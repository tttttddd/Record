import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../record/jh_picker_tool.dart';
import 'package:date_format/date_format.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easyrecord/db/db_helper.dart';
import 'package:easyrecord/models/bill_model.dart';

class EditTransferPage extends StatefulWidget {
  final Item item;

  EditTransferPage(Item item) : item = item;

  @override
  State<StatefulWidget> createState() {
    return _EditTransferPageState(item);
  }
}

class _EditTransferPageState extends State<EditTransferPage> {
  final Item item;

  _EditTransferPageState(this.item);
  var theInputType;
  var theOutputType;
  var theMember;
  var theTime;
  var _cost;
  List accounts = List();
  List members = List();
  var dbHelper = Dbhelper();

  @override
  void initState() {
    super.initState();

    theTime = DateTime.fromMillisecondsSinceEpoch(item.createTimeStamp);
    _cost = new TextEditingController.fromValue(
        TextEditingValue(text: item.cost.toString()));
    theInputType = item.inAccount;
    theOutputType = item.outAccount;
    theMember = item.member;

    dbHelp.getAccountCategory().then((list) {
      print(list.length);
      for (int i = 0; i < list.length; i++) {
        Map map = list[i];
        if (!accounts.contains(map["account"])) accounts.add(map["account"]);
      }
    });
    dbHelp.getMemberCategory().then((list) {
      print(list.length);
      for (int i = 0; i < list.length; i++) {
        Map map = list[i];
        if (!members.contains(map["member"])) members.add(map["member"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                    icon: Icon(Icons.payment),
                    // labelText: '????????????',
                    border: UnderlineInputBorder(),
                    filled: false),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 40.0,
                  // fontFamily:
                ),
                controller: _cost,
              ),
            ),
            SizedBox(
                height: 375.0, //????????????
                width: 350.0,
                child: new Card(
                    elevation: 15.0, //????????????
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(14.0))), //????????????
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: ListTile(
                            leading: Icon(
                              Icons.input,
                              size: 32.0,
                              color: Colors.blue[500],
                            ),
                            title: Text(theInputType),
                            subtitle: Text("????????????"),
                            onTap: () {
                              JhPickerTool.showStringPicker(context,
                                  data: accounts, normalIndex: 0, title: "?????????????????????",
                                  clickCallBack: (int index, var str) {
                                    print(index);
                                    setState(() {
                                      this.theOutputType = str;
                                    });
                                  });
                            },
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: ListTile(
                            leading: Icon(
                              Icons.arrow_back,
                              size: 32.0,
                              color: Colors.blue[500],
                            ),
                            title: Text(theOutputType),
                            subtitle: Text("????????????"),
                            onTap: () {
                              JhPickerTool.showStringPicker(context,
                                  data: accounts, normalIndex: 0, title: "?????????????????????",
                                  clickCallBack: (int index, var str) {
                                    print(index);
                                    setState(() {
                                      this.theInputType = str;
                                    });
                                  });
                            },
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: ListTile(
                            leading: Icon(
                              Icons.people,
                              size: 32.0,
                              color: Colors.blue[500],
                            ),
                            title: Text(theMember),
                            subtitle: Text("????????????"),
                            onTap: () {
                              JhPickerTool.showStringPicker(context,
                                  data: members, title: "???????????????", normalIndex: 0,
                                  clickCallBack: (var index, var str) {
                                    print(index);
                                    setState(() {
                                      this.theMember = str;
                                    });
                                  });
                            },
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: ListTile(
                            leading: Icon(
                              Icons.timelapse,
                              size: 32.0,
                              color: Colors.blue[500],
                            ),
                            title: Text(
                                formatDate(theTime, [yyyy, "???", mm, "???", d, "???"])),
                            subtitle: Text("????????????"),
                            onTap: () {
                              JhPickerTool.showDatePicker(context,
//            dateType: DateType.YMD,
//            dateType: DateType.YM,
//            dateType: DateType.YMD_HM,
//            dateType: DateType.YMD_AP_HM,
                                  title: "???????????????",
//            minValue: DateTime(2020,10,10),
//            maxValue: DateTime(2023,10,10),
//            value: DateTime(2020,10,10),
                                  clickCallback: (var str, var time) {
                                    setState(() {
                                      this.theTime = DateTime(
                                          int.parse(str.split("-")[0]),
                                          int.parse(str.split("-")[1]),
                                          int.parse(str.split("-")[2]));
                                    });
                                    print(time);
                                  });
                            },
                          ),
                        ),
                      ],
                    ))),
            SizedBox(
              height: 10.0,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        flex: 3,
                        // width: 200,
                        // height: 40,
                        child: new Card(
                          color: Colors.blue,
                          elevation: 15.0, //????????????
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(14.0))), //????????????
                          child: MaterialButton(
                            child: Text("??????"),
                            onPressed: () {
                              try {
                                num.parse(_cost.text);
                              } catch (e) {
                                Fluttertoast.showToast(
                                    msg: "????????????????????????",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.blue[400],
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                return;
                              }
                              if (_cost.text == "") {
                                Fluttertoast.showToast(
                                    msg: "????????????????????????",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.blue[300],
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                return;
                              }
                              // print(num.parse(_cost.text));
                              // print(theType);
                              // print(theMainType);
                              // print(theSubType);
                              // print(theMember);
                              // print(theTime.millisecondsSinceEpoch);
                              Item item = Item(
                                  id: null, //?????? ???????????????id??????null??? ?????????id?????????????????????????????????id?????????
                                  cost: num.parse(_cost.text),
                                  type: 3,
                                  mainType: "???",
                                  subType: "???",
                                  account: "???",
                                  inAccount: theInputType,
                                  outAccount: theOutputType,
                                  member: theMember,
                                  createTimeStamp: theTime.millisecondsSinceEpoch);
                              dbHelp.insertItem(item).then((value) => print(value));

                              dbHelp
                                  .getAcount(startTime: 0, endTime: 1701125919708)
                                  .then((value) {
                                print(value.length);
                                for (int i = 0; i < value.length; i++) {
                                  Item tmp = Item.fromMap(value[i]);
                                  print(tmp.id);
                                  print(tmp.cost);
                                  print(tmp.createTimeStamp);
                                }
                              });
                              Navigator.pop(context);
                            },

                            textColor: Colors.white,
                          ),
                        )

                    ),
                    Spacer(flex: 1,),
                    Expanded(
                        flex: 3,
                        child: new Card(
                          elevation: 15.0, //????????????
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(14.0))),
                          // child: Container(
                          // padding: EdgeInsets.only(left: 20),
                          // width: 200,
                          // height: 40,
                          color: Colors.red,
                          child: MaterialButton(
                            textColor: Colors.white,
                            child: Text('??????'),
                            onPressed: () {
                              setState(() {
                                dbHelper.deleteAccount(item.id);
                              });
                              Navigator.pop(context);
                            },
                          ),
                          // ),
                        )
                    )
                  ],
                )),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, "/RecordSetting");
              },
            )
          ],
        ));
  }
}

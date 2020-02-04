import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String formatedTime;
  String flag;
  String url;
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      Response res = await get('http://worldtimeapi.org/api/timezone/' + url);
      Map data = jsonDecode(res.body);

      //Offset
      DateTime dt = DateTime.parse(data['datetime']);
      int offset = int.parse(data['utc_offset'].substring(0, 3));

      // Offset değeri ekleniyorP
      dt = dt.add(Duration(hours: offset));
      isDayTime = (dt.hour > 6 && dt.hour < 18) ? true : false;

      time = DateFormat.Hm().format(dt);
    } catch (e) {
      time = 'Veri çekilirken hata';
    }
  }
}

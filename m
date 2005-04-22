From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: [patch] fixup GECOS handling
Date: Fri, 22 Apr 2005 16:23:15 +0200
Message-ID: <1114179795.29271.18.camel@nosferatu.lan>
References: <1113820589.16288.5.camel@nosferatu.lan>
	 <1113827713.5286.13.camel@localhost.localdomain>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-z/ZikGmLtiy4MChR9OcE"
Content-Transfer-Encoding: 8bit
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 16:17:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOyw3-0005Wt-Cg
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 16:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVDVOTg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 10:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVDVOTf
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 10:19:35 -0400
Received: from ctb-mesg7.saix.net ([196.25.240.79]:9160 "EHLO
	ctb-mesg7.saix.net") by vger.kernel.org with ESMTP id S261894AbVDVOTW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 10:19:22 -0400
Received: from gateway.lan (wblv-146-254-56.telkomadsl.co.za [165.146.254.56])
	by ctb-mesg7.saix.net (Postfix) with ESMTP id 548311C27;
	Fri, 22 Apr 2005 16:19:17 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 80BBC3A2430;
	Fri, 22 Apr 2005 16:25:38 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02881-05; Fri, 22 Apr 2005 16:25:32 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id E241D3A241A;
	Fri, 22 Apr 2005 16:25:31 +0200 (SAST)
To: GIT Mailing Lists <git@vger.kernel.org>
In-Reply-To: <1113827713.5286.13.camel@localhost.localdomain>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-z/ZikGmLtiy4MChR9OcE
Content-Type: multipart/mixed; boundary="=-Q9XAB/OzRkB0e5wYbuWR"


--=-Q9XAB/OzRkB0e5wYbuWR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

This still applies - any reason for not doing this?


Thanks,

----

The GECOS is delimited by ',' or ';', so we should only use whatever is
before the first ',' or ';' for the full name, rather than just
stripping those.

Signed-off-by: Martin Schlemmer <azarah@gentoo.org>

commit-tree.c: ec53a4565ec0033aaf6df2a48d233ccf4823e8b0
--- 1/commit-tree.c
+++ 2/commit-tree.c     2005-04-18 12:22:18.000000000 +0200
@@ -96,21 +96,6 @@
                if (!c)
                        break;
        }
-
-       /*
-        * Go back, and remove crud from the end: some people
-        * have commas etc in their gecos field
-        */
-       dst--;
-       while (--dst >=3D p) {
-               unsigned char c =3D *dst;
-               switch (c) {
-               case ',': case ';': case '.':
-                       *dst =3D 0;
-                       continue;
-               }
-               break;
-       }
 }

 static const char *month_names[] =3D {
@@ -313,6 +298,11 @@
        if (!pw)
                die("You don't exist. Go away!");
        realgecos =3D pw->pw_gecos;
+       /* The name is seperated from the room no., tel no, etc via [,;] */
+       if (strchr(realgecos, ','))
+               *strchr(realgecos, ',') =3D 0;
+       else if (strchr(realgecos, ';'))
+               *strchr(realgecos, ';') =3D 0;
        len =3D strlen(pw->pw_name);
        memcpy(realemail, pw->pw_name, len);
        realemail[len] =3D '@';



--=20
Martin Schlemmer


--=-Q9XAB/OzRkB0e5wYbuWR
Content-Disposition: attachment; filename=git-gecos.patch
Content-Type: text/x-patch; name=git-gecos.patch; charset=UTF-8
Content-Transfer-Encoding: base64

Y29tbWl0LXRyZWUuYzogZWM1M2E0NTY1ZWMwMDMzYWFmNmRmMmE0OGQyMzNjY2Y0ODIzZThiMA0K
LS0tIDEvY29tbWl0LXRyZWUuYw0KKysrIDIvY29tbWl0LXRyZWUuYwkyMDA1LTA0LTE4IDEyOjIy
OjE4LjAwMDAwMDAwMCArMDIwMA0KQEAgLTk2LDIxICs5Niw2IEBADQogCQlpZiAoIWMpDQogCQkJ
YnJlYWs7DQogCX0NCi0NCi0JLyoNCi0JICogR28gYmFjaywgYW5kIHJlbW92ZSBjcnVkIGZyb20g
dGhlIGVuZDogc29tZSBwZW9wbGUNCi0JICogaGF2ZSBjb21tYXMgZXRjIGluIHRoZWlyIGdlY29z
IGZpZWxkDQotCSAqLw0KLQlkc3QtLTsNCi0Jd2hpbGUgKC0tZHN0ID49IHApIHsNCi0JCXVuc2ln
bmVkIGNoYXIgYyA9ICpkc3Q7DQotCQlzd2l0Y2ggKGMpIHsNCi0JCWNhc2UgJywnOiBjYXNlICc7
JzogY2FzZSAnLic6DQotCQkJKmRzdCA9IDA7DQotCQkJY29udGludWU7DQotCQl9DQotCQlicmVh
azsNCi0JfQ0KIH0NCiANCiBzdGF0aWMgY29uc3QgY2hhciAqbW9udGhfbmFtZXNbXSA9IHsNCkBA
IC0zMTMsNiArMjk4LDExIEBADQogCWlmICghcHcpDQogCQlkaWUoIllvdSBkb24ndCBleGlzdC4g
R28gYXdheSEiKTsNCiAJcmVhbGdlY29zID0gcHctPnB3X2dlY29zOw0KKwkvKiBUaGUgbmFtZSBp
cyBzZXBlcmF0ZWQgZnJvbSB0aGUgcm9vbSBuby4sIHRlbCBubywgZXRjIHZpYSAnLCcgb3IgJzsn
ICovDQorCWlmIChzdHJjaHIocmVhbGdlY29zLCAnLCcpKQ0KKwkJKnN0cmNocihyZWFsZ2Vjb3Ms
ICcsJykgPSAwOw0KKwllbHNlIGlmIChzdHJjaHIocmVhbGdlY29zLCAnOycpKQ0KKwkJKnN0cmNo
cihyZWFsZ2Vjb3MsICc7JykgPSAwOw0KIAlsZW4gPSBzdHJsZW4ocHctPnB3X25hbWUpOw0KIAlt
ZW1jcHkocmVhbGVtYWlsLCBwdy0+cHdfbmFtZSwgbGVuKTsNCiAJcmVhbGVtYWlsW2xlbl0gPSAn
QCc7DQo=


--=-Q9XAB/OzRkB0e5wYbuWR--

--=-z/ZikGmLtiy4MChR9OcE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCaQjTqburzKaJYLYRAny9AJ9/7gtn6un03tBXgRKOGJ/zqeY+lwCdFVR5
A0sX4W2SQuw+Y0EPoiGnlPw=
=YAeO
-----END PGP SIGNATURE-----

--=-z/ZikGmLtiy4MChR9OcE--


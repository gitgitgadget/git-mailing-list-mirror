From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: [pasky] recent changes to gitdiff.sh
Date: Mon, 18 Apr 2005 12:57:26 +0200
Message-ID: <1113821846.16288.15.camel@nosferatu.lan>
References: <1113820808.16288.9.camel@nosferatu.lan>
	 <20050418104038.GM1461@pasky.ji.cz>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FqYouWoqHUCGw3h83Wvo"
Content-Transfer-Encoding: 8bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 12:51:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNTpf-00042r-27
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 12:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVDRKyD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 06:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVDRKyD
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 06:54:03 -0400
Received: from ctb-mesg7.saix.net ([196.25.240.79]:49383 "EHLO
	ctb-mesg7.saix.net") by vger.kernel.org with ESMTP id S262027AbVDRKxl
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 06:53:41 -0400
Received: from gateway.lan (wblv-146-244-27.telkomadsl.co.za [165.146.244.27])
	by ctb-mesg7.saix.net (Postfix) with ESMTP id 0BAD5B274;
	Mon, 18 Apr 2005 12:53:38 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id D03F13A26DB;
	Mon, 18 Apr 2005 12:59:50 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19808-06; Mon, 18 Apr 2005 12:59:40 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 441363A26DA;
	Mon, 18 Apr 2005 12:59:40 +0200 (SAST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050418104038.GM1461@pasky.ji.cz>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-FqYouWoqHUCGw3h83Wvo
Content-Type: multipart/mixed; boundary="=-lSxuTszV9czvu+0A8/jc"


--=-lSxuTszV9czvu+0A8/jc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-04-18 at 12:40 +0200, Petr Baudis wrote:
> Dear diary, on Mon, Apr 18, 2005 at 12:40:08PM CEST, I got a letter
> where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > Hi,
>=20
> Hello,
>=20
> > I see the recent changes to gitdiff.sh requires you to pass -r (git dif=
f
> > -r local:$tracking) even if you separate the branches via ':'.  Is this
> > intended (seems like it)?
>=20
> yes. This brings the usage style in sync with the rest of the world. :-)
>=20
> > If so, then gittrack.sh, gitpull.sh and gitmerge.sh needs to be
> > updated ...
>=20
> I hopes I updated all the places. If I missed anything, please say what.
>=20

Update calls to gitdiff.sh to include the '-r' switch.

Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>

gitmerge.sh: 7ea441e584d603463fb1b83991b88f63a3895cff
--- 1/gitmerge.sh
+++ 2/gitmerge.sh       2005-04-18 12:55:34.000000000 +0200
@@ -67,7 +67,7 @@
 fi
 update-cache --refresh

-gitdiff.sh "$base":"$branch" | gitapply.sh
+gitdiff.sh -r "$base":"$branch" | gitapply.sh

 cat >&2 <<__END__
 Please inspect the merge in the ,,merge/ subdirectory. Commit from that
gitpull.sh: 9bda6555a1dafc1db762bc46db60d2a9485dc523
--- 1/gitpull.sh
+++ 2/gitpull.sh        2005-04-18 12:55:34.000000000 +0200
@@ -73,7 +73,7 @@
                gitmerge.sh -b "$orig_head" "$new_head"

        else
-               gitdiff.sh "$orig_head":"$new_head" | gitapply.sh
+               gitdiff.sh -r "$orig_head":"$new_head" | gitapply.sh
                read-tree $(tree-id $new_head)

                echo $new_head >.git/HEAD
gittrack.sh: 30654380c10edde32def8e5fa2e2c956fbff3d58
--- 1/gittrack.sh
+++ 2/gittrack.sh       2005-04-18 12:55:34.000000000 +0200
@@ -50,7 +50,7 @@
        echo $name >.git/tracking

        read-tree $(tree-id "$name")
-       gitdiff.sh local:"$name" | gitapply.sh
+       gitdiff.sh -r local:"$name" | gitapply.sh
        update-cache --refresh

 else
@@ -60,7 +60,7 @@
                die "tracked \"$tracking\" branch missing!"

        if [ -s ".git/HEAD.local" ]; then
-               gitdiff.sh "$tracking":local | gitapply.sh
+               gitdiff.sh -r "$tracking":local | gitapply.sh
                read-tree $(tree-id local)
                update-cache --refresh



--=20
Martin Schlemmer


--=-lSxuTszV9czvu+0A8/jc
Content-Disposition: attachment; filename=git-diff_sh-updates.patch
Content-Type: text/x-patch; name=git-diff_sh-updates.patch; charset=UTF-8
Content-Transfer-Encoding: base64

Z2l0bWVyZ2Uuc2g6IDdlYTQ0MWU1ODRkNjAzNDYzZmIxYjgzOTkxYjg4ZjYzYTM4OTVjZmYNCi0t
LSAxL2dpdG1lcmdlLnNoDQorKysgMi9naXRtZXJnZS5zaAkyMDA1LTA0LTE4IDEyOjU1OjM0LjAw
MDAwMDAwMCArMDIwMA0KQEAgLTY3LDcgKzY3LDcgQEANCiBmaQ0KIHVwZGF0ZS1jYWNoZSAtLXJl
ZnJlc2gNCiANCi1naXRkaWZmLnNoICIkYmFzZSI6IiRicmFuY2giIHwgZ2l0YXBwbHkuc2gNCitn
aXRkaWZmLnNoIC1yICIkYmFzZSI6IiRicmFuY2giIHwgZ2l0YXBwbHkuc2gNCiANCiBjYXQgPiYy
IDw8X19FTkRfXw0KIFBsZWFzZSBpbnNwZWN0IHRoZSBtZXJnZSBpbiB0aGUgLCxtZXJnZS8gc3Vi
ZGlyZWN0b3J5LiBDb21taXQgZnJvbSB0aGF0DQpnaXRwdWxsLnNoOiA5YmRhNjU1NWExZGFmYzFk
Yjc2MmJjNDZkYjYwZDJhOTQ4NWRjNTIzDQotLS0gMS9naXRwdWxsLnNoDQorKysgMi9naXRwdWxs
LnNoCTIwMDUtMDQtMTggMTI6NTU6MzQuMDAwMDAwMDAwICswMjAwDQpAQCAtNzMsNyArNzMsNyBA
QA0KIAkJZ2l0bWVyZ2Uuc2ggLWIgIiRvcmlnX2hlYWQiICIkbmV3X2hlYWQiDQogDQogCWVsc2UN
Ci0JCWdpdGRpZmYuc2ggIiRvcmlnX2hlYWQiOiIkbmV3X2hlYWQiIHwgZ2l0YXBwbHkuc2gNCisJ
CWdpdGRpZmYuc2ggLXIgIiRvcmlnX2hlYWQiOiIkbmV3X2hlYWQiIHwgZ2l0YXBwbHkuc2gNCiAJ
CXJlYWQtdHJlZSAkKHRyZWUtaWQgJG5ld19oZWFkKQ0KIA0KIAkJZWNobyAkbmV3X2hlYWQgPi5n
aXQvSEVBRA0KZ2l0dHJhY2suc2g6IDMwNjU0MzgwYzEwZWRkZTMyZGVmOGU1ZmEyZTJjOTU2ZmJm
ZjNkNTgNCi0tLSAxL2dpdHRyYWNrLnNoDQorKysgMi9naXR0cmFjay5zaAkyMDA1LTA0LTE4IDEy
OjU1OjM0LjAwMDAwMDAwMCArMDIwMA0KQEAgLTUwLDcgKzUwLDcgQEANCiAJZWNobyAkbmFtZSA+
LmdpdC90cmFja2luZw0KIA0KIAlyZWFkLXRyZWUgJCh0cmVlLWlkICIkbmFtZSIpDQotCWdpdGRp
ZmYuc2ggbG9jYWw6IiRuYW1lIiB8IGdpdGFwcGx5LnNoDQorCWdpdGRpZmYuc2ggLXIgbG9jYWw6
IiRuYW1lIiB8IGdpdGFwcGx5LnNoDQogCXVwZGF0ZS1jYWNoZSAtLXJlZnJlc2gNCiANCiBlbHNl
DQpAQCAtNjAsNyArNjAsNyBAQA0KIAkJZGllICJ0cmFja2VkIFwiJHRyYWNraW5nXCIgYnJhbmNo
IG1pc3NpbmchIg0KIA0KIAlpZiBbIC1zICIuZ2l0L0hFQUQubG9jYWwiIF07IHRoZW4NCi0JCWdp
dGRpZmYuc2ggIiR0cmFja2luZyI6bG9jYWwgfCBnaXRhcHBseS5zaA0KKwkJZ2l0ZGlmZi5zaCAt
ciAiJHRyYWNraW5nIjpsb2NhbCB8IGdpdGFwcGx5LnNoDQogCQlyZWFkLXRyZWUgJCh0cmVlLWlk
IGxvY2FsKQ0KIAkJdXBkYXRlLWNhY2hlIC0tcmVmcmVzaA0KIA0K


--=-lSxuTszV9czvu+0A8/jc--

--=-FqYouWoqHUCGw3h83Wvo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCY5KWqburzKaJYLYRAvr9AJ9njt3w/FZ1BAE4amWZnaPfFIzN6gCggQpl
1lYLxCG5eH1RwZiJYz0k3hY=
=kt/e
-----END PGP SIGNATURE-----

--=-FqYouWoqHUCGw3h83Wvo--


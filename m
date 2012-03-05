From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass under Mac OSX
Date: Mon, 5 Mar 2012 20:39:15 +0100
Message-ID: <201203052039.16893.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org, avarab@gmail.com
X-From: git-owner@vger.kernel.org Mon Mar 05 20:39:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4dl9-0004KG-CN
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 20:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757528Ab2CETjq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 14:39:46 -0500
Received: from fmmailgate06.web.de ([217.72.192.247]:56868 "EHLO
	fmmailgate06.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757522Ab2CETjp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 14:39:45 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate06.web.de (Postfix) with ESMTP id 1BF33DCBC32
	for <git@vger.kernel.org>; Mon,  5 Mar 2012 20:39:21 +0100 (CET)
Received: from maxi.localnet ([194.22.188.61]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0MLP5m-1S5BiU3QJO-000HjU; Mon, 05 Mar 2012 20:39:20 +0100
X-Provags-ID: V02:K0:uEMfg/btFeipKVNaD02LgGfJVBvOkEVr3rpOUVqicg4
 w+AKigCsCH4j3FniEmJyL0JjNzL8mWGuUW53MPENUY2Bz9RxaJ
 o2yaVWOJRyexmzUOvN5/Be98iX7w74VyHHrTJa2jW4lrWNcvpX
 h8WmiQ79gORVCOBXkptUMdMFYcIrK9sZSUL/xgBqdam5n0a20u
 uPQja+9++mLjUyObGv46A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192266>

t0204 tries to use a ISO-8859-1 locale and expects that characters
outside the ISO-8859-1 code range are converted in "question marks".

The gettext under Mac OS X ignores the ISO-8859-1 locale and uses
UTF-8 anyway.

=46ixed even whitespace in this very test case.

Let the test pass when UTF-8 is returned.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 This is a suggestion to make t0204--gettext-reencode-sanity.sh to pass=
 under Mac OSX
 The tests checks if unicode characters outside ISO-8859-1 are converte=
d into '?'.
 The Mac OS X version of gettext does not seem to support ISO-8859-1 at=
 all.
 Even if we set the locale to ISO-8859-1, UTF-8 is used anyway.


 t/t0204-gettext-reencode-sanity.sh |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/t/t0204-gettext-reencode-sanity.sh b/t/t0204-gettext-reenc=
ode-sanity.sh
index 189af90..78f0889 100755
--- a/t/t0204-gettext-reencode-sanity.sh
+++ b/t/t0204-gettext-reencode-sanity.sh
@@ -27,16 +27,22 @@ test_expect_success GETTEXT_ISO_LOCALE 'gettext: Em=
itting ISO-8859-1 from our UT
 '
=20
 test_expect_success GETTEXT_ISO_LOCALE 'gettext: Emitting ISO-8859-1 f=
rom our UTF-8 *.mo files / Runes' '
-    LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" gettext "TEST: Old Engl=
ish Runes" >runes &&
+	LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" gettext "TEST: Old English=
 Runes" >runes &&
=20
 	if grep "^TEST: Old English Runes$" runes
 	then
 		say "Your system can not handle this complexity and returns the stri=
ng as-is"
 	else
-		# Both Solaris and GNU libintl will return this stream of
-		# question marks, so it is s probably portable enough
-		printf "TILRAUN: ?? ???? ??? ?? ???? ?? ??? ????? ??????????? ??? ??=
 ????" >runes-expect &&
-		test_cmp runes-expect runes
+		if grep "^TILRAUN: =E1=9A=BB=E1=9B=96 =E1=9A=B3=E1=9A=B9=E1=9A=AB=E1=
=9A=A6 =E1=9A=A6=E1=9A=AB=E1=9B=8F =E1=9A=BB=E1=9B=96 =E1=9B=92=E1=9A=A2=
=E1=9B=9E=E1=9B=96 =E1=9A=A9=E1=9A=BE =E1=9A=A6=E1=9A=AB=E1=9B=97 =E1=9B=
=9A=E1=9A=AA=E1=9A=BE=E1=9B=9E=E1=9B=96 =E1=9A=BE=E1=9A=A9=E1=9A=B1=E1=9A=
=A6=E1=9A=B9=E1=9B=96=E1=9A=AA=E1=9A=B1=E1=9B=9E=E1=9A=A2=E1=9B=97 =E1=9A=
=B9=E1=9B=81=E1=9A=A6 =E1=9A=A6=E1=9A=AA =E1=9A=B9=E1=9B=96=E1=9B=A5=E1=
=9A=AB" runes
+		then
+			# Mac OS supports only UTF-8, even if we want ISO-8859-1 we get UTF=
-8
+			say "Your system handles only utf-8"
+		else
+			# Both Solaris and GNU libintl will return this stream of
+			# question marks, so it is s probably portable enough
+			printf "TILRAUN: ?? ???? ??? ?? ???? ?? ??? ????? ??????????? ??? ?=
? ????" >runes-expect &&
+			test_cmp runes-expect runes
+		fi
 	fi
 '
=20
--=20
1.7.9.rc2

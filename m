From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] lib-gettext.sh: Show GIT_INTERNAL_GETTEXT_SH_SCHEME = fallthrough
Date: Sat, 10 Mar 2012 23:37:14 +0100
Message-ID: <201203102337.16260.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, tboegi@web.de
To: avarab@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 10 23:37:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6Uuk-0000GU-LV
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 23:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab2CJWhV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Mar 2012 17:37:21 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:49131 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab2CJWhU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Mar 2012 17:37:20 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate05.web.de (Postfix) with ESMTP id C965E6B2769A
	for <git@vger.kernel.org>; Sat, 10 Mar 2012 23:37:18 +0100 (CET)
Received: from maxi.localnet ([194.22.188.61]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MDxWR-1S8zUA1X39-00HWgE; Sat, 10 Mar 2012 23:37:17 +0100
X-Provags-ID: V02:K0:kZ43ga2YxcNLoKcEtYTALmtvzEdkrPxQiczH+3BtT02
 ETLHtB3qUDAmFjj2+a7Rm1vOwnpr6HBd23vsD8wUQVoIh0Zcz+
 f10NciEzibXwYkZAYpR16EyBBG9f/49XtZIRBV+i2Vfh76MvZA
 Q5eN5/VvlFFkTSvit7lBOFinnwTAhHUljTsLQp5TJ2zPw9sazd
 rPITmb0h5+0nJ3QFyX0PA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192793>

The test cases for gettext, which are in this 3 files:
 t0204-gettext-reencode-sanity.sh
 t0200-gettext-basic.sh
 t0203-gettext-setlocale-sanity.sh

are only run when GETTEXT_LOCALE or GETTEXT_ISO_LOCALE
(depending on the test case) is set.

This variables are set up in lib-gettext.sh
The variables may not be set and the appropriate test cases are skipped
when either
 a) GIT_INTERNAL_GETTEXT_SH_SCHEME =3D fallthrough
or
 b) the needed locale is not available on the system.

Tell the user what which was the reason to skip the tests

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/lib-gettext.sh |   44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index 0f76f6c..aa401b1 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -28,28 +28,30 @@ then
 	# test can use it too
 	export is_IS_locale is_IS_iso_locale
=20
-	if test -n "$is_IS_locale" &&
-		test $GIT_INTERNAL_GETTEXT_SH_SCHEME !=3D "fallthrough"
+	if test "$GIT_INTERNAL_GETTEXT_SH_SCHEME" !=3D fallthrough
 	then
-		# Some of the tests need the reference Icelandic locale
-		test_set_prereq GETTEXT_LOCALE
-
-		# Exporting for t0202/test.pl
-		GETTEXT_LOCALE=3D1
-		export GETTEXT_LOCALE
-		say "# lib-gettext: Found '$is_IS_locale' as an is_IS UTF-8 locale"
-	else
-		say "# lib-gettext: No is_IS UTF-8 locale available"
-	fi
-
-	if test -n "$is_IS_iso_locale" &&
-		test $GIT_INTERNAL_GETTEXT_SH_SCHEME !=3D "fallthrough"
-	then
-		# Some of the tests need the reference Icelandic locale
-		test_set_prereq GETTEXT_ISO_LOCALE
-
-		say "# lib-gettext: Found '$is_IS_iso_locale' as an is_IS ISO-8859-1=
 locale"
+		if test -n "$is_IS_locale"
+		then
+			# Some of the tests need the reference Icelandic locale
+			test_set_prereq GETTEXT_LOCALE
+
+			# Exporting for t0202/test.pl
+			GETTEXT_LOCALE=3D1
+			export GETTEXT_LOCALE
+			say "# lib-gettext: Found '$is_IS_locale' as an is_IS UTF-8 locale"
+		else
+			say "# lib-gettext: No is_IS UTF-8 locale available"
+		fi
+
+		if test -n "$is_IS_iso_locale"
+		then
+			# Some of the tests need the reference Icelandic locale
+			test_set_prereq GETTEXT_ISO_LOCALE
+			say "# lib-gettext: Found '$is_IS_iso_locale' as an is_IS ISO-8859-=
1 locale"
+		else
+			say "# lib-gettext: No is_IS ISO-8859-1 locale available"
+		fi
 	else
-		say "# lib-gettext: No is_IS ISO-8859-1 locale available"
+		say "# GIT_INTERNAL_GETTEXT_SH_SCHEME =3D fallthrough"
 	fi
 fi
--=20
1.7.10.rc0.17.g74595.dirty

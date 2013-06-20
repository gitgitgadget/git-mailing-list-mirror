From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] t7400: test of UTF-8 submodule names pass under Mac OS
Date: Thu, 20 Jun 2013 16:58:48 +0200
Message-ID: <201306201658.50174.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: iveqy@iveqy.com
To: git@vger.kernel.org, tboegi@web.de
X-From: git-owner@vger.kernel.org Thu Jun 20 16:59:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpgKM-00040A-7J
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 16:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758020Ab3FTO7A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Jun 2013 10:59:00 -0400
Received: from mout.web.de ([212.227.17.11]:59523 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758017Ab3FTO67 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 10:58:59 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0M7bhn-1U3kwC3AiV-00xKUj; Thu, 20 Jun 2013 16:58:56 +0200
X-Provags-ID: V03:K0:3PcBdeoegUghvMp44rkKcdPnUmDQxvlxxUh9Ik5c7jJH7JsFkG4
 i5gcMGNXO3/SkkpAqGbGdkYWlkp6vfZL3lFTkjuhxTFY9b7Lq1qZ20FidmU82LtGJtVIYsM
 +UJiz4tpOARjntwi6ROwe3OWzuH9u9bwuhqGbLtAyzovo+Lw1cOP3F8GIbvpdGSjc6AP43u
 amZQPurwbmEu+drW0U7Ig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228508>

submodules with names using UTF-8 need core.precomposeunicode true
under Mac OS X, set it in the TC.

Improve the portability:
Not all shells on all OS may understand literal UTF-8 strings.
Use a help variable filled by printf, as we do it in e.g. t0050.

"strange names" can be called UTF-8, rephrase the heading

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
I wasn't fast enough to catch it on pu:
fg/submodule-non-ascii-path

 t/t7400-submodule-basic.sh | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 0376370..fedfa5b 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -889,16 +889,19 @@ test_expect_success 'submodule deinit fails when =
submodule has a .git directory
 	test -n "$(git config --get-regexp "submodule\.example\.")"
 '
=20
-test_expect_success 'submodule with strange name works "=C3=A5 =C3=A4=C3=
=B6"' '
-	mkdir "=C3=A5 =C3=A4=C3=B6" &&
+svname=3D$(printf '\303\245 \303\244\303\266')
+test_expect_success 'submodule with UTF-8 name' '
+	mkdir "$svname" &&
 	(
-		cd "=C3=A5 =C3=A4=C3=B6" &&
+		cd "$svname" &&
 		git init &&
 		touch sub
 		git add sub
 		git commit -m "init sub"
 	)
-	git submodule add "/=C3=A5 =C3=A4=C3=B6" &&
-	test -n "$(git submodule | grep "=C3=A5 =C3=A4=C3=B6")"
+	git config core.precomposeunicode true &&
+	git submodule add /"$svname" &&
+	git submodule >&2 &&
+	test -n "$(git submodule | grep "$svname")"
 '
 test_done
--=20
1.8.3

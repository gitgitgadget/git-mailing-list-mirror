From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 1/8] t9402: sed -i is not portable
Date: Sat, 8 Dec 2012 22:33:38 +0100
Message-ID: <201212082233.39169.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, mmogilvi_git@miniinfo.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 22:34:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThS2C-0000W9-7o
	for gcvg-git-2@plane.gmane.org; Sat, 08 Dec 2012 22:34:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758182Ab2LHVdu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Dec 2012 16:33:50 -0500
Received: from mout.web.de ([212.227.15.4]:61916 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066Ab2LHVdu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Dec 2012 16:33:50 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0LmcnP-1T7I470AYV-00ZYuJ; Sat, 08 Dec 2012 22:33:48 +0100
X-Provags-ID: V02:K0:Vy05EHAzfKgWX4+ND21gnXf+MLwNM4GbDPd32uEPN0p
 Q3HY09YnNzciUn4c+TTnfmMjLPYuqD1bi19C//3BYNmIRO0RIE
 KebP/iRzMjg0KHZcyCiUeARoO0O+ei3h+Dw0JDHtItDtInqWs7
 gtMlRFEjY9590wFlgle5tJJuYVgchWBF4vVCzxW2ajpkAUSD7g
 yZLadwH+hAMXTYhQguluQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211215>

On some systems sed allows the usage of e.g.
sed -i -e "s/line1/line2/" afile
to edit the file "in place".
Other systems don't allow that: one observed behaviour is that
sed -i -e "s/line1/line2/" afile
creates a backup file called afile-e, which breaks the test.
As sed -i is not part of POSIX, avoid it.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Changes since v2:
Split up into many small commits
The fix of sed -i is the first and most important one


 t/t9402-git-cvsserver-refs.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs=
=2Esh
index 858ef0f..c01748a 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -155,7 +155,8 @@ test_expect_success 'cvs co b1 [cvswork3]' '
=20
 test_expect_success 'edit cvswork3 and save diff' '
     ( cd cvswork3 &&
-      sed -i -e "s/line1/line1 - data/" adir/afile &&
+      sed -e "s/line1/line1 - data/" adir/afile >adir/afileNEW &&
+			mv -f adir/afileNEW adir/afile &&
       echo "afile5" > adir/afile5 &&
       rm t2 &&
       cvs -f add adir/afile5 &&
@@ -168,7 +169,8 @@ test_expect_success 'setup v1.2 on b1' '
     git checkout b1 &&
     echo "new v1.2" > t3 &&
     rm t2 &&
-    sed -i -e "s/line3/line3 - more data/" adir/afile &&
+    sed -e "s/line3/line3 - more data/" adir/afile >adir/afileNEW &&
+		mv -f adir/afileNEW adir/afile &&
     rm adir/a2file &&
     echo "a3file" >> adir/a3file &&
     echo "bfile line 3" >> adir/bdir/bfile &&
@@ -300,7 +302,8 @@ test_expect_success 'root dir rm file [cvswork2]' '
=20
 test_expect_success 'subdir edit/add/rm files [cvswork2' '
     ( cd cvswork2 &&
-      sed -i -e "s/line 1/line 1 (v2)/" adir/bdir/bfile &&
+      sed -e "s/line 1/line 1 (v2)/" adir/bdir/bfile >adir/bdir/bfileN=
EW &&
+      mv -f adir/bdir/bfileNEW adir/bdir/bfile &&
       rm adir/bdir/b2file &&
       cd adir &&
       cvs -f rm bdir/b2file &&
--=20
1.8.0.197.g5a90748

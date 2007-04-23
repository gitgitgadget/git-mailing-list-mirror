From: "Ron Parker" <ron.parker@mobot.org>
Subject: [PATCH] Fix tests when using bash_completion
Date: Mon, 23 Apr 2007 15:51:29 -0500
Message-ID: <769697AE3E25EF4FBC0763CD91AB1B0201D496D0@MBGMail01.mobot.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 23 23:06:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg5jh-0006Pv-VH
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 23:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211AbXDWVFz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 17:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754198AbXDWVFz
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 17:05:55 -0400
Received: from mbgmail01.mobot.org ([63.78.97.14]:55608 "EHLO
	mbgmail01.mobot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670AbXDWVFk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2007 17:05:40 -0400
X-Greylist: delayed 851 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Apr 2007 17:05:40 EDT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Fix tests when using bash_completion
Thread-Index: AceF6Sq8oCNOi3PsQ/+t8U3Ci/vyYw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45362>

When using bash_completion, 'cd' echos the target directory name to
standard
out.  If 'cd' participates in a pipe whose output is compared against an
expected value, this causes a false failure report.  Pipe cd's stdout to
/dev/null in these cases.

Signed-off-by: Ron Parker <ron.parker@mobot.org>
---

	I was going to look into some of the preliminary subproject
	support, since I have a need for it.  But a bunch of the tests
	failed because I run the bash_completion package.

	I don't think I've sent any patches for git before.  Please be
	gentle.  If there is a problem with this patch or the way I've
	sent it, I'll gladly redo it.

 t/t3040-subprojects-basic.sh |    2 +-
 t/t5000-tar-tree.sh          |   10 +++++-----
 t/t5500-fetch-pack.sh        |    8 ++++----
 t/t5502-quickfetch.sh        |    8 ++++----
 t/t7002-grep.sh              |    4 ++--
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/t/t3040-subprojects-basic.sh b/t/t3040-subprojects-basic.sh
index 79b9f23..9543921 100755
--- a/t/t3040-subprojects-basic.sh
+++ b/t/t3040-subprojects-basic.sh
@@ -61,7 +61,7 @@ test_expect_success 'check if git diff works for
subproject elements' \
 test_expect_success 'check if clone works' \
     'git ls-files -s >expected &&
     git clone -l -s . cloned &&
-    ( cd cloned && git ls-files -s ) >current &&
+    ( cd cloned >/dev/null && git ls-files -s ) >current &&
     git diff expected current'
 
 test_expect_success 'removing and adding subproject' \
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index e223c07..a6654a3 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -38,7 +38,7 @@ test_expect_success \
      (p=long_path_to_a_file && cd a &&
       for depth in 1 2 3 4 5; do mkdir $p && cd $p; done &&
       echo text >file_with_long_path) &&
-     (cd a && find .) | sort >a.lst'
+     (cd a >/dev/null && find .) | sort >a.lst'
 
 test_expect_success \
     'add files to repository' \
@@ -80,7 +80,7 @@ test_expect_success \
 
 test_expect_success \
     'validate filenames' \
-    '(cd b/a && find .) | sort >b.lst &&
+    '(cd b/a >/dev/null && find .) | sort >b.lst &&
      diff a.lst b.lst'
 
 test_expect_success \
@@ -97,7 +97,7 @@ test_expect_success \
 
 test_expect_success \
     'validate filenames with prefix' \
-    '(cd c/prefix/a && find .) | sort >c.lst &&
+    '(cd c/prefix/a >/dev/null && find .) | sort >c.lst &&
      diff a.lst c.lst'
 
 test_expect_success \
@@ -114,7 +114,7 @@ test_expect_success \
 
 test_expect_success \
     'validate filenames' \
-    '(cd d/a && find .) | sort >d.lst &&
+    '(cd d/a >/dev/null && find .) | sort >d.lst &&
      diff a.lst d.lst'
 
 test_expect_success \
@@ -131,7 +131,7 @@ test_expect_success \
 
 test_expect_success \
     'validate filenames with prefix' \
-    '(cd e/prefix/a && find .) | sort >e.lst &&
+    '(cd e/prefix/a >/dev/null && find .) | sort >e.lst &&
      diff a.lst e.lst'
 
 test_expect_success \
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 48e3d17..d8ed508 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -131,7 +131,7 @@ pull_to_client 3rd "A" $((1*3)) # old fails
 
 test_expect_success "clone shallow" "git-clone --depth 2 . shallow"
 
-(cd shallow; git-count-objects -v) > count.shallow
+(cd shallow >/dev/null; git-count-objects -v) > count.shallow
 
 test_expect_success "clone shallow object count" \
 	"test \"in-pack: 18\" = \"$(grep in-pack count.shallow)\""
@@ -155,7 +155,7 @@ add B67 $B66
 test_expect_success "pull in shallow repo" \
 	"(cd shallow; git pull .. B)"
 
-(cd shallow; git-count-objects -v) > count.shallow
+(cd shallow >/dev/null; git-count-objects -v) > count.shallow
 test_expect_success "clone shallow object count" \
 	"test \"count: 6\" = \"$(grep count count.shallow)\""
 
@@ -165,14 +165,14 @@ add B69 $B68
 test_expect_success "deepening pull in shallow repo" \
 	"(cd shallow; git pull --depth 4 .. B)"
 
-(cd shallow; git-count-objects -v) > count.shallow
+(cd shallow >/dev/null; git-count-objects -v) > count.shallow
 test_expect_success "clone shallow object count" \
 	"test \"count: 12\" = \"$(grep count count.shallow)\""
 
 test_expect_success "deepening fetch in shallow repo" \
 	"(cd shallow; git fetch --depth 4 .. A:A)"
 
-(cd shallow; git-count-objects -v) > count.shallow
+(cd shallow >/dev/null; git-count-objects -v) > count.shallow
 test_expect_success "clone shallow object count" \
 	"test \"count: 18\" = \"$(grep count count.shallow)\""
 
diff --git a/t/t5502-quickfetch.sh b/t/t5502-quickfetch.sh
index b4760f2..b33e414 100755
--- a/t/t5502-quickfetch.sh
+++ b/t/t5502-quickfetch.sh
@@ -26,7 +26,7 @@ test_expect_success 'clone without alternate' '
 		git remote add -f origin ..
 	) &&
 	cnt=$( (
-		cd cloned &&
+		cd cloned >/dev/null &&
 		git count-objects | sed -e "s/ *objects,.*//"
 	) ) &&
 	test $cnt -eq 3
@@ -54,7 +54,7 @@ test_expect_success 'copy commit and tree but not blob
by hand' '
 	) &&
 
 	cnt=$( (
-		cd cloned &&
+		cd cloned >/dev/null &&
 		git count-objects | sed -e "s/ *objects,.*//"
 	) ) &&
 	test $cnt -eq 6
@@ -64,7 +64,7 @@ test_expect_success 'copy commit and tree but not blob
by hand' '
 	rm -f "cloned/.git/objects/$blob" &&
 
 	cnt=$( (
-		cd cloned &&
+		cd cloned >/dev/null &&
 		git count-objects | sed -e "s/ *objects,.*//"
 	) ) &&
 	test $cnt -eq 5
@@ -79,7 +79,7 @@ test_expect_success 'quickfetch should not leave a
corrupted repository' '
 	) &&
 
 	cnt=$( (
-		cd cloned &&
+		cd cloned >/dev/null &&
 		git count-objects | sed -e "s/ *objects,.*//"
 	) ) &&
 	test $cnt -eq 6
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index 6bfb899..5d2fc4a 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -92,7 +92,7 @@ do
 	test_expect_success "grep $L (t-2)" '
 		echo "${HC}t:1:test" >expected &&
 		(
-			cd t &&
+			cd t >/dev/null &&
 			git grep -n -e test $H
 		) >actual &&
 		diff expected actual
@@ -101,7 +101,7 @@ do
 	test_expect_success "grep $L (t-3)" '
 		echo "${HC}t/t:1:test" >expected &&
 		(
-			cd t &&
+			cd t >/dev/null &&
 			git grep --full-name -n -e test $H
 		) >actual &&
 		diff expected actual
-- 
1.5.2.rc0.1.g2cc31

From: Jonathon Mah <me@JonathonMah.com>
Subject: [PATCH 1/2] mergetool: Add tests for filename with whitespace
Date: Tue, 21 Jun 2011 19:40:23 -0700
Message-ID: <734F376D-0CF5-4417-8DC2-8A46AA05D995@JonathonMah.com>
Mime-Version: 1.0 (Apple Message framework v1242)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Charles Bailey <charles@hashpling.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 22 04:40:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZDMr-0005GI-0K
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 04:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757874Ab1FVCka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 22:40:30 -0400
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:44663 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757816Ab1FVCka convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 22:40:30 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlszAP1UAU5i6vJRPGdsb2JhbAAMSIkRngQBAQEBN8hRhisEhyOabw
Received: from c-98-234-242-81.hsd1.ca.comcast.net (HELO [192.168.120.10]) ([98.234.242.81])
  by ipmail06.adl2.internode.on.net with ESMTP; 22 Jun 2011 12:10:26 +0930
X-Mailer: Apple Mail (2.1242)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176215>

Signed-off-by: Jonathon Mah <me@JonathonMah.com>
---
 t/t7610-mergetool.sh |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index cbc08e3..f00caa3 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -16,6 +16,7 @@ Testing basic merge tool invocation'
 test_expect_success 'setup' '
     git config rerere.enabled true &&
     echo master >file1 &&
+    echo master spaced >"spaced name" &&
     echo master file11 >file11 &&
     echo master file12 >file12 &&
     echo master file13 >file13 &&
@@ -30,13 +31,14 @@ test_expect_success 'setup' '
 	git commit -m "Add foo"
     ) &&
     git submodule add git://example.com/submod submod &&
-    git add file1 file1[1-4] subdir/file3 .gitmodules submod &&
+    git add file1 "spaced name" file1[1-4] subdir/file3 .gitmodules submod &&
     git commit -m "add initial versions" &&
 
     git checkout -b branch1 master &&
     git submodule update -N &&
     echo branch1 change >file1 &&
     echo branch1 newfile >file2 &&
+    echo branch1 spaced >"spaced name" &&
     echo branch1 change file11 >file11 &&
     echo branch1 change file13 >file13 &&
     echo branch1 sub >subdir/file3 &&
@@ -47,7 +49,7 @@ test_expect_success 'setup' '
 	git commit -m "Add bar on branch1" &&
 	git checkout -b submod-branch1
     ) &&
-    git add file1 file11 file13 file2 subdir/file3 submod &&
+    git add file1 "spaced name" file11 file13 file2 subdir/file3 submod &&
     git rm file12 &&
     git commit -m "branch1 changes" &&
 
@@ -55,6 +57,7 @@ test_expect_success 'setup' '
     git submodule update -N &&
     echo master updated >file1 &&
     echo master new >file2 &&
+    echo master updated spaced >"spaced name" &&
     echo master updated file12 >file12 &&
     echo master updated file14 >file14 &&
     echo master new sub >subdir/file3 &&
@@ -65,7 +68,7 @@ test_expect_success 'setup' '
 	git commit -m "Add bar on master" &&
 	git checkout -b submod-master
     ) &&
-    git add file1 file12 file14 file2 subdir/file3 submod &&
+    git add file1 "spaced name" file12 file14 file2 subdir/file3 submod &&
     git rm file11 &&
     git commit -m "master updates" &&
 
@@ -79,7 +82,7 @@ test_expect_success 'custom mergetool' '
     git submodule update -N &&
     test_must_fail git merge master >/dev/null 2>&1 &&
     ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
-    ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file2 "spaced name" >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
@@ -97,6 +100,7 @@ test_expect_success 'mergetool crlf' '
     test_must_fail git merge master >/dev/null 2>&1 &&
     ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool "spaced name" >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
@@ -126,7 +130,7 @@ test_expect_success 'mergetool on file in parent dir' '
     (
 	cd subdir &&
 	( yes "" | git mergetool ../file1 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool ../file2 >/dev/null 2>&1 ) &&
+	( yes "" | git mergetool ../file2 ../spaced\ name >/dev/null 2>&1 ) &&
 	( yes "d" | git mergetool ../file11 >/dev/null 2>&1 ) &&
 	( yes "d" | git mergetool ../file12 >/dev/null 2>&1 ) &&
 	( yes "l" | git mergetool ../submod >/dev/null 2>&1 ) &&
@@ -189,7 +193,7 @@ test_expect_success 'deleted vs modified submodule' '
     git checkout -b test6.a test6 &&
     test_must_fail git merge master &&
     test -n "$(git ls-files -u)" &&
-    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "r" | git mergetool submod ) &&
     rmdir submod && mv submod-movedaside submod &&
@@ -205,7 +209,7 @@ test_expect_success 'deleted vs modified submodule' '
     git submodule update -N &&
     test_must_fail git merge master &&
     test -n "$(git ls-files -u)" &&
-    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "l" | git mergetool submod ) &&
     test ! -e submod &&
@@ -218,7 +222,7 @@ test_expect_success 'deleted vs modified submodule' '
     git submodule update -N &&
     test_must_fail git merge test6 &&
     test -n "$(git ls-files -u)" &&
-    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "r" | git mergetool submod ) &&
     test ! -e submod &&
@@ -233,7 +237,7 @@ test_expect_success 'deleted vs modified submodule' '
     git submodule update -N &&
     test_must_fail git merge test6 &&
     test -n "$(git ls-files -u)" &&
-    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "l" | git mergetool submod ) &&
     test "$(cat submod/bar)" = "master submodule" &&
@@ -256,7 +260,7 @@ test_expect_success 'file vs modified submodule' '
     git checkout -b test7.a branch1 &&
     test_must_fail git merge master &&
     test -n "$(git ls-files -u)" &&
-    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "r" | git mergetool submod ) &&
     rmdir submod && mv submod-movedaside submod &&
@@ -271,7 +275,7 @@ test_expect_success 'file vs modified submodule' '
     git checkout -b test7.b test7 &&
     test_must_fail git merge master &&
     test -n "$(git ls-files -u)" &&
-    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "l" | git mergetool submod ) &&
     git submodule update -N &&
@@ -286,7 +290,7 @@ test_expect_success 'file vs modified submodule' '
     git submodule update -N &&
     test_must_fail git merge test7 &&
     test -n "$(git ls-files -u)" &&
-    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "r" | git mergetool submod ) &&
     test -d submod.orig &&
@@ -301,7 +305,7 @@ test_expect_success 'file vs modified submodule' '
     git submodule update -N &&
     test_must_fail git merge test7 &&
     test -n "$(git ls-files -u)" &&
-    ( yes "" | git mergetool file1 file2 subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
     ( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
     ( yes "l" | git mergetool submod ) &&
     test "$(cat submod/bar)" = "master submodule" &&
-- 
1.7.4.4

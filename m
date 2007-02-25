From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 7/8] convert users of "cmp -s" to "git diff"
Date: Sun, 25 Feb 2007 23:37:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702252337010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Feb 25 23:51:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLSCw-0001yE-PH
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 23:51:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbXBYWvE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 17:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbXBYWvD
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 17:51:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:45893 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750991AbXBYWvB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 17:51:01 -0500
Received: (qmail invoked by alias); 25 Feb 2007 22:37:14 -0000
X-Provags-ID: V01U2FsdGVkX1+ArdlRwUeAsS/82QKWetomkYS6vcjGsNrGboFIS8
	IxBQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40591>


This is really just

$ perl -pi.bak -e "s/(^\s*|'|&&\s*)cmp -s /\1git diff /" *.sh

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	We should probably add a "--quiet" flag for the diff family
	first, and use that...

 t/t0000-basic.sh      |    4 ++--
 t/t4002-diff-basic.sh |   26 +++++++++++++-------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 186de70..743ee03 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -37,7 +37,7 @@ fi
 find .git/objects -type f -print >should-be-empty
 test_expect_success \
     '.git/objects should be empty after git-init in an empty repo.' \
-    'cmp -s /dev/null should-be-empty' 
+    'git diff /dev/null should-be-empty' 
 
 # also it should have 2 subdirectories; no fan-out anymore, pack, and info.
 # 3 is counting "objects" itself
@@ -242,7 +242,7 @@ test_expect_success \
 
 test_expect_success \
     'no diff after checkout and git-update-index --refresh.' \
-    'git-diff-files >current && cmp -s current /dev/null'
+    'git-diff-files >current && git diff current /dev/null'
 
 ################################################################
 P=087704a96baf1c2d1c869a8b084481e121c88b5b
diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index 56eda63..50e9922 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -141,50 +141,50 @@ cmp_diff_files_output () {
 test_expect_success \
     'diff-tree of known trees.' \
     'git-diff-tree $tree_O $tree_A >.test-a &&
-     cmp -s .test-a .test-plain-OA'
+     git diff .test-a .test-plain-OA'
 
 test_expect_success \
     'diff-tree of known trees.' \
     'git-diff-tree -r $tree_O $tree_A >.test-a &&
-     cmp -s .test-a .test-recursive-OA'
+     git diff .test-a .test-recursive-OA'
 
 test_expect_success \
     'diff-tree of known trees.' \
     'git-diff-tree $tree_O $tree_B >.test-a &&
-     cmp -s .test-a .test-plain-OB'
+     git diff .test-a .test-plain-OB'
 
 test_expect_success \
     'diff-tree of known trees.' \
     'git-diff-tree -r $tree_O $tree_B >.test-a &&
-     cmp -s .test-a .test-recursive-OB'
+     git diff .test-a .test-recursive-OB'
 
 test_expect_success \
     'diff-tree of known trees.' \
     'git-diff-tree $tree_A $tree_B >.test-a &&
-     cmp -s .test-a .test-plain-AB'
+     git diff .test-a .test-plain-AB'
 
 test_expect_success \
     'diff-tree of known trees.' \
     'git-diff-tree -r $tree_A $tree_B >.test-a &&
-     cmp -s .test-a .test-recursive-AB'
+     git diff .test-a .test-recursive-AB'
 
 test_expect_success \
     'diff-cache O with A in cache' \
     'git-read-tree $tree_A &&
      git-diff-index --cached $tree_O >.test-a &&
-     cmp -s .test-a .test-recursive-OA'
+     git diff .test-a .test-recursive-OA'
 
 test_expect_success \
     'diff-cache O with B in cache' \
     'git-read-tree $tree_B &&
      git-diff-index --cached $tree_O >.test-a &&
-     cmp -s .test-a .test-recursive-OB'
+     git diff .test-a .test-recursive-OB'
 
 test_expect_success \
     'diff-cache A with B in cache' \
     'git-read-tree $tree_B &&
      git-diff-index --cached $tree_A >.test-a &&
-     cmp -s .test-a .test-recursive-AB'
+     git diff .test-a .test-recursive-AB'
 
 test_expect_success \
     'diff-files with O in cache and A checked out' \
@@ -224,24 +224,24 @@ test_expect_success \
     'diff-tree O A == diff-tree -R A O' \
     'git-diff-tree $tree_O $tree_A >.test-a &&
     git-diff-tree -R $tree_A $tree_O >.test-b &&
-    cmp -s .test-a .test-b'
+    git diff .test-a .test-b'
 
 test_expect_success \
     'diff-tree -r O A == diff-tree -r -R A O' \
     'git-diff-tree -r $tree_O $tree_A >.test-a &&
     git-diff-tree -r -R $tree_A $tree_O >.test-b &&
-    cmp -s .test-a .test-b'
+    git diff .test-a .test-b'
 
 test_expect_success \
     'diff-tree B A == diff-tree -R A B' \
     'git-diff-tree $tree_B $tree_A >.test-a &&
     git-diff-tree -R $tree_A $tree_B >.test-b &&
-    cmp -s .test-a .test-b'
+    git diff .test-a .test-b'
 
 test_expect_success \
     'diff-tree -r B A == diff-tree -r -R A B' \
     'git-diff-tree -r $tree_B $tree_A >.test-a &&
     git-diff-tree -r -R $tree_A $tree_B >.test-b &&
-    cmp -s .test-a .test-b'
+    git diff .test-a .test-b'
 
 test_done
-- 
1.5.0.1.788.g8ca52

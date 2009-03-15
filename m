From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Tests: use test_cmp instead of diff where possible
Date: Sun, 15 Mar 2009 14:33:56 +0100
Message-ID: <1237124036-1348-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 14:34:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiqUC-0006X1-UN
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 14:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbZCONdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 09:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbZCONdL
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 09:33:11 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:44913 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbZCONdK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 09:33:10 -0400
Received: from vmobile.example.net (dsl5401CFBD.pool.t-online.hu [84.1.207.189])
	by yugo.frugalware.org (Postfix) with ESMTPA id 6A85A446CF6;
	Sun, 15 Mar 2009 14:33:06 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id DF0F9186220; Sun, 15 Mar 2009 14:33:56 +0100 (CET)
X-Mailer: git-send-email 1.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113288>

Several old tests were written before test_cmp was introduced, convert
these to test_cmp.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

I intentionally did not touch t5000 - using test_cmp -r works for me,
since the default is diff -u, but that would break the setup of users
where GIT_TEST_CMP is set to cmp.

 t/t0000-basic.sh                    |    8 ++++----
 t/t1100-commit-tree-options.sh      |    2 +-
 t/t1400-update-ref.sh               |    6 +++---
 t/t3000-ls-files-others.sh          |    4 ++--
 t/t3010-ls-files-killed-modified.sh |    4 ++--
 t/t5000-tar-tree.sh                 |    2 +-
 t/t9001-send-email.sh               |    2 +-
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 70df15c..4837300 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -127,7 +127,7 @@ cat >expected <<\EOF
 EOF
 test_expect_success \
     'validate git ls-files output for a known tree.' \
-    'diff current expected'
+    'test_cmp current expected'
 
 test_expect_success \
     'writing tree out with git write-tree.' \
@@ -147,7 +147,7 @@ cat >expected <<\EOF
 EOF
 test_expect_success \
     'git ls-tree output for a known tree.' \
-    'diff current expected'
+    'test_cmp current expected'
 
 # This changed in ls-tree pathspec change -- recursive does
 # not show tree nodes anymore.
@@ -166,7 +166,7 @@ cat >expected <<\EOF
 EOF
 test_expect_success \
     'git ls-tree -r output for a known tree.' \
-    'diff current expected'
+    'test_cmp current expected'
 
 # But with -r -t we can have both.
 test_expect_success \
@@ -187,7 +187,7 @@ cat >expected <<\EOF
 EOF
 test_expect_success \
     'git ls-tree -r output for a known tree.' \
-    'diff current expected'
+    'test_cmp current expected'
 
 test_expect_success \
     'writing partial tree out with git write-tree --prefix.' \
diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-options.sh
index 7f7fc36..c4414ff 100755
--- a/t/t1100-commit-tree-options.sh
+++ b/t/t1100-commit-tree-options.sh
@@ -40,6 +40,6 @@ test_expect_success \
 
 test_expect_success \
     'compare commit' \
-    'diff expected commit'
+    'test_cmp expected commit'
 
 test_done
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index bd58926..54ba3df 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -137,7 +137,7 @@ $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000
 EOF
 test_expect_success \
 	"verifying $m's log" \
-	"diff expect .git/logs/$m"
+	"test_cmp expect .git/logs/$m"
 rm -rf .git/$m .git/logs expect
 
 test_expect_success \
@@ -168,7 +168,7 @@ $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000
 EOF
 test_expect_success \
 	"verifying $m's log" \
-	'diff expect .git/logs/$m'
+	'test_cmp expect .git/logs/$m'
 rm -f .git/$m .git/logs/$m expect
 
 git update-ref $m $D
@@ -272,7 +272,7 @@ $h_FIXED $h_MERGED $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117151100 +0000	c
 EOF
 test_expect_success \
 	'git commit logged updates' \
-	"diff expect .git/logs/$m"
+	"test_cmp expect .git/logs/$m"
 unset h_TEST h_OTHER h_FIXED h_MERGED
 
 test_expect_success \
diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index bc0a351..304dd02 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -42,7 +42,7 @@ test_expect_success \
 
 test_expect_success \
     'git ls-files --others should pick up symlinks.' \
-    'diff output expected1'
+    'test_cmp output expected1'
 
 test_expect_success \
     'git ls-files --others --directory to show output.' \
@@ -51,6 +51,6 @@ test_expect_success \
 
 test_expect_success \
     'git ls-files --others --directory should not get confused.' \
-    'diff output expected2'
+    'test_cmp output expected2'
 
 test_done
diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
index ec14040..4f5375e 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -75,7 +75,7 @@ EOF
 
 test_expect_success \
     'validate git ls-files -k output.' \
-    'diff .output .expected'
+    'test_cmp .output .expected'
 
 test_expect_success \
     'git ls-files -m to show modified files.' \
@@ -91,6 +91,6 @@ EOF
 
 test_expect_success \
     'validate git ls-files -m output.' \
-    'diff .output .expected'
+    'test_cmp .output .expected'
 
 test_done
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index b7e3628..bfd593c 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -76,7 +76,7 @@ test_expect_success \
 
 test_expect_success \
     'git archive vs. git tar-tree' \
-    'diff b.tar b2.tar'
+    'test_cmp b.tar b2.tar'
 
 test_expect_success \
     'git archive in a bare repo' \
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 08d5b91..4fcc2e1 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -88,7 +88,7 @@ cat >expected <<\EOF
 EOF
 test_expect_success \
     'Verify commandline' \
-    'diff commandline1 expected'
+    'test_cmp commandline1 expected'
 
 cat >expected-show-all-headers <<\EOF
 0001-Second.patch
-- 
1.6.2

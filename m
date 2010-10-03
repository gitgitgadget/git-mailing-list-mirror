From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v4 4/4] Add testcases for the --hide-dir-rename-details diffcore flag.
Date: Sun,  3 Oct 2010 22:42:09 +0200
Message-ID: <1286138529-6780-5-git-send-email-ydirson@altern.org>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
 <1286138529-6780-2-git-send-email-ydirson@altern.org>
 <1286138529-6780-3-git-send-email-ydirson@altern.org>
 <1286138529-6780-4-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 22:32:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2VEg-000189-HC
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 22:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032Ab0JCUcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 16:32:31 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:32866 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754766Ab0JCUca (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 16:32:30 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id BA73ED480F3;
	Sun,  3 Oct 2010 22:32:23 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P2VNu-0001qZ-A7; Sun, 03 Oct 2010 22:42:14 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286138529-6780-4-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157920>

From: Yann Dirson <ydirson@free.fr>

---
 t/t4046-diff-rename-factorize.sh |  107 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 107 insertions(+), 0 deletions(-)

diff --git a/t/t4046-diff-rename-factorize.sh b/t/t4046-diff-rename-factorize.sh
index 51b0b0b..d982658 100755
--- a/t/t4046-diff-rename-factorize.sh
+++ b/t/t4046-diff-rename-factorize.sh
@@ -69,6 +69,18 @@ test_expect_success \
     'validate the output for directory move.' \
     'compare_diff_patch expected current.filtered'
 
+test_expect_success \
+    'git diff-index --hide-dir-rename-details after directory move.' \
+    'git diff-index --hide-dir-rename-details HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/	b/
+EOF
+
+test_expect_success \
+    'validate the output for directory move.' \
+    'compare_diff_patch expected current.filtered'
+
 # now test non-100% renames
 
 echo 'Line 16' >> b/path0
@@ -96,6 +108,22 @@ test_expect_success \
     'validate the output for directory move and content changes.' \
     'compare_diff_patch expected current.filtered'
 
+test_expect_success \
+    'git diff-index --hide-dir-rename-details after directory move and content changes.' \
+    'git diff-index --hide-dir-rename-details HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/	b/
+:100644 000000 c6971ab9f08a6cd9c89a0f87d94ae347aad6144a 0000000000000000000000000000000000000000 D	a/path3
+:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/path2	b/2path
+:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 4db595d12886f90e36765fc1732c17bccb836663 R093	a/path0	b/path0
+:000000 100644 0000000000000000000000000000000000000000 1ba4650885513e62386fd3e23aeb45beeb67d3bb A	b/path100
+EOF
+
+test_expect_success \
+    'validate the output for directory move and content changes.' \
+    'compare_diff_patch expected current.filtered'
+
 git reset -q --hard
 
 # now test bulk moves that are not directory moves (get consensus before going further ?)
@@ -130,6 +158,18 @@ test_expect_failure \
     'validate the output for bulk rename without full-dir rename.' \
     'compare_diff_patch expected current.filtered'
 
+test_expect_success \
+    'git diff-index --hide-dir-rename-details without full-dir rename.' \
+    'git diff-index --hide-dir-rename-details HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	c/*	a/
+EOF
+
+test_expect_failure \
+    'validate the output for bulk rename without full-dir rename.' \
+    'compare_diff_patch expected current.filtered'
+
 git reset -q --hard
 
 # now test moves to toplevel
@@ -154,6 +194,18 @@ test_expect_failure \
     'validate the output for files bulk-moved to toplevel.' \
     'compare_diff_patch expected current.filtered'
 
+test_expect_success \
+    'git diff-index --hide-dir-rename-details files bulk-moved to toplevel.' \
+    'git diff-index --hide-dir-rename-details HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	c/*	./
+EOF
+
+test_expect_failure \
+    'validate the output for files bulk-moved to toplevel.' \
+    'compare_diff_patch expected current.filtered'
+
 git reset -q --hard
 
 # now test renaming with subdirs (does not take subdirs into account)
@@ -192,6 +244,19 @@ test_expect_failure \
     'validate the output for a move including a subdir.' \
     'compare_diff_patch expected current.filtered'
 
+test_expect_success \
+    'git diff-index --hide-dir-rename-details on a move including a subdir.' \
+    'git diff-index --hide-dir-rename-details HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/	b/
+:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 00084e5ea68b5ae339b7c4b429e4a70fe25d069b R096	a/c/apath0	b/c/apath0
+EOF
+
+test_expect_failure \
+    'validate the output for a move including a subdir.' \
+    'compare_diff_patch expected current.filtered'
+
 git reset -q --hard
 
 # now check that moving all files but not subdirs is not mistaken for dir move
@@ -217,6 +282,8 @@ test_expect_success \
     'validate the output for a move without a subdir.' \
     'compare_diff_patch expected current.filtered'
 
+# no need to test for --hide-dir-rename-details here
+
 git reset -q --hard
 
 # now check that moving subdirs into one dir and files into another is not mistaken for dir move
@@ -247,6 +314,22 @@ test_expect_failure \
     'validate the output for a split of subdir and files into different places.' \
     'compare_diff_patch expected current.filtered'
 
+test_expect_success \
+    'git diff-index --hide-dir-rename-details on a split of subdir and files into different places.' \
+    'git diff-index --hide-dir-rename-details HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/c/	b/
+:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	a/path0	d/path0
+:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/path1	d/path1
+:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/path2	d/path2
+:100644 100644 c6971ab9f08a6cd9c89a0f87d94ae347aad6144a c6971ab9f08a6cd9c89a0f87d94ae347aad6144a R100	a/path3	d/path3
+EOF
+
+test_expect_failure \
+    'validate the output for a split of subdir and files into different places.' \
+    'compare_diff_patch expected current.filtered'
+
 # now test moving a dir with no files but only subdirs
 # (only factorizes lowest-level directories - not a big deal, just not perfect)
 
@@ -285,6 +368,18 @@ test_expect_failure \
     'validate the output for a move with only subdirs.' \
     'compare_diff_patch expected current.filtered'
 
+test_expect_success \
+    'git diff-index --hide-dir-rename-details with only subdirs' \
+    'git diff-index --hide-dir-rename-details HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/	z/
+EOF
+
+test_expect_failure \
+    'validate the output for a move with only subdirs.' \
+    'compare_diff_patch expected current.filtered'
+
 # now test moving all files from toplevel into subdir (does not hides file moves) (needs consensus on syntax)
 # Note: this is a special case of move of a dir into one of its own subdirs, which in
 # turn is a variant of new files/dirs being added into a dir after all its contents
@@ -323,4 +418,16 @@ test_expect_failure \
     'validate the output for a move of everything from toplevel.' \
     'compare_diff_patch expected current.filtered'
 
+test_expect_success \
+    'git diff-index --hide-dir-rename-details everything from toplevel.' \
+    'git diff-index --hide-dir-rename-details HEAD >current'
+grep -v "^\[DBG\] " <current >current.filtered
+cat >expected <<\EOF
+:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	./*	z/
+EOF
+
+test_expect_failure \
+    'validate the output for a move of everything from toplevel.' \
+    'compare_diff_patch expected current.filtered'
+
 test_done
-- 
1.7.2.3

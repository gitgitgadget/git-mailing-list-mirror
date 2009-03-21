From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 12/16] Skip tests that require a filesystem that obeys POSIX permissions
Date: Sat, 21 Mar 2009 22:26:35 +0100
Message-ID: <3dc085c7ad60932b21595dab3d6b1f062eb570d5.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 22:30:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll8li-0004Ii-G2
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 22:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410AbZCUV1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 17:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755403AbZCUV12
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 17:27:28 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27951 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248AbZCUV07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 17:26:59 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 49DAD10020;
	Sat, 21 Mar 2009 22:26:56 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id B5F0F1D235;
	Sat, 21 Mar 2009 22:26:55 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114071>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t0004-unwritable.sh      |    8 ++++----
 t/t1301-shared-repo.sh     |   10 +++++-----
 t/t3700-add.sh             |    8 ++++----
 t/t7503-pre-commit-hook.sh |    4 ++--
 t/t7504-commit-msg-hook.sh |    8 ++++----
 t/test-lib.sh              |    4 ++++
 6 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
index 63e1217..2342ac5 100755
--- a/t/t0004-unwritable.sh
+++ b/t/t0004-unwritable.sh
@@ -15,7 +15,7 @@ test_expect_success setup '
 
 '
 
-test_expect_success 'write-tree should notice unwritable repository' '
+test_expect_success POSIXPERM 'write-tree should notice unwritable repository' '
 
 	(
 		chmod a-w .git/objects .git/objects/?? &&
@@ -27,7 +27,7 @@ test_expect_success 'write-tree should notice unwritable repository' '
 
 '
 
-test_expect_success 'commit should notice unwritable repository' '
+test_expect_success POSIXPERM 'commit should notice unwritable repository' '
 
 	(
 		chmod a-w .git/objects .git/objects/?? &&
@@ -39,7 +39,7 @@ test_expect_success 'commit should notice unwritable repository' '
 
 '
 
-test_expect_success 'update-index should notice unwritable repository' '
+test_expect_success POSIXPERM 'update-index should notice unwritable repository' '
 
 	(
 		echo 6O >file &&
@@ -52,7 +52,7 @@ test_expect_success 'update-index should notice unwritable repository' '
 
 '
 
-test_expect_success 'add should notice unwritable repository' '
+test_expect_success POSIXPERM 'add should notice unwritable repository' '
 
 	(
 		echo b >file &&
diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 653362b..dc44854 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -26,7 +26,7 @@ modebits () {
 
 for u in 002 022
 do
-	test_expect_success "shared=1 does not clear bits preset by umask $u" '
+	test_expect_success POSIXPERM "shared=1 does not clear bits preset by umask $u" '
 		mkdir sub && (
 			cd sub &&
 			umask $u &&
@@ -54,7 +54,7 @@ test_expect_success 'shared=all' '
 	test 2 = $(git config core.sharedrepository)
 '
 
-test_expect_success 'update-server-info honors core.sharedRepository' '
+test_expect_success POSIXPERM 'update-server-info honors core.sharedRepository' '
 	: > a1 &&
 	git add a1 &&
 	test_tick &&
@@ -85,7 +85,7 @@ do
 	git config core.sharedrepository "$u" &&
 	umask 0277 &&
 
-	test_expect_success "shared = $u ($y) ro" '
+	test_expect_success POSIXPERM "shared = $u ($y) ro" '
 
 		rm -f .git/info/refs &&
 		git update-server-info &&
@@ -97,7 +97,7 @@ do
 	'
 
 	umask 077 &&
-	test_expect_success "shared = $u ($x) rw" '
+	test_expect_success POSIXPERM "shared = $u ($x) rw" '
 
 		rm -f .git/info/refs &&
 		git update-server-info &&
@@ -111,7 +111,7 @@ do
 
 done
 
-test_expect_success 'git reflog expire honors core.sharedRepository' '
+test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
 	git config core.sharedRepository group &&
 	git reflog expire --all &&
 	actual="$(ls -l .git/logs/refs/heads/master)" &&
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index e98f982..dc17d9f 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -179,7 +179,7 @@ test_expect_success 'git add --refresh' '
 	test -z "`git diff-index HEAD -- foo`"
 '
 
-test_expect_success 'git add should fail atomically upon an unreadable file' '
+test_expect_success POSIXPERM 'git add should fail atomically upon an unreadable file' '
 	git reset --hard &&
 	date >foo1 &&
 	date >foo2 &&
@@ -190,7 +190,7 @@ test_expect_success 'git add should fail atomically upon an unreadable file' '
 
 rm -f foo2
 
-test_expect_success 'git add --ignore-errors' '
+test_expect_success POSIXPERM 'git add --ignore-errors' '
 	git reset --hard &&
 	date >foo1 &&
 	date >foo2 &&
@@ -201,7 +201,7 @@ test_expect_success 'git add --ignore-errors' '
 
 rm -f foo2
 
-test_expect_success 'git add (add.ignore-errors)' '
+test_expect_success POSIXPERM 'git add (add.ignore-errors)' '
 	git config add.ignore-errors 1 &&
 	git reset --hard &&
 	date >foo1 &&
@@ -212,7 +212,7 @@ test_expect_success 'git add (add.ignore-errors)' '
 '
 rm -f foo2
 
-test_expect_success 'git add (add.ignore-errors = false)' '
+test_expect_success POSIXPERM 'git add (add.ignore-errors = false)' '
 	git config add.ignore-errors 0 &&
 	git reset --hard &&
 	date >foo1 &&
diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
index b069095..8528f64 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-hook.sh
@@ -69,7 +69,7 @@ test_expect_success '--no-verify with failing hook' '
 '
 
 chmod -x "$HOOK"
-test_expect_success 'with non-executable hook' '
+test_expect_success POSIXPERM 'with non-executable hook' '
 
 	echo "content" >> file &&
 	git add file &&
@@ -77,7 +77,7 @@ test_expect_success 'with non-executable hook' '
 
 '
 
-test_expect_success '--no-verify with non-executable hook' '
+test_expect_success POSIXPERM '--no-verify with non-executable hook' '
 
 	echo "more content" >> file &&
 	git add file &&
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 47680e6..1f53ea8 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -136,7 +136,7 @@ test_expect_success '--no-verify with failing hook (editor)' '
 '
 
 chmod -x "$HOOK"
-test_expect_success 'with non-executable hook' '
+test_expect_success POSIXPERM 'with non-executable hook' '
 
 	echo "content" >> file &&
 	git add file &&
@@ -144,7 +144,7 @@ test_expect_success 'with non-executable hook' '
 
 '
 
-test_expect_success 'with non-executable hook (editor)' '
+test_expect_success POSIXPERM 'with non-executable hook (editor)' '
 
 	echo "content again" >> file &&
 	git add file &&
@@ -153,7 +153,7 @@ test_expect_success 'with non-executable hook (editor)' '
 
 '
 
-test_expect_success '--no-verify with non-executable hook' '
+test_expect_success POSIXPERM '--no-verify with non-executable hook' '
 
 	echo "more content" >> file &&
 	git add file &&
@@ -161,7 +161,7 @@ test_expect_success '--no-verify with non-executable hook' '
 
 '
 
-test_expect_success '--no-verify with non-executable hook (editor)' '
+test_expect_success POSIXPERM '--no-verify with non-executable hook (editor)' '
 
 	echo "even more content" >> file &&
 	git add file &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5337e89..f134e73 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -687,6 +687,10 @@ case $(uname -s) in
 	pwd () {
 		builtin pwd -W
 	}
+	# no POSIX permissions
+	;;
+*)
+	test_set_prereq POSIXPERM
 	;;
 esac
 
-- 
1.6.2.1.224.g2225f

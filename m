From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/6] test: fix '&&' chaining
Date: Thu,  8 Dec 2011 18:40:17 +0530
Message-ID: <1323349817-15737-9-git-send-email-artagnon@gmail.com>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 14:12:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYdlU-0004UC-CD
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 14:11:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461Ab1LHNLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 08:11:50 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52142 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454Ab1LHNLs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 08:11:48 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so2573483iak.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 05:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=C9LDOqmBh/hM7r8oDc13kn5X/SdPiRbx/ReXY2Jjbv8=;
        b=PeUe4WVwohvUOtZFOoCTVWxvBwbtD3AoriB5pWR0MJBl1Zgx5MGM5z20rLHy3pPX2h
         40rE/aN152mgg+zH1EgaATc+NtrrjXsF4bIKdXGDM7gdoLdaIiQ9qnbecMGUTmNuuLm0
         K7urzH1zMi3KvkyY3TR+wm9fnYjklrhmg7dC4=
Received: by 10.42.157.137 with SMTP id d9mr3460724icx.31.1323349908460;
        Thu, 08 Dec 2011 05:11:48 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id dd36sm19583344ibb.7.2011.12.08.05.11.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 05:11:47 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186559>

Breaks in a test assertion's && chain can potentially hide failures
from earlier commands in the chain.  Fix instances of this in the
following tests:

t3419 (rebase-patch-id)
t3310 (notes-merge-manual-resolve)
t3400 (rebase)
t3418 (rebase-continue)
t1511 (rev-parse-caret)
t1510 (repo-setup)
t1007 (hash-object)
t1412 (reflog-loop)
t1300 (repo-config)
t1013 (loose-object-format)

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t1007-hash-object.sh                |    2 +-
 t/t1013-loose-object-format.sh        |    2 +-
 t/t1300-repo-config.sh                |    2 +-
 t/t1412-reflog-loop.sh                |    2 +-
 t/t1510-repo-setup.sh                 |    4 ++--
 t/t1511-rev-parse-caret.sh            |    2 +-
 t/t3310-notes-merge-manual-resolve.sh |   10 +++++-----
 t/t3400-rebase.sh                     |    4 ++--
 t/t3418-rebase-continue.sh            |    4 ++--
 t/t3419-rebase-patch-id.sh            |    2 +-
 10 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 6d52b82..f83df8e 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -189,7 +189,7 @@ for args in "-w --stdin-paths" "--stdin-paths -w"; do
 done
 
 test_expect_success 'corrupt tree' '
-	echo abc >malformed-tree
+	echo abc >malformed-tree &&
 	test_must_fail git hash-object -t tree malformed-tree
 '
 
diff --git a/t/t1013-loose-object-format.sh b/t/t1013-loose-object-format.sh
index 0a9cedd..fbf5f2f 100755
--- a/t/t1013-loose-object-format.sh
+++ b/t/t1013-loose-object-format.sh
@@ -34,7 +34,7 @@ assert_blob_equals() {
 }
 
 test_expect_success setup '
-	cp -R "$TEST_DIRECTORY/t1013/objects" .git/
+	cp -R "$TEST_DIRECTORY/t1013/objects" .git/ &&
 	git --version
 '
 
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 51caff0..0690e0e 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -38,7 +38,7 @@ cat > expect << EOF
 	WhatEver = Second
 EOF
 test_expect_success 'similar section' '
-	git config Cores.WhatEver Second
+	git config Cores.WhatEver Second &&
 	test_cmp expect .git/config
 '
 
diff --git a/t/t1412-reflog-loop.sh b/t/t1412-reflog-loop.sh
index 647d888..3acd895 100755
--- a/t/t1412-reflog-loop.sh
+++ b/t/t1412-reflog-loop.sh
@@ -20,7 +20,7 @@ test_expect_success 'setup reflog with alternating commits' '
 '
 
 test_expect_success 'reflog shows all entries' '
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 		topic@{0} reset: moving to two
 		topic@{1} reset: moving to one
 		topic@{2} reset: moving to two
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index ec50a9a..80aedfc 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -603,7 +603,7 @@ test_expect_success '#22a: core.worktree = GIT_DIR = .git dir' '
 	# like case #6.
 
 	setup_repo 22a "$here/22a/.git" "" unset &&
-	setup_repo 22ab . "" unset
+	setup_repo 22ab . "" unset &&
 	mkdir -p 22a/.git/sub 22a/sub &&
 	mkdir -p 22ab/.git/sub 22ab/sub &&
 	try_case 22a/.git unset . \
@@ -742,7 +742,7 @@ test_expect_success '#28: core.worktree and core.bare conflict (gitfile case)' '
 # Case #29: GIT_WORK_TREE(+core.worktree) overrides core.bare (gitfile case).
 test_expect_success '#29: setup' '
 	setup_repo 29 non-existent gitfile true &&
-	mkdir -p 29/sub/sub 29/wt/sub
+	mkdir -p 29/sub/sub 29/wt/sub &&
 	(
 		cd 29 &&
 		GIT_WORK_TREE="$here/29" &&
diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
index e043cb7..eaefc77 100755
--- a/t/t1511-rev-parse-caret.sh
+++ b/t/t1511-rev-parse-caret.sh
@@ -6,7 +6,7 @@ test_description='tests for ref^{stuff}'
 
 test_expect_success 'setup' '
 	echo blob >a-blob &&
-	git tag -a -m blob blob-tag `git hash-object -w a-blob`
+	git tag -a -m blob blob-tag `git hash-object -w a-blob` &&
 	mkdir a-tree &&
 	echo moreblobs >a-tree/another-blob &&
 	git add . &&
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 4ec4d11..4367197 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -389,7 +389,7 @@ test_expect_success 'abort notes merge' '
 	test_must_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
 	test_cmp /dev/null output &&
 	# m has not moved (still == y)
-	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)"
+	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)" &&
 	# Verify that other notes refs has not changed (w, x, y and z)
 	verify_notes w &&
 	verify_notes x &&
@@ -525,9 +525,9 @@ EOF
 	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha3 &&
 	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha4 &&
 	# Refs are unchanged
-	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)"
-	test "$(git rev-parse refs/notes/y)" = "$(git rev-parse NOTES_MERGE_PARTIAL^1)"
-	test "$(git rev-parse refs/notes/m)" != "$(git rev-parse NOTES_MERGE_PARTIAL^1)"
+	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)" &&
+	test "$(git rev-parse refs/notes/y)" = "$(git rev-parse NOTES_MERGE_PARTIAL^1)" &&
+	test "$(git rev-parse refs/notes/m)" != "$(git rev-parse NOTES_MERGE_PARTIAL^1)" &&
 	# Mention refs/notes/m, and its current and expected value in output
 	grep -q "refs/notes/m" output &&
 	grep -q "$(git rev-parse refs/notes/m)" output &&
@@ -545,7 +545,7 @@ test_expect_success 'resolve situation by aborting the notes merge' '
 	test_must_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
 	test_cmp /dev/null output &&
 	# m has not moved (still == w)
-	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)"
+	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)" &&
 	# Verify that other notes refs has not changed (w, x, y and z)
 	verify_notes w &&
 	verify_notes x &&
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 6eaecec..c355533 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -172,8 +172,8 @@ test_expect_success 'fail when upstream arg is missing and not configured' '
 
 test_expect_success 'default to @{upstream} when upstream arg is missing' '
 	git checkout -b default topic &&
-	git config branch.default.remote .
-	git config branch.default.merge refs/heads/master
+	git config branch.default.remote . &&
+	git config branch.default.merge refs/heads/master &&
 	git rebase &&
 	test "$(git rev-parse default~1)" = "$(git rev-parse master)"
 '
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 1e855cd..2680375 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -51,7 +51,7 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
 	test_commit "commit-new-file-F3-on-topic-branch" F3 32 &&
 	test_when_finished "rm -fr test-bin funny.was.run" &&
 	mkdir test-bin &&
-	cat >test-bin/git-merge-funny <<-EOF
+	cat >test-bin/git-merge-funny <<-EOF &&
 	#!$SHELL_PATH
 	case "\$1" in --opt) ;; *) exit 2 ;; esac
 	shift &&
@@ -77,7 +77,7 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
 test_expect_success 'rebase --continue remembers --rerere-autoupdate' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F3-on-topic-branch &&
-	git checkout master
+	git checkout master &&
 	test_commit "commit-new-file-F3" F3 3 &&
 	git config rerere.enabled true &&
 	test_must_fail git rebase -m master topic &&
diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index bd8efaf..e70ac10 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -39,7 +39,7 @@ run()
 }
 
 test_expect_success 'setup' '
-	git commit --allow-empty -m initial
+	git commit --allow-empty -m initial &&
 	git tag root
 '
 
-- 
1.7.7.3

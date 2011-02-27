From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 3/3] git-add: rename -u to -a
Date: Sun, 27 Feb 2011 16:50:12 +0100
Message-ID: <711e34a5f4761ccd1056a992df21e3389db7add7.1298821535.git.git@drmicha.warpmail.net>
References: <4D68D630.9000608@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 27 16:49:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtisI-0004ft-KI
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 16:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277Ab1B0PtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 10:49:22 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55668 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752232Ab1B0PtM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Feb 2011 10:49:12 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 782CF206BB;
	Sun, 27 Feb 2011 10:49:11 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sun, 27 Feb 2011 10:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=uU/qmTRNQFj5BxpEOEFP2aZtyuc=; b=aVZxE/aSPvBZcv6jkCA/YisdwsWCgqT1UqQgq9ujmY5RmSmD4HerTLhmQccPl74l4SV5jKctTz2ou5Mba4ZFuvpOp6yR1lp0jYYzfmtjBWEULRLjypDf7YxG1tkHkOK4nwuuDK+PIBKD5bwSKGG2qlW7AFC4zRFqlYldiK+PvSk=
X-Sasl-enc: KGLF7+ePbbKK/E1abv13tF7hJJri+siCmFvevipAhTEV 1298821749
Received: from localhost (p5485925B.dip0.t-ipconnect.de [84.133.146.91])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D23EE448DAB;
	Sun, 27 Feb 2011 10:49:09 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.224.gefc87
In-Reply-To: <4D68D630.9000608@drmicha.warpmail.net>
In-Reply-To: <cover.1298821535.git.git@drmicha.warpmail.net>
References: <cover.1298821535.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168040>

since it does what "commit -a" does (minus the committing). The long
form "--all-tracked" is also more descriptive because "add" always updates the
index (independent of "-u"), but not always for all tracked files.

Keep "-u,--update" as a hidden option because scripts may use it.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-add.txt         |    8 ++++----
 Documentation/git-rm.txt          |    2 +-
 Documentation/gitattributes.txt   |    4 ++--
 builtin/add.c                     |    5 +++--
 t/t1511-rev-parse-caret.sh        |    2 +-
 t/t2200-add-update.sh             |   26 +++++++++++++-------------
 t/t2201-add-update-typechange.sh  |    6 +++---
 t/t2203-add-intent.sh             |    2 +-
 t/t3030-merge-recursive.sh        |    2 +-
 t/t3415-rebase-autosquash.sh      |   16 ++++++++--------
 t/t4037-diff-r-t-dirs.sh          |    2 +-
 t/t6022-merge-rename.sh           |    2 +-
 t/t6036-recursive-corner-cases.sh |    2 +-
 13 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index a03448f..e75ab39 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
-	  [--edit | -e] [--all | [--update | -u]] [--intent-to-add | -N]
+	  [--edit | -e] [[--all | -A ] | [--all-tracked | -a]] [--intent-to-add | -N]
 	  [--refresh] [--ignore-errors] [--ignore-missing] [--]
 	  [<filepattern>...]
 
@@ -98,8 +98,8 @@ quicker and more flexible than using the interactive hunk selector.
 However, it is easy to confuse oneself and create a patch that does not
 apply to the index. See EDITING PATCHES below.
 
--u::
---update::
+-a::
+--all-tracked::
 	Only match <filepattern> against already tracked files in
 	the index rather than the working tree. That means that it
 	will never stage new files, but that it will stage modified
@@ -113,7 +113,7 @@ subdirectories.
 
 -A::
 --all::
-	Like `-u`, but match <filepattern> against files in the
+	Like `-a`, but match <filepattern> against files in the
 	working tree in addition to the index. That means that it
 	will find new files as well as staging modified content and
 	removing files that are no longer in the working tree.
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 0adbe8b..1bb1b82 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -96,7 +96,7 @@ of tracked files in the working tree and record all removals of
 files that have been removed from the working tree with `rm`
 (as opposed to `git rm`), use `git commit -a`, as it will
 automatically notice and record all removals.  You can also have a
-similar effect without committing by using `git add -u`.
+similar effect without committing by using `git add -a`.
 
 Using ``git add -A''
 ~~~~~~~~~~~~~~~~~~~~
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 7e7e121..de89763 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -229,13 +229,13 @@ $ echo "* text=auto" >>.gitattributes
 $ rm .git/index     # Remove the index to force git to
 $ git reset         # re-scan the working directory
 $ git status        # Show files that will be normalized
-$ git add -u
+$ git add -a
 $ git add .gitattributes
 $ git commit -m "Introduce end-of-line normalization"
 -------------------------------------------------
 
 If any files that should not be normalized show up in 'git status',
-unset their `text` attribute before running 'git add -u'.
+unset their `text` attribute before running 'git add -a'.
 
 ------------------------
 manual.pdf	-text
diff --git a/builtin/add.c b/builtin/add.c
index f7a17e4..504061d 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -42,7 +42,7 @@ static void update_callback(struct diff_queue_struct *q,
 		case DIFF_STATUS_UNMERGED:
 			/*
 			 * ADD_CACHE_IGNORE_REMOVAL is unset if "git
-			 * add -u" is calling us, In such a case, a
+			 * add -a" is calling us, In such a case, a
 			 * missing work tree file needs to be removed
 			 * if there is an unmerged entry at stage #2,
 			 * but such a diff record is followed by
@@ -320,8 +320,9 @@ static struct option builtin_add_options[] = {
 	OPT_BOOLEAN('p', "patch", &patch_interactive, "select hunks interactively"),
 	OPT_BOOLEAN('e', "edit", &edit_interactive, "edit current diff and apply"),
 	OPT__FORCE(&ignored_too, "allow adding otherwise ignored files"),
-	OPT_BOOLEAN('u', "update", &take_worktree_changes, "update tracked files"),
+	{ OPTION_BOOLEAN, 'u', "update", &take_worktree_changes, NULL, "update tracked files", PARSE_OPT_HIDDEN | PARSE_OPT_NOARG },
 	OPT_BOOLEAN('N', "intent-to-add", &intent_to_add, "record only the fact that the path will be added later"),
+	OPT_BOOLEAN('a', "all-tracked", &take_worktree_changes, "add changes from all tracked files"),
 	OPT_BOOLEAN('A', "all", &addremove, "add changes from all tracked and untracked files"),
 	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh the index"),
 	OPT_BOOLEAN( 0 , "ignore-errors", &ignore_add_errors, "just skip files which cannot be added because of errors"),
diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
index e043cb7..414f4f8 100755
--- a/t/t1511-rev-parse-caret.sh
+++ b/t/t1511-rev-parse-caret.sh
@@ -17,7 +17,7 @@ test_expect_success 'setup' '
 	git branch ref &&
 	git checkout master &&
 	echo modified >>a-blob &&
-	git add -u &&
+	git add -a &&
 	git commit -m Modified
 '
 
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 0692427..aabe8f5 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='git add -u
+test_description='git add -a
 
 This test creates a working tree state with three files:
 
@@ -8,10 +8,10 @@ This test creates a working tree state with three files:
   dir/sub (previously committed, modified)
   dir/other (untracked)
 
-and issues a git add -u with path limiting on "dir" to add
+and issues a git add -a with path limiting on "dir" to add
 only the updates to dir/sub.
 
-Also tested are "git add -u" without limiting, and "git add -u"
+Also tested are "git add -a" without limiting, and "git add -a"
 without contents changes, and other conditions'
 
 . ./test-lib.sh
@@ -36,7 +36,7 @@ test_expect_success setup '
 '
 
 test_expect_success update '
-	git add -u dir1 dir2
+	git add -a dir1 dir2
 '
 
 test_expect_success 'update noticed a removal' '
@@ -70,7 +70,7 @@ test_expect_success 'update from a subdirectory' '
 	(
 		cd dir1 &&
 		echo more >sub2 &&
-		git add -u sub2
+		git add -a sub2
 	)
 '
 
@@ -84,21 +84,21 @@ test_expect_success SYMLINKS 'replace a file with a symlink' '
 
 	rm foo &&
 	ln -s top foo &&
-	git add -u -- foo
+	git add -a -- foo
 
 '
 
 test_expect_success 'add everything changed' '
 
-	git add -u &&
+	git add -a &&
 	test -z "$(git diff-files)"
 
 '
 
-test_expect_success 'touch and then add -u' '
+test_expect_success 'touch and then add -a' '
 
 	touch check &&
-	git add -u &&
+	git add -a &&
 	test -z "$(git diff-files)"
 
 '
@@ -128,7 +128,7 @@ test_expect_success 'add -n -u should not add but just report' '
 
 '
 
-test_expect_success 'add -u resolves unmerged paths' '
+test_expect_success 'add -a resolves unmerged paths' '
 	git reset --hard &&
 	one=$(echo 1 | git hash-object -w --stdin) &&
 	two=$(echo 2 | git hash-object -w --stdin) &&
@@ -149,7 +149,7 @@ test_expect_success 'add -u resolves unmerged paths' '
 	echo 3 >path1 &&
 	echo 2 >path3 &&
 	echo 2 >path5 &&
-	git add -u &&
+	git add -a &&
 	git ls-files -s path1 path2 path3 path4 path5 path6 >actual &&
 	{
 		echo "100644 $three 0	path1"
@@ -176,8 +176,8 @@ test_expect_success 'add -u resolves unmerged paths' '
 
 '
 
-test_expect_success '"add -u non-existent" should fail' '
-	test_must_fail git add -u non-existent &&
+test_expect_success '"add -a non-existent" should fail' '
+	test_must_fail git add -a non-existent &&
 	! (git ls-files | grep "non-existent")
 '
 
diff --git a/t/t2201-add-update-typechange.sh b/t/t2201-add-update-typechange.sh
index 2e8f702..8981ccb 100755
--- a/t/t2201-add-update-typechange.sh
+++ b/t/t2201-add-update-typechange.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='more git add -u'
+test_description='more git add -a'
 
 . ./test-lib.sh
 
@@ -124,10 +124,10 @@ test_expect_success diff-index '
 	test_cmp expect-index actual
 '
 
-test_expect_success 'add -u' '
+test_expect_success 'add -a' '
 	rm -f ".git/saved-index" &&
 	cp -p ".git/index" ".git/saved-index" &&
-	git add -u &&
+	git add -a &&
 	git ls-files -s >actual &&
 	test_cmp expect-final actual
 '
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 58a3299..880bcb6 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -19,7 +19,7 @@ test_expect_success 'check result of "add -N"' '
 '
 
 test_expect_success 'intent to add is just an ordinary empty blob' '
-	git add -u &&
+	git add -a &&
 	git ls-files -s file >actual &&
 	git ls-files -s elif | sed -e "s/elif/file/" >expect &&
 	test_cmp expect actual
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 34794f8..9255360 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -320,7 +320,7 @@ test_expect_success 'fail if the index has unresolved entries' '
 	test_must_fail git merge "$c5" &&
 	test_must_fail git merge "$c5" 2> out &&
 	grep "not possible because you have unmerged files" out &&
-	git add -u &&
+	git add -a &&
 	test_must_fail git merge "$c5" 2> out &&
 	grep "You have not concluded your merge" out &&
 	rm -f .git/MERGE_HEAD &&
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index b38be8e..c41c9e3 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -25,7 +25,7 @@ test_expect_success setup '
 test_auto_fixup () {
 	git reset --hard base &&
 	echo 1 >file1 &&
-	git add -u &&
+	git add -a &&
 	test_tick &&
 	git commit -m "fixup! first" &&
 
@@ -54,7 +54,7 @@ test_expect_success 'auto fixup (config)' '
 test_auto_squash () {
 	git reset --hard base &&
 	echo 1 >file1 &&
-	git add -u &&
+	git add -a &&
 	test_tick &&
 	git commit -m "squash! first" &&
 
@@ -83,7 +83,7 @@ test_expect_success 'auto squash (config)' '
 test_expect_success 'misspelled auto squash' '
 	git reset --hard base &&
 	echo 1 >file1 &&
-	git add -u &&
+	git add -a &&
 	test_tick &&
 	git commit -m "squash! forst" &&
 	git tag final-missquash &&
@@ -102,7 +102,7 @@ test_expect_success 'auto squash that matches 2 commits' '
 	test_tick &&
 	git commit -m "first new commit" &&
 	echo 1 >file1 &&
-	git add -u &&
+	git add -a &&
 	test_tick &&
 	git commit -m "squash! first" &&
 	git tag final-multisquash &&
@@ -119,7 +119,7 @@ test_expect_success 'auto squash that matches 2 commits' '
 test_expect_success 'auto squash that matches a commit after the squash' '
 	git reset --hard base &&
 	echo 1 >file1 &&
-	git add -u &&
+	git add -a &&
 	test_tick &&
 	git commit -m "squash! third" &&
 	echo 4 >file4 &&
@@ -140,7 +140,7 @@ test_expect_success 'auto squash that matches a commit after the squash' '
 test_expect_success 'auto squash that matches a sha1' '
 	git reset --hard base &&
 	echo 1 >file1 &&
-	git add -u &&
+	git add -a &&
 	test_tick &&
 	git commit -m "squash! $(git rev-parse --short HEAD^)" &&
 	git tag final-shasquash &&
@@ -156,7 +156,7 @@ test_expect_success 'auto squash that matches a sha1' '
 test_expect_success 'auto squash that matches longer sha1' '
 	git reset --hard base &&
 	echo 1 >file1 &&
-	git add -u &&
+	git add -a &&
 	test_tick &&
 	git commit -m "squash! $(git rev-parse --short=11 HEAD^)" &&
 	git tag final-longshasquash &&
@@ -172,7 +172,7 @@ test_expect_success 'auto squash that matches longer sha1' '
 test_auto_commit_flags () {
 	git reset --hard base &&
 	echo 1 >file1 &&
-	git add -u &&
+	git add -a &&
 	test_tick &&
 	git commit --$1 first-commit &&
 	git tag final-commit-$1 &&
diff --git a/t/t4037-diff-r-t-dirs.sh b/t/t4037-diff-r-t-dirs.sh
index f5ce3b2..77534aa 100755
--- a/t/t4037-diff-r-t-dirs.sh
+++ b/t/t4037-diff-r-t-dirs.sh
@@ -22,7 +22,7 @@ test_expect_success setup '
 	do
 		echo hello >$p || exit
 	done &&
-	git add -u &&
+	git add -a &&
 	git add . &&
 	test_tick &&
 	git commit -m second
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 1ed259d..f021939 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -262,7 +262,7 @@ test_expect_success 'setup for rename + d/f conflicts' '
 
 	echo 11 >>sub/file &&
 	echo more >>dir/file-in-the-way &&
-	git add -u &&
+	git add -a &&
 	git commit -m "Commit to merge, with dir in the way" &&
 
 	git checkout -b dir-not-in-way &&
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 871577d..8359ccc 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -197,7 +197,7 @@ test_expect_success 'setup differently handled merges of rename/add conflict' '
 	test_must_fail git merge B &&
 	rm new_a~HEAD new_a &&
 	printf "Incorrectly merged content" >>new_a &&
-	git add -u &&
+	git add -a &&
 	test_tick && git commit -m E &&
 	git tag E
 '
-- 
1.7.4.1.224.gefc87

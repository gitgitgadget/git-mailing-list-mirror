Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B92BC56201
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 10:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C78D22076B
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 10:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0KKPFJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbgKXKPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 05:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgKXKPz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 05:15:55 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D74C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 02:15:54 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 1so2259565wme.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 02:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Q/ZZ96475PN8wMRyI8Cl9MAgO4hJupMUeWxw0ZlE4+s=;
        b=Z0KKPFJW1grPgF9XdXsQzHKQdYArzy8aoaFYouDZLQ+3dEqTtd2mBt9sZbNKHMKryn
         /tVzY/Z/D6vpuUac8AzMh/UIKKxsul7eOCiLmP185o67XJsET+++hHdTEK9vbPBINtGJ
         cxvOeV55tnKwku10sSOSdODuFCdMkuKBIf4D8CqlnJVnmlcUrjIbZ6l57BMBO9fEpQj5
         +3hYZsWHd1xoiVKtmZVE+3dN6A9qfcJ5ANuWTNEFB7eFRjESYfhzt69nJXowiMF+bCU1
         LP85xUeIT4kAeJvcGlzliR0aSd42DW3t2y74z9iZYawjw7//clzP1FMzTWuz5pkYMCNM
         R9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q/ZZ96475PN8wMRyI8Cl9MAgO4hJupMUeWxw0ZlE4+s=;
        b=YyMtrTn5b38WpflBWQc6tgYeefLV4nG8wV0o4OhCHRuYGtxnrG1izUgejKrcp3ZDuk
         mmxxfp5vgtSaXoqZIFlF7kVMgjvOvyD4fb1CxV1fccnjULNF5Fh1npT76LGmFWaJKC+I
         Zc+N8kctgg2r05VR/S+m1KXl20s3u0+W7Iawg+eF2G+FrTZOGwnN1Y4AjwvDNR2GJymx
         LL605XvQkKsd5gPt8/CF+frEK9Sy04p7pWPTozSUGdjhxMxkN4oZKqY89hwH7jjT4/TM
         6SqyhOWRJhtlICNq80eShqxO3Ef3grOx4k91ZhlCjSeU2AfA04E13ThQZPQgJhwKt9yS
         FoZA==
X-Gm-Message-State: AOAM532FvAdh9KDvgbY+7q6nCglVXEyRu7x9+Bp86odrDSwwZ0Wsc/dV
        UDCajw/Y0BQGZKCt/Jj/IPOYkrOfxrs=
X-Google-Smtp-Source: ABdhPJzHYTNj3cgNq0TlhLLBPe+UNeIevq2jYF5/4za4XRmC+U5EveiWeLFlXwMkzGBsLj7zdsE/rA==
X-Received: by 2002:a1c:f717:: with SMTP id v23mr3521946wmh.89.1606212951690;
        Tue, 24 Nov 2020 02:15:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p3sm25790034wrs.50.2020.11.24.02.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 02:15:50 -0800 (PST)
Message-Id: <pull.798.git.1606212950283.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Nov 2020 10:15:49 +0000
Subject: [PATCH] t3404: do not depend on any specific default branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Now that we can override the default branch name in the tests via
`GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME`, we should avoid expecting a
particular hard-coded name.

So let's rename the initial branch immediately to `primary` and work
with that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    t3404: do not depend on any specific default branch name
    
    This makes t3404-rebase-interactive.sh resilient against changing the
    default branch name.
    
    Applying this patch would obsolete the change in 
    js/default-branch-name-tests-final-stretch to force the default branch
    name to master in t3404.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-798%2Fdscho%2Ft3404-and-the-default-branch-name-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-798/dscho/t3404-and-the-default-branch-name-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/798

 t/t3404-rebase-interactive.sh | 89 ++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 44 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 1e56696e4f..b06fc36159 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -12,7 +12,7 @@ Initial setup:
 
      one - two - three - four (conflict-branch)
    /
- A - B - C - D - E            (master)
+ A - B - C - D - E            (primary)
  | \
  |   F - G - H                (branch1)
  |     \
@@ -30,6 +30,7 @@ Initial setup:
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
 test_expect_success 'setup' '
+	git switch -C primary &&
 	test_commit A file1 &&
 	test_commit B file1 &&
 	test_commit C file2 &&
@@ -65,7 +66,7 @@ SHELL=
 export SHELL
 
 test_expect_success 'rebase --keep-empty' '
-	git checkout -b emptybranch master &&
+	git checkout -b emptybranch primary &&
 	git commit --allow-empty -m "empty" &&
 	git rebase --keep-empty -i HEAD~2 &&
 	git log --oneline >actual &&
@@ -86,7 +87,7 @@ test_expect_success 'rebase -i with empty todo list' '
 '
 
 test_expect_success 'rebase -i with the exec command' '
-	git checkout master &&
+	git checkout primary &&
 	(
 	set_fake_editor &&
 	FAKE_LINES="1 exec_>touch-one
@@ -103,12 +104,12 @@ test_expect_success 'rebase -i with the exec command' '
 	test_path_is_file touch-three &&
 	test_path_is_file "touch-file  name with spaces" &&
 	test_path_is_file touch-after-semicolon &&
-	test_cmp_rev master HEAD &&
+	test_cmp_rev primary HEAD &&
 	rm -f touch-*
 '
 
 test_expect_success 'rebase -i with the exec command runs from tree root' '
-	git checkout master &&
+	git checkout primary &&
 	mkdir subdir && (cd subdir &&
 	set_fake_editor &&
 	FAKE_LINES="1 exec_>touch-subdir" \
@@ -121,7 +122,7 @@ test_expect_success 'rebase -i with the exec command runs from tree root' '
 test_expect_success 'rebase -i with exec allows git commands in subdirs' '
 	test_when_finished "rm -rf subdir" &&
 	test_when_finished "git rebase --abort ||:" &&
-	git checkout master &&
+	git checkout primary &&
 	mkdir subdir && (cd subdir &&
 	set_fake_editor &&
 	FAKE_LINES="1 x_cd_subdir_&&_git_rev-parse_--is-inside-work-tree" \
@@ -139,13 +140,13 @@ test_expect_success 'rebase -i sets work tree properly' '
 '
 
 test_expect_success 'rebase -i with the exec command checks tree cleanness' '
-	git checkout master &&
+	git checkout primary &&
 	(
 		set_fake_editor &&
 		test_must_fail env FAKE_LINES="exec_echo_foo_>file1 1" \
 			git rebase -i HEAD^
 	) &&
-	test_cmp_rev master^ HEAD &&
+	test_cmp_rev primary^ HEAD &&
 	git reset --hard &&
 	git rebase --continue
 '
@@ -168,7 +169,7 @@ test_expect_success 'rebase -x with newline in command fails' '
 '
 
 test_expect_success 'rebase -i with exec of inexistent command' '
-	git checkout master &&
+	git checkout primary &&
 	test_when_finished "git rebase --abort" &&
 	(
 		set_fake_editor &&
@@ -259,8 +260,8 @@ test_expect_success 'stop on conflicting pick' '
 	>>>>>>> $commit (G)
 	EOF
 	git tag new-branch1 &&
-	test_must_fail git rebase -i master &&
-	test "$(git rev-parse HEAD~3)" = "$(git rev-parse master)" &&
+	test_must_fail git rebase -i primary &&
+	test "$(git rev-parse HEAD~3)" = "$(git rev-parse primary)" &&
 	test_cmp expect .git/rebase-merge/patch &&
 	test_cmp expect2 file1 &&
 	test "$(git diff --name-status |
@@ -287,7 +288,7 @@ test_expect_success 'abort' '
 test_expect_success 'abort with error when new base cannot be checked out' '
 	git rm --cached file1 &&
 	git commit -m "remove file in base" &&
-	test_must_fail git rebase -i master > output 2>&1 &&
+	test_must_fail git rebase -i primary > output 2>&1 &&
 	test_i18ngrep "The following untracked working tree files would be overwritten by checkout:" \
 		output &&
 	test_i18ngrep "file1" output &&
@@ -301,7 +302,7 @@ test_expect_success 'retain authorship' '
 	test_tick &&
 	GIT_AUTHOR_NAME="Twerp Snog" git commit -m "different author" &&
 	git tag twerp &&
-	git rebase -i --onto master HEAD^ &&
+	git rebase -i --onto primary HEAD^ &&
 	git show HEAD | grep "^Author: Twerp Snog"
 '
 
@@ -336,10 +337,10 @@ test_expect_success 'squash' '
 	(
 		set_fake_editor &&
 		FAKE_LINES="1 squash 2" EXPECT_HEADER_COUNT=2 \
-			git rebase -i --onto master HEAD~2
+			git rebase -i --onto primary HEAD~2
 	) &&
 	test B = $(cat file7) &&
-	test_cmp_rev HEAD^ master
+	test_cmp_rev HEAD^ primary
 '
 
 test_expect_success 'retain authorship when squashing' '
@@ -366,12 +367,12 @@ test_expect_failure REBASE_P 'exchange two commits with -p' '
 '
 
 test_expect_success REBASE_P 'preserve merges with -p' '
-	git checkout -b to-be-preserved master^ &&
+	git checkout -b to-be-preserved primary^ &&
 	: > unrelated-file &&
 	git add unrelated-file &&
 	test_tick &&
 	git commit -m "unrelated" &&
-	git checkout -b another-branch master &&
+	git checkout -b another-branch primary &&
 	echo B > file1 &&
 	test_tick &&
 	git commit -m J file1 &&
@@ -394,7 +395,7 @@ test_expect_success REBASE_P 'preserve merges with -p' '
 	git commit -m M file1 &&
 	git checkout -b to-be-rebased &&
 	test_tick &&
-	git rebase -i -p --onto branch1 master &&
+	git rebase -i -p --onto branch1 primary &&
 	git update-index --refresh &&
 	git diff-files --quiet &&
 	git diff-index --quiet --cached HEAD -- &&
@@ -437,7 +438,7 @@ test_expect_success '--continue tries to commit' '
 '
 
 test_expect_success 'verbose flag is heeded, even after --continue' '
-	git reset --hard master@{1} &&
+	git reset --hard primary@{1} &&
 	test_tick &&
 	test_must_fail git rebase -v -i --onto new-branch1 HEAD^ &&
 	echo resolved > file1 &&
@@ -802,7 +803,7 @@ test_expect_success 'rebase -i continue with unstaged submodule' '
 '
 
 test_expect_success 'avoid unnecessary reset' '
-	git checkout master &&
+	git checkout primary &&
 	git reset --hard &&
 	test-tool chmtime =123456789 file3 &&
 	git update-index --refresh &&
@@ -814,14 +815,14 @@ test_expect_success 'avoid unnecessary reset' '
 '
 
 test_expect_success 'reword' '
-	git checkout -b reword-branch master &&
+	git checkout -b reword-branch primary &&
 	(
 		set_fake_editor &&
 		FAKE_LINES="1 2 3 reword 4" FAKE_COMMIT_MESSAGE="E changed" \
 			git rebase -i A &&
 		git show HEAD | grep "E changed" &&
-		test $(git rev-parse master) != $(git rev-parse HEAD) &&
-		test_cmp_rev master^ HEAD^ &&
+		test $(git rev-parse primary) != $(git rev-parse HEAD) &&
+		test_cmp_rev primary^ HEAD^ &&
 		FAKE_LINES="1 2 reword 3 4" FAKE_COMMIT_MESSAGE="D changed" \
 			git rebase -i A &&
 		git show HEAD^ | grep "D changed" &&
@@ -918,7 +919,7 @@ test_expect_success 'rebase-i history with funny messages' '
 '
 
 test_expect_success 'prepare for rebase -i --exec' '
-	git checkout master &&
+	git checkout primary &&
 	git checkout -b execute &&
 	test_commit one_exec main.txt one_exec &&
 	test_commit two_exec main.txt two_exec &&
@@ -1027,7 +1028,7 @@ test_expect_success 'rebase -i --exec without <CMD>' '
 	git reset --hard execute &&
 	test_must_fail git rebase -i --exec 2>actual &&
 	test_i18ngrep "requires a value" actual &&
-	git checkout master
+	git checkout primary
 '
 
 test_expect_success 'rebase -i --root re-order and drop commits' '
@@ -1079,7 +1080,7 @@ test_expect_success 'rebase -i --root fixup root commit' '
 
 test_expect_success 'rebase -i --root reword original root commit' '
 	test_when_finished "test_might_fail git rebase --abort" &&
-	git checkout -b reword-original-root-branch master &&
+	git checkout -b reword-original-root-branch primary &&
 	(
 		set_fake_editor &&
 		FAKE_LINES="reword 1 2" FAKE_COMMIT_MESSAGE="A changed" \
@@ -1091,7 +1092,7 @@ test_expect_success 'rebase -i --root reword original root commit' '
 
 test_expect_success 'rebase -i --root reword new root commit' '
 	test_when_finished "test_might_fail git rebase --abort" &&
-	git checkout -b reword-now-root-branch master &&
+	git checkout -b reword-now-root-branch primary &&
 	(
 		set_fake_editor &&
 		FAKE_LINES="reword 3 1" FAKE_COMMIT_MESSAGE="C changed" \
@@ -1251,7 +1252,7 @@ test_expect_success 'rebase -i error on commits with \ in message' '
 '
 
 test_expect_success 'short commit ID setup' '
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout primary" &&
 	git checkout --orphan collide &&
 	git rm -rf . &&
 	(
@@ -1292,7 +1293,7 @@ test_expect_success 'short commit ID collide' '
 	t3404_collider	sha1:ac4f2ee
 	t3404_collider	sha256:16697
 	EOF
-	test_when_finished "reset_rebase && git checkout master" &&
+	test_when_finished "reset_rebase && git checkout primary" &&
 	git checkout collide &&
 	colliding_id=$(test_oid t3404_collision) &&
 	hexsz=$(test_oid hexsz) &&
@@ -1416,11 +1417,11 @@ test_expect_success 'rebase --continue removes CHERRY_PICK_HEAD' '
 
 rebase_setup_and_clean () {
 	test_when_finished "
-		git checkout master &&
+		git checkout primary &&
 		test_might_fail git branch -D $1 &&
 		test_might_fail git rebase --abort
 	" &&
-	git checkout -b $1 ${2:-master}
+	git checkout -b $1 ${2:-primary}
 }
 
 test_expect_success 'drop' '
@@ -1451,7 +1452,7 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = warn' '
 	cat >expect <<-EOF &&
 	Warning: some commits may have been dropped accidentally.
 	Dropped commits (newer to older):
-	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
+	 - $(git rev-list --pretty=oneline --abbrev-commit -1 primary)
 	To avoid this message, use "drop" to explicitly remove a commit.
 	EOF
 	test_config rebase.missingCommitsCheck warn &&
@@ -1469,8 +1470,8 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
 	cat >expect <<-EOF &&
 	Warning: some commits may have been dropped accidentally.
 	Dropped commits (newer to older):
-	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
-	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master~2)
+	 - $(git rev-list --pretty=oneline --abbrev-commit -1 primary)
+	 - $(git rev-list --pretty=oneline --abbrev-commit -1 primary~2)
 	To avoid this message, use "drop" to explicitly remove a commit.
 
 	Use '\''git config rebase.missingCommitsCheck'\'' to change the level of warnings.
@@ -1512,11 +1513,11 @@ test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = ig
 
 test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = warn' '
 	cat >expect <<-EOF &&
-	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
+	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 primary~4)
 	Warning: some commits may have been dropped accidentally.
 	Dropped commits (newer to older):
-	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
-	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
+	 - $(git rev-list --pretty=oneline --abbrev-commit -1 primary)
+	 - $(git rev-list --pretty=oneline --abbrev-commit -1 primary~4)
 	To avoid this message, use "drop" to explicitly remove a commit.
 	EOF
 	head -n4 expect >expect.2 &&
@@ -1546,11 +1547,11 @@ test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = wa
 
 test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = error' '
 	cat >expect <<-EOF &&
-	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
+	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 primary~4)
 	Warning: some commits may have been dropped accidentally.
 	Dropped commits (newer to older):
-	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
-	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
+	 - $(git rev-list --pretty=oneline --abbrev-commit -1 primary)
+	 - $(git rev-list --pretty=oneline --abbrev-commit -1 primary~4)
 	To avoid this message, use "drop" to explicitly remove a commit.
 
 	Use '\''git config rebase.missingCommitsCheck'\'' to change the level of warnings.
@@ -1635,7 +1636,7 @@ test_expect_success 'respects rebase.abbreviateCommands with fixup, squash and e
 	(
 		set_cat_todo_editor &&
 		test_must_fail git rebase -i --exec "git show HEAD" \
-			--autosquash master >actual
+			--autosquash primary >actual
 	) &&
 	test_cmp expected actual
 '
@@ -1646,7 +1647,7 @@ test_expect_success 'static check of bad command' '
 		set_fake_editor &&
 		test_must_fail env FAKE_LINES="1 2 3 bad 4 5" \
 		git rebase -i --root 2>actual &&
-		test_i18ngrep "badcmd $(git rev-list --oneline -1 master~1)" \
+		test_i18ngrep "badcmd $(git rev-list --oneline -1 primary~1)" \
 				actual &&
 		test_i18ngrep "You can fix this with .git rebase --edit-todo.." \
 				actual &&
@@ -1798,13 +1799,13 @@ test_expect_success 'todo has correct onto hash' '
 '
 
 test_expect_success 'ORIG_HEAD is updated correctly' '
-	test_when_finished "git checkout master && git branch -D test-orig-head" &&
+	test_when_finished "git checkout primary && git branch -D test-orig-head" &&
 	git checkout -b test-orig-head A &&
 	git commit --allow-empty -m A1 &&
 	git commit --allow-empty -m A2 &&
 	git commit --allow-empty -m A3 &&
 	git commit --allow-empty -m A4 &&
-	git rebase master &&
+	git rebase primary &&
 	test_cmp_rev ORIG_HEAD test-orig-head@{1}
 '
 

base-commit: faefdd61ec7c7f6f3c8c9907891465ac9a2a1475
-- 
gitgitgadget

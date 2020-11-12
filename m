Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99035C388F7
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27E9422241
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eI2gq30b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgKLWoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbgKLWoI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:44:08 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8EAC0613D6
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:06 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p22so6588218wmg.3
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UUM/0lmCs1aqvCoxTM1h22m3vboSA9Rt6AykdoJDelI=;
        b=eI2gq30bfijY9XTdr3YgIFfuE8f+Z6MB9gsl7T+5P1xhJwUgdSBt2WbyZI87/YYmSa
         SpgOXkr3WWQrrrJxL9e7be2YnSaWM1GV70OMH7DI58fjttSWUeVT29kEQlkWAGjIRCiI
         hZcSyoHv67v7UVYuvlE1p0gH7046Nltfeysiu7jCpI3eIaGhvPFvqgwODAI5tgpVIY5T
         yPcaa0ORcosHmLG8XnBkHfWldg7ME6ldaW4IK3dXxehdYLGOBrYkqz12AfGuZqUPkzN2
         KzZ5HHPvdPzXSJrSM8lFwS/qkeoR3QV2rB7miOpx0sjqehFG2tVfLMkfSXhSPlzycxhI
         amNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UUM/0lmCs1aqvCoxTM1h22m3vboSA9Rt6AykdoJDelI=;
        b=lRivs16wH/wSWaslQj2SSFzwnbU/ENGZfA1i2yyl6D2BlsrArsUtx+lznT6zJpBs5h
         NbWXCAkIStBwOa18Humy/K1xWtOaZQMzDXJbEtC3VKdra5uIaYCreXaYYjoyLVhn1K09
         TQeAPVgnaWF1JLZIT4JVoWR4H+BJgmlvi12tIzhkTsVVJwG+TPMlWt6efiZcCy+rgwE8
         P5/R0N9QyasUiUyX6eZ/rQF/WrBIpe1RSOZNqi+JJhPPqGumxWMXtneVLBmfyitCNgbo
         lI3vpWqeK75QNvqKGkLaJ63NXt6b/BtvSVvGb9egqD85hN/Bkcl6bvcqZdXhRlJx353a
         m5zA==
X-Gm-Message-State: AOAM5312ujkzQnz7nyuwIzfT+6j4l0PjRYeQsDBBJEee/BvWWUd8VJsz
        ZVPm+dXgDeUFaqklsHdC/x19JmXmWPo=
X-Google-Smtp-Source: ABdhPJwKXgM+9YYRrASUuvLmFM+PFcktexL+uKMqMwFauFU/j6SuRN8N/XV9DW7lCw+JhMNxXKZ7VQ==
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr50792wmb.39.1605221044295;
        Thu, 12 Nov 2020 14:44:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q2sm8472669wru.76.2020.11.12.14.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:44:03 -0800 (PST)
Message-Id: <0697ef9742af1ab15bd886990bbc0080bad6f41c.1605221039.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.git.1605221038.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Nov 2020 22:43:34 +0000
Subject: [PATCH 04/28] t3[0-3]*: adjust the references to the default branch
 name "main"
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

This trick was performed via

	$ (cd t &&
	   sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
		-e 's/Master/Main/g' -- t3[0-3]*.sh t3206/*)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3040-subprojects-basic.sh          |   2 +-
 t/t3200-branch.sh                     | 242 +++++++++++++-------------
 t/t3201-branch-contains.sh            |  80 ++++-----
 t/t3202-show-branch-octopus.sh        |   2 +-
 t/t3203-branch-output.sh              |  38 ++--
 t/t3204-branch-name-interpretation.sh |   6 +-
 t/t3205-branch-color.sh               |   6 +-
 t/t3206-range-diff.sh                 |  40 ++---
 t/t3206/history.export                |   2 +-
 t/t3210-pack-refs.sh                  |   4 +-
 t/t3211-peel-ref.sh                   |   4 +-
 t/t3301-notes.sh                      |   6 +-
 t/t3302-notes-index-expensive.sh      |   2 +-
 t/t3303-notes-subtrees.sh             |   8 +-
 t/t3304-notes-mixed.sh                |   8 +-
 t/t3308-notes-merge.sh                |   2 +-
 t/t3320-notes-merge-worktrees.sh      |   4 +-
 t/test-lib.sh                         |   2 +-
 18 files changed, 229 insertions(+), 229 deletions(-)

diff --git a/t/t3040-subprojects-basic.sh b/t/t3040-subprojects-basic.sh
index b81eb5fd6f..f3ea8dcf58 100755
--- a/t/t3040-subprojects-basic.sh
+++ b/t/t3040-subprojects-basic.sh
@@ -80,6 +80,6 @@ test_expect_success 'checkout in superproject' '
 '
 
 # just interesting what happened...
-# git diff --name-status -M save master
+# git diff --name-status -M save main
 
 test_done
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a0b832d59e..63036e0369 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -28,7 +28,7 @@ test_expect_success 'branch -h in broken repository' '
 	(
 		cd broken &&
 		git init &&
-		>.git/refs/heads/master &&
+		>.git/refs/heads/main &&
 		test_expect_code 129 git branch -h >usage 2>&1
 	) &&
 	test_i18ngrep "[Uu]sage" broken/usage
@@ -42,8 +42,8 @@ test_expect_success 'git branch a/b/c should create a branch' '
 	git branch a/b/c && test_path_is_file .git/refs/heads/a/b/c
 '
 
-test_expect_success 'git branch mb master... should create a branch' '
-	git branch mb master... && test_path_is_file .git/refs/heads/mb
+test_expect_success 'git branch mb main... should create a branch' '
+	git branch mb main... && test_path_is_file .git/refs/heads/mb
 '
 
 test_expect_success 'git branch HEAD should fail' '
@@ -51,7 +51,7 @@ test_expect_success 'git branch HEAD should fail' '
 '
 
 cat >expect <<EOF
-$ZERO_OID $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
+$ZERO_OID $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from main
 EOF
 test_expect_success 'git branch --create-reflog d/e/f should create a branch and a log' '
 	GIT_COMMITTER_DATE="2005-05-26 23:30" \
@@ -110,7 +110,7 @@ test_expect_success 'git branch -m n/n n should work' '
 
 test_expect_success 'git branch -m bbb should rename checked out branch' '
 	test_when_finished git branch -D bbb &&
-	test_when_finished git checkout master &&
+	test_when_finished git checkout main &&
 	git checkout -b aaa &&
 	git commit --allow-empty -m "a new commit" &&
 	git rev-parse aaa@{0} >expect &&
@@ -124,7 +124,7 @@ test_expect_success 'git branch -m bbb should rename checked out branch' '
 
 test_expect_success 'renaming checked out branch works with d/f conflict' '
 	test_when_finished "git branch -D foo/bar || git branch -D foo" &&
-	test_when_finished git checkout master &&
+	test_when_finished git checkout main &&
 	git checkout -b foo &&
 	git branch -m foo/bar &&
 	git symbolic-ref HEAD >actual &&
@@ -185,7 +185,7 @@ test_expect_success 'git branch -M should leave orphaned HEAD alone' '
 		git checkout --orphan lonely &&
 		grep lonely .git/HEAD &&
 		test_path_is_missing .git/refs/head/lonely &&
-		git branch -M master mistress &&
+		git branch -M main mistress &&
 		grep lonely .git/HEAD
 	)
 '
@@ -201,7 +201,7 @@ test_expect_success 'resulting reflog can be shown by log -g' '
 '
 
 test_expect_success 'git branch -M baz bam should succeed when baz is checked out as linked working tree' '
-	git checkout master &&
+	git checkout main &&
 	git worktree add -b baz bazdir &&
 	git worktree add -f bazdir2 baz &&
 	git branch -M baz bam &&
@@ -224,18 +224,18 @@ test_expect_success 'git branch -M baz bam should succeed within a worktree in w
 	git worktree prune
 '
 
-test_expect_success 'git branch -M master should work when master is checked out' '
-	git checkout master &&
-	git branch -M master
+test_expect_success 'git branch -M main should work when main is checked out' '
+	git checkout main &&
+	git branch -M main
 '
 
-test_expect_success 'git branch -M master master should work when master is checked out' '
-	git checkout master &&
-	git branch -M master master
+test_expect_success 'git branch -M main main should work when main is checked out' '
+	git checkout main &&
+	git branch -M main main
 '
 
-test_expect_success 'git branch -M topic topic should work when master is checked out' '
-	git checkout master &&
+test_expect_success 'git branch -M topic topic should work when main is checked out' '
+	git checkout main &&
 	git branch topic &&
 	git branch -M topic topic
 '
@@ -292,8 +292,8 @@ test_expect_success 'bare main worktree has HEAD at branch deleted by secondary
 	git init nonbare &&
 	test_commit -C nonbare x &&
 	git clone --bare nonbare bare &&
-	git -C bare worktree add --detach ../secondary master &&
-	git -C secondary branch -D master
+	git -C bare worktree add --detach ../secondary main &&
+	git -C secondary branch -D main
 '
 
 test_expect_success 'git branch --list -v with --abbrev' '
@@ -345,7 +345,7 @@ test_expect_success 'git branch --column with an extremely long branch name' '
   j/k
   l
   m/m
-* master
+* main
   mb
   n
   o/o
@@ -388,7 +388,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'git branch -v with column.ui ignore
   j/k
   l
   m/m
-* master
+* main
   mb
   n
   o/o
@@ -427,8 +427,8 @@ test_expect_success 'config information was renamed, too' '
 '
 
 test_expect_success 'git branch -m correctly renames multiple config sections' '
-	test_when_finished "git checkout master" &&
-	git checkout -b source master &&
+	test_when_finished "git checkout main" &&
+	git checkout -b source main &&
 
 	# Assert that a config file with multiple config sections has
 	# those sections preserved...
@@ -587,18 +587,18 @@ test_expect_success 'git branch -C c1 c2 should never touch HEAD' '
 	! grep "$msg$" .git/logs/HEAD
 '
 
-test_expect_success 'git branch -C master should work when master is checked out' '
-	git checkout master &&
-	git branch -C master
+test_expect_success 'git branch -C main should work when main is checked out' '
+	git checkout main &&
+	git branch -C main
 '
 
-test_expect_success 'git branch -C master master should work when master is checked out' '
-	git checkout master &&
-	git branch -C master master
+test_expect_success 'git branch -C main main should work when main is checked out' '
+	git checkout main &&
+	git branch -C main main
 '
 
-test_expect_success 'git branch -C main5 main5 should work when master is checked out' '
-	git checkout master &&
+test_expect_success 'git branch -C main5 main5 should work when main is checked out' '
+	git checkout main &&
 	git branch main5 &&
 	git branch -C main5 main5
 '
@@ -620,8 +620,8 @@ test_expect_success 'git branch -C ab cd should overwrite existing config for cd
 test_expect_success 'git branch -c correctly copies multiple config sections' '
 	FOO=1 &&
 	export FOO &&
-	test_when_finished "git checkout master" &&
-	git checkout -b source2 master &&
+	test_when_finished "git checkout main" &&
+	git checkout -b source2 main &&
 
 	# Assert that a config file with multiple config sections has
 	# those sections preserved...
@@ -711,10 +711,10 @@ test_expect_success 'deleting a self-referential symref' '
 '
 
 test_expect_success 'renaming a symref is not allowed' '
-	git symbolic-ref refs/heads/topic refs/heads/master &&
+	git symbolic-ref refs/heads/topic refs/heads/main &&
 	test_must_fail git branch -m topic new-topic &&
 	git symbolic-ref refs/heads/topic &&
-	test_path_is_file .git/refs/heads/master &&
+	test_path_is_file .git/refs/heads/main &&
 	test_path_is_missing .git/refs/heads/new-topic
 '
 
@@ -728,27 +728,27 @@ test_expect_success SYMLINKS 'git branch -m u v should fail when the reflog for
 test_expect_success 'test tracking setup via --track' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --track my1 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --track my1 local/main &&
 	test $(git config branch.my1.remote) = local &&
-	test $(git config branch.my1.merge) = refs/heads/master
+	test $(git config branch.my1.merge) = refs/heads/main
 '
 
 test_expect_success 'test tracking setup (non-wildcard, matching)' '
 	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/master:refs/remotes/local/master &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --track my4 local/master &&
+	git config remote.local.fetch refs/heads/main:refs/remotes/local/main &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --track my4 local/main &&
 	test $(git config branch.my4.remote) = local &&
-	test $(git config branch.my4.merge) = refs/heads/master
+	test $(git config branch.my4.merge) = refs/heads/main
 '
 
 test_expect_success 'tracking setup fails on non-matching refspec' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
 	git config remote.local.fetch refs/heads/s:refs/remotes/local/s &&
-	test_must_fail git branch --track my5 local/master &&
+	test_must_fail git branch --track my5 local/main &&
 	test_must_fail git config branch.my5.remote &&
 	test_must_fail git config branch.my5.merge
 '
@@ -757,21 +757,21 @@ test_expect_success 'test tracking setup via config' '
 	git config branch.autosetupmerge true &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch my3 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch my3 local/main &&
 	test $(git config branch.my3.remote) = local &&
-	test $(git config branch.my3.merge) = refs/heads/master
+	test $(git config branch.my3.merge) = refs/heads/main
 '
 
 test_expect_success 'test overriding tracking setup via --no-track' '
 	git config branch.autosetupmerge true &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track my2 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --no-track my2 local/main &&
 	git config branch.autosetupmerge false &&
 	! test "$(git config branch.my2.remote)" = local &&
-	! test "$(git config branch.my2.merge)" = refs/heads/master
+	! test "$(git config branch.my2.merge)" = refs/heads/main
 '
 
 test_expect_success 'no tracking without .fetch entries' '
@@ -836,26 +836,26 @@ test_expect_success 'branch from tag w/--track causes failure' '
 
 test_expect_success '--set-upstream-to fails on multiple branches' '
 	echo "fatal: too many arguments to set new upstream" >expect &&
-	test_must_fail git branch --set-upstream-to master a b c 2>err &&
+	test_must_fail git branch --set-upstream-to main a b c 2>err &&
 	test_i18ncmp expect err
 '
 
 test_expect_success '--set-upstream-to fails on detached HEAD' '
 	git checkout HEAD^{} &&
 	test_when_finished git checkout - &&
-	echo "fatal: could not set upstream of HEAD to master when it does not point to any branch." >expect &&
-	test_must_fail git branch --set-upstream-to master 2>err &&
+	echo "fatal: could not set upstream of HEAD to main when it does not point to any branch." >expect &&
+	test_must_fail git branch --set-upstream-to main 2>err &&
 	test_i18ncmp expect err
 '
 
 test_expect_success '--set-upstream-to fails on a missing dst branch' '
 	echo "fatal: branch '"'"'does-not-exist'"'"' does not exist" >expect &&
-	test_must_fail git branch --set-upstream-to master does-not-exist 2>err &&
+	test_must_fail git branch --set-upstream-to main does-not-exist 2>err &&
 	test_i18ncmp expect err
 '
 
 test_expect_success '--set-upstream-to fails on a missing src branch' '
-	test_must_fail git branch --set-upstream-to does-not-exist master 2>err &&
+	test_must_fail git branch --set-upstream-to does-not-exist main 2>err &&
 	test_i18ngrep "the requested upstream branch '"'"'does-not-exist'"'"' does not exist" err
 '
 
@@ -874,20 +874,20 @@ test_expect_success '--set-upstream-to fails on locked config' '
 '
 
 test_expect_success 'use --set-upstream-to modify HEAD' '
-	test_config branch.master.remote foo &&
-	test_config branch.master.merge foo &&
+	test_config branch.main.remote foo &&
+	test_config branch.main.merge foo &&
 	git branch my12 &&
 	git branch --set-upstream-to my12 &&
-	test "$(git config branch.master.remote)" = "." &&
-	test "$(git config branch.master.merge)" = "refs/heads/my12"
+	test "$(git config branch.main.remote)" = "." &&
+	test "$(git config branch.main.merge)" = "refs/heads/my12"
 '
 
 test_expect_success 'use --set-upstream-to modify a particular branch' '
 	git branch my13 &&
-	git branch --set-upstream-to master my13 &&
+	git branch --set-upstream-to main my13 &&
 	test_when_finished "git branch --unset-upstream my13" &&
 	test "$(git config branch.my13.remote)" = "." &&
-	test "$(git config branch.my13.merge)" = "refs/heads/master"
+	test "$(git config branch.my13.merge)" = "refs/heads/main"
 '
 
 test_expect_success '--unset-upstream should fail if given a non-existent branch' '
@@ -906,14 +906,14 @@ test_expect_success '--unset-upstream should fail if config is locked' '
 
 test_expect_success 'test --unset-upstream on HEAD' '
 	git branch my14 &&
-	test_config branch.master.remote foo &&
-	test_config branch.master.merge foo &&
+	test_config branch.main.remote foo &&
+	test_config branch.main.merge foo &&
 	git branch --set-upstream-to my14 &&
 	git branch --unset-upstream &&
-	test_must_fail git config branch.master.remote &&
-	test_must_fail git config branch.master.merge &&
+	test_must_fail git config branch.main.remote &&
+	test_must_fail git config branch.main.merge &&
 	# fail for a branch without upstream set
-	echo "fatal: Branch '"'"'master'"'"' has no upstream information" >expect &&
+	echo "fatal: Branch '"'"'main'"'"' has no upstream information" >expect &&
 	test_must_fail git branch --unset-upstream 2>err &&
 	test_i18ncmp expect err
 '
@@ -934,14 +934,14 @@ test_expect_success '--unset-upstream should fail on detached HEAD' '
 
 test_expect_success 'test --unset-upstream on a particular branch' '
 	git branch my15 &&
-	git branch --set-upstream-to master my14 &&
+	git branch --set-upstream-to main my14 &&
 	git branch --unset-upstream my14 &&
 	test_must_fail git config branch.my14.remote &&
 	test_must_fail git config branch.my14.merge
 '
 
 test_expect_success 'disabled option --set-upstream fails' '
-	test_must_fail git branch --set-upstream origin/master
+	test_must_fail git branch --set-upstream origin/main
 '
 
 test_expect_success '--set-upstream-to notices an error to set branch as own upstream' '
@@ -956,32 +956,32 @@ test_expect_success '--set-upstream-to notices an error to set branch as own ups
 
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
-$ZERO_OID $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
+$ZERO_OID $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from main
 EOF
 test_expect_success 'git checkout -b g/h/i -l should create a branch and a log' '
 	GIT_COMMITTER_DATE="2005-05-26 23:30" \
-	git checkout -b g/h/i -l master &&
+	git checkout -b g/h/i -l main &&
 	test_path_is_file .git/refs/heads/g/h/i &&
 	test_path_is_file .git/logs/refs/heads/g/h/i &&
 	test_cmp expect .git/logs/refs/heads/g/h/i
 '
 
 test_expect_success 'checkout -b makes reflog by default' '
-	git checkout master &&
+	git checkout main &&
 	git config --unset core.logAllRefUpdates &&
 	git checkout -b alpha &&
 	git rev-parse --verify alpha@{0}
 '
 
 test_expect_success 'checkout -b does not make reflog when core.logAllRefUpdates = false' '
-	git checkout master &&
+	git checkout main &&
 	git config core.logAllRefUpdates false &&
 	git checkout -b beta &&
 	test_must_fail git rev-parse --verify beta@{0}
 '
 
 test_expect_success 'checkout -b with -l makes reflog when core.logAllRefUpdates = false' '
-	git checkout master &&
+	git checkout main &&
 	git checkout -lb gamma &&
 	git config --unset core.logAllRefUpdates &&
 	git rev-parse --verify gamma@{0}
@@ -990,10 +990,10 @@ test_expect_success 'checkout -b with -l makes reflog when core.logAllRefUpdates
 test_expect_success 'avoid ambiguous track' '
 	git config branch.autosetupmerge true &&
 	git config remote.ambi1.url lalala &&
-	git config remote.ambi1.fetch refs/heads/lalala:refs/heads/master &&
+	git config remote.ambi1.fetch refs/heads/lalala:refs/heads/main &&
 	git config remote.ambi2.url lilili &&
-	git config remote.ambi2.fetch refs/heads/lilili:refs/heads/master &&
-	test_must_fail git branch all1 master &&
+	git config remote.ambi2.fetch refs/heads/lilili:refs/heads/main &&
+	test_must_fail git branch all1 main &&
 	test -z "$(git config branch.all1.merge)"
 '
 
@@ -1049,10 +1049,10 @@ test_expect_success 'autosetuprebase local on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase local &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --track myr5 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --track myr5 local/main &&
 	test "$(git config branch.myr5.remote)" = local &&
-	test "$(git config branch.myr5.merge)" = refs/heads/master &&
+	test "$(git config branch.myr5.merge)" = refs/heads/main &&
 	! test "$(git config branch.myr5.rebase)" = true
 '
 
@@ -1060,10 +1060,10 @@ test_expect_success 'autosetuprebase never on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase never &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --track myr6 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --track myr6 local/main &&
 	test "$(git config branch.myr6.remote)" = local &&
-	test "$(git config branch.myr6.merge)" = refs/heads/master &&
+	test "$(git config branch.myr6.merge)" = refs/heads/main &&
 	! test "$(git config branch.myr6.rebase)" = true
 '
 
@@ -1071,10 +1071,10 @@ test_expect_success 'autosetuprebase remote on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase remote &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --track myr7 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --track myr7 local/main &&
 	test "$(git config branch.myr7.remote)" = local &&
-	test "$(git config branch.myr7.merge)" = refs/heads/master &&
+	test "$(git config branch.myr7.merge)" = refs/heads/main &&
 	test "$(git config branch.myr7.rebase)" = true
 '
 
@@ -1082,10 +1082,10 @@ test_expect_success 'autosetuprebase always on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase remote &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --track myr8 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --track myr8 local/main &&
 	test "$(git config branch.myr8.remote)" = local &&
-	test "$(git config branch.myr8.merge)" = refs/heads/master &&
+	test "$(git config branch.myr8.merge)" = refs/heads/main &&
 	test "$(git config branch.myr8.rebase)" = true
 '
 
@@ -1093,10 +1093,10 @@ test_expect_success 'autosetuprebase unconfigured on a tracked remote branch' '
 	git config --unset branch.autosetuprebase &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --track myr9 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --track myr9 local/main &&
 	test "$(git config branch.myr9.remote)" = local &&
-	test "$(git config branch.myr9.merge)" = refs/heads/master &&
+	test "$(git config branch.myr9.merge)" = refs/heads/main &&
 	test "z$(git config branch.myr9.rebase)" = z
 '
 
@@ -1114,7 +1114,7 @@ test_expect_success 'autosetuprebase unconfigured on a tracked local branch' '
 test_expect_success 'autosetuprebase unconfigured on untracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
 	git branch --no-track myr11 mybase2 &&
 	test "z$(git config branch.myr11.remote)" = z &&
 	test "z$(git config branch.myr11.merge)" = z &&
@@ -1124,8 +1124,8 @@ test_expect_success 'autosetuprebase unconfigured on untracked local branch' '
 test_expect_success 'autosetuprebase unconfigured on untracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track myr12 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --no-track myr12 local/main &&
 	test "z$(git config branch.myr12.remote)" = z &&
 	test "z$(git config branch.myr12.merge)" = z &&
 	test "z$(git config branch.myr12.rebase)" = z
@@ -1135,7 +1135,7 @@ test_expect_success 'autosetuprebase never on an untracked local branch' '
 	git config branch.autosetuprebase never &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
 	git branch --no-track myr13 mybase2 &&
 	test "z$(git config branch.myr13.remote)" = z &&
 	test "z$(git config branch.myr13.merge)" = z &&
@@ -1146,7 +1146,7 @@ test_expect_success 'autosetuprebase local on an untracked local branch' '
 	git config branch.autosetuprebase local &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
 	git branch --no-track myr14 mybase2 &&
 	test "z$(git config branch.myr14.remote)" = z &&
 	test "z$(git config branch.myr14.merge)" = z &&
@@ -1157,7 +1157,7 @@ test_expect_success 'autosetuprebase remote on an untracked local branch' '
 	git config branch.autosetuprebase remote &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
 	git branch --no-track myr15 mybase2 &&
 	test "z$(git config branch.myr15.remote)" = z &&
 	test "z$(git config branch.myr15.merge)" = z &&
@@ -1168,7 +1168,7 @@ test_expect_success 'autosetuprebase always on an untracked local branch' '
 	git config branch.autosetuprebase always &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
 	git branch --no-track myr16 mybase2 &&
 	test "z$(git config branch.myr16.remote)" = z &&
 	test "z$(git config branch.myr16.merge)" = z &&
@@ -1179,8 +1179,8 @@ test_expect_success 'autosetuprebase never on an untracked remote branch' '
 	git config branch.autosetuprebase never &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track myr17 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --no-track myr17 local/main &&
 	test "z$(git config branch.myr17.remote)" = z &&
 	test "z$(git config branch.myr17.merge)" = z &&
 	test "z$(git config branch.myr17.rebase)" = z
@@ -1190,8 +1190,8 @@ test_expect_success 'autosetuprebase local on an untracked remote branch' '
 	git config branch.autosetuprebase local &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track myr18 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --no-track myr18 local/main &&
 	test "z$(git config branch.myr18.remote)" = z &&
 	test "z$(git config branch.myr18.merge)" = z &&
 	test "z$(git config branch.myr18.rebase)" = z
@@ -1201,8 +1201,8 @@ test_expect_success 'autosetuprebase remote on an untracked remote branch' '
 	git config branch.autosetuprebase remote &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track myr19 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --no-track myr19 local/main &&
 	test "z$(git config branch.myr19.remote)" = z &&
 	test "z$(git config branch.myr19.merge)" = z &&
 	test "z$(git config branch.myr19.rebase)" = z
@@ -1212,8 +1212,8 @@ test_expect_success 'autosetuprebase always on an untracked remote branch' '
 	git config branch.autosetuprebase always &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track myr20 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --no-track myr20 local/main &&
 	test "z$(git config branch.myr20.remote)" = z &&
 	test "z$(git config branch.myr20.merge)" = z &&
 	test "z$(git config branch.myr20.rebase)" = z
@@ -1221,7 +1221,7 @@ test_expect_success 'autosetuprebase always on an untracked remote branch' '
 
 test_expect_success 'autosetuprebase always on detached HEAD' '
 	git config branch.autosetupmerge always &&
-	test_when_finished git checkout master &&
+	test_when_finished git checkout main &&
 	git checkout HEAD^0 &&
 	git branch my11 &&
 	test -z "$(git config branch.my11.remote)" &&
@@ -1249,18 +1249,18 @@ test_expect_success 'attempt to delete a branch without base and unmerged to HEA
 test_expect_success 'attempt to delete a branch merged to its base' '
 	# we are on my9 which is the initial commit; traditionally
 	# we would not have allowed deleting my8 that is not merged
-	# to my9, but it is set to track master that already has my8
-	git config branch.my8.merge refs/heads/master &&
+	# to my9, but it is set to track main that already has my8
+	git config branch.my8.merge refs/heads/main &&
 	git branch -d my8
 '
 
 test_expect_success 'attempt to delete a branch merged to its base' '
-	git checkout master &&
+	git checkout main &&
 	echo Third >>A &&
 	git commit -m "Third commit" A &&
 	git branch -t my10 my9 &&
 	git branch -f my10 HEAD^ &&
-	# we are on master which is at the third commit, and my10
+	# we are on main which is at the third commit, and my10
 	# is behind us, so traditionally we would have allowed deleting
 	# it; but my10 is set to track my9 that is further behind.
 	test_must_fail git branch -d my10
@@ -1287,7 +1287,7 @@ test_expect_success 'detect typo in branch name when using --edit-description' '
 '
 
 test_expect_success 'refuse --edit-description on unborn branch for now' '
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	write_script editor <<-\EOF &&
 		echo "New contents" >"$1"
 	EOF
@@ -1301,18 +1301,18 @@ test_expect_success '--merged catches invalid object names' '
 
 test_expect_success '--list during rebase' '
 	test_when_finished "reset_rebase" &&
-	git checkout master &&
+	git checkout main &&
 	FAKE_LINES="1 edit 2" &&
 	export FAKE_LINES &&
 	set_fake_editor &&
 	git rebase -i HEAD~2 &&
 	git branch --list >actual &&
-	test_i18ngrep "rebasing master" actual
+	test_i18ngrep "rebasing main" actual
 '
 
 test_expect_success '--list during rebase from detached HEAD' '
-	test_when_finished "reset_rebase && git checkout master" &&
-	git checkout master^0 &&
+	test_when_finished "reset_rebase && git checkout main" &&
+	git checkout main^0 &&
 	oid=$(git rev-parse --short HEAD) &&
 	FAKE_LINES="1 edit 2" &&
 	export FAKE_LINES &&
@@ -1348,11 +1348,11 @@ test_expect_success 'tracking with unexpected .fetch refspec' '
 		git remote add c ../c &&
 		git config remote.c.fetch "+refs/remotes/*:refs/remotes/*" &&
 		git fetch c &&
-		git branch --track local/a/master remotes/a/master &&
-		test "$(git config branch.local/a/master.remote)" = "c" &&
-		test "$(git config branch.local/a/master.merge)" = "refs/remotes/a/master" &&
+		git branch --track local/a/main remotes/a/main &&
+		test "$(git config branch.local/a/main.remote)" = "c" &&
+		test "$(git config branch.local/a/main.merge)" = "refs/remotes/a/main" &&
 		git rev-parse --verify a >expect &&
-		git rev-parse --verify local/a/master >actual &&
+		git rev-parse --verify local/a/main >actual &&
 		test_cmp expect actual
 	)
 '
@@ -1371,7 +1371,7 @@ test_expect_success 'configured committerdate sort' '
 		test_commit b &&
 		git branch >actual &&
 		cat >expect <<-\EOF &&
-		  master
+		  main
 		  a
 		  c
 		* b
@@ -1389,7 +1389,7 @@ test_expect_success 'option override configured sort' '
 		  a
 		* b
 		  c
-		  master
+		  main
 		EOF
 		test_cmp expect actual
 	)
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 3733cd0091..110cfef820 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -14,47 +14,47 @@ test_expect_success setup '
 
 	echo 1 >file &&
 	test_tick &&
-	git commit -a -m "second on master" &&
+	git commit -a -m "second on main" &&
 
 	git checkout side &&
 	echo 1 >file &&
 	test_tick &&
 	git commit -a -m "second on side" &&
 
-	git merge master
+	git merge main
 
 '
 
-test_expect_success 'branch --contains=master' '
+test_expect_success 'branch --contains=main' '
 
-	git branch --contains=master >actual &&
+	git branch --contains=main >actual &&
 	{
-		echo "  master" && echo "* side"
+		echo "  main" && echo "* side"
 	} >expect &&
 	test_cmp expect actual
 
 '
 
-test_expect_success 'branch --contains master' '
+test_expect_success 'branch --contains main' '
 
-	git branch --contains master >actual &&
+	git branch --contains main >actual &&
 	{
-		echo "  master" && echo "* side"
+		echo "  main" && echo "* side"
 	} >expect &&
 	test_cmp expect actual
 
 '
 
-test_expect_success 'branch --no-contains=master' '
+test_expect_success 'branch --no-contains=main' '
 
-	git branch --no-contains=master >actual &&
+	git branch --no-contains=main >actual &&
 	test_must_be_empty actual
 
 '
 
-test_expect_success 'branch --no-contains master' '
+test_expect_success 'branch --no-contains main' '
 
-	git branch --no-contains master >actual &&
+	git branch --no-contains main >actual &&
 	test_must_be_empty actual
 
 '
@@ -73,7 +73,7 @@ test_expect_success 'branch --no-contains=side' '
 
 	git branch --no-contains=side >actual &&
 	{
-		echo "  master"
+		echo "  main"
 	} >expect &&
 	test_cmp expect actual
 
@@ -81,9 +81,9 @@ test_expect_success 'branch --no-contains=side' '
 
 test_expect_success 'branch --contains with pattern implies --list' '
 
-	git branch --contains=master master >actual &&
+	git branch --contains=main main >actual &&
 	{
-		echo "  master"
+		echo "  main"
 	} >expect &&
 	test_cmp expect actual
 
@@ -91,7 +91,7 @@ test_expect_success 'branch --contains with pattern implies --list' '
 
 test_expect_success 'branch --no-contains with pattern implies --list' '
 
-	git branch --no-contains=master master >actual &&
+	git branch --no-contains=main main >actual &&
 	test_must_be_empty actual
 
 '
@@ -100,7 +100,7 @@ test_expect_success 'side: branch --merged' '
 
 	git branch --merged >actual &&
 	{
-		echo "  master" &&
+		echo "  main" &&
 		echo "* side"
 	} >expect &&
 	test_cmp expect actual
@@ -109,9 +109,9 @@ test_expect_success 'side: branch --merged' '
 
 test_expect_success 'branch --merged with pattern implies --list' '
 
-	git branch --merged=side master >actual &&
+	git branch --merged=side main >actual &&
 	{
-		echo "  master"
+		echo "  main"
 	} >expect &&
 	test_cmp expect actual
 
@@ -124,18 +124,18 @@ test_expect_success 'side: branch --no-merged' '
 
 '
 
-test_expect_success 'master: branch --merged' '
+test_expect_success 'main: branch --merged' '
 
-	git checkout master &&
+	git checkout main &&
 	git branch --merged >actual &&
 	{
-		echo "* master"
+		echo "* main"
 	} >expect &&
 	test_cmp expect actual
 
 '
 
-test_expect_success 'master: branch --no-merged' '
+test_expect_success 'main: branch --no-merged' '
 
 	git branch --no-merged >actual &&
 	{
@@ -147,22 +147,22 @@ test_expect_success 'master: branch --no-merged' '
 
 test_expect_success 'branch --no-merged with pattern implies --list' '
 
-	git branch --no-merged=master master >actual &&
+	git branch --no-merged=main main >actual &&
 	test_must_be_empty actual
 
 '
 
 test_expect_success 'implicit --list conflicts with modification options' '
 
-	test_must_fail git branch --contains=master -d &&
-	test_must_fail git branch --contains=master -m foo &&
-	test_must_fail git branch --no-contains=master -d &&
-	test_must_fail git branch --no-contains=master -m foo
+	test_must_fail git branch --contains=main -d &&
+	test_must_fail git branch --contains=main -m foo &&
+	test_must_fail git branch --no-contains=main -d &&
+	test_must_fail git branch --no-contains=main -m foo
 
 '
 
 test_expect_success 'Assert that --contains only works on commits, not trees & blobs' '
-	test_must_fail git branch --contains master^{tree} &&
+	test_must_fail git branch --contains main^{tree} &&
 	blob=$(git hash-object -w --stdin <<-\EOF
 	Some blob
 	EOF
@@ -172,11 +172,11 @@ test_expect_success 'Assert that --contains only works on commits, not trees & b
 '
 
 test_expect_success 'multiple branch --contains' '
-	git checkout -b side2 master &&
+	git checkout -b side2 main &&
 	>feature &&
 	git add feature &&
 	git commit -m "add feature" &&
-	git checkout -b next master &&
+	git checkout -b next main &&
 	git merge side &&
 	git branch --contains side --contains side2 >actual &&
 	cat >expect <<-\EOF &&
@@ -188,9 +188,9 @@ test_expect_success 'multiple branch --contains' '
 '
 
 test_expect_success 'multiple branch --merged' '
-	git branch --merged next --merged master >actual &&
+	git branch --merged next --merged main >actual &&
 	cat >expect <<-\EOF &&
-	  master
+	  main
 	* next
 	  side
 	EOF
@@ -200,13 +200,13 @@ test_expect_success 'multiple branch --merged' '
 test_expect_success 'multiple branch --no-contains' '
 	git branch --no-contains side --no-contains side2 >actual &&
 	cat >expect <<-\EOF &&
-	  master
+	  main
 	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'multiple branch --no-merged' '
-	git branch --no-merged next --no-merged master >actual &&
+	git branch --no-merged next --no-merged main >actual &&
 	cat >expect <<-\EOF &&
 	  side2
 	EOF
@@ -214,7 +214,7 @@ test_expect_success 'multiple branch --no-merged' '
 '
 
 test_expect_success 'branch --contains combined with --no-contains' '
-	git checkout -b seen master &&
+	git checkout -b seen main &&
 	git merge side &&
 	git merge side2 &&
 	git branch --contains side --no-contains side2 >actual &&
@@ -239,17 +239,17 @@ test_expect_success 'branch --merged combined with --no-merged' '
 # that the latter walk does not mess up our flag to see if it was
 # merged).
 #
-# Here "topic" tracks "master" with one extra commit, and "zzz" points to the
-# same tip as master The name "zzz" must come alphabetically after "topic"
+# Here "topic" tracks "main" with one extra commit, and "zzz" points to the
+# same tip as main The name "zzz" must come alphabetically after "topic"
 # as we process them in that order.
 test_expect_success PREPARE_FOR_MAIN_BRANCH 'branch --merged with --verbose' '
-	git branch --track topic master &&
+	git branch --track topic main &&
 	git branch zzz topic &&
 	git checkout topic &&
 	test_commit foo &&
 	git branch --merged topic >actual &&
 	cat >expect <<-\EOF &&
-	  master
+	  main
 	* topic
 	  zzz
 	EOF
diff --git a/t/t3202-show-branch-octopus.sh b/t/t3202-show-branch-octopus.sh
index 6adf47869c..97551016ad 100755
--- a/t/t3202-show-branch-octopus.sh
+++ b/t/t3202-show-branch-octopus.sh
@@ -15,7 +15,7 @@ test_expect_success 'setup' '
 
 	for i in $numbers
 	do
-		git checkout -b branch$i master &&
+		git checkout -b branch$i main &&
 		> file$i &&
 		git add file$i &&
 		test_tick &&
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index d65586541d..727c9d9caa 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -26,7 +26,7 @@ test_expect_success 'make remote branches' '
 cat >expect <<'EOF'
   branch-one
   branch-two
-* master
+* main
 EOF
 test_expect_success 'git branch shows local branches' '
 	git branch >actual &&
@@ -60,7 +60,7 @@ test_expect_success 'git branch -r shows remote branches' '
 cat >expect <<'EOF'
   branch-one
   branch-two
-* master
+* main
   remotes/origin/HEAD -> origin/branch-one
   remotes/origin/branch-one
   remotes/origin/branch-two
@@ -152,7 +152,7 @@ test_expect_success 'git branch shows detached HEAD properly' '
 * (HEAD detached at $(git rev-parse --short HEAD^0))
   branch-one
   branch-two
-  master
+  main
 EOF
 	git checkout HEAD^0 &&
 	git branch >actual &&
@@ -160,12 +160,12 @@ EOF
 '
 
 test_expect_success 'git branch shows detached HEAD properly after checkout --detach' '
-	git checkout master &&
+	git checkout main &&
 	cat >expect <<EOF &&
 * (HEAD detached at $(git rev-parse --short HEAD^0))
   branch-one
   branch-two
-  master
+  main
 EOF
 	git checkout --detach &&
 	git branch >actual &&
@@ -177,7 +177,7 @@ test_expect_success 'git branch shows detached HEAD properly after moving' '
 * (HEAD detached from $(git rev-parse --short HEAD))
   branch-one
   branch-two
-  master
+  main
 EOF
 	git reset --hard HEAD^1 &&
 	git branch >actual &&
@@ -189,9 +189,9 @@ test_expect_success 'git branch shows detached HEAD properly from tag' '
 * (HEAD detached at fromtag)
   branch-one
   branch-two
-  master
+  main
 EOF
-	git tag fromtag master &&
+	git tag fromtag main &&
 	git checkout fromtag &&
 	git branch >actual &&
 	test_i18ncmp expect actual
@@ -202,7 +202,7 @@ test_expect_success 'git branch shows detached HEAD properly after moving from t
 * (HEAD detached from fromtag)
   branch-one
   branch-two
-  master
+  main
 EOF
 	git reset --hard HEAD^1 &&
 	git branch >actual &&
@@ -214,7 +214,7 @@ test_expect_success 'git branch `--sort` option' '
 	* (HEAD detached from fromtag)
 	  branch-two
 	  branch-one
-	  master
+	  main
 	EOF
 	git branch --sort=objectsize >actual &&
 	test_i18ncmp expect actual
@@ -223,7 +223,7 @@ test_expect_success 'git branch `--sort` option' '
 test_expect_success 'git branch --points-at option' '
 	cat >expect <<-\EOF &&
 	  branch-one
-	  master
+	  main
 	EOF
 	git branch --points-at=branch-one >actual &&
 	test_cmp expect actual
@@ -260,14 +260,14 @@ test_expect_success 'sort branches, ignore case' '
 		cat >expected <<-\EOF &&
 		BRANCH-two
 		branch-one
-		master
+		main
 		EOF
 		test_cmp expected actual &&
 		git branch --list -i | awk "{print \$NF}" >actual &&
 		cat >expected <<-\EOF &&
 		branch-one
 		BRANCH-two
-		master
+		main
 		EOF
 		test_cmp expected actual
 	)
@@ -279,7 +279,7 @@ test_expect_success 'git branch --format option' '
 	Refname is refs/heads/ambiguous
 	Refname is refs/heads/branch-one
 	Refname is refs/heads/branch-two
-	Refname is refs/heads/master
+	Refname is refs/heads/main
 	Refname is refs/heads/ref-to-branch
 	Refname is refs/heads/ref-to-remote
 	EOF
@@ -293,7 +293,7 @@ test_expect_success 'worktree colors correct' '
 	  ambiguous<RESET>
 	  branch-one<RESET>
 	+ <CYAN>branch-two<RESET>
-	  master<RESET>
+	  main<RESET>
 	  ref-to-branch<RESET> -> branch-one
 	  ref-to-remote<RESET> -> origin/branch-one
 	EOF
@@ -306,9 +306,9 @@ test_expect_success 'worktree colors correct' '
 '
 
 test_expect_success "set up color tests" '
-	echo "<RED>master<RESET>" >expect.color &&
-	echo "master" >expect.bare &&
-	color_args="--format=%(color:red)%(refname:short) --list master"
+	echo "<RED>main<RESET>" >expect.color &&
+	echo "main" >expect.bare &&
+	color_args="--format=%(color:red)%(refname:short) --list main"
 '
 
 test_expect_success '%(color) omitted without tty' '
@@ -331,7 +331,7 @@ test_expect_success '--color overrides auto-color' '
 
 test_expect_success PREPARE_FOR_MAIN_BRANCH 'verbose output lists worktree path' '
 	one=$(git rev-parse --short HEAD) &&
-	two=$(git rev-parse --short master) &&
+	two=$(git rev-parse --short main) &&
 	cat >expect <<-EOF &&
 	* (HEAD detached from fromtag) $one one
 	  ambiguous                    $one one
diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
index 698d9cc4f3..e527e0b0c9 100755
--- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -28,7 +28,7 @@ test_expect_success 'update branch via @{-1}' '
 	git branch previous one &&
 
 	git checkout previous &&
-	git checkout master &&
+	git checkout main &&
 
 	git branch -f @{-1} two &&
 	expect_branch previous two
@@ -58,7 +58,7 @@ test_expect_success 'delete branch via @{-1}' '
 	git branch previous-del &&
 
 	git checkout previous-del &&
-	git checkout master &&
+	git checkout main &&
 
 	git branch -D @{-1} &&
 	expect_deleted previous-del
@@ -98,7 +98,7 @@ test_expect_success 'disallow deleting remote branch via @{-1}' '
 	git update-ref refs/remotes/origin/previous one &&
 
 	git checkout -b origin/previous two &&
-	git checkout master &&
+	git checkout main &&
 
 	test_must_fail git branch -r -D @{-1} &&
 	expect_branch refs/remotes/origin/previous one &&
diff --git a/t/t3205-branch-color.sh b/t/t3205-branch-color.sh
index 289625c464..9f2fb785d2 100755
--- a/t/t3205-branch-color.sh
+++ b/t/t3205-branch-color.sh
@@ -5,7 +5,7 @@ test_description='basic branch output coloring'
 
 test_expect_success 'set up some sample branches' '
 	test_commit foo &&
-	git update-ref refs/remotes/origin/master HEAD &&
+	git update-ref refs/remotes/origin/main HEAD &&
 	git update-ref refs/heads/other HEAD
 '
 
@@ -19,9 +19,9 @@ test_expect_success 'set up some color config' '
 
 test_expect_success 'regular output shows colors' '
 	cat >expect <<-\EOF &&
-	* <CYAN>master<RESET>
+	* <CYAN>main<RESET>
 	  <BLUE>other<RESET>
-	  <YELLOW>remotes/origin/master<RESET>
+	  <YELLOW>remotes/origin/main<RESET>
 	EOF
 	git branch --color -a >actual.raw &&
 	test_decode_color <actual.raw >actual &&
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 6eb344be03..2813a362c7 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -127,7 +127,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'simple A..B A..C (unmodified)' '
-	git range-diff --no-color master..topic master..unmodified \
+	git range-diff --no-color main..topic main..unmodified \
 		>actual &&
 	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid u1) s/5/A/
@@ -145,13 +145,13 @@ test_expect_success 'simple B...C (unmodified)' '
 '
 
 test_expect_success 'simple A B C (unmodified)' '
-	git range-diff --no-color master topic unmodified >actual &&
+	git range-diff --no-color main topic unmodified >actual &&
 	# same "expect" as above
 	test_cmp expect actual
 '
 
 test_expect_success 'trivial reordering' '
-	git range-diff --no-color master topic reordered >actual &&
+	git range-diff --no-color main topic reordered >actual &&
 	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid r1) s/5/A/
 	3:  $(test_oid t3) = 2:  $(test_oid r2) s/11/B/
@@ -162,7 +162,7 @@ test_expect_success 'trivial reordering' '
 '
 
 test_expect_success 'removed a commit' '
-	git range-diff --no-color master topic removed >actual &&
+	git range-diff --no-color main topic removed >actual &&
 	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid d1) s/5/A/
 	2:  $(test_oid t2) < -:  $(test_oid __) s/4/A/
@@ -173,7 +173,7 @@ test_expect_success 'removed a commit' '
 '
 
 test_expect_success 'added a commit' '
-	git range-diff --no-color master topic added >actual &&
+	git range-diff --no-color main topic added >actual &&
 	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid a1) s/5/A/
 	2:  $(test_oid t2) = 2:  $(test_oid a2) s/4/A/
@@ -185,7 +185,7 @@ test_expect_success 'added a commit' '
 '
 
 test_expect_success 'new base, A B C' '
-	git range-diff --no-color master topic rebased >actual &&
+	git range-diff --no-color main topic rebased >actual &&
 	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid b1) s/5/A/
 	2:  $(test_oid t2) = 2:  $(test_oid b2) s/4/A/
@@ -196,7 +196,7 @@ test_expect_success 'new base, A B C' '
 '
 
 test_expect_success 'new base, B...C' '
-	# this syntax includes the commits from master!
+	# this syntax includes the commits from main!
 	git range-diff --no-color topic...rebased >actual &&
 	cat >expect <<-EOF &&
 	-:  $(test_oid __) > 1:  $(test_oid b5) unrelated
@@ -420,7 +420,7 @@ test_expect_success 'file added and later removed' '
 
 test_expect_success 'no commits on one side' '
 	git commit --amend -m "new message" &&
-	git range-diff master HEAD@{1} HEAD
+	git range-diff main HEAD@{1} HEAD
 '
 
 test_expect_success 'changed message' '
@@ -482,11 +482,11 @@ test_expect_success 'dual-coloring' '
 	test_cmp expect actual
 '
 
-for prev in topic master..topic
+for prev in topic main..topic
 do
 	test_expect_success "format-patch --range-diff=$prev" '
 		git format-patch --cover-letter --range-diff=$prev \
-			master..unmodified >actual &&
+			main..unmodified >actual &&
 		test_when_finished "rm 000?-*" &&
 		test_line_count = 5 actual &&
 		test_i18ngrep "^Range-diff:$" 0000-* &&
@@ -511,19 +511,19 @@ test_expect_success 'range-diff overrides diff.noprefix internally' '
 
 test_expect_success 'basic with modified format.pretty with suffix' '
 	git -c format.pretty="format:commit %H%d%n" range-diff \
-		master..topic master..unmodified
+		main..topic main..unmodified
 '
 
 test_expect_success 'basic with modified format.pretty without "commit "' '
 	git -c format.pretty="format:%H%n" range-diff \
-		master..topic master..unmodified
+		main..topic main..unmodified
 '
 
 test_expect_success 'range-diff compares notes by default' '
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
 	test_when_finished git notes remove topic unmodified &&
-	git range-diff --no-color master..topic master..unmodified \
+	git range-diff --no-color main..topic main..unmodified \
 		>actual &&
 	sed s/Z/\ /g >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid u1) s/5/A/
@@ -547,7 +547,7 @@ test_expect_success 'range-diff with --no-notes' '
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
 	test_when_finished git notes remove topic unmodified &&
-	git range-diff --no-color --no-notes master..topic master..unmodified \
+	git range-diff --no-color --no-notes main..topic main..unmodified \
 		>actual &&
 	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid u1) s/5/A/
@@ -565,7 +565,7 @@ test_expect_success 'range-diff with multiple --notes' '
 	git notes --ref=note2 add -m "topic note2" topic &&
 	git notes --ref=note2 add -m "unmodified note2" unmodified &&
 	test_when_finished git notes --ref=note2 remove topic unmodified &&
-	git range-diff --no-color --notes=note1 --notes=note2 master..topic master..unmodified \
+	git range-diff --no-color --notes=note1 --notes=note2 main..topic main..unmodified \
 		>actual &&
 	sed s/Z/\ /g >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid u1) s/5/A/
@@ -595,7 +595,7 @@ test_expect_success 'format-patch --range-diff does not compare notes by default
 	git notes add -m "unmodified note" unmodified &&
 	test_when_finished git notes remove topic unmodified &&
 	git format-patch --cover-letter --range-diff=$prev \
-		master..unmodified >actual &&
+		main..unmodified >actual &&
 	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_i18ngrep "^Range-diff:$" 0000-* &&
@@ -612,7 +612,7 @@ test_expect_success 'format-patch --range-diff with --no-notes' '
 	git notes add -m "unmodified note" unmodified &&
 	test_when_finished git notes remove topic unmodified &&
 	git format-patch --no-notes --cover-letter --range-diff=$prev \
-		master..unmodified >actual &&
+		main..unmodified >actual &&
 	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_i18ngrep "^Range-diff:$" 0000-* &&
@@ -629,7 +629,7 @@ test_expect_success 'format-patch --range-diff with --notes' '
 	git notes add -m "unmodified note" unmodified &&
 	test_when_finished git notes remove topic unmodified &&
 	git format-patch --notes --cover-letter --range-diff=$prev \
-		master..unmodified >actual &&
+		main..unmodified >actual &&
 	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_i18ngrep "^Range-diff:$" 0000-* &&
@@ -658,7 +658,7 @@ test_expect_success 'format-patch --range-diff with format.notes config' '
 	test_when_finished git notes remove topic unmodified &&
 	test_config format.notes true &&
 	git format-patch --cover-letter --range-diff=$prev \
-		master..unmodified >actual &&
+		main..unmodified >actual &&
 	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_i18ngrep "^Range-diff:$" 0000-* &&
@@ -689,7 +689,7 @@ test_expect_success 'format-patch --range-diff with multiple notes' '
 	git notes --ref=note2 add -m "unmodified note2" unmodified &&
 	test_when_finished git notes --ref=note2 remove topic unmodified &&
 	git format-patch --notes=note1 --notes=note2 --cover-letter --range-diff=$prev \
-		master..unmodified >actual &&
+		main..unmodified >actual &&
 	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_i18ngrep "^Range-diff:$" 0000-* &&
diff --git a/t/t3206/history.export b/t/t3206/history.export
index 4c808e5b3b..4485adc37b 100644
--- a/t/t3206/history.export
+++ b/t/t3206/history.export
@@ -168,7 +168,7 @@ mark :11
 data 10
 unrelated
 
-commit refs/heads/master
+commit refs/heads/main
 mark :12
 author Thomas Rast <trast@inf.ethz.ch> 1374485127 +0200
 committer Thomas Rast <trast@inf.ethz.ch> 1374485127 +0200
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index f41b2afb99..a0b188fa4d 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -135,7 +135,7 @@ test_expect_success 'delete ref with dangling packed version' '
 	git commit --allow-empty -m "future garbage" &&
 	git pack-refs --all &&
 	git reset --hard HEAD^ &&
-	git checkout master &&
+	git checkout main &&
 	git reflog expire --expire=all --all &&
 	git prune --expire=all &&
 	git branch -d lamb 2>result &&
@@ -240,7 +240,7 @@ test_expect_success 'retry acquiring packed-refs.lock' '
 
 test_expect_success SYMLINKS 'pack symlinked packed-refs' '
 	# First make sure that symlinking works when reading:
-	git update-ref refs/heads/lossy refs/heads/master &&
+	git update-ref refs/heads/lossy refs/heads/main &&
 	git for-each-ref >all-refs-before &&
 	mv .git/packed-refs .git/my-deviant-packed-refs &&
 	ln -s my-deviant-packed-refs .git/packed-refs &&
diff --git a/t/t3211-peel-ref.sh b/t/t3211-peel-ref.sh
index 3b7caca421..73a914d194 100755
--- a/t/t3211-peel-ref.sh
+++ b/t/t3211-peel-ref.sh
@@ -19,7 +19,7 @@ print_ref() {
 
 test_expect_success 'set up expected show-ref output' '
 	{
-		print_ref "refs/heads/master" &&
+		print_ref "refs/heads/main" &&
 		print_ref "refs/outside/foo" &&
 		print_ref "refs/outside/foo^{}" &&
 		print_ref "refs/tags/base" &&
@@ -47,7 +47,7 @@ test_expect_success 'create old-style pack-refs without fully-peeled' '
 	# know we are emulating exactly what an older git would have written.
 	{
 		echo "# pack-refs with: peeled " &&
-		print_ref "refs/heads/master" &&
+		print_ref "refs/heads/main" &&
 		print_ref "refs/outside/foo" &&
 		print_ref "refs/tags/base" &&
 		print_ref "refs/tags/foo" &&
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 8f43303007..2b685580b6 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1295,11 +1295,11 @@ test_expect_success 'git notes copy diagnoses too many or too few parameters' '
 	test_i18ngrep "too many parameters" error
 '
 
-test_expect_success 'git notes get-ref expands refs/heads/master to refs/notes/refs/heads/master' '
+test_expect_success 'git notes get-ref expands refs/heads/main to refs/notes/refs/heads/main' '
 	test_unconfig core.notesRef &&
 	sane_unset GIT_NOTES_REF &&
-	echo refs/notes/refs/heads/master >expect &&
-	git notes --ref=refs/heads/master get-ref >actual &&
+	echo refs/notes/refs/heads/main >expect &&
+	git notes --ref=refs/heads/main get-ref >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-expensive.sh
index 7217c5e222..1c1490ca68 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -20,7 +20,7 @@ create_repo () {
 			notemark=$(($mark+1))
 			test_tick &&
 			cat <<-INPUT_END &&
-			commit refs/heads/master
+			commit refs/heads/main
 			mark :$mark
 			committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 			data <<COMMIT
diff --git a/t/t3303-notes-subtrees.sh b/t/t3303-notes-subtrees.sh
index 704aee81ef..d994492469 100755
--- a/t/t3303-notes-subtrees.sh
+++ b/t/t3303-notes-subtrees.sh
@@ -40,7 +40,7 @@ test_expect_success "setup: create $number_of_commits commits" '
 			nr=$(($nr+1)) &&
 			test_tick &&
 			cat <<INPUT_END
-commit refs/heads/master
+commit refs/heads/main
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
 commit #$nr
@@ -75,7 +75,7 @@ test_sha1_based () {
 	(
 		start_note_commit &&
 		nr=$number_of_commits &&
-		git rev-list refs/heads/master |
+		git rev-list refs/heads/main |
 		while read sha1; do
 			note_path=$(echo "$sha1" | sed "$1")
 			cat <<INPUT_END &&
@@ -105,7 +105,7 @@ test_same_notes () {
 	(
 		start_note_commit &&
 		nr=$number_of_commits &&
-		git rev-list refs/heads/master |
+		git rev-list refs/heads/main |
 		while read sha1; do
 			first_note_path=$(echo "$sha1" | sed "$1")
 			second_note_path=$(echo "$sha1" | sed "$2")
@@ -144,7 +144,7 @@ test_concatenated_notes () {
 	(
 		start_note_commit &&
 		nr=$number_of_commits &&
-		git rev-list refs/heads/master |
+		git rev-list refs/heads/main |
 		while read sha1; do
 			first_note_path=$(echo "$sha1" | sed "$1")
 			second_note_path=$(echo "$sha1" | sed "$2")
diff --git a/t/t3304-notes-mixed.sh b/t/t3304-notes-mixed.sh
index 1709e8c00b..802e004016 100755
--- a/t/t3304-notes-mixed.sh
+++ b/t/t3304-notes-mixed.sh
@@ -36,7 +36,7 @@ test_expect_success "setup: create a couple of commits" '
 
 	test_tick &&
 	cat <<INPUT_END >input &&
-commit refs/heads/master
+commit refs/heads/main
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
 commit #1
@@ -51,7 +51,7 @@ INPUT_END
 
 	test_tick &&
 	cat <<INPUT_END >>input &&
-commit refs/heads/master
+commit refs/heads/main
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
 commit #2
@@ -68,8 +68,8 @@ INPUT_END
 
 test_expect_success "create a notes tree with both notes and non-notes" '
 
-	commit1=$(git rev-parse refs/heads/master^) &&
-	commit2=$(git rev-parse refs/heads/master) &&
+	commit1=$(git rev-parse refs/heads/main^) &&
+	commit2=$(git rev-parse refs/heads/main) &&
 	test_tick &&
 	cat <<INPUT_END >input &&
 commit refs/notes/commits
diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
index d69c84c640..202702be1a 100755
--- a/t/t3308-notes-merge.sh
+++ b/t/t3308-notes-merge.sh
@@ -108,7 +108,7 @@ test_expect_success 'fail to merge into various non-notes refs' '
 	git update-ref refs/notes/dir/foo HEAD &&
 	test_must_fail git -c "core.notesRef=refs/notes/dir" notes merge x &&
 	test_must_fail git -c "core.notesRef=refs/notes/dir/" notes merge x &&
-	test_must_fail git -c "core.notesRef=refs/heads/master" notes merge x &&
+	test_must_fail git -c "core.notesRef=refs/heads/main" notes merge x &&
 	test_must_fail git -c "core.notesRef=refs/notes/y:" notes merge x &&
 	test_must_fail git -c "core.notesRef=refs/notes/y:foo" notes merge x &&
 	test_must_fail git -c "core.notesRef=refs/notes/foo^{bar" notes merge x
diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-worktrees.sh
index 823fdbda1f..465145c487 100755
--- a/t/t3320-notes-merge-worktrees.sh
+++ b/t/t3320-notes-merge-worktrees.sh
@@ -36,8 +36,8 @@ test_expect_success 'modify notes ref ourselves (x)' '
 '
 
 test_expect_success 'create some new worktrees' '
-	git worktree add -b newbranch worktree master &&
-	git worktree add -b newbranch2 worktree2 master
+	git worktree add -b newbranch worktree main &&
+	git worktree add -b newbranch2 worktree2 main
 '
 
 test_expect_success 'merge z into y fails and sets NOTES_MERGE_REF' '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3bb6675390..c464f8dcc8 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -257,7 +257,7 @@ case "$TRASH_DIRECTORY" in
 esac
 
 case "$TEST_NUMBER" in
-[0-2]*)
+[0-2]*|3[0-3]*)
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-- 
gitgitgadget


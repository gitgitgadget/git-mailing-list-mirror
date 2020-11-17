Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2351C83011
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 580CE2465E
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmzQyPVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgKQQNF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 11:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbgKQQMw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 11:12:52 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0189C0617A7
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:50 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k2so23788849wrx.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9KlyTqv5lTt+rxG6aB0CkRbPxttmztvLby+Z0FlVzSM=;
        b=jmzQyPVGpxunh23ASktI2T7ELy88lhZxL+7eT0ux/UXOblDRWb+WLSlgOxi3ugX8L/
         lasQicYn6XMNKUmXzPEqfyu9kk6iG6bNvPyWY7x3vCSkUPPD2zdTIYIn/x1WLxSEe7Tp
         n3WYsKGqUAL61396A8NtTITZU9LPgxVNS6pqeApEwSEfqJqpgkhEakYOEX+cUhl3cmab
         1urQwd1rQ5bdcMDtQWB7C8PMFh1qYTPSRGbb4khcvtRB+YpRdUz+XDD6G0NYtqzHQl77
         JQrewpzWogzmQ/7xuTySE1zMJ8tTakVsJNiGXK9IslMv5e4/Rd2oWHQV3zrEpjgkfMQH
         RJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9KlyTqv5lTt+rxG6aB0CkRbPxttmztvLby+Z0FlVzSM=;
        b=BEvicpLQux9BwX+fSVFbXg7qCsQP0lCmRuukhIYv+jjSCDNVwUoFw3ruKCTjWsn+uc
         iFcsBiR1pP6m60BdDRgvGU7RWVZEt9RGwfCC6+ZcCJYr4rVAiAvs3un4MW6H60hzI08/
         /4LAoI45Za1+6uP4R5I2pInAXUrBYUa83aDwJvxxGUpJB7ZrIBQ7is9+r0Lm3Bmha0Pk
         Aw8THUHu5fvUU/+AEyTQ8XvWvtzUNOb9sARRXSDO4ulnzy/Ug0kOMDxqUciPaqW83a95
         fxPyZ7NIfgtRZZ3KjL0J180pNOvS7lKt+YZwgMeAeHbKSwfkFEc/jz8uLz8sgPlobycH
         RhxQ==
X-Gm-Message-State: AOAM531jA7fZ4GPuguWQFV8YXSg7ccQMftbTJb/Ikfsk60vxWaqKA6P2
        K26qZMMDH2B2oBO0nA0OnFh3O341g4Q=
X-Google-Smtp-Source: ABdhPJzgjnF7oBX7x/X4Qcv1lrkv8Dh0EkuS4xeIrzyM9nU9oVf1R1VEZip0QV2EzDxOrGuYwjKD4Q==
X-Received: by 2002:adf:f208:: with SMTP id p8mr281832wro.280.1605629568724;
        Tue, 17 Nov 2020 08:12:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10sm27612119wrv.77.2020.11.17.08.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 08:12:48 -0800 (PST)
Message-Id: <f9c30dc516e8462d7b653484dd6d91421162ace8.1605629549.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 16:12:20 +0000
Subject: [PATCH v2 20/27] t7[0-4]*: adjust the references to the default
 branch name "main"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Carefully excluding t7064, which sees independent development elsewhere
at the time of writing, we use `main` as the default branch name in
t7[0-4]*. This trick was performed via

	$ (cd t &&
	   sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
		-e 's/Master/Main/g' -- t7[0-4]*.sh &&
	   git checkout HEAD -- t7064\*)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7003-filter-branch.sh                |  40 ++++-----
 t/t7004-tag.sh                          |   8 +-
 t/t7030-verify-tag.sh                   |   2 +-
 t/t7060-wtstatus.sh                     |  26 +++---
 t/t7063-status-untracked-cache.sh       |  14 +--
 t/t7102-reset.sh                        |   6 +-
 t/t7113-post-index-change-hook.sh       |   2 +-
 t/t7201-co.sh                           | 110 ++++++++++++------------
 t/t7400-submodule-basic.sh              |  20 ++---
 t/t7403-submodule-sync.sh               |  10 +--
 t/t7406-submodule-update.sh             |  38 ++++----
 t/t7407-submodule-foreach.sh            |  24 +++---
 t/t7409-submodule-detached-work-tree.sh |   8 +-
 t/t7417-submodule-path-url.sh           |   2 +-
 t/test-lib.sh                           |   4 +-
 15 files changed, 157 insertions(+), 157 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 36477cb1f4..e8df682c8d 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -13,7 +13,7 @@ test_expect_success 'setup' '
 	mkdir dir &&
 	test_commit dir/D &&
 	test_commit E &&
-	git checkout master &&
+	git checkout main &&
 	test_commit C &&
 	git checkout branch &&
 	git merge C &&
@@ -25,7 +25,7 @@ test_expect_success 'setup' '
 # * G
 # *   Merge commit 'C' into branch
 # |\
-# | * (master) C
+# | * (main) C
 # * | E
 # * | dir/D
 # * | D
@@ -162,15 +162,15 @@ test_expect_success 'subdirectory filter result looks okay' '
 '
 
 test_expect_success 'more setup' '
-	git checkout master &&
+	git checkout main &&
 	mkdir subdir &&
 	echo A > subdir/new &&
 	git add subdir/new &&
 	test_tick &&
-	git commit -m "subdir on master" subdir/new &&
+	git commit -m "subdir on main" subdir/new &&
 	git rm A.t &&
 	test_tick &&
-	git commit -m "again subdir on master" &&
+	git commit -m "again subdir on main" &&
 	git merge branch
 '
 
@@ -199,7 +199,7 @@ test_expect_success 'author information is preserved' '
 	git branch preserved-author &&
 	(sane_unset GIT_AUTHOR_NAME &&
 	 git filter-branch -f --msg-filter "cat; \
-			test \$GIT_COMMIT != $(git rev-parse master) || \
+			test \$GIT_COMMIT != $(git rev-parse main) || \
 			echo Hallo" \
 		preserved-author) &&
 	git rev-list --author="B V Uips" preserved-author >actual &&
@@ -218,7 +218,7 @@ test_expect_success "remove a certain author's commits" '
 		else\
 			git commit-tree \"\$@\";\
 		fi" removed-author &&
-	cnt1=$(git rev-list master | wc -l) &&
+	cnt1=$(git rev-list main | wc -l) &&
 	cnt2=$(git rev-list removed-author | wc -l) &&
 	test $cnt1 -eq $(($cnt2 + 1)) &&
 	git rev-list --author="B V Uips" removed-author >actual &&
@@ -226,7 +226,7 @@ test_expect_success "remove a certain author's commits" '
 '
 
 test_expect_success 'barf on invalid name' '
-	test_must_fail git filter-branch -f master xy-problem &&
+	test_must_fail git filter-branch -f main xy-problem &&
 	test_must_fail git filter-branch -f HEAD^
 '
 
@@ -236,8 +236,8 @@ test_expect_success '"map" works in commit filter' '
 		mapped=\$(map \$parent) &&
 		actual=\$(echo \"\$@\" | sed \"s/^.*-p //\") &&
 		test \$mapped = \$actual &&
-		git commit-tree \"\$@\";" master~2..master &&
-	git rev-parse --verify master
+		git commit-tree \"\$@\";" main~2..main &&
+	git rev-parse --verify main
 '
 
 test_expect_success 'Name needing quotes' '
@@ -256,7 +256,7 @@ test_expect_success 'Name needing quotes' '
 
 test_expect_success 'Subdirectory filter with disappearing trees' '
 	git reset --hard &&
-	git checkout master &&
+	git checkout main &&
 
 	mkdir foo &&
 	touch foo/bar &&
@@ -275,7 +275,7 @@ test_expect_success 'Subdirectory filter with disappearing trees' '
 	git commit -m "Re-adding foo" &&
 
 	git filter-branch -f --subdirectory-filter foo &&
-	git rev-list master >actual &&
+	git rev-list main >actual &&
 	test_line_count = 3 actual
 '
 
@@ -332,7 +332,7 @@ test_expect_success 'Tag name filtering allows slashes in tag names' '
 	test_cmp expect actual
 '
 test_expect_success 'setup --prune-empty comparisons' '
-	git checkout --orphan master-no-a &&
+	git checkout --orphan main-no-a &&
 	git rm -rf . &&
 	unset test_tick &&
 	test_tick &&
@@ -343,7 +343,7 @@ test_expect_success 'setup --prune-empty comparisons' '
 	mkdir dir &&
 	test_commit dir/D dir/D.t dir/D dir/Dx &&
 	test_commit E E.t E Ex &&
-	git checkout master-no-a &&
+	git checkout main-no-a &&
 	test_commit C C.t C Cx &&
 	git checkout branch-no-a &&
 	git merge Cx -m "Merge tag '\''C'\'' into branch" &&
@@ -397,7 +397,7 @@ test_expect_success '--prune-empty is able to prune entire branch' '
 '
 
 test_expect_success '--remap-to-ancestor with filename filters' '
-	git checkout master &&
+	git checkout main &&
 	git reset --hard A &&
 	test_commit add-foo foo 1 &&
 	git branch moved-foo &&
@@ -407,15 +407,15 @@ test_expect_success '--remap-to-ancestor with filename filters' '
 	git branch moved-bar &&
 	test_commit change-foo foo 2 &&
 	git filter-branch -f --remap-to-ancestor \
-		moved-foo moved-bar A..master \
+		moved-foo moved-bar A..main \
 		-- -- foo &&
 	test $(git rev-parse moved-foo) = $(git rev-parse moved-bar) &&
-	test $(git rev-parse moved-foo) = $(git rev-parse master^) &&
+	test $(git rev-parse moved-foo) = $(git rev-parse main^) &&
 	test $orig_invariant = $(git rev-parse invariant)
 '
 
 test_expect_success 'automatic remapping to ancestor with filename filters' '
-	git checkout master &&
+	git checkout main &&
 	git reset --hard A &&
 	test_commit add-foo2 foo 1 &&
 	git branch moved-foo2 &&
@@ -425,10 +425,10 @@ test_expect_success 'automatic remapping to ancestor with filename filters' '
 	git branch moved-bar2 &&
 	test_commit change-foo2 foo 2 &&
 	git filter-branch -f \
-		moved-foo2 moved-bar2 A..master \
+		moved-foo2 moved-bar2 A..main \
 		-- -- foo &&
 	test $(git rev-parse moved-foo2) = $(git rev-parse moved-bar2) &&
-	test $(git rev-parse moved-foo2) = $(git rev-parse master^) &&
+	test $(git rev-parse moved-foo2) = $(git rev-parse main^) &&
 	test $orig_invariant = $(git rev-parse invariant2)
 '
 
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 05f411c821..630fcde90b 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1583,7 +1583,7 @@ test_expect_success 'checking that branch head with --no-contains lists all but
 "
 
 test_expect_success 'merging original branch into this branch' '
-	git merge --strategy=ours master &&
+	git merge --strategy=ours main &&
         git tag v4.0
 '
 
@@ -1944,15 +1944,15 @@ test_expect_success ULIMIT_STACK_SIZE '--contains and --no-contains work in a de
 	i=1 &&
 	while test $i -lt 8000
 	do
-		echo "commit refs/heads/master
+		echo "commit refs/heads/main
 committer A U Thor <author@example.com> $((1000000000 + $i * 100)) +0200
 data <<EOF
 commit #$i
 EOF"
-		test $i = 1 && echo "from refs/heads/master^0"
+		test $i = 1 && echo "from refs/heads/main^0"
 		i=$(($i + 1))
 	done | git fast-import &&
-	git checkout master &&
+	git checkout main &&
 	git tag far-far-away HEAD^ &&
 	run_with_limited_stack git tag --contains HEAD >actual &&
 	test_must_be_empty actual &&
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 5c5bc32ccb..7a70df79a2 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -17,7 +17,7 @@ test_expect_success GPG 'create signed tags' '
 	echo 3 >elif && git add elif &&
 	test_tick && git commit -m "third on side" &&
 
-	git checkout master &&
+	git checkout main &&
 	test_tick && git merge -S side &&
 	git tag -s -m merge merge &&
 
diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index d5218743e9..cb4e104e4b 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -51,7 +51,7 @@ EOF
 		git checkout -b side HEAD^ &&
 		git rm foo &&
 		git commit -m delete &&
-		test_must_fail git merge master &&
+		test_must_fail git merge main &&
 		test_must_fail git commit --dry-run >../actual &&
 		test_i18ncmp ../expect ../actual &&
 		git status >../actual &&
@@ -124,18 +124,18 @@ test_expect_success 'git diff-index --cached -C shows 2 copies + 1 unmerged' '
 
 test_expect_success 'status when conflicts with add and rm advice (deleted by them)' '
 	git reset --hard &&
-	git checkout master &&
+	git checkout main &&
 	test_commit init main.txt init &&
 	git checkout -b second_branch &&
 	git rm main.txt &&
 	git commit -m "main.txt deleted on second_branch" &&
 	test_commit second conflict.txt second &&
-	git checkout master &&
+	git checkout main &&
 	test_commit on_second main.txt on_second &&
-	test_commit master conflict.txt master &&
+	test_commit main conflict.txt main &&
 	test_must_fail git merge second_branch &&
 	cat >expected <<\EOF &&
-On branch master
+On branch main
 You have unmerged paths.
   (fix conflicts and run "git commit")
   (use "git merge --abort" to abort the merge)
@@ -157,8 +157,8 @@ test_expect_success 'prepare for conflicts' '
 	git checkout -b conflict &&
 	test_commit one main.txt one &&
 	git branch conflict_second &&
-	git mv main.txt sub_master.txt &&
-	git commit -m "main.txt renamed in sub_master.txt" &&
+	git mv main.txt sub_main.txt &&
+	git commit -m "main.txt renamed in sub_main.txt" &&
 	git checkout conflict_second &&
 	git mv main.txt sub_second.txt &&
 	git commit -m "main.txt renamed in sub_second.txt"
@@ -176,7 +176,7 @@ You have unmerged paths.
 Unmerged paths:
   (use "git add/rm <file>..." as appropriate to mark resolution)
 	both deleted:    main.txt
-	added by them:   sub_master.txt
+	added by them:   sub_main.txt
 	added by us:     sub_second.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
@@ -189,7 +189,7 @@ EOF
 test_expect_success 'status when conflicts with only rm advice (both deleted)' '
 	git reset --hard conflict_second &&
 	test_must_fail git merge conflict &&
-	git add sub_master.txt &&
+	git add sub_main.txt &&
 	git add sub_second.txt &&
 	cat >expected <<\EOF &&
 On branch conflict_second
@@ -198,7 +198,7 @@ You have unmerged paths.
   (use "git merge --abort" to abort the merge)
 
 Changes to be committed:
-	new file:   sub_master.txt
+	new file:   sub_main.txt
 
 Unmerged paths:
   (use "git rm <file>..." to mark resolution)
@@ -209,12 +209,12 @@ EOF
 	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual &&
 	git reset --hard &&
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'status --branch with detached HEAD' '
 	git reset --hard &&
-	git checkout master^0 &&
+	git checkout main^0 &&
 	git status --branch --porcelain >actual &&
 	cat >expected <<-EOF &&
 	## HEAD (no branch)
@@ -230,7 +230,7 @@ test_expect_success 'status --branch with detached HEAD' '
 ## Duplicate the above test and verify --porcelain=v1 arg parsing.
 test_expect_success 'status --porcelain=v1 --branch with detached HEAD' '
 	git reset --hard &&
-	git checkout master^0 &&
+	git checkout main^0 &&
 	git status --branch --porcelain=v1 >actual &&
 	cat >expected <<-EOF &&
 	## HEAD (no branch)
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index a682a3d826..3b41d563d5 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -475,7 +475,7 @@ EOF
 test_expect_success 'set up sparse checkout' '
 	echo "done/[a-z]*" >.git/info/sparse-checkout &&
 	test_config core.sparsecheckout true &&
-	git checkout master &&
+	git checkout main &&
 	git update-index --force-untracked-cache &&
 	git status --porcelain >/dev/null && # prime the cache
 	test_path_is_missing done/.gitignore &&
@@ -734,13 +734,13 @@ test_expect_success 'test ident field is working' '
 test_expect_success 'untracked cache survives a checkout' '
 	git commit --allow-empty -m empty &&
 	test-tool dump-untracked-cache >../before &&
-	test_when_finished  "git checkout master" &&
+	test_when_finished  "git checkout main" &&
 	git checkout -b other_branch &&
 	test-tool dump-untracked-cache >../after &&
 	test_cmp ../before ../after &&
 	test_commit test &&
 	test-tool dump-untracked-cache >../before &&
-	git checkout master &&
+	git checkout main &&
 	test-tool dump-untracked-cache >../after &&
 	test_cmp ../before ../after
 '
@@ -775,7 +775,7 @@ test_expect_success SYMLINKS '"status" after symlink replacement should be clean
 	git checkout HEAD~ &&
 	status_is_clean &&
 	status_is_clean &&
-	git checkout master &&
+	git checkout main &&
 	avoid_racy &&
 	status_is_clean &&
 	status_is_clean
@@ -786,7 +786,7 @@ test_expect_success SYMLINKS '"status" after symlink replacement should be clean
 	git checkout HEAD~ &&
 	status_is_clean &&
 	status_is_clean &&
-	git checkout master &&
+	git checkout main &&
 	avoid_racy &&
 	status_is_clean &&
 	status_is_clean
@@ -810,7 +810,7 @@ test_expect_success '"status" after file replacement should be clean with UC=tru
 	git checkout HEAD~ &&
 	status_is_clean &&
 	status_is_clean &&
-	git checkout master &&
+	git checkout main &&
 	avoid_racy &&
 	status_is_clean &&
 	test-tool dump-untracked-cache >../actual &&
@@ -828,7 +828,7 @@ test_expect_success '"status" after file replacement should be clean with UC=fal
 	git checkout HEAD~ &&
 	status_is_clean &&
 	status_is_clean &&
-	git checkout master &&
+	git checkout main &&
 	avoid_racy &&
 	status_is_clean &&
 	status_is_clean
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index b1affb001f..9dfed50354 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -145,7 +145,7 @@ test_expect_success 'trying to do reset --soft with pending merge should fail' '
 	printf "1st line 2nd file\n2nd line 2nd file\n3rd line" >secondfile &&
 	git commit -a -m "the change in branch2" &&
 
-	git checkout master &&
+	git checkout main &&
 	git branch -D branch1 branch2 &&
 	check_changes $head5
 '
@@ -167,7 +167,7 @@ test_expect_success 'trying to do reset --soft with pending checkout merge shoul
 	printf "1st line 2nd file\n2nd line 2nd file\n3rd line" >secondfile &&
 	git commit -a -m "the line in branch3" &&
 
-	git checkout master &&
+	git checkout main &&
 	git branch -D branch3 branch4 &&
 	check_changes $head5
 '
@@ -380,7 +380,7 @@ test_expect_success '--hard reset to ORIG_HEAD should clear a fast-forward merge
 	git reset --hard ORIG_HEAD &&
 	check_changes $head5 &&
 
-	git checkout master &&
+	git checkout main &&
 	git branch -D branch1 branch2 &&
 	check_changes $head5
 '
diff --git a/t/t7113-post-index-change-hook.sh b/t/t7113-post-index-change-hook.sh
index f011ad7eec..2e38428176 100755
--- a/t/t7113-post-index-change-hook.sh
+++ b/t/t7113-post-index-change-hook.sh
@@ -85,7 +85,7 @@ test_expect_success 'test checkout and reset trigger the hook' '
 	EOF
 	: force index to be dirty &&
 	test-tool chmtime +60 dir1/file1.txt &&
-	git checkout master &&
+	git checkout main &&
 	test_path_is_file testsuccess && rm -f testsuccess &&
 	test_path_is_missing testfailure &&
 	test-tool chmtime +60 dir1/file1.txt &&
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index b36a93056f..3ab219a04e 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -5,10 +5,10 @@
 
 test_description='git checkout tests.
 
-Creates master, forks renamer and side branches from it.
+Creates main, forks renamer and side branches from it.
 Test switching across them.
 
-  ! [master] Initial A one, A two
+  ! [main] Initial A one, A two
    * [renamer] Renamer R one->uno, M two
     ! [side] Side M one, D two, A three
      ! [simple] Simple D one, M two
@@ -16,7 +16,7 @@ Test switching across them.
      + [simple] Simple D one, M two
     +  [side] Side M one, D two, A three
    *   [renamer] Renamer R one->uno, M two
-  +*++ [master] Initial A one, A two
+  +*++ [main] Initial A one, A two
 
 '
 
@@ -46,27 +46,27 @@ test_expect_success setup '
 	fill a b c d e f >two &&
 	git commit -a -m "Renamer R one->uno, M two" &&
 
-	git checkout -b side master &&
+	git checkout -b side main &&
 	fill 1 2 3 4 5 6 7 >one &&
 	fill A B C D E >three &&
 	rm -f two &&
 	git update-index --add --remove one two three &&
 	git commit -m "Side M one, D two, A three" &&
 
-	git checkout -b simple master &&
+	git checkout -b simple main &&
 	rm -f one &&
 	fill a c e >two &&
 	git commit -a -m "Simple D one, M two" &&
 
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'checkout from non-existing branch' '
-	git checkout -b delete-me master &&
+	git checkout -b delete-me main &&
 	git update-ref -d --no-deref refs/heads/delete-me &&
 	test refs/heads/delete-me = "$(git symbolic-ref HEAD)" &&
-	git checkout master &&
-	test refs/heads/master = "$(git symbolic-ref HEAD)"
+	git checkout main &&
+	test refs/heads/main = "$(git symbolic-ref HEAD)"
 '
 
 test_expect_success 'checkout with dirty tree without -m' '
@@ -81,7 +81,7 @@ test_expect_success 'checkout with dirty tree without -m' '
 '
 
 test_expect_success 'checkout with unrelated dirty tree without -m' '
-	git checkout -f master &&
+	git checkout -f main &&
 	fill 0 1 2 3 4 5 6 7 8 >same &&
 	cp same kept &&
 	git checkout side >messages &&
@@ -91,7 +91,7 @@ test_expect_success 'checkout with unrelated dirty tree without -m' '
 '
 
 test_expect_success 'checkout -m with dirty tree' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git clean -f &&
 
 	fill 0 1 2 3 4 5 6 7 8 >one &&
@@ -102,9 +102,9 @@ test_expect_success 'checkout -m with dirty tree' '
 	printf "M\t%s\n" one >expect.messages &&
 	test_cmp expect.messages messages &&
 
-	fill "M	one" "A	three" "D	two" >expect.master &&
-	git diff --name-status master >current.master &&
-	test_cmp expect.master current.master &&
+	fill "M	one" "A	three" "D	two" >expect.main &&
+	git diff --name-status main >current.main &&
+	test_cmp expect.main current.main &&
 
 	fill "M	one" >expect.side &&
 	git diff --name-status side >current.side &&
@@ -115,7 +115,7 @@ test_expect_success 'checkout -m with dirty tree' '
 '
 
 test_expect_success 'checkout -m with dirty tree, renamed' '
-	git checkout -f master && git clean -f &&
+	git checkout -f main && git clean -f &&
 
 	fill 1 2 3 4 5 7 8 >one &&
 	if git checkout renamer
@@ -135,7 +135,7 @@ test_expect_success 'checkout -m with dirty tree, renamed' '
 '
 
 test_expect_success 'checkout -m with merge conflict' '
-	git checkout -f master && git clean -f &&
+	git checkout -f main && git clean -f &&
 
 	fill 1 T 3 4 5 6 S 8 >one &&
 	if git checkout renamer
@@ -148,7 +148,7 @@ test_expect_success 'checkout -m with merge conflict' '
 
 	git checkout -m renamer &&
 
-	git diff master:one :3:uno |
+	git diff main:one :3:uno |
 	sed -e "1,/^@@/d" -e "/^ /d" -e "s/^-/d/" -e "s/^+/a/" >current &&
 	fill d2 aT d7 aS >expect &&
 	test_cmp expect current &&
@@ -157,7 +157,7 @@ test_expect_success 'checkout -m with merge conflict' '
 '
 
 test_expect_success 'format of merge conflict from checkout -m' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git clean -f &&
 
 	fill b d >two &&
@@ -181,7 +181,7 @@ test_expect_success 'format of merge conflict from checkout -m' '
 '
 
 test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard &&
 	git clean -f &&
 
@@ -193,7 +193,7 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
 	a
 	c
 	e
-	||||||| master
+	||||||| main
 	a
 	b
 	c
@@ -208,7 +208,7 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
 '
 
 test_expect_success 'switch to another branch while carrying a deletion' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git reset --hard &&
 	git clean -f &&
 	git rm two &&
@@ -229,7 +229,7 @@ test_expect_success 'checkout to detach HEAD (with advice declined)' '
 	test_i18ngrep "HEAD is now at $rev" messages &&
 	test_line_count = 1 messages &&
 	H=$(git rev-parse --verify HEAD) &&
-	M=$(git show-ref -s --verify refs/heads/master) &&
+	M=$(git show-ref -s --verify refs/heads/main) &&
 	test "z$H" = "z$M" &&
 	if git symbolic-ref HEAD >/dev/null 2>&1
 	then
@@ -249,7 +249,7 @@ test_expect_success 'checkout to detach HEAD' '
 	grep "HEAD is now at $rev" messages &&
 	test_line_count -gt 1 messages &&
 	H=$(git rev-parse --verify HEAD) &&
-	M=$(git show-ref -s --verify refs/heads/master) &&
+	M=$(git show-ref -s --verify refs/heads/main) &&
 	test "z$H" = "z$M" &&
 	if git symbolic-ref HEAD >/dev/null 2>&1
 	then
@@ -261,11 +261,11 @@ test_expect_success 'checkout to detach HEAD' '
 '
 
 test_expect_success 'checkout to detach HEAD with branchname^' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git clean -f &&
 	git checkout renamer^ &&
 	H=$(git rev-parse --verify HEAD) &&
-	M=$(git show-ref -s --verify refs/heads/master) &&
+	M=$(git show-ref -s --verify refs/heads/main) &&
 	test "z$H" = "z$M" &&
 	if git symbolic-ref HEAD >/dev/null 2>&1
 	then
@@ -277,11 +277,11 @@ test_expect_success 'checkout to detach HEAD with branchname^' '
 '
 
 test_expect_success 'checkout to detach HEAD with :/message' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git clean -f &&
 	git checkout ":/Initial" &&
 	H=$(git rev-parse --verify HEAD) &&
-	M=$(git show-ref -s --verify refs/heads/master) &&
+	M=$(git show-ref -s --verify refs/heads/main) &&
 	test "z$H" = "z$M" &&
 	if git symbolic-ref HEAD >/dev/null 2>&1
 	then
@@ -293,11 +293,11 @@ test_expect_success 'checkout to detach HEAD with :/message' '
 '
 
 test_expect_success 'checkout to detach HEAD with HEAD^0' '
-	git checkout -f master &&
+	git checkout -f main &&
 	git clean -f &&
 	git checkout HEAD^0 &&
 	H=$(git rev-parse --verify HEAD) &&
-	M=$(git show-ref -s --verify refs/heads/master) &&
+	M=$(git show-ref -s --verify refs/heads/main) &&
 	test "z$H" = "z$M" &&
 	if git symbolic-ref HEAD >/dev/null 2>&1
 	then
@@ -310,13 +310,13 @@ test_expect_success 'checkout to detach HEAD with HEAD^0' '
 
 test_expect_success 'checkout with ambiguous tag/branch names' '
 	git tag both side &&
-	git branch both master &&
+	git branch both main &&
 	git reset --hard &&
-	git checkout master &&
+	git checkout main &&
 
 	git checkout both &&
 	H=$(git rev-parse --verify HEAD) &&
-	M=$(git show-ref -s --verify refs/heads/master) &&
+	M=$(git show-ref -s --verify refs/heads/main) &&
 	test "z$H" = "z$M" &&
 	name=$(git symbolic-ref HEAD 2>/dev/null) &&
 	test "z$name" = zrefs/heads/both
@@ -324,12 +324,12 @@ test_expect_success 'checkout with ambiguous tag/branch names' '
 
 test_expect_success 'checkout with ambiguous tag/branch names' '
 	git reset --hard &&
-	git checkout master &&
+	git checkout main &&
 
 	git tag frotz side &&
-	git branch frotz master &&
+	git branch frotz main &&
 	git reset --hard &&
-	git checkout master &&
+	git checkout main &&
 
 	git checkout tags/frotz &&
 	H=$(git rev-parse --verify HEAD) &&
@@ -346,7 +346,7 @@ test_expect_success 'checkout with ambiguous tag/branch names' '
 
 test_expect_success 'switch branches while in subdirectory' '
 	git reset --hard &&
-	git checkout master &&
+	git checkout main &&
 
 	mkdir subs &&
 	git -C subs checkout side &&
@@ -362,7 +362,7 @@ test_expect_success 'checkout specific path while in subdirectory' '
 	git add subs/bero &&
 	git commit -m "add subs/bero" &&
 
-	git checkout master &&
+	git checkout main &&
 	mkdir -p subs &&
 	git -C subs checkout side -- bero &&
 	test -f subs/bero
@@ -370,7 +370,7 @@ test_expect_success 'checkout specific path while in subdirectory' '
 
 test_expect_success 'checkout w/--track sets up tracking' '
     git config branch.autosetupmerge false &&
-    git checkout master &&
+    git checkout main &&
     git checkout --track -b track1 &&
     test "$(git config branch.track1.remote)" &&
     test "$(git config branch.track1.merge)"
@@ -379,40 +379,40 @@ test_expect_success 'checkout w/--track sets up tracking' '
 test_expect_success 'checkout w/autosetupmerge=always sets up tracking' '
     test_when_finished git config branch.autosetupmerge false &&
     git config branch.autosetupmerge always &&
-    git checkout master &&
+    git checkout main &&
     git checkout -b track2 &&
     test "$(git config branch.track2.remote)" &&
     test "$(git config branch.track2.merge)"
 '
 
 test_expect_success 'checkout w/--track from non-branch HEAD fails' '
-    git checkout master^0 &&
+    git checkout main^0 &&
     test_must_fail git symbolic-ref HEAD &&
     test_must_fail git checkout --track -b track &&
     test_must_fail git rev-parse --verify track &&
     test_must_fail git symbolic-ref HEAD &&
-    test "z$(git rev-parse master^0)" = "z$(git rev-parse HEAD)"
+    test "z$(git rev-parse main^0)" = "z$(git rev-parse HEAD)"
 '
 
 test_expect_success 'checkout w/--track from tag fails' '
-    git checkout master^0 &&
+    git checkout main^0 &&
     test_must_fail git symbolic-ref HEAD &&
     test_must_fail git checkout --track -b track frotz &&
     test_must_fail git rev-parse --verify track &&
     test_must_fail git symbolic-ref HEAD &&
-    test "z$(git rev-parse master^0)" = "z$(git rev-parse HEAD)"
+    test "z$(git rev-parse main^0)" = "z$(git rev-parse HEAD)"
 '
 
 test_expect_success 'detach a symbolic link HEAD' '
-    git checkout master &&
+    git checkout main &&
     git config --bool core.prefersymlinkrefs yes &&
     git checkout side &&
-    git checkout master &&
+    git checkout main &&
     it=$(git symbolic-ref HEAD) &&
-    test "z$it" = zrefs/heads/master &&
-    here=$(git rev-parse --verify refs/heads/master) &&
+    test "z$it" = zrefs/heads/main &&
+    here=$(git rev-parse --verify refs/heads/main) &&
     git checkout side^ &&
-    test "z$(git rev-parse --verify refs/heads/master)" = "z$here"
+    test "z$(git rev-parse --verify refs/heads/main)" = "z$here"
 '
 
 test_expect_success 'checkout with --track fakes a sensible -b <name>' '
@@ -423,13 +423,13 @@ test_expect_success 'checkout with --track fakes a sensible -b <name>' '
     test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
     test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)" &&
 
-    git checkout master && git branch -D koala/bear &&
+    git checkout main && git branch -D koala/bear &&
 
     git checkout --track refs/remotes/origin/koala/bear &&
     test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
     test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)" &&
 
-    git checkout master && git branch -D koala/bear &&
+    git checkout main && git branch -D koala/bear &&
 
     git checkout --track remotes/origin/koala/bear &&
     test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
@@ -582,17 +582,17 @@ test_expect_success 'checkout --conflict=diff3' '
 '
 
 test_expect_success 'failing checkout -b should not break working tree' '
-	git reset --hard master &&
-	git symbolic-ref HEAD refs/heads/master &&
+	git reset --hard main &&
+	git symbolic-ref HEAD refs/heads/main &&
 	test_must_fail git checkout -b renamer side^ &&
-	test $(git symbolic-ref HEAD) = refs/heads/master &&
+	test $(git symbolic-ref HEAD) = refs/heads/main &&
 	git diff --exit-code &&
 	git diff --cached --exit-code
 '
 
 test_expect_success 'switch out of non-branch' '
-	git reset --hard master &&
-	git checkout master^0 &&
+	git reset --hard main &&
+	git checkout main^0 &&
 	echo modified >one &&
 	test_must_fail git checkout renamer 2>error.log &&
 	! grep "^Previous HEAD" error.log
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index fec7e0299d..ce320807d4 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -124,7 +124,7 @@ inspect() {
 }
 
 test_expect_success 'submodule add' '
-	echo "refs/heads/master" >expect &&
+	echo "refs/heads/main" >expect &&
 
 	(
 		cd addtest &&
@@ -223,7 +223,7 @@ test_expect_success 'submodule add --branch' '
 	echo "refs/heads/initial" >expect-head &&
 	cat <<-\EOF >expect-heads &&
 	refs/heads/initial
-	refs/heads/master
+	refs/heads/main
 	EOF
 
 	(
@@ -241,7 +241,7 @@ test_expect_success 'submodule add --branch' '
 '
 
 test_expect_success 'submodule add with ./ in path' '
-	echo "refs/heads/master" >expect &&
+	echo "refs/heads/main" >expect &&
 
 	(
 		cd addtest &&
@@ -257,7 +257,7 @@ test_expect_success 'submodule add with ./ in path' '
 '
 
 test_expect_success 'submodule add with /././ in path' '
-	echo "refs/heads/master" >expect &&
+	echo "refs/heads/main" >expect &&
 
 	(
 		cd addtest &&
@@ -273,7 +273,7 @@ test_expect_success 'submodule add with /././ in path' '
 '
 
 test_expect_success 'submodule add with // in path' '
-	echo "refs/heads/master" >expect &&
+	echo "refs/heads/main" >expect &&
 
 	(
 		cd addtest &&
@@ -289,7 +289,7 @@ test_expect_success 'submodule add with // in path' '
 '
 
 test_expect_success 'submodule add with /.. in path' '
-	echo "refs/heads/master" >expect &&
+	echo "refs/heads/main" >expect &&
 
 	(
 		cd addtest &&
@@ -305,7 +305,7 @@ test_expect_success 'submodule add with /.. in path' '
 '
 
 test_expect_success 'submodule add with ./, /.. and // in path' '
-	echo "refs/heads/master" >expect &&
+	echo "refs/heads/main" >expect &&
 
 	(
 		cd addtest &&
@@ -335,7 +335,7 @@ test_expect_success !CYGWIN 'submodule add with \\ in path' '
 '
 
 test_expect_success 'submodule add in subdirectory' '
-	echo "refs/heads/master" >expect &&
+	echo "refs/heads/main" >expect &&
 
 	mkdir addtest/sub &&
 	(
@@ -557,7 +557,7 @@ test_expect_success 'status should be "up-to-date" after update' '
 
 test_expect_success 'checkout superproject with subproject already present' '
 	git checkout initial &&
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'apply submodule diff' '
@@ -574,7 +574,7 @@ test_expect_success 'apply submodule diff' '
 	git checkout second &&
 	git apply --index P.diff &&
 
-	git diff --cached master >staged &&
+	git diff --cached main >staged &&
 	test_must_be_empty staged
 '
 
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 0726799e74..848d4e7db7 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -78,7 +78,7 @@ test_expect_success 'change submodule url' '
 	(
 		cd super &&
 		cd submodule &&
-		git checkout master &&
+		git checkout main &&
 		git pull
 	) &&
 	mv submodule moved-submodule &&
@@ -112,7 +112,7 @@ test_expect_success '"git submodule sync" should update submodule URLs' '
 	)" &&
 	(
 		cd super-clone/submodule &&
-		git checkout master &&
+		git checkout main &&
 		git pull
 	) &&
 	(
@@ -140,7 +140,7 @@ test_expect_success '"git submodule sync --recursive" should update all submodul
 	)" &&
 	(
 		cd super-clone/submodule/sub-submodule &&
-		git checkout master &&
+		git checkout main &&
 		git pull
 	)
 '
@@ -168,7 +168,7 @@ test_expect_success '"git submodule sync" should update submodule URLs - subdire
 	)" &&
 	(
 		cd super-clone/submodule &&
-		git checkout master &&
+		git checkout main &&
 		git pull
 	) &&
 	(
@@ -199,7 +199,7 @@ test_expect_success '"git submodule sync --recursive" should update all submodul
 	)" &&
 	(
 		cd super-clone/submodule/sub-submodule &&
-		git checkout master &&
+		git checkout main &&
 		git pull
 	)
 '
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index acb8766ac2..87097846cb 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -14,10 +14,10 @@ submodule and "git submodule update --rebase/--merge" does not detach the HEAD.
 
 compare_head()
 {
-    sha_master=$(git rev-list --max-count=1 master)
+    sha_main=$(git rev-list --max-count=1 main)
     sha_head=$(git rev-list --max-count=1 HEAD)
 
-    test "$sha_master" = "$sha_head"
+    test "$sha_main" = "$sha_head"
 }
 
 
@@ -262,14 +262,14 @@ test_expect_success 'submodule update --remote should fetch upstream changes wit
 		cd super &&
 		git submodule update --remote --force submodule &&
 		git -C submodule log -1 --oneline >actual &&
-		git -C ../submodule log -1 --oneline master >expect &&
+		git -C ../submodule log -1 --oneline main >expect &&
 		test_cmp expect actual &&
 		git checkout -b test-branch &&
 		git submodule update --remote --force submodule &&
 		git -C submodule log -1 --oneline >actual &&
 		git -C ../submodule log -1 --oneline test-branch >expect &&
 		test_cmp expect actual &&
-		git checkout master &&
+		git checkout main &&
 		git branch -d test-branch &&
 		git reset --hard HEAD^
 	)
@@ -282,7 +282,7 @@ test_expect_success 'local config should override .gitmodules branch' '
 	 git add file &&
 	 test_tick &&
 	 git commit -m "upstream line5" &&
-	 git checkout master
+	 git checkout main
 	) &&
 	(cd super &&
 	 git config submodule.submodule.branch test-branch &&
@@ -292,9 +292,9 @@ test_expect_success 'local config should override .gitmodules branch' '
 	)
 '
 
-test_expect_success 'submodule update --rebase staying on master' '
+test_expect_success 'submodule update --rebase staying on main' '
 	(cd super/submodule &&
-	  git checkout master
+	  git checkout main
 	) &&
 	(cd super &&
 	 (cd submodule &&
@@ -306,7 +306,7 @@ test_expect_success 'submodule update --rebase staying on master' '
 	)
 '
 
-test_expect_success 'submodule update --merge staying on master' '
+test_expect_success 'submodule update --merge staying on main' '
 	(cd super/submodule &&
 	  git reset --hard HEAD~1
 	) &&
@@ -609,7 +609,7 @@ test_expect_success 'submodule update - update=none in .git/config' '
 	(cd super &&
 	 git config submodule.submodule.update none &&
 	 (cd submodule &&
-	  git checkout master &&
+	  git checkout main &&
 	  compare_head
 	 ) &&
 	 git diff --name-only >out &&
@@ -629,7 +629,7 @@ test_expect_success 'submodule update - update=none in .git/config but --checkou
 	(cd super &&
 	 git config submodule.submodule.update none &&
 	 (cd submodule &&
-	  git checkout master &&
+	  git checkout main &&
 	  compare_head
 	 ) &&
 	 git diff --name-only >out &&
@@ -689,7 +689,7 @@ test_expect_success 'submodule update continues after checkout error' '
 test_expect_success 'submodule update continues after recursive checkout error' '
 	(cd super &&
 	 git reset --hard HEAD &&
-	 git checkout master &&
+	 git checkout main &&
 	 git submodule update &&
 	 (cd submodule &&
 	  git submodule add ../submodule subsubmodule &&
@@ -733,7 +733,7 @@ test_expect_success 'submodule update continues after recursive checkout error'
 
 test_expect_success 'submodule update exit immediately in case of merge conflict' '
 	(cd super &&
-	 git checkout master &&
+	 git checkout main &&
 	 git reset --hard HEAD &&
 	 (cd submodule &&
 	  (cd subsubmodule &&
@@ -751,7 +751,7 @@ test_expect_success 'submodule update exit immediately in case of merge conflict
 	 git add submodule2 &&
 	 git commit -m "two_new_submodule_commits" &&
 	 (cd submodule &&
-	  git checkout master &&
+	  git checkout main &&
 	  test_commit "conflict" file &&
 	  echo "conflict" > file
 	 ) &&
@@ -770,7 +770,7 @@ test_expect_success 'submodule update exit immediately in case of merge conflict
 
 test_expect_success 'submodule update exit immediately after recursive rebase error' '
 	(cd super &&
-	 git checkout master &&
+	 git checkout main &&
 	 git reset --hard HEAD &&
 	 (cd submodule &&
 	  git reset --hard HEAD &&
@@ -786,7 +786,7 @@ test_expect_success 'submodule update exit immediately after recursive rebase er
 	 git add submodule2 &&
 	 git commit -m "two_new_submodule_commits" &&
 	 (cd submodule &&
-	  git checkout master &&
+	  git checkout main &&
 	  test_commit "conflict2" file &&
 	  echo "conflict" > file
 	 ) &&
@@ -878,21 +878,21 @@ test_expect_success 'submodule update places git-dir in superprojects git-dir re
 	git clone subsubsuper_update_r subsubsuper_update_r2 &&
 	(cd subsubsuper_update_r2 &&
 	 test_commit "update_subsubsuper" file &&
-	 git push origin master
+	 git push origin main
 	) &&
 	git clone subsuper_update_r subsuper_update_r2 &&
 	(cd subsuper_update_r2 &&
 	 test_commit "update_subsuper" file &&
 	 git submodule add ../subsubsuper_update_r subsubmodule &&
 	 git commit -am "subsubmodule" &&
-	 git push origin master
+	 git push origin main
 	) &&
 	git clone super_update_r super_update_r2 &&
 	(cd super_update_r2 &&
 	 test_commit "update_super" file &&
 	 git submodule add ../subsuper_update_r submodule &&
 	 git commit -am "submodule" &&
-	 git push origin master
+	 git push origin main
 	) &&
 	rm -rf super_update_r2 &&
 	git clone super_update_r super_update_r2 &&
@@ -911,7 +911,7 @@ test_expect_success 'submodule update places git-dir in superprojects git-dir re
 
 test_expect_success 'submodule add properly re-creates deeper level submodules' '
 	(cd super &&
-	 git reset --hard master &&
+	 git reset --hard main &&
 	 rm -rf deeper/ &&
 	 git submodule add --force ../submodule deeper/submodule
 	)
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 6b2aa917e1..8ebcaa3694 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -277,13 +277,13 @@ sub1sha1_short=$(cd clone3/sub1 && git rev-parse --short HEAD)
 sub2sha1_short=$(cd clone3/sub2 && git rev-parse --short HEAD)
 
 cat > expect <<EOF
- $nested1sha1 nested1 (heads/master)
- $nested2sha1 nested1/nested2 (heads/master)
- $nested3sha1 nested1/nested2/nested3 (heads/master)
- $submodulesha1 nested1/nested2/nested3/submodule (heads/master)
+ $nested1sha1 nested1 (heads/main)
+ $nested2sha1 nested1/nested2 (heads/main)
+ $nested3sha1 nested1/nested2/nested3 (heads/main)
+ $submodulesha1 nested1/nested2/nested3/submodule (heads/main)
  $sub1sha1 sub1 ($sub1sha1_short)
  $sub2sha1 sub2 ($sub2sha1_short)
- $sub3sha1 sub3 (heads/master)
+ $sub3sha1 sub3 (heads/main)
 EOF
 
 test_expect_success 'test "status --recursive"' '
@@ -295,10 +295,10 @@ test_expect_success 'test "status --recursive"' '
 '
 
 cat > expect <<EOF
- $nested1sha1 nested1 (heads/master)
+ $nested1sha1 nested1 (heads/main)
 +$nested2sha1 nested1/nested2 (file2~1)
- $nested3sha1 nested1/nested2/nested3 (heads/master)
- $submodulesha1 nested1/nested2/nested3/submodule (heads/master)
+ $nested3sha1 nested1/nested2/nested3 (heads/main)
+ $submodulesha1 nested1/nested2/nested3/submodule (heads/main)
 EOF
 
 test_expect_success 'ensure "status --cached --recursive" preserves the --cached flag' '
@@ -316,13 +316,13 @@ test_expect_success 'ensure "status --cached --recursive" preserves the --cached
 nested2sha1=$(git -C clone3/nested1/nested2 rev-parse HEAD)
 
 cat > expect <<EOF
- $nested1sha1 ../nested1 (heads/master)
+ $nested1sha1 ../nested1 (heads/main)
 +$nested2sha1 ../nested1/nested2 (file2)
- $nested3sha1 ../nested1/nested2/nested3 (heads/master)
- $submodulesha1 ../nested1/nested2/nested3/submodule (heads/master)
+ $nested3sha1 ../nested1/nested2/nested3 (heads/main)
+ $submodulesha1 ../nested1/nested2/nested3/submodule (heads/main)
  $sub1sha1 ../sub1 ($sub1sha1_short)
  $sub2sha1 ../sub2 ($sub2sha1_short)
- $sub3sha1 ../sub3 (heads/master)
+ $sub3sha1 ../sub3 (heads/main)
 EOF
 
 test_expect_success 'test "status --recursive" from sub directory' '
diff --git a/t/t7409-submodule-detached-work-tree.sh b/t/t7409-submodule-detached-work-tree.sh
index fc018e3638..727490eb15 100755
--- a/t/t7409-submodule-detached-work-tree.sh
+++ b/t/t7409-submodule-detached-work-tree.sh
@@ -35,7 +35,7 @@ test_expect_success 'submodule on detached working tree' '
 			git rev-parse --verify HEAD >actual &&
 			test_cmp ../../../../expect actual
 		) &&
-		git push origin master
+		git push origin main
 	) &&
 	mkdir home2 &&
 	(
@@ -44,7 +44,7 @@ test_expect_success 'submodule on detached working tree' '
 		GIT_WORK_TREE="$(pwd)" &&
 		GIT_DIR="$(pwd)/.dotfiles" &&
 		export GIT_WORK_TREE GIT_DIR &&
-		git checkout master &&
+		git checkout main &&
 		git submodule update --init &&
 		(
 			unset GIT_WORK_TREE GIT_DIR &&
@@ -64,10 +64,10 @@ test_expect_success 'submodule on detached working pointed by core.worktree' '
 		git clone --bare ../remote "$GIT_DIR" &&
 		git config core.bare false &&
 		git config core.worktree .. &&
-		git checkout master &&
+		git checkout main &&
 		git submodule add ../bundle1 .vim/bundle/dupe &&
 		test_commit "dupe" &&
-		git push origin master
+		git push origin main
 	) &&
 	(
 		cd home &&
diff --git a/t/t7417-submodule-path-url.sh b/t/t7417-submodule-path-url.sh
index f7e7e94d7b..1c9181aee7 100755
--- a/t/t7417-submodule-path-url.sh
+++ b/t/t7417-submodule-path-url.sh
@@ -36,7 +36,7 @@ test_expect_success MINGW 'submodule paths disallows trailing spaces' '
 	sed "s/sub/sub /" <tree >tree.new &&
 	tree=$(git -C super mktree <tree.new) &&
 	commit=$(echo with space | git -C super commit-tree $tree) &&
-	git -C super update-ref refs/heads/master $commit &&
+	git -C super update-ref refs/heads/main $commit &&
 
 	test_must_fail git clone --recurse-submodules super dst 2>err &&
 	test_i18ngrep "sub " err
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2f9c584fab..056d9591aa 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -257,13 +257,13 @@ case "$TRASH_DIRECTORY" in
 esac
 
 case "$TEST_NUMBER" in
-3404|4013|5310|5526|6300)
+3404|4013|5310|5526|6300|7064)
 	# Avoid conflicts with patch series that are cooking at the same time
 	# as the patch series changing the default of `init.defaultBranch`.
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-[0-6]*)
+[0-6]*|7[0-4]*)
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-- 
gitgitgadget


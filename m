Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FE6C07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6EB661175
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhGUBDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 21:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhGUBCH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 21:02:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7A2C0613DC
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 18:42:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id q18-20020a1ce9120000b02901f259f3a250so61952wmc.2
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 18:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qb6Qv/QTG8TQipZzjrlI6gWR2sPxI5Lvdl6+RVCYh7k=;
        b=QPTliYvBu2KbbK1nQWe4iywH7gRDYk1ke09J4F2jAIszy1svprRl6gXBWj78nBgh9F
         4wNzEe/2rB220r1L/ug1tDJCJHrK8/IaunpgjscsDCxzBn0tbSpQYAEKxxMlKWLmRKgX
         x5G+7Hv45cdcDafDSjgW7B5H74lg+LtgDiVjedU1YYYJzAAEi8oNr6D1QRyQTNgCnogi
         UW4j/8E7piehkurlFNuBOpE+NMnOHckMKNxY5vVzuNPxJTZed2U4OweJw/0eiZYtaTeB
         IfVxakB3OdO0noGXBM36/2RY92pd+Y9DXiiTZRXj9JYM6Dcpii8RTr81zT+xMYHUwDzR
         wE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qb6Qv/QTG8TQipZzjrlI6gWR2sPxI5Lvdl6+RVCYh7k=;
        b=L/h0bT0vHJ9tzLnsQvlL4dFrvdOdBxTWb/PJklhIbK4hKbUo7/GvY2O6EtsRo1q0kZ
         118D2jtC1i3spab3f9ddWdyQvTaMkFkr1ubNSG8R0ZzFfMFsZV3b1mNzOtghyDn3J10M
         rMJa6mXOpKLC9NfR2l3eRDNM/GCnHC/Oq/7T5l05ixWkILPi+bd8gcP54u0sEhcX8I2p
         LrZp3czdh3+Tly9JeQFFCbR0wxtmDng6tGywHXhGpSi0MSq1j3+Sl+rJakPO/BXq0vyg
         J9htp3scRvbMqM7zZxUOxPnAd5D/iTRN0eGRGUNM18DC7Y7aumoGv693YEkDvGX15DiE
         HLnA==
X-Gm-Message-State: AOAM532c+kXj3UOFPJHT+9Hroe0CbYsMNsdskuQBZ224k6YRuw+KMEtI
        7hZ4B5EldTVAa9RP7CLXAnqUV16SSWk=
X-Google-Smtp-Source: ABdhPJzGKAPoTvLN6qNPE0Bv7afb4KAIXvtiHnm4gJPe7qjzZ+1SBm2Zcj5vF893nIbseqkxfrHUKg==
X-Received: by 2002:a7b:ce8b:: with SMTP id q11mr33595022wmj.80.1626831749929;
        Tue, 20 Jul 2021 18:42:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s4sm23839976wmh.41.2021.07.20.18.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 18:42:29 -0700 (PDT)
Message-Id: <f061f8b4e75a42f3c08b0a8fc63ac87c8f8d77ec.1626831744.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
        <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 01:42:22 +0000
Subject: [PATCH v2 6/8] pull: abort by default when fast-forwarding is not
 possible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We have for some time shown a long warning when the user does not
specify how to reconcile divergent branches with git pull.  Make it an
error now.

Initial-patch-by: Alex Henrie <alexhenrie24@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-pull.txt    | 20 +++++++++------
 builtin/pull.c                | 10 +++++---
 t/t4013-diff-various.sh       |  2 +-
 t/t5520-pull.sh               | 20 +++++++--------
 t/t5521-pull-options.sh       |  4 +--
 t/t5524-pull-msg.sh           |  4 +--
 t/t5553-set-upstream.sh       | 14 +++++-----
 t/t5604-clone-reference.sh    |  4 +--
 t/t6402-merge-rename.sh       | 18 ++++++-------
 t/t6409-merge-subtree.sh      |  6 ++---
 t/t6417-merge-ours-theirs.sh  | 10 ++++----
 t/t7601-merge-pull-config.sh  | 48 +++++++++++++++++------------------
 t/t7603-merge-reduce-heads.sh |  2 +-
 13 files changed, 84 insertions(+), 78 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 5c3fb67c014..cad3f6bfcee 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -15,14 +15,18 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Incorporates changes from a remote repository into the current
-branch.  In its default mode, `git pull` is shorthand for
-`git fetch` followed by `git merge FETCH_HEAD`.
-
-More precisely, 'git pull' runs 'git fetch' with the given
-parameters and calls 'git merge' to merge the retrieved branch
-heads into the current branch.
-With `--rebase`, it runs 'git rebase' instead of 'git merge'.
+Incorporates changes from a remote repository into the current branch.
+If the current branch is behind the remote, then by default it will
+fast-forward the current branch to match the remote.  If the current
+branch and the remote have diverged, the user needs to specify how to
+reconcile the divergent branches with `--no-ff`, `--ff`, or `--rebase`
+(or the corresponding configuration options in `pull.ff` or
+`pull.rebase`).
+
+More precisely, `git pull` runs `git fetch` with the given parameters
+and then depending on configuration options or command line flags,
+will call either `git merge` or `git rebase` to reconcile diverging
+branches.
 
 <repository> should be the name of a remote repository as
 passed to linkgit:git-fetch[1].  <refspec> can name an
diff --git a/builtin/pull.c b/builtin/pull.c
index da1d4b19666..94464ca196f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -927,9 +927,9 @@ static int get_can_ff(struct object_id *orig_head, struct object_id *orig_merge_
 
 static void show_advice_pull_non_ff(void)
 {
-	advise(_("Pulling without specifying how to reconcile divergent branches is\n"
-		 "discouraged. You can squelch this message by running one of the following\n"
-		 "commands sometime before your next pull:\n"
+	advise(_("You have divergent branches and need to specify how to reconcile them.\n"
+		 "You can do so by running one of the following commands sometime before\n"
+		 "your next pull:\n"
 		 "\n"
 		 "  git config pull.rebase false  # merge (the default strategy)\n"
 		 "  git config pull.rebase true   # rebase\n"
@@ -1067,8 +1067,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		opt_rebase = REBASE_FALSE;
 	}
 	/* If no action specified and we can't fast forward, then warn. */
-	if (!opt_ff && rebase_unspecified && !can_ff)
+	if (!opt_ff && rebase_unspecified && !can_ff) {
 		show_advice_pull_non_ff();
+		die(_("Need to specify how to reconcile divergent branches."));
+	}
 
 	if (opt_rebase) {
 		int ret = 0;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 7fadc985ccc..eb989f7f191 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -65,7 +65,7 @@ test_expect_success setup '
 	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
 
 	git checkout master &&
-	git pull -s ours . side &&
+	git pull -s ours --no-rebase . side &&
 
 	GIT_AUTHOR_DATE="2006-06-26 00:05:00 +0000" &&
 	GIT_COMMITTER_DATE="2006-06-26 00:05:00 +0000" &&
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 4b50488141f..56f5864b269 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -136,12 +136,12 @@ test_expect_success 'the default remote . should not break explicit pull' '
 	git reset --hard HEAD^ &&
 	echo file >expect &&
 	test_cmp expect file &&
-	git pull . second &&
+	git pull --no-rebase . second &&
 	echo modified >expect &&
 	test_cmp expect file &&
 	git reflog -1 >reflog.actual &&
 	sed "s/^[0-9a-f][0-9a-f]*/OBJID/" reflog.actual >reflog.fuzzy &&
-	echo "OBJID HEAD@{0}: pull . second: Fast-forward" >reflog.expected &&
+	echo "OBJID HEAD@{0}: pull --no-rebase . second: Fast-forward" >reflog.expected &&
 	test_cmp reflog.expected reflog.fuzzy
 '
 
@@ -226,7 +226,7 @@ test_expect_success 'fail if the index has unresolved entries' '
 	test_commit modified2 file &&
 	git ls-files -u >unmerged &&
 	test_must_be_empty unmerged &&
-	test_must_fail git pull . second &&
+	test_must_fail git pull --no-rebase . second &&
 	git ls-files -u >unmerged &&
 	test_file_not_empty unmerged &&
 	cp file expected &&
@@ -409,37 +409,37 @@ test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
 
 test_expect_success 'pull succeeds with dirty working directory and merge.autostash set' '
 	test_config merge.autostash true &&
-	test_pull_autostash 2
+	test_pull_autostash 2 --no-rebase
 '
 
 test_expect_success 'pull --autostash & merge.autostash=true' '
 	test_config merge.autostash true &&
-	test_pull_autostash 2 --autostash
+	test_pull_autostash 2 --autostash --no-rebase
 '
 
 test_expect_success 'pull --autostash & merge.autostash=false' '
 	test_config merge.autostash false &&
-	test_pull_autostash 2 --autostash
+	test_pull_autostash 2 --autostash --no-rebase
 '
 
 test_expect_success 'pull --autostash & merge.autostash unset' '
 	test_unconfig merge.autostash &&
-	test_pull_autostash 2 --autostash
+	test_pull_autostash 2 --autostash --no-rebase
 '
 
 test_expect_success 'pull --no-autostash & merge.autostash=true' '
 	test_config merge.autostash true &&
-	test_pull_autostash_fail --no-autostash
+	test_pull_autostash_fail --no-autostash --no-rebase
 '
 
 test_expect_success 'pull --no-autostash & merge.autostash=false' '
 	test_config merge.autostash false &&
-	test_pull_autostash_fail --no-autostash
+	test_pull_autostash_fail --no-autostash --no-rebase
 '
 
 test_expect_success 'pull --no-autostash & merge.autostash unset' '
 	test_unconfig merge.autostash &&
-	test_pull_autostash_fail --no-autostash
+	test_pull_autostash_fail --no-autostash --no-rebase
 '
 
 test_expect_success 'pull.rebase' '
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 63a688bdbf5..7601c919fdc 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -113,7 +113,7 @@ test_expect_success 'git pull --force' '
 	git pull two &&
 	test_commit A &&
 	git branch -f origin &&
-	git pull --all --force
+	git pull --no-rebase --all --force
 	)
 '
 
@@ -179,7 +179,7 @@ test_expect_success 'git pull --allow-unrelated-histories' '
 	(
 		cd dst &&
 		test_must_fail git pull ../src side &&
-		git pull --allow-unrelated-histories ../src side
+		git pull --no-rebase --allow-unrelated-histories ../src side
 	)
 '
 
diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
index c278adaa5a2..b2be3605f5a 100755
--- a/t/t5524-pull-msg.sh
+++ b/t/t5524-pull-msg.sh
@@ -28,7 +28,7 @@ test_expect_success setup '
 test_expect_success pull '
 (
 	cd cloned &&
-	git pull --log &&
+	git pull --no-rebase --log &&
 	git log -2 &&
 	git cat-file commit HEAD >result &&
 	grep Dollar result
@@ -41,7 +41,7 @@ test_expect_success '--log=1 limits shortlog length' '
 	git reset --hard HEAD^ &&
 	test "$(cat afile)" = original &&
 	test "$(cat bfile)" = added &&
-	git pull --log=1 &&
+	git pull --no-rebase --log=1 &&
 	git log -3 &&
 	git cat-file commit HEAD >result &&
 	grep Dollar result &&
diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
index b1d614ce18c..9c12c0f8c32 100755
--- a/t/t5553-set-upstream.sh
+++ b/t/t5553-set-upstream.sh
@@ -108,27 +108,27 @@ test_expect_success 'setup commit on main and other pull' '
 
 test_expect_success 'pull --set-upstream upstream main sets branch main but not other' '
 	clear_config main other &&
-	git pull --set-upstream upstream main &&
+	git pull --no-rebase --set-upstream upstream main &&
 	check_config main upstream refs/heads/main &&
 	check_config_missing other
 '
 
 test_expect_success 'pull --set-upstream main:other2 does not set the branch other2' '
 	clear_config other2 &&
-	git pull --set-upstream upstream main:other2 &&
+	git pull --no-rebase --set-upstream upstream main:other2 &&
 	check_config_missing other2
 '
 
 test_expect_success 'pull --set-upstream upstream other sets branch main' '
 	clear_config main other &&
-	git pull --set-upstream upstream other &&
+	git pull --no-rebase --set-upstream upstream other &&
 	check_config main upstream refs/heads/other &&
 	check_config_missing other
 '
 
 test_expect_success 'pull --set-upstream upstream tag does not set the tag' '
 	clear_config three &&
-	git pull --tags --set-upstream upstream three &&
+	git pull --no-rebase --tags --set-upstream upstream three &&
 	check_config_missing three
 '
 
@@ -144,16 +144,16 @@ test_expect_success 'pull --set-upstream http://nosuchdomain.example.com fails w
 
 test_expect_success 'pull --set-upstream upstream HEAD sets branch HEAD' '
 	clear_config main other &&
-	git pull --set-upstream upstream HEAD &&
+	git pull --no-rebase --set-upstream upstream HEAD &&
 	check_config main upstream HEAD &&
 	git checkout other &&
-	git pull --set-upstream upstream HEAD &&
+	git pull --no-rebase --set-upstream upstream HEAD &&
 	check_config other upstream HEAD
 '
 
 test_expect_success 'pull --set-upstream upstream with more than one branch does nothing' '
 	clear_config main three &&
-	git pull --set-upstream upstream main three &&
+	git pull --no-rebase --set-upstream upstream main three &&
 	check_config_missing main &&
 	check_config_missing three
 '
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index e845d621f61..24340e6d56e 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -87,7 +87,7 @@ test_expect_success 'updating origin' '
 '
 
 test_expect_success 'pulling changes from origin' '
-	git -C C pull origin
+	git -C C pull --no-rebase origin
 '
 
 # the 2 local objects are commit and tree from the merge
@@ -96,7 +96,7 @@ test_expect_success 'that alternate to origin gets used' '
 '
 
 test_expect_success 'pulling changes from origin' '
-	git -C D pull origin
+	git -C D pull --no-rebase origin
 '
 
 # the 5 local objects are expected; file3 blob, commit in A to add it
diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 3da2896e3bc..3a32b1a45cf 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -103,7 +103,7 @@ test_expect_success 'setup' '
 test_expect_success 'pull renaming branch into unrenaming one' \
 '
 	git show-branch &&
-	test_expect_code 1 git pull . white &&
+	test_expect_code 1 git pull --no-rebase . white &&
 	git ls-files -s &&
 	test_stdout_line_count = 3 git ls-files -u B &&
 	test_stdout_line_count = 1 git ls-files -s N &&
@@ -119,7 +119,7 @@ test_expect_success 'pull renaming branch into another renaming one' \
 	rm -f B &&
 	git reset --hard &&
 	git checkout red &&
-	test_expect_code 1 git pull . white &&
+	test_expect_code 1 git pull --no-rebase . white &&
 	test_stdout_line_count = 3 git ls-files -u B &&
 	test_stdout_line_count = 1 git ls-files -s N &&
 	sed -ne "/^g/{
@@ -133,7 +133,7 @@ test_expect_success 'pull unrenaming branch into renaming one' \
 '
 	git reset --hard &&
 	git show-branch &&
-	test_expect_code 1 git pull . main &&
+	test_expect_code 1 git pull --no-rebase . main &&
 	test_stdout_line_count = 3 git ls-files -u B &&
 	test_stdout_line_count = 1 git ls-files -s N &&
 	sed -ne "/^g/{
@@ -147,7 +147,7 @@ test_expect_success 'pull conflicting renames' \
 '
 	git reset --hard &&
 	git show-branch &&
-	test_expect_code 1 git pull . blue &&
+	test_expect_code 1 git pull --no-rebase . blue &&
 	test_stdout_line_count = 1 git ls-files -u A &&
 	test_stdout_line_count = 1 git ls-files -u B &&
 	test_stdout_line_count = 1 git ls-files -u C &&
@@ -163,7 +163,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git reset --hard &&
 	git show-branch &&
 	echo >A this file should not matter &&
-	test_expect_code 1 git pull . white &&
+	test_expect_code 1 git pull --no-rebase . white &&
 	test_path_is_file A
 '
 
@@ -173,7 +173,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git show-branch &&
 	rm -f A &&
 	echo >A this file should not matter &&
-	test_expect_code 1 git pull . red &&
+	test_expect_code 1 git pull --no-rebase . red &&
 	test_path_is_file A
 '
 
@@ -183,7 +183,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git checkout -f main &&
 	git tag -f anchor &&
 	git show-branch &&
-	git pull . yellow &&
+	git pull --no-rebase . yellow &&
 	test_path_is_missing M &&
 	git reset --hard anchor
 '
@@ -210,7 +210,7 @@ test_expect_success 'updated working tree file should prevent the merge' '
 	echo >>M one line addition &&
 	cat M >M.saved &&
 	git update-index M &&
-	test_expect_code 128 git pull . yellow &&
+	test_expect_code 128 git pull --no-rebase . yellow &&
 	test_cmp M M.saved &&
 	rm -f M.saved
 '
@@ -222,7 +222,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git tag -f anchor &&
 	git show-branch &&
 	echo >M this file should not matter &&
-	git pull . main &&
+	git pull --no-rebase . main &&
 	test_path_is_file M &&
 	! {
 		git ls-files -s |
diff --git a/t/t6409-merge-subtree.sh b/t/t6409-merge-subtree.sh
index d406b2343cb..ba7890ec521 100755
--- a/t/t6409-merge-subtree.sh
+++ b/t/t6409-merge-subtree.sh
@@ -100,7 +100,7 @@ test_expect_success 'merge update' '
 	git checkout -b topic_2 &&
 	git commit -m "update git-gui" &&
 	cd ../git &&
-	git pull -s subtree gui topic_2 &&
+	git pull --no-rebase -s subtree gui topic_2 &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o3 0	git-gui/git-gui.sh" &&
@@ -129,7 +129,7 @@ test_expect_success 'initial ambiguous subtree' '
 test_expect_success 'merge using explicit' '
 	cd ../git &&
 	git reset --hard topic_2 &&
-	git pull -Xsubtree=git-gui gui topic_2 &&
+	git pull --no-rebase -Xsubtree=git-gui gui topic_2 &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o3 0	git-gui/git-gui.sh" &&
@@ -142,7 +142,7 @@ test_expect_success 'merge using explicit' '
 test_expect_success 'merge2 using explicit' '
 	cd ../git &&
 	git reset --hard topic_2 &&
-	git pull -Xsubtree=git-gui2 gui topic_2 &&
+	git pull --no-rebase -Xsubtree=git-gui2 gui topic_2 &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o1 0	git-gui/git-gui.sh" &&
diff --git a/t/t6417-merge-ours-theirs.sh b/t/t6417-merge-ours-theirs.sh
index ac9aee9a662..ec065d6a658 100755
--- a/t/t6417-merge-ours-theirs.sh
+++ b/t/t6417-merge-ours-theirs.sh
@@ -69,11 +69,11 @@ test_expect_success 'binary file with -Xours/-Xtheirs' '
 '
 
 test_expect_success 'pull passes -X to underlying merge' '
-	git reset --hard main && git pull -s recursive -Xours . side &&
-	git reset --hard main && git pull -s recursive -X ours . side &&
-	git reset --hard main && git pull -s recursive -Xtheirs . side &&
-	git reset --hard main && git pull -s recursive -X theirs . side &&
-	git reset --hard main && test_must_fail git pull -s recursive -X bork . side
+	git reset --hard main && git pull --no-rebase -s recursive -Xours . side &&
+	git reset --hard main && git pull --no-rebase -s recursive -X ours . side &&
+	git reset --hard main && git pull --no-rebase -s recursive -Xtheirs . side &&
+	git reset --hard main && git pull --no-rebase -s recursive -X theirs . side &&
+	git reset --hard main && test_must_fail git pull --no-rebase -s recursive -X bork . side
 '
 
 test_expect_success SYMLINKS 'symlink with -Xours/-Xtheirs' '
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 0c0dfecd2a3..742ed3981c7 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -27,120 +27,120 @@ test_expect_success 'setup' '
 	git tag c3
 '
 
-test_expect_success 'pull.rebase not set' '
+test_expect_success 'pull.rebase not set, ff possible' '
 	git reset --hard c0 &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=true' '
 	git reset --hard c0 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=false' '
 	git reset --hard c0 &&
 	test_config pull.ff false &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=only' '
 	git reset --hard c0 &&
 	test_config pull.ff only &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --rebase given' '
 	git reset --hard c0 &&
 	git pull --rebase . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --no-rebase given' '
 	git reset --hard c0 &&
 	git pull --no-rebase . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --ff given' '
 	git reset --hard c0 &&
 	git pull --ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --no-ff given' '
 	git reset --hard c0 &&
 	git pull --no-ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --ff-only given' '
 	git reset --hard c0 &&
 	git pull --ff-only . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set (not-fast-forward)' '
 	git reset --hard c2 &&
-	git -c color.advice=always pull . c1 2>err &&
+	test_must_fail git -c color.advice=always pull . c1 2>err &&
 	test_decode_color <err >decoded &&
 	test_i18ngrep "<YELLOW>hint: " decoded &&
-	test_i18ngrep "Pulling without specifying how to reconcile" decoded
+	test_i18ngrep "You have divergent branches" decoded
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=true (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=false (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff false &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=only (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff only &&
 	test_must_fail git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --rebase given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --rebase . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --no-rebase given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --no-rebase . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --ff given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --no-ff given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --no-ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --ff-only given (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_must_fail git pull --ff-only . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "You have divergent branches" err
 '
 
 test_does_rebase () {
@@ -325,16 +325,16 @@ test_expect_success 'pull.rebase=false and --ff, ff not possible' '
 
 # End of groupings for conflicting merge vs. rebase flags/options
 
-test_expect_failure 'Multiple heads warns about inability to fast forward' '
+test_expect_success 'Multiple heads warns about inability to fast forward' '
 	git reset --hard c1 &&
 	test_must_fail git pull . c2 c3 2>err &&
-	test_i18ngrep "Pulling without specifying how to reconcile" err
+	test_i18ngrep "You have divergent branches" err
 '
 
 test_expect_failure 'Multiple can never be fast forwarded' '
 	git reset --hard c0 &&
 	test_must_fail git -c pull.ff=only pull . c1 c2 c3 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err &&
+	test_i18ngrep ! "You have divergent branches" err &&
 	# In addition to calling out "cannot fast-forward", we very much
 	# want the "multiple branches" piece to be called out to users.
 	test_i18ngrep "Cannot fast-forward to multiple branches" err
@@ -343,7 +343,7 @@ test_expect_failure 'Multiple can never be fast forwarded' '
 test_expect_success 'Cannot rebase with multiple heads' '
 	git reset --hard c0 &&
 	test_must_fail git -c pull.rebase=true pull . c1 c2 c3 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err &&
+	test_i18ngrep ! "You have divergent branches" err &&
 	test_i18ngrep "Cannot rebase onto multiple branches." err
 '
 
diff --git a/t/t7603-merge-reduce-heads.sh b/t/t7603-merge-reduce-heads.sh
index 98948955ae5..27cd94ad6f7 100755
--- a/t/t7603-merge-reduce-heads.sh
+++ b/t/t7603-merge-reduce-heads.sh
@@ -68,7 +68,7 @@ test_expect_success 'merge c1 with c2, c3, c4, c5' '
 
 test_expect_success 'pull c2, c3, c4, c5 into c1' '
 	git reset --hard c1 &&
-	git pull . c2 c3 c4 c5 &&
+	git pull --no-rebase . c2 c3 c4 c5 &&
 	test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
 	test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
 	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
-- 
gitgitgadget


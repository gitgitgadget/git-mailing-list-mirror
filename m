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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2314EC12002
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 02:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F03E61377
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 02:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhGOCny (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 22:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhGOCnt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 22:43:49 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081C9C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 19:40:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso4377626wmc.1
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 19:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u4w4lM9mW6Glpd0K1hgqO40zuUz+Y5Fvm5kuzrNVeog=;
        b=f/Qopt8rp2ocWWrn6sC+PIrbiSlMPB5ibjj1mthpu0KZqHQuKebpjcS4/NdDYO07Q/
         9hJVlFOZLJUTWA3TIP7A/UFJkalUA0EjDP+HWnYBFkEA4TrOOHF603gY29ql1liuGLgK
         SN4f/58Pyecd3fyLGigXTuGmDhmh+x+pdcr+8dG6V/mDUzUb2fqEbP+Hxl8YGRiHULXj
         GgeZ+rSt251UOyhB/qrS8SdgIp4EPT1Tkp0PLhSqUQwZHRCwjR0+ZzqTGnTFBb6FJjIe
         au6tubSXQ026PfIMhhj7lTXARAsiB1PrH/u8j9nMd4ZXfi9X/aY87o6rXSqCxrKMPlGI
         GHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u4w4lM9mW6Glpd0K1hgqO40zuUz+Y5Fvm5kuzrNVeog=;
        b=LIKx2bhWuMRvUUbh7hXkzKPtLq8+NBOTWnO7V+Z/xC0b2Zu8t/oBahThO3ArtULnjg
         S+BJaIg+EGPXo1FjXgVel0V2JLNyq+HZKHBHYLZJVQ1o5MaEclmmSwikF/D528h3CVSR
         il0uV1cDIr77b6RAWvGxTR/haAe2wM/5VXXX9B7Uoyk0xCx6Skv0WdLDzrEcLL9gUAKD
         6u3NSSAtgx2PHZVe8LmtBnYNqNSSFerbXJ3c3wmg6oW+uJUSaJJFmSVlWJnzTLInluhS
         2Cla9PUSe3elZGeE3qtI+4c5jZp6d6Bl55o4e/a6/nUcXm1j6Y4DmEIcG+a5EauZH+1p
         KUhg==
X-Gm-Message-State: AOAM530UarSLY07WzjU1u7zV4kV6jNB4PCV3mB+gS47aFe4nhfSjzw0L
        kfDoHPwcO8YahE/moTZvArs+ndEGD3c=
X-Google-Smtp-Source: ABdhPJynvgz6zdtkWDiYYHfC4uwnpJ14WtXsM1q3isqR929JTGt9/W2GqixkynO7Srs3alJrEhSIxw==
X-Received: by 2002:a7b:c844:: with SMTP id c4mr7501047wml.107.1626316854252;
        Wed, 14 Jul 2021 19:40:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9sm4428046wrx.59.2021.07.14.19.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 19:40:53 -0700 (PDT)
Message-Id: <7e12c45fc9a94e7b56a6efdc085ebe081dd40afc.1626316849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 02:40:49 +0000
Subject: [PATCH 5/5] pull: abort by default when fast-forwarding is not
 possible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
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
 Documentation/git-pull.txt    | 18 ++++++++++--------
 builtin/pull.c                | 31 +++++++++++++++----------------
 t/t4013-diff-various.sh       |  2 +-
 t/t5520-pull.sh               | 20 ++++++++++----------
 t/t5521-pull-options.sh       |  4 ++--
 t/t5524-pull-msg.sh           |  4 ++--
 t/t5553-set-upstream.sh       | 14 +++++++-------
 t/t5604-clone-reference.sh    |  4 ++--
 t/t6402-merge-rename.sh       | 18 +++++++++---------
 t/t6409-merge-subtree.sh      |  6 +++---
 t/t6417-merge-ours-theirs.sh  | 10 +++++-----
 t/t7601-merge-pull-config.sh  |  6 ++----
 t/t7603-merge-reduce-heads.sh |  2 +-
 13 files changed, 69 insertions(+), 70 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 03e8694e146..cb65d33e15e 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -15,14 +15,16 @@ SYNOPSIS
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
+reconcile the divergent branches with --no-ff or --rebase (or the
+corresponding configuration options in pull.ff or pull.rebase).
+
+More precisely, 'git pull' runs 'git fetch' with the given parameters
+and then depending on config options or command line flags, will call
+either 'git merge' or 'git rebase' to reconcile diverging branches.
 
 <repository> should be the name of a remote repository as
 passed to linkgit:git-fetch[1].  <refspec> can name an
diff --git a/builtin/pull.c b/builtin/pull.c
index 2c90bbb1588..0f8fdb7d42b 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -946,20 +946,20 @@ static int get_can_ff(struct object_id *orig_head, struct object_id *orig_merge_
 	return ret;
 }
 
-static void show_advice_pull_non_ff(void)
+static void NORETURN die_pull_non_ff(void)
 {
-	advise(_("Pulling without specifying how to reconcile divergent branches is\n"
-		 "discouraged. You can squelch this message by running one of the following\n"
-		 "commands sometime before your next pull:\n"
-		 "\n"
-		 "  git config pull.rebase false  # merge (the default strategy)\n"
-		 "  git config pull.rebase true   # rebase\n"
-		 "  git config pull.ff only       # fast-forward only\n"
-		 "\n"
-		 "You can replace \"git config\" with \"git config --global\" to set a default\n"
-		 "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
-		 "or --ff-only on the command line to override the configured default per\n"
-		 "invocation.\n"));
+	die(_("You have divergent branches and need to specify how to reconcile them.\n"
+	      "You can do so by running one of the following commands sometime before\n"
+	      "your next pull:\n"
+	      "\n"
+	      "  git config pull.rebase false  # merge (the default strategy)\n"
+	      "  git config pull.rebase true   # rebase\n"
+	      "  git config pull.ff only       # fast-forward only\n"
+	      "\n"
+	      "You can replace \"git config\" with \"git config --global\" to set a default\n"
+	      "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
+	      "or --ff-only on the command line to override the configured default per\n"
+	      "invocation.\n"));
 }
 
 int cmd_pull(int argc, const char **argv, const char *prefix)
@@ -1074,9 +1074,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		if (opt_ff) {
 			if (!strcmp(opt_ff, "--ff-only"))
 				die_ff_impossible();
-		} else {
-			if (rebase_unspecified && opt_verbosity >= 0)
-				show_advice_pull_non_ff();
+		} else if (rebase_unspecified) {
+			die_pull_non_ff();
 		}
 	}
 
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
index e2c0c510222..672001a18bd 100755
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
index 425dad97d54..02a842697b8 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -103,7 +103,7 @@ test_expect_success 'setup' '
 test_expect_success 'pull renaming branch into unrenaming one' \
 '
 	git show-branch &&
-	test_expect_code 1 git pull . white &&
+	test_expect_code 1 git pull --no-rebase . white &&
 	git ls-files -s &&
 	git ls-files -u B >b.stages &&
 	test_line_count = 3 b.stages &&
@@ -121,7 +121,7 @@ test_expect_success 'pull renaming branch into another renaming one' \
 	rm -f B &&
 	git reset --hard &&
 	git checkout red &&
-	test_expect_code 1 git pull . white &&
+	test_expect_code 1 git pull --no-rebase . white &&
 	git ls-files -u B >b.stages &&
 	test_line_count = 3 b.stages &&
 	git ls-files -s N >n.stages &&
@@ -137,7 +137,7 @@ test_expect_success 'pull unrenaming branch into renaming one' \
 '
 	git reset --hard &&
 	git show-branch &&
-	test_expect_code 1 git pull . main &&
+	test_expect_code 1 git pull --no-rebase . main &&
 	git ls-files -u B >b.stages &&
 	test_line_count = 3 b.stages &&
 	git ls-files -s N >n.stages &&
@@ -153,7 +153,7 @@ test_expect_success 'pull conflicting renames' \
 '
 	git reset --hard &&
 	git show-branch &&
-	test_expect_code 1 git pull . blue &&
+	test_expect_code 1 git pull --no-rebase . blue &&
 	git ls-files -u A >a.stages &&
 	test_line_count = 1 a.stages &&
 	git ls-files -u B >b.stages &&
@@ -173,7 +173,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git reset --hard &&
 	git show-branch &&
 	echo >A this file should not matter &&
-	test_expect_code 1 git pull . white &&
+	test_expect_code 1 git pull --no-rebase . white &&
 	test_path_is_file A
 '
 
@@ -183,7 +183,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git show-branch &&
 	rm -f A &&
 	echo >A this file should not matter &&
-	test_expect_code 1 git pull . red &&
+	test_expect_code 1 git pull --no-rebase . red &&
 	test_path_is_file A
 '
 
@@ -193,7 +193,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git checkout -f main &&
 	git tag -f anchor &&
 	git show-branch &&
-	git pull . yellow &&
+	git pull --no-rebase . yellow &&
 	test_path_is_missing M &&
 	git reset --hard anchor
 '
@@ -220,7 +220,7 @@ test_expect_success 'updated working tree file should prevent the merge' '
 	echo >>M one line addition &&
 	cat M >M.saved &&
 	git update-index M &&
-	test_expect_code 128 git pull . yellow &&
+	test_expect_code 128 git pull --no-rebase . yellow &&
 	test_cmp M M.saved &&
 	rm -f M.saved
 '
@@ -232,7 +232,7 @@ test_expect_success 'interference with untracked working tree file' '
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
index 6b9e80db97b..84404f4f0c3 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -86,10 +86,8 @@ test_expect_success 'pull.rebase not set and --ff-only given' '
 
 test_expect_success 'pull.rebase not set (not-fast-forward)' '
 	git reset --hard c2 &&
-	git -c color.advice=always pull . c1 2>err &&
-	test_decode_color <err >decoded &&
-	test_i18ngrep "<YELLOW>hint: " decoded &&
-	test_i18ngrep "Pulling without specifying how to reconcile" decoded
+	test_must_fail git pull . c1 2>err &&
+	test_i18ngrep "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=true (not-fast-forward)' '
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

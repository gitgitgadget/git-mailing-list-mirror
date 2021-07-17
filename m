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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0887C636C9
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A717D61159
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbhGQPo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 11:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbhGQPoz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 11:44:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9EFC0613DC
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:41:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r11so15607378wro.9
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1wobEcbm+Jf9WybKWhfAfxo2HD5LrqQZ3DD9f05SbaE=;
        b=SooPPCdH1LEkdKQIhp7liA/onPw7Jjha55QDUU7wYZvrg2GCMKRu6QG58rvWim3k2H
         quWMYnOr0W0jie2TcgbE7grvJ1AmfODvnrGoFjLqYzBHgxuW1G+ZLZgcTEZ0GZDPJw/n
         F2jdQdHTQ439RJXOOo3yCvbh7s+oCb8cukgb9xktzFOJGf8aZQCIiwMLr3TIO9R3b1Pd
         Zoenv8zsSfuKpMTGGgrVogv1cm6OgHKuhnES4VulfWFkoV6BpDT6oLf/1c81HzLawH5c
         w/PVP19zme4Qxo91zRoISpAZaGn6c8XsA7qiV626fwie2RhsJc0AXnW/Hh3Hy41FSOzh
         FNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1wobEcbm+Jf9WybKWhfAfxo2HD5LrqQZ3DD9f05SbaE=;
        b=B5Yf9a+zwIF9aGFgsC05o24pblrIXPrD5/HXsKoFnmWxleACH1O5quw1Ayhw4+BjZu
         P1yEPxc10OfLZwRnmSa8djngTX0y0WCdHP1x4ijxqMwd5+hhI1PU4hVHLU5m/oPpb3nQ
         yJcOQLsBamfOMwVAb3+Mwa68CCv87DC7Af2+W9zVPWHj7f0SZEKaJKqBL1wxPcxiE1+h
         yND1wjo8mEwKpN6BkfQyIxVgkOGfAWH39Gmu9uwqS296kSLply6C5w11MnrmDlrFifor
         5DmoNNNkydm/T7R4+xf4C/1uxpRbvUeJoXh2Crr7HAGotTmPwaT4LS0LveK+RDEuG9xD
         7bFA==
X-Gm-Message-State: AOAM530+h8z0HPeFlID6L+BhRcUH+mizwKHTAS6YJnysZsNFOj2oSmDH
        jsCR7hZnIuxvSLC31AKUvTwLHIi93kY=
X-Google-Smtp-Source: ABdhPJyPbf8zO+eawboL4nT/SjYp+IxImMWMYEVQiwJMTILEA0L3BHGDZFpBu/ZG9p7oq7ZbwvFDsA==
X-Received: by 2002:adf:f60a:: with SMTP id t10mr18894799wrp.127.1626536514114;
        Sat, 17 Jul 2021 08:41:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v21sm14505509wml.5.2021.07.17.08.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 08:41:53 -0700 (PDT)
Message-Id: <dca0455898a838b46546a29ee79f0a8b112fbff5.1626536508.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Jul 2021 15:41:45 +0000
Subject: [PATCH 7/9] pull: abort by default when fast-forwarding is not
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
 Documentation/git-pull.txt    | 20 +++++++++++-------
 builtin/pull.c                | 10 +++++----
 t/t4013-diff-various.sh       |  2 +-
 t/t5520-pull.sh               | 20 +++++++++---------
 t/t5521-pull-options.sh       |  4 ++--
 t/t5524-pull-msg.sh           |  4 ++--
 t/t5553-set-upstream.sh       | 14 ++++++------
 t/t5604-clone-reference.sh    |  4 ++--
 t/t6402-merge-rename.sh       | 18 ++++++++--------
 t/t6409-merge-subtree.sh      |  6 +++---
 t/t6417-merge-ours-theirs.sh  | 10 ++++-----
 t/t7601-merge-pull-config.sh  | 40 +++++++++++++++++------------------
 t/t7603-merge-reduce-heads.sh |  2 +-
 13 files changed, 80 insertions(+), 74 deletions(-)

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
index 7e7c90f6a10..2d7f2d765ab 100644
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
@@ -1057,8 +1057,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			return run_merge();
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
index 12787d07289..673b92afbab 100755
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
 
 test_does_rebase() {
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


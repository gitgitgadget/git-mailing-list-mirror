Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B10C56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 02:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32A7F2075A
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 02:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9dwq6sh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgKYCOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 21:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKYCOh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 21:14:37 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F0DC0613D4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 18:14:37 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id j19so972060pgg.5
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 18:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yUf4krW0ZjdisiV62bZVCifmS49ci9lqFJTs6fKA/b8=;
        b=H9dwq6sh0H33pT1irNmUbTNBe9RrOwmPLUnnGPjkyXmd7u9lVYfn4MEwqI534dnMar
         c2HfztuVlON1+oaKepXniLw2LqbURI4NRVSFReDi+5mamIg/b4HuI1MNVpzemO2KmZwu
         udeCOTHrwsq5YyUYUEP0bFSUERFvZpumvZEHaUl4qboIKrCqQrN0lzFaAF1eP6A3ydYL
         0ikID/70h9Hbq6obhrfvg++3C0b6t9+n2uQFZyKD40HL/OPOTDImQ0BiKVTDWr5IXuxZ
         S7Fuv8HurLlSddTYEzKMO3W///D0npuGxHahgeF51qgzl8q9uuY1YNLXIVR0s7nsxLt6
         FDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yUf4krW0ZjdisiV62bZVCifmS49ci9lqFJTs6fKA/b8=;
        b=O+NNpsCdvsOldQsB4hW5S9/WbOgm/bqQuZJTl6n/PP8Jxhwz5DozEpyRwG6RDzAaVD
         YzvRGneYJQdft7NIzTgKDOoDdcLqpZSHABMY6Tu3nskGwpP3Ae970X0tlAsQp499aR/7
         CGE9miGIqpPlV1VhQhrGGlQhDJKflTfmSL042nJI+IK/MtX0AHk5TRUkmVEhkQ60SbBN
         Jc77z3c8zj35t4V1mcK39TL/4tjRvpvzJS4B9rbunAIltCssf6ioOjrQvdJnvIvW7mzm
         K9hCyYAx6onV+N3FpQnOGaNm24+uazZeO9nG7DK/oi6uOezNFBJ/iQXi3o24vg+lHbTI
         3mJg==
X-Gm-Message-State: AOAM531j7YCzFi+MIYlyjpYy4ZX2rNPzvmw0q7OV7yAaMGgLc8QV8jfZ
        c4IC+av14r43+ShrbBbcn+muO8nMYzCVjd7K
X-Google-Smtp-Source: ABdhPJwMceQzB52OArXW6LF+4O3ZJmf5RiAreJ5fK6KiBnEdj4flkAsyxQHStInAqWYRRKy+zmXnMA==
X-Received: by 2002:a63:fe0c:: with SMTP id p12mr1159822pgh.31.1606270475676;
        Tue, 24 Nov 2020 18:14:35 -0800 (PST)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:5900:961c:3398:e348:1cc1:ced7])
        by smtp.gmail.com with ESMTPSA id 23sm426050pgs.19.2020.11.24.18.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 18:14:34 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, felipe.contreras@gmail.com, gitster@pobox.com,
        ray@ameretat.dev, peff@peff.net, vondruch@redhat.com, tytso@mit.edu
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [RFC 2/2] pull: default pull.ff to "only" when pull.rebase is not set either
Date:   Tue, 24 Nov 2020 19:09:31 -0700
Message-Id: <20201125020931.248427-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125020931.248427-1-alexhenrie24@gmail.com>
References: <20201125020931.248427-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/merge-options.txt | 14 +++++---
 builtin/pull.c                  | 41 +++++++++---------------
 t/t5520-pull.sh                 | 16 ++++-----
 t/t5521-pull-options.sh         |  4 +--
 t/t5524-pull-msg.sh             |  4 +--
 t/t5553-set-upstream.sh         | 20 ++++++------
 t/t5604-clone-reference.sh      |  4 +--
 t/t6402-merge-rename.sh         | 20 ++++++------
 t/t6409-merge-subtree.sh        |  6 ++--
 t/t6417-merge-ours-theirs.sh    | 10 +++---
 t/t7600-merge.sh                |  2 +-
 t/t7601-merge-pull-config.sh    | 57 ---------------------------------
 t/t7603-merge-reduce-heads.sh   |  2 +-
 13 files changed, 70 insertions(+), 130 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index eb0aabd396..1eb79e2939 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -43,10 +43,16 @@ set to `no` at the beginning of them.
 --no-ff::
 --ff-only::
 	Specifies how a merge is handled when the merged-in history is
-	already a descendant of the current history.  `--ff` is the
-	default unless merging an annotated (and possibly signed) tag
-	that is not stored in its natural place in the `refs/tags/`
-	hierarchy, in which case `--no-ff` is assumed.
+	already a descendant of the current history.
+	+
+	In `git pull`, `--ff-only` is the default unless `--rebase` or
+	`--no-rebase` is specified, in which case the default is `--ff`.
+	However, the default changes again to `--no-ff` in the unlikely
+	scenario where an annotated (and possibly signed) tag that is not
+	stored in its natural place in the `refs/tags/` hierarchy is being
+	merged.
+	+
+	In `git merge`, `--ff` is always the default.
 +
 With `--ff`, when possible resolve the merge as a fast-forward (only
 update the branch pointer to match the merged branch; do not create a
diff --git a/builtin/pull.c b/builtin/pull.c
index 4d80efe5b7..c703560a77 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -292,17 +292,21 @@ static void set_reflog_message(int argc, const char **argv)
 }
 
 /**
- * If pull.ff is unset, returns NULL. If pull.ff is "true", returns "--ff". If
- * pull.ff is "false", returns "--no-ff". If pull.ff is "only", returns
- * "--ff-only". Otherwise, if pull.ff is set to an invalid value, die with an
- * error.
+ * If pull.ff is unset, returns NULL if pull.rebase is set or "--ff-only" if
+ * pull.rebase is not set. If pull.ff is "true", returns "--ff". If pull.ff is
+ * "false", returns "--no-ff". If pull.ff is "only", returns "--ff-only".
+ * Otherwise, if pull.ff is set to an invalid value, die with an error.
  */
 static const char *config_get_ff(void)
 {
 	const char *value;
 
-	if (git_config_get_value("pull.ff", &value))
-		return NULL;
+	if (git_config_get_value("pull.ff", &value)) {
+		if (opt_rebase < 0)
+			return "--ff-only";
+		else
+			return NULL;
+	}
 
 	switch (git_parse_maybe_bool(value)) {
 	case 0:
@@ -322,7 +326,7 @@ static const char *config_get_ff(void)
  * value of "branch.$curr_branch.rebase", where $curr_branch is the current
  * branch, and if HEAD is detached or the configuration key does not exist,
  * looks for the value of "pull.rebase". If both configuration keys do not
- * exist, returns REBASE_FALSE.
+ * exist, returns REBASE_INVALID.
  */
 static enum rebase_type config_get_rebase(void)
 {
@@ -344,23 +348,7 @@ static enum rebase_type config_get_rebase(void)
 	if (!git_config_get_value("pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
 
-	if (opt_verbosity >= 0 && !opt_ff) {
-		warning(_("Starting in Git 3.0, the default behavior of `git pull` will change\n"
-			"when it is not specified how to reconcile divergent branches. You can\n"
-			"squelch this message by running one of the following commands sometime\n"
-			"before your next pull:\n"
-			"\n"
-			"  git config pull.rebase false  # merge (the current default)\n"
-			"  git config pull.rebase true   # rebase\n"
-			"  git config pull.ff only       # fast-forward only (the future default)\n"
-			"\n"
-			"You can replace \"git config\" with \"git config --global\" to set a default\n"
-			"preference for all repositories. You can also pass --rebase, --no-rebase,\n"
-			"or --ff-only on the command line to override the configured default per\n"
-			"invocation.\n"));
-	}
-
-	return REBASE_FALSE;
+	return REBASE_INVALID;
 }
 
 /**
@@ -931,11 +919,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
+	if (opt_rebase < 0)
+		opt_rebase = config_get_rebase();
+
 	if (!opt_ff)
 		opt_ff = xstrdup_or_null(config_get_ff());
 
 	if (opt_rebase < 0)
-		opt_rebase = config_get_rebase();
+		opt_rebase = REBASE_FALSE;
 
 	if (read_cache_unmerged())
 		die_resolve_conflict("pull");
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 9fae07cdfa..856eccd706 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -15,7 +15,7 @@ test_pull_autostash () {
 	git reset --hard before-rebase &&
 	echo dirty >new_file &&
 	git add new_file &&
-	git pull "$@" . copy &&
+	git pull --ff "$@" . copy &&
 	test_cmp_rev HEAD^"$expect_parent_num" copy &&
 	echo dirty >expect &&
 	test_cmp expect new_file &&
@@ -27,7 +27,7 @@ test_pull_autostash_fail () {
 	git reset --hard before-rebase &&
 	echo dirty >new_file &&
 	git add new_file &&
-	test_must_fail git pull "$@" . copy 2>err &&
+	test_must_fail git pull --ff "$@" . copy 2>err &&
 	test_i18ngrep -E "uncommitted changes.|overwritten by merge:" err
 }
 
@@ -210,7 +210,7 @@ test_expect_success 'fail if upstream branch does not exist' '
 	test_config branch.test.merge refs/heads/nonexisting &&
 	echo file >expect &&
 	test_cmp expect file &&
-	test_must_fail git pull 2>err &&
+	test_must_fail git pull --no-rebase 2>err &&
 	test_i18ngrep "no such ref was fetched" err &&
 	test_cmp expect file
 '
@@ -223,17 +223,17 @@ test_expect_success 'fail if the index has unresolved entries' '
 	test_commit modified2 file &&
 	git ls-files -u >unmerged &&
 	test_must_be_empty unmerged &&
-	test_must_fail git pull . second &&
+	test_must_fail git pull --no-rebase . second &&
 	git ls-files -u >unmerged &&
 	test_file_not_empty unmerged &&
 	cp file expected &&
-	test_must_fail git pull . second 2>err &&
+	test_must_fail git pull --no-rebase . second 2>err &&
 	test_i18ngrep "Pulling is not possible because you have unmerged files." err &&
 	test_cmp expected file &&
 	git add file &&
 	git ls-files -u >unmerged &&
 	test_must_be_empty unmerged &&
-	test_must_fail git pull . second 2>err &&
+	test_must_fail git pull --no-rebase . second 2>err &&
 	test_i18ngrep "You have not concluded your merge" err &&
 	test_cmp expected file
 '
@@ -243,7 +243,7 @@ test_expect_success 'fast-forwards working tree if branch head is updated' '
 	test_when_finished "git checkout -f copy && git branch -D third" &&
 	echo file >expect &&
 	test_cmp expect file &&
-	git pull . second:third 2>err &&
+	git pull --no-rebase . second:third 2>err &&
 	test_i18ngrep "fetch updated the current branch head" err &&
 	echo modified >expect &&
 	test_cmp expect file &&
@@ -256,7 +256,7 @@ test_expect_success 'fast-forward fails with conflicting work tree' '
 	echo file >expect &&
 	test_cmp expect file &&
 	echo conflict >file &&
-	test_must_fail git pull . second:third 2>err &&
+	test_must_fail git pull --no-rebase . second:third 2>err &&
 	test_i18ngrep "Cannot fast-forward your working tree" err &&
 	echo conflict >expect &&
 	test_cmp expect file &&
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index db1a381cd9..24801857ec 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -175,8 +175,8 @@ test_expect_success 'git pull --allow-unrelated-histories' '
 	) &&
 	(
 		cd dst &&
-		test_must_fail git pull ../src side &&
-		git pull --allow-unrelated-histories ../src side
+		test_must_fail git pull --no-rebase ../src side &&
+		git pull --no-rebase --allow-unrelated-histories ../src side
 	)
 '
 
diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
index c278adaa5a..b2be3605f5 100755
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
index 7622981cbf..53b9add9f6 100755
--- a/t/t5553-set-upstream.sh
+++ b/t/t5553-set-upstream.sh
@@ -105,34 +105,34 @@ test_expect_success 'setup commit on master and other pull' '
 
 test_expect_success 'pull --set-upstream upstream master sets branch master but not other' '
 	clear_config master other &&
-	git pull --set-upstream upstream master &&
+	git pull --no-rebase --set-upstream upstream master &&
 	check_config master upstream refs/heads/master &&
 	check_config_missing other
 '
 
 test_expect_success 'pull --set-upstream master:other2 does not set the branch other2' '
 	clear_config other2 &&
-	git pull --set-upstream upstream master:other2 &&
+	git pull --no-rebase --set-upstream upstream master:other2 &&
 	check_config_missing other2
 '
 
 test_expect_success 'pull --set-upstream upstream other sets branch master' '
 	clear_config master other &&
-	git pull --set-upstream upstream other &&
+	git pull --no-rebase --set-upstream upstream other &&
 	check_config master upstream refs/heads/other &&
 	check_config_missing other
 '
 
 test_expect_success 'pull --set-upstream upstream tag does not set the tag' '
 	clear_config three &&
-	git pull --tags --set-upstream upstream three &&
+	git pull --no-rebase --tags --set-upstream upstream three &&
 	check_config_missing three
 '
 
 test_expect_success 'pull --set-upstream http://nosuchdomain.example.com fails with invalid url' '
 	# master explicitly not cleared, we check that it is not touched from previous value
 	clear_config other other2 three &&
-	test_must_fail git pull --set-upstream http://nosuchdomain.example.com &&
+	test_must_fail git pull --no-rebase --set-upstream http://nosuchdomain.example.com &&
 	check_config master upstream refs/heads/other &&
 	check_config_missing other &&
 	check_config_missing other2 &&
@@ -141,16 +141,16 @@ test_expect_success 'pull --set-upstream http://nosuchdomain.example.com fails w
 
 test_expect_success 'pull --set-upstream upstream HEAD sets branch HEAD' '
 	clear_config master other &&
-	git pull --set-upstream upstream HEAD &&
+	git pull --no-rebase --set-upstream upstream HEAD &&
 	check_config master upstream HEAD &&
 	git checkout other &&
-	git pull --set-upstream upstream HEAD &&
+	git pull --no-rebase --set-upstream upstream HEAD &&
 	check_config other upstream HEAD
 '
 
 test_expect_success 'pull --set-upstream upstream with more than one branch does nothing' '
 	clear_config master three &&
-	git pull --set-upstream upstream master three &&
+	git pull --no-rebase --set-upstream upstream master three &&
 	check_config_missing master &&
 	check_config_missing three
 '
@@ -159,7 +159,7 @@ test_expect_success 'pull --set-upstream with valid URL sets upstream to URL' '
 	clear_config master other other2 &&
 	git checkout master &&
 	url="file://$PWD" &&
-	git pull --set-upstream "$url" &&
+	git pull --no-rebase --set-upstream "$url" &&
 	check_config master "$url" HEAD &&
 	check_config_missing other &&
 	check_config_missing other2
@@ -169,7 +169,7 @@ test_expect_success 'pull --set-upstream with valid URL and branch sets branch'
 	clear_config master other other2 &&
 	git checkout master &&
 	url="file://$PWD" &&
-	git pull --set-upstream "$url" master &&
+	git pull --no-rebase --set-upstream "$url" master &&
 	check_config master "$url" refs/heads/master &&
 	check_config_missing other &&
 	check_config_missing other2
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 2f7be23044..b9e11eceec 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -84,7 +84,7 @@ test_expect_success 'updating origin' '
 '
 
 test_expect_success 'pulling changes from origin' '
-	git -C C pull origin
+	git -C C pull --no-rebase origin
 '
 
 # the 2 local objects are commit and tree from the merge
@@ -93,7 +93,7 @@ test_expect_success 'that alternate to origin gets used' '
 '
 
 test_expect_success 'pulling changes from origin' '
-	git -C D pull origin
+	git -C D pull --no-rebase origin
 '
 
 # the 5 local objects are expected; file3 blob, commit in A to add it
diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 3f64f62224..ad140a8def 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -100,7 +100,7 @@ test_expect_success 'setup' '
 test_expect_success 'pull renaming branch into unrenaming one' \
 '
 	git show-branch &&
-	test_expect_code 1 git pull . white &&
+	test_expect_code 1 git pull --no-rebase . white &&
 	git ls-files -s &&
 	git ls-files -u B >b.stages &&
 	test_line_count = 3 b.stages &&
@@ -118,7 +118,7 @@ test_expect_success 'pull renaming branch into another renaming one' \
 	rm -f B &&
 	git reset --hard &&
 	git checkout red &&
-	test_expect_code 1 git pull . white &&
+	test_expect_code 1 git pull --no-rebase . white &&
 	git ls-files -u B >b.stages &&
 	test_line_count = 3 b.stages &&
 	git ls-files -s N >n.stages &&
@@ -134,7 +134,7 @@ test_expect_success 'pull unrenaming branch into renaming one' \
 '
 	git reset --hard &&
 	git show-branch &&
-	test_expect_code 1 git pull . master &&
+	test_expect_code 1 git pull --no-rebase . master &&
 	git ls-files -u B >b.stages &&
 	test_line_count = 3 b.stages &&
 	git ls-files -s N >n.stages &&
@@ -150,7 +150,7 @@ test_expect_success 'pull conflicting renames' \
 '
 	git reset --hard &&
 	git show-branch &&
-	test_expect_code 1 git pull . blue &&
+	test_expect_code 1 git pull --no-rebase . blue &&
 	git ls-files -u A >a.stages &&
 	test_line_count = 1 a.stages &&
 	git ls-files -u B >b.stages &&
@@ -170,7 +170,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git reset --hard &&
 	git show-branch &&
 	echo >A this file should not matter &&
-	test_expect_code 1 git pull . white &&
+	test_expect_code 1 git pull --no-rebase . white &&
 	test_path_is_file A
 '
 
@@ -180,7 +180,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git show-branch &&
 	rm -f A &&
 	echo >A this file should not matter &&
-	test_expect_code 1 git pull . red &&
+	test_expect_code 1 git pull --no-rebase . red &&
 	test_path_is_file A
 '
 
@@ -190,7 +190,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git checkout -f master &&
 	git tag -f anchor &&
 	git show-branch &&
-	git pull . yellow &&
+	git pull --no-rebase . yellow &&
 	test_path_is_missing M &&
 	git reset --hard anchor
 '
@@ -203,7 +203,7 @@ test_expect_success 'updated working tree file should prevent the merge' '
 	git show-branch &&
 	echo >>M one line addition &&
 	cat M >M.saved &&
-	test_expect_code 128 git pull . yellow &&
+	test_expect_code 128 git pull --no-rebase . yellow &&
 	test_cmp M M.saved &&
 	rm -f M.saved
 '
@@ -217,7 +217,7 @@ test_expect_success 'updated working tree file should prevent the merge' '
 	echo >>M one line addition &&
 	cat M >M.saved &&
 	git update-index M &&
-	test_expect_code 128 git pull . yellow &&
+	test_expect_code 128 git pull --no-rebase . yellow &&
 	test_cmp M M.saved &&
 	rm -f M.saved
 '
@@ -229,7 +229,7 @@ test_expect_success 'interference with untracked working tree file' '
 	git tag -f anchor &&
 	git show-branch &&
 	echo >M this file should not matter &&
-	git pull . master &&
+	git pull --no-rebase . master &&
 	test_path_is_file M &&
 	! {
 		git ls-files -s |
diff --git a/t/t6409-merge-subtree.sh b/t/t6409-merge-subtree.sh
index b8e8b6f642..b79cb0a368 100755
--- a/t/t6409-merge-subtree.sh
+++ b/t/t6409-merge-subtree.sh
@@ -97,7 +97,7 @@ test_expect_success 'merge update' '
 	git checkout -b topic_2 &&
 	git commit -m "update git-gui" &&
 	cd ../git &&
-	git pull -s subtree gui topic_2 &&
+	git pull --no-rebase -s subtree gui topic_2 &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o3 0	git-gui/git-gui.sh" &&
@@ -126,7 +126,7 @@ test_expect_success 'initial ambiguous subtree' '
 test_expect_success 'merge using explicit' '
 	cd ../git &&
 	git reset --hard topic_2 &&
-	git pull -Xsubtree=git-gui gui topic_2 &&
+	git pull --no-rebase -Xsubtree=git-gui gui topic_2 &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o3 0	git-gui/git-gui.sh" &&
@@ -139,7 +139,7 @@ test_expect_success 'merge using explicit' '
 test_expect_success 'merge2 using explicit' '
 	cd ../git &&
 	git reset --hard topic_2 &&
-	git pull -Xsubtree=git-gui2 gui topic_2 &&
+	git pull --no-rebase -Xsubtree=git-gui2 gui topic_2 &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o1 0	git-gui/git-gui.sh" &&
diff --git a/t/t6417-merge-ours-theirs.sh b/t/t6417-merge-ours-theirs.sh
index 0aebc6c028..ba9b100562 100755
--- a/t/t6417-merge-ours-theirs.sh
+++ b/t/t6417-merge-ours-theirs.sh
@@ -66,11 +66,11 @@ test_expect_success 'binary file with -Xours/-Xtheirs' '
 '
 
 test_expect_success 'pull passes -X to underlying merge' '
-	git reset --hard master && git pull -s recursive -Xours . side &&
-	git reset --hard master && git pull -s recursive -X ours . side &&
-	git reset --hard master && git pull -s recursive -Xtheirs . side &&
-	git reset --hard master && git pull -s recursive -X theirs . side &&
-	git reset --hard master && test_must_fail git pull -s recursive -X bork . side
+	git reset --hard master && git pull --no-rebase -s recursive -Xours . side &&
+	git reset --hard master && git pull --no-rebase -s recursive -X ours . side &&
+	git reset --hard master && git pull --no-rebase -s recursive -Xtheirs . side &&
+	git reset --hard master && git pull --no-rebase -s recursive -X theirs . side &&
+	git reset --hard master && test_must_fail git pull --no-rebase -s recursive -X bork . side
 '
 
 test_expect_success SYMLINKS 'symlink with -Xours/-Xtheirs' '
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 1c85f75555..3ad47f0925 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -891,7 +891,7 @@ test_expect_success 'merge annotated/signed tag w/o tracking' '
 		# tag from the "upstream", this pull defaults to --no-ff
 		cd dst &&
 		git pull .. c0 &&
-		git pull .. anno1 &&
+		git pull --no-rebase .. anno1 &&
 		git rev-parse HEAD^2 >actual &&
 		test_cmp expect actual
 	)
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index c5c4ea5fc0..c6c44ec570 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -27,63 +27,6 @@ test_expect_success 'setup' '
 	git tag c3
 '
 
-test_expect_success 'pull.rebase not set' '
-	git reset --hard c0 &&
-	git pull . c1 2>err &&
-	test_i18ngrep "Pulling without specifying how to reconcile" err
-'
-
-test_expect_success 'pull.rebase not set and pull.ff=true' '
-	git reset --hard c0 &&
-	test_config pull.ff true &&
-	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
-'
-
-test_expect_success 'pull.rebase not set and pull.ff=false' '
-	git reset --hard c0 &&
-	test_config pull.ff false &&
-	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
-'
-
-test_expect_success 'pull.rebase not set and pull.ff=only' '
-	git reset --hard c0 &&
-	test_config pull.ff only &&
-	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
-'
-
-test_expect_success 'pull.rebase not set and --rebase given' '
-	git reset --hard c0 &&
-	git pull --rebase . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
-'
-
-test_expect_success 'pull.rebase not set and --no-rebase given' '
-	git reset --hard c0 &&
-	git pull --no-rebase . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
-'
-
-test_expect_success 'pull.rebase not set and --ff given' '
-	git reset --hard c0 &&
-	git pull --ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
-'
-
-test_expect_success 'pull.rebase not set and --no-ff given' '
-	git reset --hard c0 &&
-	git pull --no-ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
-'
-
-test_expect_success 'pull.rebase not set and --ff-only given' '
-	git reset --hard c0 &&
-	git pull --ff-only . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
-'
-
 test_expect_success 'merge c1 with c2' '
 	git reset --hard c1 &&
 	test -f c0.c &&
diff --git a/t/t7603-merge-reduce-heads.sh b/t/t7603-merge-reduce-heads.sh
index 98948955ae..27cd94ad6f 100755
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
2.29.2


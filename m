Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9812BC433F5
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 21:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241069AbiBGVdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 16:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241014AbiBGVdM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 16:33:12 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6D6C061A73
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 13:33:11 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m14so27098227wrg.12
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 13:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gNGD5q/SjVzOkwpQKi5dugiQ1BOgAonIAEOI/Pa9RFI=;
        b=Gg7vcgDm8oWbbXm7c94te7cBlvygJj52sBjyH4SAO7Vmr0FD60PGqDdnSFIxHbqGWy
         423LUzUpMSgwRWl5PAIwOQZKmj2q0SphucxjVu3kkDYMkPGBqs610IHayvbR8ZTGURwt
         VQdQ8iet0rXEzn56k18HKGXEsQ15LGpjuf0HhH3HXIBLjNwZxn6FhZvOCloH/s2K/Lnt
         NdNdmIFaJzvwAtbmXmcyKuqHkRUKa65LhR6ZXWAB4dBN3YRkigeOLbsrgUSiNBPqyjVC
         dR9DnSjHouvNvEYmUaxtcsxhYnO68AmEsXSpn+m8fN1mw00kfQKfXTA99U0KIQvzRl5F
         1Q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gNGD5q/SjVzOkwpQKi5dugiQ1BOgAonIAEOI/Pa9RFI=;
        b=nGSg6UKDHpKU1aEtyDoCiLwweg505LrG4MwZKrh9PPHdl6o8c3Tgko8NYyA7MEozYJ
         geTPw+LJDg4EH5AG4BoyCgRIBUGmvvI5QmnfgxKnbfMy2wjKc9otfCF8FaqYrVGMdCvV
         4HyZgVN2zHLi/QC5LudnvlYuH9YzXOl41tcSp22AT50NM66YD0zutlSgK/CEbdXulMVL
         kblpmiW7OFKKLtK6axspGXacIWMM8xwBg7QXeC5q/9FStJoZClsAnOozfX8QE0HyJ95R
         wFFi6Im823tQ0p7jvQQLpCPJHdCLpQrWwUYIZ7xYWxO2iJTsWrM4ai/tR2THJbcOt2rg
         nD1Q==
X-Gm-Message-State: AOAM533pictaCzaFEX9ngXtrnFuQ1DnDANGAaxjYgIxbMkFIcvGBcxo+
        FKs8IIJqoeuPSZJw0Kl4IKMLRVosOxQ=
X-Google-Smtp-Source: ABdhPJzJ2pah1TEs7FSWPOOCLoY2Dnpib+yBBgmSKgTQnO0zqL593dO7yKloVh/A52wHgDCdV0+cGQ==
X-Received: by 2002:a5d:6850:: with SMTP id o16mr1057237wrw.344.1644269589681;
        Mon, 07 Feb 2022 13:33:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v3sm10661407wru.15.2022.02.07.13.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:33:09 -0800 (PST)
Message-Id: <c51cb3714e7b1d2f8c9370fe87eca9984ff4859f.1644269584.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
        <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Feb 2022 21:33:02 +0000
Subject: [PATCH v6 5/6] worktree: copy sparse-checkout patterns and config on
 add
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        derrickstolee@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When adding a new worktree, it is reasonable to expect that we want to
use the current set of sparse-checkout settings for that new worktree.
This is particularly important for repositories where the worktree would
become too large to be useful. This is even more important when using
partial clone as well, since we want to avoid downloading the missing
blobs for files that should not be written to the new worktree.

The only way to create such a worktree without this intermediate step of
expanding the full worktree is to copy the sparse-checkout patterns and
config settings during 'git worktree add'. Each worktree has its own
sparse-checkout patterns, and the default behavior when the
sparse-checkout file is missing is to include all paths at HEAD. Thus,
we need to have patterns from somewhere, they might as well be the
current worktree's patterns. These are then modified independently in
the future.

In addition to the sparse-checkout file, copy the worktree config file
if worktree config is enabled and the file exists. This will copy over
any important settings to ensure the new worktree behaves the same as
the current one. The only exception we must continue to make is that
core.bare and core.worktree should become unset in the worktree's config
file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/worktree.c                 | 63 ++++++++++++++++++++++++++++++
 t/t1091-sparse-checkout-builtin.sh | 31 +++++++++++----
 t/t2400-worktree-add.sh            | 58 ++++++++++++++++++++++++++-
 3 files changed, 142 insertions(+), 10 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 2838254f7f2..c6eb636329a 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -335,6 +335,69 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
 
+	/*
+	 * If the current worktree has sparse-checkout enabled, then copy
+	 * the sparse-checkout patterns from the current worktree.
+	 */
+	if (core_apply_sparse_checkout) {
+		char *from_file = git_pathdup("info/sparse-checkout");
+		char *to_file = xstrfmt("%s/info/sparse-checkout",
+					sb_repo.buf);
+
+		if (file_exists(from_file)) {
+			if (safe_create_leading_directories(to_file) ||
+			    copy_file(to_file, from_file, 0666))
+				error(_("failed to copy '%s' to '%s'; sparse-checkout may not work correctly"),
+				      from_file, to_file);
+		}
+
+		free(from_file);
+		free(to_file);
+	}
+
+	/*
+	 * If we are using worktree config, then copy all current config
+	 * values from the current worktree into the new one, that way the
+	 * new worktree behaves the same as this one.
+	 */
+	if (repository_format_worktree_config) {
+		char *from_file = git_pathdup("config.worktree");
+		char *to_file = xstrfmt("%s/config.worktree",
+					sb_repo.buf);
+
+		if (file_exists(from_file)) {
+			struct config_set cs = { { 0 } };
+			const char *core_worktree;
+			int bare;
+
+			if (safe_create_leading_directories(to_file) ||
+			    copy_file(to_file, from_file, 0666)) {
+				error(_("failed to copy worktree config from '%s' to '%s'"),
+				      from_file, to_file);
+				goto worktree_copy_cleanup;
+			}
+
+			git_configset_init(&cs);
+			git_configset_add_file(&cs, from_file);
+
+			if (!git_configset_get_bool(&cs, "core.bare", &bare) &&
+			    bare &&
+			    git_config_set_multivar_in_file_gently(
+					to_file, "core.bare", NULL, "true", 0))
+				error(_("failed to unset 'core.bare' in '%s'"), to_file);
+			if (!git_configset_get_value(&cs, "core.worktree", &core_worktree) &&
+			    git_config_set_in_file_gently(to_file,
+							  "core.worktree", NULL))
+				error(_("failed to unset 'core.worktree' in '%s'"), to_file);
+
+			git_configset_clear(&cs);
+		}
+
+worktree_copy_cleanup:
+		free(from_file);
+		free(to_file);
+	}
+
 	strvec_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
 	strvec_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
 	cp.git_cmd = 1;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index be6ea4ffe33..8a757b43e6c 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -146,9 +146,9 @@ test_expect_success 'interaction with clone --no-checkout (unborn index)' '
 '
 
 test_expect_success 'set enables config' '
-	git init empty-config &&
+	git init worktree-config &&
 	(
-		cd empty-config &&
+		cd worktree-config &&
 		test_commit test file &&
 		test_path_is_missing .git/config.worktree &&
 		git sparse-checkout set nothing &&
@@ -201,6 +201,21 @@ test_expect_success 'add to sparse-checkout' '
 	check_files repo "a folder1 folder2"
 '
 
+test_expect_success 'worktree: add copies sparse-checkout patterns' '
+	cat repo/.git/info/sparse-checkout >old &&
+	test_when_finished cp old repo/.git/info/sparse-checkout &&
+	test_when_finished git -C repo worktree remove ../worktree &&
+	git -C repo sparse-checkout set --no-cone "/*" &&
+	git -C repo worktree add --quiet ../worktree 2>err &&
+	test_must_be_empty err &&
+	new="$(git -C worktree rev-parse --git-path info/sparse-checkout)" &&
+	test_path_is_file "$new" &&
+	test_cmp repo/.git/info/sparse-checkout "$new" &&
+	git -C worktree sparse-checkout set --cone &&
+	test_cmp_config -C worktree true core.sparseCheckoutCone &&
+	test_must_fail git -C repo core.sparseCheckoutCone
+'
+
 test_expect_success 'cone mode: match patterns' '
 	git -C repo config --worktree core.sparseCheckoutCone true &&
 	rm -rf repo/a repo/folder1 repo/folder2 &&
@@ -520,13 +535,13 @@ test_expect_success 'interaction with submodules' '
 '
 
 test_expect_success 'different sparse-checkouts with worktrees' '
+	git -C repo sparse-checkout set --cone deep folder1 &&
 	git -C repo worktree add --detach ../worktree &&
-	check_files worktree "a deep folder1 folder2" &&
-	git -C worktree sparse-checkout init --cone &&
-	git -C repo sparse-checkout set folder1 &&
-	git -C worktree sparse-checkout set deep/deeper1 &&
-	check_files repo a folder1 &&
-	check_files worktree a deep
+	check_files worktree "a deep folder1" &&
+	git -C repo sparse-checkout set --cone folder1 &&
+	git -C worktree sparse-checkout set --cone deep/deeper1 &&
+	check_files repo "a folder1" &&
+	check_files worktree "a deep"
 '
 
 test_expect_success 'set using filename keeps file on-disk' '
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 37ad79470fb..43139af08fc 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -165,8 +165,62 @@ test_expect_success '"add" default branch of a bare repo' '
 	(
 		git clone --bare . bare2 &&
 		cd bare2 &&
-		git worktree add ../there3 main
-	)
+		git worktree add ../there3 main &&
+		cd ../there3 &&
+		# Simple check that a Git command does not
+		# immediately fail with the current setup
+		git status
+	) &&
+	cat >expect <<-EOF &&
+	init.t
+	EOF
+	ls there3 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '"add" to bare repo with worktree config' '
+	(
+		git clone --bare . bare3 &&
+		cd bare3 &&
+		git config extensions.worktreeconfig true &&
+
+		# Add config values that are erroneous to have in
+		# a config.worktree file outside of the main
+		# working tree, to check that Git filters them out
+		# when copying config during "git worktree add".
+		git config --worktree core.bare true &&
+		git config --worktree core.worktree "$(pwd)" &&
+
+		# We want to check that bogus.key is copied
+		git config --worktree bogus.key value &&
+		git config --unset core.bare &&
+		git worktree add ../there4 main &&
+		cd ../there4 &&
+
+		# Simple check that a Git command does not
+		# immediately fail with the current setup
+		git status &&
+		git worktree add --detach ../there5 &&
+		cd ../there5 &&
+		git status
+	) &&
+
+	# the worktree has the arbitrary value copied.
+	test_cmp_config -C there4 value bogus.key &&
+	test_cmp_config -C there5 value bogus.key &&
+
+	# however, core.bare and core.worktree were removed.
+	test_must_fail git -C there4 config core.bare &&
+	test_must_fail git -C there4 config core.worktree &&
+
+	cat >expect <<-EOF &&
+	init.t
+	EOF
+
+	ls there4 >actual &&
+	test_cmp expect actual &&
+	ls there5 >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'checkout with grafts' '
-- 
gitgitgadget


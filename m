Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4011DC433EF
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 21:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241388AbiBGVdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 16:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240971AbiBGVdL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 16:33:11 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B20C0612A4
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 13:33:10 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e3so13207931wra.0
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 13:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ABpkPLaMlQSyuii/h6Kzk3rFjsx7ver4X6LdDJV17Rs=;
        b=lhE+10Xf5jeqIjFVCjp4xDh/t0myigWeLFo0dgvyCaLImr7ApgJmhZEmAAN+4q7kfD
         UOhYlqb64kJzENaIjrcO045T1gZBksh9IxcQ82wGu0bap1oXTaXMoaQyqu1lRFk0A5ON
         nZ8eqIJqzYhF1Rj0rpZcaLXhtd2fxC8boCQPK/fKtdCU4e7Wo4vYHZlNrZLqzKCiHurZ
         3sMQzmKGJLUFKdfUGKl+vK6t3YebwG9zNnttUUVIJaV3GimxFtayz5xMwy/Zdqv33+EH
         i8G/wj0CVlIBBZs4to/X2aw/8UVENLMkZYQoz98TkqLWW6P+Gsz84JjKpguxp1DJAP3w
         cTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ABpkPLaMlQSyuii/h6Kzk3rFjsx7ver4X6LdDJV17Rs=;
        b=S6x81Yac4vfNxLy80ZcAjOFXUNJ9rv5HTlJDF8Lt/jZ1aXy3KgoIWJaRNdzGPVZVj4
         Dp/EYtHRMW37tkKjV71H7FflRECRuLQc0/wfcEHTkQSNqFxwaLskStk61Py3uiuLApC1
         a4kkbS48PKqObFCA2A1owMKiV5xRtf2qC6P6k1X5cUqc1rsCDd0Gs4QrX7jVw5WSBDU7
         jTT8RhN3ELcHhv65LP4X5JJ6kE/WushgutaEuO4yVxjtt63ka8aXHDw1AP2uQ0LEU75G
         ErIGWwwAvegpZbdMm2Buo0WSe1VVmcBv3Nd35AJBMgtnLfcVfL9j5VehroLgQSRYwvHw
         1wNw==
X-Gm-Message-State: AOAM531rUgjV+kRoibMq0fPIxpAyghTW9Gn6F1AZm01ZZVwMpPAlbErY
        3IU405Ddl2d6voz9+rDTCh0QGplAdRs=
X-Google-Smtp-Source: ABdhPJzVEB5ILes54ZxMvWUK4DTBBnyGDm0u9EPrUmTgmGPf2mXA5ohGiEI4rZ+cVZbEgot4JrP3iA==
X-Received: by 2002:adf:f3d2:: with SMTP id g18mr1099890wrp.484.1644269588852;
        Mon, 07 Feb 2022 13:33:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c13sm11080647wrv.24.2022.02.07.13.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:33:08 -0800 (PST)
Message-Id: <5b5924eab498c40542f42989fb31f568cb5371b2.1644269583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
        <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Feb 2022 21:33:01 +0000
Subject: [PATCH v6 4/6] sparse-checkout: set worktree-config correctly
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

`git sparse-checkout set/init` enables worktree-specific
configuration[*] by setting extensions.worktreeConfig=true, but neglects
to perform the additional necessary bookkeeping of relocating
`core.bare=true` and `core.worktree` from $GIT_COMMON_DIR/config to
$GIT_COMMON_DIR/config.worktree, as documented in git-worktree.txt. As a
result of this oversight, these settings, which are nonsensical for
secondary worktrees, can cause Git commands to incorrectly consider a
worktree bare (in the case of `core.bare`) or operate on the wrong
worktree (in the case of `core.worktree`). Fix this problem by taking
advantage of the recently-added init_worktree_config() which enables
`extensions.worktreeConfig` and takes care of necessary bookkeeping.

While at it, for backward-compatibility reasons, also stop upgrading the
repository format to "1" since doing so is (unintentionally) not
required to take advantage of `extensions.worktreeConfig`, as explained
by 11664196ac ("Revert "check_repository_format_gently(): refuse
extensions for old repositories"", 2020-07-15).

[*] The main reason to use worktree-specific config for the
sparse-checkout builtin was to avoid enabling sparse-checkout patterns
in one and causing a loss of files in another. If a worktree does not
have a sparse-checkout patterns file, then the sparse-checkout logic
will not kick in on that worktree.

Reported-by: Sean Allred <allred.sean@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt | 16 +++++++++++----
 builtin/sparse-checkout.c             | 28 +++++++++++++--------------
 sparse-index.c                        | 10 +++-------
 t/t1091-sparse-checkout-builtin.sh    |  4 ++--
 4 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index b81dbe06543..94dad137b96 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -31,13 +31,21 @@ COMMANDS
 	Describe the patterns in the sparse-checkout file.
 
 'set'::
-	Enable the necessary config settings
-	(extensions.worktreeConfig, core.sparseCheckout,
-	core.sparseCheckoutCone) if they are not already enabled, and
-	write a set of patterns to the sparse-checkout file from the
+	Enable the necessary sparse-checkout config settings
+	(`core.sparseCheckout`, `core.sparseCheckoutCone`, and
+	`index.sparse`) if they are not already set to the desired values,
+	and write a set of patterns to the sparse-checkout file from the
 	list of arguments following the 'set' subcommand. Update the
 	working directory to match the new patterns.
 +
+To ensure that adjusting the sparse-checkout settings within a worktree
+does not alter the sparse-checkout settings in other worktrees, the 'set'
+subcommand will upgrade your repository config to use worktree-specific
+config if not already present. The sparsity defined by the arguments to
+the 'set' subcommand are stored in the worktree-specific sparse-checkout
+file. See linkgit:git-worktree[1] and the documentation of
+`extensions.worktreeConfig` in linkgit:git-config[1] for more details.
++
 When the `--stdin` option is provided, the patterns are read from
 standard in as a newline-delimited list instead of from the arguments.
 +
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 679c1070368..314c8d61f80 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -15,6 +15,7 @@
 #include "wt-status.h"
 #include "quote.h"
 #include "sparse-index.h"
+#include "worktree.h"
 
 static const char *empty_base = "";
 
@@ -359,26 +360,23 @@ enum sparse_checkout_mode {
 
 static int set_config(enum sparse_checkout_mode mode)
 {
-	const char *config_path;
-
-	if (upgrade_repository_format(1) < 0)
-		die(_("unable to upgrade repository format to enable worktreeConfig"));
-	if (git_config_set_gently("extensions.worktreeConfig", "true")) {
-		error(_("failed to set extensions.worktreeConfig setting"));
+	/* Update to use worktree config, if not already. */
+	if (init_worktree_config(the_repository)) {
+		error(_("failed to initialize worktree config"));
 		return 1;
 	}
 
-	config_path = git_path("config.worktree");
-	git_config_set_in_file_gently(config_path,
-				      "core.sparseCheckout",
-				      mode ? "true" : NULL);
-
-	git_config_set_in_file_gently(config_path,
-				      "core.sparseCheckoutCone",
-				      mode == MODE_CONE_PATTERNS ? "true" : NULL);
+	if (repo_config_set_worktree_gently(the_repository,
+					    "core.sparseCheckout",
+					    mode ? "true" : "false") ||
+	    repo_config_set_worktree_gently(the_repository,
+					    "core.sparseCheckoutCone",
+					    mode == MODE_CONE_PATTERNS ?
+						"true" : "false"))
+		return 1;
 
 	if (mode == MODE_NO_PATTERNS)
-		set_sparse_index_config(the_repository, 0);
+		return set_sparse_index_config(the_repository, 0);
 
 	return 0;
 }
diff --git a/sparse-index.c b/sparse-index.c
index a1d505d50e9..e93609999e0 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -99,13 +99,9 @@ static int convert_to_sparse_rec(struct index_state *istate,
 
 int set_sparse_index_config(struct repository *repo, int enable)
 {
-	int res;
-	char *config_path = repo_git_path(repo, "config.worktree");
-	res = git_config_set_in_file_gently(config_path,
-					    "index.sparse",
-					    enable ? "true" : NULL);
-	free(config_path);
-
+	int res = repo_config_set_worktree_gently(repo,
+						  "index.sparse",
+						  enable ? "true" : "false");
 	prepare_repo_settings(repo);
 	repo->settings.sparse_index = enable;
 	return res;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 42776984fe7..be6ea4ffe33 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -117,7 +117,7 @@ test_expect_success 'switching to cone mode with non-cone mode patterns' '
 		cd bad-patterns &&
 		git sparse-checkout init &&
 		git sparse-checkout add dir &&
-		git config core.sparseCheckoutCone true &&
+		git config --worktree core.sparseCheckoutCone true &&
 		test_must_fail git sparse-checkout add dir 2>err &&
 		grep "existing sparse-checkout patterns do not use cone mode" err
 	)
@@ -256,7 +256,7 @@ test_expect_success 'sparse-index enabled and disabled' '
 		test_cmp expect actual &&
 
 		git -C repo config --list >config &&
-		! grep index.sparse config
+		test_cmp_config -C repo false index.sparse
 	)
 '
 
-- 
gitgitgadget


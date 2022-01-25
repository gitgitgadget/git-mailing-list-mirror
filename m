Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C00C433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 18:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiAYSnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 13:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbiAYSmW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 13:42:22 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84637C06174E
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 10:42:21 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id f17so21574406wrx.1
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 10:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z92cXzxOMOXSQJrB/5DWqYVgOFHRRQCuflcw+BRqa50=;
        b=pxCWj/GTKnsC15KHuh6OEpmw4TNT9sHcLAkKZIXa02T9rPfS/1itH+Ujr4qFvGbLrU
         g8USXCDdV+oxyXpG+Nl942DGfQ1Ijd2ySTDIe85M4wdpnEDYxWAhv4sZHOWMRUFKL7qp
         7mf/PtJLq0x9Ocy/YDFWrqD9NhpUKRYWJZLSRuoiqGijDDEKlbImOQnoKo1ScwaUs0Lu
         53XhyfnOJ9pADRONi68YoYcYxfh7Cf+sfaq4JKsrwkU9dBjF+3jcAtGVt6CKRXXEUNCJ
         H+tja978LGClYshg9sfB/ZiUwSBh1ghXHSlAhVKFJuwttABZYpCM5XMu4OHmn+8zuKvH
         N1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Z92cXzxOMOXSQJrB/5DWqYVgOFHRRQCuflcw+BRqa50=;
        b=mrpO5sLdA0daFvN7zLK2Xn737oTlLbwneNEfC+TsTNGWVT3S7dLVg5KgvRIjc8Np+p
         CIXpsZb78tL723yAS0W5TNiRKhIpw86qEHmluSORV7rIzZ4c3B2dPd5jTfFAfEfWPT86
         YR2KMZifjrNlO7CP4xs7sZWyGATwQu29uNOfDWtYkkoOnBd925tIc0PdfKBYqcwCsjA1
         we/1XgSXiqEKEX46FYl26loOOyzjo0dHOscbb3+iyB3xLlpSLD8wSyLFHNBtmDDJnz6d
         BheNtfwrxcpxFnosQAGUiWK0lHKLWmhL8NhQEtQgbojZSzodHz4GyQ1kZiBgvF4jeiVr
         IZow==
X-Gm-Message-State: AOAM532oXOscCE7DVH8WWd33YPaGlZgbnyANouZCP9VuScspEq3lUWln
        gZ1aLF+XeluxkpSTaC8AahoIG3eZYfC5ww==
X-Google-Smtp-Source: ABdhPJxgSAaZOVKSL1iTyjO4vLG2S9FZ3yPb3DNAxvcorrFn069N0To6N38DD7PajATdq+/TY68PWA==
X-Received: by 2002:a05:6000:42:: with SMTP id k2mr19206455wrx.178.1643136139883;
        Tue, 25 Jan 2022 10:42:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3sm7603970wrs.55.2022.01.25.10.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 10:42:19 -0800 (PST)
Message-Id: <fbfaa17797c023f4a86eeac200a83c2e1954daf5.1643136134.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
References: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
        <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Jan 2022 18:42:13 +0000
Subject: [PATCH v4 4/5] sparse-checkout: set worktree-config correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The previous change added repo_config_set_worktree_gently() to assist
writing config values into the config.worktree file, if enabled. An
earlier change added init_worktree_config() as a helper to initialize
extensions.worktreeConfig if not already enabled.

Let the sparse-checkout builtin use these helpers instead of attempting to
initialize the worktree config on its own. This changes behavior of 'git
sparse-checkout set' in a few important ways:

 1. Git will no longer upgrade the repository format, since this is not
    a requirement for understanding extensions.worktreeConfig.

 2. If the main worktree is bare, then this command will not put the
    worktree in a broken state.

The main reason to use worktree-specific config for the sparse-checkout
builtin was to avoid enabling sparse-checkout patterns in one and
causing a loss of files in another. If a worktree does not have a
sparse-checkout patterns file, then the sparse-checkout logic will not
kick in on that worktree.

Reported-by: Sean Allred <allred.sean@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt | 24 ++++++++++++++++-------
 builtin/sparse-checkout.c             | 28 +++++++++++++--------------
 sparse-index.c                        | 10 +++-------
 t/t1091-sparse-checkout-builtin.sh    |  4 ++--
 4 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index b81dbe06543..c6eae3ec7fd 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -31,12 +31,20 @@ COMMANDS
 	Describe the patterns in the sparse-checkout file.
 
 'set'::
-	Enable the necessary config settings
-	(extensions.worktreeConfig, core.sparseCheckout,
-	core.sparseCheckoutCone) if they are not already enabled, and
-	write a set of patterns to the sparse-checkout file from the
-	list of arguments following the 'set' subcommand. Update the
-	working directory to match the new patterns.
+	Enable the necessary sparse-checkout config settings
+	(`core.sparseCheckout` and possibly `core.sparseCheckoutCone`) if
+	they are not already enabled, and write a set of patterns to the
+	sparse-checkout file from the list of arguments following the
+	'set' subcommand. Update the working directory to match the new
+	patterns.
++
+To ensure that adjusting the sparse-checkout settings within a worktree
+does not alter the sparse-checkout settings in other worktrees, the 'set'
+subcommand will upgrade your repository config to use worktree-specific
+config if not already present. The sparsity defined by the arguments to
+the 'set' subcommand are stored in the worktree-specific sparse-checkout
+file. See linkgit:git-worktree[1] and the documentation of
+`extensions.worktreeConfig` in linkgit:git-config[1] for more details.
 +
 When the `--stdin` option is provided, the patterns are read from
 standard in as a newline-delimited list instead of from the arguments.
@@ -73,7 +81,9 @@ interact with your repository until it is disabled.
 	By default, these patterns are read from the command-line arguments,
 	but they can be read from stdin using the `--stdin` option. When
 	`core.sparseCheckoutCone` is enabled, the given patterns are interpreted
-	as directory names as in the 'set' subcommand.
+	as directory names as in the 'set' subcommand. The sparsity defined
+	by the arguments to the 'add' subcommand are added to the patterns
+	in the worktree-specific sparse-checkout file.
 
 'reapply'::
 	Reapply the sparsity pattern rules to paths in the working tree.
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


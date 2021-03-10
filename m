Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F8FC4321A
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2037564FDE
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbhCJTby (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbhCJTbS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:31:18 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA7FC061761
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:18 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d15so24637321wrv.5
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cPtFZCkvkX2KLRtyrHWEELrhALm1VwPtUV70W83IOCw=;
        b=f77GmvVnKR+NPTyBcz+nG6oEZJjmR7imzMRfv4A3qB5splKG1eyETy8rFALwdD11sY
         4NeQwNaA7pFtrrOgb8TZo6834h+VGzvTT80MRARWZyuJgs7M2ev3yyV8ClXYmuIJRqdF
         KYaXAkvwRmkRynEk/R4ZA+lOXZz77wyrBIRZN4LFrk+ib1kdrcxJe2Ejir8L6eX6lRRH
         f0Iodo/NgpVr80fCx+DrioLZMTK107057+uuIrSQ5hBlSNZUrGNN36tiuO7rnqKhuo+v
         aCctt2FxA/CSusZQbZ1q2uozerzSXVfRa2O0ovyTSCCBm2gavJ6Y25FlLlIZ90dEHqSS
         Av3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cPtFZCkvkX2KLRtyrHWEELrhALm1VwPtUV70W83IOCw=;
        b=mK/SlLXDC1yEC5gYmUMuWj8Pi4RiRV4PLluGlRKG1v9P/f7Qc5M1FbyXq8GGwRmcdZ
         ffA+fjxpaJqgivKOPyugdConRIHmoEltLC4B4VUzEx5Jw8h8u1gpv6LVfz5V3kEgbbrG
         lKiWMmygh1CtolYZZsa6/+1qmr7IL1hkrv52i5aKD8VlXoWTXhpveDJ62aEZISZqREIT
         6nt/cdzxcgn72FcYIREnZXGXmgohRIS5/IkB8Xtgvm6I97fyUdtEyBJXqzUXVSV9y1AP
         vt1IwUGiVj/AtRKnBfnEjswvre7Ang7NC6WxrWeNtZf1qT1SDHS0cr/q0Uex18aTI4La
         4G4Q==
X-Gm-Message-State: AOAM530YFJzxsYTRHj8xNw2LSTjyRTMIVQXsVxulnW0tNSQjwQdQ5lPb
        iE+HtX778MMPZ29Gzjv1AjMTrGBeUz8=
X-Google-Smtp-Source: ABdhPJwwa/LpHkfVo8O/KBVMTrwS7qO8SgPSvOfSD7QYW29EZoZRzTxfK5aggNaM+GguqXRR1pFCSA==
X-Received: by 2002:a5d:6684:: with SMTP id l4mr5044469wru.381.1615404677098;
        Wed, 10 Mar 2021 11:31:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d29sm310175wra.51.2021.03.10.11.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:31:16 -0800 (PST)
Message-Id: <e530ca5f668d2b3d3583133ba3b539a3ef69181d.1615404665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
        <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Mar 2021 19:30:59 +0000
Subject: [PATCH v2 16/20] sparse-checkout: toggle sparse index from builtin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The sparse index extension is used to signal that index writes should be
in sparse mode. This was only updated using GIT_TEST_SPARSE_INDEX=1.

Add a '--[no-]sparse-index' option to 'git sparse-checkout init' that
specifies if the sparse index should be used. It also updates the index
to use the correct format, either way. Add a warning in the
documentation that the use of a repository extension might reduce
compatibility with third-party tools. 'git sparse-checkout init' already
sets extension.worktreeConfig, which places most sparse-checkout users
outside of the scope of most third-party tools.

Update t1092-sparse-checkout-compatibility.sh to use this CLI instead of
GIT_TEST_SPARSE_INDEX=1.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt    | 14 +++++++++
 builtin/sparse-checkout.c                | 17 ++++++++++-
 sparse-index.c                           | 37 +++++++++++++++--------
 sparse-index.h                           |  3 ++
 t/t1092-sparse-checkout-compatibility.sh | 38 +++++++++++-------------
 5 files changed, 76 insertions(+), 33 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index a0eeaeb02ee3..4a8343cf7fa4 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -45,6 +45,20 @@ To avoid interfering with other worktrees, it first enables the
 When `--cone` is provided, the `core.sparseCheckoutCone` setting is
 also set, allowing for better performance with a limited set of
 patterns (see 'CONE PATTERN SET' below).
++
+Use the `--[no-]sparse-index` option to toggle the use of the sparse
+index format. This reduces the size of the index to be more closely
+aligned with your sparse-checkout definition. This can have significant
+performance advantages for commands such as `git status` or `git add`.
+This feature is still experimental. Some commands might be slower with
+a sparse index until they are properly integrated with the feature.
++
+**WARNING:** Using a sparse index requires modifying the index in a way
+that is not completely understood by external tools. If you have trouble
+with this compatibility, then run `git sparse-checkout sparse-index disable`
+to rewrite your index to not be sparse. Older versions of Git will not
+understand the `sparseIndex` repository extension and may fail to interact
+with your repository until it is disabled.
 
 'set'::
 	Write a set of patterns to the sparse-checkout file, as given as
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index e00b82af727b..ca63e2c64e95 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -14,6 +14,7 @@
 #include "unpack-trees.h"
 #include "wt-status.h"
 #include "quote.h"
+#include "sparse-index.h"
 
 static const char *empty_base = "";
 
@@ -283,12 +284,13 @@ static int set_config(enum sparse_checkout_mode mode)
 }
 
 static char const * const builtin_sparse_checkout_init_usage[] = {
-	N_("git sparse-checkout init [--cone]"),
+	N_("git sparse-checkout init [--cone] [--[no-]sparse-index]"),
 	NULL
 };
 
 static struct sparse_checkout_init_opts {
 	int cone_mode;
+	int sparse_index;
 } init_opts;
 
 static int sparse_checkout_init(int argc, const char **argv)
@@ -303,11 +305,15 @@ static int sparse_checkout_init(int argc, const char **argv)
 	static struct option builtin_sparse_checkout_init_options[] = {
 		OPT_BOOL(0, "cone", &init_opts.cone_mode,
 			 N_("initialize the sparse-checkout in cone mode")),
+		OPT_BOOL(0, "sparse-index", &init_opts.sparse_index,
+			 N_("toggle the use of a sparse index")),
 		OPT_END(),
 	};
 
 	repo_read_index(the_repository);
 
+	init_opts.sparse_index = -1;
+
 	argc = parse_options(argc, argv, NULL,
 			     builtin_sparse_checkout_init_options,
 			     builtin_sparse_checkout_init_usage, 0);
@@ -326,6 +332,15 @@ static int sparse_checkout_init(int argc, const char **argv)
 	sparse_filename = get_sparse_checkout_filename();
 	res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL);
 
+	if (init_opts.sparse_index >= 0) {
+		if (set_sparse_index_config(the_repository, init_opts.sparse_index) < 0)
+			die(_("failed to modify sparse-index config"));
+
+		/* force an index rewrite */
+		repo_read_index(the_repository);
+		the_repository->index->updated_workdir = 1;
+	}
+
 	/* If we already have a sparse-checkout file, use it. */
 	if (res >= 0) {
 		free(sparse_filename);
diff --git a/sparse-index.c b/sparse-index.c
index b9c14ef7ab50..1c84cac255bf 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -104,23 +104,37 @@ static int convert_to_sparse_rec(struct index_state *istate,
 
 static int enable_sparse_index(struct repository *repo)
 {
-	const char *config_path = repo_git_path(repo, "config.worktree");
+	int res;
 
 	if (upgrade_repository_format(1) < 0) {
 		warning(_("unable to upgrade repository format to enable sparse-index"));
 		return -1;
 	}
-	git_config_set_in_file_gently(config_path,
-				      "extensions.sparseIndex",
-				      "true");
+	res = git_config_set_gently("extensions.sparseindex", "true");
 
 	prepare_repo_settings(repo);
 	repo->settings.sparse_index = 1;
-	return 0;
+	return res;
+}
+
+int set_sparse_index_config(struct repository *repo, int enable)
+{
+	int res;
+
+	if (enable)
+		return enable_sparse_index(repo);
+
+	/* Don't downgrade repository format, just remove the extension. */
+	res = git_config_set_gently("extensions.sparseindex", NULL);
+
+	prepare_repo_settings(repo);
+	repo->settings.sparse_index = 0;
+	return res;
 }
 
 int convert_to_sparse(struct index_state *istate)
 {
+	int test_env;
 	if (istate->split_index || istate->sparse_index ||
 	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
@@ -129,14 +143,13 @@ int convert_to_sparse(struct index_state *istate)
 		istate->repo = the_repository;
 
 	/*
-	 * The GIT_TEST_SPARSE_INDEX environment variable triggers the
-	 * extensions.sparseIndex config variable to be on.
+	 * If GIT_TEST_SPARSE_INDEX=1, then trigger extensions.sparseIndex
+	 * to be fully enabled. If GIT_TEST_SPARSE_INDEX=0 (set explicitly),
+	 * then purposefully disable the setting.
 	 */
-	if (git_env_bool("GIT_TEST_SPARSE_INDEX", 0)) {
-		int err = enable_sparse_index(istate->repo);
-		if (err < 0)
-			return err;
-	}
+	test_env = git_env_bool("GIT_TEST_SPARSE_INDEX", -1);
+	if (test_env >= 0)
+		set_sparse_index_config(istate->repo, test_env);
 
 	/*
 	 * Only convert to sparse if extensions.sparseIndex is set.
diff --git a/sparse-index.h b/sparse-index.h
index 64380e121d80..39dcc859735e 100644
--- a/sparse-index.h
+++ b/sparse-index.h
@@ -5,4 +5,7 @@ struct index_state;
 void ensure_full_index(struct index_state *istate);
 int convert_to_sparse(struct index_state *istate);
 
+struct repository;
+int set_sparse_index_config(struct repository *repo, int enable);
+
 #endif
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index bfc9e28ef0e1..9c2bc4d25f66 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -4,6 +4,7 @@ test_description='compare full workdir to sparse workdir'
 
 GIT_TEST_CHECK_CACHE_TREE=0
 GIT_TEST_SPLIT_INDEX=0
+GIT_TEST_SPARSE_INDEX=
 
 . ./test-lib.sh
 
@@ -98,25 +99,26 @@ init_repos () {
 	# initialize sparse-checkout definitions
 	git -C sparse-checkout sparse-checkout init --cone &&
 	git -C sparse-checkout sparse-checkout set deep &&
-	GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout init --cone &&
-	GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout set deep
+	git -C sparse-index sparse-checkout init --cone --sparse-index &&
+	test_cmp_config -C sparse-index true extensions.sparseindex &&
+	git -C sparse-index sparse-checkout set deep
 }
 
 run_on_sparse () {
 	(
 		cd sparse-checkout &&
-		GIT_TEST_SPARSE_INDEX=0 "$@" >../sparse-checkout-out 2>../sparse-checkout-err
+		"$@" >../sparse-checkout-out 2>../sparse-checkout-err
 	) &&
 	(
 		cd sparse-index &&
-		GIT_TEST_SPARSE_INDEX=1 "$@" >../sparse-index-out 2>../sparse-index-err
+		"$@" >../sparse-index-out 2>../sparse-index-err
 	)
 }
 
 run_on_all () {
 	(
 		cd full-checkout &&
-		GIT_TEST_SPARSE_INDEX=0 "$@" >../full-checkout-out 2>../full-checkout-err
+		"$@" >../full-checkout-out 2>../full-checkout-err
 	) &&
 	run_on_sparse "$@"
 }
@@ -146,7 +148,7 @@ test_expect_success 'sparse-index contents' '
 			|| return 1
 	done &&
 
-	GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout set folder1 &&
+	git -C sparse-index sparse-checkout set folder1 &&
 
 	test-tool -C sparse-index read-cache --table >cache &&
 	for dir in deep folder2 x
@@ -156,7 +158,7 @@ test_expect_success 'sparse-index contents' '
 			|| return 1
 	done &&
 
-	GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout set deep/deeper1 &&
+	git -C sparse-index sparse-checkout set deep/deeper1 &&
 
 	test-tool -C sparse-index read-cache --table >cache &&
 	for dir in deep/deeper2 folder1 folder2 x
@@ -394,19 +396,15 @@ test_expect_success 'submodule handling' '
 test_expect_success 'sparse-index is expanded and converted back' '
 	init_repos &&
 
-	(
-		GIT_TEST_SPARSE_INDEX=1 &&
-		export GIT_TEST_SPARSE_INDEX &&
-		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
-			git -C sparse-index -c core.fsmonitor="" reset --hard &&
-		test_region index convert_to_sparse trace2.txt &&
-		test_region index ensure_full_index trace2.txt &&
-
-		rm trace2.txt &&
-		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
-			git -C sparse-index -c core.fsmonitor="" status -uno &&
-		test_region index ensure_full_index trace2.txt
-	)
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git -C sparse-index -c core.fsmonitor="" reset --hard &&
+	test_region index convert_to_sparse trace2.txt &&
+	test_region index ensure_full_index trace2.txt &&
+
+	rm trace2.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git -C sparse-index -c core.fsmonitor="" status -uno &&
+	test_region index ensure_full_index trace2.txt
 '
 
 test_done
-- 
gitgitgadget


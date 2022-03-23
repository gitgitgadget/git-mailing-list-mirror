Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C51C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344746AbiCWUeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344726AbiCWUeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:09 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF4C8CCF4
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r7so2671701wrc.0
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wC1YBhdtGB75P1xbLfTEPiKqFbJksxDx5VtFD2usk+s=;
        b=aDeQPA6TjNT1ne9USm18eI4k+fMAjo9zcJdlOWJD4dgYsWeffHyWMPSpkEYz8FI/eM
         Cze7GPdwvHDqTWhyrgASM0bjtEi4rZXXJhh1N+aBU+o2+7a+/YhU4lX7yrC4zkdNZm50
         ecOZ939lvrSUm2w3Hb9QC/5PJ7ZZem7UzCviioG5hEuFv443xQ6lx3Ri7zH09KLSx+4x
         RXYiRq3n9vL9Pcp7bg0CODW5IFrwWzmfsy8vVi9SVzmHPBE++r0okL/f6eWVE+ZJ2gMD
         MBQZBb9l/oVD2Mii2huMpE8r1NwDHVI6yICBjcgKe7xw3qTlTRMBRJolZCUHsZXYXHa8
         Qdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wC1YBhdtGB75P1xbLfTEPiKqFbJksxDx5VtFD2usk+s=;
        b=LvMBvRfB3OCArTGLv3Q4dmbXSEe4z//euHFWTbevjaaGTAs15nVrS5YpumWjuqj5WB
         l0QCz0LO9pXNbTzyCNhJ56EmixFyGxdbxxvbzMrfNGXoKr9Ge79fGZp3fTt2i5Iu7VD6
         z8ljvgD+PObY/pwD29QZEgtW9Bd24ipR1THJmf59CD73Lhm3uCHY6Dxzwy840w0ElFXi
         tIRZQs6UKDqt+VClCfr8H5Jrt0SwUC52xAcBAFpG2XYPrUNl/uSDWzIxTbWznhgAGjfN
         IFKYxGAjZkrMk21Elg8+xSWUXe3AkHSEM1vf/lPNzwCBMc6dtEdEAd03uNnG+/uf66v8
         Vn3Q==
X-Gm-Message-State: AOAM533YnpUMokV6rMcyms5RFfEJrPyLIFPac/WEzikx0QzVOozSSsGm
        V8ZwTRx/1xIeg9cjJH0n/CpoQQUCDnL4nA==
X-Google-Smtp-Source: ABdhPJyURrRHaPMLvPkZ2bZUeYSc1hrjfs94f0r+Nhljic0THWz1Cb3NOyTu8a5LMuJ9+6+etxDZ9Q==
X-Received: by 2002:a5d:4c82:0:b0:204:d78:7635 with SMTP id z2-20020a5d4c82000000b002040d787635mr1599365wrs.318.1648067555531;
        Wed, 23 Mar 2022 13:32:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/27] revisions API users: add "goto cleanup" for release_revisions()
Date:   Wed, 23 Mar 2022 21:32:00 +0100
Message-Id: <patch-v2-10.27-eafe57663fc-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a release_revisions() to various users of "struct rev_list" which
requires a minor refactoring to a "goto cleanup" pattern to use that
function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/diff-files.c        |  8 ++++++--
 builtin/rev-list.c          | 19 ++++++++++++-------
 builtin/stash.c             |  1 +
 builtin/submodule--helper.c | 10 +++++++---
 sequencer.c                 | 23 ++++++++++++++++-------
 t/helper/test-fast-rebase.c | 18 +++++++++++++-----
 6 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 70103c40952..2bfaf9ba7ae 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -77,8 +77,12 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 
 	if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
 		perror("read_cache_preload");
-		return -1;
+		result = -1;
+		goto cleanup;
 	}
+cleanup:
 	result = run_diff_files(&rev, options);
-	return diff_result_code(&rev.diffopt, result);
+	result = diff_result_code(&rev.diffopt, result);
+	release_revisions(&rev);
+	return result;
 }
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 572da1472e5..2f0b6c759e4 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -502,6 +502,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int use_bitmap_index = 0;
 	int filter_provided_objects = 0;
 	const char *show_progress = NULL;
+	int ret = 0;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(rev_list_usage);
@@ -585,7 +586,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		}
 		if (!strcmp(arg, "--test-bitmap")) {
 			test_bitmap_walk(&revs);
-			return 0;
+			goto cleanup;
 		}
 		if (skip_prefix(arg, "--progress=", &arg)) {
 			show_progress = arg;
@@ -674,11 +675,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	if (use_bitmap_index) {
 		if (!try_bitmap_count(&revs, filter_provided_objects))
-			return 0;
+			goto cleanup;
 		if (!try_bitmap_disk_usage(&revs, filter_provided_objects))
-			return 0;
+			goto cleanup;
 		if (!try_bitmap_traversal(&revs, filter_provided_objects))
-			return 0;
+			goto cleanup;
 	}
 
 	if (prepare_revision_walk(&revs))
@@ -698,8 +699,10 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 		find_bisection(&revs.commits, &reaches, &all, bisect_flags);
 
-		if (bisect_show_vars)
-			return show_bisect_vars(&info, reaches, all);
+		if (bisect_show_vars) {
+			ret = show_bisect_vars(&info, reaches, all);
+			goto cleanup;
+		}
 	}
 
 	if (filter_provided_objects) {
@@ -754,5 +757,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (show_disk_usage)
 		printf("%"PRIuMAX"\n", (uintmax_t)total_disk_usage);
 
-	return 0;
+cleanup:
+	release_revisions(&revs);
+	return ret;
 }
diff --git a/builtin/stash.c b/builtin/stash.c
index 4c8c8af8a09..4fc717d5578 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -917,6 +917,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 cleanup:
 	strvec_clear(&stash_args);
 	free_stash_info(&info);
+	release_revisions(&rev);
 	return ret;
 }
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e8e20cdcc53..78887779d8b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1222,6 +1222,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 	struct strvec diff_args = STRVEC_INIT;
 	struct rev_info rev;
 	struct module_cb_list list = MODULE_CB_LIST_INIT;
+	int ret = 0;
 
 	strvec_push(&diff_args, get_diff_cmd(diff_cmd));
 	if (info->cached)
@@ -1247,11 +1248,13 @@ static int compute_summary_module_list(struct object_id *head_oid,
 			setup_work_tree();
 		if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
 			perror("read_cache_preload");
-			return -1;
+			ret = -1;
+			goto cleanup;
 		}
 	} else if (read_cache() < 0) {
 		perror("read_cache");
-		return -1;
+		ret = -1;
+		goto cleanup;
 	}
 
 	if (diff_cmd == DIFF_INDEX)
@@ -1259,9 +1262,10 @@ static int compute_summary_module_list(struct object_id *head_oid,
 	else
 		run_diff_files(&rev, 0);
 	prepare_submodule_summary(info, &list);
+cleanup:
 	strvec_clear(&diff_args);
 	release_revisions(&rev);
-	return 0;
+	return ret;
 }
 
 static int module_summary(int argc, const char **argv, const char *prefix)
diff --git a/sequencer.c b/sequencer.c
index 29ec201af64..efea320fb9b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5356,6 +5356,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 	int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
 	int reapply_cherry_picks = flags & TODO_LIST_REAPPLY_CHERRY_PICKS;
 	int skipped_commit = 0;
+	int ret = 0;
 
 	repo_init_revisions(r, &revs, NULL);
 	revs.verbose_header = 1;
@@ -5379,14 +5380,20 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 	pp.fmt = revs.commit_format;
 	pp.output_encoding = get_log_output_encoding();
 
-	if (setup_revisions(argc, argv, &revs, NULL) > 1)
-		return error(_("make_script: unhandled options"));
+	if (setup_revisions(argc, argv, &revs, NULL) > 1) {
+		ret = error(_("make_script: unhandled options"));
+		goto cleanup;
+	}
 
-	if (prepare_revision_walk(&revs) < 0)
-		return error(_("make_script: error preparing revisions"));
+	if (prepare_revision_walk(&revs) < 0) {
+		ret = error(_("make_script: error preparing revisions"));
+		goto cleanup;
+	}
 
-	if (rebase_merges)
-		return make_script_with_merges(&pp, &revs, out, flags);
+	if (rebase_merges) {
+		ret = make_script_with_merges(&pp, &revs, out, flags);
+		goto cleanup;
+	}
 
 	while ((commit = get_revision(&revs))) {
 		int is_empty = is_original_commit_empty(commit);
@@ -5410,7 +5417,9 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 	if (skipped_commit)
 		advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
 				  _("use --reapply-cherry-picks to include skipped commits"));
-	return 0;
+cleanup:
+	release_revisions(&revs);
+	return ret;
 }
 
 /*
diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index 993b90eaedd..4e5553e2024 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -99,6 +99,7 @@ int cmd__fast_rebase(int argc, const char **argv)
 	struct merge_result result;
 	struct strbuf reflog_msg = STRBUF_INIT;
 	struct strbuf branch_name = STRBUF_INIT;
+	int ret = 0;
 
 	/*
 	 * test-tool stuff doesn't set up the git directory by default; need to
@@ -137,13 +138,17 @@ int cmd__fast_rebase(int argc, const char **argv)
 	revs.topo_order = 1;
 	strvec_pushl(&rev_walk_args, "", argv[4], "--not", argv[3], NULL);
 
-	if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1)
-		return error(_("unhandled options"));
+	if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1) {
+		ret = error(_("unhandled options"));
+		goto cleanup;
+	}
 
 	strvec_clear(&rev_walk_args);
 
-	if (prepare_revision_walk(&revs) < 0)
-		return error(_("error preparing revisions"));
+	if (prepare_revision_walk(&revs) < 0) {
+		ret = error(_("error preparing revisions"));
+		goto cleanup;
+	}
 
 	init_merge_options(&merge_opt, the_repository);
 	memset(&result, 0, sizeof(result));
@@ -220,7 +225,10 @@ int cmd__fast_rebase(int argc, const char **argv)
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("unable to write %s"), get_index_file());
 
+	ret = (result.clean == 0);
+cleanup:
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_name);
-	return (result.clean == 0);
+	release_revisions(&revs);
+	return ret;
 }
-- 
2.35.1.1452.ga7cfc89151f


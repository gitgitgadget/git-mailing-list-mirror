Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2600C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiCINTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbiCINSx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:18:53 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883DC172897
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:17:52 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r6so2555599wrr.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HbIu89yx4fnXUQ06a6bq+jDu7ElJQI28xQaa1EcIf3Y=;
        b=oEAsN+LbJsJXUKomB6QE6GhE+Ly7otJOVs/Bx5vnAAleTx42jRHb/0nNbxiaVlVZKh
         ztY+Ygnxv00YEzPS+dn2hjfZ/wRBGvTpOwjQ5heWoBnUVIYyv4/Iq3ut9vzC7UJM0/Mn
         ggazJxtsM5fNYlCO1KN6B49uLtY7K2mMBKMpLvbjOTktVyzd2HXQ+uxC9sDxgBDC9br5
         mvYUbs1vhXU2/HksDBFIdhdJza9mHkDkCiBWAmEpMeC8E5eaW/IT5GYOZ4Ojf4ajNmqK
         q95HrZCqUGCGXPUgoNKNA48N03SJ+CLIVXmbMcBD/JKTahe/xazo4H0+8vTqCyRtRgph
         d5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HbIu89yx4fnXUQ06a6bq+jDu7ElJQI28xQaa1EcIf3Y=;
        b=ouAJMZ6ZPRB0v49B6hCtEyvBAaFZmtsofxY+hTSlz1/pkeDwmWBzdiEwIhfoOm66Od
         t5tCJnoCPu05SyV3sw/PoD5iSe6PJMXVTHVmyvIFUqW9vx14hsdYnS3OPsFJu+546slO
         4pVpWf1DRVODkwv8pOVPjibXp9t1mj+42kFC+VI+hUGhc0K4SlSPtrLORRzNaGZP4YhX
         +ACi3RO/te0RPQRoa8wzUh7rqF9m595oBHUzmqIp4hxXCNq+FM/qMwoBWIjQ0cUxJ8J2
         duUpMRWf3jP4FVkkhY/ib3MDC/Im0KgfoWhJrVQyRUQ3AUcsj/zan/M8cSCpN4QmajZU
         SLjQ==
X-Gm-Message-State: AOAM5331+aNHoDBxRs8E0jVqzAQhegiZ+R1tswxMvhcVFFGFFj+U27b2
        q5bsUWjAo/ZirTnqHoes9799mOT3XGKpmg==
X-Google-Smtp-Source: ABdhPJxeG0VXC24e9eFIXoQHZDwIL1b9YHvY4IjBVrUuET5DJhIdBwLQGHrfV0ICOMi2Cjg0XQRawQ==
X-Received: by 2002:adf:fa48:0:b0:1f0:d71:f9a with SMTP id y8-20020adffa48000000b001f00d710f9amr15284590wrr.50.1646831870736;
        Wed, 09 Mar 2022 05:17:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:17:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/24] revisions API users: add "goto cleanup" for release_revisions()
Date:   Wed,  9 Mar 2022 14:16:38 +0100
Message-Id: <patch-08.24-0f9d313b338-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
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
 builtin/stash.c             | 14 ++++++++++----
 builtin/submodule--helper.c | 11 ++++++++---
 sequencer.c                 | 23 ++++++++++++++++-------
 t/helper/test-fast-rebase.c | 19 +++++++++++++------
 6 files changed, 65 insertions(+), 29 deletions(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 70103c40952..92cf6e1e922 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -77,8 +77,12 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 
 	if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
 		perror("read_cache_preload");
-		return -1;
+		result = -1;
+		goto cleanup;
 	}
 	result = run_diff_files(&rev, options);
-	return diff_result_code(&rev.diffopt, result);
+	result = diff_result_code(&rev.diffopt, result);
+cleanup:
+	release_revisions(&rev);
+	return result;
 }
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 38528c7f156..5db8e71645f 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -506,6 +506,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int use_bitmap_index = 0;
 	int filter_provided_objects = 0;
 	const char *show_progress = NULL;
+	int ret = 0;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(rev_list_usage);
@@ -589,7 +590,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		}
 		if (!strcmp(arg, "--test-bitmap")) {
 			test_bitmap_walk(&revs);
-			return 0;
+			goto cleanup;
 		}
 		if (skip_prefix(arg, "--progress=", &arg)) {
 			show_progress = arg;
@@ -689,11 +690,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	if (use_bitmap_index) {
 		if (!try_bitmap_count(&revs, &filter_options, filter_provided_objects))
-			return 0;
+			goto cleanup;
 		if (!try_bitmap_disk_usage(&revs, &filter_options, filter_provided_objects))
-			return 0;
+			goto cleanup;
 		if (!try_bitmap_traversal(&revs, &filter_options, filter_provided_objects))
-			return 0;
+			goto cleanup;
 	}
 
 	if (prepare_revision_walk(&revs))
@@ -713,8 +714,10 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 		find_bisection(&revs.commits, &reaches, &all, bisect_flags);
 
-		if (bisect_show_vars)
-			return show_bisect_vars(&info, reaches, all);
+		if (bisect_show_vars) {
+			ret = show_bisect_vars(&info, reaches, all);
+			goto cleanup;
+		}
 	}
 
 	if (filter_provided_objects) {
@@ -769,5 +772,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (show_disk_usage)
 		printf("%"PRIuMAX"\n", (uintmax_t)total_disk_usage);
 
-	return 0;
+cleanup:
+	release_revisions(&revs);
+	return ret;
 }
diff --git a/builtin/stash.c b/builtin/stash.c
index af9b61ef17a..0b9d55d09bb 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -874,8 +874,10 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 
 	ret = get_stash_info(&info, stash_args.nr, stash_args.v);
 	strvec_clear(&stash_args);
-	if (ret)
-		return -1;
+	if (ret) {
+		ret = -1;
+		goto cleanup;
+	}
 
 	/*
 	 * The config settings are applied only if there are not passed
@@ -890,7 +892,8 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 
 		if (!show_stat && !show_patch) {
 			free_stash_info(&info);
-			return 0;
+			ret = 0;
+			goto cleanup;
 		}
 	}
 
@@ -924,7 +927,10 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	log_tree_diff_flush(&rev);
 
 	free_stash_info(&info);
-	return diff_result_code(&rev.diffopt, 0);
+	ret = diff_result_code(&rev.diffopt, 0);
+cleanup:
+	release_revisions(&rev);
+	return ret;
 }
 
 static int do_store_stash(const struct object_id *w_commit, const char *stash_msg,
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 09db2620829..19393da4e31 100644
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
@@ -1259,9 +1262,11 @@ static int compute_summary_module_list(struct object_id *head_oid,
 	else
 		run_diff_files(&rev, 0);
 	prepare_submodule_summary(info, &list);
+	ret = 0;
+cleanup:
 	strvec_clear(&diff_args);
 	release_revisions(&rev);
-	return 0;
+	return ret;
 }
 
 static int module_summary(int argc, const char **argv, const char *prefix)
diff --git a/sequencer.c b/sequencer.c
index b15f8d1ff50..40d41c09523 100644
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
index 993b90eaedd..e49a0244836 100644
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
+		ret =  error(_("unhandled options"));
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
@@ -219,8 +224,10 @@ int cmd__fast_rebase(int argc, const char **argv)
 	if (write_locked_index(&the_index, &lock,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("unable to write %s"), get_index_file());
-
+	ret = (result.clean == 0);
+cleanup:
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_name);
-	return (result.clean == 0);
+	release_revisions(&revs);
+	return ret;
 }
-- 
2.35.1.1295.g6b025d3e231


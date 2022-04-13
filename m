Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E621C433FE
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbiDMUE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238581AbiDMUEm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:04:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9A97C16A
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i20so4129591wrb.13
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WeYrDPtVm60vwEmAozcenOwrJ3p6DSHM1Ok4wp2Re4s=;
        b=EbM7GKjbaYB/ZDSIkBvQjOtX4kYSDUMhGokZ0kn+9pS+VH/hw1d/lMfFGvrCTCnej2
         sj6QJHR4cShJsB38QQasYjbp0Cn4kh/FNjpXTwclGboPHlLhO6FnHTZUENgSNn8j3S23
         SXMiBxNMcnDH7XO63Uq95zkLSwe0ND3ObKEAW+PhCru7TjQLzvXxbi+oOTEchFspSiQ8
         rCej9bRr1TTEHmnOifodc0c1j71ctaV4Z/7XJbgWlPulxUPgJ1+8Vi28K9bOJKLqfTdR
         KHMSs58ZfYL4xdyOJXBtLqpmZndWhsA+e00Q0frP2V/KgM8iNZdgQ1X8bBwCdLScF9q/
         qKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WeYrDPtVm60vwEmAozcenOwrJ3p6DSHM1Ok4wp2Re4s=;
        b=e4q2a96Rj3ip4rr6prMI30QxrTnta3hvFbhAZm24hYqfgH7a1SMXa7vh4eEDfNrQX5
         02PzYur5WuO2uL40tbrfukKPjkpKDwFv3ity+z1Rpr0foAgJXGCmbY642QdfXcNJbm3d
         PZUwlT7J38oXqLvvXixBgyz1D0gep7X4FgCTDdRBgJy5X2QqvEkIAXAnmNztEVjXbkBQ
         3ujrB1kNboiF7AmHyPBZpcTUzs4b9uuRan8GwHEsE3/wnlXvabOhBwt1ydKKcCKDDsbq
         3SbfBLYESwMImTWhCaXhhFRNxvkGKF1maWD4SXrCU1tBJX1QzjjNPw0TPaUk6oHeFmnf
         0rvg==
X-Gm-Message-State: AOAM530aVeaJYihb73Yvdf9LetcsKE0NpCXDBRIZObRRGKlwZfxnZnOO
        wOB8jjTWxsObL1nMhDeFp6VA3PvPhJX+OA==
X-Google-Smtp-Source: ABdhPJz+97X5OLeCaBeWGDhUB6UFM5iZz1iuWNpNDJSysVFDJpGJlhXOE3MOuwveRT9hIsu7GL3emg==
X-Received: by 2002:a5d:6301:0:b0:205:cb42:74a5 with SMTP id i1-20020a5d6301000000b00205cb4274a5mr341095wru.385.1649880131258;
        Wed, 13 Apr 2022 13:02:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm35220498wri.48.2022.04.13.13.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:02:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 11/27] revisions API users: add "goto cleanup" for release_revisions()
Date:   Wed, 13 Apr 2022 22:01:40 +0200
Message-Id: <patch-v6-11.27-e93791b6242-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com> <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a release_revisions() to various users of "struct rev_info" which
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
index 07c0ad11d8d..30fd8e83eaf 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -500,6 +500,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int use_bitmap_index = 0;
 	int filter_provided_objects = 0;
 	const char *show_progress = NULL;
+	int ret = 0;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(rev_list_usage);
@@ -583,7 +584,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		}
 		if (!strcmp(arg, "--test-bitmap")) {
 			test_bitmap_walk(&revs);
-			return 0;
+			goto cleanup;
 		}
 		if (skip_prefix(arg, "--progress=", &arg)) {
 			show_progress = arg;
@@ -672,11 +673,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
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
@@ -696,8 +697,10 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 		find_bisection(&revs.commits, &reaches, &all, bisect_flags);
 
-		if (bisect_show_vars)
-			return show_bisect_vars(&info, reaches, all);
+		if (bisect_show_vars) {
+			ret = show_bisect_vars(&info, reaches, all);
+			goto cleanup;
+		}
 	}
 
 	if (filter_provided_objects) {
@@ -752,5 +755,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (show_disk_usage)
 		printf("%"PRIuMAX"\n", (uintmax_t)total_disk_usage);
 
-	return 0;
+cleanup:
+	release_revisions(&revs);
+	return ret;
 }
diff --git a/builtin/stash.c b/builtin/stash.c
index ba030238939..fce4393d123 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -917,6 +917,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 cleanup:
 	strvec_clear(&stash_args);
 	free_stash_info(&info);
+	release_revisions(&rev);
 	if (do_usage)
 		usage_with_options(git_stash_show_usage, options);
 	return ret;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9a65985b418..f83c75c7768 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1232,6 +1232,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 	struct strvec diff_args = STRVEC_INIT;
 	struct rev_info rev;
 	struct module_cb_list list = MODULE_CB_LIST_INIT;
+	int ret = 0;
 
 	strvec_push(&diff_args, get_diff_cmd(diff_cmd));
 	if (info->cached)
@@ -1257,11 +1258,13 @@ static int compute_summary_module_list(struct object_id *head_oid,
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
@@ -1269,9 +1272,10 @@ static int compute_summary_module_list(struct object_id *head_oid,
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
index f9d7acd1065..41ae5e25278 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5354,6 +5354,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 	int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
 	int reapply_cherry_picks = flags & TODO_LIST_REAPPLY_CHERRY_PICKS;
 	int skipped_commit = 0;
+	int ret = 0;
 
 	repo_init_revisions(r, &revs, NULL);
 	revs.verbose_header = 1;
@@ -5377,14 +5378,20 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
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
@@ -5408,7 +5415,9 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
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
2.36.0.rc2.843.g193535c2aa7


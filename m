Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6896C433F5
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354515AbiDBKwD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354483AbiDBKv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:51:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AC414074D
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:49:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ot30so781252ejb.12
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGikEYJGeZ9WbbaHrUTKnGPY9TifFJpZyg3/u5HVfJs=;
        b=ShqhjnEypX5N8tVAPw+boykGU7NCiQsQb3ya0ZvMSXY+i6O+Dtw10zzJE6RbwbMPxM
         rU/EL1URcZqvcsL39JCCFeEQsz0aefY1ZpDROMIIGf3K5QMc1nF7oLt321S7N4jscTco
         KKkKgk3eXYNkxfonV4QKmoSCzYD6Y+cGo822tUWLE4YQawuY4w4M5f4cHE8V+hhEr9nq
         pyqWHWZ6E2QYpEcbpeMQIHt+Jo93AMJwWWpzUM1WzxHscbWhvuPcqxQYQCrIh6SSHGaC
         yp+acB9J9PFZ5H2IHzCHqAAMhOkDQa19DeGNAdCsIKXklZ/Uz8shw9SHNG7XSIXbWMfG
         8IKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGikEYJGeZ9WbbaHrUTKnGPY9TifFJpZyg3/u5HVfJs=;
        b=I3PHDDzNVT4bvc8My+wo7XLgVD0Uqq+j0m99yOuHiWGb21Z7x38lOxJRi+C4dGtjyF
         IYINDzW+j3H5zZ/3GlY0u30rec6aGWdB61+n4GA69mqrl+K4zT+ixBLKWidre+QpinQi
         42bv/F/rOuVEOYslmMcvQYCWLl/yuX3kJ1cFMfCdi/14/tDVuznThNr35t2vlutnoCK9
         X2tJdpKDhDlEWtdHjO9lc70GLNM5vbbNSJFVR10Xg3pCTTb+votJ5GES696B6BQCzgYz
         HZUstKo5jHG0kySrPjimULbym27jp12uO01KEPp+d2/Gb26d0HqLy9+ut7xQBhiZJ0bT
         21nw==
X-Gm-Message-State: AOAM533JmVpqbvuHeedMX05etr/FMG5AJb78e1hsxy7YgvdnlVtJ1uhK
        P5yq1CF5On+80XxCnUjFKyN4d1WwCJMQBQ==
X-Google-Smtp-Source: ABdhPJwx5qQSatGBtdkdMK9rOU6I8bW6HYOJLY51eUn3YrSojB54GxDFit9SEbzX4ufpgms9zyGu1g==
X-Received: by 2002:a17:906:e208:b0:6e6:df07:ac80 with SMTP id gf8-20020a170906e20800b006e6df07ac80mr897728ejb.167.1648896595737;
        Sat, 02 Apr 2022 03:49:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:49:55 -0700 (PDT)
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
Subject: [PATCH v5 11/27] revisions API users: add "goto cleanup" for release_revisions()
Date:   Sat,  2 Apr 2022 12:49:25 +0200
Message-Id: <patch-v5-11.27-4210232e3a1-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
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
index cda33ee4d2b..1bd31c85946 100644
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
2.35.1.1585.gd85f8dcb745


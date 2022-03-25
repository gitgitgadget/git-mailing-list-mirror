Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679BCC433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiCYTz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiCYTzn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:55:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DD128AB1B
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:42:31 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so9573350wms.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sCym5aXaQRxDxmtjPGDeoxEOFhlzjIDUNbKcRU3rciI=;
        b=YucXOTtz6WTrh9IRCfSpSu3ICozBUQma3FjN1devYDTDCV7dBYBsWNKkfwFuvGDx25
         1ZlF6zWTWlQHIa8gchKowHD90PEWT2MQafG4/YwJ1BjS/39s6FqYoRO10AF8BXMVfBKa
         d2x3rZ0SuCPFJm+uA9YM8yO1bXCt9ESyn7JN4yOHDYxlCpa9elGN3u9wiTTQSifLbyap
         lRilFWXzn2SeqoSCmYUUWm8FzEMEc7jDcJjzScUWBnWMBkLN9QVYEfNW6s0K+DXckNes
         h0yrra5a627/I840I9nvcIcoEeROXmdgqEWwpmdHAPc00ulnWbjfxo6LRwPYsVUVIL4K
         4wzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sCym5aXaQRxDxmtjPGDeoxEOFhlzjIDUNbKcRU3rciI=;
        b=l3WHYQlsFoT4lwb/tDYCPxuyLfIL0PmmkC0woqeIVpcLOHtJAUY1dL4YDS+tYr0ZZ1
         KYAdVe+xuQhIm0pQX8UuxSoEIrNgOuEprnhl+6BDoh1lFTuuv9Q5WjqK3+ftu9qfDoTa
         vburRrB7786C2HRrJTDWwHWWhMKb0mNA35mYx8u5Z/NSqXFZxbTdinyraWaYXYlllRR3
         oFFJdcYRUPjoCTkrVZHFHUy821nq0+VV61jv8D4Yu/6FVWnZapw+Z0hy9I7XxPaE5EXj
         0AAxpWDOK8yvBf5L6K+qYkZq1KdBBzNqse0r4CL1TnEQa7fHUDVakQC1/tdUvZJu+UQF
         XMgg==
X-Gm-Message-State: AOAM531JXUefdBFSuzlzYi10NhuJXbExbkQJkWz+/IYK8yqbrqkHzJYj
        3WwxjQhtR41Cy1mmGs9P1CeaNofUJshggg==
X-Google-Smtp-Source: ABdhPJxgmUhsmlwprCnvOGQM25SYCtmu3ByDwHMWDldkILZ9xux77x5oaPjcMWajzb2wBYpkYVtAwA==
X-Received: by 2002:a05:600c:4ecd:b0:38c:afd6:76f with SMTP id g13-20020a05600c4ecd00b0038cafd6076fmr20511301wmq.3.1648228782228;
        Fri, 25 Mar 2022 10:19:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:41 -0700 (PDT)
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
Subject: [PATCH v3 11/27] revisions API users: add "goto cleanup" for release_revisions()
Date:   Fri, 25 Mar 2022 18:18:35 +0100
Message-Id: <patch-v3-11.27-da4fcd04345-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
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
index 891572d807c..76d162387e2 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -916,6 +916,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 cleanup:
 	strvec_clear(&stash_args);
 	free_stash_info(&info);
+	release_revisions(&rev);
 	return ret;
 }
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d1b656c0909..5d4c0b62ba9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1233,6 +1233,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 	struct strvec diff_args = STRVEC_INIT;
 	struct rev_info rev;
 	struct module_cb_list list = MODULE_CB_LIST_INIT;
+	int ret = 0;
 
 	strvec_push(&diff_args, get_diff_cmd(diff_cmd));
 	if (info->cached)
@@ -1258,11 +1259,13 @@ static int compute_summary_module_list(struct object_id *head_oid,
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
@@ -1270,9 +1273,10 @@ static int compute_summary_module_list(struct object_id *head_oid,
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
2.35.1.1509.ge4eeb5bd39e


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A839CC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiGUTNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbiGUTNq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:13:46 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050FF88765
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b26so3632981wrc.2
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rNr9aRcaN4JdeKQzr/y6dLghAvimfsPNQXgFwthexRU=;
        b=N4zpgHx/Hkk6Nq7QdYW/E0ZEGNlkwbxWvuxROnFmwG5/KoJdCYMGkDhsh90TK0fWvE
         Cc7SapXJfc/iFKmpUeNACzX26wY/w0T9JJYqUKmYidyR9XdzSrPxgSzKn+rBoK4GQbQc
         K9pwsQAWQlmaDqIr1egMIWoOBzX4bq+yKZMxn5gzMzBfgcfLogSgk7rwzvq73jKttnyA
         S2O2u7wl03jNsA0tGyc63Vkkf6Ydubpz8t8kVuiaVoCDUhtERr4GVMFXNxhWT2YkYwjS
         jEh+6ZhtRMFV02GYc2xDTZMUJVzrvGxU6ICQW5J53b9d2ow4bebKGsttCHmjlyEB/Mtk
         g3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rNr9aRcaN4JdeKQzr/y6dLghAvimfsPNQXgFwthexRU=;
        b=FVonVnhhLrjE0DkvcU1KznHZL618YC3VuK1aoG0rklVGVzGKfJSDDa4X4pgBxqDXyL
         9Wv4jfxMbZ7XSLg9qMYS/IL21Z8hn3a+reVJ3W6grQPrjY5O3gTAKDnajbJmzzj5w6VM
         20Dl5o3PgvHAZol5L0hgfYWrEGl/8vBAX1pWtu052I5vpqKEmcljocBVeJkiY0T5PDg5
         3VtOJuXJzDHjAMdqhcjXD3cMVdbzvm/I78LWQgU52gY56+pBjug5BCJFp+zS3fki33V2
         JLY+NVwN0QT5AEdV/fjx3ru/P2yp8Em9ETu1pZtIioUatT8RW23iN2BkhFkDw6r7w/Ld
         9F5A==
X-Gm-Message-State: AJIora8hQHefMpvgCgonsCLTRSpw714epzJ7sjT9xumydnP+AhmBfk4O
        Q035Qh6X55+4dwuKXld8O7sdQCfqUWJdQw==
X-Google-Smtp-Source: AGRyM1u2UVoHDCU0d/ZWheAqe+lId1YqmpgvZuriSz5vUe2lFHI/NWGwxSTOyluUvf6lX2J0UvHFyA==
X-Received: by 2002:a5d:59a4:0:b0:21d:bdec:8a67 with SMTP id p4-20020a5d59a4000000b0021dbdec8a67mr35260724wrr.194.1658430823174;
        Thu, 21 Jul 2022 12:13:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:13:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/26] submodule--helper: fix most "struct pathspec" memory leaks
Date:   Thu, 21 Jul 2022 21:13:02 +0200
Message-Id: <patch-v3-06.26-7672ef1305f-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call clear_pathspec() at the end of various functions that work with
and allocate a "struct pathspec".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 84 +++++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 26 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 73ac1fcbb9c..a60dc6af178 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -269,7 +269,7 @@ static char *get_up_path(const char *path)
 static int module_list(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 
 	struct option module_list_options[] = {
@@ -278,6 +278,7 @@ static int module_list(int argc, const char **argv, const char *prefix)
 			   N_("alternative anchor for relative paths")),
 		OPT_END()
 	};
+	int ret = 1;
 
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule--helper list [--prefix=<path>] [<path>...]"),
@@ -288,7 +289,7 @@ static int module_list(int argc, const char **argv, const char *prefix)
 			     git_submodule_helper_usage, 0);
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+		goto cleanup;
 
 	for (i = 0; i < list.nr; i++) {
 		const struct cache_entry *ce = list.entries[i];
@@ -302,7 +303,10 @@ static int module_list(int argc, const char **argv, const char *prefix)
 
 		fprintf(stdout, "%s\n", ce->name);
 	}
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 static void for_each_listed_submodule(const struct module_list *list,
@@ -427,7 +431,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 static int module_foreach(int argc, const char **argv, const char *prefix)
 {
 	struct foreach_cb info = FOREACH_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 
 	struct option module_foreach_options[] = {
@@ -441,12 +445,13 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 		N_("git submodule foreach [--quiet] [--recursive] [--] <command>"),
 		NULL
 	};
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, module_foreach_options,
 			     git_submodule_helper_usage, 0);
 
 	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
-		return 1;
+		goto cleanup;
 
 	info.argc = argc;
 	info.argv = argv;
@@ -454,7 +459,10 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, runcommand_in_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 static int starts_with_dot_slash(const char *const path)
@@ -562,7 +570,7 @@ static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data
 static int module_init(int argc, const char **argv, const char *prefix)
 {
 	struct init_cb info = INIT_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 
@@ -575,12 +583,13 @@ static int module_init(int argc, const char **argv, const char *prefix)
 		N_("git submodule init [<options>] [<path>]"),
 		NULL
 	};
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, module_init_options,
 			     git_submodule_helper_usage, 0);
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+		goto cleanup;
 
 	/*
 	 * If there are no path args and submodule.active is set then,
@@ -595,7 +604,10 @@ static int module_init(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, init_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 struct status_cb {
@@ -740,7 +752,7 @@ static void status_submodule_cb(const struct cache_entry *list_item,
 static int module_status(int argc, const char **argv, const char *prefix)
 {
 	struct status_cb info = STATUS_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 
@@ -755,12 +767,13 @@ static int module_status(int argc, const char **argv, const char *prefix)
 		N_("git submodule status [--quiet] [--cached] [--recursive] [<path>...]"),
 		NULL
 	};
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, module_status_options,
 			     git_submodule_helper_usage, 0);
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+		goto cleanup;
 
 	info.prefix = prefix;
 	if (quiet)
@@ -768,7 +781,10 @@ static int module_status(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, status_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 static int module_name(int argc, const char **argv, const char *prefix)
@@ -1326,10 +1342,11 @@ static void sync_submodule_cb(const struct cache_entry *list_item, void *cb_data
 static int module_sync(int argc, const char **argv, const char *prefix)
 {
 	struct sync_cb info = SYNC_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 	int recursive = 0;
+	int ret = 1;
 
 	struct option module_sync_options[] = {
 		OPT__QUIET(&quiet, N_("suppress output of synchronizing submodule url")),
@@ -1347,7 +1364,7 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 			     git_submodule_helper_usage, 0);
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+		goto cleanup;
 
 	info.prefix = prefix;
 	if (quiet)
@@ -1357,7 +1374,10 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, sync_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 struct deinit_cb {
@@ -1464,7 +1484,7 @@ static void deinit_submodule_cb(const struct cache_entry *list_item,
 static int module_deinit(int argc, const char **argv, const char *prefix)
 {
 	struct deinit_cb info = DEINIT_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 	int force = 0;
@@ -1481,6 +1501,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 		N_("git submodule deinit [--quiet] [-f | --force] [--all | [--] [<path>...]]"),
 		NULL
 	};
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, module_deinit_options,
 			     git_submodule_helper_usage, 0);
@@ -1495,7 +1516,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 		die(_("Use '--all' if you really want to deinitialize all submodules"));
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+		goto cleanup;
 
 	info.prefix = prefix;
 	if (quiet)
@@ -1505,7 +1526,10 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, deinit_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 struct module_clone_data {
@@ -2577,7 +2601,7 @@ static int update_submodules(struct update_data *update_data)
 
 static int module_update(int argc, const char **argv, const char *prefix)
 {
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options = { 0 };
 	int ret;
@@ -2656,8 +2680,8 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		opt.update_strategy.type = opt.update_default;
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0) {
-		list_objects_filter_release(&filter_options);
-		return 1;
+		ret = 1;
+		goto cleanup;
 	}
 
 	if (pathspec.nr)
@@ -2668,8 +2692,10 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		struct init_cb info = INIT_CB_INIT;
 
 		if (module_list_compute(argc, argv, opt.prefix,
-					&pathspec, &list) < 0)
-			return 1;
+					&pathspec, &list) < 0) {
+			ret = 1;
+			goto cleanup;
+		}
 
 		/*
 		 * If there are no path args and submodule.active is set then,
@@ -2686,7 +2712,9 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	}
 
 	ret = update_submodules(&opt);
+cleanup:
 	list_objects_filter_release(&filter_options);
+	clear_pathspec(&pathspec);
 	return ret;
 }
 
@@ -2770,9 +2798,10 @@ static int push_check(int argc, const char **argv, const char *prefix)
 static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	unsigned flags = ABSORB_GITDIR_RECURSE_SUBMODULES;
+	int ret = 1;
 
 	struct option embed_gitdir_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
@@ -2792,12 +2821,15 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 			     git_submodule_helper_usage, 0);
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+		goto cleanup;
 
 	for (i = 0; i < list.nr; i++)
 		absorb_git_dir_into_superproject(list.entries[i]->name, flags);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 static int is_active(int argc, const char **argv, const char *prefix)
-- 
2.37.1.1095.g0bd6f54ba8a


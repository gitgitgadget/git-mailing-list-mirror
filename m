Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6FEC28D13
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiHUOCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiHUOBv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 10:01:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BA12497B
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso6404552wmh.5
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=VN1l4osaPK4fY9j7X5TGynmqPlCTRBZm5aF085gbeqE=;
        b=cMcf2+F1tH+OiU7PTxDADCESw0xbssG9PImnuEqLmVVh5xGmQQS+f8d7DIaFX4rjtp
         iWljQje/imYgJkdQRyrD7o4bbZmHi03sfXss8CR5VYtF7+BWdDMy86PAMP2DR+WtDrzB
         IiszHxFj3GSwd0BBy42D3X9hwR9L6ApJ1h3DUf87Q97zN6gzk6oy89EbDUF6Y9j5SpqK
         Js8VD6Xc0moHPMjEyGIzXX18LknzVWEhoFX9qwKoXifJ/On7Y95G4QgkHGPJqoKaMbmJ
         q4sNJiZv4P0l8bQSmVBw8eIOHPPx8xlNsMoieH77afWZzJdNCstZ5oWq0QSSM/hQIwod
         hkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=VN1l4osaPK4fY9j7X5TGynmqPlCTRBZm5aF085gbeqE=;
        b=Sz9FKRd5sUzuy6hqVBX90h/4Ejk13s6FjzGBQHGxYN3zP5e/0squYCYLT6yz20gKaY
         kzCfeHwNxbrExYDifMTMzLa+PvigxBoNNdLVKqvxM/eRvwZN02o2TOm9HqOe/uceJRyc
         R8IeY4gYTkL/TSQyO/ZDR+qAi0ONAkaiVdy2xEXP/F86/Eh0U5yXOW0giBKGEDRcPbgv
         ME63pMyB2wRZUE0jhTHPwDUg+jjN/DFR90DHtGdfqqjAKVyuOqcfCMtSlCh8t+ZGhWIa
         L4UGS8FctUkwYNt370VwgY79xMJZsjPBlyLdZR8meV7Bh7Fuzv5Tsu9OkhZpYjjn8Cx1
         i3og==
X-Gm-Message-State: ACgBeo2pVmCMy+w0WMxCL3qfK0fFBdSdNnK2wvo3mOD2bCfwAgwhVHnQ
        BG0IXOi/uEHXYdaqHF1Mu4+nptgHZWFsjzce
X-Google-Smtp-Source: AA6agR5L5kXU6lOxBm3slyjURq94+x/IBfOmahjwV2LhceKWKeCGEhCcxF6TS2Aalo1VyEx/Bi7pew==
X-Received: by 2002:a7b:c051:0:b0:3a6:36fc:8429 with SMTP id u17-20020a7bc051000000b003a636fc8429mr6721760wmc.78.1661090464958;
        Sun, 21 Aug 2022 07:01:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q4-20020a1c4304000000b003a5c7a942edsm14449642wma.28.2022.08.21.07.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 07:01:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 03/17] submodule--helper: fix most "struct pathspec" memory leaks
Date:   Sun, 21 Aug 2022 15:59:27 +0200
Message-Id: <patch-v6-03.17-a2ecdb301d3-20220821T130415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call clear_pathspec() at the end of various functions that work with
and allocate a "struct pathspec".

In some cases the zero-initialization here isn't strictly needed, but
as we're moving to a "goto cleanup" pattern let's make sure that it's
safe to call clear_pathspec(), we don't want the data to be
uninitialized.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 74 +++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 23 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index da9e0016509..a118f615783 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -379,7 +379,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 static int module_foreach(int argc, const char **argv, const char *prefix)
 {
 	struct foreach_cb info = FOREACH_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	struct option module_foreach_options[] = {
 		OPT__QUIET(&info.quiet, N_("suppress output of entering each submodule command")),
@@ -391,12 +391,13 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
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
@@ -404,7 +405,10 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, runcommand_in_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 static int starts_with_dot_slash(const char *const path)
@@ -515,7 +519,7 @@ static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data
 static int module_init(int argc, const char **argv, const char *prefix)
 {
 	struct init_cb info = INIT_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 	struct option module_init_options[] = {
@@ -526,12 +530,13 @@ static int module_init(int argc, const char **argv, const char *prefix)
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
@@ -546,7 +551,10 @@ static int module_init(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, init_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 struct status_cb {
@@ -693,7 +701,7 @@ static void status_submodule_cb(const struct cache_entry *list_item,
 static int module_status(int argc, const char **argv, const char *prefix)
 {
 	struct status_cb info = STATUS_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 	struct option module_status_options[] = {
@@ -706,12 +714,13 @@ static int module_status(int argc, const char **argv, const char *prefix)
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
@@ -719,7 +728,10 @@ static int module_status(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, status_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 struct module_cb {
@@ -1261,7 +1273,7 @@ static void sync_submodule_cb(const struct cache_entry *list_item, void *cb_data
 static int module_sync(int argc, const char **argv, const char *prefix)
 {
 	struct sync_cb info = SYNC_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 	int recursive = 0;
@@ -1275,12 +1287,13 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 		N_("git submodule sync [--quiet] [--recursive] [<path>]"),
 		NULL
 	};
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, module_sync_options,
 			     git_submodule_helper_usage, 0);
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+		goto cleanup;
 
 	info.prefix = prefix;
 	if (quiet)
@@ -1290,7 +1303,10 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, sync_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 struct deinit_cb {
@@ -1399,7 +1415,7 @@ static void deinit_submodule_cb(const struct cache_entry *list_item,
 static int module_deinit(int argc, const char **argv, const char *prefix)
 {
 	struct deinit_cb info = DEINIT_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 	int force = 0;
@@ -1414,6 +1430,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 		N_("git submodule deinit [--quiet] [-f | --force] [--all | [--] [<path>...]]"),
 		NULL
 	};
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, module_deinit_options,
 			     git_submodule_helper_usage, 0);
@@ -1428,7 +1445,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 		die(_("Use '--all' if you really want to deinitialize all submodules"));
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+		goto cleanup;
 
 	info.prefix = prefix;
 	if (quiet)
@@ -1438,7 +1455,10 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, deinit_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 struct module_clone_data {
@@ -2541,7 +2561,7 @@ static int update_submodules(struct update_data *update_data)
 
 static int module_update(int argc, const char **argv, const char *prefix)
 {
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options = { 0 };
 	int ret;
@@ -2618,8 +2638,8 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		opt.update_strategy.type = opt.update_default;
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0) {
-		list_objects_filter_release(&filter_options);
-		return 1;
+		ret = 1;
+		goto cleanup;
 	}
 
 	if (pathspec.nr)
@@ -2630,8 +2650,10 @@ static int module_update(int argc, const char **argv, const char *prefix)
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
@@ -2648,7 +2670,9 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	}
 
 	ret = update_submodules(&opt);
+cleanup:
 	list_objects_filter_release(&filter_options);
+	clear_pathspec(&pathspec);
 	return ret;
 }
 
@@ -2732,7 +2756,7 @@ static int push_check(int argc, const char **argv, const char *prefix)
 static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	unsigned flags = ABSORB_GITDIR_RECURSE_SUBMODULES;
 	struct option embed_gitdir_options[] = {
@@ -2747,17 +2771,21 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 		N_("git submodule absorbgitdirs [<options>] [<path>...]"),
 		NULL
 	};
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, embed_gitdir_options,
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
 
 static int module_config(int argc, const char **argv, const char *prefix)
-- 
2.37.2.1279.g64dec4e13cf


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98742C433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 12:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbiKSMmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 07:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiKSMly (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 07:41:54 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676958CF0C
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:41:40 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ft34so18969514ejc.12
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvx+E1XZAvvtVIY/FYVscLmSEGgszPvEUCZwSz5aFtg=;
        b=BxFJ0KMeNu/SNaAeH3Y6wRwTIanvetRKdLEf2+jgh07xgKLeVjWBbuoPlX9g1/M6BW
         zqNzUXW60dLMNUtbMQWpJ17fWqkC5lA4+ZFzhn8zLYkMGv8lJgJlgvZrW9M9zOFsLsl/
         ZkXIm1dwwgx3fcDkZJGY1XyFYhS3YlVLoKaAhU/iGDFTBCRXepYhqnX2AIXRNvl/O9T0
         JPCugD98U2OFlJzEizppe+ZjWHFABOKmXGy44avNcz8BQj7UcidE2CItgY95NrpScY0Y
         5/W1yBdrKiXpeY+R6gTCDdcZ8vxk35LQva35xcpXXxmhOST9VDeKT43R9heR/tuFAgE2
         KO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvx+E1XZAvvtVIY/FYVscLmSEGgszPvEUCZwSz5aFtg=;
        b=Ix8cTyR1oI5OTTYWesBCvJc8mSvPYLVeg/1EvJnTFfDDpb7WliccF3VDRnkQkZPhSH
         0h8xjqyhBbFqaezx2V3V71SC6e/GtadHxvTjqQmfBpZZQcZqmn40UcX/NF29TKr1VF+U
         OqVU1HsC6I9k1eKw39CwUntQTehRoXds1F1BdlluPNlN4bDUM3VU1GPyxmJQZZZibQW1
         i/BWQGRiQ0REGVv126ebWoXmxXlykqMrbacQoCrOyoH/28+GHOUyylpcAfSmy/GkBkJy
         /RQ3VuZIxqU/UGMdGgyrgppIaVw+imIpty4OA7mGaeVbf4qUS6bF4vTE30wUG4G1abXl
         Ti7w==
X-Gm-Message-State: ANoB5plTb1w3bFl+B9UZo0CBYL6dNBGxZiE5rt5at3jDWYPBJ9/v2ayV
        NoytSzpifWRrLtA/2gpy6REeNspkq6tqgA==
X-Google-Smtp-Source: AA0mqf6oc+g9X/uARoY6sfkFwhj7dlo1rqMY7EJFvfoM1yNcQkksnFtQ5TFKqvA5mj0+oTiTGa8yhQ==
X-Received: by 2002:a17:906:f858:b0:78d:b654:8af9 with SMTP id ks24-20020a170906f85800b0078db6548af9mr1347423ejb.660.1668861698626;
        Sat, 19 Nov 2022 04:41:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id la19-20020a170907781300b007b29eb8a4dbsm2909276ejc.13.2022.11.19.04.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 04:41:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 7/9] submodule--helper: convert "{update,clone}" to their own "--super-prefix"
Date:   Sat, 19 Nov 2022 13:41:26 +0100
Message-Id: <patch-v3-7.9-754a7489aa5-20221119T122853Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1509.g9445af83948
In-Reply-To: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with a preceding commit to convert "absorbgitdirs", we can convert
"submodule--helper status" to use its own "--super-prefix", instead of
relying on the global "--super-prefix" argument to "git".

We need to convert both of these away from the global "--super-prefix"
at the same time, because "update" will call "clone", but "clone"
itself didn't make use of the global "--super-prefix" for displaying
paths. It was only on the list of sub-commands that accepted it
because "update"'s use of it would set it in its environment.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 32 +++++++++++++-------------------
 git.c                       |  2 +-
 2 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8a186b61b9d..b1945a06da1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -437,11 +437,13 @@ static int starts_with_dot_dot_slash(const char *const path)
 
 struct init_cb {
 	const char *prefix;
+	const char *super_prefix;
 	unsigned int flags;
 };
 #define INIT_CB_INIT { 0 }
 
 static void init_submodule(const char *path, const char *prefix,
+			   const char *super_prefix,
 			   unsigned int flags)
 {
 	const struct submodule *sub;
@@ -449,8 +451,7 @@ static void init_submodule(const char *path, const char *prefix,
 	const char *upd;
 	char *url = NULL, *displaypath;
 
-	displaypath = get_submodule_displaypath(path, prefix,
-						get_super_prefix());
+	displaypath = get_submodule_displaypath(path, prefix, super_prefix);
 
 	sub = submodule_from_path(the_repository, null_oid(), path);
 
@@ -526,7 +527,8 @@ static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data
 {
 	struct init_cb *info = cb_data;
 
-	init_submodule(list_item->name, info->prefix, info->flags);
+	init_submodule(list_item->name, info->prefix, info->super_prefix,
+		       info->flags);
 }
 
 static int module_init(int argc, const char **argv, const char *prefix)
@@ -792,6 +794,7 @@ struct summary_cb {
 	int argc;
 	const char **argv;
 	const char *prefix;
+	const char *super_prefix;
 	unsigned int cached: 1;
 	unsigned int for_status: 1;
 	unsigned int files: 1;
@@ -954,7 +957,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 	}
 
 	displaypath = get_submodule_displaypath(p->sm_path, info->prefix,
-						get_super_prefix());
+						info->super_prefix);
 
 	if (!missing_src && !missing_dst) {
 		struct child_process cp_rev_list = CHILD_PROCESS_INIT;
@@ -1893,6 +1896,7 @@ static void submodule_update_clone_release(struct submodule_update_clone *suc)
 
 struct update_data {
 	const char *prefix;
+	const char *super_prefix;
 	char *displaypath;
 	enum submodule_update_type update_default;
 	struct object_id suboid;
@@ -1969,7 +1973,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	char *key;
 	const struct update_data *ud = suc->update_data;
 	char *displaypath = get_submodule_displaypath(ce->name, ud->prefix,
-						      get_super_prefix());
+						      ud->super_prefix);
 	struct strbuf sb = STRBUF_INIT;
 	int needs_cloning = 0;
 	int need_free_url = 0;
@@ -2449,11 +2453,11 @@ static void update_data_to_args(const struct update_data *update_data,
 {
 	enum submodule_update_type update_type = update_data->update_default;
 
+	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
 	if (update_data->displaypath) {
 		strvec_push(args, "--super-prefix");
 		strvec_pushf(args, "%s/", update_data->displaypath);
 	}
-	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
 	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
 	if (update_data->quiet)
 		strvec_push(args, "--quiet");
@@ -2620,7 +2624,7 @@ static int update_submodules(struct update_data *update_data)
 
 		update_data->displaypath = get_submodule_displaypath(
 			update_data->sm_path, update_data->prefix,
-			get_super_prefix());
+			update_data->super_prefix);
 		code = update_submodule(update_data);
 		FREE_AND_NULL(update_data->displaypath);
 fail:
@@ -2646,6 +2650,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		LIST_OBJECTS_FILTER_INIT;
 	int ret;
 	struct option module_update_options[] = {
+		OPT__SUPER_PREFIX(&opt.super_prefix),
 		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
 		OPT_BOOL(0, "init", &opt.init,
 			 N_("initialize uninitialized submodules before update")),
@@ -2742,6 +2747,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 			module_list_active(&list);
 
 		info.prefix = opt.prefix;
+		info.super_prefix = opt.super_prefix;
 		if (opt.quiet)
 			info.flags |= OPT_QUIET;
 
@@ -3368,8 +3374,6 @@ static int module_add(int argc, const char **argv, const char *prefix)
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 {
-	const char *cmd = argv[0];
-	const char *subcmd;
 	parse_opt_subcommand_fn *fn = NULL;
 	const char *const usage[] = {
 		N_("git submodule--helper <command>"),
@@ -3393,16 +3397,6 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
-	subcmd = argv[0];
-
-	if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
-	    get_super_prefix())
-		/*
-		 * xstrfmt() rather than "%s %s" to keep the translated
-		 * string identical to git.c's.
-		 */
-		die(_("%s doesn't support --super-prefix"),
-		    xstrfmt("'%s %s'", cmd, subcmd));
 
 	return fn(argc, argv, prefix);
 }
diff --git a/git.c b/git.c
index b1b7e1a837e..2bca22cfd9a 100644
--- a/git.c
+++ b/git.c
@@ -610,7 +610,7 @@ static struct cmd_struct commands[] = {
 	{ "stash", cmd_stash, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
-	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX },
+	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP },
 	{ "switch", cmd_switch, RUN_SETUP | NEED_WORK_TREE },
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 	{ "tag", cmd_tag, RUN_SETUP | DELAY_PAGER_CONFIG },
-- 
2.38.0.1509.g9445af83948


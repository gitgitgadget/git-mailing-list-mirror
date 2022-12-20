Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1031C4167B
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 12:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiLTMnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 07:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiLTMnK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 07:43:10 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBFF1ADBA
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 04:40:21 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso10994646wme.5
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 04:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agLIQV1H9+TvLmB6dhIZpRFjwNfvnZsAYcGGLPPbhx4=;
        b=CQv3G1x9IGBbGEyuYMbPFVh0JCNu65uGXpwRU3SC2KrmdlfgQ5+JrYyx+Wp8AHi8bc
         lj1tc/fxoTfEpVusdsKS3Cq/spVegY0Mp2cr8arzxo+5Ur7RZcEoEfAVL8apkY3uuSaJ
         PRdpuoQjYPQQgKER2+KXzLycXe5YTeWset67Dm2Q7YMZaNJZjIRZHObERQC+bm0uY9Sj
         w3LJDLMOgutGWooO/ncisw4AFCwnBOJ4rCwcWQJ2/L7SFxgtyhWjARwA24JKRqVZWTPN
         y0330nvgxSFOX7CkMYP4aiqbb4eI1rtYNyct59qZCKSrxgyV/At+r4rKWEQIc0b9DV3y
         qm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agLIQV1H9+TvLmB6dhIZpRFjwNfvnZsAYcGGLPPbhx4=;
        b=hYkR9hb7NW4M8wp68QVlkOdx/+Zz1saQDnqbvAYK0ApHywZrkYRMAnTVXQqrZNPwgp
         4lODAUmjIbmlcbK/E2N/5rm3LHlqHATyoBwMZMLvr60KGduPxjkPH9pwGsIwNHXlSOVe
         tEm+H7TMTsDsmU6uXUAs0T42kHdKqMb3ctc6SHkdTCvXC/J/h6fjGeYJuvNWXWvsmDPT
         dgGEY8daS2sg/SvHt3cDxEH6eDiOy0ld8Z1MyYMBwBQxzzuDeuMJ4RvJZvfkepZAgRir
         YwFEEEtPzvuTB9FHMAVIFKF8yvkwSLQQ+Iw+HDm5zdYhqUL3S3MUR0fxziavk751JBGt
         hZ/g==
X-Gm-Message-State: AFqh2kqd/C9NB7HmOHrcvTwCb0e9rmkCbiLaOoHM+R/mFNnv/yXdYLFa
        YImgj+16RxhiQev4TnxUhs7dtojhu377ug==
X-Google-Smtp-Source: AMrXdXtjROdPjRQ2Ln9A4yRwSxeGnAUBhryc8G3yLM614JN3SLUBXL/elGt8CJcZqt4YAs11RLvt2g==
X-Received: by 2002:a05:600c:5563:b0:3d5:365b:773e with SMTP id ja3-20020a05600c556300b003d5365b773emr1805369wmb.39.1671540009318;
        Tue, 20 Dec 2022 04:40:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b003d355ad9bb7sm9630759wmq.20.2022.12.20.04.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:40:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 8/9] submodule--helper: convert "{update,clone}" to their own "--super-prefix"
Date:   Tue, 20 Dec 2022 13:39:55 +0100
Message-Id: <patch-v5-8.9-72e774ebb06-20221220T104519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1106.g08bce9674be
In-Reply-To: <cover-v5-0.9-00000000000-20221220T104519Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com> <cover-v5-0.9-00000000000-20221220T104519Z-avarab@gmail.com>
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
index 448896f1b1d..a0aa4635a0c 100644
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
index e473b4b7d72..2c31ba27040 100644
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
2.39.0.1071.g97ce8966538


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998C6C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 12:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BED5613B2
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 12:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhFNM47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 08:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbhFNM46 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 08:56:58 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D9CC061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 05:54:41 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id z26so10481857pfj.5
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 05:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FK30CWlcBHds5nQMmMXbdK4q/ax4TX+g38bM42pZPb4=;
        b=bJ0a6MlhY4+zHtKcLqMRbREGVgRHEHkae8Zwh83TUQ/WiPyCKIJG1+XmThFweZlLey
         XvrxpYWFy1LguUTYJZ7ReU69rhn0SyqkoRlhGt8WZHd5RbezdTzb5hSIwOkGp4xRmJsf
         VFmkwRkbOE/nsYDm2WsSbl5toxDcWuwjXVRAvh4nOMBTJbtE9Sr414IHMjty/ClhK9n9
         3rev5AWnrcQz6hsh58PUDw4EzWOGnl6BEF6vQageIAqciurqV4A6CUuxqbUH3XXScpWC
         NpdvipgoSFRMEFk/RdzgTuguI400eG2lZpitVUubzQOkkIOnRLvQdNqkcdI101ViFgCB
         PhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FK30CWlcBHds5nQMmMXbdK4q/ax4TX+g38bM42pZPb4=;
        b=VeOq4GemN70kmi+8rRYB6EsFfQ7eP45siZAlOkibYzQloS2tsCG3Hv+GuX/2f047z5
         rh0e2qB1cACnMfz92kBLWrnppDTv5I2Ztogl+btYzgpr/dELcJicAWdwW1ZDws3LvjUm
         NMJcflvjaZS0kCPKN+gTBJYpJDuTIghTP+UuSRCW0LxJ5xoMwSZhnqgiLe+rlREACCK+
         qABSwXEffpd8MVZvzrP5mkLK5PlxxLjjzE2DcYRegxaXGj8A2JZ9yaWh2gQ3MZ8BH/cB
         c7yyfnC703qxr2YvSmd28s8HIitKC4e7tHn6UPi4RZ2HgHuWV9F300QPjBauMQb7QNwK
         VDjQ==
X-Gm-Message-State: AOAM5315Bcu62NqOVAzwyf0vmgh01HbKe0g52zD2634/fNbzM61UWX9n
        Pgqz/6pHFFq1KrIWdNcMYjSkNZaIEJ41CV/Q
X-Google-Smtp-Source: ABdhPJyC3dKDcQZjHXqiCmo2udp9HgTG9LHUQBvRZGaxgN1xy/5qSbWgUubcCv2mnSxD4muw2zf8Tw==
X-Received: by 2002:a62:cd46:0:b029:2ea:299c:d7bd with SMTP id o67-20020a62cd460000b02902ea299cd7bdmr21864683pfg.72.1623675280742;
        Mon, 14 Jun 2021 05:54:40 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id k9sm12907085pgq.27.2021.06.14.05.54.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jun 2021 05:54:40 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>
Subject: [PATCH v4 1/3] submodule--helper: refactor module_clone()
Date:   Mon, 14 Jun 2021 18:21:55 +0530
Message-Id: <20210614125157.99426-2-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614125157.99426-1-raykar.ath@gmail.com>
References: <20210610083916.96243-1-raykar.ath@gmail.com>
 <20210614125157.99426-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Separate out the core logic of module_clone() from the flag
parsing---this way we can call the equivalent of the `submodule--helper
clone` subcommand directly within C, without needing to push arguments
in a strvec.
---
 builtin/submodule--helper.c | 241 +++++++++++++++++++-----------------
 1 file changed, 128 insertions(+), 113 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d55f6262e9..321b623d81 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1658,45 +1658,20 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int clone_submodule(const char *path, const char *gitdir, const char *url,
-			   const char *depth, struct string_list *reference, int dissociate,
-			   int quiet, int progress, int single_branch)
-{
-	struct child_process cp = CHILD_PROCESS_INIT;
-
-	strvec_push(&cp.args, "clone");
-	strvec_push(&cp.args, "--no-checkout");
-	if (quiet)
-		strvec_push(&cp.args, "--quiet");
-	if (progress)
-		strvec_push(&cp.args, "--progress");
-	if (depth && *depth)
-		strvec_pushl(&cp.args, "--depth", depth, NULL);
-	if (reference->nr) {
-		struct string_list_item *item;
-		for_each_string_list_item(item, reference)
-			strvec_pushl(&cp.args, "--reference",
-				     item->string, NULL);
-	}
-	if (dissociate)
-		strvec_push(&cp.args, "--dissociate");
-	if (gitdir && *gitdir)
-		strvec_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
-	if (single_branch >= 0)
-		strvec_push(&cp.args, single_branch ?
-					  "--single-branch" :
-					  "--no-single-branch");
-
-	strvec_push(&cp.args, "--");
-	strvec_push(&cp.args, url);
-	strvec_push(&cp.args, path);
-
-	cp.git_cmd = 1;
-	prepare_submodule_repo_env(&cp.env_array);
-	cp.no_stdin = 1;
-
-	return run_command(&cp);
-}
+struct module_clone_data {
+	const char* prefix;
+	const char* path;
+	const char* name;
+	const char* url;
+	const char* depth;
+	struct string_list reference;
+	unsigned int quiet: 1;
+	unsigned int progress: 1;
+	unsigned int dissociate: 1;
+	unsigned int require_init: 1;
+	int single_branch;
+};
+#define MODULE_CLONE_DATA_INIT { .reference = STRING_LIST_INIT_NODUP, .single_branch = -1 }
 
 struct submodule_alternate_setup {
 	const char *submodule_name;
@@ -1802,37 +1777,128 @@ static void prepare_possible_alternates(const char *sm_name,
 	free(error_strategy);
 }
 
+static int clone_submodule(struct module_clone_data *clone_data)
+{
+	char *p, *sm_gitdir;
+	char *sm_alternate = NULL, *error_strategy = NULL;
+	struct strbuf sb = STRBUF_INIT;
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), clone_data->name);
+	sm_gitdir = absolute_pathdup(sb.buf);
+	strbuf_reset(&sb);
+
+	if (!is_absolute_path(clone_data->path)) {
+		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
+		clone_data->path = strbuf_detach(&sb, NULL);
+	} else {
+		clone_data->path = xstrdup(clone_data->path);
+	}
+
+	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
+		die(_("refusing to create/use '%s' in another submodule's "
+		      "git dir"), sm_gitdir);
+
+	if (!file_exists(sm_gitdir)) {
+		if (safe_create_leading_directories_const(sm_gitdir) < 0)
+			die(_("could not create directory '%s'"), sm_gitdir);
+
+		prepare_possible_alternates(clone_data->name, &clone_data->reference);
+
+		strvec_push(&cp.args, "clone");
+		strvec_push(&cp.args, "--no-checkout");
+		if (clone_data->quiet)
+			strvec_push(&cp.args, "--quiet");
+		if (clone_data->progress)
+			strvec_push(&cp.args, "--progress");
+		if (clone_data->depth && *(clone_data->depth))
+			strvec_pushl(&cp.args, "--depth", clone_data->depth, NULL);
+		if (clone_data->reference.nr) {
+			struct string_list_item *item;
+			for_each_string_list_item(item, &clone_data->reference)
+				strvec_pushl(&cp.args, "--reference",
+					     item->string, NULL);
+		}
+		if (clone_data->dissociate)
+			strvec_push(&cp.args, "--dissociate");
+		if (sm_gitdir && *sm_gitdir)
+			strvec_pushl(&cp.args, "--separate-git-dir", sm_gitdir, NULL);
+		if (clone_data->single_branch >= 0)
+			strvec_push(&cp.args, clone_data->single_branch ?
+				    "--single-branch" :
+				    "--no-single-branch");
+
+		strvec_push(&cp.args, "--");
+		strvec_push(&cp.args, clone_data->url);
+		strvec_push(&cp.args, clone_data->path);
+
+		cp.git_cmd = 1;
+		prepare_submodule_repo_env(&cp.env_array);
+		cp.no_stdin = 1;
+
+		if(run_command(&cp))
+			die(_("clone of '%s' into submodule path '%s' failed"),
+			    clone_data->url, clone_data->path);
+	} else {
+		if (clone_data->require_init && !access(clone_data->path, X_OK) &&
+		    !is_empty_dir(clone_data->path))
+			die(_("directory not empty: '%s'"), clone_data->path);
+		if (safe_create_leading_directories_const(clone_data->path) < 0)
+			die(_("could not create directory '%s'"), clone_data->path);
+		strbuf_addf(&sb, "%s/index", sm_gitdir);
+		unlink_or_warn(sb.buf);
+		strbuf_reset(&sb);
+	}
+
+	connect_work_tree_and_git_dir(clone_data->path, sm_gitdir, 0);
+
+	p = git_pathdup_submodule(clone_data->path, "config");
+	if (!p)
+		die(_("could not get submodule directory for '%s'"), clone_data->path);
+
+	/* setup alternateLocation and alternateErrorStrategy in the cloned submodule if needed */
+	git_config_get_string("submodule.alternateLocation", &sm_alternate);
+	if (sm_alternate)
+		git_config_set_in_file(p, "submodule.alternateLocation",
+				       sm_alternate);
+	git_config_get_string("submodule.alternateErrorStrategy", &error_strategy);
+	if (error_strategy)
+		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
+				       error_strategy);
+
+	free(sm_alternate);
+	free(error_strategy);
+
+	strbuf_release(&sb);
+	free(sm_gitdir);
+	free(p);
+	return 0;
+}
+
 static int module_clone(int argc, const char **argv, const char *prefix)
 {
-	const char *name = NULL, *url = NULL, *depth = NULL;
-	int quiet = 0;
-	int progress = 0;
-	char *p, *path = NULL, *sm_gitdir;
-	struct strbuf sb = STRBUF_INIT;
-	struct string_list reference = STRING_LIST_INIT_NODUP;
-	int dissociate = 0, require_init = 0;
-	char *sm_alternate = NULL, *error_strategy = NULL;
-	int single_branch = -1;
+	int dissociate = 0, quiet = 0, progress = 0, require_init = 0;
+	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
 
 	struct option module_clone_options[] = {
-		OPT_STRING(0, "prefix", &prefix,
+		OPT_STRING(0, "prefix", &clone_data.prefix,
 			   N_("path"),
 			   N_("alternative anchor for relative paths")),
-		OPT_STRING(0, "path", &path,
+		OPT_STRING(0, "path", &clone_data.path,
 			   N_("path"),
 			   N_("where the new submodule will be cloned to")),
-		OPT_STRING(0, "name", &name,
+		OPT_STRING(0, "name", &clone_data.name,
 			   N_("string"),
 			   N_("name of the new submodule")),
-		OPT_STRING(0, "url", &url,
+		OPT_STRING(0, "url", &clone_data.url,
 			   N_("string"),
 			   N_("url where to clone the submodule from")),
-		OPT_STRING_LIST(0, "reference", &reference,
+		OPT_STRING_LIST(0, "reference", &clone_data.reference,
 			   N_("repo"),
 			   N_("reference repository")),
 		OPT_BOOL(0, "dissociate", &dissociate,
 			   N_("use --reference only while cloning")),
-		OPT_STRING(0, "depth", &depth,
+		OPT_STRING(0, "depth", &clone_data.depth,
 			   N_("string"),
 			   N_("depth for shallow clones")),
 		OPT__QUIET(&quiet, "Suppress output for cloning a submodule"),
@@ -1840,7 +1906,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 			   N_("force cloning progress")),
 		OPT_BOOL(0, "require-init", &require_init,
 			   N_("disallow cloning into non-empty directory")),
-		OPT_BOOL(0, "single-branch", &single_branch,
+		OPT_BOOL(0, "single-branch", &clone_data.single_branch,
 			 N_("clone only one branch, HEAD or --branch")),
 		OPT_END()
 	};
@@ -1856,67 +1922,16 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_clone_options,
 			     git_submodule_helper_usage, 0);
 
-	if (argc || !url || !path || !*path)
+	clone_data.dissociate = !!dissociate;
+	clone_data.quiet = !!quiet;
+	clone_data.progress = !!progress;
+	clone_data.require_init = !!require_init;
+
+	if (argc || !clone_data.url || !clone_data.path || !*(clone_data.path))
 		usage_with_options(git_submodule_helper_usage,
 				   module_clone_options);
 
-	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
-	sm_gitdir = absolute_pathdup(sb.buf);
-	strbuf_reset(&sb);
-
-	if (!is_absolute_path(path)) {
-		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), path);
-		path = strbuf_detach(&sb, NULL);
-	} else
-		path = xstrdup(path);
-
-	if (validate_submodule_git_dir(sm_gitdir, name) < 0)
-		die(_("refusing to create/use '%s' in another submodule's "
-			"git dir"), sm_gitdir);
-
-	if (!file_exists(sm_gitdir)) {
-		if (safe_create_leading_directories_const(sm_gitdir) < 0)
-			die(_("could not create directory '%s'"), sm_gitdir);
-
-		prepare_possible_alternates(name, &reference);
-
-		if (clone_submodule(path, sm_gitdir, url, depth, &reference, dissociate,
-				    quiet, progress, single_branch))
-			die(_("clone of '%s' into submodule path '%s' failed"),
-			    url, path);
-	} else {
-		if (require_init && !access(path, X_OK) && !is_empty_dir(path))
-			die(_("directory not empty: '%s'"), path);
-		if (safe_create_leading_directories_const(path) < 0)
-			die(_("could not create directory '%s'"), path);
-		strbuf_addf(&sb, "%s/index", sm_gitdir);
-		unlink_or_warn(sb.buf);
-		strbuf_reset(&sb);
-	}
-
-	connect_work_tree_and_git_dir(path, sm_gitdir, 0);
-
-	p = git_pathdup_submodule(path, "config");
-	if (!p)
-		die(_("could not get submodule directory for '%s'"), path);
-
-	/* setup alternateLocation and alternateErrorStrategy in the cloned submodule if needed */
-	git_config_get_string("submodule.alternateLocation", &sm_alternate);
-	if (sm_alternate)
-		git_config_set_in_file(p, "submodule.alternateLocation",
-					   sm_alternate);
-	git_config_get_string("submodule.alternateErrorStrategy", &error_strategy);
-	if (error_strategy)
-		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
-					   error_strategy);
-
-	free(sm_alternate);
-	free(error_strategy);
-
-	strbuf_release(&sb);
-	free(sm_gitdir);
-	free(path);
-	free(p);
+	clone_submodule(&clone_data);
 	return 0;
 }
 
-- 
2.31.1


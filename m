Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D65CC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B13D6142E
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhFOJks (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 05:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhFOJkr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 05:40:47 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD42C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 02:38:43 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e22so10936234pgv.10
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 02:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W0O5QM47p2GTw/HlGeQhYBlfPP1YTCy6+Ry2+Z67e8Q=;
        b=BLzkoHEYdJxNIInR2WlOXqP5qF95q4ll7lbayhPEQCXjRle/qcAXjSHyxXhycDPWXU
         kPnmWeQ0EEcdq2ur1kAC8Rl3Ijsd/xVbj3ZfKjn/6d3ttw1AO8ch9jsq8Lf0VPLtOXUO
         jyYml7wdNVA+peziVSKNJZAJg4mkDsnFZmSYl5gmkzQS48q/r5kSPVyqAm/9oGkBcgdj
         fVOTUtA4gSmBIarp2QMaK9rSO8jjuK16O5v77KThTqG9lmcJifChREZshAlU0rIgvZ51
         0s+x9AkRFgKz3zCGbKKAANDrmbmfWDMMzejs46NkPItO42mJgLRtkIeDf9uXlRfQ7U0k
         g2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W0O5QM47p2GTw/HlGeQhYBlfPP1YTCy6+Ry2+Z67e8Q=;
        b=uhcyzuUGW87Y03kvQwq14gd0AwmDoO7iY0SvwL9ifvKTyTiMepcuw3JxkNQTDw6T2b
         HQERz+05zkRaACe3VpHAg8vGVXyAa1+9247queJVEfjXsqjibjCYmzlatR0RQSlb4v9g
         h/uRQfWTaW+smW3mhkV90RAn1U5aqYrAvAP+GQsmmXsN2BRN5NdmdxtVwDckcy2eQLuq
         gwu+SXNGjdKSJT+QUU3pcqiNYfYgElltUy4KJStwR5/9fUunz/++xFkUEPKlYEqlEBJM
         hV8oRDQIpfYBXWqPrK7DnVATk2UAUcKHY7vBREcRG0L+EsfgGWAQ9/v3F4p7qT74TTJc
         wvtw==
X-Gm-Message-State: AOAM5302WZ59S/BmbIgY2Krv4vKz995majquBgzQFwZobUlyDK3rgUQO
        I8+5kr9t/9Ayb1WexpHtaNB0LCu6buOu4egj6ks=
X-Google-Smtp-Source: ABdhPJzk9rHQJgchjNa+JTjJb/NU3RXzRX8hl4Ha9hyVFIQHUm7hVuvGObXPZfp6MqaxYHI5649MOg==
X-Received: by 2002:a62:5e05:0:b029:2fb:2ee4:2b9c with SMTP id s5-20020a625e050000b02902fb2ee42b9cmr3613291pfb.0.1623749922645;
        Tue, 15 Jun 2021 02:38:42 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id p11sm14669854pfo.126.2021.06.15.02.38.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jun 2021 02:38:42 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 1/3] submodule--helper: refactor module_clone()
Date:   Tue, 15 Jun 2021 15:08:08 +0530
Message-Id: <20210615093810.27930-2-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210615093810.27930-1-raykar.ath@gmail.com>
References: <20210614125157.99426-1-raykar.ath@gmail.com>
 <20210615093810.27930-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Separate out the core logic of module_clone() from the flag
parsing---this way we can call the equivalent of the `submodule--helper
clone` subcommand directly within C, without needing to push arguments
in a strvec.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <shouryashukla.oo@gmail.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 241 +++++++++++++++++++-----------------
 1 file changed, 128 insertions(+), 113 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d55f6262e9..ae246a35f9 100644
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
+	const char *prefix;
+	const char *path;
+	const char *name;
+	const char *url;
+	const char *depth;
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
 
-static int module_clone(int argc, const char **argv, const char *prefix)
+static int clone_submodule(struct module_clone_data *clone_data)
 {
-	const char *name = NULL, *url = NULL, *depth = NULL;
-	int quiet = 0;
-	int progress = 0;
-	char *p, *path = NULL, *sm_gitdir;
-	struct strbuf sb = STRBUF_INIT;
-	struct string_list reference = STRING_LIST_INIT_NODUP;
-	int dissociate = 0, require_init = 0;
+	char *p, *sm_gitdir;
 	char *sm_alternate = NULL, *error_strategy = NULL;
-	int single_branch = -1;
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
+static int module_clone(int argc, const char **argv, const char *prefix)
+{
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


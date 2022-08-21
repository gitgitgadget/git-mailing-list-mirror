Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC9FC00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiHUN7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiHUN6q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:58:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2602817AAB
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id ay12so4373334wmb.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DOQgtSb1e64SllI1i6oH4T0Tq9wMW4+1Ny4nIHi5g+0=;
        b=M97x+EQTJJ4/s/dm9yefYlfQPDFAmF2/j0Za7nw+92o+nPrdK+8hNAb7SPSx/R6xIg
         e48B20C5KR+Tg0JV5OJWKIZKv8/RHoWVNZceyW1W3R0nk+VliEzcnv5CZGHfAXEyPRcn
         Pdx+HYBFcR/ZpoH6m8um7QaTOeA4xhG/kmF3jER6vfsIWQaLz9lmDZZ2/OjF8RBdRdWM
         /0pZ05tF4xqiy1M6wFQrZ7Ryy3r7HrGKjRdX33d+TuwXujvogqC4O+xRkZiHX8tMqYdJ
         paRQ/Q3APR2ke31v+RC6YHlHI1llDugivw66x3C0ctfyowSNZphutzUg/lufmT1NPq4a
         cayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DOQgtSb1e64SllI1i6oH4T0Tq9wMW4+1Ny4nIHi5g+0=;
        b=rjESlptvkUOAefNRc3diSbI6lnUE70mch40RZf4DaZuxvmRj54dAE/LtZQ0tbPNixa
         OgnwFGuMZt73ZyaWW4oqpNbcF1g/1/LLklF16/nqQUgHtCr+V0FFo6d1shT/i4xRe7KP
         WxD8a33xUtH6/CGZ978b3VufCI3fTFZk7o/o7xmGFZDuuIrrD5tgEM0MyPhxEdmQgkWP
         V3DIXhiSmLCxiwLPxgnKx/E04Ff8hFNJEz3zMjdYSPfzNmauLyBbT0EsyNlxxTt1UiT4
         eqpforW9eagcKSkCKuzrC+1wd648AgrGRbZCikyDC6QG0Hf8cShEfNhIPZU/TuyRQrA6
         34bA==
X-Gm-Message-State: ACgBeo3YbptWDAZpJR6MnFapYSDjS4dmCqaF9lUjeG+UN+9e7DxluP5G
        qNc1uHR27cBks+JNgOq0rULzHBeWvXdt1Y0n
X-Google-Smtp-Source: AA6agR7JdJRcsQYrftXOJoG2g83FHhU3x99rVaFkwjBVtKb3gM6XDQi7R7BdYYBk+TIv6Sw9EH0irw==
X-Received: by 2002:a7b:cd0f:0:b0:3a5:ec59:daf0 with SMTP id f15-20020a7bcd0f000000b003a5ec59daf0mr12695908wmj.13.1661090319897;
        Sun, 21 Aug 2022 06:58:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 14/32] submodule--helper: add "const" to passed "module_clone_data"
Date:   Sun, 21 Aug 2022 15:57:23 +0200
Message-Id: <patch-v3-14.32-ad7848067a9-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add "const" to the "struct module_clone_data" that we pass to
clone_submodule(), which makes the ownership clear, and stops us from
clobbering the "clone_data->path".

We still need to add to the "reference" member, which is a "struct
string_list". Let's do this by having clone_submodule() create its
own, and copy the contents over, allowing us to pass it as a
separate parameter.

This new "struct string_list" still leaks memory, just as the "struct
module_clone_data" did before. let's not fix that for now, to fix that
we'll need to add some "goto cleanup" to the relevant code. That will
eventually be done in follow-up commits, this change makes it easier
to fix the memory leak.

The scope of the new "reference" variable in add_submodule() could be
narrowed to the "else" block, but as we'll eventually free it with a
"goto cleanup" let's declare it at the start of the function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 49 ++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2f1f0e1bf34..d243c3ddfd3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1437,7 +1437,6 @@ struct module_clone_data {
 	const char *url;
 	const char *depth;
 	struct list_objects_filter_options *filter_options;
-	struct string_list reference;
 	unsigned int quiet: 1;
 	unsigned int progress: 1;
 	unsigned int dissociate: 1;
@@ -1445,7 +1444,6 @@ struct module_clone_data {
 	int single_branch;
 };
 #define MODULE_CLONE_DATA_INIT { \
-	.reference = STRING_LIST_INIT_NODUP, \
 	.single_branch = -1, \
 }
 
@@ -1572,18 +1570,20 @@ static char *clone_submodule_sm_gitdir(const char *name)
 	return sm_gitdir;
 }
 
-static int clone_submodule(struct module_clone_data *clone_data)
+static int clone_submodule(const struct module_clone_data *clone_data,
+			   struct string_list *reference)
 {
 	char *p;
 	char *sm_gitdir = clone_submodule_sm_gitdir(clone_data->name);
 	char *sm_alternate = NULL, *error_strategy = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
+	const char *clone_data_path;
 
 	if (!is_absolute_path(clone_data->path))
-		clone_data->path = xstrfmt("%s/%s", get_git_work_tree(),
-					   clone_data->path);
+		clone_data_path = xstrfmt("%s/%s", get_git_work_tree(),
+					  clone_data->path);
 	else
-		clone_data->path = xstrdup(clone_data->path);
+		clone_data_path = xstrdup(clone_data->path);
 
 	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
 		die(_("refusing to create/use '%s' in another submodule's "
@@ -1593,7 +1593,7 @@ static int clone_submodule(struct module_clone_data *clone_data)
 		if (safe_create_leading_directories_const(sm_gitdir) < 0)
 			die(_("could not create directory '%s'"), sm_gitdir);
 
-		prepare_possible_alternates(clone_data->name, &clone_data->reference);
+		prepare_possible_alternates(clone_data->name, reference);
 
 		strvec_push(&cp.args, "clone");
 		strvec_push(&cp.args, "--no-checkout");
@@ -1603,10 +1603,10 @@ static int clone_submodule(struct module_clone_data *clone_data)
 			strvec_push(&cp.args, "--progress");
 		if (clone_data->depth && *(clone_data->depth))
 			strvec_pushl(&cp.args, "--depth", clone_data->depth, NULL);
-		if (clone_data->reference.nr) {
+		if (reference->nr) {
 			struct string_list_item *item;
 
-			for_each_string_list_item(item, &clone_data->reference)
+			for_each_string_list_item(item, reference)
 				strvec_pushl(&cp.args, "--reference",
 					     item->string, NULL);
 		}
@@ -1625,7 +1625,7 @@ static int clone_submodule(struct module_clone_data *clone_data)
 
 		strvec_push(&cp.args, "--");
 		strvec_push(&cp.args, clone_data->url);
-		strvec_push(&cp.args, clone_data->path);
+		strvec_push(&cp.args, clone_data_path);
 
 		cp.git_cmd = 1;
 		prepare_submodule_repo_env(&cp.env);
@@ -1633,25 +1633,25 @@ static int clone_submodule(struct module_clone_data *clone_data)
 
 		if(run_command(&cp))
 			die(_("clone of '%s' into submodule path '%s' failed"),
-			    clone_data->url, clone_data->path);
+			    clone_data->url, clone_data_path);
 	} else {
 		char *path;
 
-		if (clone_data->require_init && !access(clone_data->path, X_OK) &&
-		    !is_empty_dir(clone_data->path))
-			die(_("directory not empty: '%s'"), clone_data->path);
-		if (safe_create_leading_directories_const(clone_data->path) < 0)
-			die(_("could not create directory '%s'"), clone_data->path);
+		if (clone_data->require_init && !access(clone_data_path, X_OK) &&
+		    !is_empty_dir(clone_data_path))
+			die(_("directory not empty: '%s'"), clone_data_path);
+		if (safe_create_leading_directories_const(clone_data_path) < 0)
+			die(_("could not create directory '%s'"), clone_data_path);
 		path = xstrfmt("%s/index", sm_gitdir);
 		unlink_or_warn(path);
 		free(path);
 	}
 
-	connect_work_tree_and_git_dir(clone_data->path, sm_gitdir, 0);
+	connect_work_tree_and_git_dir(clone_data_path, sm_gitdir, 0);
 
-	p = git_pathdup_submodule(clone_data->path, "config");
+	p = git_pathdup_submodule(clone_data_path, "config");
 	if (!p)
-		die(_("could not get submodule directory for '%s'"), clone_data->path);
+		die(_("could not get submodule directory for '%s'"), clone_data_path);
 
 	/* setup alternateLocation and alternateErrorStrategy in the cloned submodule if needed */
 	git_config_get_string("submodule.alternateLocation", &sm_alternate);
@@ -1676,6 +1676,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	int dissociate = 0, quiet = 0, progress = 0, require_init = 0;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
 	struct list_objects_filter_options filter_options = { 0 };
+	struct string_list reference = STRING_LIST_INIT_NODUP;
 	struct option module_clone_options[] = {
 		OPT_STRING(0, "prefix", &clone_data.prefix,
 			   N_("path"),
@@ -1689,7 +1690,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "url", &clone_data.url,
 			   N_("string"),
 			   N_("url where to clone the submodule from")),
-		OPT_STRING_LIST(0, "reference", &clone_data.reference,
+		OPT_STRING_LIST(0, "reference", &reference,
 			   N_("repo"),
 			   N_("reference repository")),
 		OPT_BOOL(0, "dissociate", &dissociate,
@@ -1728,7 +1729,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_submodule_helper_usage,
 				   module_clone_options);
 
-	clone_submodule(&clone_data);
+	clone_submodule(&clone_data, &reference);
 	list_objects_filter_release(&filter_options);
 	return 0;
 }
@@ -2916,6 +2917,7 @@ static int add_submodule(const struct add_data *add_data)
 {
 	char *submod_gitdir_path;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
+	struct string_list reference = STRING_LIST_INIT_NODUP;
 
 	/* perhaps the path already exists and is already a git repo, else clone it */
 	if (is_directory(add_data->sm_path)) {
@@ -2932,6 +2934,7 @@ static int add_submodule(const struct add_data *add_data)
 		free(submod_gitdir_path);
 	} else {
 		struct child_process cp = CHILD_PROCESS_INIT;
+
 		submod_gitdir_path = xstrfmt(".git/modules/%s", add_data->sm_name);
 
 		if (is_directory(submod_gitdir_path)) {
@@ -2971,13 +2974,13 @@ static int add_submodule(const struct add_data *add_data)
 		clone_data.quiet = add_data->quiet;
 		clone_data.progress = add_data->progress;
 		if (add_data->reference_path)
-			string_list_append(&clone_data.reference,
+			string_list_append(&reference,
 					   xstrdup(add_data->reference_path));
 		clone_data.dissociate = add_data->dissociate;
 		if (add_data->depth >= 0)
 			clone_data.depth = xstrfmt("%d", add_data->depth);
 
-		if (clone_submodule(&clone_data))
+		if (clone_submodule(&clone_data, &reference))
 			return -1;
 
 		prepare_submodule_repo_env(&cp.env);
-- 
2.37.2.1279.g64dec4e13cf


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CD5C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 15:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbiJZPhT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 11:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbiJZPhL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 11:37:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BCF132DC7
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:36:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g12so14213646wrs.10
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YkOAAVekhipes04yfRYM4Wej+5sf5u/ItiK+Lwg/1U=;
        b=YsElhwWzQ5GwXf024qWOs0BUwtEAi3YOWDlkM6BMaxz0zMudTQUzlQ7owdFJZm7D0S
         NSqxSKkvLJFBQrWUYXWyd8WHjWO6FdEXF+oX7zkIljeGArYgeW9B/3NOgB+1ttODo7zJ
         lr+DeWIY9mPkxX5zBYHObz8oBFG5PE9yCsL+epc24IW0/e7qGrhUMPElyJjdaEiqwYeK
         2cHbVgMTDMFWO6vm5mQ7ShFmnyPudf01aXD19jSWyqqrJq0yOs3w5pS/ocu14zF3MgYj
         p+DKFdZ3lvO18gDyjLlCOZlQxLf5Sx1MhcSHv764/rcqbDQoHL/KjNj7Bm5DP8FZ7mQO
         h4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YkOAAVekhipes04yfRYM4Wej+5sf5u/ItiK+Lwg/1U=;
        b=CvPevSsilTkwRAvYq/u/jDOx47leYsy3brVp/p7CxYkx+lGr/uRzipU3c1zcIfoEnu
         pqFZjy1U1JR04zSyrtppJlU2HE0rQv42eA244BbZ9+WMh96KkbfTEyNjcVmPnaW/I8vE
         CYrLbBpNLfqsNzW4QDYLESpFNtznRaJ5AcjPTmvUtq9jZtT+NXM95cLth6X+W3Hp27N8
         rQhDbq2kdNYKX4fQpHrXoeeDD9MyirM14TS/Op2mePxbm0gwvm3GcQtQnuX4Rx8if2cZ
         HuIHiFBnTt4zxS54gx2sCuyk4KobcVYUhHFToongJyoxImoBbGm/Fn24oRJKYBqjFuT0
         b52w==
X-Gm-Message-State: ACrzQf12QQcNHEJHdEGAey9SeWVL1PXBUOAVJ3jc+Nw6BZcStDuFaUTu
        5qGSgWddd9F8U5b3honTcSfwL2hvlFE+wg==
X-Google-Smtp-Source: AMsMyM5jzgrDKRAvb2jhepov6bKjHv9wSzmY7o9nP9K5WsT7Vkj9X01baJe6TWEFCyevgcksPi/02A==
X-Received: by 2002:adf:e583:0:b0:236:6280:57c9 with SMTP id l3-20020adfe583000000b00236628057c9mr14872986wrm.262.1666798603728;
        Wed, 26 Oct 2022 08:36:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1-20020a0560001b8100b002366f300e57sm5581884wru.23.2022.10.26.08.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:36:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/10] config API: add and use "lookup_value" functions
Date:   Wed, 26 Oct 2022 17:35:20 +0200
Message-Id: <patch-07.10-c01f7d85c94-20221026T151328Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change various users of the config API who only wanted to ask if a
configuration key existed to use a new *_config*_lookup_value() family
of functions. Unlike the existing API functions in the API this one
doesn't take a "dest" argument.

Some of these were using either git_config_get_string() or
git_config_get_string_tmp(), see fe4c750fb13 (submodule--helper: fix a
configure_added_submodule() leak, 2022-09-01) for a recent example. We
can now use a helper function that doesn't require a throwaway
variable.

We could have changed git_configset_get_value_multi() to accept a
"NULL" as a "dest" for all callers, but let's avoid changing the
behavior of existing API users. The new "lookup" API and the older API
call our static "git_configset_get_value_multi_1()" helper with a new
"read_only" argument instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c                |  5 +----
 builtin/submodule--helper.c |  9 +++------
 builtin/worktree.c          |  3 +--
 config.c                    | 25 +++++++++++++++++++++----
 config.h                    | 12 ++++++++++++
 5 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index f435eda2e73..3e94fa5e20f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1465,7 +1465,6 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 	};
 	int found = 0;
 	const char *key = "maintenance.repo";
-	char *config_value;
 	char *maintpath = get_maintpath();
 	const struct string_list *list;
 
@@ -1479,9 +1478,7 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 	git_config_set("maintenance.auto", "false");
 
 	/* Set maintenance strategy, if unset */
-	if (!git_config_get_string("maintenance.strategy", &config_value))
-		free(config_value);
-	else
+	if (git_config_lookup_value("maintenance.strategy"))
 		git_config_set("maintenance.strategy", "incremental");
 
 	if (!git_config_get_knownkey_value_multi(key, &list))
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1f8fe6a8e0d..b758255f816 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -541,7 +541,6 @@ static int module_init(int argc, const char **argv, const char *prefix)
 		NULL
 	};
 	int ret = 1;
-	const struct string_list *values;
 
 	argc = parse_options(argc, argv, prefix, module_init_options,
 			     git_submodule_helper_usage, 0);
@@ -553,7 +552,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	 * If there are no path args and submodule.active is set then,
 	 * by default, only initialize 'active' modules.
 	 */
-	if (!argc && !git_config_get_value_multi("submodule.active", &values))
+	if (!argc && !git_config_lookup_value("submodule.active"))
 		module_list_active(&list);
 
 	info.prefix = prefix;
@@ -2709,7 +2708,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	if (opt.init) {
 		struct module_list list = MODULE_LIST_INIT;
 		struct init_cb info = INIT_CB_INIT;
-		const struct string_list *values;
 
 		if (module_list_compute(argc, argv, opt.prefix,
 					&pathspec2, &list) < 0) {
@@ -2722,7 +2720,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		 * If there are no path args and submodule.active is set then,
 		 * by default, only initialize 'active' modules.
 		 */
-		if (!argc && !git_config_get_value_multi("submodule.active", &values))
+		if (!argc && !git_config_lookup_value("submodule.active"))
 			module_list_active(&list);
 
 		info.prefix = opt.prefix;
@@ -3166,7 +3164,6 @@ static int config_submodule_in_gitmodules(const char *name, const char *var, con
 static void configure_added_submodule(struct add_data *add_data)
 {
 	char *key;
-	const char *val;
 	struct child_process add_submod = CHILD_PROCESS_INIT;
 	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
 
@@ -3211,7 +3208,7 @@ static void configure_added_submodule(struct add_data *add_data)
 	 * is_submodule_active(), since that function needs to find
 	 * out the value of "submodule.active" again anyway.
 	 */
-	if (!git_config_get_string_tmp("submodule.active", &val)) {
+	if (!git_config_lookup_value("submodule.active")) {
 		/*
 		 * If the submodule being added isn't already covered by the
 		 * current configured pathspec, set the submodule's active flag
diff --git a/builtin/worktree.c b/builtin/worktree.c
index c6710b25520..5ab16631dbc 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -260,7 +260,6 @@ static void copy_filtered_worktree_config(const char *worktree_git_dir)
 
 	if (file_exists(from_file)) {
 		struct config_set cs = { { 0 } };
-		const char *core_worktree;
 		int bare;
 
 		if (safe_create_leading_directories(to_file) ||
@@ -279,7 +278,7 @@ static void copy_filtered_worktree_config(const char *worktree_git_dir)
 				to_file, "core.bare", NULL, "true", 0))
 			error(_("failed to unset '%s' in '%s'"),
 				"core.bare", to_file);
-		if (!git_configset_get_value(&cs, "core.worktree", &core_worktree) &&
+		if (!git_configset_lookup_value(&cs, "core.worktree") &&
 			git_config_set_in_file_gently(to_file,
 							"core.worktree", NULL))
 			error(_("failed to unset '%s' in '%s'"),
diff --git a/config.c b/config.c
index 2100b29b689..5cd130ddbb9 100644
--- a/config.c
+++ b/config.c
@@ -2428,7 +2428,7 @@ int git_configset_get_value(struct config_set *cs, const char *key, const char *
 
 static int git_configset_get_value_multi_1(struct config_set *cs, const char *key,
 					   const struct string_list **dest,
-					   int knownkey)
+					   int read_only, int knownkey)
 {
 	struct config_set_element *e;
 	int ret;
@@ -2440,7 +2440,8 @@ static int git_configset_get_value_multi_1(struct config_set *cs, const char *ke
 		return ret;
 	else if (!e)
 		return 1;
-	*dest = &e->value_list;
+	if (!read_only)
+		*dest = &e->value_list;
 
 	return 0;
 }
@@ -2448,14 +2449,19 @@ static int git_configset_get_value_multi_1(struct config_set *cs, const char *ke
 int git_configset_get_value_multi(struct config_set *cs, const char *key,
 				  const struct string_list **dest)
 {
-	return git_configset_get_value_multi_1(cs, key, dest, 0);
+	return git_configset_get_value_multi_1(cs, key, dest, 0, 0);
 }
 
 int git_configset_get_knownkey_value_multi(struct config_set *cs,
 					   const char *const key,
 					   const struct string_list **dest)
 {
-	return git_configset_get_value_multi_1(cs, key, dest, 1);
+	return git_configset_get_value_multi_1(cs, key, dest, 0, 1);
+}
+
+int git_configset_lookup_value(struct config_set *cs, const char *key)
+{
+	return git_configset_get_value_multi_1(cs, key, NULL, 1, 0);
 }
 
 int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
@@ -2594,6 +2600,12 @@ void repo_config(struct repository *repo, config_fn_t fn, void *data)
 	configset_iter(repo->config, fn, data);
 }
 
+int repo_config_lookup_value(struct repository *repo, const char *key)
+{
+	git_config_check_init(repo);
+	return git_configset_get_value_multi_1(repo->config, key, NULL, 1, 0);
+}
+
 int repo_config_get_value(struct repository *repo,
 			  const char *key, const char **value)
 {
@@ -2726,6 +2738,11 @@ void git_config_clear(void)
 	repo_config_clear(the_repository);
 }
 
+int git_config_lookup_value(const char *key)
+{
+	return repo_config_lookup_value(the_repository, key);
+}
+
 int git_config_get_value(const char *key, const char **value)
 {
 	return repo_config_get_value(the_repository, key, value);
diff --git a/config.h b/config.h
index a5710c5856e..cf1ae7862a8 100644
--- a/config.h
+++ b/config.h
@@ -502,6 +502,8 @@ void git_configset_clear(struct config_set *cs);
  * is owned by the cache.
  */
 int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
+RESULT_MUST_BE_USED
+int git_configset_lookup_value(struct config_set *cs, const char *key);
 
 int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
 int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
@@ -524,6 +526,8 @@ RESULT_MUST_BE_USED
 int repo_config_get_knownkey_value_multi(struct repository *repo,
 					 const char *const key,
 					 const struct string_list **dest);
+RESULT_MUST_BE_USED
+int repo_config_lookup_value(struct repository *repo, const char *key);
 int repo_config_get_string(struct repository *repo,
 			   const char *key, char **dest);
 int repo_config_get_string_tmp(struct repository *repo,
@@ -588,6 +592,14 @@ RESULT_MUST_BE_USED
 int git_config_get_knownkey_value_multi(const char *const key,
 					const struct string_list **dest);
 
+/**
+ * The same as git_config_value(), except without the extra work to
+ * return the value to the user, used to check if a value for a key
+ * exists.
+ */
+RESULT_MUST_BE_USED
+int git_config_lookup_value(const char *key);
+
 /**
  * Resets and invalidates the config cache.
  */
-- 
2.38.0.1251.g3eefdfb5e7a


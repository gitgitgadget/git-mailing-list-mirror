Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26169C4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 09:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiKYJy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 04:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiKYJyc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 04:54:32 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8E245EE8
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:51:55 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s5so5976949wru.1
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=virdkYmWkaQxITvhC8RRnAeoSCEsQ00hmb2CglYu56M=;
        b=eV29twYhhSoeAj7YT02s2fWzO1qq+SGv8JXFhJ4aOAqwVX1a+zYymY22qPZ5O9lTWd
         /e63HwQ4kV6lrRFaEbPo1QjKGm2DLxnZqtkuJvZQGjEe7FMboxt4/PUVgdufiJmGPn2s
         ZOpdnAqFl8lTaYPqhIfH6ACl6ypU9bvVNbcPANiKemC/k9fD7gJlJ5GjwZ2mheHnVZDD
         1w4by8IDTAhAMgo4pD1/8gJDAfunbNw251oYZBLQw1BZLnBRtjdlk5VVAAfonC0mDGm3
         6Mv5cVnI/KGX+37tmGrkjw/wFUDQFDATNu9bUOJE4LDnzW5Etrk/CPyB9dTm8Z2njP3P
         yXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=virdkYmWkaQxITvhC8RRnAeoSCEsQ00hmb2CglYu56M=;
        b=odxg1B8UEz/cXYablmVDoJ7Ts0ZoSxAlhnyr4wze2146EeOgjBAYOI8fNqwifve7l+
         YFg8jBUzGWoSYx8hZ1L5CwV/OpI0vNJ0eLbN6u2paj5mLJOuiLDBThsVYaGVpTwqloXF
         6Eg4CvmdfKjY3YtPCYCpSXbVIcJnIF0T0xQZ2Blc5ypNG+KGaKCx+kLwnX2ITdew0sdG
         VLjhjy4G5QZqmZCSnntVbrld9x+B+a5qRxKNYNQFsfbtHlGsbu0EynPk8DGiCb1OQFap
         UJY4BO/0+6vvuHyG3yfI3f//LTuHShSR+fIyd+Tx6V3aQKg+2pBbLh26wk7IoYpLKxVG
         i0UA==
X-Gm-Message-State: ANoB5pl3MUmZGOTggktXmHH2dAscUyJKQ+pevYl7BCrz4pHRMKEfAV51
        xlSgp6ixrLVe9TBXPkji6yqJxeTL1MtSIxY6
X-Google-Smtp-Source: AA0mqf6m2hI4OysQWSKVh5CKAww/P4sPZTnIUNvu5eFrw6e5u5KT5Bs80w203u9KZTzn4DE5dV7zNQ==
X-Received: by 2002:a05:6000:1370:b0:22c:dd26:3c0 with SMTP id q16-20020a056000137000b0022cdd2603c0mr23414940wrz.18.1669369886345;
        Fri, 25 Nov 2022 01:51:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6-20020adfe546000000b0023655e51c33sm3420975wrm.4.2022.11.25.01.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 01:51:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/9] config API: have *_multi() return an "int" and take a "dest"
Date:   Fri, 25 Nov 2022 10:50:06 +0100
Message-Id: <patch-v3-5.9-e0e6ade3f38-20221125T093159Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.955.ge9b241be664
In-Reply-To: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have the "git_configset_get_value_multi()" function and its siblings
return an "int" and populate a "**dest" parameter like every other
git_configset_get_*()" in the API.

As we'll see in in subsequent commits this fixes a blind spot in the
API where it wasn't possible to tell whether a list was empty from
whether a config key existed. We'll take advantage of that in
subsequent commits, but for now we're faithfully converting existing
API callers.

See [1] for the initial addition of "git_configset_get_value_multi()"

1. 3c8687a73ee (add `config_set` API for caching config-like files,
   2014-07-28).

A logical follow-up to this would be to change the various "*_get_*()"
functions to ferry the git_configset_get_value() return value to their
own callers, e.g. git_configset_get_int() returns "1" rather than
ferrying up the "-1" that "git_configset_get_value()" might return,
but that's not being done in this series

Most of this is straightforward, commentary on cases that stand out:

- As we've tested for in a preceding commit we can rely on getting the
  config list in git_die_config(), and as we need to handle the new
  return value let's BUG() out if we can't acquire it.

- In "builtin/for-each-ref.c" we could preserve the comment added in
  6c62f015520, but now that we're directly using the documented
  repo_config_get_value_multi() value it's just narrating something that
  should be obvious from the API use, so let's drop it.

- The loops after getting the "list" value in "builtin/gc.c" could
  also make use of "unsorted_string_list_has_string()" instead of using
  that loop, but let's leave that for now.

- We have code e.g. in "builtin/submodule--helper.c" that only wants
  to check if a config key exists, and would be better served with
  another API, but let's keep using "git_configset_get_value_multi()"
  for now.

- In "versioncmp.c" we now use the return value of the functions,
  instead of checking if the lists are still non-NULL. This is strictly
  speaking unnecessary, but makes the API use consistent with the rest,
  but more importantly...

- ...because we always check our return values we can assert that with
  the RESULT_MUST_BE_USED macro added in 1e8697b5c4e (submodule--helper:
  check repo{_submodule,}_init() return values, 2022-09-01)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/for-each-repo.c     | 13 ++++-----
 builtin/gc.c                | 10 +++----
 builtin/log.c               |  6 ++--
 builtin/submodule--helper.c |  7 +++--
 config.c                    | 55 ++++++++++++++++++++++++++-----------
 config.h                    | 29 +++++++++++++------
 pack-bitmap.c               |  6 +++-
 submodule.c                 |  3 +-
 t/helper/test-config.c      |  6 ++--
 versioncmp.c                | 11 +++++---
 10 files changed, 92 insertions(+), 54 deletions(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 6aeac371488..7cc41847635 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -32,6 +32,7 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	static const char *config_key = NULL;
 	int i, result = 0;
 	const struct string_list *values;
+	int err;
 
 	const struct option options[] = {
 		OPT_STRING(0, "config", &config_key, N_("config"),
@@ -45,14 +46,10 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	if (!config_key)
 		die(_("missing --config=<config>"));
 
-	values = repo_config_get_value_multi(the_repository,
-					     config_key);
-
-	/*
-	 * Do nothing on an empty list, which is equivalent to the case
-	 * where the config variable does not exist at all.
-	 */
-	if (!values)
+	err = repo_config_get_value_multi(the_repository, config_key, &values);
+	if (err < 0)
+		return 0;
+	else if (err)
 		return 0;
 
 	for (i = 0; !result && i < values->nr; i++)
diff --git a/builtin/gc.c b/builtin/gc.c
index 02455fdcd73..69503e0a023 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1513,8 +1513,7 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 	else
 		git_config_set("maintenance.strategy", "incremental");
 
-	list = git_config_get_value_multi(key);
-	if (list) {
+	if (!git_config_get_value_multi(key, &list)) {
 		for_each_string_list_item(item, list) {
 			if (!strcmp(maintpath, item->string)) {
 				found = 1;
@@ -1580,11 +1579,10 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 	if (config_file) {
 		git_configset_init(&cs);
 		git_configset_add_file(&cs, config_file);
-		list = git_configset_get_value_multi(&cs, key);
-	} else {
-		list = git_config_get_value_multi(key);
 	}
-	if (list) {
+	if (!(config_file
+	      ? git_configset_get_value_multi(&cs, key, &list)
+	      : git_config_get_value_multi(key, &list))) {
 		for_each_string_list_item(item, list) {
 			if (!strcmp(maintpath, item->string)) {
 				found = 1;
diff --git a/builtin/log.c b/builtin/log.c
index 5eafcf26b49..cc9d92f95da 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -182,10 +182,10 @@ static void set_default_decoration_filter(struct decoration_filter *decoration_f
 	int i;
 	char *value = NULL;
 	struct string_list *include = decoration_filter->include_ref_pattern;
-	const struct string_list *config_exclude =
-			git_config_get_value_multi("log.excludeDecoration");
+	const struct string_list *config_exclude;
 
-	if (config_exclude) {
+	if (!git_config_get_value_multi("log.excludeDecoration",
+					&config_exclude)) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, config_exclude)
 			string_list_append(decoration_filter->exclude_ref_config_pattern,
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c75e9e86b06..08c12b25375 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -541,6 +541,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 		NULL
 	};
 	int ret = 1;
+	const struct string_list *values;
 
 	argc = parse_options(argc, argv, prefix, module_init_options,
 			     git_submodule_helper_usage, 0);
@@ -552,7 +553,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	 * If there are no path args and submodule.active is set then,
 	 * by default, only initialize 'active' modules.
 	 */
-	if (!argc && git_config_get_value_multi("submodule.active"))
+	if (!argc && !git_config_get_value_multi("submodule.active", &values))
 		module_list_active(&list);
 
 	info.prefix = prefix;
@@ -2714,6 +2715,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	if (opt.init) {
 		struct module_list list = MODULE_LIST_INIT;
 		struct init_cb info = INIT_CB_INIT;
+		const struct string_list *values;
 
 		if (module_list_compute(argv, opt.prefix,
 					&pathspec2, &list) < 0) {
@@ -2726,7 +2728,8 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		 * If there are no path args and submodule.active is set then,
 		 * by default, only initialize 'active' modules.
 		 */
-		if (!argc && git_config_get_value_multi("submodule.active"))
+		if (!argc && !git_config_get_value_multi("submodule.active",
+							 &values))
 			module_list_active(&list);
 
 		info.prefix = opt.prefix;
diff --git a/config.c b/config.c
index c058b2c70c3..0b07045ed8c 100644
--- a/config.c
+++ b/config.c
@@ -2275,23 +2275,28 @@ void read_very_early_config(config_fn_t cb, void *data)
 	config_with_options(cb, data, NULL, &opts);
 }
 
-static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
+static int configset_find_element(struct config_set *cs, const char *key,
+				  struct config_set_element **dest)
 {
 	struct config_set_element k;
 	struct config_set_element *found_entry;
 	char *normalized_key;
+	int ret;
+
 	/*
 	 * `key` may come from the user, so normalize it before using it
 	 * for querying entries from the hashmap.
 	 */
-	if (git_config_parse_key(key, &normalized_key, NULL))
-		return NULL;
+	ret = git_config_parse_key(key, &normalized_key, NULL);
+	if (ret < 0)
+		return ret;
 
 	hashmap_entry_init(&k.ent, strhash(normalized_key));
 	k.key = normalized_key;
 	found_entry = hashmap_get_entry(&cs->config_hash, &k, ent, NULL);
 	free(normalized_key);
-	return found_entry;
+	*dest = found_entry;
+	return 0;
 }
 
 static int configset_add_value(struct config_set *cs, const char *key, const char *value)
@@ -2300,8 +2305,11 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 	struct string_list_item *si;
 	struct configset_list_item *l_item;
 	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
+	int ret;
 
-	e = configset_find_element(cs, key);
+	ret = configset_find_element(cs, key, &e);
+	if (ret < 0)
+		return ret;
 	/*
 	 * Since the keys are being fed by git_config*() callback mechanism, they
 	 * are already normalized. So simply add them without any further munging.
@@ -2395,24 +2403,38 @@ int git_configset_add_file(struct config_set *cs, const char *filename)
 int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
 {
 	const struct string_list *values = NULL;
+	int ret;
+
 	/*
 	 * Follows "last one wins" semantic, i.e., if there are multiple matches for the
 	 * queried key in the files of the configset, the value returned will be the last
 	 * value in the value list for that key.
 	 */
-	values = git_configset_get_value_multi(cs, key);
+	ret = git_configset_get_value_multi(cs, key, &values);
 
-	if (!values)
+	if (ret < 0)
+		return ret;
+	else if (!values)
 		return 1;
 	assert(values->nr > 0);
 	*value = values->items[values->nr - 1].string;
 	return 0;
 }
 
-const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
+int git_configset_get_value_multi(struct config_set *cs, const char *key,
+				  const struct string_list **dest)
 {
-	struct config_set_element *e = configset_find_element(cs, key);
-	return e ? &e->value_list : NULL;
+	struct config_set_element *e;
+	int ret;
+
+	ret = configset_find_element(cs, key, &e);
+	if (ret < 0)
+		return ret;
+	else if (!e)
+		return 1;
+	*dest = &e->value_list;
+
+	return 0;
 }
 
 int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
@@ -2558,11 +2580,11 @@ int repo_config_get_value(struct repository *repo,
 	return git_configset_get_value(repo->config, key, value);
 }
 
-const struct string_list *repo_config_get_value_multi(struct repository *repo,
-						      const char *key)
+int repo_config_get_value_multi(struct repository *repo, const char *key,
+				const struct string_list **dest)
 {
 	git_config_check_init(repo);
-	return git_configset_get_value_multi(repo->config, key);
+	return git_configset_get_value_multi(repo->config, key, dest);
 }
 
 int repo_config_get_string(struct repository *repo,
@@ -2670,9 +2692,9 @@ int git_config_get_value(const char *key, const char **value)
 	return repo_config_get_value(the_repository, key, value);
 }
 
-const struct string_list *git_config_get_value_multi(const char *key)
+int git_config_get_value_multi(const char *key, const struct string_list **dest)
 {
-	return repo_config_get_value_multi(the_repository, key);
+	return repo_config_get_value_multi(the_repository, key, dest);
 }
 
 int git_config_get_string(const char *key, char **dest)
@@ -2819,7 +2841,8 @@ void git_die_config(const char *key, const char *err, ...)
 		error_fn(err, params);
 		va_end(params);
 	}
-	values = git_config_get_value_multi(key);
+	if (git_config_get_value_multi(key, &values))
+		BUG("for key '%s' we must have a value to report on", key);
 	kv_info = values->items[values->nr - 1].util;
 	git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
 }
diff --git a/config.h b/config.h
index ef9eade6414..7f6ce6f2fb5 100644
--- a/config.h
+++ b/config.h
@@ -459,10 +459,18 @@ int git_configset_add_parameters(struct config_set *cs);
 /**
  * Finds and returns the value list, sorted in order of increasing priority
  * for the configuration variable `key` and config set `cs`. When the
- * configuration variable `key` is not found, returns NULL. The caller
- * should not free or modify the returned pointer, as it is owned by the cache.
+ * configuration variable `key` is not found, returns 1 without touching
+ * `value`.
+ *
+ * The key will be parsed for validity with git_config_parse_key(), on
+ * error a negative value will be returned.
+ *
+ * The caller should not free or modify the returned pointer, as it is
+ * owned by the cache.
  */
-const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
+RESULT_MUST_BE_USED
+int git_configset_get_value_multi(struct config_set *cs, const char *key,
+				  const struct string_list **dest);
 
 /**
  * Clears `config_set` structure, removes all saved variable-value pairs.
@@ -496,8 +504,9 @@ struct repository;
 void repo_config(struct repository *repo, config_fn_t fn, void *data);
 int repo_config_get_value(struct repository *repo,
 			  const char *key, const char **value);
-const struct string_list *repo_config_get_value_multi(struct repository *repo,
-						      const char *key);
+RESULT_MUST_BE_USED
+int repo_config_get_value_multi(struct repository *repo, const char *key,
+				const struct string_list **dest);
 int repo_config_get_string(struct repository *repo,
 			   const char *key, char **dest);
 int repo_config_get_string_tmp(struct repository *repo,
@@ -544,10 +553,14 @@ int git_config_get_value(const char *key, const char **value);
 /**
  * Finds and returns the value list, sorted in order of increasing priority
  * for the configuration variable `key`. When the configuration variable
- * `key` is not found, returns NULL. The caller should not free or modify
- * the returned pointer, as it is owned by the cache.
+ * `key` is not found, returns 1 without touching `value`.
+ *
+ * The caller should not free or modify the returned pointer, as it is
+ * owned by the cache.
  */
-const struct string_list *git_config_get_value_multi(const char *key);
+RESULT_MUST_BE_USED
+int git_config_get_value_multi(const char *key,
+			       const struct string_list **dest);
 
 /**
  * Resets and invalidates the config cache.
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 440407f1be7..81f0c0e016b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2301,7 +2301,11 @@ int bitmap_is_midx(struct bitmap_index *bitmap_git)
 
 const struct string_list *bitmap_preferred_tips(struct repository *r)
 {
-	return repo_config_get_value_multi(r, "pack.preferbitmaptips");
+	const struct string_list *dest;
+
+	if (!repo_config_get_value_multi(r, "pack.preferbitmaptips", &dest))
+		return dest;
+	return NULL;
 }
 
 int bitmap_is_preferred_refname(struct repository *r, const char *refname)
diff --git a/submodule.c b/submodule.c
index 8ac2fca855d..e43c4230ba3 100644
--- a/submodule.c
+++ b/submodule.c
@@ -274,8 +274,7 @@ int is_tree_submodule_active(struct repository *repo,
 	free(key);
 
 	/* submodule.active is set */
-	sl = repo_config_get_value_multi(repo, "submodule.active");
-	if (sl) {
+	if (!repo_config_get_value_multi(repo, "submodule.active", &sl)) {
 		struct pathspec ps;
 		struct strvec args = STRVEC_INIT;
 		const struct string_list_item *item;
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 4ba9eb65606..8f70beb6c9d 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -95,8 +95,7 @@ int cmd__config(int argc, const char **argv)
 			goto exit1;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
-		strptr = git_config_get_value_multi(argv[2]);
-		if (strptr) {
+		if (!git_config_get_value_multi(argv[2], &strptr)) {
 			for (i = 0; i < strptr->nr; i++) {
 				v = strptr->items[i].string;
 				if (!v)
@@ -159,8 +158,7 @@ int cmd__config(int argc, const char **argv)
 				goto exit2;
 			}
 		}
-		strptr = git_configset_get_value_multi(&cs, argv[2]);
-		if (strptr) {
+		if (!git_configset_get_value_multi(&cs, argv[2], &strptr)) {
 			for (i = 0; i < strptr->nr; i++) {
 				v = strptr->items[i].string;
 				if (!v)
diff --git a/versioncmp.c b/versioncmp.c
index 323f5d35ea8..60c3a517122 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -162,13 +162,16 @@ int versioncmp(const char *s1, const char *s2)
 	if (!initialized) {
 		const char *const newk = "versionsort.suffix";
 		const char *const oldk = "versionsort.prereleasesuffix";
+		const struct string_list *newl;
 		const struct string_list *oldl;
+		int new = git_config_get_value_multi(newk, &newl);
+		int old = git_config_get_value_multi(oldk, &oldl);
 
-		prereleases = git_config_get_value_multi(newk);
-		oldl = git_config_get_value_multi(oldk);
-		if (prereleases && oldl)
+		if (!new && !old)
 			warning("ignoring %s because %s is set", oldk, newk);
-		else if (!prereleases)
+		if (!new)
+			prereleases = newl;
+		else if (!old)
 			prereleases = oldl;
 
 		initialized = 1;
-- 
2.39.0.rc0.955.ge9b241be664


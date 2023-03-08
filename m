Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A706C6FD1F
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 09:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjCHJIV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 04:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjCHJIE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 04:08:04 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F5FB3295
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 01:07:27 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l25so14645569wrb.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 01:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678266443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auVZI/PFWr2hfsF3kAwrJYMzsfDjJzN0fkJNVnDKTpM=;
        b=W1iJeBfXbRp80Faa9P83bxJ0xaSLpLL5Ev/svYNrSRJKjuJns5n0ul3RrGkZKW+lcB
         N1cg9AVhLD9AkJrZjy2qWDA3EfLiW3guRfX2raCyLN19eh1TeA139G8zA0eHvj2d21WT
         Kp2znh9DcAYKH4K9nlQa+LffjT/mQa4y7bNEuVYekW+Ur0bseYZ0ZOTw1FFY8wzs2Q4B
         YswNEOtTy6vGWQ04g6JIOHuVRH02R8ryKX4BHlxpOgKhOk/x3AuCqcOune4Mo4j0cS63
         fKflO/DqntbvEsfHZcBULYB6aA22zU3WhfbTkz5VZXNLZzt62CGDYIsFachQaSA8hIuB
         IW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auVZI/PFWr2hfsF3kAwrJYMzsfDjJzN0fkJNVnDKTpM=;
        b=Wmd4jlJSf8KEYbTkU0rHs/OOpNbaRL87E6vihbE+cdxRDwCueyYrbFS8FPN928Dr32
         Zk2kt3PMjVv0liHgwD4mCMc2F2GYJj6Jhz65f8bptNTSgvtGAa1ZSNJor3CoVxtWVE7X
         mIj9v3hAfP3RNBcxJoojPBfm8flmHwiufhURIX6GkZe4Du1hqnOQJDTYUU7J8S3Wp8wu
         9r4YWm/4ux2oSEE6it3h1+/OSCjQEB8poh+02UA9vEFJ00Y47zltN245FLI1hg/+tN3s
         25VkAZletl2MzfTiKBzBXjRI9BgZ3EtjVuqr+I4ED9xyLKApAn4TK6/AXAt7TKpEP0OD
         IlBg==
X-Gm-Message-State: AO0yUKVlOFT872GTFQPMe0gRJ6GXrDnQqh44TtlL9ZfuYax2RhOvonpY
        Oi9wa0eBZUyl7iNcQhSbDzFOhCDyj1rGJA==
X-Google-Smtp-Source: AK7set8Mwe9pF/Wmb9wRNwAx0+i9PpS/r3r9b8kUIMwbxEip3e+Q62pCCjgLi7z5qCvYH1RQLnq9qQ==
X-Received: by 2002:a05:6000:1d2:b0:2c5:48ed:d258 with SMTP id t18-20020a05600001d200b002c548edd258mr10841464wrx.35.1678266443505;
        Wed, 08 Mar 2023 01:07:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s17-20020adfea91000000b002c6e8cb612fsm14435156wrm.92.2023.03.08.01.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:07:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 5/9] config API: have *_multi() return an "int" and take a "dest"
Date:   Wed,  8 Mar 2023 10:06:47 +0100
Message-Id: <patch-v7-5.9-dced12a40d2-20230308T090513Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
References: <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com> <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have the "git_configset_get_value_multi()" function and its siblings
return an "int" and populate a "**dest" parameter like every other
git_configset_get_*()" in the API.

As we'll take advantage of in subsequent commits, this fixes a blind
spot in the API where it wasn't possible to tell whether a list was
empty from whether a config key existed. For now we don't make use of
those new return values, but faithfully convert existing API users.

Most of this is straightforward, commentary on cases that stand out:

- To ensure that we'll properly use the return values of this function
  in the future we're using the "RESULT_MUST_BE_USED" macro introduced
  in [1].

  As git_die_config() now has to handle this return value let's have
  it BUG() if it can't find the config entry. As tested for in a
  preceding commit we can rely on getting the config list in
  git_die_config().

- The loops after getting the "list" value in "builtin/gc.c" could
  also make use of "unsorted_string_list_has_string()" instead of using
  that loop, but let's leave that for now.

- In "versioncmp.c" we now use the return value of the functions,
  instead of checking if the lists are still non-NULL.

1. 1e8697b5c4e (submodule--helper: check repo{_submodule,}_init()
   return values, 2022-09-01),

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/for-each-repo.c |  5 +----
 builtin/gc.c            | 10 ++++------
 builtin/log.c           |  6 +++---
 config.c                | 34 ++++++++++++++++++++--------------
 config.h                | 29 +++++++++++++++++++++--------
 pack-bitmap.c           |  6 +++++-
 submodule.c             |  3 +--
 t/helper/test-config.c  |  6 ++----
 versioncmp.c            | 11 +++++++----
 9 files changed, 64 insertions(+), 46 deletions(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 6aeac371488..fd0e7739e6a 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -45,14 +45,11 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	if (!config_key)
 		die(_("missing --config=<config>"));
 
-	values = repo_config_get_value_multi(the_repository,
-					     config_key);
-
 	/*
 	 * Do nothing on an empty list, which is equivalent to the case
 	 * where the config variable does not exist at all.
 	 */
-	if (!values)
+	if (repo_config_get_value_multi(the_repository, config_key, &values))
 		return 0;
 
 	for (i = 0; !result && i < values->nr; i++)
diff --git a/builtin/gc.c b/builtin/gc.c
index e38d1783f30..2b3da377d52 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1510,8 +1510,7 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 	if (git_config_get("maintenance.strategy"))
 		git_config_set("maintenance.strategy", "incremental");
 
-	list = git_config_get_value_multi(key);
-	if (list) {
+	if (!git_config_get_value_multi(key, &list)) {
 		for_each_string_list_item(item, list) {
 			if (!strcmp(maintpath, item->string)) {
 				found = 1;
@@ -1577,11 +1576,10 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
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
index a70fba198f9..e43f6f9d8c1 100644
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
diff --git a/config.c b/config.c
index d4f0e4fd619..569819b4a1b 100644
--- a/config.c
+++ b/config.c
@@ -2418,29 +2418,34 @@ int git_configset_add_file(struct config_set *cs, const char *filename)
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
+	if ((ret = git_configset_get_value_multi(cs, key, &values)))
+		return ret;
 
-	if (!values)
-		return 1;
 	assert(values->nr > 0);
 	*value = values->items[values->nr - 1].string;
 	return 0;
 }
 
-const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
+int git_configset_get_value_multi(struct config_set *cs, const char *key,
+				  const struct string_list **dest)
 {
 	struct config_set_element *e;
+	int ret;
 
-	if (configset_find_element(cs, key, &e))
-		return NULL;
+	if ((ret = configset_find_element(cs, key, &e)))
+		return ret;
 	else if (!e)
-		return NULL;
-	return &e->value_list;
+		return 1;
+	*dest = &e->value_list;
+
+	return 0;
 }
 
 int git_configset_get(struct config_set *cs, const char *key)
@@ -2604,11 +2609,11 @@ int repo_config_get_value(struct repository *repo,
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
@@ -2721,9 +2726,9 @@ int git_config_get_value(const char *key, const char **value)
 	return repo_config_get_value(the_repository, key, value);
 }
 
-const struct string_list *git_config_get_value_multi(const char *key)
+int git_config_get_value_multi(const char *key, const struct string_list **dest)
 {
-	return repo_config_get_value_multi(the_repository, key);
+	return repo_config_get_value_multi(the_repository, key, dest);
 }
 
 int git_config_get_string(const char *key, char **dest)
@@ -2870,7 +2875,8 @@ void git_die_config(const char *key, const char *err, ...)
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
index 7dd62ca81bf..4db6b90ac20 100644
--- a/config.h
+++ b/config.h
@@ -450,10 +450,18 @@ int git_configset_add_file(struct config_set *cs, const char *filename);
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
@@ -498,8 +506,9 @@ RESULT_MUST_BE_USED
 int repo_config_get(struct repository *repo, const char *key);
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
@@ -553,10 +562,14 @@ int git_config_get_value(const char *key, const char **value);
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
index d2a42abf28c..15c5eb507c0 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2314,7 +2314,11 @@ int bitmap_is_midx(struct bitmap_index *bitmap_git)
 
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
index 3a0dfc417c0..4b6f5223b0c 100644
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
index cbb33ae1fff..6dc4c37444f 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -97,8 +97,7 @@ int cmd__config(int argc, const char **argv)
 			goto exit1;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
-		strptr = git_config_get_value_multi(argv[2]);
-		if (strptr) {
+		if (!git_config_get_value_multi(argv[2], &strptr)) {
 			for (i = 0; i < strptr->nr; i++) {
 				v = strptr->items[i].string;
 				if (!v)
@@ -181,8 +180,7 @@ int cmd__config(int argc, const char **argv)
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
2.40.0.rc1.1034.g5867a1b10c5


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CC3C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjC1OGh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjC1OGV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 10:06:21 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5BD977F
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:04:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so7518514wms.2
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680012281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeIqCCu9FZo6In2P/ZtaoSAtYgjuEnmbO7UP4EcZLiU=;
        b=VJZatzh3HC3BTWyU4zgNbxZFDAJN9ButzaeO+/TUnPl6f10J9yOyAx0/oe6QBk/w0M
         Qb6YTCaW1d6ygRThAwlSwvq5O9SLUcmR12U36ayafavCZlEcytM5RhDFBsGTsD/1jrvK
         NwTNNF2Yb+VpkbZuyjLYQUw832uInlI1smW3zlmdzAWt8IpmV5er8TIyM8d3u7AXtizw
         G2DtcyDoJjzgzmXI4ByeUxETyJLbBTu8mfz20raOTTnOGAG0wl3XOrAXa/lR00Q3czsw
         EMlLYbNRFB5EQn3JPPTzKU/O7Y/R5RYWGlZOnXhp+M5CSzM150t0kFEXX90kHww7JwpD
         K/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeIqCCu9FZo6In2P/ZtaoSAtYgjuEnmbO7UP4EcZLiU=;
        b=4MUoS50+exKBSc8CldpLmEEKWvYOeLUfjC5SqD2zqy/3IbyXGizoi4A4nApMGT0R1f
         SVEgHEwLyUG5RsJHN8scIXE5WTETnlLOmfA1eu/t2hABuP/QJrBfnXl7rCsF9U29WUw1
         jTWknXTy1a0hvxwoaAksvcvDnBrSZsk4NatXVIfQpTeW9Oux+Wv3L1r+8w22R8j0w03L
         uIQykQVyjbfKDLZpjGqtn7isr7wh0TqJSVSPNfxNYkopyTxdGnX8BqXf2OzaErj+WPm4
         OW84Cag69UgjNLugrtaI2eUvgS1mv0rx/lpHZL9wps+AWTwymtKeuJRwqij95OtHRpE0
         S3GA==
X-Gm-Message-State: AO0yUKWHmdzRWGPEjn5FVN+mMVWmZAfJIEgOJmbed+o9z9um62+BlH7q
        GzJtULKCdiqkN0YV0tu3F1xJ8kovTLlpSg==
X-Google-Smtp-Source: AK7set/O5lIn3Mv3MdWQfmwxrplSR9oKnPmo9DhTcX9QIsh+JRC0ewIuw2EjIi0+QSiu6Sh1GVsUSg==
X-Received: by 2002:a7b:ce87:0:b0:3ed:2eb5:c2e8 with SMTP id q7-20020a7bce87000000b003ed2eb5c2e8mr11558726wmj.10.1680012281233;
        Tue, 28 Mar 2023 07:04:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c3b8a00b003ede3f5c81fsm12903622wms.41.2023.03.28.07.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:04:40 -0700 (PDT)
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
Subject: [PATCH v8 5/9] config API: have *_multi() return an "int" and take a "dest"
Date:   Tue, 28 Mar 2023 16:04:24 +0200
Message-Id: <patch-v8-5.9-840fb9d5c74-20230328T140127Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v8-0.9-00000000000-20230328T140126Z-avarab@gmail.com>
References: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com> <cover-v8-0.9-00000000000-20230328T140126Z-avarab@gmail.com>
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
index b7251840e20..b87fb53a215 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1511,8 +1511,7 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 	if (git_config_get("maintenance.strategy"))
 		git_config_set("maintenance.strategy", "incremental");
 
-	list = git_config_get_value_multi(key);
-	if (list) {
+	if (!git_config_get_value_multi(key, &list)) {
 		for_each_string_list_item(item, list) {
 			if (!strcmp(maintpath, item->string)) {
 				found = 1;
@@ -1578,11 +1577,10 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
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
index 4693385e8ed..4e04efa5a72 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -185,10 +185,10 @@ static void set_default_decoration_filter(struct decoration_filter *decoration_f
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
index ba2ec3b54ee..e8ea4533f94 100644
--- a/config.c
+++ b/config.c
@@ -2421,29 +2421,34 @@ int git_configset_add_file(struct config_set *cs, const char *filename)
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
@@ -2607,11 +2612,11 @@ int repo_config_get_value(struct repository *repo,
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
@@ -2724,9 +2729,9 @@ int git_config_get_value(const char *key, const char **value)
 	return repo_config_get_value(the_repository, key, value);
 }
 
-const struct string_list *git_config_get_value_multi(const char *key)
+int git_config_get_value_multi(const char *key, const struct string_list **dest)
 {
-	return repo_config_get_value_multi(the_repository, key);
+	return repo_config_get_value_multi(the_repository, key, dest);
 }
 
 int git_config_get_string(const char *key, char **dest)
@@ -2873,7 +2878,8 @@ void git_die_config(const char *key, const char *err, ...)
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
index 72d83e21e3d..109c845663d 100644
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
@@ -502,8 +510,9 @@ RESULT_MUST_BE_USED
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
@@ -557,10 +566,14 @@ int git_config_get_value(const char *key, const char **value);
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
index ca7c81b5c9f..4c1e6fed631 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2318,7 +2318,11 @@ int bitmap_is_midx(struct bitmap_index *bitmap_git)
 
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
index 2a057c35b74..85b1ccbf784 100644
--- a/submodule.c
+++ b/submodule.c
@@ -275,8 +275,7 @@ int is_tree_submodule_active(struct repository *repo,
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


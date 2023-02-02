Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A0FC05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 13:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjBBN2P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 08:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjBBN2J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 08:28:09 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5D38F510
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 05:27:36 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so3713514wmb.4
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 05:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDq5pvU7qd9iE1C7DXXGheajDGhhjIcxWATy/a/uV9s=;
        b=EEzd4Mt58DW/Fh+mNC+RG0WKaY3XRyqTRfKgghQT8g9FTN54j8nMOOtZ6MLbkVjPW+
         r85Qu0fq/a3qzmyjZa9swck6fI1v8zXHAXsPhtRz9XWIXtzA0WrhkOYlB3EEY7WLufff
         W/9A31hRXp873yfLb0GIgYdR+PhbtB8dbpeGXlg7k4x3MgHuYce5zBpPTxiDOupgT0nS
         TrjaFtBs+L2BE338wJtu+TJD8nyzBWxe7lTz1CE2hGV9N2RddOgRwuDQ0RtwEeljrOOQ
         99RYzbl31QJURNP1jDURb7MFLgVcpKP5WTNhexStfFodl8RixZYJlwb863wU6OYgsUWN
         n0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDq5pvU7qd9iE1C7DXXGheajDGhhjIcxWATy/a/uV9s=;
        b=pjfCw+8DwrnCZqfOs2Z879cN7s3wah/fKxPn29uzUN7Ac+5XJqxqgLfWsEdFfSBXrP
         5RPkkajMXYBceW7SWO5PAearnGP+U5RN4DmVYwicMdkgDTKd0zH9BY1pCLshKw1LXRS9
         yt0E3/0lRt7y1DVQHxJyvI2UdcPxAOmnFrToha/LygsLiFKW4SfcA5vckZXekJet3fnv
         joV2VPbg3ipWbtX5hu5RhoUb6TTfDVZbiCxVkKq9EX5MFKrE+Bq/XseDspszpCEmeoEo
         /p5zign4rxdXposGgueEskiZ45u4rgaX9N93E7pZk3/81N8fdNcZRkE9OIQDTxK28YZb
         Ij9Q==
X-Gm-Message-State: AO0yUKVU/v33r0RsnWnJLjDxa4Qz+X1AHpDm3TfwV2jU0P0VWztT23v6
        pVeM0sXVxSkEWO28YVNqJdd7lEbaxfwcMtBn
X-Google-Smtp-Source: AK7set/kvHKODQQbYZVRZv6TAiFOUEc5sPSqo+8ZNVUcOPjaQcs0OOJUtwFUGAXfIDuUqLgJO4ZnhQ==
X-Received: by 2002:a7b:c4c9:0:b0:3de:1d31:1042 with SMTP id g9-20020a7bc4c9000000b003de1d311042mr6560497wmk.23.1675344454486;
        Thu, 02 Feb 2023 05:27:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z18-20020a1c4c12000000b003dc48a2f997sm4306052wmf.17.2023.02.02.05.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 05:27:33 -0800 (PST)
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
Subject: [PATCH v4 5/9] config API: have *_multi() return an "int" and take a "dest"
Date:   Thu,  2 Feb 2023 14:27:17 +0100
Message-Id: <patch-v4-5.9-23449ff2c4e-20230202T131155Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1397.g8c8c074958d
In-Reply-To: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
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

A logical follow-up to this would be to change the various "*_get_*()"
functions to ferry the git_configset_get_value() return value to their
own callers, e.g. git_configset_get_int() returns "1" rather than
ferrying up the "-1" that "git_configset_get_value()" might return,
but that's not being done in this series

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
index 04412dd9c93..cec8cabd21e 100644
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
index b88da70c664..ce5d50a490c 100644
--- a/config.c
+++ b/config.c
@@ -2417,29 +2417,34 @@ int git_configset_add_file(struct config_set *cs, const char *filename)
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
@@ -2603,11 +2608,11 @@ int repo_config_get_value(struct repository *repo,
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
@@ -2720,9 +2725,9 @@ int git_config_get_value(const char *key, const char **value)
 	return repo_config_get_value(the_repository, key, value);
 }
 
-const struct string_list *git_config_get_value_multi(const char *key)
+int git_config_get_value_multi(const char *key, const struct string_list **dest)
 {
-	return repo_config_get_value_multi(the_repository, key);
+	return repo_config_get_value_multi(the_repository, key, dest);
 }
 
 int git_config_get_string(const char *key, char **dest)
@@ -2869,7 +2874,8 @@ void git_die_config(const char *key, const char *err, ...)
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
index 04c5e594015..fbc153cdc96 100644
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
@@ -507,8 +515,9 @@ RESULT_MUST_BE_USED
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
@@ -561,10 +570,14 @@ int git_config_get_value(const char *key, const char **value);
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
2.39.1.1397.g8c8c074958d


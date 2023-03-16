Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29FCC61DA4
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 00:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjCPAPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 20:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjCPAPp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 20:15:45 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE5278C8F
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 17:15:35 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id q30-20020a17090a17a100b0023d376ac2c5so1654377pja.5
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 17:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678925734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fjCUIeTc//lX2dKKqYKzjsai4cvVOyX7smHc0TWcWNU=;
        b=Y/KOZ2gQMzbatqplC1Bm5tVUgxrU9q4gKKUTHpQyhj2GEgTJhyoCw9SrtDi4EQ90HB
         ngCcty3JAEG5EQpe6maP/nw+FmTE2E0UW924wt6S8wmszRZq1D1wP7czZVJ63KLmgMeM
         hnXo4QDhJuVu6+NQuwV3saMaR209VnTLX2qrpB/zfg4WTUp2JvKk90Kp7fmX2rugcKVV
         ZbIqNPC5ENlOhHbZ5kxIHbtj724fbdHXvcZy+uH6dVOpRBqSJraBP8bLBiyzL77SGL/n
         L7R4NQkZ9X62hlxBt3gLdtxN7gZA/25/PQwkAWDROPg+/CZqz7c13E7BuzZXalYd5pw9
         OS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678925734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjCUIeTc//lX2dKKqYKzjsai4cvVOyX7smHc0TWcWNU=;
        b=1/weBPkL8W1NsrbsDuZOlm2JEtWd9BAuJxO3MfXvM/fsQsOQktcrPeFStb7pIwZ2Bj
         PXglE7bw/etGP1kmGETgzTr4RAtVjfrGROpOkrycBtvuz35K3ndk9XlTKBI8s3/O1Va4
         YAF4IIa2OTgHb923Upla13UWcHD37EufGAN4IpOu1FxGJlAky09w+E3H/XaO0wqdJ0uG
         5UbQF0w3kHsqYneg1L08t4sGjdFnJIkqgENwABiqXW7bLZ0m0Nmfj8VIp+YgwMJPTChb
         8nm6Log0RcG/2223YmSSRBMpAZsvVkY4lgOqH92OVVofaprQe4RHlVscQU3/+q8pQBbO
         YQNQ==
X-Gm-Message-State: AO0yUKUb06ENuyZzEBxEeMOIUr53DiF7F/H/Ak8Fkp1+E9uqQnn8+Q2s
        mVKJSVUqXqNb+qk+3x2E0ba5iELdKDQd2Q==
X-Google-Smtp-Source: AK7set99oVpiGUBqLA6M1JwnhLVJiTWzNeOIU/WtkBuQr1AVUPAe6C8rrXYvSZnxArkOs4+Rp5ta6IiBxZBlJg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:90a:4f42:b0:23d:54c1:27b0 with SMTP
 id w2-20020a17090a4f4200b0023d54c127b0mr519911pjl.6.1678925734567; Wed, 15
 Mar 2023 17:15:34 -0700 (PDT)
Date:   Wed, 15 Mar 2023 17:15:33 -0700
In-Reply-To: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com> <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
Message-ID: <kl6l3565wnyy.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 0/8] config.c: use struct for config reading state
From:   Glen Choo <chooglen@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> As a result of moving the rename, the range-diff is quite noisy. The diff
> between the final commits is might be helpful instead [2] (I'll also send a
> diff to the ML).

diff --git a/config.c b/config.c
index 19bab84c47..ae171ab11c 100644
--- a/config.c
+++ b/config.c
@@ -81,14 +81,18 @@ struct config_reader {
 	 */
 	enum config_scope parsing_scope;
 };
-/* Only public functions should reference the_reader. */
+/*
+ * Where possible, prefer to accept "struct config_reader" as an arg than to use
+ * "the_reader". "the_reader" should only be used if that is infeasible, e.g. in
+ * a public function.
+ */
 static struct config_reader the_reader;
 
 static inline void config_reader_push_source(struct config_reader *reader,
 					     struct config_source *top)
 {
 	if (reader->config_kvi)
-		BUG("source should only be set when parsing a config source");
+		BUG("source should not be set while iterating a config set");
 	if (reader->source)
 		top->prev = reader->source;
 	reader->source = top;
@@ -108,7 +112,7 @@ static inline void config_reader_set_kvi(struct config_reader *reader,
 					 struct key_value_info *kvi)
 {
 	if (kvi && (reader->source || reader->parsing_scope))
-		BUG("kvi should only be set when iterating through configset");
+		BUG("kvi should not be set while parsing a config source");
 	reader->config_kvi = kvi;
 }
 
@@ -1308,39 +1312,48 @@ int git_parse_ssize_t(const char *value, ssize_t *ret)
 	return 1;
 }
 
+static int reader_config_name(struct config_reader *reader, const char **out);
+static int reader_origin_type(struct config_reader *reader,
+			      enum config_origin_type *type);
 NORETURN
-static void die_bad_number(struct config_source *cs, const char *name,
+static void die_bad_number(struct config_reader *reader, const char *name,
 			   const char *value)
 {
 	const char *error_type = (errno == ERANGE) ?
 		N_("out of range") : N_("invalid unit");
 	const char *bad_numeric = N_("bad numeric config value '%s' for '%s': %s");
+	const char *config_name = NULL;
+	enum config_origin_type config_origin = CONFIG_ORIGIN_UNKNOWN;
 
 	if (!value)
 		value = "";
 
-	if (!(cs && cs->name))
+	/* Ignoring the return value is okay since we handle missing values. */
+	reader_config_name(reader, &config_name);
+	reader_origin_type(reader, &config_origin);
+
+	if (!config_name)
 		die(_(bad_numeric), value, name, _(error_type));
 
-	switch (cs->origin_type) {
+	switch (config_origin) {
 	case CONFIG_ORIGIN_BLOB:
 		die(_("bad numeric config value '%s' for '%s' in blob %s: %s"),
-		    value, name, cs->name, _(error_type));
+		    value, name, config_name, _(error_type));
 	case CONFIG_ORIGIN_FILE:
 		die(_("bad numeric config value '%s' for '%s' in file %s: %s"),
-		    value, name, cs->name, _(error_type));
+		    value, name, config_name, _(error_type));
 	case CONFIG_ORIGIN_STDIN:
 		die(_("bad numeric config value '%s' for '%s' in standard input: %s"),
 		    value, name, _(error_type));
 	case CONFIG_ORIGIN_SUBMODULE_BLOB:
 		die(_("bad numeric config value '%s' for '%s' in submodule-blob %s: %s"),
-		    value, name, cs->name, _(error_type));
+		    value, name, config_name, _(error_type));
 	case CONFIG_ORIGIN_CMDLINE:
 		die(_("bad numeric config value '%s' for '%s' in command line %s: %s"),
-		    value, name, cs->name, _(error_type));
+		    value, name, config_name, _(error_type));
 	default:
 		die(_("bad numeric config value '%s' for '%s' in %s: %s"),
-		    value, name, cs->name, _(error_type));
+		    value, name, config_name, _(error_type));
 	}
 }
 
@@ -1348,7 +1361,7 @@ int git_config_int(const char *name, const char *value)
 {
 	int ret;
 	if (!git_parse_int(value, &ret))
-		die_bad_number(the_reader.source, name, value);
+		die_bad_number(&the_reader, name, value);
 	return ret;
 }
 
@@ -1356,7 +1369,7 @@ int64_t git_config_int64(const char *name, const char *value)
 {
 	int64_t ret;
 	if (!git_parse_int64(value, &ret))
-		die_bad_number(the_reader.source, name, value);
+		die_bad_number(&the_reader, name, value);
 	return ret;
 }
 
@@ -1364,7 +1377,7 @@ unsigned long git_config_ulong(const char *name, const char *value)
 {
 	unsigned long ret;
 	if (!git_parse_ulong(value, &ret))
-		die_bad_number(the_reader.source, name, value);
+		die_bad_number(&the_reader, name, value);
 	return ret;
 }
 
@@ -1372,7 +1385,7 @@ ssize_t git_config_ssize_t(const char *name, const char *value)
 {
 	ssize_t ret;
 	if (!git_parse_ssize_t(value, &ret))
-		die_bad_number(the_reader.source, name, value);
+		die_bad_number(&the_reader, name, value);
 	return ret;
 }
 
@@ -2268,34 +2281,27 @@ int config_with_options(config_fn_t fn, void *data,
 	return ret;
 }
 
-struct configset_iter_data {
-	struct config_reader *config_reader;
-	void *inner;
-};
-#define CONFIGSET_ITER_INIT { 0 }
-
-static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
+static void configset_iter(struct config_reader *reader, struct config_set *set,
+			   config_fn_t fn, void *data)
 {
 	int i, value_index;
 	struct string_list *values;
 	struct config_set_element *entry;
-	struct configset_list *list = &cs->list;
-	struct configset_iter_data *iter_data = data;
+	struct configset_list *list = &set->list;
 
 	for (i = 0; i < list->nr; i++) {
-		struct key_value_info *kvi;
 		entry = list->items[i].e;
 		value_index = list->items[i].value_index;
 		values = &entry->value_list;
 
-		kvi = values->items[value_index].util;
-		config_reader_set_kvi(iter_data->config_reader, kvi);
+		config_reader_set_kvi(reader, values->items[value_index].util);
 
-		if (fn(entry->key, values->items[value_index].string, iter_data->inner) < 0)
-			git_die_config_linenr(entry->key, kvi->filename,
-					      kvi->linenr);
+		if (fn(entry->key, values->items[value_index].string, data) < 0)
+			git_die_config_linenr(entry->key,
+					      reader->config_kvi->filename,
+					      reader->config_kvi->linenr);
 
-		config_reader_set_kvi(iter_data->config_reader, NULL);
+		config_reader_set_kvi(reader, NULL);
 	}
 }
 
@@ -2346,7 +2352,7 @@ void read_very_early_config(config_fn_t cb, void *data)
 	config_with_options(cb, data, NULL, &opts);
 }
 
-static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
+static struct config_set_element *configset_find_element(struct config_set *set, const char *key)
 {
 	struct config_set_element k;
 	struct config_set_element *found_entry;
@@ -2360,13 +2366,13 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
 
 	hashmap_entry_init(&k.ent, strhash(normalized_key));
 	k.key = normalized_key;
-	found_entry = hashmap_get_entry(&cs->config_hash, &k, ent, NULL);
+	found_entry = hashmap_get_entry(&set->config_hash, &k, ent, NULL);
 	free(normalized_key);
 	return found_entry;
 }
 
 static int configset_add_value(struct config_reader *reader,
-			       struct config_set *cs, const char *key,
+			       struct config_set *set, const char *key,
 			       const char *value)
 {
 	struct config_set_element *e;
@@ -2374,7 +2380,7 @@ static int configset_add_value(struct config_reader *reader,
 	struct configset_list_item *l_item;
 	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
 
-	e = configset_find_element(cs, key);
+	e = configset_find_element(set, key);
 	/*
 	 * Since the keys are being fed by git_config*() callback mechanism, they
 	 * are already normalized. So simply add them without any further munging.
@@ -2384,12 +2390,12 @@ static int configset_add_value(struct config_reader *reader,
 		hashmap_entry_init(&e->ent, strhash(key));
 		e->key = xstrdup(key);
 		string_list_init_dup(&e->value_list);
-		hashmap_add(&cs->config_hash, &e->ent);
+		hashmap_add(&set->config_hash, &e->ent);
 	}
 	si = string_list_append_nodup(&e->value_list, xstrdup_or_null(value));
 
-	ALLOC_GROW(cs->list.items, cs->list.nr + 1, cs->list.alloc);
-	l_item = &cs->list.items[cs->list.nr++];
+	ALLOC_GROW(set->list.items, set->list.nr + 1, set->list.alloc);
+	l_item = &set->list.items[set->list.nr++];
 	l_item->e = e;
 	l_item->value_index = e->value_list.nr - 1;
 
@@ -2424,33 +2430,33 @@ static int config_set_element_cmp(const void *cmp_data UNUSED,
 	return strcmp(e1->key, e2->key);
 }
 
-void git_configset_init(struct config_set *cs)
+void git_configset_init(struct config_set *set)
 {
-	hashmap_init(&cs->config_hash, config_set_element_cmp, NULL, 0);
-	cs->hash_initialized = 1;
-	cs->list.nr = 0;
-	cs->list.alloc = 0;
-	cs->list.items = NULL;
+	hashmap_init(&set->config_hash, config_set_element_cmp, NULL, 0);
+	set->hash_initialized = 1;
+	set->list.nr = 0;
+	set->list.alloc = 0;
+	set->list.items = NULL;
 }
 
-void git_configset_clear(struct config_set *cs)
+void git_configset_clear(struct config_set *set)
 {
 	struct config_set_element *entry;
 	struct hashmap_iter iter;
-	if (!cs->hash_initialized)
+	if (!set->hash_initialized)
 		return;
 
-	hashmap_for_each_entry(&cs->config_hash, &iter, entry,
+	hashmap_for_each_entry(&set->config_hash, &iter, entry,
 				ent /* member name */) {
 		free(entry->key);
 		string_list_clear(&entry->value_list, 1);
 	}
-	hashmap_clear_and_free(&cs->config_hash, struct config_set_element, ent);
-	cs->hash_initialized = 0;
-	free(cs->list.items);
-	cs->list.nr = 0;
-	cs->list.alloc = 0;
-	cs->list.items = NULL;
+	hashmap_clear_and_free(&set->config_hash, struct config_set_element, ent);
+	set->hash_initialized = 0;
+	free(set->list.items);
+	set->list.nr = 0;
+	set->list.alloc = 0;
+	set->list.items = NULL;
 }
 
 struct configset_add_data {
@@ -2466,15 +2472,15 @@ static int config_set_callback(const char *key, const char *value, void *cb)
 	return 0;
 }
 
-int git_configset_add_file(struct config_set *cs, const char *filename)
+int git_configset_add_file(struct config_set *set, const char *filename)
 {
 	struct configset_add_data data = CONFIGSET_ADD_INIT;
 	data.config_reader = &the_reader;
-	data.config_set = cs;
+	data.config_set = set;
 	return git_config_from_file(config_set_callback, filename, &data);
 }
 
-int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
+int git_configset_get_value(struct config_set *set, const char *key, const char **value)
 {
 	const struct string_list *values = NULL;
 	/*
@@ -2482,7 +2488,7 @@ int git_configset_get_value(struct config_set *cs, const char *key, const char *
 	 * queried key in the files of the configset, the value returned will be the last
 	 * value in the value list for that key.
 	 */
-	values = git_configset_get_value_multi(cs, key);
+	values = git_configset_get_value_multi(set, key);
 
 	if (!values)
 		return 1;
@@ -2491,26 +2497,26 @@ int git_configset_get_value(struct config_set *cs, const char *key, const char *
 	return 0;
 }
 
-const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
+const struct string_list *git_configset_get_value_multi(struct config_set *set, const char *key)
 {
-	struct config_set_element *e = configset_find_element(cs, key);
+	struct config_set_element *e = configset_find_element(set, key);
 	return e ? &e->value_list : NULL;
 }
 
-int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
+int git_configset_get_string(struct config_set *set, const char *key, char **dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value))
+	if (!git_configset_get_value(set, key, &value))
 		return git_config_string((const char **)dest, key, value);
 	else
 		return 1;
 }
 
-static int git_configset_get_string_tmp(struct config_set *cs, const char *key,
+static int git_configset_get_string_tmp(struct config_set *set, const char *key,
 					const char **dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value)) {
+	if (!git_configset_get_value(set, key, &value)) {
 		if (!value)
 			return config_error_nonbool(key);
 		*dest = value;
@@ -2520,51 +2526,51 @@ static int git_configset_get_string_tmp(struct config_set *cs, const char *key,
 	}
 }
 
-int git_configset_get_int(struct config_set *cs, const char *key, int *dest)
+int git_configset_get_int(struct config_set *set, const char *key, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value)) {
+	if (!git_configset_get_value(set, key, &value)) {
 		*dest = git_config_int(key, value);
 		return 0;
 	} else
 		return 1;
 }
 
-int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest)
+int git_configset_get_ulong(struct config_set *set, const char *key, unsigned long *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value)) {
+	if (!git_configset_get_value(set, key, &value)) {
 		*dest = git_config_ulong(key, value);
 		return 0;
 	} else
 		return 1;
 }
 
-int git_configset_get_bool(struct config_set *cs, const char *key, int *dest)
+int git_configset_get_bool(struct config_set *set, const char *key, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value)) {
+	if (!git_configset_get_value(set, key, &value)) {
 		*dest = git_config_bool(key, value);
 		return 0;
 	} else
 		return 1;
 }
 
-int git_configset_get_bool_or_int(struct config_set *cs, const char *key,
+int git_configset_get_bool_or_int(struct config_set *set, const char *key,
 				int *is_bool, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value)) {
+	if (!git_configset_get_value(set, key, &value)) {
 		*dest = git_config_bool_or_int(key, value, is_bool);
 		return 0;
 	} else
 		return 1;
 }
 
-int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest)
+int git_configset_get_maybe_bool(struct config_set *set, const char *key, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value)) {
+	if (!git_configset_get_value(set, key, &value)) {
 		*dest = git_parse_maybe_bool(value);
 		if (*dest == -1)
 			return -1;
@@ -2573,10 +2579,10 @@ int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *de
 		return 1;
 }
 
-int git_configset_get_pathname(struct config_set *cs, const char *key, const char **dest)
+int git_configset_get_pathname(struct config_set *set, const char *key, const char **dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value))
+	if (!git_configset_get_value(set, key, &value))
 		return git_config_pathname(dest, key, value);
 	else
 		return 1;
@@ -2630,14 +2636,10 @@ static void repo_config_clear(struct repository *repo)
 	git_configset_clear(repo->config);
 }
 
-void repo_config(struct repository *repo, config_fn_t fn, void *data_inner)
+void repo_config(struct repository *repo, config_fn_t fn, void *data)
 {
-	struct configset_iter_data data = CONFIGSET_ITER_INIT;
-	data.inner = data_inner;
-	data.config_reader = &the_reader;
-
 	git_config_check_init(repo);
-	configset_iter(repo->config, fn, &data);
+	configset_iter(&the_reader, repo->config, fn, data);
 }
 
 int repo_config_get_value(struct repository *repo,
@@ -2739,15 +2741,11 @@ static void read_protected_config(void)
 	config_with_options(config_set_callback, &data, NULL, &opts);
 }
 
-void git_protected_config(config_fn_t fn, void *data_inner)
+void git_protected_config(config_fn_t fn, void *data)
 {
-	struct configset_iter_data data = CONFIGSET_ITER_INIT;
 	if (!protected_config.hash_initialized)
 		read_protected_config();
-	data.inner = data_inner;
-	data.config_reader = &the_reader;
-
-	configset_iter(&protected_config, fn, &data);
+	configset_iter(&the_reader, &protected_config, fn, data);
 }
 
 /* Functions used historically to read configuration from 'the_repository' */
@@ -3851,14 +3849,23 @@ int parse_config_key(const char *var,
 	return 0;
 }
 
-const char *current_config_origin_type(void)
+static int reader_origin_type(struct config_reader *reader,
+			      enum config_origin_type *type)
 {
-	int type;
 	if (the_reader.config_kvi)
-		type = the_reader.config_kvi->origin_type;
+		*type = reader->config_kvi->origin_type;
 	else if(the_reader.source)
-		type = the_reader.source->origin_type;
+		*type = reader->source->origin_type;
 	else
+		return 1;
+	return 0;
+}
+
+const char *current_config_origin_type(void)
+{
+	enum config_origin_type type = CONFIG_ORIGIN_UNKNOWN;
+
+	if (reader_origin_type(&the_reader, &type))
 		BUG("current_config_origin_type called outside config callback");
 
 	switch (type) {
@@ -3897,14 +3904,21 @@ const char *config_scope_name(enum config_scope scope)
 	}
 }
 
-const char *current_config_name(void)
+static int reader_config_name(struct config_reader *reader, const char **out)
 {
-	const char *name;
 	if (the_reader.config_kvi)
-		name = the_reader.config_kvi->filename;
+		*out = reader->config_kvi->filename;
 	else if (the_reader.source)
-		name = the_reader.source->name;
+		*out = reader->source->name;
 	else
+		return 1;
+	return 0;
+}
+
+const char *current_config_name(void)
+{
+	const char *name;
+	if (reader_config_name(&the_reader, &name))
 		BUG("current_config_name called outside config callback");
 	return name ? name : "";
 }
diff --git a/config.h b/config.h
index 7606246531..66c8b996e1 100644
--- a/config.h
+++ b/config.h
@@ -56,6 +56,7 @@ struct git_config_source {
 };
 
 enum config_origin_type {
+	CONFIG_ORIGIN_UNKNOWN = 0,
 	CONFIG_ORIGIN_BLOB,
 	CONFIG_ORIGIN_FILE,
 	CONFIG_ORIGIN_STDIN,
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 4ba9eb6560..26e79168f6 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -30,6 +30,9 @@
  * iterate -> iterate over all values using git_config(), and print some
  *            data for each
  *
+ * git_config_int -> iterate over all values using git_config() and print the
+ *                   integer value for the entered key or die
+ *
  * Examples:
  *
  * To print the value with highest priority for key "foo.bAr Baz.rock":
@@ -54,6 +57,17 @@ static int iterate_cb(const char *var, const char *value, void *data UNUSED)
 	return 0;
 }
 
+static int parse_int_cb(const char *var, const char *value, void *data)
+{
+	const char *key_to_match = data;
+
+	if (!strcmp(key_to_match, var)) {
+		int parsed = git_config_int(value, value);
+		printf("%d\n", parsed);
+	}
+	return 0;
+}
+
 static int early_config_cb(const char *var, const char *value, void *vdata)
 {
 	const char *key = vdata;
@@ -176,6 +190,9 @@ int cmd__config(int argc, const char **argv)
 	} else if (!strcmp(argv[1], "iterate")) {
 		git_config(iterate_cb, NULL);
 		goto exit0;
+	} else if (argc == 3 && !strcmp(argv[1], "git_config_int")) {
+		git_config(parse_int_cb, (void *) argv[2]);
+		goto exit0;
 	}
 
 	die("%s: Please check the syntax and the function name", argv[0]);
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index b38e158d3b..9733bed30a 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -120,6 +120,10 @@ test_expect_success 'find integer value for a key' '
 	check_config get_int lamb.chop 65
 '
 
+test_expect_success 'parse integer value during iteration' '
+	check_config git_config_int lamb.chop 65
+'
+
 test_expect_success 'find string value for a key' '
 	check_config get_string case.baz hask &&
 	check_config expect_code 1 get_string case.ba "Value not found for \"case.ba\""
@@ -134,6 +138,11 @@ test_expect_success 'find integer if value is non parse-able' '
 	check_config expect_code 128 get_int lamb.head
 '
 
+test_expect_success 'non parse-able integer value during iteration' '
+	check_config expect_code 128 git_config_int lamb.head 2>result &&
+	grep "fatal: bad numeric config value .* in file \.git/config" result
+'
+
 test_expect_success 'find bool value for the entered key' '
 	check_config get_bool goat.head 1 &&
 	check_config get_bool goat.skin 0 &&

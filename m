Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2671AC05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 13:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjBBN2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 08:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjBBN14 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 08:27:56 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25A98F24E
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 05:27:33 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t7so1710043wrp.5
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 05:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWjSMZz/1eHAlpYGbwX6udlZYAB8VFzKdV79RO01ifg=;
        b=JQypr7NALcHwe+AMD/mvshio4h/326+8+S8MvxgHm6wepjRnElJyNCqPdPTTJcl3+d
         qMRWpJes4AaPoh1ZkTkVJ+FxItNB1RpqDgUC4/+w8kzPU86oaCQfmNC1rI9hGvkG9fdA
         Igf9wiIvINt5J9b3PSVrsISQacW/1JtOu3m0V6hRpAXKkUNi9m7NuGYKuDJxb3i6f9D+
         kxNd6oYH7XjQawia01n07JyqKIwvSSw5imkIxgPOokZ0twNemLoizvxwoZyu2LZuYf2a
         ZwK6QXj2rh7RZSdpBx3lPawwtn/aZ0bSD+k4ipSPbPY5Kmu0Cb+n3XKtqlK7CMmbulLi
         mJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWjSMZz/1eHAlpYGbwX6udlZYAB8VFzKdV79RO01ifg=;
        b=E185ZKmQ6unlbCWnGb3f+fVwt4YujG2dyF9cu7bhJ2HLHxhIg0Vo+yHaJDP2Z21tU4
         KmkeVwB7trqiCd8im7KylnFOZayoFMkCQXndilco2bhkEULVcezESlVtM6nLzYKhnZVd
         j/jmSL1LOL7IQsvZfoL2rapXtb8pleGdzVRsFt/cwlYZ9+CP1yUgU9wYYDD0ch2dwSSk
         7S1ydN6p6qCwm+YjIKmmWON4Uxapp6bdJLFxa25MCw71uocIsjuxk0e4+767vBJYUWHX
         tT0zZrMvhhjVgnyq738FH8lfkASpVvxCk67OQJ+WtBvJgNL2+7lE0OVY+LRpDa1kLrYU
         8GAw==
X-Gm-Message-State: AO0yUKUtenUcg+2s93X3Z94U10dSGNALOhGUfqTC1XGVcjPafE2+e13B
        G/VNG/+fTREqzesR+o7diUC01GWPrsSNaafH
X-Google-Smtp-Source: AK7set/ORy0L0gzFDmuhlMbQUc1zmVWPdQ5pEqnPd1QmDcsH/y+vfzD3W5weAYnGmbWuwykm8ZkVkw==
X-Received: by 2002:a05:6000:15cd:b0:2be:d03:287 with SMTP id y13-20020a05600015cd00b002be0d030287mr7291508wry.44.1675344451791;
        Thu, 02 Feb 2023 05:27:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z18-20020a1c4c12000000b003dc48a2f997sm4306052wmf.17.2023.02.02.05.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 05:27:31 -0800 (PST)
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
Subject: [PATCH v4 3/9] config API: add and use a "git_config_get()" family of functions
Date:   Thu,  2 Feb 2023 14:27:15 +0100
Message-Id: <patch-v4-3.9-998b11ae4bc-20230202T131155Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1397.g8c8c074958d
In-Reply-To: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have the basic "git_config_get_value()" function and its
"repo_*" and "configset" siblings to get a given "key" and assign the
last key found to a provided "value".

But some callers don't care about that value, but just want to use the
return value of the "get_value()" function to check whether the key
exist (or another non-zero return value).

The immediate motivation for this is that a subsequent commit will
need to change all callers of the "*_get_value_multi()" family of
functions. In two cases here we (ab)used it to check whether we had
any values for the given key, but didn't care about the return value.

The rest of the callers here used various other config API functions
to do the same, all of which resolved to the same underlying functions
to provide the answer.

Some of these were using either git_config_get_string() or
git_config_get_string_tmp(), see fe4c750fb13 (submodule--helper: fix a
configure_added_submodule() leak, 2022-09-01) for a recent example. We
can now use a helper function that doesn't require a throwaway
variable.

We could have changed git_configset_get_value_multi() to accept a
"NULL" as a "dest" for all callers, but let's avoid changing the
behavior of existing API users. Having an "unused" value that we throw
away internal to config.c is cheap.

Another name for this function could have been
"*_config_key_exists()", as suggested in [1]. That would work for all
of these callers, and would currently be equivalent to this function,
as the git_configset_get_value() API normalizes all non-zero return
values to a "1".

But adding that API would set us up to lose information, as e.g. if
git_config_parse_key() in the underlying configset_find_element()
fails we'd like to return -1, not 1.

Let's change the underlying configset_find_element() function to
support this use-case, we'll make further use of it in a subsequent
commit where the git_configset_get_value_multi() function itself will
expose this new return value.

1. https://lore.kernel.org/git/xmqqczadkq9f.fsf@gitster.g/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c                |  5 +---
 builtin/submodule--helper.c |  7 +++---
 builtin/worktree.c          |  3 +--
 config.c                    | 50 +++++++++++++++++++++++++++++++------
 config.h                    | 19 +++++++++++++-
 5 files changed, 66 insertions(+), 18 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 02455fdcd73..e38d1783f30 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1493,7 +1493,6 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 	};
 	int found = 0;
 	const char *key = "maintenance.repo";
-	char *config_value;
 	char *maintpath = get_maintpath();
 	struct string_list_item *item;
 	const struct string_list *list;
@@ -1508,9 +1507,7 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 	git_config_set("maintenance.auto", "false");
 
 	/* Set maintenance strategy, if unset */
-	if (!git_config_get_string("maintenance.strategy", &config_value))
-		free(config_value);
-	else
+	if (git_config_get("maintenance.strategy"))
 		git_config_set("maintenance.strategy", "incremental");
 
 	list = git_config_get_value_multi(key);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4c173d8b37a..2278e8c91cb 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -557,7 +557,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	 * If there are no path args and submodule.active is set then,
 	 * by default, only initialize 'active' modules.
 	 */
-	if (!argc && git_config_get_value_multi("submodule.active"))
+	if (!argc && !git_config_get("submodule.active"))
 		module_list_active(&list);
 
 	info.prefix = prefix;
@@ -2743,7 +2743,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		 * If there are no path args and submodule.active is set then,
 		 * by default, only initialize 'active' modules.
 		 */
-		if (!argc && git_config_get_value_multi("submodule.active"))
+		if (!argc && !git_config_get("submodule.active"))
 			module_list_active(&list);
 
 		info.prefix = opt.prefix;
@@ -3140,7 +3140,6 @@ static int config_submodule_in_gitmodules(const char *name, const char *var, con
 static void configure_added_submodule(struct add_data *add_data)
 {
 	char *key;
-	const char *val;
 	struct child_process add_submod = CHILD_PROCESS_INIT;
 	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
 
@@ -3185,7 +3184,7 @@ static void configure_added_submodule(struct add_data *add_data)
 	 * is_submodule_active(), since that function needs to find
 	 * out the value of "submodule.active" again anyway.
 	 */
-	if (!git_config_get_string_tmp("submodule.active", &val)) {
+	if (!git_config_get("submodule.active")) {
 		/*
 		 * If the submodule being added isn't already covered by the
 		 * current configured pathspec, set the submodule's active flag
diff --git a/builtin/worktree.c b/builtin/worktree.c
index f51c40f1e1e..6ba42d4ad20 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -319,7 +319,6 @@ static void copy_filtered_worktree_config(const char *worktree_git_dir)
 
 	if (file_exists(from_file)) {
 		struct config_set cs = { { 0 } };
-		const char *core_worktree;
 		int bare;
 
 		if (safe_create_leading_directories(to_file) ||
@@ -338,7 +337,7 @@ static void copy_filtered_worktree_config(const char *worktree_git_dir)
 				to_file, "core.bare", NULL, "true", 0))
 			error(_("failed to unset '%s' in '%s'"),
 				"core.bare", to_file);
-		if (!git_configset_get_value(&cs, "core.worktree", &core_worktree) &&
+		if (!git_configset_get(&cs, "core.worktree") &&
 			git_config_set_in_file_gently(to_file,
 							"core.worktree", NULL))
 			error(_("failed to unset '%s' in '%s'"),
diff --git a/config.c b/config.c
index 00090a32fc3..b88da70c664 100644
--- a/config.c
+++ b/config.c
@@ -2289,23 +2289,28 @@ void read_very_early_config(config_fn_t cb, void *data)
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
+	if (ret)
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
@@ -2314,8 +2319,11 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 	struct string_list_item *si;
 	struct configset_list_item *l_item;
 	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
+	int ret;
 
-	e = configset_find_element(cs, key);
+	ret = configset_find_element(cs, key, &e);
+	if (ret)
+		return ret;
 	/*
 	 * Since the keys are being fed by git_config*() callback mechanism, they
 	 * are already normalized. So simply add them without any further munging.
@@ -2425,8 +2433,25 @@ int git_configset_get_value(struct config_set *cs, const char *key, const char *
 
 const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
 {
-	struct config_set_element *e = configset_find_element(cs, key);
-	return e ? &e->value_list : NULL;
+	struct config_set_element *e;
+
+	if (configset_find_element(cs, key, &e))
+		return NULL;
+	else if (!e)
+		return NULL;
+	return &e->value_list;
+}
+
+int git_configset_get(struct config_set *cs, const char *key)
+{
+	struct config_set_element *e;
+	int ret;
+
+	if ((ret = configset_find_element(cs, key, &e)))
+		return ret;
+	else if (!e)
+		return 1;
+	return 0;
 }
 
 int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
@@ -2565,6 +2590,12 @@ void repo_config(struct repository *repo, config_fn_t fn, void *data)
 	configset_iter(repo->config, fn, data);
 }
 
+int repo_config_get(struct repository *repo, const char *key)
+{
+	git_config_check_init(repo);
+	return git_configset_get(repo->config, key);
+}
+
 int repo_config_get_value(struct repository *repo,
 			  const char *key, const char **value)
 {
@@ -2679,6 +2710,11 @@ void git_config_clear(void)
 	repo_config_clear(the_repository);
 }
 
+int git_config_get(const char *key)
+{
+	return repo_config_get(the_repository, key);
+}
+
 int git_config_get_value(const char *key, const char **value)
 {
 	return repo_config_get_value(the_repository, key, value);
diff --git a/config.h b/config.h
index ef9eade6414..04c5e594015 100644
--- a/config.h
+++ b/config.h
@@ -471,9 +471,12 @@ void git_configset_clear(struct config_set *cs);
 
 /*
  * These functions return 1 if not found, and 0 if found, leaving the found
- * value in the 'dest' pointer.
+ * value in the 'dest' pointer (if any).
  */
 
+RESULT_MUST_BE_USED
+int git_configset_get(struct config_set *cs, const char *key);
+
 /*
  * Finds the highest-priority value for the configuration variable `key`
  * and config set `cs`, stores the pointer to it in `value` and returns 0.
@@ -494,6 +497,14 @@ int git_configset_get_pathname(struct config_set *cs, const char *key, const cha
 /* Functions for reading a repository's config */
 struct repository;
 void repo_config(struct repository *repo, config_fn_t fn, void *data);
+
+/**
+ * Run only the discover part of the repo_config_get_*() functions
+ * below, in addition to 1 if not found, returns negative values on
+ * error (e.g. if the key itself is invalid).
+ */
+RESULT_MUST_BE_USED
+int repo_config_get(struct repository *repo, const char *key);
 int repo_config_get_value(struct repository *repo,
 			  const char *key, const char **value);
 const struct string_list *repo_config_get_value_multi(struct repository *repo,
@@ -530,8 +541,14 @@ void git_protected_config(config_fn_t fn, void *data);
  * manner, the config API provides two functions `git_config_get_value`
  * and `git_config_get_value_multi`. They both read values from an internal
  * cache generated previously from reading the config files.
+ *
+ * For those git_config_get*() functions that aren't documented,
+ * consult the corresponding repo_config_get*() function's
+ * documentation.
  */
 
+int git_config_get(const char *key);
+
 /**
  * Finds the highest-priority value for the configuration variable `key`,
  * stores the pointer to it in `value` and returns 0. When the
-- 
2.39.1.1397.g8c8c074958d


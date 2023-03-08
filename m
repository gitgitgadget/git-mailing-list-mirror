Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8618AC64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 09:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCHJIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 04:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCHJIB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 04:08:01 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218EEB06D1
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 01:07:25 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l25so14645473wrb.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 01:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678266441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQ66+SeVfagp1eaf2M9GQc8qLBFfg5ISc7IAFov5Tdw=;
        b=HGVnAihRF4S6kmOoEssvQNiLfIj/CjaB8HzF3snpF7fiZj0aKcc81VCHeRenGq8Tus
         XSOvHaBY0TcKFjdgf+qEPaX4sPz242bP7qoRmoEp+wheOjg1BTMHwD406WSpR8McNyyV
         FEFGye7rWfAhPa+NpSNu52ywIZftMCQ4/eGAPOZc1+jMLXMQtKngNg+bxSwCffTIO15Q
         PNa0kIyOuBEJ0KL8kUR0R+f8BMqxrJaVbs6mJ/wX2BKZE6Mspk8v66XYT2XSmAE4TDuX
         Scv1Ynf6kkxb/Lduo0Q1rA4+ncaxg5GRDN6RulmVhjMwcaaLCr2fp6IyGiBMxRqqDx1w
         t2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQ66+SeVfagp1eaf2M9GQc8qLBFfg5ISc7IAFov5Tdw=;
        b=hPkwdCj5NB5UuxEliHoJJ2D44CpLzvLjRU5Pp+4V5IYehFXitOe8EEe4R4oYYmSq+Z
         aq7nHXkubRwhrAmF3OJmQkMMikt9Iyp+yKl527DnnURVJmwZPO7bQmv5xURanIv7j3Ue
         tGoZ5z8cec8SNOaXz4r1psBOUGRyBAY/pWbqR5x7nu4G28xkfrWIKq3P3+K/ByWsu43O
         4vDLUrGUIaunZiNeVpGcRF4HiP+5I8JRkEHEAuEaVSTOvqmKvTFKsqMU3N1S5NDiKdi+
         SutBV/ylQQAFRh+q7vH3ebzPJcdML2i+fe3z4gAkX5suzr1YijIn6pr//ZNe5+jzEjqQ
         +T6Q==
X-Gm-Message-State: AO0yUKUuJQWMjAKcIp98/lPNt/EzkACPcp/ghotgXxMgNuD+tcviBKOF
        WVInEfVliyEg5s4WBW9Iwth4h9JjXV0siw==
X-Google-Smtp-Source: AK7set8Ggwt3p4gF+usbHJwlEoTYJ9tXXfXoS2RkEg3x2/zptFNMkLIT2Vh/a/SXKd5PgUxLQ8FbaA==
X-Received: by 2002:adf:fad1:0:b0:2c6:e7f6:49af with SMTP id a17-20020adffad1000000b002c6e7f649afmr10760423wrs.27.1678266441343;
        Wed, 08 Mar 2023 01:07:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s17-20020adfea91000000b002c6e8cb612fsm14435156wrm.92.2023.03.08.01.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:07:20 -0800 (PST)
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
Subject: [PATCH v7 3/9] config API: add and use a "git_config_get()" family of functions
Date:   Wed,  8 Mar 2023 10:06:45 +0100
Message-Id: <patch-v7-3.9-a977b7b188f-20230308T090513Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
References: <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com> <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
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

We could have changed git_configset_get_value_multi() (and then
git_config_get_value() etc.) to accept a "NULL" as a "dest" for all
callers, but let's avoid changing the behavior of existing API
users. Having an "unused" value that we throw away internal to
config.c is cheap.

A "NULL as optional dest" pattern is also more fragile, as the intent
of the caller might be misinterpreted if he were to accidentally pass
"NULL", e.g. when "dest" is passed in from another function.

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

This still leaves various inconsistencies and clobbering or ignoring
of the return value in place. E.g here we're modifying
configset_add_value(), but ever since it was added in [2] we've been
ignoring its "int" return value, but as we're changing the
configset_find_element() it uses, let's have it faithfully ferry that
"ret" along.

Let's also use the "RESULT_MUST_BE_USED" macro introduced in [3] to
assert that we're checking the return value of
configset_find_element().

We're leaving the same change to configset_add_value() for some future
series. Once we start paying attention to its return value we'd need
to ferry it up as deep as do_config_from(), and would need to make
least read_{,very_}early_config() and git_protected_config() return an
"int" instead of "void". Let's leave that for now, and focus on
the *_get_*() functions.

1. 3c8687a73ee (add `config_set` API for caching config-like files, 2014-07-28)
2. https://lore.kernel.org/git/xmqqczadkq9f.fsf@gitster.g/
3. 1e8697b5c4e (submodule--helper: check repo{_submodule,}_init()
   return values, 2022-09-01),

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c                |  5 +---
 builtin/submodule--helper.c |  7 +++--
 builtin/worktree.c          |  3 +--
 config.c                    | 51 ++++++++++++++++++++++++++++++++-----
 config.h                    | 18 +++++++++++++
 t/helper/test-config.c      | 22 ++++++++++++++++
 t/t1308-config-set.sh       | 43 ++++++++++++++++++++++++++++++-
 7 files changed, 131 insertions(+), 18 deletions(-)

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
index 254283aa6f5..2d81965711f 100644
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
index 00090a32fc3..d4f0e4fd619 100644
--- a/config.c
+++ b/config.c
@@ -2289,23 +2289,29 @@ void read_very_early_config(config_fn_t cb, void *data)
 	config_with_options(cb, data, NULL, &opts);
 }
 
-static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
+RESULT_MUST_BE_USED
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
@@ -2314,8 +2320,11 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
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
@@ -2425,8 +2434,25 @@ int git_configset_get_value(struct config_set *cs, const char *key, const char *
 
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
@@ -2565,6 +2591,12 @@ void repo_config(struct repository *repo, config_fn_t fn, void *data)
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
@@ -2679,6 +2711,11 @@ void git_config_clear(void)
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
index 7606246531a..7dd62ca81bf 100644
--- a/config.h
+++ b/config.h
@@ -465,6 +465,9 @@ void git_configset_clear(struct config_set *cs);
  * value in the 'dest' pointer.
  */
 
+RESULT_MUST_BE_USED
+int git_configset_get(struct config_set *cs, const char *key);
+
 /*
  * Finds the highest-priority value for the configuration variable `key`
  * and config set `cs`, stores the pointer to it in `value` and returns 0.
@@ -485,6 +488,14 @@ int git_configset_get_pathname(struct config_set *cs, const char *key, const cha
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
@@ -521,8 +532,15 @@ void git_protected_config(config_fn_t fn, void *data);
  * manner, the config API provides two functions `git_config_get_value`
  * and `git_config_get_value_multi`. They both read values from an internal
  * cache generated previously from reading the config files.
+ *
+ * For those git_config_get*() functions that aren't documented,
+ * consult the corresponding repo_config_get*() function's
+ * documentation.
  */
 
+RESULT_MUST_BE_USED
+int git_config_get(const char *key);
+
 /**
  * Finds the highest-priority value for the configuration variable `key`,
  * stores the pointer to it in `value` and returns 0. When the
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 4ba9eb65606..cbb33ae1fff 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -14,6 +14,8 @@
  * get_value_multi -> prints all values for the entered key in increasing order
  *		     of priority
  *
+ * get -> print return value for the entered key
+ *
  * get_int -> print integer value for the entered key or die
  *
  * get_bool -> print bool value for the entered key or die
@@ -109,6 +111,26 @@ int cmd__config(int argc, const char **argv)
 			printf("Value not found for \"%s\"\n", argv[2]);
 			goto exit1;
 		}
+	} else if (argc == 3 && !strcmp(argv[1], "get")) {
+		int ret;
+
+		if (!(ret = git_config_get(argv[2])))
+			goto exit0;
+		else if (ret == 1)
+			printf("Value not found for \"%s\"\n", argv[2]);
+		else if (ret == -CONFIG_INVALID_KEY)
+			printf("Key \"%s\" is invalid\n", argv[2]);
+		else if (ret == -CONFIG_NO_SECTION_OR_NAME)
+			printf("Key \"%s\" has no section\n", argv[2]);
+		else
+			/*
+			 * A normal caller should just check "ret <
+			 * 0", but for our own tests let's BUG() if
+			 * our whitelist of git_config_parse_key()
+			 * return values isn't exhaustive.
+			 */
+			BUG("Key \"%s\" has unknown return %d", argv[2], ret);
+		goto exit1;
 	} else if (argc == 3 && !strcmp(argv[1], "get_int")) {
 		if (!git_config_get_int(argv[2], &val)) {
 			printf("%d\n", val);
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 4be1ab1147c..7def7053e1c 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -58,6 +58,8 @@ test_expect_success 'setup default config' '
 		skin = false
 		nose = 1
 		horns
+	[value]
+		less
 	EOF
 '
 
@@ -116,6 +118,45 @@ test_expect_success 'find value with the highest priority' '
 	check_config get_value case.baz "hask"
 '
 
+test_expect_success 'return value for an existing key' '
+	test-tool config get lamb.chop >out 2>err &&
+	test_must_be_empty out &&
+	test_must_be_empty err
+'
+
+test_expect_success 'return value for value-less key' '
+	test-tool config get value.less >out 2>err &&
+	test_must_be_empty out &&
+	test_must_be_empty err
+'
+
+test_expect_success 'return value for a missing key' '
+	cat >expect <<-\EOF &&
+	Value not found for "missing.key"
+	EOF
+	test_expect_code 1 test-tool config get missing.key >actual 2>err &&
+	test_cmp actual expect &&
+	test_must_be_empty err
+'
+
+test_expect_success 'return value for a bad key: CONFIG_INVALID_KEY' '
+	cat >expect <<-\EOF &&
+	Key "fails.iskeychar.-" is invalid
+	EOF
+	test_expect_code 1 test-tool config get fails.iskeychar.- >actual 2>err &&
+	test_cmp actual expect &&
+	test_must_be_empty out
+'
+
+test_expect_success 'return value for a bad key: CONFIG_NO_SECTION_OR_NAME' '
+	cat >expect <<-\EOF &&
+	Key "keynosection" has no section
+	EOF
+	test_expect_code 1 test-tool config get keynosection >actual 2>err &&
+	test_cmp actual expect &&
+	test_must_be_empty out
+'
+
 test_expect_success 'find integer value for a key' '
 	check_config get_int lamb.chop 65
 '
@@ -272,7 +313,7 @@ test_expect_success 'proper error on error in default config files' '
 	cp .git/config .git/config.old &&
 	test_when_finished "mv .git/config.old .git/config" &&
 	echo "[" >>.git/config &&
-	echo "fatal: bad config line 34 in file .git/config" >expect &&
+	echo "fatal: bad config line 36 in file .git/config" >expect &&
 	test_expect_code 128 test-tool config get_value foo.bar 2>actual &&
 	test_cmp expect actual
 '
-- 
2.40.0.rc1.1034.g5867a1b10c5


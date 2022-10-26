Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCC7C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 15:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbiJZPhY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 11:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbiJZPhN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 11:37:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B10132EB7
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:36:49 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bp11so26453547wrb.9
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoYQgBb7Hvs24wGCL0DyTLCeg3CW9CIYsQYGy2GbvNw=;
        b=Vu02bhzVYar/osKXeF/LkFRBUZd6MQAZAFMpMwvRZQhDIP9OH4+Sl7N4VEinWoom+V
         3wVllSuTKOr7Bfegtmksu7FgBUPzwk8OxFR45QNbww0TPVjeXNJGLo4cKUxD8uPE4FeY
         8BGOJXM+ORh5CmTUdnZQ/bJz0AF3RElll7qPXCFhC9F0ETubBWYn0bzUy5bhf5Ljmyq+
         6dw668DktCw+YUmI+iuPHclk1+YxLT8ajqEfIQse12uASgvZSn+3rC4VpsvphF4mc0UG
         2VBGpNRCtDXd5pII7wuPveAxUz7bjp54/hg7BxEnwv6SZBwAfSzBoT+SarSgEb7xropY
         0gLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aoYQgBb7Hvs24wGCL0DyTLCeg3CW9CIYsQYGy2GbvNw=;
        b=w5qCqZSvhVdpQbDFJ+A0eWOv7IYYjfkZC2FwK98oGoO6AsAXGXLS2w+WcV9C0AxRbG
         LTSNdA3d1qcukQyM3i4nxi/GSpCqS/gDg9K/3xQEJsXYuDfpHn8Q++YUEF6vQExsfder
         AN4fregf3zFQDaqS8scobWlL3X15Z/pL7gncRjyQ4cNg9kS5Yc8woQY/IJHaT0GjunFx
         qTrK4+XxgpWZG9/BBfY9dsTzsFzFT+ZR+xAejmu0IvPNEnE8YebIzgaji3sUGq612f42
         Jk3BLrqxAIQj0WITGNQ7RfBgZzEXNO2A7cvgLB9n/m8Lqoit1jgeVNKMD87bEEo3vhwZ
         xa6Q==
X-Gm-Message-State: ACrzQf2mgSNBHVVcnBcDize1T4Fbsld/wgWu/IfshjTC8VdHfOaanewg
        WZXPSHgldXnsfybUbSEXzaGETJojtESYKA==
X-Google-Smtp-Source: AMsMyM5LcDzU1bbD2U4XEvC/J0xOtZF1wPgasEl9vpAzLfZzQhTLjjOoI2D3GZNjTuWOQ9IkNG+g1A==
X-Received: by 2002:a05:6000:184d:b0:22f:4ef4:47a7 with SMTP id c13-20020a056000184d00b0022f4ef447a7mr29230436wri.563.1666798607944;
        Wed, 26 Oct 2022 08:36:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1-20020a0560001b8100b002366f300e57sm5581884wru.23.2022.10.26.08.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:36:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/10] config API: add "string" version of *_value_multi(), fix segfaults
Date:   Wed, 26 Oct 2022 17:35:22 +0200
Message-Id: <patch-09.10-bda9d504b89-20221026T151328Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix numerous and mostly long-standing segfaults in consumers of
the *_config_*value_multi() API. As discussed in the preceding commit
an empty key in the config syntax yields a "NULL" string, which these
users would give to strcmp() (or similar), resulting in segfaults.

As this change shows, these non-test users of
the *_config_*value_multi() API didn't really want such an an unsafe
and low-level API, let's give them something with the safety of
git_config_get_string() instead.

This fix is similar to what the *_string() functions and others
acquired in[1] and [2]. Namely introducing and using a
safer *_config_*value_multi_string() variant of the
low-level *_config_*value_multi_string() function.

This fixes segfaults in code introduced in:

  - d811c8e17c6 (versionsort: support reorder prerelease suffixes, 2015-02-26)
  - c026557a373 (versioncmp: generalize version sort suffix reordering, 2016-12-08)
  - a086f921a72 (submodule: decouple url and submodule interest, 2017-03-17)
  - a6be5e6764a (log: add log.excludeDecoration config option, 2020-04-16)
  - 92156291ca8 (log: add default decoration filter, 2022-08-05)
  - 50a044f1e40 (gc: replace config subprocesses with API calls, 2022-09-27)

There are now two remaining user of the low-level API, one is the
"t/helper/test-config.c" code added in [3]. The other we'll address in
a subsequent commit.

As seen in the preceding commit we need to give the
"t/helper/test-config.c" caller these "NULL" entries. We thus cannot
alter the underlying git_configset_get_value_multi_1() function itself
to make it "safe".

Such a thing would also be undesirable, as casting or forbidding NULL
values might only be one potential use-case of the underlying
function. It's better to have a "raw" low-level function, and
corresponding wrapper functions that coerce its values. The callback
pattern being used here will make it easy to introduce e.g. a "multi"
variant which coerces its values to "bool", "int", "path" etc.

1. 40ea4ed9032 (Add config_error_nonbool() helper function,
   2008-02-11)
2. 6c47d0e8f39 (config.c: guard config parser from value=NULL,
   2008-02-11).
3. 4c715ebb96a (test-config: add tests for the config_set API,
   2014-07-28)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c                   |  4 +--
 builtin/log.c                  |  2 +-
 config.c                       | 63 +++++++++++++++++++++++++++++++---
 config.h                       | 40 +++++++++++++++++++++
 pack-bitmap.c                  |  2 +-
 submodule.c                    |  2 +-
 t/t4202-log.sh                 | 15 ++++++++
 t/t5310-pack-bitmaps.sh        | 21 ++++++++++++
 t/t7004-tag.sh                 | 17 +++++++++
 t/t7413-submodule-is-active.sh | 16 +++++++++
 t/t7900-maintenance.sh         | 38 ++++++++++++++++++++
 versioncmp.c                   |  8 ++---
 12 files changed, 214 insertions(+), 14 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 3e94fa5e20f..3fc759b1f0c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1481,7 +1481,7 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 	if (git_config_lookup_value("maintenance.strategy"))
 		git_config_set("maintenance.strategy", "incremental");
 
-	if (!git_config_get_knownkey_value_multi(key, &list))
+	if (!git_config_get_knownkey_value_multi_string(key, &list))
 		found = unsorted_string_list_has_string(list, maintpath);
 
 	if (!found) {
@@ -1530,7 +1530,7 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		usage_with_options(builtin_maintenance_unregister_usage,
 				   options);
 
-	if (!git_config_get_knownkey_value_multi(key, &list))
+	if (!git_config_get_knownkey_value_multi_string(key, &list))
 		found = unsorted_string_list_has_string(list, maintpath);
 
 	if (found) {
diff --git a/builtin/log.c b/builtin/log.c
index 75464c96ccf..d6b1c75ea2e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -184,7 +184,7 @@ static void set_default_decoration_filter(struct decoration_filter *decoration_f
 	struct string_list *include = decoration_filter->include_ref_pattern;
 	const struct string_list *config_exclude;
 
-	if (!git_config_get_knownkey_value_multi("log.excludeDecoration",
+	if (!git_config_get_knownkey_value_multi_string("log.excludeDecoration",
 					      &config_exclude)) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, config_exclude)
diff --git a/config.c b/config.c
index 5cd130ddbb9..25bb6514f81 100644
--- a/config.c
+++ b/config.c
@@ -2428,7 +2428,8 @@ int git_configset_get_value(struct config_set *cs, const char *key, const char *
 
 static int git_configset_get_value_multi_1(struct config_set *cs, const char *key,
 					   const struct string_list **dest,
-					   int read_only, int knownkey)
+					   int read_only, int knownkey,
+					   string_list_each_func_t check_fn)
 {
 	struct config_set_element *e;
 	int ret;
@@ -2440,28 +2441,51 @@ static int git_configset_get_value_multi_1(struct config_set *cs, const char *ke
 		return ret;
 	else if (!e)
 		return 1;
+	if (check_fn &&
+	    (ret = for_each_string_list(&e->value_list, check_fn, (void *)key)))
+		return ret;
 	if (!read_only)
 		*dest = &e->value_list;
 
 	return 0;
 }
 
+static int check_multi_string(struct string_list_item *item, void *util)
+{
+	return item->string ? 0 : config_error_nonbool(util);
+}
+
 int git_configset_get_value_multi(struct config_set *cs, const char *key,
 				  const struct string_list **dest)
 {
-	return git_configset_get_value_multi_1(cs, key, dest, 0, 0);
+	return git_configset_get_value_multi_1(cs, key, dest, 0, 0, NULL);
 }
 
 int git_configset_get_knownkey_value_multi(struct config_set *cs,
 					   const char *const key,
 					   const struct string_list **dest)
 {
-	return git_configset_get_value_multi_1(cs, key, dest, 0, 1);
+	return git_configset_get_value_multi_1(cs, key, dest, 0, 1, NULL);
+}
+
+int git_configset_get_value_multi_string(struct config_set *cs, const char *key,
+					 const struct string_list **dest)
+{
+	return git_configset_get_value_multi_1(cs, key, dest, 0, 0,
+					       check_multi_string);
+}
+
+int git_configset_get_knownkey_value_multi_string(struct config_set *cs,
+						  const char *const key,
+						  const struct string_list **dest)
+{
+	return git_configset_get_value_multi_1(cs, key, dest, 0, 1,
+					       check_multi_string);
 }
 
 int git_configset_lookup_value(struct config_set *cs, const char *key)
 {
-	return git_configset_get_value_multi_1(cs, key, NULL, 1, 0);
+	return git_configset_get_value_multi_1(cs, key, NULL, 1, 0, NULL);
 }
 
 int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
@@ -2603,7 +2627,8 @@ void repo_config(struct repository *repo, config_fn_t fn, void *data)
 int repo_config_lookup_value(struct repository *repo, const char *key)
 {
 	git_config_check_init(repo);
-	return git_configset_get_value_multi_1(repo->config, key, NULL, 1, 0);
+	return git_configset_get_value_multi_1(repo->config, key, NULL, 1, 0,
+					       NULL);
 }
 
 int repo_config_get_value(struct repository *repo,
@@ -2629,6 +2654,22 @@ int repo_config_get_knownkey_value_multi(struct repository *repo,
 	return git_configset_get_knownkey_value_multi(repo->config, key, dest);
 }
 
+int repo_config_get_value_multi_string(struct repository *repo,
+				       const char *key,
+				       const struct string_list **dest)
+{
+	git_config_check_init(repo);
+	return git_configset_get_value_multi_string(repo->config, key, dest);
+}
+
+int repo_config_get_knownkey_value_multi_string(struct repository *repo,
+						const char *key,
+						const struct string_list **dest)
+{
+	git_config_check_init(repo);
+	return git_configset_get_knownkey_value_multi_string(repo->config, key, dest);
+}
+
 int repo_config_get_string(struct repository *repo,
 			   const char *key, char **dest)
 {
@@ -2759,6 +2800,18 @@ int git_config_get_knownkey_value_multi(const char *const key,
 	return repo_config_get_knownkey_value_multi(the_repository, key, dest);
 }
 
+int git_config_get_value_multi_string(const char *key,
+				      const struct string_list **dest)
+{
+	return repo_config_get_value_multi_string(the_repository, key, dest);
+}
+
+int git_config_get_knownkey_value_multi_string(const char *key,
+					       const struct string_list **dest)
+{
+	return repo_config_get_knownkey_value_multi_string(the_repository, key, dest);
+}
+
 int git_config_get_string(const char *key, char **dest)
 {
 	return repo_config_get_string(the_repository, key, dest);
diff --git a/config.h b/config.h
index cf1ae7862a8..047ef83afc6 100644
--- a/config.h
+++ b/config.h
@@ -484,6 +484,30 @@ int git_configset_get_knownkey_value_multi(struct config_set *cs,
 					   const char *const key,
 					   const struct string_list **dest);
 
+/**
+ * A validation wrapper for git_configset_get_value_multi() which does
+ * for it what git_configset_get_string() does for
+ * git_configset_get_value().
+ *
+ * The configuration syntax allows for "[section] key", which will
+ * give us a NULL entry in the "struct string_list", as opposed to
+ * "[section] key =" which is the empty string. Most users of the API
+ * are not prepared to handle NULL in a "struct string_list".
+ */
+int git_configset_get_value_multi_string(struct config_set *cs, const char *key,
+					 const struct string_list **dest);
+
+/**
+ * A wrapper for git_configset_get_value_multi_string() which does for
+ * it what git_configset_get_knownkey_value_multi() does for
+ * git_configset_get_value_multi().
+ */
+RESULT_MUST_BE_USED
+int git_configset_get_knownkey_value_multi_string(struct config_set *cs,
+						  const char *const key,
+						  const struct string_list **dest);
+
+
 /**
  * Clears `config_set` structure, removes all saved variable-value pairs.
  */
@@ -527,6 +551,14 @@ int repo_config_get_knownkey_value_multi(struct repository *repo,
 					 const char *const key,
 					 const struct string_list **dest);
 RESULT_MUST_BE_USED
+int repo_config_get_value_multi_string(struct repository *repo,
+				       const char *key,
+				       const struct string_list **dest);
+RESULT_MUST_BE_USED
+int repo_config_get_knownkey_value_multi_string(struct repository *repo,
+						const char *const key,
+						const struct string_list **dest);
+RESULT_MUST_BE_USED
 int repo_config_lookup_value(struct repository *repo, const char *key);
 int repo_config_get_string(struct repository *repo,
 			   const char *key, char **dest);
@@ -592,6 +624,14 @@ RESULT_MUST_BE_USED
 int git_config_get_knownkey_value_multi(const char *const key,
 					const struct string_list **dest);
 
+RESULT_MUST_BE_USED
+int git_config_get_value_multi_string(const char *key,
+				      const struct string_list **dest);
+
+RESULT_MUST_BE_USED
+int git_config_get_knownkey_value_multi_string(const char *const key,
+					       const struct string_list **dest);
+
 /**
  * The same as git_config_value(), except without the extra work to
  * return the value to the user, used to check if a value for a key
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 0b4e73abbfa..9a61d9ff9a8 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2303,7 +2303,7 @@ const struct string_list *bitmap_preferred_tips(struct repository *r)
 {
 	const struct string_list *dest;
 
-	if (!repo_config_get_knownkey_value_multi(r, "pack.preferbitmaptips",
+	if (!repo_config_get_knownkey_value_multi_string(r, "pack.preferbitmaptips",
 					       &dest))
 		return dest;
 	return NULL;
diff --git a/submodule.c b/submodule.c
index e8c4362743d..f84b253154e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -274,7 +274,7 @@ int is_tree_submodule_active(struct repository *repo,
 	free(key);
 
 	/* submodule.active is set */
-	if (!repo_config_get_knownkey_value_multi(repo, "submodule.active", &sl)) {
+	if (!repo_config_get_knownkey_value_multi_string(repo, "submodule.active", &sl)) {
 		struct pathspec ps;
 		struct strvec args = STRVEC_INIT;
 		const struct string_list_item *item;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 2ce2b41174d..ae73aef922f 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -835,6 +835,21 @@ test_expect_success 'log.decorate configuration' '
 
 '
 
+test_expect_success 'parse log.excludeDecoration with no value' '
+	cp .git/config .git/config.orig &&
+	test_when_finished mv .git/config.orig .git/config &&
+
+	cat >>.git/config <<-\EOF &&
+	[log]
+		excludeDecoration
+	EOF
+	cat >expect <<-\EOF &&
+	error: missing value for '\''log.excludeDecoration'\''
+	EOF
+	git log --decorate=short 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'decorate-refs with glob' '
 	cat >expect.decorate <<-\EOF &&
 	Merge-tag-reach
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 6d693eef82f..68195a1de36 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -404,6 +404,27 @@ test_bitmap_cases () {
 		)
 	'
 
+	test_expect_success 'pack.preferBitmapTips' '
+		git init repo &&
+		test_when_finished "rm -rf repo" &&
+		(
+			cd repo &&
+			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
+			test_commit_bulk --message="%s" 103 &&
+
+			cat >>.git/config <<-\EOF &&
+			[pack]
+				preferBitmapTips
+			EOF
+
+			cat >expect <<-\EOF &&
+			error: missing value for '\''pack.preferbitmaptips'\''
+			EOF
+			git repack -adb 2>actual &&
+			test_cmp expect actual
+		)
+	'
+
 	test_expect_success 'complains about multiple pack bitmaps' '
 		rm -fr repo &&
 		git init repo &&
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 9aa1660651b..f4a31ada79a 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1843,6 +1843,23 @@ test_expect_success 'invalid sort parameter in configuratoin' '
 	test_must_fail git tag -l "foo*"
 '
 
+test_expect_success 'version sort handles empty value for versionsort.{prereleaseSuffix,suffix}' '
+	cp .git/config .git/config.orig &&
+	test_when_finished mv .git/config.orig .git/config &&
+
+	cat >>.git/config <<-\EOF &&
+	[versionsort]
+		prereleaseSuffix
+		suffix
+	EOF
+	cat >expect <<-\EOF &&
+	error: missing value for '\''versionsort.suffix'\''
+	error: missing value for '\''versionsort.prereleasesuffix'\''
+	EOF
+	git tag -l --sort=version:refname 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'version sort with prerelease reordering' '
 	test_config versionsort.prereleaseSuffix -rc &&
 	git tag foo1.6-rc1 &&
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index 7cdc2637649..887d181b72e 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -51,6 +51,22 @@ test_expect_success 'is-active works with submodule.<name>.active config' '
 	test-tool -C super submodule is-active sub1
 '
 
+test_expect_success 'is-active handles submodule.active config missing a value' '
+	cp super/.git/config super/.git/config.orig &&
+	test_when_finished mv super/.git/config.orig super/.git/config &&
+
+	cat >>super/.git/config <<-\EOF &&
+	[submodule]
+		active
+	EOF
+
+	cat >expect <<-\EOF &&
+	error: missing value for '\''submodule.active'\''
+	EOF
+	test-tool -C super submodule is-active sub1 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'is-active works with basic submodule.active config' '
 	test_when_finished "git -C super config submodule.sub1.URL ../sub" &&
 	test_when_finished "git -C super config --unset-all submodule.active" &&
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 96bdd420456..1201866c8d0 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -505,6 +505,44 @@ test_expect_success 'register and unregister' '
 	git maintenance unregister --force
 '
 
+test_expect_success 'register with no value for maintenance.repo' '
+	cp .git/config .git/config.orig &&
+	test_when_finished mv .git/config.orig .git/config &&
+
+	cat >>.git/config <<-\EOF &&
+	[maintenance]
+		repo
+	EOF
+	cat >expect <<-\EOF &&
+	error: missing value for '\''maintenance.repo'\''
+	EOF
+	git maintenance register 2>actual &&
+	test_cmp expect actual &&
+	git config maintenance.repo
+'
+
+test_expect_success 'unregister with no value for maintenance.repo' '
+	cp .git/config .git/config.orig &&
+	test_when_finished mv .git/config.orig .git/config &&
+
+	cat >>.git/config <<-\EOF &&
+	[maintenance]
+		repo
+	EOF
+	cat >expect <<-\EOF &&
+	error: missing value for '\''maintenance.repo'\''
+	EOF
+	test_expect_code 128 git maintenance unregister 2>actual.raw &&
+	grep ^error actual.raw >actual &&
+	test_cmp expect actual &&
+	git config maintenance.repo &&
+
+	git maintenance unregister --force 2>actual.raw &&
+	grep ^error actual.raw >actual &&
+	test_cmp expect actual &&
+	git config maintenance.repo
+'
+
 test_expect_success !MINGW 'register and unregister with regex metacharacters' '
 	META="a+b*c" &&
 	git init "$META" &&
diff --git a/versioncmp.c b/versioncmp.c
index effe1a6a6be..4efb5f9e621 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -165,11 +165,11 @@ int versioncmp(const char *s1, const char *s2)
 
 		initialized = 1;
 		prereleases_ret =
-			git_config_get_knownkey_value_multi("versionsort.suffix",
-							    &prereleases);
+			git_config_get_knownkey_value_multi_string("versionsort.suffix",
+								   &prereleases);
 		deprecated_prereleases_ret =
-			git_config_get_knownkey_value_multi("versionsort.prereleasesuffix",
-							    &deprecated_prereleases);
+			git_config_get_knownkey_value_multi_string("versionsort.prereleasesuffix",
+								   &deprecated_prereleases);
 
 		if (!prereleases_ret) {
 			if (!deprecated_prereleases_ret)
-- 
2.38.0.1251.g3eefdfb5e7a


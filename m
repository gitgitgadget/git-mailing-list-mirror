Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D755BC43217
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 23:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiKAXGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 19:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiKAXFo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 19:05:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEB260FB
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 16:05:41 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f7so18242356edc.6
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 16:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9kpcGLudZ4GjaY1OwZUHEFuQp9Gv8yRkkHT8HMZFAw=;
        b=YSh2oMRzOy59e2cwb44F1FWTlIs25JB+sxeBgNWtS8dO4eOJt01XmZQMCxONuxjTUn
         NYp468opAlReoSCXkjXijyx5Mvwm5wdnqFTKmWANnvf+HtTmun2YiK+8DiHYey3TMBxM
         cLt19Oj4IJRBmbdB9Y0RJAYm0129IYw1/sxmZRXrKHmCvm/QdfJgFrhxIMIglepE8B2k
         DevVhRnndKlol8MaODuLfl4peT76hbW73+4Dfm8hZUniQXdwROZM8CyCgtnbB5lEXV1U
         V/vQY8AXiWDld9oBUe5sexZl3DS+7ArjvEvdY+jyLX2aE4zNpvw/HFFAHgzuB6ySjW1G
         CPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9kpcGLudZ4GjaY1OwZUHEFuQp9Gv8yRkkHT8HMZFAw=;
        b=e48WKm79A3UnICEsmKCteKe/bnqXeASRifVbBWx/nYHa0zqVc15uxxr/h2eMZ/7JF7
         UJAKRvV0a4cOlBL1F+0ubhj5JIJXV3rhJ3QbPjG6D5xRG6wMyfWF4eQomrgsnj3e8vcX
         7LZKvNjRV28Yq1HXj/vQjBJKPvx+CEpWEPny2Vd95dSbdk1f5cocaOQUSEoGj6ajo6Oq
         qfgHa1Wck7zDZPUzjswTT1tnFgtjdbOrD4tHYwzJtGrkpKs0c2LKTUV7BwpB4knNWVeZ
         9fWN3RxBiArwgCamuPHuonSolHQ9TUQJqU8D9flUc8Gci8vNwlMCA5D3igH5kTTwPd3s
         HNDg==
X-Gm-Message-State: ACrzQf2O7ujNfuIXsUgAdXhJN3ekAEjGj0vUnRFHL0GdX2l7+mC75U7q
        XBkN/CAxA3v+AXz3Nzk6pjNEvaqh1uoW8Q==
X-Google-Smtp-Source: AMsMyM5Jrh9+2W0o8Zd+wek0NTbKO+FPyTph/fGDYbvL8cY2WXw60fIGZ6OA8g5S5Z77IemZtQTKhA==
X-Received: by 2002:a05:6402:f24:b0:461:7c77:98c4 with SMTP id i36-20020a0564020f2400b004617c7798c4mr20788663eda.80.1667343939750;
        Tue, 01 Nov 2022 16:05:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020a17090631d200b0078cb06c2ef9sm4645202ejf.8.2022.11.01.16.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:05:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 8/9] config API: add "string" version of *_value_multi(), fix segfaults
Date:   Wed,  2 Nov 2022 00:05:19 +0100
Message-Id: <patch-v2-8.9-6b76f9eac90-20221101T225823Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
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

As this change shows, most users users of the *_config_*value_multi()
API didn't really want such an an unsafe and low-level API, let's give
them something with the safety of git_config_get_string() instead.

This fix is similar to what the *_string() functions and others
acquired in[1] and [2]. Namely introducing and using a safer
"*_get_string_multi()" variant of the low-level "_*value_multi()"
function.

This fixes segfaults in code introduced in:

  - d811c8e17c6 (versionsort: support reorder prerelease suffixes, 2015-02-26)
  - c026557a373 (versioncmp: generalize version sort suffix reordering, 2016-12-08)
  - a086f921a72 (submodule: decouple url and submodule interest, 2017-03-17)
  - a6be5e6764a (log: add log.excludeDecoration config option, 2020-04-16)
  - 92156291ca8 (log: add default decoration filter, 2022-08-05)
  - 50a044f1e40 (gc: replace config subprocesses with API calls, 2022-09-27)

There are now three remaining files using the low-level API:

- Two cases in "builtin/submodule--helper.c", where it's used safely
  to see if any config exists.
- One in "builtin/for-each-repo.c", which we'll convert in a
  subsequent commit.
- The "t/helper/test-config.c" code added in [3].

As seen in the preceding commit we need to give the
"t/helper/test-config.c" caller these "NULL" entries.

We could also alter the underlying git_configset_get_value_multi()
function to be "string safe", but doing so would leave no room for
other variants of "*_get_value_multi()" that coerce to other types.

Such coercion can't be built on the string version, since as we've
established "NULL" is a true value in the boolean context, but if we
coerced it to "" for use in a list of strings it'll be subsequently
coerced to "false" as a boolean.

The callback pattern being used here will make it easy to introduce
e.g. a "multi" variant which coerces its values to "bool", "int",
"path" etc.

1. 40ea4ed9032 (Add config_error_nonbool() helper function,
   2008-02-11)
2. 6c47d0e8f39 (config.c: guard config parser from value=NULL,
   2008-02-11).
3. 4c715ebb96a (test-config: add tests for the config_set API,
   2014-07-28)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c                   |  4 ++--
 builtin/log.c                  |  3 +--
 config.c                       | 35 +++++++++++++++++++++++++++++++++-
 config.h                       | 19 ++++++++++++++++++
 pack-bitmap.c                  |  2 +-
 submodule.c                    |  2 +-
 t/t4202-log.sh                 |  8 ++++++--
 t/t5310-pack-bitmaps.sh        |  9 +++++++--
 t/t7004-tag.sh                 |  9 +++++++--
 t/t7413-submodule-is-active.sh |  8 ++++++--
 t/t7900-maintenance.sh         | 22 ++++++++++++++++-----
 versioncmp.c                   |  4 ++--
 12 files changed, 103 insertions(+), 22 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 76cee01e442..f887dc7a3f3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1485,7 +1485,7 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 	else
 		git_config_set("maintenance.strategy", "incremental");
 
-	if (!git_config_get_value_multi(key, &list)) {
+	if (!git_config_get_string_multi(key, &list)) {
 		for_each_string_list_item(item, list) {
 			if (!strcmp(maintpath, item->string)) {
 				found = 1;
@@ -1541,7 +1541,7 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		usage_with_options(builtin_maintenance_unregister_usage,
 				   options);
 
-	if (!git_config_get_value_multi(key, &list)) {
+	if (!git_config_get_string_multi(key, &list)) {
 		for_each_string_list_item(item, list) {
 			if (!strcmp(maintpath, item->string)) {
 				found = 1;
diff --git a/builtin/log.c b/builtin/log.c
index cc9d92f95da..9b19ae0a736 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -184,8 +184,7 @@ static void set_default_decoration_filter(struct decoration_filter *decoration_f
 	struct string_list *include = decoration_filter->include_ref_pattern;
 	const struct string_list *config_exclude;
 
-	if (!git_config_get_value_multi("log.excludeDecoration",
-					&config_exclude)) {
+	if (!git_config_get_string_multi("log.excludeDecoration", &config_exclude)) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, config_exclude)
 			string_list_append(decoration_filter->exclude_ref_config_pattern,
diff --git a/config.c b/config.c
index 0b07045ed8c..f656d1cd99d 100644
--- a/config.c
+++ b/config.c
@@ -2437,6 +2437,25 @@ int git_configset_get_value_multi(struct config_set *cs, const char *key,
 	return 0;
 }
 
+static int check_multi_string(struct string_list_item *item, void *util)
+{
+	return item->string ? 0 : config_error_nonbool(util);
+}
+
+int git_configset_get_string_multi(struct config_set *cs, const char *key,
+				   const struct string_list **dest)
+{
+	int ret;
+
+	if ((ret = git_configset_get_value_multi(cs, key, dest)))
+		return ret;
+	if ((ret = for_each_string_list((struct string_list *)*dest,
+					check_multi_string, (void *)key)))
+		return ret;
+
+	return 0;
+}
+
 int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
 {
 	const char *value;
@@ -2587,6 +2606,13 @@ int repo_config_get_value_multi(struct repository *repo, const char *key,
 	return git_configset_get_value_multi(repo->config, key, dest);
 }
 
+int repo_config_get_string_multi(struct repository *repo, const char *key,
+				 const struct string_list **dest)
+{
+	git_config_check_init(repo);
+	return git_configset_get_string_multi(repo->config, key, dest);
+}
+
 int repo_config_get_string(struct repository *repo,
 			   const char *key, char **dest)
 {
@@ -2697,6 +2723,12 @@ int git_config_get_value_multi(const char *key, const struct string_list **dest)
 	return repo_config_get_value_multi(the_repository, key, dest);
 }
 
+int git_config_get_string_multi(const char *key,
+				const struct string_list **dest)
+{
+	return repo_config_get_string_multi(the_repository, key, dest);
+}
+
 int git_config_get_string(const char *key, char **dest)
 {
 	return repo_config_get_string(the_repository, key, dest);
@@ -2842,7 +2874,8 @@ void git_die_config(const char *key, const char *err, ...)
 		va_end(params);
 	}
 	if (git_config_get_value_multi(key, &values))
-		BUG("for key '%s' we must have a value to report on", key);
+		BUG("key '%s' does not exist, should not be given to git_die_config()",
+		    key);
 	kv_info = values->items[values->nr - 1].util;
 	git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
 }
diff --git a/config.h b/config.h
index 7f6ce6f2fb5..3079d60a860 100644
--- a/config.h
+++ b/config.h
@@ -472,6 +472,19 @@ RESULT_MUST_BE_USED
 int git_configset_get_value_multi(struct config_set *cs, const char *key,
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
+int git_configset_get_string_multi(struct config_set *cs, const char *key,
+				   const struct string_list **dest);
+
 /**
  * Clears `config_set` structure, removes all saved variable-value pairs.
  */
@@ -507,6 +520,9 @@ int repo_config_get_value(struct repository *repo,
 RESULT_MUST_BE_USED
 int repo_config_get_value_multi(struct repository *repo, const char *key,
 				const struct string_list **dest);
+RESULT_MUST_BE_USED
+int repo_config_get_string_multi(struct repository *repo, const char *key,
+				 const struct string_list **dest);
 int repo_config_get_string(struct repository *repo,
 			   const char *key, char **dest);
 int repo_config_get_string_tmp(struct repository *repo,
@@ -561,6 +577,9 @@ int git_config_get_value(const char *key, const char **value);
 RESULT_MUST_BE_USED
 int git_config_get_value_multi(const char *key,
 			       const struct string_list **dest);
+RESULT_MUST_BE_USED
+int git_config_get_string_multi(const char *key,
+				const struct string_list **dest);
 
 /**
  * Resets and invalidates the config cache.
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 81f0c0e016b..dd05ab03ca0 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2303,7 +2303,7 @@ const struct string_list *bitmap_preferred_tips(struct repository *r)
 {
 	const struct string_list *dest;
 
-	if (!repo_config_get_value_multi(r, "pack.preferbitmaptips", &dest))
+	if (!repo_config_get_string_multi(r, "pack.preferbitmaptips", &dest))
 		return dest;
 	return NULL;
 }
diff --git a/submodule.c b/submodule.c
index 05ebe5cab4c..6151e5c67a2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -274,7 +274,7 @@ int is_tree_submodule_active(struct repository *repo,
 	free(key);
 
 	/* submodule.active is set */
-	if (!repo_config_get_value_multi(repo, "submodule.active", &sl)) {
+	if (!repo_config_get_string_multi(repo, "submodule.active", &sl)) {
 		struct pathspec ps;
 		struct strvec args = STRVEC_INIT;
 		const struct string_list_item *item;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index e4f02d8208b..ae73aef922f 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -835,7 +835,7 @@ test_expect_success 'log.decorate configuration' '
 
 '
 
-test_expect_failure 'parse log.excludeDecoration with no value' '
+test_expect_success 'parse log.excludeDecoration with no value' '
 	cp .git/config .git/config.orig &&
 	test_when_finished mv .git/config.orig .git/config &&
 
@@ -843,7 +843,11 @@ test_expect_failure 'parse log.excludeDecoration with no value' '
 	[log]
 		excludeDecoration
 	EOF
-	git log --decorate=short
+	cat >expect <<-\EOF &&
+	error: missing value for '\''log.excludeDecoration'\''
+	EOF
+	git log --decorate=short 2>actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'decorate-refs with glob' '
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 2e65c8139c4..68195a1de36 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -404,7 +404,7 @@ test_bitmap_cases () {
 		)
 	'
 
-	test_expect_failure 'pack.preferBitmapTips' '
+	test_expect_success 'pack.preferBitmapTips' '
 		git init repo &&
 		test_when_finished "rm -rf repo" &&
 		(
@@ -416,7 +416,12 @@ test_bitmap_cases () {
 			[pack]
 				preferBitmapTips
 			EOF
-			git repack -adb
+
+			cat >expect <<-\EOF &&
+			error: missing value for '\''pack.preferbitmaptips'\''
+			EOF
+			git repack -adb 2>actual &&
+			test_cmp expect actual
 		)
 	'
 
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index f343551a7d4..f4a31ada79a 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1843,7 +1843,7 @@ test_expect_success 'invalid sort parameter in configuratoin' '
 	test_must_fail git tag -l "foo*"
 '
 
-test_expect_failure 'version sort handles empty value for versionsort.{prereleaseSuffix,suffix}' '
+test_expect_success 'version sort handles empty value for versionsort.{prereleaseSuffix,suffix}' '
 	cp .git/config .git/config.orig &&
 	test_when_finished mv .git/config.orig .git/config &&
 
@@ -1852,7 +1852,12 @@ test_expect_failure 'version sort handles empty value for versionsort.{prereleas
 		prereleaseSuffix
 		suffix
 	EOF
-	git tag -l --sort=version:refname
+	cat >expect <<-\EOF &&
+	error: missing value for '\''versionsort.suffix'\''
+	error: missing value for '\''versionsort.prereleasesuffix'\''
+	EOF
+	git tag -l --sort=version:refname 2>actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'version sort with prerelease reordering' '
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index bfe27e50732..887d181b72e 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -51,7 +51,7 @@ test_expect_success 'is-active works with submodule.<name>.active config' '
 	test-tool -C super submodule is-active sub1
 '
 
-test_expect_failure 'is-active handles submodule.active config missing a value' '
+test_expect_success 'is-active handles submodule.active config missing a value' '
 	cp super/.git/config super/.git/config.orig &&
 	test_when_finished mv super/.git/config.orig super/.git/config &&
 
@@ -60,7 +60,11 @@ test_expect_failure 'is-active handles submodule.active config missing a value'
 		active
 	EOF
 
-	test-tool -C super submodule is-active sub1
+	cat >expect <<-\EOF &&
+	error: missing value for '\''submodule.active'\''
+	EOF
+	test-tool -C super submodule is-active sub1 2>actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'is-active works with basic submodule.active config' '
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 958d906f245..1201866c8d0 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -505,7 +505,7 @@ test_expect_success 'register and unregister' '
 	git maintenance unregister --force
 '
 
-test_expect_failure 'register with no value for maintenance.repo' '
+test_expect_success 'register with no value for maintenance.repo' '
 	cp .git/config .git/config.orig &&
 	test_when_finished mv .git/config.orig .git/config &&
 
@@ -513,10 +513,15 @@ test_expect_failure 'register with no value for maintenance.repo' '
 	[maintenance]
 		repo
 	EOF
-	git maintenance register
+	cat >expect <<-\EOF &&
+	error: missing value for '\''maintenance.repo'\''
+	EOF
+	git maintenance register 2>actual &&
+	test_cmp expect actual &&
+	git config maintenance.repo
 '
 
-test_expect_failure 'unregister with no value for maintenance.repo' '
+test_expect_success 'unregister with no value for maintenance.repo' '
 	cp .git/config .git/config.orig &&
 	test_when_finished mv .git/config.orig .git/config &&
 
@@ -527,8 +532,15 @@ test_expect_failure 'unregister with no value for maintenance.repo' '
 	cat >expect <<-\EOF &&
 	error: missing value for '\''maintenance.repo'\''
 	EOF
-	git maintenance unregister &&
-	git maintenance unregister --force
+	test_expect_code 128 git maintenance unregister 2>actual.raw &&
+	grep ^error actual.raw >actual &&
+	test_cmp expect actual &&
+	git config maintenance.repo &&
+
+	git maintenance unregister --force 2>actual.raw &&
+	grep ^error actual.raw >actual &&
+	test_cmp expect actual &&
+	git config maintenance.repo
 '
 
 test_expect_success !MINGW 'register and unregister with regex metacharacters' '
diff --git a/versioncmp.c b/versioncmp.c
index 60c3a517122..7498da96e0e 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -164,8 +164,8 @@ int versioncmp(const char *s1, const char *s2)
 		const char *const oldk = "versionsort.prereleasesuffix";
 		const struct string_list *newl;
 		const struct string_list *oldl;
-		int new = git_config_get_value_multi(newk, &newl);
-		int old = git_config_get_value_multi(oldk, &oldl);
+		int new = git_config_get_string_multi(newk, &newl);
+		int old = git_config_get_string_multi(oldk, &oldl);
 
 		if (!new && !old)
 			warning("ignoring %s because %s is set", oldk, newk);
-- 
2.38.0.1280.g8136eb6fab2


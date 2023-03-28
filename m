Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E6DC76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjC1OGt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjC1OGi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 10:06:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FA9CA20
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:05:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so4194744wmq.3
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680012284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgVFenbfe9out5/7TmY0T3116q5YHU6A0v0mNo0HA1Y=;
        b=F2w3sv+HamCm2zj9TDxJMv7wat0IxjRC5ccWyZ1/GgDe6qYA+xaIrat2zzrMvAXzXl
         jJR4iRU1rz1FaWp+ezEq9SQPqq6tqu9GuZ8GpZ5pkEb9akdDZtS9h2zQzlKoFHz3mV+N
         oHIeDUbJSpk5mmVtPlnBxRlmqxU/Lw14a84TIlqKnRrwWmCxVPK2d6jHKentHkNZN37I
         9qPyu7fQqSiCfsZ0aHMYYSUhmk1l7tZyphI0/ApaxKokZkFfL4ATSGXuL44j8l2bFe8w
         ZlLF8il/jYKCfMUIgD3dA1d20ye3Yh1ukPBG5HIC8gh8+kCWh1eiknY4OGCGFWJJ5eTk
         S+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgVFenbfe9out5/7TmY0T3116q5YHU6A0v0mNo0HA1Y=;
        b=XC9cofMD8yUfvEnzGKU51e4w3RrLc34BHh/p9Ajqsapmfpt6ujv3ogl++8fd31vOt4
         KItQDAvnHsg5QWQi4Aphz5K1wC40Z2dOrer2qKC0Z1DD03y+P42M2m8iiOR3z3PrvZ6x
         bmQOdnR7gLz2+QK2CWNO5k7xyzPDmFkKFQCGFzOfjR44RnV0rcSM58FgLwCSKyKCopaM
         UQTln6fMJGeo8+1BxvXPTws0Ah2kdqylOigRTLyjBtVQsb6k1kk9SvEOHReefyr0gDLv
         bJEm45oYfoTyoz7qFoESuWtX3o2/eHHyP4IQLwubk7M0bPMk3HYC0LFGf8CpPXW2lRRi
         2GZg==
X-Gm-Message-State: AO0yUKWS6NHKZG+/qcqC7qViEj5GrtlC4gQtw+sOWifHU0iK2C2T0j6w
        5ItaQPRctHvrUnBcAWqW0pY+mce4OfYCzw==
X-Google-Smtp-Source: AK7set/KX2Ju09KqF5wseU6k66t/poAB/IlVgU5wnLcHKoQMw3PVdKrkytE7Z5WYE51turP5tN2z9w==
X-Received: by 2002:a05:600c:25a:b0:3ed:358e:c1c2 with SMTP id 26-20020a05600c025a00b003ed358ec1c2mr12132020wmj.18.1680012284206;
        Tue, 28 Mar 2023 07:04:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c3b8a00b003ede3f5c81fsm12903622wms.41.2023.03.28.07.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:04:43 -0700 (PDT)
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
Subject: [PATCH v8 8/9] config API: add "string" version of *_value_multi(), fix segfaults
Date:   Tue, 28 Mar 2023 16:04:27 +0200
Message-Id: <patch-v8-8.9-686b512c3df-20230328T140127Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v8-0.9-00000000000-20230328T140126Z-avarab@gmail.com>
References: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com> <cover-v8-0.9-00000000000-20230328T140126Z-avarab@gmail.com>
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

There are now two users ofthe low-level API:

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
 builtin/gc.c                   |  6 +++---
 builtin/log.c                  |  4 ++--
 config.c                       | 32 ++++++++++++++++++++++++++++++++
 config.h                       | 19 +++++++++++++++++++
 pack-bitmap.c                  |  2 +-
 submodule.c                    |  2 +-
 t/t4202-log.sh                 |  8 ++++++--
 t/t5310-pack-bitmaps.sh        |  8 ++++++--
 t/t7004-tag.sh                 |  9 +++++++--
 t/t7413-submodule-is-active.sh |  8 ++++++--
 t/t7900-maintenance.sh         | 25 ++++++++++++++++++++-----
 versioncmp.c                   |  4 ++--
 12 files changed, 105 insertions(+), 22 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index b87fb53a215..efc1b9a0fda 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1511,7 +1511,7 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 	if (git_config_get("maintenance.strategy"))
 		git_config_set("maintenance.strategy", "incremental");
 
-	if (!git_config_get_value_multi(key, &list)) {
+	if (!git_config_get_string_multi(key, &list)) {
 		for_each_string_list_item(item, list) {
 			if (!strcmp(maintpath, item->string)) {
 				found = 1;
@@ -1579,8 +1579,8 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		git_configset_add_file(&cs, config_file);
 	}
 	if (!(config_file
-	      ? git_configset_get_value_multi(&cs, key, &list)
-	      : git_config_get_value_multi(key, &list))) {
+	      ? git_configset_get_string_multi(&cs, key, &list)
+	      : git_config_get_string_multi(key, &list))) {
 		for_each_string_list_item(item, list) {
 			if (!strcmp(maintpath, item->string)) {
 				found = 1;
diff --git a/builtin/log.c b/builtin/log.c
index 4e04efa5a72..0c6556b2d78 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -187,8 +187,8 @@ static void set_default_decoration_filter(struct decoration_filter *decoration_f
 	struct string_list *include = decoration_filter->include_ref_pattern;
 	const struct string_list *config_exclude;
 
-	if (!git_config_get_value_multi("log.excludeDecoration",
-					&config_exclude)) {
+	if (!git_config_get_string_multi("log.excludeDecoration",
+					 &config_exclude)) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, config_exclude)
 			string_list_append(decoration_filter->exclude_ref_config_pattern,
diff --git a/config.c b/config.c
index e8ea4533f94..f80a068fcad 100644
--- a/config.c
+++ b/config.c
@@ -2451,6 +2451,25 @@ int git_configset_get_value_multi(struct config_set *cs, const char *key,
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
 int git_configset_get(struct config_set *cs, const char *key)
 {
 	struct config_set_element *e;
@@ -2619,6 +2638,13 @@ int repo_config_get_value_multi(struct repository *repo, const char *key,
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
@@ -2734,6 +2760,12 @@ int git_config_get_value_multi(const char *key, const struct string_list **dest)
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
diff --git a/config.h b/config.h
index 109c845663d..4a6e3f19e5d 100644
--- a/config.h
+++ b/config.h
@@ -463,6 +463,19 @@ RESULT_MUST_BE_USED
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
@@ -513,6 +526,9 @@ int repo_config_get_value(struct repository *repo,
 RESULT_MUST_BE_USED
 int repo_config_get_value_multi(struct repository *repo, const char *key,
 				const struct string_list **dest);
+RESULT_MUST_BE_USED
+int repo_config_get_string_multi(struct repository *repo, const char *key,
+				 const struct string_list **dest);
 int repo_config_get_string(struct repository *repo,
 			   const char *key, char **dest);
 int repo_config_get_string_tmp(struct repository *repo,
@@ -574,6 +590,9 @@ int git_config_get_value(const char *key, const char **value);
 RESULT_MUST_BE_USED
 int git_config_get_value_multi(const char *key,
 			       const struct string_list **dest);
+RESULT_MUST_BE_USED
+int git_config_get_string_multi(const char *key,
+				const struct string_list **dest);
 
 /**
  * Resets and invalidates the config cache.
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 4c1e6fed631..f8ab6be411d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2320,7 +2320,7 @@ const struct string_list *bitmap_preferred_tips(struct repository *r)
 {
 	const struct string_list *dest;
 
-	if (!repo_config_get_value_multi(r, "pack.preferbitmaptips", &dest))
+	if (!repo_config_get_string_multi(r, "pack.preferbitmaptips", &dest))
 		return dest;
 	return NULL;
 }
diff --git a/submodule.c b/submodule.c
index 85b1ccbf784..c9579f9a3f8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -275,7 +275,7 @@ int is_tree_submodule_active(struct repository *repo,
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
index 0306b399188..526a5a506eb 100755
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
@@ -416,7 +416,11 @@ test_bitmap_cases () {
 			[pack]
 				preferBitmapTips
 			EOF
-			git repack -adb
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
index d82eac6a471..487e326b3fa 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -524,7 +524,7 @@ test_expect_success 'register and unregister' '
 	git maintenance unregister --config-file ./other --force
 '
 
-test_expect_failure 'register with no value for maintenance.repo' '
+test_expect_success 'register with no value for maintenance.repo' '
 	cp .git/config .git/config.orig &&
 	test_when_finished mv .git/config.orig .git/config &&
 
@@ -532,10 +532,15 @@ test_expect_failure 'register with no value for maintenance.repo' '
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
 
@@ -543,8 +548,18 @@ test_expect_failure 'unregister with no value for maintenance.repo' '
 	[maintenance]
 		repo
 	EOF
-	git maintenance unregister &&
-	git maintenance unregister --force
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
2.40.0.rc1.1034.g5867a1b10c5


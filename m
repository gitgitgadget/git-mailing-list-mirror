Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF504C6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 05:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCQFBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 01:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCQFBX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 01:01:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B17B06E2
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 22:01:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i9so3355246wrp.3
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 22:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679029280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsaVfHXBcKemTCXldc4n+DmxkKkZetZryL+LR9ilXo0=;
        b=I7cQwRXb/TRzhVpfIDiwLBNhvQ+H86YSfap7LJAWbnn2jCvzs8OH13hQN3uIQT7GLo
         EOHpnqGMbS5JG7yhvcyMS0jiRu4hMoYGlR2ebRHI6thVptCHtCHJqMzornLlwGXxEzDY
         3n7gdujqPWgro5WNeaJmOmApGxP+13wxLYF8qbt075Qp8+rfdc9rR3og4v3Qdg3oIPAB
         YKy9ZJYpyVIticNEo+YsESUgtobtBStHTWmMGfgk4cNVm5mNFie63OQjwudrnGouwyHv
         jlerCWuMQ4Pt0iXdcri3etp468+VCLkHiJwaE2AKQVbMXLmzL+ZxMLGGX73FKLMN/O8F
         Mwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679029280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsaVfHXBcKemTCXldc4n+DmxkKkZetZryL+LR9ilXo0=;
        b=Ua74VRy8RrwQ/+c1fdyziF1XtzeaWrOPFu+fQiBE4H0SQFDozHCyKb+aEKtTh+6yvx
         I30gHD5ALUVzKdT+M0uV6QHsZDzNivQXw40KWu2XGzB4ufL+7M/nqmGUcnPEgIBViZjO
         IioVbjBuX2YMd9jLw3/SGsiY1F1lRDDOfWHwZQr73ABV3f3f6g18JIB31H1VTnOO8PWT
         S+ddTbtxk06Fj5BtYF4uAckVvsR69n8q1DZ6f89Nto0TUEH1meeL2wCpOo1LPDIAso4J
         6i4KmjYaKz2r4buwtko0eGz8GrcchwXI8sIr4mBmH4aoFdmkDTMJd2ojQcG4GzXuwcSS
         NYHw==
X-Gm-Message-State: AO0yUKV9TW11MYD1ou0xTMYoKqiCCRXhWLZ94NLA6hH4+xHgfTa2h2Zh
        ovfaKpQHSTpr1M4jj2jkVFwddL/iyY0T2w==
X-Google-Smtp-Source: AK7set9Iw72u3mgJzDTf3QEJTdf315ZaN7z7jjAvdsu0oazM6dCF0D4dv69G2opTIChUJgR+AaIUOQ==
X-Received: by 2002:a5d:5010:0:b0:2d0:d73a:7671 with SMTP id e16-20020a5d5010000000b002d0d73a7671mr4807614wrt.22.1679029280015;
        Thu, 16 Mar 2023 22:01:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d4889000000b002c559843748sm1027844wrq.10.2023.03.16.22.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 22:01:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 5/5] config API: add and use a repo_config_kvi()
Date:   Fri, 17 Mar 2023 06:01:10 +0100
Message-Id: <RFC-patch-5.5-2b80d293c83-20230317T042408Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com>
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com> <RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a repo_config_kvi(), which is a repo_config() which calls a
"config_kvi_fn_t", rather than the "config_fn_t" that repo_config()
uses.

This allows us to pass along the "struct key_value_info *" directly,
rather than having the callback grab it from the global
"current_config_kvi" that we've been maintaining in
"configset_iter()".

This change is an alternate direction to the topic at [1], this
expands on the vague suggestions I made in [2] to go in this
direction.

As this shows we can split apart the "config_fn_t", and thus avoid
having to change the hundreds of existing "config_fn_t" callers. By
doing this we can already get rid of the current_config_kvi()
function, as "builtin/remote.c" and "t/helper/test-config.c" were the
only users of it.

The change to "t/t5505-remote.sh" ensures that the change here to
config_read_push_default() isn't breaking things. It's the only test
that would go through that codepath, but nothing asserted that we'd
get the correct line number. Let's sanity check that, as well as the
other callback data.

This leaves the other current_config_*() functions. Subsequent commits
will need to deal with those.

1. https://lore.kernel.org/git/pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com/
2. https://lore.kernel.org/git/230307.86wn3szrzu.gmgdl@evledraar.gmail.com/
3. https://lore.kernel.org/git/230308.867cvrziac.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/remote.c       | 11 ++++++-----
 config.c               | 32 ++++++++++++++++++--------------
 config.h               |  9 ++++++++-
 t/helper/test-config.c | 13 +++++++------
 t/t5505-remote.sh      |  7 +++++--
 5 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 729f6f3643a..c65bce05034 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -644,17 +644,18 @@ struct push_default_info
 };
 
 static int config_read_push_default(const char *key, const char *value,
-	void *cb)
+				    struct key_value_info *kvi, void *cb)
 {
 	struct push_default_info* info = cb;
 	if (strcmp(key, "remote.pushdefault") ||
 	    !value || strcmp(value, info->old_name))
 		return 0;
 
-	info->scope = current_config_scope();
+	info->scope = kvi->scope;
 	strbuf_reset(&info->origin);
-	strbuf_addstr(&info->origin, current_config_name());
-	info->linenr = current_config_line();
+	if (kvi->filename)
+		strbuf_addstr(&info->origin, kvi->filename);
+	info->linenr = kvi->linenr;
 
 	return 0;
 }
@@ -663,7 +664,7 @@ static void handle_push_default(const char* old_name, const char* new_name)
 {
 	struct push_default_info push_default = {
 		old_name, CONFIG_SCOPE_UNKNOWN, STRBUF_INIT, -1 };
-	git_config(config_read_push_default, &push_default);
+	repo_config_kvi(the_repository, config_read_push_default, &push_default);
 	if (push_default.scope >= CONFIG_SCOPE_COMMAND)
 		; /* pass */
 	else if (push_default.scope >= CONFIG_SCOPE_LOCAL) {
diff --git a/config.c b/config.c
index 230a98b0631..1b3f534757c 100644
--- a/config.c
+++ b/config.c
@@ -2219,7 +2219,8 @@ int config_with_options(config_fn_t fn, void *data,
 	return ret;
 }
 
-static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
+static void configset_iter(struct config_set *cs, config_fn_t fn,
+			   config_kvi_fn_t fn_kvi, void *data)
 {
 	int i, value_index;
 	struct string_list *values;
@@ -2230,6 +2231,7 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 		const char *key;
 		const char *val;
 		struct key_value_info *kvi;
+		int ret;
 
 		entry = list->items[i].e;
 		value_index = list->items[i].value_index;
@@ -2239,11 +2241,15 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 		val = values->items[value_index].string;
 		kvi = values->items[value_index].util;
 
-		current_config_kvi = kvi;
-		if (fn(key, val, data) < 0)
+		if (!fn_kvi)
+			current_config_kvi = kvi;
+		ret = fn_kvi ? fn_kvi(key, val, kvi, data) :
+			fn(key, val, data);
+		current_config_kvi = NULL;
+
+		if (ret < 0)
 			git_die_config_linenr(entry->key, kvi->filename,
 					      kvi->linenr);
-		current_config_kvi = NULL;
 	}
 }
 
@@ -2567,7 +2573,13 @@ static void repo_config_clear(struct repository *repo)
 void repo_config(struct repository *repo, config_fn_t fn, void *data)
 {
 	git_config_check_init(repo);
-	configset_iter(repo->config, fn, data);
+	configset_iter(repo->config, fn, NULL, data);
+}
+
+void repo_config_kvi(struct repository *repo, config_kvi_fn_t fn, void *data)
+{
+	git_config_check_init(repo);
+	configset_iter(repo->config, NULL, fn, data);
 }
 
 int repo_config_get_value(struct repository *repo,
@@ -2670,7 +2682,7 @@ void git_protected_config(config_fn_t fn, void *data)
 {
 	if (!protected_config.hash_initialized)
 		read_protected_config();
-	configset_iter(&protected_config, fn, data);
+	configset_iter(&protected_config, fn, NULL, data);
 }
 
 /* Functions used historically to read configuration from 'the_repository' */
@@ -3843,14 +3855,6 @@ enum config_scope current_config_scope(void)
 		return current_parsing_scope;
 }
 
-int current_config_line(void)
-{
-	if (current_config_kvi)
-		return current_config_kvi->linenr;
-	else
-		return cf->linenr;
-}
-
 int lookup_config(const char **mapping, int nr_mapping, const char *var)
 {
 	int i;
diff --git a/config.h b/config.h
index a9cb01e9405..de5350dbee5 100644
--- a/config.h
+++ b/config.h
@@ -143,6 +143,13 @@ const char *config_origin_type_name(enum config_origin_type type);
  */
 typedef int (*config_fn_t)(const char *, const char *, void *);
 
+/**
+ * Like config_fn_t, but before the callback-specific data we'll get a
+ * "struct key_value_info" indicating the origin of the config.
+ */
+typedef int (*config_kvi_fn_t)(const char *key, const char *var,
+			       struct key_value_info *kvi, void *data);
+
 int git_default_config(const char *, const char *, void *);
 
 /**
@@ -371,7 +378,6 @@ int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
 enum config_scope current_config_scope(void);
 const char *current_config_origin_type(void);
 const char *current_config_name(void);
-int current_config_line(void);
 
 /*
  * Match and parse a config key of the form:
@@ -498,6 +504,7 @@ int git_configset_get_pathname(struct config_set *cs, const char *key, const cha
 /* Functions for reading a repository's config */
 struct repository;
 void repo_config(struct repository *repo, config_fn_t fn, void *data);
+void repo_config_kvi(struct repository *repo, config_kvi_fn_t fn, void *data);
 int repo_config_get_value(struct repository *repo,
 			  const char *key, const char **value);
 const struct string_list *repo_config_get_value_multi(struct repository *repo,
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 4ba9eb65606..2ef67b18a0b 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -37,7 +37,8 @@
  *
  */
 
-static int iterate_cb(const char *var, const char *value, void *data UNUSED)
+static int iterate_cb(const char *var, const char *value,
+		      struct key_value_info *kvi, void *data UNUSED)
 {
 	static int nr;
 
@@ -46,10 +47,10 @@ static int iterate_cb(const char *var, const char *value, void *data UNUSED)
 
 	printf("key=%s\n", var);
 	printf("value=%s\n", value ? value : "(null)");
-	printf("origin=%s\n", current_config_origin_type());
-	printf("name=%s\n", current_config_name());
-	printf("lno=%d\n", current_config_line());
-	printf("scope=%s\n", config_scope_name(current_config_scope()));
+	printf("origin=%s\n", config_origin_type_name(kvi->origin_type));
+	printf("name=%s\n", kvi->filename ? kvi->filename : "");
+	printf("lno=%d\n", kvi->linenr);
+	printf("scope=%s\n", config_scope_name(kvi->scope));
 
 	return 0;
 }
@@ -174,7 +175,7 @@ int cmd__config(int argc, const char **argv)
 			goto exit1;
 		}
 	} else if (!strcmp(argv[1], "iterate")) {
-		git_config(iterate_cb, NULL);
+		repo_config_kvi(the_repository, iterate_cb, NULL);
 		goto exit0;
 	}
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 43b7bcd7159..d9659b9c65e 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -853,8 +853,11 @@ test_expect_success 'rename a remote' '
 	(
 		cd four &&
 		git config branch.main.pushRemote origin &&
-		GIT_TRACE2_EVENT=$(pwd)/trace \
-			git remote rename --progress origin upstream &&
+		GIT_TRACE2_EVENT=$PWD/trace \
+			git remote rename --progress origin upstream 2>warn &&
+		grep -F "The global configuration remote.pushDefault" warn &&
+		grep "/\.gitconfig:2$" warn &&
+		grep "remote '\''origin'\''" warn &&
 		test_region progress "Renaming remote references" trace &&
 		grep "pushRemote" .git/config &&
 		test -z "$(git for-each-ref refs/remotes/origin)" &&
-- 
2.40.0.rc1.1034.g5867a1b10c5


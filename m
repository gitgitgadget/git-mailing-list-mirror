Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC2B31FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751665AbdFHXlk (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:41:40 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35324 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbdFHXlg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:41:36 -0400
Received: by mail-pg0-f44.google.com with SMTP id k71so20707526pgd.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MLFKMhP6GHbVgiCMYXe6mxyYldZZ0W7zGofmAWSmvQI=;
        b=TLeB8nAO+H6nA/KktQ9ag2NjMryFesunsCMfh91NVBgVeg0i04J6YNaWbi8HTHH8Ka
         VeE3DeaQ6OfL6aHbBbu2FkEk0NCLl7cc0U0DB9n2eSkq5PjFu3hda2AQ+518yzuHbRp1
         AFSBpH3ZyuvbB36YslGIv2MJaub6XrxB2XH0R34Ob6w9eBwJEqDMyfJPupHQBnFByNP+
         o1AoqJ8c8PapKnOKqxKZAOKlRughc/rcBSrFfN/9K4v8SvsLg9vFKZEYHupfrQUuwAE7
         G5sCjk/P9nY75YSgHVeu8pEygp+U/fwzof6V0bSl0rq0wW4MO5vrFWGidN+r4B/NRNxh
         awTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MLFKMhP6GHbVgiCMYXe6mxyYldZZ0W7zGofmAWSmvQI=;
        b=F1+qwa8sRXinFvz8hev6Vz8aht41ALxmpDZqVajfOdekLARVXRZNIAYQ1RGSmXIbNJ
         xZSmKAEp03yO7ij4wxGBgPt8lvrpj35PIrFfS58/bMBDj848tZZdCXcjdp/QWdNg39Us
         Mw8Z9+YElNb/Tb4sAvlBqnL9KiGn5KHPKlcYJo6fMFn0ikr6lr0sE4+Ty91jmlzxRCrl
         KJF0+NbOHikmWt0N1AQ7qb2DQlQaSK3FbBjhI2JAumWBsEZVqLKtlevDTg1+uL/QjtiC
         KNh8W422D0dQ9fE7I8WEtnheYkG4LQQh6v74YLRHq9MWAK0M97LZ4RDXsRTSEt9jdVms
         wzwg==
X-Gm-Message-State: AODbwcBOJ/uV8oKOYwfMC9pyH4e6b9prOOBphwo5a4QNoMlcksqZmjcG
        OKZhni9DFnMl4KBfyFRK4g==
X-Received: by 10.99.95.134 with SMTP id t128mr40328921pgb.182.1496965295073;
        Thu, 08 Jun 2017 16:41:35 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:34 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 13/32] submodule-config: store the_submodule_cache in the_repository
Date:   Thu,  8 Jun 2017 16:40:41 -0700
Message-Id: <20170608234100.188529-14-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor how 'the_submodule_cache' is handled so that it can be stored
inside of a repository object.  Also migrate 'the_submodule_cache' to be
stored in 'the_repository'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 repository.c       |  6 +++++
 repository.h       |  2 ++
 submodule-config.c | 70 ++++++++++++++++++++++++++++++++++++++++--------------
 submodule-config.h | 10 ++++++++
 4 files changed, 70 insertions(+), 18 deletions(-)

diff --git a/repository.c b/repository.c
index 21719d0a6..98a851d20 100644
--- a/repository.c
+++ b/repository.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "repository.h"
 #include "config.h"
+#include "submodule-config.h"
 
 /* The main repository */
 static struct repository the_repo;
@@ -192,6 +193,11 @@ void repo_clear(struct repository *repo)
 		repo->index = NULL;
 	}
 
+	if (repo->submodule_cache) {
+		submodule_cache_free(repo->submodule_cache);
+		repo->submodule_cache = NULL;
+	}
+
 	memset(repo, 0, sizeof(*repo));
 }
 
diff --git a/repository.h b/repository.h
index 9515cc631..d9f1f721b 100644
--- a/repository.h
+++ b/repository.h
@@ -3,6 +3,7 @@
 
 struct config_set;
 struct index_state;
+struct submodule_cache;
 
 struct repository {
 	/* Environment */
@@ -22,6 +23,7 @@ struct repository {
 	 */
 	struct config_set *config;
 	struct index_state *index;
+	struct submodule_cache *submodule_cache;
 
 	/* Configurations */
 	unsigned ignore_env:1;
diff --git a/submodule-config.c b/submodule-config.c
index d8f8d5ea3..37cfcceb9 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repository.h"
 #include "config.h"
 #include "submodule-config.h"
 #include "submodule.h"
@@ -15,6 +16,7 @@
 struct submodule_cache {
 	struct hashmap for_path;
 	struct hashmap for_name;
+	unsigned initialized:1;
 };
 
 /*
@@ -31,9 +33,6 @@ enum lookup_type {
 	lookup_path
 };
 
-static struct submodule_cache the_submodule_cache;
-static int is_cache_init;
-
 static int config_path_cmp(const struct submodule_entry *a,
 			   const struct submodule_entry *b,
 			   const void *unused)
@@ -50,10 +49,16 @@ static int config_name_cmp(const struct submodule_entry *a,
 	       hashcmp(a->config->gitmodules_sha1, b->config->gitmodules_sha1);
 }
 
-static void cache_init(struct submodule_cache *cache)
+static struct submodule_cache *submodule_cache_alloc(void)
+{
+	return xcalloc(1, sizeof(struct submodule_cache));
+}
+
+static void submodule_cache_init(struct submodule_cache *cache)
 {
 	hashmap_init(&cache->for_path, (hashmap_cmp_fn) config_path_cmp, 0);
 	hashmap_init(&cache->for_name, (hashmap_cmp_fn) config_name_cmp, 0);
+	cache->initialized = 1;
 }
 
 static void free_one_config(struct submodule_entry *entry)
@@ -65,11 +70,14 @@ static void free_one_config(struct submodule_entry *entry)
 	free(entry->config);
 }
 
-static void cache_free(struct submodule_cache *cache)
+static void submodule_cache_clear(struct submodule_cache *cache)
 {
 	struct hashmap_iter iter;
 	struct submodule_entry *entry;
 
+	if (!cache->initialized)
+		return;
+
 	/*
 	 * We iterate over the name hash here to be symmetric with the
 	 * allocation of struct submodule entries. Each is allocated by
@@ -81,6 +89,13 @@ static void cache_free(struct submodule_cache *cache)
 
 	hashmap_free(&cache->for_path, 1);
 	hashmap_free(&cache->for_name, 1);
+	cache->initialized = 0;
+}
+
+void submodule_cache_free(struct submodule_cache *cache)
+{
+	submodule_cache_clear(cache);
+	free(cache);
 }
 
 static unsigned int hash_sha1_string(const unsigned char *sha1,
@@ -494,43 +509,62 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	return submodule;
 }
 
-static void ensure_cache_init(void)
+static void submodule_cache_check_init(struct repository *repo)
 {
-	if (is_cache_init)
+	if (repo->submodule_cache && repo->submodule_cache->initialized)
 		return;
 
-	cache_init(&the_submodule_cache);
-	is_cache_init = 1;
+	if (!repo->submodule_cache)
+		repo->submodule_cache = submodule_cache_alloc();
+
+	submodule_cache_init(repo->submodule_cache);
 }
 
-int parse_submodule_config_option(const char *var, const char *value)
+int submodule_config_option(struct repository *repo,
+			    const char *var, const char *value)
 {
 	struct parse_config_parameter parameter;
-	parameter.cache = &the_submodule_cache;
+
+	submodule_cache_check_init(repo);
+
+	parameter.cache = repo->submodule_cache;
 	parameter.treeish_name = NULL;
 	parameter.gitmodules_sha1 = null_sha1;
 	parameter.overwrite = 1;
 
-	ensure_cache_init();
 	return parse_config(var, value, &parameter);
 }
 
+int parse_submodule_config_option(const char *var, const char *value)
+{
+	return submodule_config_option(the_repository, var, value);
+}
+
 const struct submodule *submodule_from_name(const unsigned char *treeish_name,
 		const char *name)
 {
-	ensure_cache_init();
-	return config_from(&the_submodule_cache, treeish_name, name, lookup_name);
+	submodule_cache_check_init(the_repository);
+	return config_from(the_repository->submodule_cache, treeish_name, name, lookup_name);
 }
 
 const struct submodule *submodule_from_path(const unsigned char *treeish_name,
 		const char *path)
 {
-	ensure_cache_init();
-	return config_from(&the_submodule_cache, treeish_name, path, lookup_path);
+	submodule_cache_check_init(the_repository);
+	return config_from(the_repository->submodule_cache, treeish_name, path, lookup_path);
+}
+
+const struct submodule *submodule_from_cache(struct repository *repo,
+					     const unsigned char *treeish_name,
+					     const char *key)
+{
+	submodule_cache_check_init(repo);
+	return config_from(repo->submodule_cache, treeish_name,
+			   key, lookup_path);
 }
 
 void submodule_free(void)
 {
-	cache_free(&the_submodule_cache);
-	is_cache_init = 0;
+	if (the_repository->submodule_cache)
+		submodule_cache_clear(the_repository->submodule_cache);
 }
diff --git a/submodule-config.h b/submodule-config.h
index d434ecdb4..bc45a25e8 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -22,14 +22,24 @@ struct submodule {
 	int recommend_shallow;
 };
 
+struct submodule_cache;
+struct repository;
+
+extern void submodule_cache_free(struct submodule_cache *cache);
+
 extern int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 extern int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
 extern int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
 extern int parse_submodule_config_option(const char *var, const char *value);
+extern int submodule_config_option(struct repository *repo,
+				   const char *var, const char *value);
 extern const struct submodule *submodule_from_name(
 		const unsigned char *commit_or_tree, const char *name);
 extern const struct submodule *submodule_from_path(
 		const unsigned char *commit_or_tree, const char *path);
+extern const struct submodule *submodule_from_cache(struct repository *repo,
+						    const unsigned char *treeish_name,
+						    const char *key);
 extern int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
 				      unsigned char *gitmodules_sha1,
 				      struct strbuf *rev);
-- 
2.13.1.508.gb3defc5cc-goog


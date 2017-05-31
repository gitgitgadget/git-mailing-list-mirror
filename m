Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D70E1FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751196AbdEaVox (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:44:53 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33455 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbdEaVow (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:44:52 -0400
Received: by mail-pf0-f176.google.com with SMTP id e193so18620190pfh.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DDYyd7kRin3jktLdd8OdjHoMTGvpgdTd1OnICoc7upY=;
        b=vpHGpagz3se/hNxhQOvGLlEMskWAE2WbM2Ul0z1IF6BRxpRVm7/BcAtBGjZRbcFG9v
         3V0oWUmIoVOfQhGZ5Eu6aCbj4cWFultAKZqG6MWS4KN+fLqgbN+MOcj3BHdk1124nE0+
         k4xynwz5JaSfY6DAJvf1T7W+WplfY711cHslDI4pni3bGdw67DQ9ova4fdwQyHoXVr0X
         nykQBQCZgaAmX/Ppv2FnXeX95T00zAYjBBHL9x26Cj3NhTCcjfEaX3j/g71ySANcDXIM
         psS2Yw/fBm0Yh8E18asdrA2EkzZRMuCtTvIoC3/CEpbR0RAmxdph9hQij6ZxhawVkY4f
         va3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DDYyd7kRin3jktLdd8OdjHoMTGvpgdTd1OnICoc7upY=;
        b=kBLrnQheQjKmAela+pEbYsy6+U3GSOX6oMXXtav83/+4z0rMycK4OzzP0n5DWDlfYQ
         Y7RcVtWWNfRyCUUByjQODouPf4hAlVDmK6EbwoMcvBSHod1tl3w16NacngKBJqjP7B55
         B4skTaqcpDStzQcVp6CQnHr0TPrHlnjYAM2lcDWhbp8kCDeiYSowuwoOd8JmAlqWqgkc
         yUaL+3wuhSQEdjIyM5u0CWCRYCso3jjE7Pr68lc+ozJc20GgyuTA0AxeqjQ6FYqylKPB
         vFNTzYsCVBQad/ag7NSKfz9MPf+9sFsmZN2p2pz23utrzyA0JfOWsl5WW0ELYOGgeyu/
         c7PA==
X-Gm-Message-State: AODbwcADq8Fwbq5vz15QlZ3mOT399ZUrEz+az+IsL5cVsH2FBHf7M6Vg
        wFnxr8VBHeOBGR+Z
X-Received: by 10.84.210.166 with SMTP id a35mr9446226pli.160.1496267091375;
        Wed, 31 May 2017 14:44:51 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:44:50 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 12/31] submodule-config: store the_submodule_cache in the_repository
Date:   Wed, 31 May 2017 14:43:58 -0700
Message-Id: <20170531214417.38857-13-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor how 'the_submodule_cache' is handled so that it can be stored
inside of a repository object.  Also migrate 'the_submodule_cache' to be
stored in 'the_repository'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 repo.c             |  6 +++++
 repo.h             |  2 ++
 submodule-config.c | 71 ++++++++++++++++++++++++++++++++++++++++--------------
 submodule-config.h | 10 ++++++++
 4 files changed, 71 insertions(+), 18 deletions(-)

diff --git a/repo.c b/repo.c
index c79d29534..13b7d244f 100644
--- a/repo.c
+++ b/repo.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "repo.h"
 #include "config.h"
+#include "submodule-config.h"
 
 /*
  * This may be the wrong place for this.
@@ -166,4 +167,9 @@ void repo_clear(struct repo *repo)
 		free(repo->index);
 		repo->index = NULL;
 	}
+
+	if (repo->submodule_cache) {
+		submodule_cache_free(repo->submodule_cache);
+		repo->submodule_cache = NULL;
+	}
 }
diff --git a/repo.h b/repo.h
index 756cda9e1..ebce2a408 100644
--- a/repo.h
+++ b/repo.h
@@ -3,6 +3,7 @@
 
 struct config_set;
 struct index_state;
+struct submodule_cache;
 
 struct repo {
 	/* Environment */
@@ -22,6 +23,7 @@ struct repo {
 	 */
 	struct config_set *config;
 	struct index_state *index;
+	struct submodule_cache *submodule_cache;
 
 	/* Configurations */
 	unsigned ignore_env:1;
diff --git a/submodule-config.c b/submodule-config.c
index d8f8d5ea3..cd356fec0 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repo.h"
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
@@ -494,43 +509,63 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	return submodule;
 }
 
-static void ensure_cache_init(void)
+static void submodule_cache_check_init(struct repo *repository)
 {
-	if (is_cache_init)
+	if (repository->submodule_cache && repository->submodule_cache->initialized)
 		return;
 
-	cache_init(&the_submodule_cache);
-	is_cache_init = 1;
+	if (!repository->submodule_cache)
+		repository->submodule_cache = submodule_cache_alloc();
+
+	submodule_cache_init(repository->submodule_cache);
 }
 
-int parse_submodule_config_option(const char *var, const char *value)
+int submodule_config_option(struct repo *repository,
+			    const char *var, const char *value)
 {
 	struct parse_config_parameter parameter;
-	parameter.cache = &the_submodule_cache;
+
+	submodule_cache_check_init(repository);
+
+	parameter.cache = repository->submodule_cache;
 	parameter.treeish_name = NULL;
 	parameter.gitmodules_sha1 = null_sha1;
 	parameter.overwrite = 1;
 
-	ensure_cache_init();
 	return parse_config(var, value, &parameter);
 }
 
+int parse_submodule_config_option(const char *var, const char *value)
+{
+	return submodule_config_option(&the_repository, var, value);
+}
+
 const struct submodule *submodule_from_name(const unsigned char *treeish_name,
 		const char *name)
 {
-	ensure_cache_init();
-	return config_from(&the_submodule_cache, treeish_name, name, lookup_name);
+	submodule_cache_check_init(&the_repository);
+	return config_from(the_repository.submodule_cache, treeish_name, name, lookup_name);
 }
 
 const struct submodule *submodule_from_path(const unsigned char *treeish_name,
 		const char *path)
 {
-	ensure_cache_init();
-	return config_from(&the_submodule_cache, treeish_name, path, lookup_path);
+	submodule_cache_check_init(&the_repository);
+	return config_from(the_repository.submodule_cache, treeish_name, path, lookup_path);
 }
 
+const struct submodule *submodule_from_cache(struct repo *repository,
+					     const unsigned char *treeish_name,
+					     const char *key)
+{
+	submodule_cache_check_init(repository);
+	return config_from(repository->submodule_cache, treeish_name,
+			   key, lookup_path);
+}
+
+
 void submodule_free(void)
 {
-	cache_free(&the_submodule_cache);
-	is_cache_init = 0;
+	if (the_repository.submodule_cache)
+		submodule_cache_clear(the_repository.submodule_cache);
 }
diff --git a/submodule-config.h b/submodule-config.h
index d434ecdb4..2bfe78d89 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -22,14 +22,24 @@ struct submodule {
 	int recommend_shallow;
 };
 
+struct submodule_cache;
+struct repo;
+
+extern void submodule_cache_free(struct submodule_cache *cache);
+
 extern int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 extern int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
 extern int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
 extern int parse_submodule_config_option(const char *var, const char *value);
+extern int submodule_config_option(struct repo *repository,
+				   const char *var, const char *value);
 extern const struct submodule *submodule_from_name(
 		const unsigned char *commit_or_tree, const char *name);
 extern const struct submodule *submodule_from_path(
 		const unsigned char *commit_or_tree, const char *path);
+extern const struct submodule *submodule_from_cache(struct repo *repository,
+						    const unsigned char *treeish_name,
+						    const char *key);
 extern int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
 				      unsigned char *gitmodules_sha1,
 				      struct strbuf *rev);
-- 
2.13.0.506.g27d5fe0cd-goog


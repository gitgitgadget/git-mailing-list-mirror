Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5DE21FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753696AbdFVSoc (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:44:32 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35575 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753649AbdFVSoa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:44:30 -0400
Received: by mail-pf0-f180.google.com with SMTP id c73so12563603pfk.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 11:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eTOiXeyrj/sL+9Z85EuKOmCL9NJ1+7QYfQc/cg72Vt8=;
        b=XZCwBF3kyiaX5N2rTLUvDnLbVhpVYZ4oN9fxH/yCTKpzc6WrX+b6jgYxKKpyC/KsKk
         BFsEfYNF9tRTLfReY5QePeKRHmHx2dERsuxvv1ihnRlV1iqn2IyDDAykT2npQppHLjDu
         jJy5Bu7SFnEI1UYxd6t8UZpsHD3sJlPi+HcgtMSB0XXzq6+MeMuC1Z17Pn07G+tCkG5z
         7q/bUAXO1hfyOKcagQVLQ7n64Ellyq2Tam1hJuL81dvBBOVdul+m+Ug7FcZXqKMAgVvi
         h3F/fJxO8RypmyYRtBAXb3aan2EytruMScZWIhLF1Q+wu/tRiWyeKlr4g7vqtdkSH5MS
         QEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eTOiXeyrj/sL+9Z85EuKOmCL9NJ1+7QYfQc/cg72Vt8=;
        b=az5Eklsjx4MhZSVQ95uw4pqf3tGMfolDMRP/Pp+F41NHnru8BOxsjYquGnFxWHC2hI
         dOzkvmlmWxmSbnDnFs/tHMRFFDUFOafuPPaX4A84dLeZpl01v/F1SJ4vbr1KkXBgOA6u
         FHGGUiUvIscvIcxdgqXvWFv8s6P3PZ3311BgVnNPYB/iIzkWF+/okWLdYvB/AYP2VUd3
         k5g6UljNgM/0x9sDlaJjZDc6lTPvkVIpyrnZCMLe35cxfUL+dumx1SeB6cga+sY1SqWd
         xdQSPVnY4OJJZ4Q7fd1mwJQJJs//7Kvo3ArE+L2bFolfVagZ6GdzLcWf/niAUD+ORUfL
         B9KA==
X-Gm-Message-State: AKS2vOzN3CICxMSzRHoDxjZRPMn2V9zmD6FDx+cMTd7fhtP6DCB3h7eF
        jMFpyBb7YTI1fHKtXFHMVA==
X-Received: by 10.84.179.193 with SMTP id b59mr4418999plc.3.1498157068422;
        Thu, 22 Jun 2017 11:44:28 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g78sm5222211pfb.122.2017.06.22.11.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 11:44:27 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 16/20] submodule-config: store the_submodule_cache in the_repository
Date:   Thu, 22 Jun 2017 11:43:44 -0700
Message-Id: <20170622184348.56497-17-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.704.gde00cce3c-goog
In-Reply-To: <20170622184348.56497-1-bmwill@google.com>
References: <20170620191951.84791-1-bmwill@google.com>
 <20170622184348.56497-1-bmwill@google.com>
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
 repository.h       |  4 ++++
 submodule-config.c | 70 ++++++++++++++++++++++++++++++++++++++++--------------
 submodule-config.h | 10 ++++++++
 4 files changed, 72 insertions(+), 18 deletions(-)

diff --git a/repository.c b/repository.c
index 6f6f4d91e..358c17517 100644
--- a/repository.c
+++ b/repository.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "repository.h"
 #include "config.h"
+#include "submodule-config.h"
 
 /* The main repository */
 static struct repository the_repo;
@@ -164,6 +165,11 @@ void repo_clear(struct repository *repo)
 		repo->config = NULL;
 	}
 
+	if (repo->submodule_cache) {
+		submodule_cache_free(repo->submodule_cache);
+		repo->submodule_cache = NULL;
+	}
+
 	if (repo->index) {
 		discard_index(repo->index);
 		free(repo->index);
diff --git a/repository.h b/repository.h
index 3a41568aa..c40738ceb 100644
--- a/repository.h
+++ b/repository.h
@@ -3,6 +3,7 @@
 
 struct config_set;
 struct index_state;
+struct submodule_cache;
 
 struct repository {
 	/* Environment */
@@ -50,6 +51,9 @@ struct repository {
 	 */
 	struct config_set *config;
 
+	/* Repository's submodule config as defined by '.gitmodules' */
+	struct submodule_cache *submodule_cache;
+
 	/*
 	 * Repository's in-memory index.
 	 * 'repo_read_index()' can be used to populate 'index'.
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
2.13.1.704.gde00cce3c-goog


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A72C20D28
	for <e@80x24.org>; Tue, 20 Jun 2017 19:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbdFTTVI (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:21:08 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35182 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbdFTTUi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:20:38 -0400
Received: by mail-pg0-f41.google.com with SMTP id 132so33104705pgb.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VCQ+dsdZVQlTswsRSzQjmg4rHEHitGiYdBsl/Eob7ko=;
        b=EqiHqhaN6PZ4FWP2TLkSW8jVe/bt5cN9hEZul9H2BjBrh+1+8QZy9keMEVIeFvpkad
         crFBRONGPEFE4yjOsODZQE0YroLx4wi/o/YhUQ9QypWLEdltxDIWrixJcC73CKxebWZm
         KYriiIZ7klwW//n4T5Y6m7UDrFxaAJVnMSP01GYwOiYUTu2ok3TUznjcqFj6NmnpBhKc
         DIAWuUHNPZNRR+0i2yR2CkHQvMAlB7AmanVgX3Yp8Wi4hcav8ush87ONLXZ0J+f/czSQ
         /koLutqCaVU/eo63K752/qgyUq4tHcWGCTQn6ocxLux8p1BpzLMJ//QXZuRJ4Rp9IdpV
         /LRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VCQ+dsdZVQlTswsRSzQjmg4rHEHitGiYdBsl/Eob7ko=;
        b=sxjLfvdnt/VJa4PRI9MGL+I0/9IWwCdNZxAjqSkFvZmHe5XwdrUP7iICFABpqYiG2V
         EUf/AV4ThMn/Bfrd5+AjUTdh1G+dCYIXPdHxDQObn9WF2asv9+nIcJJ4LX10SbRItF9A
         OJi0yv4CQgvcl53xVua7OaSUJ7PixdQVxzLVJnML5tJ0bSlrfqfkju03g/2XvClla1F+
         1kIGhnHEqid/vdVM///VM47FO9nxpzfcBKrYQ8C0YpkUaVQH+8e9G8exUnePEGVmA7MD
         LD8hq9Pf6ycMQIZAsZgVeY0jKPom5VT6TbN1yceAqUnapN6zXLFkVL+B0uLEt1Bk2Q6C
         WKvw==
X-Gm-Message-State: AKS2vOw+BcFpmjXJsdYeLmIf2uhsOvrN1kc5Q40xfuyOt/xoEWXpGsmN
        X22RgIR4YMnBlo1d1LQTmg==
X-Received: by 10.98.78.70 with SMTP id c67mr32072540pfb.155.1497986437398;
        Tue, 20 Jun 2017 12:20:37 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t6sm18680500pgs.33.2017.06.20.12.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 12:20:36 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 16/20] submodule-config: store the_submodule_cache in the_repository
Date:   Tue, 20 Jun 2017 12:19:47 -0700
Message-Id: <20170620191951.84791-17-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <20170620191951.84791-1-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
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
index 883e6e9e9..317041a4a 100644
--- a/repository.c
+++ b/repository.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "repository.h"
 #include "config.h"
+#include "submodule-config.h"
 
 /* The main repository */
 static struct repository the_repo;
@@ -181,6 +182,11 @@ void repo_clear(struct repository *repo)
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
index 1fa65c42f..4bc70ebc5 100644
--- a/repository.h
+++ b/repository.h
@@ -3,6 +3,7 @@
 
 struct config_set;
 struct index_state;
+struct submodule_cache;
 
 struct repository {
 	/* Environment */
@@ -32,6 +33,9 @@ struct repository {
 	 */
 	struct config_set *config;
 
+	/* Repository's submodule config as defined by '.gitmodules' */
+	struct submodule_cache *submodule_cache;
+
 	/* Repository's in-memory index */
 	struct index_state *index;
 
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
2.13.1.611.g7e3b11ae1-goog


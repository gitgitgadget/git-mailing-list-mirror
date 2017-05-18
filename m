Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ABD0201CF
	for <e@80x24.org>; Thu, 18 May 2017 23:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755001AbdERXWx (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:22:53 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36418 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753889AbdERXWr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:47 -0400
Received: by mail-pf0-f179.google.com with SMTP id m17so30751202pfg.3
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aYYoQPYWbV6AGYNzPgV6qsz6c0QYvK6Ghp9SDINjomE=;
        b=mmHUF15/8pINMx1LpvTntNPivihHsLfdQ0I3f0HSrPkuK7AxqCloz6BqMnkDSJ1csx
         Y76nJy7FeqHLBcW3KACY86xUTtN0vuFA15PxLZYrlLfjqp/mNUUuNQgB1H3kkAEYkB/m
         gMeJ9aA2+cwkPwSHTnbaJwGo1M2toXbDVtkW883IASakDysk0OliPU/1qwPaNylq6+Xy
         w9XolQT4qjrsznum2qrHCfHuiWkbq8eL2cNcd8PwKMz85YVOdzZPqLqGS9a4PAo/Q/+C
         h3j1Zy6ly47tOFB8XBuxnozIV4b0QZN9oSRoYt+LDHJeM3Xnps1MDlurYAbfEE41oaV9
         fz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aYYoQPYWbV6AGYNzPgV6qsz6c0QYvK6Ghp9SDINjomE=;
        b=TNHVeH4I47duGskJIO3zBUkEGtbLPJ7mM9OH/JGJ085BcGL+usHE4w3cZBC37wafuT
         Zv4d2ZWY1QVK4+ThBWWH7xlIfJXlq6OP41lbFDeAD2FNLpC03UCGs8+Sj5TeTX6pMTrE
         liUXL/tZELvjRR/IGHJ5FbrvkCau5GIm+TwmR0v79jaDHC/QCxK5NmFtX66sXo99Ddh3
         LPFG3VQ7c73mh1ET5bS3FiczVPcZMMYMRZjRMBkh7dIX+2MxHbW+K/1doEjFcDuXgqg4
         /SJHCayjEEqvob0G0AJXLNP+hM2y6Rbf/ypygAxMgVO3exYRj6R6H7lUrb0F0BvS91vm
         HFNQ==
X-Gm-Message-State: AODbwcBI7sN8hluivH9GwS/8vyFJBV5Z6RGZ7wgTOdlSwSwhXz3Xin8F
        S5k2NeXxTB2NVltT
X-Received: by 10.84.232.71 with SMTP id f7mr7892475pln.168.1495149756441;
        Thu, 18 May 2017 16:22:36 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:35 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 20/23] submodule-config: refactor to allow for multiple submodule_cache's
Date:   Thu, 18 May 2017 16:21:31 -0700
Message-Id: <20170518232134.163059-21-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A repository object will have its own submodule cache so lay the ground
work for allowing multiple submodule cache structs.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule-config.c | 40 ++++++++++++++++++++++++++++++++--------
 submodule-config.h | 10 ++++++++++
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 4f58491dd..666643d52 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -30,7 +30,7 @@ enum lookup_type {
 	lookup_path
 };
 
-static struct submodule_cache the_submodule_cache;
+struct submodule_cache the_submodule_cache;
 static int is_cache_init;
 
 static int config_path_cmp(const struct submodule_entry *a,
@@ -49,7 +49,12 @@ static int config_name_cmp(const struct submodule_entry *a,
 	       hashcmp(a->config->gitmodules_sha1, b->config->gitmodules_sha1);
 }
 
-static void cache_init(struct submodule_cache *cache)
+struct submodule_cache *submodule_cache_alloc(void)
+{
+	return xcalloc(1, sizeof(struct submodule_cache));
+}
+
+void submodule_cache_init(struct submodule_cache *cache)
 {
 	hashmap_init(&cache->for_path, (hashmap_cmp_fn) config_path_cmp, 0);
 	hashmap_init(&cache->for_name, (hashmap_cmp_fn) config_name_cmp, 0);
@@ -64,7 +69,7 @@ static void free_one_config(struct submodule_entry *entry)
 	free(entry->config);
 }
 
-static void cache_free(struct submodule_cache *cache)
+static void submodule_cache_clear(struct submodule_cache *cache)
 {
 	struct hashmap_iter iter;
 	struct submodule_entry *entry;
@@ -82,6 +87,12 @@ static void cache_free(struct submodule_cache *cache)
 	hashmap_free(&cache->for_name, 1);
 }
 
+void submodule_cache_free(struct submodule_cache *cache)
+{
+	submodule_cache_clear(cache);
+	free(cache);
+}
+
 static unsigned int hash_sha1_string(const unsigned char *sha1,
 				     const char *string)
 {
@@ -493,27 +504,40 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	return submodule;
 }
 
+const struct submodule *
+submodule_from_cache(struct submodule_cache *cache,
+		     const unsigned char *treeish_name,
+		     const char *key)
+{
+	return config_from(cache, treeish_name, key, lookup_path);
+}
+
 static void ensure_cache_init(void)
 {
 	if (is_cache_init)
 		return;
 
-	cache_init(&the_submodule_cache);
+	submodule_cache_init(&the_submodule_cache);
 	is_cache_init = 1;
 }
 
-int parse_submodule_config_option(const char *var, const char *value)
+int parse_submodule_config_option_cache(struct submodule_cache *cache, const char *var, const char *value)
 {
 	struct parse_config_parameter parameter;
-	parameter.cache = &the_submodule_cache;
+	parameter.cache = cache;
 	parameter.treeish_name = NULL;
 	parameter.gitmodules_sha1 = null_sha1;
 	parameter.overwrite = 1;
 
-	ensure_cache_init();
 	return parse_config(var, value, &parameter);
 }
 
+int parse_submodule_config_option(const char *var, const char *value)
+{
+	ensure_cache_init();
+	return parse_submodule_config_option_cache(&the_submodule_cache, var, value);
+}
+
 const struct submodule *submodule_from_name(const unsigned char *treeish_name,
 		const char *name)
 {
@@ -530,6 +554,6 @@ const struct submodule *submodule_from_path(const unsigned char *treeish_name,
 
 void submodule_free(void)
 {
-	cache_free(&the_submodule_cache);
+	submodule_cache_clear(&the_submodule_cache);
 	is_cache_init = 0;
 }
diff --git a/submodule-config.h b/submodule-config.h
index d434ecdb4..ed598aadd 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -22,14 +22,24 @@ struct submodule {
 	int recommend_shallow;
 };
 
+struct submodule_cache;
+
+extern struct submodule_cache *submodule_cache_alloc(void);
+extern void submodule_cache_init(struct submodule_cache *cache);
+extern void submodule_cache_free(struct submodule_cache *cache);
+
 extern int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 extern int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
 extern int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
 extern int parse_submodule_config_option(const char *var, const char *value);
+extern int parse_submodule_config_option_cache(struct submodule_cache *cache, const char *var, const char *value);
 extern const struct submodule *submodule_from_name(
 		const unsigned char *commit_or_tree, const char *name);
 extern const struct submodule *submodule_from_path(
 		const unsigned char *commit_or_tree, const char *path);
+extern const struct submodule *submodule_from_cache(struct submodule_cache *cache,
+						    const unsigned char *treeish_name,
+						    const char *key);
 extern int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
 				      unsigned char *gitmodules_sha1,
 				      struct strbuf *rev);
-- 
2.13.0.303.g4ebf302169-goog


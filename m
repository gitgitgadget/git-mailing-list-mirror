Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2490E1FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbdEaVpD (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:45:03 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33475 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdEaVoz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:44:55 -0400
Received: by mail-pf0-f175.google.com with SMTP id e193so18621148pfh.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ph71H25iQiLfEH+AbAveTKnBClQ3EMGKPfZ2x5ETAhE=;
        b=IIzZhMhEzcFVt5CdeQpbPs7k4+xkGFOhznFyv+MgzWAbxRxuNSTiUMBBsZKPcbMjd8
         reNCamO2QDtZ5THd5mHnkbyLgMBIptZiYY2qsPY/2FDOQHj4FaLcDv+RHXMhjAbeJ+xZ
         1M5G/aEVqgR3UGUFw8cfaCo3FkjJxgwJxRaaVVKWZ+jm1J/wFeRzjEKk5FRH5wjkCkpL
         DUv+5LnwPDIGGKxJ9c+NYBMM6s4EQRhKAfgnf402EK03rBlDlYW/N90b3EhAy+dZNLSw
         zdbjm/1ciMNLyVHCBdDtuvD0q20RVoRD+6uIptTdlH+yF6LACygclMsAtgrlYZegAVR0
         dgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ph71H25iQiLfEH+AbAveTKnBClQ3EMGKPfZ2x5ETAhE=;
        b=avSgiRUVrYVTwIQdrWJEK/QC910t2s+YBp4Zlhqc5ERMeP8XRd6FFF/VPr9hLCvfym
         1wPc6sBhnlZQ363aJ+TxBwqmiJdvqaaT3VHp7ByhJiCOhgfsb6UO7qQlFJ8Kvt/y6mRJ
         4YhFx6U+lOxWsr9dwv1Dxl5KCK44Hk4RSvYX91/gebTMP9l2huejbxdxJ7+L/gAozIx0
         PpiTaQZuwt711MgTIRm3DP4Pc7PZ9/d+4fIzG2XbGgGazl3xo8hd36sFYTAuZ/r+rVuW
         ZZ7jMKJfv+rLv+N4UAXvh/q2VKPFHRuX+z+5OARmJajWCv5CP2+Ai2hN91r5jOmjJ0RR
         z+lQ==
X-Gm-Message-State: AODbwcBaHIikO1wfOZ3F2y/YzkOkUA+1oDCbFafoso1Irod8djjYiQnt
        ViX8rl1vv2tvb71x
X-Received: by 10.84.217.201 with SMTP id d9mr91118440plj.164.1496267094439;
        Wed, 31 May 2017 14:44:54 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:44:53 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 14/31] submodule: convert is_submodule_initialized to work on a repository
Date:   Wed, 31 May 2017 14:44:00 -0700
Message-Id: <20170531214417.38857-15-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'is_submodule_initialized()' to take a repository object and
while we're at it, lets rename the function to 'is_submodule_active()'
and remove the NEEDSWORK comment.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/grep.c              |  3 ++-
 builtin/submodule--helper.c |  9 +++++----
 config.c                    | 12 ++++++------
 config.h                    |  9 +++++++++
 submodule.c                 | 21 +++++++++------------
 submodule.h                 |  3 ++-
 6 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 0f4a1e5a3..c3086bc0b 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2006 Junio C Hamano
  */
 #include "cache.h"
+#include "repo.h"
 #include "config.h"
 #include "blob.h"
 #include "tree.h"
@@ -626,7 +627,7 @@ static int grep_submodule_launch(struct grep_opt *opt,
 static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
 			  const char *filename, const char *path)
 {
-	if (!is_submodule_initialized(path))
+	if (!is_submodule_active(&the_repository, path))
 		return 0;
 	if (!is_submodule_populated_gently(path, NULL)) {
 		/*
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4dcbfb952..d2d6fa914 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "repo.h"
 #include "cache.h"
 #include "config.h"
 #include "parse-options.h"
@@ -280,7 +281,7 @@ static void module_list_active(struct module_list *list)
 	for (i = 0; i < list->nr; i++) {
 		const struct cache_entry *ce = list->entries[i];
 
-		if (!is_submodule_initialized(ce->name))
+		if (!is_submodule_active(&the_repository, ce->name))
 			continue;
 
 		ALLOC_GROW(active_modules.entries,
@@ -362,7 +363,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 *
 	 * Set active flag for the submodule being initialized
 	 */
-	if (!is_submodule_initialized(path)) {
+	if (!is_submodule_active(&the_repository, path)) {
 		strbuf_reset(&sb);
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
 		git_config_set_gently(sb.buf, "true");
@@ -817,7 +818,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	}
 
 	/* Check if the submodule has been initialized. */
-	if (!is_submodule_initialized(ce->name)) {
+	if (!is_submodule_active(&the_repository, ce->name)) {
 		next_submodule_warn_missing(suc, out, displaypath);
 		goto cleanup;
 	}
@@ -1193,7 +1194,7 @@ static int is_active(int argc, const char **argv, const char *prefix)
 
 	gitmodules_config();
 
-	return !is_submodule_initialized(argv[1]);
+	return !is_submodule_active(&the_repository, argv[1]);
 }
 
 #define SUPPORT_SUPER_PREFIX (1<<0)
diff --git a/config.c b/config.c
index 930333e89..977bba233 100644
--- a/config.c
+++ b/config.c
@@ -1885,8 +1885,8 @@ static int repo_config_get_value(struct repo *repository,
 	return git_configset_get_value(repository->config, key, value);
 }
 
-static const struct string_list *repo_config_get_value_multi(struct repo *repository,
-							     const char *key)
+const struct string_list *repo_config_get_value_multi(struct repo *repository,
+						      const char *key)
 {
 	git_config_check_init(repository);
 	return git_configset_get_value_multi(repository->config, key);
@@ -1903,8 +1903,8 @@ static int repo_config_get_string_const(struct repo *repository,
 	return ret;
 }
 
-static int repo_config_get_string(struct repo *repository,
-				  const char *key, char **dest)
+int repo_config_get_string(struct repo *repository,
+			   const char *key, char **dest)
 {
 	git_config_check_init(repository);
 	return repo_config_get_string_const(repository, key, (const char **)dest);
@@ -1924,8 +1924,8 @@ static int repo_config_get_ulong(struct repo *repository,
 	return git_configset_get_ulong(repository->config, key, dest);
 }
 
-static int repo_config_get_bool(struct repo *repository,
-				const char *key, int *dest)
+int repo_config_get_bool(struct repo *repository,
+			 const char *key, int *dest)
 {
 	git_config_check_init(repository);
 	return git_configset_get_bool(repository->config, key, dest);
diff --git a/config.h b/config.h
index 4cd9e2915..c4406b728 100644
--- a/config.h
+++ b/config.h
@@ -163,6 +163,15 @@ extern int git_configset_get_bool_or_int(struct config_set *cs, const char *key,
 extern int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest);
 extern int git_configset_get_pathname(struct config_set *cs, const char *key, const char **dest);
 
+struct repo;
+
+extern const struct string_list *repo_config_get_value_multi(struct repo *repository,
+							     const char *key);
+extern int repo_config_get_string(struct repo *repository,
+				  const char *key, char **dest);
+extern int repo_config_get_bool(struct repo *repository,
+				const char *key, int *dest);
+
 extern int git_config_get_value(const char *key, const char **value);
 extern const struct string_list *git_config_get_value_multi(const char *key);
 extern void git_config_clear(void);
diff --git a/submodule.c b/submodule.c
index 95328de61..84600bde7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repo.h"
 #include "config.h"
 #include "submodule-config.h"
 #include "submodule.h"
@@ -215,21 +216,17 @@ void gitmodules_config_sha1(const unsigned char *commit_sha1)
 }
 
 /*
- * NEEDSWORK: With the addition of different configuration options to determine
- * if a submodule is of interests, the validity of this function's name comes
- * into question.  Once the dust has settled and more concrete terminology is
- * decided upon, come up with a more proper name for this function.  One
- * potential candidate could be 'is_submodule_active()'.
- *
  * Determine if a submodule has been initialized at a given 'path'
  */
-int is_submodule_initialized(const char *path)
+int is_submodule_active(struct repo *repo, const char *path)
 {
 	int ret = 0;
 	char *key = NULL;
 	char *value = NULL;
 	const struct string_list *sl;
-	const struct submodule *module = submodule_from_path(null_sha1, path);
+	const struct submodule *module;
+	
+	module = submodule_from_cache(repo, null_sha1, path);
 
 	/* early return if there isn't a path->module mapping */
 	if (!module)
@@ -237,14 +234,14 @@ int is_submodule_initialized(const char *path)
 
 	/* submodule.<name>.active is set */
 	key = xstrfmt("submodule.%s.active", module->name);
-	if (!git_config_get_bool(key, &ret)) {
+	if (!repo_config_get_bool(repo, key, &ret)) {
 		free(key);
 		return ret;
 	}
 	free(key);
 
 	/* submodule.active is set */
-	sl = git_config_get_value_multi("submodule.active");
+	sl = repo_config_get_value_multi(repo, "submodule.active");
 	if (sl) {
 		struct pathspec ps;
 		struct argv_array args = ARGV_ARRAY_INIT;
@@ -264,7 +261,7 @@ int is_submodule_initialized(const char *path)
 
 	/* fallback to checking if the URL is set */
 	key = xstrfmt("submodule.%s.url", module->name);
-	ret = !git_config_get_string(key, &value);
+	ret = !repo_config_get_string(repo, key, &value);
 
 	free(value);
 	free(key);
@@ -1469,7 +1466,7 @@ int submodule_move_head(const char *path,
 	const struct submodule *sub;
 	int *error_code_ptr, error_code;
 
-	if (!is_submodule_initialized(path))
+	if (!is_submodule_active(&the_repository, path))
 		return 0;
 
 	if (flags & SUBMODULE_MOVE_HEAD_FORCE)
diff --git a/submodule.h b/submodule.h
index 8fb0f2549..5c30eea55 100644
--- a/submodule.h
+++ b/submodule.h
@@ -1,6 +1,7 @@
 #ifndef SUBMODULE_H
 #define SUBMODULE_H
 
+struct repo;
 struct diff_options;
 struct argv_array;
 struct oid_array;
@@ -41,7 +42,7 @@ extern void set_diffopt_flags_from_submodule_config(struct diff_options *,
 extern int submodule_config(const char *var, const char *value, void *cb);
 extern void gitmodules_config(void);
 extern void gitmodules_config_sha1(const unsigned char *commit_sha1);
-extern int is_submodule_initialized(const char *path);
+extern int is_submodule_active(struct repo *repo, const char *path);
 /*
  * Determine if a submodule has been populated at a given 'path' by checking if
  * the <path>/.git resolves to a valid git repository.
-- 
2.13.0.506.g27d5fe0cd-goog


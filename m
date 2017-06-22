Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97C7C1FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753714AbdFVSoh (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:44:37 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35588 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753701AbdFVSod (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:44:33 -0400
Received: by mail-pf0-f177.google.com with SMTP id c73so12564243pfk.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 11:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4iHxdmwb1DfAA8XckrokX8t1hB57ycv4o32p74FzjAA=;
        b=nYPNdxGC8eYo+KhNnA9rTnYcJUTKSV8PIigE8TfZWcu5H7qNlJr1ImnZNpjPZEXGh1
         hUxOu1m/JHlzg7QTkXIKhigZrmR+o/+LkjBk8Yxk4eTmRjbeJYlF2RKFcpGD4bNWvyUA
         OJEHtGQBWzPSKfx33Ky69qnuaA9MAV8V3yPGfnC5bvrjwjB7VdqIq6NAVlrt4axX7gWL
         MYYFM72/QUu1jupjUf0YidwXBhRa6yJccLEcxX3qfSMMkDTPaU50j+jysj6ah2IeA5VB
         aGRPZNHoYquNhkI92ozR80BbQ4uTYDe70NhcZNBdh62RslLbVjvR5KF4cMr3iysvdvfw
         hmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4iHxdmwb1DfAA8XckrokX8t1hB57ycv4o32p74FzjAA=;
        b=I2lwT8o5VPVLFCNHhc1rPXNr2yl9BN0WWLuETIbGQaTfizKzhz1cDgJF+8fSdXkvhL
         mlgkYRUFkkPVUwICzLEUyjYFRm5q/6o5oiJYvIrgX+W4Yplks6qWrjmBQjgWCZCWYlSP
         hZwcKWBBqa+geZ6RgmG2IM5EhMkLmFiOYt9Ybo5sTDO6RMTjzcE2TIa9ViVoKLFjPDtx
         LXjzWZkJ7B4yb+ZLgkfe7qI5F4wHLsukiQBd4T0N/9Uq0zAy297ybWhn4B7G21NIQBPp
         lsgPgmoh0XkB2rVBXQJR9ll1oJ8+MUHy3BCQIw2svrcfVtg6VWtbtS18z1+U3CBEg1hu
         s7OQ==
X-Gm-Message-State: AKS2vOylZ8vY9K8enTDs6qsuLqkfO+BkrElQwOOdKIEkYILr7LKWYJJ/
        U8FJxWnXABWMbQ3+VaxcQw==
X-Received: by 10.84.209.236 with SMTP id y99mr4532237plh.198.1498157072291;
        Thu, 22 Jun 2017 11:44:32 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g78sm5222211pfb.122.2017.06.22.11.44.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 11:44:31 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 18/20] submodule: convert is_submodule_initialized to work on a repository
Date:   Thu, 22 Jun 2017 11:43:46 -0700
Message-Id: <20170622184348.56497-19-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.704.gde00cce3c-goog
In-Reply-To: <20170622184348.56497-1-bmwill@google.com>
References: <20170620191951.84791-1-bmwill@google.com>
 <20170622184348.56497-1-bmwill@google.com>
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
 submodule.c                 | 20 ++++++++------------
 submodule.h                 |  2 +-
 4 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index f61a9d938..e3ba1d98e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2006 Junio C Hamano
  */
 #include "cache.h"
+#include "repository.h"
 #include "config.h"
 #include "blob.h"
 #include "tree.h"
@@ -643,7 +644,7 @@ static int grep_submodule_launch(struct grep_opt *opt,
 static int grep_submodule(struct grep_opt *opt, const struct object_id *oid,
 			  const char *filename, const char *path)
 {
-	if (!is_submodule_initialized(path))
+	if (!is_submodule_active(the_repository, path))
 		return 0;
 	if (!is_submodule_populated_gently(path, NULL)) {
 		/*
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8517032b3..e1b06c41d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "repository.h"
 #include "cache.h"
 #include "config.h"
 #include "parse-options.h"
@@ -280,7 +281,7 @@ static void module_list_active(struct module_list *list)
 	for (i = 0; i < list->nr; i++) {
 		const struct cache_entry *ce = list->entries[i];
 
-		if (!is_submodule_initialized(ce->name))
+		if (!is_submodule_active(the_repository, ce->name))
 			continue;
 
 		ALLOC_GROW(active_modules.entries,
@@ -362,7 +363,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 *
 	 * Set active flag for the submodule being initialized
 	 */
-	if (!is_submodule_initialized(path)) {
+	if (!is_submodule_active(the_repository, path)) {
 		strbuf_reset(&sb);
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
 		git_config_set_gently(sb.buf, "true");
@@ -817,7 +818,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	}
 
 	/* Check if the submodule has been initialized. */
-	if (!is_submodule_initialized(ce->name)) {
+	if (!is_submodule_active(the_repository, ce->name)) {
 		next_submodule_warn_missing(suc, out, displaypath);
 		goto cleanup;
 	}
@@ -1193,7 +1194,7 @@ static int is_active(int argc, const char **argv, const char *prefix)
 
 	gitmodules_config();
 
-	return !is_submodule_initialized(argv[1]);
+	return !is_submodule_active(the_repository, argv[1]);
 }
 
 #define SUPPORT_SUPER_PREFIX (1<<0)
diff --git a/submodule.c b/submodule.c
index d0b894772..b23c25311 100644
--- a/submodule.c
+++ b/submodule.c
@@ -283,21 +283,17 @@ void gitmodules_config_sha1(const unsigned char *commit_sha1)
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
+int is_submodule_active(struct repository *repo, const char *path)
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
@@ -305,14 +301,14 @@ int is_submodule_initialized(const char *path)
 
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
@@ -332,7 +328,7 @@ int is_submodule_initialized(const char *path)
 
 	/* fallback to checking if the URL is set */
 	key = xstrfmt("submodule.%s.url", module->name);
-	ret = !git_config_get_string(key, &value);
+	ret = !repo_config_get_string(repo, key, &value);
 
 	free(value);
 	free(key);
@@ -1532,7 +1528,7 @@ int submodule_move_head(const char *path,
 	const struct submodule *sub;
 	int *error_code_ptr, error_code;
 
-	if (!is_submodule_initialized(path))
+	if (!is_submodule_active(the_repository, path))
 		return 0;
 
 	if (flags & SUBMODULE_MOVE_HEAD_FORCE)
diff --git a/submodule.h b/submodule.h
index 8a3771ec6..623ce6ad7 100644
--- a/submodule.h
+++ b/submodule.h
@@ -49,7 +49,7 @@ void load_submodule_cache(void);
 extern void gitmodules_config(void);
 extern void repo_read_gitmodules(struct repository *repo);
 extern void gitmodules_config_sha1(const unsigned char *commit_sha1);
-extern int is_submodule_initialized(const char *path);
+extern int is_submodule_active(struct repository *repo, const char *path);
 /*
  * Determine if a submodule has been populated at a given 'path' by checking if
  * the <path>/.git resolves to a valid git repository.
-- 
2.13.1.704.gde00cce3c-goog


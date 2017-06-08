Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14BA21FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751603AbdFHXmC (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:42:02 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34420 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbdFHXlz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:41:55 -0400
Received: by mail-pg0-f53.google.com with SMTP id v18so20714007pgb.1
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wqEMq0mZmFDP4H/yOFhq3sQWirovzvRZdT1z0fBFWUc=;
        b=EHnZQt1yvpa7RNoMKL07svpqu0r4rpCxR5V8wub4FuH37Z1uGrO8NbxHUfD3mftRIw
         ipl7tPQrrBjPFvroOevskBqVgZQGLInrCrrI+425Kv8xzDT2IDC7tnQwrzIFJVrl6QiA
         782SgY4CHPiFdcQaluuBeXG2yJEU/zr2eNaVLe2RpktuCEP1xRC7e8cPBv9LBQ9CSz3t
         g/nU8z5mzsIrAUzc+EAcfvcUhjFTSK2dcj4xJu36iyYqxukmaXx4jLJMTXHqjTekVIRt
         Kuim2PboADJ3vWNiAevXtIGHz7VeFgQJHTsGDXdJduva1/+5TYjOnMlKjusG8fcxYdoV
         3s7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wqEMq0mZmFDP4H/yOFhq3sQWirovzvRZdT1z0fBFWUc=;
        b=ndwsIyBERxSb2kpgLV2FD+qdvBLhAF3iBuahV3ij0hEOFZALH5U645jo7xypojT1im
         HwkRkL6fi02EyBr+SrqH4apxk1S11amMbt2YuJTEN4Jr5Vvwqu+TRVYuMSwWX1/tlw8m
         KD/cdjLuuHoWbjhn1IgVwfBrRPT4OtlrCsU2KI6b1fXHml4wE/ST/PRjKWrXbLcMZAl5
         v7cJy5sxbIX6Jn3jWTSWTQe2dhOLXnwIC7WXSTteIj6WEbEbI1yukS16SCm6zdrPoSwQ
         7rnPyutyQ2HTXA09RHWcMDeY6FA8TkGmBHS6ES69MwXBkUZUjNEjKevGBq+JEA/L2HhC
         cgeA==
X-Gm-Message-State: AODbwcA0Zwz/gKzAeHaeCkc3dn1lehHwblnoXoGPb4GUTzQi6U0urAXm
        lRwlEB8eiHH7JHjkvzPBWA==
X-Received: by 10.98.91.5 with SMTP id p5mr38506203pfb.94.1496965298611;
        Thu, 08 Jun 2017 16:41:38 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:37 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 15/32] submodule: convert is_submodule_initialized to work on a repository
Date:   Thu,  8 Jun 2017 16:40:43 -0700
Message-Id: <20170608234100.188529-16-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
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
index 0f4a1e5a3..c2473c281 100644
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
@@ -626,7 +627,7 @@ static int grep_submodule_launch(struct grep_opt *opt,
 static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
 			  const char *filename, const char *path)
 {
-	if (!is_submodule_initialized(path))
+	if (!is_submodule_active(the_repository, path))
 		return 0;
 	if (!is_submodule_populated_gently(path, NULL)) {
 		/*
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4dcbfb952..2cd6047ef 100644
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
index 65f60ab57..7ec13253e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -230,21 +230,17 @@ void gitmodules_config_sha1(const unsigned char *commit_sha1)
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
@@ -252,14 +248,14 @@ int is_submodule_initialized(const char *path)
 
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
@@ -279,7 +275,7 @@ int is_submodule_initialized(const char *path)
 
 	/* fallback to checking if the URL is set */
 	key = xstrfmt("submodule.%s.url", module->name);
-	ret = !git_config_get_string(key, &value);
+	ret = !repo_config_get_string(repo, key, &value);
 
 	free(value);
 	free(key);
@@ -1484,7 +1480,7 @@ int submodule_move_head(const char *path,
 	const struct submodule *sub;
 	int *error_code_ptr, error_code;
 
-	if (!is_submodule_initialized(path))
+	if (!is_submodule_active(the_repository, path))
 		return 0;
 
 	if (flags & SUBMODULE_MOVE_HEAD_FORCE)
diff --git a/submodule.h b/submodule.h
index ec6ea8dfd..af8eada23 100644
--- a/submodule.h
+++ b/submodule.h
@@ -43,7 +43,7 @@ extern int submodule_config(const char *var, const char *value, void *cb);
 extern void gitmodules_config(void);
 extern void repo_read_gitmodules(struct repository *repo);
 extern void gitmodules_config_sha1(const unsigned char *commit_sha1);
-extern int is_submodule_initialized(const char *path);
+extern int is_submodule_active(struct repository *repo, const char *path);
 /*
  * Determine if a submodule has been populated at a given 'path' by checking if
  * the <path>/.git resolves to a valid git repository.
-- 
2.13.1.508.gb3defc5cc-goog


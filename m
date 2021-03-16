Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6710C4332E
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E54B65101
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhCPPxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhCPPwv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:52:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CECC06175F
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:52:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p19so1444723wmq.1
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=743W/QEa8d/zq2m4gyKfupVsy7XyaAWgf8DgagVsVlA=;
        b=WkzWRfZK/1SK6uYbIFMM+mgE34ZMKd4lS9QRn2iQulMPo4EpDQVXDTTo6nAcTH8d/c
         PPZoXlARdZ4GmBWQJYqau8AWiezYvsxiuaHUXqsn8OlJRGalXIQxS9zPTATWHijrHvyg
         KrYGMqUOYnOFS+kNybF7vYdPg5Dq6trMcyQoWEcm3c9GJf0wl41S6rDH1Nywa+H2nknK
         mbItu9F2ZInlNIefbqtaMwEJRMqKxdHfvsAOA44oC85C0awfzbR2nBjD8et0LINLrJbq
         Yj8KP2g/qwqsKoY91FuAWYqZwszQVABNRtpgIX2N7M3r66Sj2BlVFXK5NqtQ7NveRfPr
         POdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=743W/QEa8d/zq2m4gyKfupVsy7XyaAWgf8DgagVsVlA=;
        b=LzR5YpO51BAIDnuHVbeUWqzQ2kUu7aSD3E3kLqHZ+meTn/ZU69KxFjjsdRO1gm576S
         fod53NNhxEMOEGI4AlRTzBW1HgKTg+d5GDMTD70vYZdVFAs2YzVqqBg+UcxJJtG3X4JX
         fxfgrqhg4c7fCkbw2fFmqYHtzgVU9eRHu6RTZtC/lIfxBU4ykthbzHP5bOvRde1MuQBt
         CSUHdPdlgKBd4ZAqpzSYD4qF6aqT1fGeDuD06NcFOlZZkA51sYajCrM43MRb17sGLMZh
         FzVYAh75ncunjlKxnWI5H7gTbIpm25VvIJ4IDp/2BR6xAH/RPR63NyuftvxCLIrcHJX3
         CbfA==
X-Gm-Message-State: AOAM531gBKQozo1e7O2a4aK4yEM2U9UvzLTGi14Pt+3n0I2Oy0uq3h2R
        fm6Y88jTcOuxzFD2E9UcNsNl9Smwo+xv7w==
X-Google-Smtp-Source: ABdhPJzkPAeMeEOLeuzfj08p5XGp6hB+Ge6xO1rUwdCy6vZCMJKga589I08XoSNLKQ3+f0oUs25mtQ==
X-Received: by 2002:a1c:6a05:: with SMTP id f5mr269774wmc.75.1615909969314;
        Tue, 16 Mar 2021 08:52:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i11sm22224228wro.53.2021.03.16.08.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:52:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/9] tree.c API: move read_tree() into builtin/ls-files.c
Date:   Tue, 16 Mar 2021 16:52:37 +0100
Message-Id: <20210316155244.28328-3-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210315234344.28427-1-avarab@gmail.com>
References: <20210315234344.28427-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the read_tree() API was added around the same time as
read_tree_recursive() in 94537c78a82 (Move "read_tree()" to
"tree.c"[...], 2005-04-22) and b12ec373b8e ([PATCH] Teach read-tree
about commit objects, 2005-04-20) things have gradually migrated over
to the read_tree_recursive() version.

Now builtin/ls-files.c is the last user of this code, let's move all
the relevant code there. This allows for subsequent simplification of
it, and an eventual move to read_tree_recursive().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-files.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++
 cache.h            |  2 +-
 tree.c             | 89 ---------------------------------------------
 tree.h             |  5 ---
 4 files changed, 92 insertions(+), 95 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index f6f9e483b2..a445862281 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -12,6 +12,7 @@
 #include "dir.h"
 #include "builtin.h"
 #include "tree.h"
+#include "cache-tree.h"
 #include "parse-options.h"
 #include "resolve-undo.h"
 #include "string-list.h"
@@ -420,6 +421,96 @@ static int get_common_prefix_len(const char *common_prefix)
 	return common_prefix_len;
 }
 
+static int read_one_entry_opt(struct index_state *istate,
+			      const struct object_id *oid,
+			      const char *base, int baselen,
+			      const char *pathname,
+			      unsigned mode, int stage, int opt)
+{
+	int len;
+	struct cache_entry *ce;
+
+	if (S_ISDIR(mode))
+		return READ_TREE_RECURSIVE;
+
+	len = strlen(pathname);
+	ce = make_empty_cache_entry(istate, baselen + len);
+
+	ce->ce_mode = create_ce_mode(mode);
+	ce->ce_flags = create_ce_flags(stage);
+	ce->ce_namelen = baselen + len;
+	memcpy(ce->name, base, baselen);
+	memcpy(ce->name + baselen, pathname, len+1);
+	oidcpy(&ce->oid, oid);
+	return add_index_entry(istate, ce, opt);
+}
+
+static int read_one_entry(const struct object_id *oid, struct strbuf *base,
+			  const char *pathname, unsigned mode, int stage,
+			  void *context)
+{
+	struct index_state *istate = context;
+	return read_one_entry_opt(istate, oid, base->buf, base->len, pathname,
+				  mode, stage,
+				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
+}
+
+/*
+ * This is used when the caller knows there is no existing entries at
+ * the stage that will conflict with the entry being added.
+ */
+static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base,
+				const char *pathname, unsigned mode, int stage,
+				void *context)
+{
+	struct index_state *istate = context;
+	return read_one_entry_opt(istate, oid, base->buf, base->len, pathname,
+				  mode, stage,
+				  ADD_CACHE_JUST_APPEND);
+}
+
+
+static int read_tree(struct repository *r, struct tree *tree, int stage,
+		     struct pathspec *match, struct index_state *istate)
+{
+	read_tree_fn_t fn = NULL;
+	int i, err;
+
+	/*
+	 * Currently the only existing callers of this function all
+	 * call it with stage=1 and after making sure there is nothing
+	 * at that stage; we could always use read_one_entry_quick().
+	 *
+	 * But when we decide to straighten out git-read-tree not to
+	 * use unpack_trees() in some cases, this will probably start
+	 * to matter.
+	 */
+
+	/*
+	 * See if we have cache entry at the stage.  If so,
+	 * do it the original slow way, otherwise, append and then
+	 * sort at the end.
+	 */
+	for (i = 0; !fn && i < istate->cache_nr; i++) {
+		const struct cache_entry *ce = istate->cache[i];
+		if (ce_stage(ce) == stage)
+			fn = read_one_entry;
+	}
+
+	if (!fn)
+		fn = read_one_entry_quick;
+	err = read_tree_recursive(r, tree, "", 0, stage, match, fn, istate);
+	if (fn == read_one_entry || err)
+		return err;
+
+	/*
+	 * Sort the cache entry -- we need to nuke the cache tree, though.
+	 */
+	cache_tree_free(&istate->cache_tree);
+	QSORT(istate->cache, istate->cache_nr, cmp_cache_name_compare);
+	return 0;
+}
+
 /*
  * Read the tree specified with --with-tree option
  * (typically, HEAD) into stage #1 and then
diff --git a/cache.h b/cache.h
index 6fda8091f1..c2f8a8eadf 100644
--- a/cache.h
+++ b/cache.h
@@ -803,7 +803,7 @@ static inline int index_pos_to_insert_pos(uintmax_t pos)
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
 #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
-#define ADD_CACHE_JUST_APPEND 8		/* Append only; tree.c::read_tree() */
+#define ADD_CACHE_JUST_APPEND 8		/* Append only */
 #define ADD_CACHE_NEW_ONLY 16		/* Do not replace existing ones */
 #define ADD_CACHE_KEEP_CACHE_TREE 32	/* Do not invalidate cache-tree */
 #define ADD_CACHE_RENORMALIZE 64        /* Pass along HASH_RENORMALIZE */
diff --git a/tree.c b/tree.c
index a52479812c..a6c12f2745 100644
--- a/tree.c
+++ b/tree.c
@@ -11,54 +11,6 @@
 
 const char *tree_type = "tree";
 
-static int read_one_entry_opt(struct index_state *istate,
-			      const struct object_id *oid,
-			      const char *base, int baselen,
-			      const char *pathname,
-			      unsigned mode, int stage, int opt)
-{
-	int len;
-	struct cache_entry *ce;
-
-	if (S_ISDIR(mode))
-		return READ_TREE_RECURSIVE;
-
-	len = strlen(pathname);
-	ce = make_empty_cache_entry(istate, baselen + len);
-
-	ce->ce_mode = create_ce_mode(mode);
-	ce->ce_flags = create_ce_flags(stage);
-	ce->ce_namelen = baselen + len;
-	memcpy(ce->name, base, baselen);
-	memcpy(ce->name + baselen, pathname, len+1);
-	oidcpy(&ce->oid, oid);
-	return add_index_entry(istate, ce, opt);
-}
-
-static int read_one_entry(const struct object_id *oid, struct strbuf *base,
-			  const char *pathname, unsigned mode, int stage,
-			  void *context)
-{
-	struct index_state *istate = context;
-	return read_one_entry_opt(istate, oid, base->buf, base->len, pathname,
-				  mode, stage,
-				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
-}
-
-/*
- * This is used when the caller knows there is no existing entries at
- * the stage that will conflict with the entry being added.
- */
-static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base,
-				const char *pathname, unsigned mode, int stage,
-				void *context)
-{
-	struct index_state *istate = context;
-	return read_one_entry_opt(istate, oid, base->buf, base->len, pathname,
-				  mode, stage,
-				  ADD_CACHE_JUST_APPEND);
-}
-
 static int read_tree_1(struct repository *r,
 		       struct tree *tree, struct strbuf *base,
 		       int stage, const struct pathspec *pathspec,
@@ -154,47 +106,6 @@ int cmp_cache_name_compare(const void *a_, const void *b_)
 				  ce2->name, ce2->ce_namelen, ce_stage(ce2));
 }
 
-int read_tree(struct repository *r, struct tree *tree, int stage,
-	      struct pathspec *match, struct index_state *istate)
-{
-	read_tree_fn_t fn = NULL;
-	int i, err;
-
-	/*
-	 * Currently the only existing callers of this function all
-	 * call it with stage=1 and after making sure there is nothing
-	 * at that stage; we could always use read_one_entry_quick().
-	 *
-	 * But when we decide to straighten out git-read-tree not to
-	 * use unpack_trees() in some cases, this will probably start
-	 * to matter.
-	 */
-
-	/*
-	 * See if we have cache entry at the stage.  If so,
-	 * do it the original slow way, otherwise, append and then
-	 * sort at the end.
-	 */
-	for (i = 0; !fn && i < istate->cache_nr; i++) {
-		const struct cache_entry *ce = istate->cache[i];
-		if (ce_stage(ce) == stage)
-			fn = read_one_entry;
-	}
-
-	if (!fn)
-		fn = read_one_entry_quick;
-	err = read_tree_recursive(r, tree, "", 0, stage, match, fn, istate);
-	if (fn == read_one_entry || err)
-		return err;
-
-	/*
-	 * Sort the cache entry -- we need to nuke the cache tree, though.
-	 */
-	cache_tree_free(&istate->cache_tree);
-	QSORT(istate->cache, istate->cache_nr, cmp_cache_name_compare);
-	return 0;
-}
-
 struct tree *lookup_tree(struct repository *r, const struct object_id *oid)
 {
 	struct object *obj = lookup_object(r, oid);
diff --git a/tree.h b/tree.h
index 3eb0484cbf..6b0b1dc211 100644
--- a/tree.h
+++ b/tree.h
@@ -38,9 +38,4 @@ int read_tree_recursive(struct repository *r,
 			const char *base, int baselen,
 			int stage, const struct pathspec *pathspec,
 			read_tree_fn_t fn, void *context);
-
-int read_tree(struct repository *r, struct tree *tree,
-	      int stage, struct pathspec *pathspec,
-	      struct index_state *istate);
-
 #endif /* TREE_H */
-- 
2.31.0.256.gf0ddda3145


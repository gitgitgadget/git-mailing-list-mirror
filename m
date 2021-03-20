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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC98C433E1
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 22:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F0061933
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 22:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhCTWik (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 18:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhCTWiP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 18:38:15 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0575C061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 15:38:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b9so12753179wrt.8
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 15:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TT/xgXZlL5BvQfRSdgAIGqc2RRH7Q4ENWAoB0zNbJTY=;
        b=kMSmL22GguFgTHXDNIK46yjANXrDIqTJ4zVRN4MnQrcQv8v3NVU8yQBP/5YjIFMnwM
         FLX9fapd10mJZaTj79/cwUJrtdW6aUwUUttSM3OOy7tJsyvVQLi1uZiTuoBZElR3cF1A
         X+BeWc8aZ0c3m6+Ge9Y2ZzUAYqILSUxnHRICAYcx0zQGYoc8/08LBKoJWb217vemQ0TE
         jPlLIjYFJqGs/U4EYst3G8luyDyt62+UeH3p/BUYQo+0K4ZE4narouk7+dCRf+Hmw6vX
         LwB2vPnCRrc+yk3/WaSjiNWUa58olSLpaphMJK84o4XzredPcV/f2CP91DeYQ6JYK1/u
         bOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TT/xgXZlL5BvQfRSdgAIGqc2RRH7Q4ENWAoB0zNbJTY=;
        b=RnGMSrBz4+JYbv08iPyq0g9Ledg9koWzEcw2pL1lyEsyxZ4k9XS1WuauqVSagvvF1+
         Ah6LKeTniGy3YOupT0++oMYuCTncFxJB+Nknu20KM5YYHGB7EGHGD0Bgy06ppiC70Rp7
         jaTtpePGvy1/pCoZpnU1AqD64V0fPv0+m4rz2vD4HS7qkyu9FnuzFEwKQkzOT5c6jD72
         IvdvXzws+FBDMhWZGnxnsAyjxQnGd57DyltAoLSgVjHSY+Hs76ZEau2I227dBkZITuQ6
         pYqSEWGbOXBkxh2OPjoAV0XdUBKC8vdgYtbmjig0mD5yBgp/e1eVH2pGJdNYqy3DJK+1
         3HpA==
X-Gm-Message-State: AOAM532Ub15E7lonwXh/cqDzag9iTPZtBy2TTfTZUtc+j3AfL5x967pS
        v7qp9GzYOPJAGzzVh1stFE04kw9dOfyWug==
X-Google-Smtp-Source: ABdhPJx7y4TKXDiYPYi10BisEqofpWlVTFvEMn0vRXKpCSMhOShHLH2lV4teFQoBM1geBkUrKlbj0w==
X-Received: by 2002:adf:9148:: with SMTP id j66mr11308924wrj.124.1616279893327;
        Sat, 20 Mar 2021 15:38:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v2sm21472697wmj.1.2021.03.20.15.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 15:38:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 3/8] tree.c API: move read_tree() into builtin/ls-files.c
Date:   Sat, 20 Mar 2021 23:37:46 +0100
Message-Id: <6291d8a1b5ebb537d3842713f22f038125f57b38.1616279653.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.286.gc175f2cb894
In-Reply-To: <cover.1616279653.git.avarab@gmail.com>
References: <xmqqpmzxy939.fsf@gitster.g> <cover.1616279653.git.avarab@gmail.com>
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
index f6f9e483b27..a4458622813 100644
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
index 6fda8091f11..c2f8a8eadf6 100644
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
index a52479812ce..a6c12f2745a 100644
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
index 3eb0484cbf2..6b0b1dc211a 100644
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
2.31.0.286.gc175f2cb894


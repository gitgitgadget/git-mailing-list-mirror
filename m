Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4461FC433DB
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 19:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC9B650CF
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 19:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhCFTf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 14:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhCFTfP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 14:35:15 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53C5C06174A
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 11:35:14 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso1374951wma.4
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 11:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l44t0kx9MTkP83vPd5vNxPvm69YH9r5x3db1VIahav4=;
        b=TGzUCBjBNIwD3ZdPdqevMQx7sQHvlNIy3dQOS4DxGhWwo+J73bYiI9JYXT+dIKALV9
         UVPY5Qh9uOp1uYKMPY1EsWuWT/YnjuC5ot2wakD+2yYvdS6fIdhgoJH9wXhZ4HPZH++h
         crCWopDjyuHz+6vLnLdh59C1oQNxrM9jYXubDqHVVwyS7c2Cu8U1ONpF5uieboqdURku
         yE0kyMDtZ+EskEdSyT5NDIbr7aB4uWHbPJYgNGxMoyWqjfkfGn6gBKuzEQcho6qlZNK9
         xcvW0caEfZ7JO6iISIuWjMCsqWkn2kGzAhY1uw3hgy2JlyP2XUQ4KJ+8IbXdV8Z5hY4V
         lsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l44t0kx9MTkP83vPd5vNxPvm69YH9r5x3db1VIahav4=;
        b=lvvFUEumM9/mk2epvv59vVDQCgN7JKRXucmlbH1z8laH4bE0L/PL9ViJiZYnjn4tcr
         bkfxHak3+3mJdQf73fSWhCzms+mSBc3X2d8AkIApatSMy9tycJ8GzW9iKKK6+EgHPw2j
         S3B+l+P8FisjBvL8VpDzBZGh8viGk8wtcHK6ZMFKAbjsEw8wdSvXg9fro0lbap3nqg1i
         hIqLPHvX0sepVMXwssescOWPg02aj+b+cxMr5Fcg+5Jf0rZ565M9HXeFzClHvoQ0uc7z
         Vh4wVTLfGrVEh5MxEwZSsgJGpiLqB7/Cf5dAwKKIbQejnmhFD+NeZJltmiAVKBaxNwK1
         Q6Dw==
X-Gm-Message-State: AOAM530RK5iGaGp8oZ+RfgiIPCipbrMBuFlFTk7wKq2jwkeLo/ozB+6b
        gzwTqPk1XRttBfxCqq4bfGl+sdbE4HEFlw==
X-Google-Smtp-Source: ABdhPJxijE3x1+VhIKo7sxDdGcbYaX5wysxBqrmfYcOvnax227c6aDAGAhyy/GLZrkvbHv314cWR4A==
X-Received: by 2002:a1c:7901:: with SMTP id l1mr14986599wme.114.1615059313304;
        Sat, 06 Mar 2021 11:35:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a5sm9951578wrs.35.2021.03.06.11.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 11:35:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/7] tree.c API: move read_tree() into builtin/ls-files.c
Date:   Sat,  6 Mar 2021 20:34:52 +0100
Message-Id: <20210306193458.20633-2-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <1240014568-3675-1-git-send-email-pclouds@gmail.com>
References: <1240014568-3675-1-git-send-email-pclouds@gmail.com>
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
 tree.c             | 89 ---------------------------------------------
 tree.h             |  4 --
 3 files changed, 91 insertions(+), 93 deletions(-)

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
index 3eb0484cbf2..84d66b45538 100644
--- a/tree.h
+++ b/tree.h
@@ -39,8 +39,4 @@ int read_tree_recursive(struct repository *r,
 			int stage, const struct pathspec *pathspec,
 			read_tree_fn_t fn, void *context);
 
-int read_tree(struct repository *r, struct tree *tree,
-	      int stage, struct pathspec *pathspec,
-	      struct index_state *istate);
-
 #endif /* TREE_H */
-- 
2.31.0.rc0.126.g04f22c5b82


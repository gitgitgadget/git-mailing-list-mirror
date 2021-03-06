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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0A5C43381
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 19:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56F05650E3
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 19:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhCFTf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 14:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbhCFTfR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 14:35:17 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D2AC06174A
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 11:35:16 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id 7so6618928wrz.0
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 11:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s2SCpNqpvtyG6ZTXDnM+8KOZOD8tX2tX2pQPYZ2RGWA=;
        b=NuPSaiNn5WB4YYJICTxpSgpzbQ9dgc7r1WO3cGBPwaMFXAtgtDnybXFwU0mgzGIIgw
         VGy0GfPEAryRxIHgJG0MxK0tsYWkjL81bYJkO/E7jU/uFNAkkUqR5FlVWR2d+Zub8Dvo
         Js+sAGRRoqrfdA+cz7okm2XYd0ZWAZy9WEOpsFfZQ4FnQYOAMC6H9dPOqW1ku2BByeBi
         zzGE2jCTW10KqrcrsPOS5/5EpzL+/LI214LfLXpAF70glFxB/P3vTzeTLPq1ViaD6gUV
         vynJpzXdomVdMGlA2qznM6LnEhOUDmH0+OwxNaHADm1k7iAPl8H3SWDKp5ivHnGDmnne
         XniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s2SCpNqpvtyG6ZTXDnM+8KOZOD8tX2tX2pQPYZ2RGWA=;
        b=aXMxz62pPG4YsRTTn74vcpllWOJMhwLk9iAxMWoyp9UOt4fkomak8udjIYz+qzP6HM
         l1V44iNqWla5nJM38KDJj/na7jkLJG5JrdPjQkNvKCfVM8UzFF7XJmYwPtxL7sR5yjej
         9pwNLwkBfig7cJr3DFbECBAeQxvDhuY/ytcJxVRBfA4Osyj0RcuwZnEn5nPSWtl83H23
         5H28jWsGyvfE2K5wK5WKfw7nYI1dA5lXIMVtCCc9Gw5Ucn7aORoyii5I7gRRDwTuG4MD
         zao5ewv2Te3cxulQKxiy+j67eMAUPjWyy8DpiKDa/mHFZos4m5oISHj2pCeZ4I/WecgI
         J5mg==
X-Gm-Message-State: AOAM530hrRv2QdfpO8ZuFfQRIsQFWdpGb5fFWRVTsClzWOUCJVMzxHJm
        gs7q3TLNSaueZ1f8HN1YRKSyK/30++SPzg==
X-Google-Smtp-Source: ABdhPJzDk91sViPgIonmw0KIPIJlhxYZ8rDDb2kttShNC2Pxyv39DrTqfWmnPHTh2fxOWm9XINFo4w==
X-Received: by 2002:adf:ec46:: with SMTP id w6mr15045102wrn.213.1615059315282;
        Sat, 06 Mar 2021 11:35:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a5sm9951578wrs.35.2021.03.06.11.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 11:35:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/7] ls-files: remove cache juggling + sorting
Date:   Sat,  6 Mar 2021 20:34:54 +0100
Message-Id: <20210306193458.20633-4-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <1240014568-3675-1-git-send-email-pclouds@gmail.com>
References: <1240014568-3675-1-git-send-email-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "ce_stage(ce) == 1" and "Sort the cache entry" code from
read_tree(), which allows us to remove the function entirely and move
over to read_tree_recursive().

I don't think the "Sort the cached entry" code was needed here, see
af3785dc5a7 (Optimize "diff --cached" performance., 2007-08-09) for
the use-case it was intended for. The only user of this code is
"ls-files --with-tree", which isn't the sort of use-case that needs to
care about "ce_stage(ce) != 0" or sorting tree entries.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-files.c | 76 +++++++---------------------------------------
 1 file changed, 11 insertions(+), 65 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 74d572a3e4a..f5239437809 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -12,7 +12,6 @@
 #include "dir.h"
 #include "builtin.h"
 #include "tree.h"
-#include "cache-tree.h"
 #include "parse-options.h"
 #include "resolve-undo.h"
 #include "string-list.h"
@@ -421,12 +420,15 @@ static int get_common_prefix_len(const char *common_prefix)
 	return common_prefix_len;
 }
 
-static int read_one_entry_opt(struct index_state *istate,
-			      const struct object_id *oid,
-			      const char *base, int baselen,
-			      const char *pathname,
-			      unsigned mode, int stage, int opt)
+static int read_one_entry_quick(const struct object_id *oid,
+				struct strbuf *basebuf,
+				const char *pathname,
+				unsigned mode,
+				int stage, void *context)
 {
+	struct index_state *istate = context;
+	const char *base = basebuf->buf;
+	const int baselen = basebuf->len;
 	int len;
 	struct cache_entry *ce;
 
@@ -442,64 +444,7 @@ static int read_one_entry_opt(struct index_state *istate,
 	memcpy(ce->name, base, baselen);
 	memcpy(ce->name + baselen, pathname, len+1);
 	oidcpy(&ce->oid, oid);
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
-
-static int read_tree(struct repository *r, struct tree *tree,
-		     struct pathspec *match, struct index_state *istate)
-{
-	read_tree_fn_t fn = NULL;
-	int i, err;
-
-
-	/*
-	 * See if we have cache entry at the stage.  If so,
-	 * do it the original slow way, otherwise, append and then
-	 * sort at the end.
-	 */
-	for (i = 0; !fn && i < istate->cache_nr; i++) {
-		const struct cache_entry *ce = istate->cache[i];
-		if (ce_stage(ce) == 1)
-			fn = read_one_entry;
-	}
-
-	if (!fn)
-		fn = read_one_entry_quick;
-	err = read_tree_recursive(r, tree, "", 0, 1, match, fn, istate);
-	if (fn == read_one_entry || err)
-		return err;
-
-	/*
-	 * Sort the cache entry -- we need to nuke the cache tree, though.
-	 */
-	cache_tree_free(&istate->cache_tree);
-	QSORT(istate->cache, istate->cache_nr, cmp_cache_name_compare);
-	return 0;
+	return add_index_entry(istate, ce, ADD_CACHE_JUST_APPEND);
 }
 
 /*
@@ -540,7 +485,8 @@ void overlay_tree_on_index(struct index_state *istate,
 			       PATHSPEC_PREFER_CWD, prefix, matchbuf);
 	} else
 		memset(&pathspec, 0, sizeof(pathspec));
-	if (read_tree(the_repository, tree, &pathspec, istate))
+	if (read_tree_recursive(the_repository, tree, "", 0, 1,
+				&pathspec, read_one_entry_quick, istate))
 		die("unable to read tree entries %s", tree_name);
 
 	for (i = 0; i < istate->cache_nr; i++) {
-- 
2.31.0.rc0.126.g04f22c5b82


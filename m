Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3860A1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 19:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeJDCm3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 22:42:29 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:55834 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbeJDCm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 22:42:29 -0400
Received: by mail-vs1-f73.google.com with SMTP id e15-v6so2248635vso.22
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 12:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=w9PL1mndR6OdE97ALIWJ7/eMgY6Fzt1CJXNhuiZ9jBs=;
        b=arTeUfiaJxcrJSSzA2A7i7Wmj3jJvuFF5VD2EkXX1EQODo/vowkj7kGnO3mZKvPCtH
         UP6IWqYjQ3g2qowG+3tb/XcXhc0pjxCuxSX2HFMXRcB27gnaoPD5QSECHOncV67hwFtE
         3Kt1RjkNJHTvokUaAM64zSCU/FcvHDtOWjyXMAa9+0QA8IWJ85MM617S9ulgDxIAgCJu
         ymm53VGqoos9ivx5G/Vcubd1BlbFHDj6U3bs4Ba+X7cwPIYY7qgxbjhFukd2Fwx1ZCNz
         1Y+m+ArgsDG5jWB7SNX/vooy9L1qA0Cdni3PFA0cH6EgfbWZbMxaCYog3K15AJ0b/bB8
         zarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w9PL1mndR6OdE97ALIWJ7/eMgY6Fzt1CJXNhuiZ9jBs=;
        b=pF/I9/Tr1c4qad+t8d59zSfVQb12koX85aBbMkH6ZKs8qNukgaCPxhk0gtzmZAXKh2
         J5X3T3yi9VBNGesxVHW582OBFZNVM0Q0+X/GM93GbwAIhy9mo/z3GAG7mGCB5cdok+2T
         TixqFzyYs4ajwvR76XTxqSOrQRSW0MbGY1GvADAdBtoVqRFgSozaNbVhbBqypMoFsdqq
         /Uwi0MlwN9AWtq/ERgFWplamQ7MYl3xcLRI4MEy5qpsQhNUHlDiURssqP7AhbmCyPIqj
         Z+LeLTztpaVHtugcrVsbRI1PkSKXu8jDu1kVUyJxr1NJCW6gmCP8Jbxkl+YHksQRxXM7
         vF3A==
X-Gm-Message-State: ABuFfogUytpXoj+/tEkaoBin+9+jH0zf/SAEHzuVxfNii+r+BOmDrHed
        Ua+AxtauJFFuiIrc5NxDkvH2xQ0HqTGTeOlHgJeL8WjyMT8pY73dwfLKYVSMbirpPVsmu/gjaJ6
        vsKtsDtcSWFRczf6ycuYSwz6tX8JNz491co5efrx23xDxCMMF/pZYkZEW4q0=
X-Google-Smtp-Source: ACcGV62BflcmKwRMGBx4u0eLYHoIe3xdu1/d3YBq/n0B2vMRLQAIdnuiJZuWqEfmi3odQTmXl409HW0l+cFM
X-Received: by 2002:a67:7f8f:: with SMTP id a137-v6mr2775580vsd.21.1538596359972;
 Wed, 03 Oct 2018 12:52:39 -0700 (PDT)
Date:   Wed,  3 Oct 2018 12:52:13 -0700
In-Reply-To: <cover.1538592829.git.matvore@google.com>
Message-Id: <42ad5623bab52b8207831eab4a4f27e47a318e36.1538592829.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1538592829.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v10 2/8] list-objects: refactor to process_tree_contents
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com,
        gitster@pobox.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will be used in a follow-up patch to reduce indentation needed when
invoking the logic conditionally. i.e. rather than:

if (foo) {
	while (...) {
		/* this is very indented */
	}
}

we will have:

if (foo)
	process_tree_contents(...);

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects.c | 68 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 27 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 584518a3f..ccc529e5e 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -94,6 +94,46 @@ static void process_gitlink(struct traversal_context *ctx,
 	/* Nothing to do */
 }
 
+static void process_tree(struct traversal_context *ctx,
+			 struct tree *tree,
+			 struct strbuf *base,
+			 const char *name);
+
+static void process_tree_contents(struct traversal_context *ctx,
+				  struct tree *tree,
+				  struct strbuf *base)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+	enum interesting match = ctx->revs->diffopt.pathspec.nr == 0 ?
+		all_entries_interesting : entry_not_interesting;
+
+	init_tree_desc(&desc, tree->buffer, tree->size);
+
+	while (tree_entry(&desc, &entry)) {
+		if (match != all_entries_interesting) {
+			match = tree_entry_interesting(&entry, base, 0,
+						       &ctx->revs->diffopt.pathspec);
+			if (match == all_entries_not_interesting)
+				break;
+			if (match == entry_not_interesting)
+				continue;
+		}
+
+		if (S_ISDIR(entry.mode))
+			process_tree(ctx,
+				     lookup_tree(the_repository, entry.oid),
+				     base, entry.path);
+		else if (S_ISGITLINK(entry.mode))
+			process_gitlink(ctx, entry.oid->hash,
+					base, entry.path);
+		else
+			process_blob(ctx,
+				     lookup_blob(the_repository, entry.oid),
+				     base, entry.path);
+	}
+}
+
 static void process_tree(struct traversal_context *ctx,
 			 struct tree *tree,
 			 struct strbuf *base,
@@ -101,10 +141,6 @@ static void process_tree(struct traversal_context *ctx,
 {
 	struct object *obj = &tree->object;
 	struct rev_info *revs = ctx->revs;
-	struct tree_desc desc;
-	struct name_entry entry;
-	enum interesting match = revs->diffopt.pathspec.nr == 0 ?
-		all_entries_interesting: entry_not_interesting;
 	int baselen = base->len;
 	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
 	int gently = revs->ignore_missing_links ||
@@ -144,29 +180,7 @@ static void process_tree(struct traversal_context *ctx,
 	if (base->len)
 		strbuf_addch(base, '/');
 
-	init_tree_desc(&desc, tree->buffer, tree->size);
-
-	while (tree_entry(&desc, &entry)) {
-		if (match != all_entries_interesting) {
-			match = tree_entry_interesting(&entry, base, 0,
-						       &revs->diffopt.pathspec);
-			if (match == all_entries_not_interesting)
-				break;
-			if (match == entry_not_interesting)
-				continue;
-		}
-
-		if (S_ISDIR(entry.mode))
-			process_tree(ctx,
-				     lookup_tree(the_repository, entry.oid),
-				     base, entry.path);
-		else if (S_ISGITLINK(entry.mode))
-			process_gitlink(ctx, entry.oid->hash, base, entry.path);
-		else
-			process_blob(ctx,
-				     lookup_blob(the_repository, entry.oid),
-				     base, entry.path);
-	}
+	process_tree_contents(ctx, tree, base);
 
 	if (!(obj->flags & USER_GIVEN) && ctx->filter_fn) {
 		r = ctx->filter_fn(LOFS_END_TREE, obj,
-- 
2.19.0.605.g01d371f741-goog


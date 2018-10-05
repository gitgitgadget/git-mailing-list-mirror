Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B9241F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 21:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeJFEcP (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 00:32:15 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:38142 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJFEcP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 00:32:15 -0400
Received: by mail-io1-f73.google.com with SMTP id a13-v6so1291145ioh.5
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 14:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=w9PL1mndR6OdE97ALIWJ7/eMgY6Fzt1CJXNhuiZ9jBs=;
        b=C6K7fRdhgfXl/GRHzc4B2xP8py5k75p23FWRFtfmpn4glmKUFhf/YTMRCsOx4NWU3n
         CwfWpoOCHSq3zijEtFfG6kjQgOQ5BUnewk0QBYjrDPkcpmYduDbYal+alY14XsjU338C
         SXqcu6rZJOAjJlobevYznPE8Py5YnzhCTSYuHem6r6Vshre7meOdY+2sozFw/o3JBWXJ
         v6D5iiyGYS/cesfVZP8d33TWvYCqaYMF8imP9Zc7z0CKHqie4LT6mZ6mB5AHBnpSRUqx
         05dq/k+9ZpKuqYdJzVC5xUZhd+94BwUz9WqEzNfRqVeK5jotvqfruiHE3ph/zDoR3WwH
         23DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w9PL1mndR6OdE97ALIWJ7/eMgY6Fzt1CJXNhuiZ9jBs=;
        b=AAGfZh+teuwQGKh74LyVSsx5xgK5RVfthLt5JIcp8DQMz0JKK6pYuagBYhbfbE6Buc
         kQ9NS664snpdXfBejc7iK/cV/gLxFvfn2acJGM2khnQpW9wmXKE2nW0sjXEAvNP6ufh5
         KJcqYl04ujr6gVVNFcPCBNHngZSvi/oA9486vnUPpm2Uuie231t3tRoLnFChktWW08nb
         hgQyP5uAX9nzeqNm+kcZZeH7cP5P0ym4snAZMFQ2Tsz7vRYLmeLEu5ioAolQDz+ZnpVW
         8NnuE4pahG7IT0EAHTQlZZgVQZNkB/3OGWEOVW1hY3aSTl5VLnIDYkrb711baqhVjQhH
         bzpw==
X-Gm-Message-State: ABuFfoj9Spc4AOk1un2WhRBFJsgXM8+RJH9z2DjoeGdjs47zwrjgKJHa
        EcPLA5AXeDt8gkKRbP+vWkkczPJ3mRzonZQkuRC+8LZ47obFBMkYB0vjgNRhcCotfxXVWOLbbxE
        HpBoAp9pBT3pO5D8eShWZ3CeSuZJglg/o2LZYBNo948or5B/BlcwykJ1dDDU=
X-Google-Smtp-Source: ACcGV61h2Uza+KKq7hnsPGOF8UoDWFZuBDRd0/X4pU3Pwmw5FDLjvt7UihH7R3JLBuIZWNMT5j3b49JgUybB
X-Received: by 2002:a24:7996:: with SMTP id z144-v6mr9372090itc.10.1538775100902;
 Fri, 05 Oct 2018 14:31:40 -0700 (PDT)
Date:   Fri,  5 Oct 2018 14:31:21 -0700
In-Reply-To: <cover.1538774738.git.matvore@google.com>
Message-Id: <42ad5623bab52b8207831eab4a4f27e47a318e36.1538774738.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1538774738.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v11 2/8] list-objects: refactor to process_tree_contents
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


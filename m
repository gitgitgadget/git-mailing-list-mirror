Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF3431F453
	for <e@80x24.org>; Fri, 21 Sep 2018 20:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391499AbeIVCXA (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 22:23:00 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:35877 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391318AbeIVCW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 22:22:59 -0400
Received: by mail-pf1-f202.google.com with SMTP id d22-v6so7041490pfn.3
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 13:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+jcwrQHG0/7jLAct55sMVM0IYo0kK4SM6zajPikhqMg=;
        b=qUu6QRBfDsTqltQ7L2mKMQtSTtE+3gEUBElUBZJZBTTw5yNvgq6Ye8QU5BIVKrBDAw
         H0oc3BV+0uV2lU9REuqy5EBVDueaEUGp3RGvz9QQxxDFocUnJwZzBWfYOWEIbab7O5/9
         +8tRTKGIfykfN2P1+XdQjsNMNGO8eVey+HAfegtF7ch/oTLLKm5IsSN2mr8cxWq90+dw
         ZDIf1wIksbInxn+Fee0x1Se2SHdDtzSyH+rxrfxWVzYvCkhL6a+EE3i0ebuKBXAMWNhz
         qyYGrKlEZDoMpNpuKB0E4gYzfRG/3wgk2/P+tHjUK+fh1rmuo3bn7v5N9Cw+0i3DV1z9
         e6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+jcwrQHG0/7jLAct55sMVM0IYo0kK4SM6zajPikhqMg=;
        b=oYL5Fog1eZ3XDA4R2sEMNt1k5xl4p32+Kew8jIsM4FTARU+r3ZfRoIWSVW6vGkpdNQ
         JKEkOoW+Rkx+QSB1eWKD+XhugdwmaXQPC0RFMRN4s/IYwdyini0lyrUD0ld9598gO7Y5
         cn9rYcbxrRzD1vHZ2tTMcvkUOzPQ/52dmUFPEGpWJzbg0SNAI9Xgiq3j3BQec7/pxLgY
         X+fnmEt2UBKKRxQ9jqyY22+QXInn//aXo4ciTtlBLQLRaE7Sy3lIeJRpjrocu3AJqL7g
         XX170Jtxhw8DX89N5SV/Cz3sEkEGy1AuSL4h8AcsY/lH/CFjWQ79u2i9Hw+QRFVrad8l
         XJjQ==
X-Gm-Message-State: APzg51BS9zr+kyf+g2xCHSzRHAX3bB3rJTbYtLWawIdWtiu2ID37vMnk
        RRBWq0XTcm5JHKgqh1OMz4BRRp/dw2TJyPcxCZndHQLs0xoJMN+TLie6pngXHlhLNg+MyiyIv7e
        LIq68H5PHPPMUV6AIGTPldnK1kDBqvqUCock89lVYI49ukPbdQclHnBU229c=
X-Google-Smtp-Source: ANB0VdZfvJ9OFXuRCl5ewufiGg5OrtdzW/udIkrVB7AssAJWWTICNr8kLmxtbT8xKHAX8jLthn+xTtZa/uYC
X-Received: by 2002:a63:8b42:: with SMTP id j63-v6mr1910277pge.19.1537561948018;
 Fri, 21 Sep 2018 13:32:28 -0700 (PDT)
Date:   Fri, 21 Sep 2018 13:31:58 -0700
In-Reply-To: <cover.1537561420.git.matvore@google.com>
Message-Id: <42ad5623bab52b8207831eab4a4f27e47a318e36.1537561420.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1537561420.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH v9 2/8] list-objects: refactor to process_tree_contents
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
2.19.0.444.g18242da7ef-goog


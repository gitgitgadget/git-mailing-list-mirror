Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 815691F428
	for <e@80x24.org>; Tue, 14 Aug 2018 17:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388605AbeHNURU (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 16:17:20 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:37378 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388648AbeHNURT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 16:17:19 -0400
Received: by mail-ua1-f74.google.com with SMTP id w15-v6so10478079uao.4
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 10:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P/XVYMYGcUwy2zeTUhBFcI0p6ZEcn9k1dB9nuLK2AC0=;
        b=FgLZdzHfUa+dGMb3TJPs7/NAN13TLwBerjAwQ/VSRsmFSxV6rNfMmc0nAhq8WvZ+er
         s+tZvKWi6uv+/8an+k/pleCP5DOEr2TsAOWQ2We2LNaDTrSJ5Ydn7MFY2bdMGylDWAJM
         /W5UCxwf5ImLjk9x1zNaOYPz0DYuhPwYMmpBMZbCQEcBBSUEjzH6EOqvtrmaAcAPYW+Z
         eYM8Kee7LGOHB8xmQE4zuMKLZKqyFvBKIqbuTFROId2mIe4NXZ5ARY8SR2bBWQuutclN
         EhmUqhXqHVF8qiQ0obK1VOgnU5MXbdFOmgvaqs8861zHl5MHTfFI1qPglAue71B+wQ7U
         rxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P/XVYMYGcUwy2zeTUhBFcI0p6ZEcn9k1dB9nuLK2AC0=;
        b=KIZgQ3vWmj/wXWgbVC6xAG8yCQPeIkZKL+NeYx3v/pKiCkV21zWolc5GgVhTi1mB0z
         R81og+MtbJgSPOHlNTAY/03NS+k3osv0kY6/uHuDfsbiDBN2W3OcnzEn8J2bet+yxQyc
         cFZT9Qn3e7ay6/i1IsIWr5YZlL/LlFdqKSMKa2ggcm2VE5kMuLqSzhfYArI+9nCe0X37
         dFnslrj9wjR03lKKfZyJAGhlmWM4pTQbDTkHp3wuIWPeCHyfZB6MXJ6OFUWjISA0VZt8
         mr0B1e/MwoirZaXEJyLej8uHrPJhjm/mtrlXm21tlEY7M05lzFqMT477w6h1LT40QHjz
         +2dw==
X-Gm-Message-State: AOUpUlE92/PLJvzFYs3cqUGFPdoT3LyMfvZ2J+lwBdu7YrjNT9af+Fqs
        s3kx5iL7uQs4mkbH39+zEzSQBbLF1HXbRgKdKVxal51HRCjrEuY6FhtLwOOV7AsTZAqBQRdnUwC
        1iRbjP6p2bVTSc7lXrGvKoWIg85BojP6LeMeP81NMZoZxd7epadW3hAXzTEg=
X-Google-Smtp-Source: AA+uWPzYJD56aaS4tbe/8+WRGYtM69uG+otf2tGL52kmw/IbQiycZHqwkOFP0p4Nda2q5/ULV5I7uHoyNI/p
X-Received: by 2002:a9f:2b0b:: with SMTP id p11-v6mr10239613uaj.107.1534267752119;
 Tue, 14 Aug 2018 10:29:12 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:28:09 -0700
In-Reply-To: <cover.1534267611.git.matvore@google.com>
Message-Id: <feb7ea58228df4bb777ee96651389000e804f9fa.1534267611.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1534267611.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH v4 2/6] list-objects: refactor to process_tree_contents
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com
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
2.18.0.865.gffc8e1a3cd6-goog


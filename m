Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B8F61F46C
	for <e@80x24.org>; Thu,  9 Aug 2018 22:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeHJBMm (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 21:12:42 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:43892 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbeHJBMm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 21:12:42 -0400
Received: by mail-it0-f73.google.com with SMTP id d9-v6so136904itf.8
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 15:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FMnLr3rSeQO0N8qSHqHsb6P99GRriuBXmaKY9DtoicY=;
        b=ULmvH8ADWJ0WF33JRDtVDtfF/ZLC4ksiTrmjE/sZ1loA3omcJrZrsjnWkqno3/3Ett
         SEN00YZQAJsb2xcqHsgfUuCdfZjFuPSZhwfR9KVlX++SuRr+/AHB39bu0Og5uYJydQIz
         yoRWZQS+RAXNcirxV6GmXYymd3BxU8JLLYzMasivBhRtz8jQnTzi2F7zWhX7twKvv8Ln
         qP7xY2bP6COgmzoiGJ7GMVpCW1v0lAfSt+Jk0Y5lvZyyXzJq4uUkgaVAd5giBn7gS6Je
         cjABw47bJJw42i2WIIEXIQKtVDEhscakuBzFalOkH7M+c1qpb0oN3cLUMhRX/9n3Q6PG
         xfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FMnLr3rSeQO0N8qSHqHsb6P99GRriuBXmaKY9DtoicY=;
        b=PPRFYzXGLt3ug2O1DKZ6/TQgXWEO3pki9hDtF0dxw+EYEk+MnYMvlnI5ZCfEmPQcbA
         cVDQ8auCiNj9yJmN3N2Xfzk4pHYhgJf/yi1L/rYwozmBdQ+eSenUhDk2j8+dDOdSsEx3
         H09d3b0R5V5mjxP6oEMDY8f7XpmHsBhbN7eKQuqqmCu+YNZ7AJfpF95ApC05wj4zYlW3
         7mXzoVrtyxiH9BoBfxqKiAxpYYZFkEW/aUs+4n5niuPNPGjXULGUnF2AXuETywKfYPty
         dxm+Gz/Bn4rX2uRb3GWCLQbzJ4dp6OInDH+bWTPnA+TjUidsz6TZVmzFXtDHc0l4ADSN
         vZaQ==
X-Gm-Message-State: AOUpUlGkX3hB6gPcf4KlCziQLFihfDO3ssqBW9CFt/rXgnoO8d2d+GVu
        igJFUS5V1MLqVgKeLFgwuvzEqYwYekKg2fDZlAzTYdqqf8OG4i4WAL0K8UgHd5dpGEeWzbDy+3s
        hbvvrODM1oq8U7mdXZQSO7v7AJG3/4+GkMrN9zKA7ASyU6k3eM/0f8dI2KyQ=
X-Google-Smtp-Source: AA+uWPwECAUDpVhj7zSt1LhLd80d5tISvafk888ZgEcfNsbumh8yWw69MHoBs0Z2i6FXmLgbRWG5GSiGZNzd
X-Received: by 2002:a6b:1408:: with SMTP id 8-v6mr1612725iou.81.1533854742752;
 Thu, 09 Aug 2018 15:45:42 -0700 (PDT)
Date:   Thu,  9 Aug 2018 15:45:03 -0700
In-Reply-To: <cover.1533854545.git.matvore@google.com>
Message-Id: <b3d4e955b66aa1e871ad4bfab002ca5ebbd3d972.1533854545.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 4/5] list-objects: refactor to process_tree_contents
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, jeffhost@microsoft.com,
        peff@peff.net, stefanbeller@gmail.com, jonathantanmy@google.com
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
 list-objects.c | 73 +++++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 30 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index fa34fbf58..7ecdb95ce 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -94,6 +94,48 @@ static void process_gitlink(struct traversal_context *ctx,
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
+		if (S_ISDIR(entry.mode)) {
+			struct tree *t = lookup_tree(the_repository, entry.oid);
+			t->object.flags |= NOT_USER_GIVEN;
+			process_tree(ctx, t, base, entry.path);
+		}
+		else if (S_ISGITLINK(entry.mode))
+			process_gitlink(ctx, entry.oid->hash,
+					base, entry.path);
+		else {
+			struct blob *b = lookup_blob(the_repository, entry.oid);
+			b->object.flags |= NOT_USER_GIVEN;
+			process_blob(ctx, b, base, entry.path);
+		}
+	}
+}
+
 static void process_tree(struct traversal_context *ctx,
 			 struct tree *tree,
 			 struct strbuf *base,
@@ -101,10 +143,6 @@ static void process_tree(struct traversal_context *ctx,
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
@@ -144,32 +182,7 @@ static void process_tree(struct traversal_context *ctx,
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
-		if (S_ISDIR(entry.mode)) {
-			struct tree *t = lookup_tree(the_repository, entry.oid);
-			t->object.flags |= NOT_USER_GIVEN;
-			process_tree(ctx, t, base, entry.path);
-		}
-		else if (S_ISGITLINK(entry.mode))
-			process_gitlink(ctx, entry.oid->hash,
-					base, entry.path);
-		else {
-			struct blob *b = lookup_blob(the_repository, entry.oid);
-			b->object.flags |= NOT_USER_GIVEN;
-			process_blob(ctx, b, base, entry.path);
-		}
-	}
+	process_tree_contents(ctx, tree, base);
 
 	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn) {
 		r = ctx->filter_fn(LOFS_END_TREE, obj,
-- 
2.18.0.597.ga71716f1ad-goog


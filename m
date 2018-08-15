Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE76A1F428
	for <e@80x24.org>; Wed, 15 Aug 2018 23:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeHPCRd (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 22:17:33 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:50498 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeHPCRd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 22:17:33 -0400
Received: by mail-qk0-f201.google.com with SMTP id e3-v6so2629133qkj.17
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 16:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P/XVYMYGcUwy2zeTUhBFcI0p6ZEcn9k1dB9nuLK2AC0=;
        b=IMNo6DYmDsTOJNyVl3IZ/dgGieca9YNp68U8cHLHvPIkgppy+y6ySJt4abj5zH4Mvu
         8W26gG4K4uZ9pDQ9exTKyAdxCuZ6GnngaCYKh4EufjF68Wb42qz7Cy1jcS0CsZ/NKV3/
         nzD53YsAr652d7x95+sHigzSTSDtsBuPfMuizCNPqjKxkoxCPni9Sn39PVaJGg7ZrAmN
         MY06rNjTfLd0i5a8lt6Km0yndyNJMFAmQF82eWaD58bT3dLVhAwxLO817/HIJZkSx1Le
         Yb4hWyJfcQ/j5iqyorFfYA6/d6DxE8Z9RnBP6GjNoZCWUdDzbXfoSvxv/Jwx1Jg+UVhj
         r6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P/XVYMYGcUwy2zeTUhBFcI0p6ZEcn9k1dB9nuLK2AC0=;
        b=O7wFOltVwZRSQ654OWgCO/fYcwd9kZTejcOHLFYM1XUWmpqy6aD5Rlk93SJ6QN8CEI
         AC7bnThf9uwjAn93+LBCMAjfylHtBfeWgKA8jpesJDw512bvOYcNGFQgl3cLyQikFmUx
         1Zm/66LOPSwkN4LLpd2YsR2SLYXrjrS5KkbP4AswpOz1qT0KlCmJm111k/uKsuevAzum
         SY5qxZ4aBalXBAvRrmCsusCZICq0fjueorbQXsk+n+7pywCuCErmcWBXROi5NUVOWORa
         vQn1kGV/tp27QfVi90x2mVqQvzDyIDkp3GbfEShdBbYey+GNtbrjblKdUukVO/huQk7g
         FkkQ==
X-Gm-Message-State: AOUpUlEiVXYMN3NrJXKJ8bcvFDOV4TzYLYvw4VgJE9RV93IQIFLfjGc4
        wJzwndzqaBcI42uBsCcj4Z2LS4iH81/Xz6oV6ao/g8UH4F3neQ2zYKtDHTalEIukNwP63roauRL
        1z4ei614MfOzjrIYxPNkvQlTBkzu41mJ5AJpGEbxKIvE5QDp011FdTUrRY0s=
X-Google-Smtp-Source: AA+uWPzdoVF1cnoDeWyCCiEGoAbKbwAjPV7S9HiJAzI+cnQq9TtWJoJKAN9cLcizT81DpR+efBas7Zt95Y3v
X-Received: by 2002:a0c:e745:: with SMTP id g5-v6mr14171181qvn.6.1534375391592;
 Wed, 15 Aug 2018 16:23:11 -0700 (PDT)
Date:   Wed, 15 Aug 2018 16:19:07 -0700
In-Reply-To: <cover.1534374650.git.matvore@google.com>
Message-Id: <f753322f09757bdafe62dae89fa53171956ed69e.1534374650.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1534374650.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH v6 2/6] list-objects: refactor to process_tree_contents
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, gitster@pobox.com
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


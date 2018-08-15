Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6408B1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 00:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeHODMz (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 23:12:55 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:56656 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeHODMz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 23:12:55 -0400
Received: by mail-qt0-f202.google.com with SMTP id k21-v6so16856088qtj.23
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 17:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j6P3Ym2pKObFXRRKDsmaz19mTknTWOXx1Thm/xIRDVU=;
        b=TygVS4beg3os9sik/TP1b3m2h+bHp6HA3+Gu4c21cigyMuMmM2qARb1JWYFJxIB5Jg
         AbUCT4O0wGhmFRg7axa/iaukg0ua982ZCHU9ZNKXljsp/3p+T2UjU0hTyCX48Qxemu3l
         DsdK186ljr6MEuOekPU0d5JEr34wB8lg9TlrT1QKUaN+dRSbARpVZtNI1DrYA9I7ds/X
         Bq60ez2FfhQlTkffrGwHad8MgGys4xKsZFIVTUH3pPRahIA7KRUUga7MCa4ZwSliNNE9
         JPIILj3+WEic26tEiRC6MFi3abCNESZiz3+Y0Ls6dFT2UtDVB+QXWQQs6GeaZBGxF5jh
         pwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j6P3Ym2pKObFXRRKDsmaz19mTknTWOXx1Thm/xIRDVU=;
        b=SNPJg58c2QDWWGYt4eCxl+LEDnkkGUKoSOSGFLH/QvoHtXnHF83nDZPZjLa7iKlp6O
         KGpQ/0gWQcp9nlQ57g27DP7hhHbcXpA2AkYZtqazNIXjWR1jpMLeL8I1ax+Qe9LErGR0
         1HcIsO5ezuRtHyLZfLJiuEefVBDrmRjekYWdb67+CjB3Itb1B4YiMdSkBnyr0WkcrniG
         Q5P4LRdW0DA9WaBWFa1ny3qxsJLujMBveh2wrL6lNd9rI6TvJPM+UKMZDYYNAH1uQw2l
         c5vyEJLXqTx1rXrhEcfDWRUv0kCQsJMYV2zpB1FbEO4BmEeulkF2G3jJTpfGwZt59nuh
         BsIA==
X-Gm-Message-State: AOUpUlFtQSdcYXo3NugTLUgUrZMvFXvfpq26D62OtocyzvHIFlu7o2xb
        GNQv16vifXPQercUO4WHk/oV7BWH+QMlBvWTSrKpsSox/Jia1qDRsGexCTt4gWZet6y37J8Pk1Y
        1RZpevIEnAHPbkXHy7Ro17mN6oS/C9NDnEOtbaqRBej2dgUOPEXoYTcxlpls=
X-Google-Smtp-Source: AA+uWPxT3FZuXeuQydLQSSJVOWBFflhckx40fELzRW68yFk+aDYebRVLDM9VmDdVp1sf0otZ57vMoUx879/b
X-Received: by 2002:a37:a881:: with SMTP id r123-v6mr14285398qke.5.1534292594597;
 Tue, 14 Aug 2018 17:23:14 -0700 (PDT)
Date:   Tue, 14 Aug 2018 17:22:54 -0700
In-Reply-To: <cover.1534291033.git.matvore@google.com>
Message-Id: <88556df54c5f7cdd6c0005923f0c27ab3bf3280e.1534291033.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1534291033.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH v5 5/6] revision: mark non-user-given objects instead
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

Currently, list-objects.c incorrectly treats all root trees of commits
as USER_GIVEN. Also, it would be easier to mark objects that are
non-user-given instead of user-given, since the places in the code
where we access an object through a reference are more obvious than
the places where we access an object that was given by the user.

Resolve these two problems by introducing a flag NOT_USER_GIVEN that
marks blobs and trees that are non-user-given, replacing USER_GIVEN.
(Only blobs and trees are marked because this mark is only used when
filtering objects, and filtering of other types of objects is not
supported yet.)

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects.c | 31 ++++++++++++++++++-------------
 revision.c     |  1 -
 revision.h     | 10 +++++++---
 3 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 243192af5..7a1a0929d 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -53,7 +53,7 @@ static void process_blob(struct traversal_context *ctx,
 
 	pathlen = path->len;
 	strbuf_addstr(path, name);
-	if (!(obj->flags & USER_GIVEN) && ctx->filter_fn)
+	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn)
 		r = ctx->filter_fn(LOFS_BLOB, obj,
 				   path->buf, &path->buf[pathlen],
 				   ctx->filter_data);
@@ -120,17 +120,19 @@ static void process_tree_contents(struct traversal_context *ctx,
 				continue;
 		}
 
-		if (S_ISDIR(entry.mode))
-			process_tree(ctx,
-				     lookup_tree(the_repository, entry.oid),
-				     base, entry.path);
+		if (S_ISDIR(entry.mode)) {
+			struct tree *t = lookup_tree(the_repository, entry.oid);
+			t->object.flags |= NOT_USER_GIVEN;
+			process_tree(ctx, t, base, entry.path);
+		}
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(ctx, entry.oid->hash,
 					base, entry.path);
-		else
-			process_blob(ctx,
-				     lookup_blob(the_repository, entry.oid),
-				     base, entry.path);
+		else {
+			struct blob *b = lookup_blob(the_repository, entry.oid);
+			b->object.flags |= NOT_USER_GIVEN;
+			process_blob(ctx, b, base, entry.path);
+		}
 	}
 }
 
@@ -171,7 +173,7 @@ static void process_tree(struct traversal_context *ctx,
 	}
 
 	strbuf_addstr(base, name);
-	if (!(obj->flags & USER_GIVEN) && ctx->filter_fn)
+	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn)
 		r = ctx->filter_fn(LOFS_BEGIN_TREE, obj,
 				   base->buf, &base->buf[baselen],
 				   ctx->filter_data);
@@ -185,7 +187,7 @@ static void process_tree(struct traversal_context *ctx,
 	if (!failed_parse)
 		process_tree_contents(ctx, tree, base);
 
-	if (!(obj->flags & USER_GIVEN) && ctx->filter_fn) {
+	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn) {
 		r = ctx->filter_fn(LOFS_END_TREE, obj,
 				   base->buf, &base->buf[baselen],
 				   ctx->filter_data);
@@ -301,8 +303,11 @@ static void do_traverse(struct traversal_context *ctx)
 		 * an uninteresting boundary commit may not have its tree
 		 * parsed yet, but we are not going to show them anyway
 		 */
-		if (get_commit_tree(commit))
-			add_pending_tree(ctx->revs, get_commit_tree(commit));
+		if (get_commit_tree(commit)) {
+			struct tree *tree = get_commit_tree(commit);
+			tree->object.flags |= NOT_USER_GIVEN;
+			add_pending_tree(ctx->revs, tree);
+		}
 		ctx->show_commit(commit, ctx->show_data);
 
 		if (ctx->revs->tree_blobs_in_commit_order)
diff --git a/revision.c b/revision.c
index 062749437..6d355b43c 100644
--- a/revision.c
+++ b/revision.c
@@ -175,7 +175,6 @@ static void add_pending_object_with_path(struct rev_info *revs,
 		strbuf_release(&buf);
 		return; /* do not add the commit itself */
 	}
-	obj->flags |= USER_GIVEN;
 	add_object_array_with_path(obj, name, &revs->pending, mode, path);
 }
 
diff --git a/revision.h b/revision.h
index 5118aaaa9..2d381e636 100644
--- a/revision.h
+++ b/revision.h
@@ -8,7 +8,11 @@
 #include "diff.h"
 #include "commit-slab-decl.h"
 
-/* Remember to update object flag allocation in object.h */
+/* Remember to update object flag allocation in object.h
+ * NEEDSWORK: NOT_USER_GIVEN doesn't apply to commits because we only support
+ * filtering trees and blobs, but it may be useful to support filtering commits
+ * in the future.
+ */
 #define SEEN		(1u<<0)
 #define UNINTERESTING   (1u<<1)
 #define TREESAME	(1u<<2)
@@ -20,9 +24,9 @@
 #define SYMMETRIC_LEFT	(1u<<8)
 #define PATCHSAME	(1u<<9)
 #define BOTTOM		(1u<<10)
-#define USER_GIVEN	(1u<<25) /* given directly by the user */
+#define NOT_USER_GIVEN	(1u<<25) /* tree or blob not given directly by user */
 #define TRACK_LINEAR	(1u<<26)
-#define ALL_REV_FLAGS	(((1u<<11)-1) | USER_GIVEN | TRACK_LINEAR)
+#define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR)
 
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
-- 
2.18.0.865.gffc8e1a3cd6-goog


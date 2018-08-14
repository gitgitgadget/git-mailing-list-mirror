Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C37C51F404
	for <e@80x24.org>; Tue, 14 Aug 2018 17:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389191AbeHNUR2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 16:17:28 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:44789 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388318AbeHNUR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 16:17:27 -0400
Received: by mail-ua1-f74.google.com with SMTP id d22-v6so10415441uaq.11
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 10:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f2Cmkg/D3efPn7kAVp3TmChalKI1u8GGleXOrqbjEZE=;
        b=hJlc6IdDfRfgssy136bUIfcsIy9SRDRG8oBOP7wc4Er3npGPqxz0RzTTz/69Gfonw+
         RBVD/0h5asjgAM8IqEjuvN5+1ayPE6za1X67fhvoXQwygNvRhGCzmOithXZO8djfEILk
         UAAR3o1whUzqZqYRaaqnPzPxar5WWbQ/fMnIk7h4ZU11yw5UAyggGZUmKM3cn0sJS+kz
         aFPCWL4rPbEP9YVWBjBfFM/OTiCGvee2A388sqDgPeFkixL4/Qda8FKpLhrLiJ7DW9V0
         mtryggQwzIhYON7/MZO6ocP+oxtiIwdH7rWbD5fDK+2/0ARIIJ+2X2DAxLYTKLPvOwyM
         M5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f2Cmkg/D3efPn7kAVp3TmChalKI1u8GGleXOrqbjEZE=;
        b=BpK87HXifLRj24JFqXWCpAE384Pov9n6hAPOXG/RNZuP2us7cc7d3uvttdR6BEIzlM
         guWscBrGyowtismmrwI2emwF7fyedxwZn05abSwoDkHHhN26e4y/4EEp91iCozBNVG8L
         fKy7yQWHstSnK0dkyAlpCShGj0fnH/PQ9va7jC4MMVfq+98LG1ZOlD4c04QiSeQfDmmB
         quaPgeiWz/EJyBfMw5B2CuC3zDn3oyTRCCIPNem6ffg52fd+YJe8TUZZx8d3dBd0nsX/
         kEbcFaOYw9A3etvEyPL6uTeqkNamWvCbP2cTSDBkU9l06/yoMSpYVUUCUi3T8QVey9ZH
         eFYg==
X-Gm-Message-State: AOUpUlEjuOoDARKj3vMpx5GhxlyufVWgHDxSzxRq5NfcGVnri5X1sUe1
        aYdMl0SKoamSZayWdv1yUfTf102haW47i6M43OU9btQfCSVGm5rKnr/84185O/ko4J5fMO2NKoe
        WlveXIbU3klzD74grpmF06vrtPEunJ2RrDqhoRUOMkSxNNOgm+z+uRk9MwcM=
X-Google-Smtp-Source: AA+uWPxkA8yBaTRwhbHwHupSa4ZholgeLhPxkuztfq21kbHg+8CR2oyV1JpcxriUMmRMtZPzns/rNXwIhOLs
X-Received: by 2002:a9f:300d:: with SMTP id h13-v6mr10712221uab.9.1534267760059;
 Tue, 14 Aug 2018 10:29:20 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:28:12 -0700
In-Reply-To: <cover.1534267611.git.matvore@google.com>
Message-Id: <a3284bac2d6c317347ed74d43f474b3998050fd1.1534267611.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1534267611.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH v4 5/6] revision: mark non-user-given objects instead
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
index e88474a2d..3aee1b8a4 100644
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
@@ -191,7 +193,7 @@ static void process_tree(struct traversal_context *ctx,
 	if (parsed)
 		process_tree_contents(ctx, tree, base);
 
-	if (!(obj->flags & USER_GIVEN) && ctx->filter_fn) {
+	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn) {
 		r = ctx->filter_fn(LOFS_END_TREE, obj,
 				   base->buf, &base->buf[baselen],
 				   ctx->filter_data);
@@ -307,8 +309,11 @@ static void do_traverse(struct traversal_context *ctx)
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
index c94243543..55d47004d 100644
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


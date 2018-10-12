Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65AC1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 20:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeJMDgx (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 23:36:53 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:59890 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeJMDgx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 23:36:53 -0400
Received: by mail-it1-f202.google.com with SMTP id e197-v6so14261715ita.9
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 13:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7ZVc1HLBJ0JKDdjqU7X8AloTo5WMg8dUz7dk+UOq41A=;
        b=VKOL9cJ7OThExV87IFIkqdovjUejxtyU8QoYajL3FigT/O7scPU2ETlC78VFMWNXZp
         G7zvfAkLm2XEtFEqePmU58OwyrU8bFaNUjHOuNKuxymuHSN5N6IIj2GZUqrzNnatZrG0
         RMSncpEQHp+qjHfnJKBrvyUlk5bJb+iiSSmljrtCpw9WpQj8zE5K9n5wFrDcJA5zfvTV
         eLApzG9fHsOITlrNaM2Eaok0Z0cxK34qS3qPDVsObu+p+yuYOJi/xXQw+mmDUNzdJIU7
         z2oT8/PCMPkEGRNxJut9vBtf7BbIMRU6MwxKBLeY9DGjznD25XznwNgyydmmDOc9eN6L
         GDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7ZVc1HLBJ0JKDdjqU7X8AloTo5WMg8dUz7dk+UOq41A=;
        b=WkMO241ukTsNZ13xihtZQZY4axkfq2B4430pDHveCwCcvc0xnnuhkwMdTT1qYoS+Dc
         AqdIlWkfP+Sp1SI/aiI4tLQVIzpF2fDhlW4PkjK4FXEDEmokCrePyXFvajSwpJ2asYWQ
         mPhs1pvYHGqf/RBAawCmRM5cYxoTwfthy+g7/W4VLs/jktLZc04tSQHq53KIkFjeeShF
         Ma86CLERxUwIW7HNaPTsdtMkERTLYRDw85bJ3salg3n0Spy8/lTXtyY59hw/lP8/rnlj
         4wQmYApwzVtjH1GHyHXxbvA7l54bzsse5TqHliZxPKXehIt9HL2l9VlF8eKZtITyB+zc
         TsUg==
X-Gm-Message-State: ABuFfojPqKwAkGOIREHRHPRA+OMJV0QAggJBxYCc1giIeRC+gldpgcrv
        V78ng50dhn39T9SuWQjSfSgpfqNWM2YTTFo5uFJS2atXFhzC8HR4zuml52rA1dbzu9+DElKpbNT
        FvBpxUTH6wFu7NZqYaE69qkFcjJ+uYnqJhiH19BGb6Dv9D8wm+KX/5ierZAw=
X-Google-Smtp-Source: ACcGV60uT+EyTBuHk6YJBm2R4zm0FiUt6xJpywkv1QluJFJVINxVSAg4q2rrierMu0UcfeBcsu86VqJIy5Qi
X-Received: by 2002:a24:75c9:: with SMTP id y192-v6mr6158256itc.13.1539374565306;
 Fri, 12 Oct 2018 13:02:45 -0700 (PDT)
Date:   Fri, 12 Oct 2018 13:01:46 -0700
In-Reply-To: <cover.1539373969.git.matvore@google.com>
Message-Id: <38f39b252e2c0bbb7a9b48eba67849c92bb1f24b.1539373969.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1539373969.git.matvore@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [PATCH v12 5/8] revision: mark non-user-given objects instead
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

This fixes a bug in that git rev-list behaved differently from git
pack-objects. pack-objects would *not* filter objects given explicitly
on the command line and rev-list would filter. This was because the two
commands used a different function to add objects to the rev_info
struct. This seems to have been an oversight, and pack-objects has the
correct behavior, so I added a test to make sure that rev-list now
behaves properly.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects.c                      | 31 +++++++++++++++++------------
 revision.c                          |  1 -
 revision.h                          | 11 ++++++++--
 t/t6112-rev-list-filters-objects.sh | 12 +++++++++++
 4 files changed, 39 insertions(+), 16 deletions(-)

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
index de4dce600..72d48a17f 100644
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
index 5910613cb..83e164039 100644
--- a/revision.h
+++ b/revision.h
@@ -21,9 +21,16 @@
 #define SYMMETRIC_LEFT	(1u<<8)
 #define PATCHSAME	(1u<<9)
 #define BOTTOM		(1u<<10)
-#define USER_GIVEN	(1u<<25) /* given directly by the user */
+/*
+ * Indicates object was reached by traversal. i.e. not given by user on
+ * command-line or stdin.
+ * NEEDSWORK: NOT_USER_GIVEN doesn't apply to commits because we only support
+ * filtering trees and blobs, but it may be useful to support filtering commits
+ * in the future.
+ */
+#define NOT_USER_GIVEN	(1u<<25)
 #define TRACK_LINEAR	(1u<<26)
-#define ALL_REV_FLAGS	(((1u<<11)-1) | USER_GIVEN | TRACK_LINEAR)
+#define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR)
 
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index efe5a2467..110d4f74d 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -30,6 +30,18 @@ test_expect_success 'verify blob:none omits all 5 blobs' '
 	test_cmp observed expected
 '
 
+test_expect_success 'specify blob explicitly prevents filtering' '
+	file_3=$(git -C r1 ls-files -s file.3 |
+		 awk -f print_2.awk) &&
+
+	file_4=$(git -C r1 ls-files -s file.4 |
+		 awk -f print_2.awk) &&
+
+	git -C r1 rev-list --objects --filter=blob:none HEAD $file_3 >observed &&
+	grep "$file_3" observed &&
+	! grep "$file_4" observed
+'
+
 test_expect_success 'verify emitted+omitted == all' '
 	git -C r1 rev-list HEAD --objects \
 		| awk -f print_1.awk \
-- 
2.19.1.331.ge82ca0e54c-goog


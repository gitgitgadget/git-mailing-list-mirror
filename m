Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB1881F405
	for <e@80x24.org>; Thu,  9 Aug 2018 22:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeHJBMp (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 21:12:45 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:49642 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbeHJBMp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 21:12:45 -0400
Received: by mail-qk0-f202.google.com with SMTP id a70-v6so7302791qkb.16
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 15:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=598nLBtORhWErX7jVas9LRmQmfVjwyYWM/GTkTC2FOs=;
        b=Cfvkl72q/fkXYkAZo5phAw6ucv144hi2hy0fWa8RCNu3Y+mnTTCUQdewwR3QeRdAkR
         XEucNBQYnClA9Pks0k8/1lsqMWwKEqinqOHlFa+KVpAVdQ5I16CQQVxYMaW7swqx8LdV
         iNNh3THFXF+z4CBinpS/swPTy6pXCkWbGP2vu1O54fk/Y8LJ4l3tCy6/GUCZ+3NEtz6E
         ws3U6ZViyxCApBzTaiJCT1SmbFTSxcI+2Q6xU7l6CFCy+zV/YrfvcyuJVGqpi4xWGhbj
         Bu1QiFBw+hB/evVXnvN8PHPYALf/6Nqhj86f9vvCq2W1h73Y+RgwV+j+TGoIKD1HTvHU
         PnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=598nLBtORhWErX7jVas9LRmQmfVjwyYWM/GTkTC2FOs=;
        b=ln0mDTZlAZPDjQYUbw5HR+FuDJrqI+zBfwk/HxK76Xgl32i6OaBLv8E/I8p/RMbkU4
         4komzNlI/srUwbl8yHFFU7dC24GmZyoNfHmFEyu+ZshMwS9EuChnpN0U9d/SnbMMC2G2
         3BRl4I2UXE27A/w6QM7xVn9cbwer911HgPI+ezGO4BXEOdrncShJCd4JXDc29Hq/cD6W
         ATj/mmkBLpjQbSNqZp5+mOy4ntUxkG4bViV5rJyWy3X6mnT6DNhi+ymniuucfs9x2iyA
         pM2IvT+vTy4VlNLeRk+hai3LbsTlxwqFVF5Zk3seVCJ8srhzBJwfFYjZ3dSDEdb5A7uZ
         E9TQ==
X-Gm-Message-State: AOUpUlGTiOia6F1patyTCNudIU9KdKCkrFJ5WhkHfaSoAlyuheWsGYIW
        JBGxW29lSeDLQru8I+qC8fvf/cFRkB9S202XLuNlIwoNHAQOtuaNYEunUb+SJ3Lk1fEfoW7MUIZ
        Ac1UaMduhHSh30RKs6tTA3itBXBbjIdhMVxliZ4/GnfTHcEnbAFTTMZ0t/ro=
X-Google-Smtp-Source: AA+uWPxoUb+hXGi+HQHCPljduwvLoyZb9l3xoypfWYRztnfVJtvmqvtDs08Yu5v98b2niP21ttJF1SEaJCgQ
X-Received: by 2002:a0c:99c1:: with SMTP id y1-v6mr2082946qve.15.1533854745307;
 Thu, 09 Aug 2018 15:45:45 -0700 (PDT)
Date:   Thu,  9 Aug 2018 15:45:04 -0700
In-Reply-To: <cover.1533854545.git.matvore@google.com>
Message-Id: <54d827e7c0dc757451fa10f5bd0752e1e3356281.1533854545.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 5/5] rev-list: handle missing tree objects properly
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, jeffhost@microsoft.com,
        peff@peff.net, stefanbeller@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, we assumed only blob objects could be missing. This patch
makes rev-list handle missing trees like missing blobs. A missing tree
will cause an error if --missing indicates an error should be caused,
and the hash is printed even if the tree is missing.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 builtin/rev-list.c       | 12 ++++++++----
 list-objects.c           |  8 ++++++--
 revision.h               |  1 +
 t/t5616-partial-clone.sh | 27 +++++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 5b07f3f4a..c870d4fe6 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -6,6 +6,7 @@
 #include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
+#include "object.h"
 #include "object-store.h"
 #include "pack.h"
 #include "pack-bitmap.h"
@@ -209,7 +210,8 @@ static inline void finish_object__ma(struct object *obj)
 	 */
 	switch (arg_missing_action) {
 	case MA_ERROR:
-		die("missing blob object '%s'", oid_to_hex(&obj->oid));
+		die("missing %s object '%s'",
+		    type_name(obj->type), oid_to_hex(&obj->oid));
 		return;
 
 	case MA_ALLOW_ANY:
@@ -222,8 +224,8 @@ static inline void finish_object__ma(struct object *obj)
 	case MA_ALLOW_PROMISOR:
 		if (is_promisor_object(&obj->oid))
 			return;
-		die("unexpected missing blob object '%s'",
-		    oid_to_hex(&obj->oid));
+		die("unexpected missing %s object '%s'",
+		    type_name(obj->type), oid_to_hex(&obj->oid));
 		return;
 
 	default:
@@ -235,7 +237,7 @@ static inline void finish_object__ma(struct object *obj)
 static int finish_object(struct object *obj, const char *name, void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
-	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid)) {
+	if (!has_object_file(&obj->oid)) {
 		finish_object__ma(obj);
 		return 1;
 	}
@@ -373,6 +375,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	init_revisions(&revs, prefix);
 	revs.abbrev = DEFAULT_ABBREV;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
+	revs.show_missing_trees = 1;
 
 	/*
 	 * Scan the argument list before invoking setup_revisions(), so that we
@@ -389,6 +392,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		if (!strcmp(arg, "--exclude-promisor-objects")) {
 			fetch_if_missing = 0;
 			revs.exclude_promisor_objects = 1;
+			revs.show_missing_trees = 0;
 			break;
 		}
 	}
diff --git a/list-objects.c b/list-objects.c
index 7ecdb95ce..b0291c45a 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -146,7 +146,9 @@ static void process_tree(struct traversal_context *ctx,
 	int baselen = base->len;
 	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
 	int gently = revs->ignore_missing_links ||
+		     revs->show_missing_trees ||
 		     revs->exclude_promisor_objects;
+	int parse_result;
 
 	if (!revs->tree_objects)
 		return;
@@ -154,7 +156,8 @@ static void process_tree(struct traversal_context *ctx,
 		die("bad tree object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
-	if (parse_tree_gently(tree, gently) < 0) {
+	parse_result = parse_tree_gently(tree, gently);
+	if (parse_result < 0 && !revs->show_missing_trees) {
 		if (revs->ignore_missing_links)
 			return;
 
@@ -182,7 +185,8 @@ static void process_tree(struct traversal_context *ctx,
 	if (base->len)
 		strbuf_addch(base, '/');
 
-	process_tree_contents(ctx, tree, base);
+	if (parse_result >= 0)
+		process_tree_contents(ctx, tree, base);
 
 	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn) {
 		r = ctx->filter_fn(LOFS_END_TREE, obj,
diff --git a/revision.h b/revision.h
index cd6b62313..34ff99f05 100644
--- a/revision.h
+++ b/revision.h
@@ -128,6 +128,7 @@ struct rev_info {
 			first_parent_only:1,
 			line_level_traverse:1,
 			tree_blobs_in_commit_order:1,
+			show_missing_trees:1,
 
 			/* for internal use only */
 			exclude_promisor_objects:1;
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index bbbe7537d..8a0ca0a74 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -170,6 +170,33 @@ test_expect_success 'partial clone fetches blobs pointed to by refs even if norm
 	git -C dst fsck
 '
 
+test_expect_success 'can use only:commits to filter partial clone' '
+	rm -rf dst &&
+	git clone --no-checkout --filter=only:commits "file://$(pwd)/srv.bare" dst &&
+	git -C dst rev-list master --missing=allow-any --objects >fetched_objects &&
+	cat fetched_objects \
+		| awk -f print_1.awk \
+		| xargs -n1 git -C dst cat-file -t >fetched_types &&
+	sort fetched_types -u >unique_types.observed &&
+	echo commit > unique_types.expected &&
+	test_cmp unique_types.observed unique_types.expected
+'
+
+test_expect_success 'show missing tree objects with --missing=print' '
+	git -C dst rev-list master --missing=print --quiet --objects >missing_objs &&
+	sed "s/?//" missing_objs \
+		| xargs -n1 git -C srv.bare cat-file -t \
+		>missing_types &&
+	sort -u missing_types >missing_types.uniq &&
+	echo tree >expected &&
+	test_cmp missing_types.uniq expected
+'
+
+test_expect_success 'do not complain when a missing tree cannot be parsed' '
+	git -C dst rev-list master --missing=print --quiet --objects 2>rev_list_err >&2 &&
+	! grep -q "Could not read " rev_list_err
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.18.0.597.ga71716f1ad-goog


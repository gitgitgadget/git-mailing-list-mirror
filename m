Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE8AA1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 20:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeJMDgo (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 23:36:44 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:51480 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeJMDgo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 23:36:44 -0400
Received: by mail-yb1-f202.google.com with SMTP id o2-v6so6715414ybq.18
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 13:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lzAa4JA9bOzz5PyllZP6AdPWZBX01s19lhHCSHYEy/8=;
        b=ckPoxPUB8oeOz+LVSxH0ekwy/uXpcAdCY6LHH1TRQjA7POalncQMnmXSIwp9oYqTLv
         xDXTQu8kNmR2nSNx736bqJs1rMrP0La1FBzMeyynqT4G2D12OztzZBpIlKdt0YDKH73h
         aqq8GAwswNyup4kXP9yym4XZ8vQ9+TG165ZQQbZYWbyR33mQ7+7XMLA4urJOsxNBKpsz
         DbA3CyMmqtwp/WxflzfG8qMtqEUQaK4hPcfHVyBJ8QSDHGbPAjkvYO565t2J07mGqjHL
         fbjCpT8cmI3SEWH2aBTMOSs1F7pigxD4USPccDKUS+Oma77BUcfHSqlHzD2VTD3AC4n/
         T4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lzAa4JA9bOzz5PyllZP6AdPWZBX01s19lhHCSHYEy/8=;
        b=aEz5QbI/Y8fdIhsyZgfQ6Pz2ziL8zt1U8Buo8dzmMx1CvyfHCOABE5cdy3ZkJv0H3d
         g0kXnk1wc6sEBCzYYUN5Wqvj3gk3f3CPSWdLNuz/ayZsxXNCZiG9Cv8k7S9QNXC9a2XO
         czYTgx76l3bVcaTOGiqo7mjsro2esDtsv/Fd8BB6Vo1VHZgQslLzYjINp39PRmkBUupY
         U1BUOvyDnt7vWvFJhmQzmTBaKDBvkzJe0azVZJfeG4uOqcubRTO5ljUC2+Ul+HkKIOyu
         5aj0+Sz6JcxNrdbG+mvasOpYSpGsUspwolS8IqsPQnS1u2i6tB3dQcjGwhcr26UmqRVh
         Xj7g==
X-Gm-Message-State: ABuFfohmwQtdOOq1nv9ATjKYcvwaKZlItiot6yXrUvqifVJYk43dyepS
        wrLIjm75fW/Vv7fOUPOdgS5Xr5HKAikyhq4aCRVO45PljCV/2cmTnbCEtZeSkvx1M6AkK9+wtSO
        kMaWPNVE1TmVhzPws630G4mxCXZrZ5Itk2y9W1864t+yU3kLx5Nbtghfei64=
X-Google-Smtp-Source: ACcGV639WAWjyHYFAhXPbjTo7NTGMHoAQIGyiYKCnFDDWU31n0Z/oI/Qh43xqKQ2OEV6WfB3Uf1c9HIeLj7X
X-Received: by 2002:a25:70c6:: with SMTP id l189-v6mr4395779ybc.5.1539374556367;
 Fri, 12 Oct 2018 13:02:36 -0700 (PDT)
Date:   Fri, 12 Oct 2018 13:01:45 -0700
In-Reply-To: <cover.1539373969.git.matvore@google.com>
Message-Id: <59856878ed196240db1365013d1822032ea66b83.1539373969.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1539373969.git.matvore@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [PATCH v12 4/8] rev-list: handle missing tree objects properly
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

Previously, we assumed only blob objects could be missing. This patch
makes rev-list handle missing trees like missing blobs. The --missing=*
and --exclude-promisor-objects flags now work for trees as they already
do for blobs. This is demonstrated in t6112.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 builtin/rev-list.c                     | 11 ++++---
 list-objects.c                         | 11 +++++--
 revision.h                             | 15 +++++++++
 t/t0410-partial-clone.sh               | 45 ++++++++++++++++++++++++++
 t/t5317-pack-objects-filter-objects.sh | 13 ++++++++
 t/t6112-rev-list-filters-objects.sh    | 22 +++++++++++++
 6 files changed, 110 insertions(+), 7 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 5b07f3f4a..49d6deed7 100644
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
+	revs.do_not_die_on_missing_tree = 1;
 
 	/*
 	 * Scan the argument list before invoking setup_revisions(), so that we
diff --git a/list-objects.c b/list-objects.c
index f9b51db7a..243192af5 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -143,6 +143,7 @@ static void process_tree(struct traversal_context *ctx,
 	struct rev_info *revs = ctx->revs;
 	int baselen = base->len;
 	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
+	int failed_parse;
 
 	if (!revs->tree_objects)
 		return;
@@ -150,7 +151,9 @@ static void process_tree(struct traversal_context *ctx,
 		die("bad tree object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
-	if (parse_tree_gently(tree, 1) < 0) {
+
+	failed_parse = parse_tree_gently(tree, 1);
+	if (failed_parse) {
 		if (revs->ignore_missing_links)
 			return;
 
@@ -163,7 +166,8 @@ static void process_tree(struct traversal_context *ctx,
 		    is_promisor_object(&obj->oid))
 			return;
 
-		die("bad tree object %s", oid_to_hex(&obj->oid));
+		if (!revs->do_not_die_on_missing_tree)
+			die("bad tree object %s", oid_to_hex(&obj->oid));
 	}
 
 	strbuf_addstr(base, name);
@@ -178,7 +182,8 @@ static void process_tree(struct traversal_context *ctx,
 	if (base->len)
 		strbuf_addch(base, '/');
 
-	process_tree_contents(ctx, tree, base);
+	if (!failed_parse)
+		process_tree_contents(ctx, tree, base);
 
 	if (!(obj->flags & USER_GIVEN) && ctx->filter_fn) {
 		r = ctx->filter_fn(LOFS_END_TREE, obj,
diff --git a/revision.h b/revision.h
index 007278cc1..5910613cb 100644
--- a/revision.h
+++ b/revision.h
@@ -126,6 +126,21 @@ struct rev_info {
 			line_level_traverse:1,
 			tree_blobs_in_commit_order:1,
 
+			/*
+			 * Blobs are shown without regard for their existence.
+			 * But not so for trees: unless exclude_promisor_objects
+			 * is set and the tree in question is a promisor object;
+			 * OR ignore_missing_links is set, the revision walker
+			 * dies with a "bad tree object HASH" message when
+			 * encountering a missing tree. For callers that can
+			 * handle missing trees and want them to be filterable
+			 * and showable, set this to true. The revision walker
+			 * will filter and show such a missing tree as usual,
+			 * but will not attempt to recurse into this tree
+			 * object.
+			 */
+			do_not_die_on_missing_tree:1,
+
 			/* for internal use only */
 			exclude_promisor_objects:1;
 
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 128130066..5bc5b4445 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -186,6 +186,51 @@ test_expect_success 'rev-list stops traversal at missing and promised commit' '
 	! grep $FOO out
 '
 
+test_expect_success 'missing tree objects with --missing=allow-promisor and --exclude-promisor-objects' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo foo &&
+	test_commit -C repo bar &&
+	test_commit -C repo baz &&
+
+	promise_and_delete $(git -C repo rev-parse bar^{tree}) &&
+	promise_and_delete $(git -C repo rev-parse foo^{tree}) &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+
+	git -C repo rev-list --missing=allow-promisor --objects HEAD >objs 2>rev_list_err &&
+	test_must_be_empty rev_list_err &&
+	# 3 commits, 3 blobs, and 1 tree
+	test_line_count = 7 objs &&
+
+	# Do the same for --exclude-promisor-objects, but with all trees gone.
+	promise_and_delete $(git -C repo rev-parse baz^{tree}) &&
+	git -C repo rev-list --exclude-promisor-objects --objects HEAD >objs 2>rev_list_err &&
+	test_must_be_empty rev_list_err &&
+	# 3 commits, no blobs or trees
+	test_line_count = 3 objs
+'
+
+test_expect_success 'missing non-root tree object and rev-list' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	mkdir repo/dir &&
+	echo foo >repo/dir/foo &&
+	git -C repo add dir/foo &&
+	git -C repo commit -m "commit dir/foo" &&
+
+	promise_and_delete $(git -C repo rev-parse HEAD:dir) &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+
+	git -C repo rev-list --missing=allow-any --objects HEAD >objs 2>rev_list_err &&
+	test_must_be_empty rev_list_err &&
+	# 1 commit and 1 tree
+	test_line_count = 2 objs
+'
+
 test_expect_success 'rev-list stops traversal at missing and promised tree' '
 	rm -rf repo &&
 	test_create_repo repo &&
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 6710c8bc8..ba83f3829 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -59,6 +59,19 @@ test_expect_success 'verify normal and blob:none packfiles have same commits/tre
 	test_cmp observed expected
 '
 
+test_expect_success 'get an error for missing tree object' '
+	git init r5 &&
+	echo foo >r5/foo &&
+	git -C r5 add foo &&
+	git -C r5 commit -m "foo" &&
+	del=$(git -C r5 rev-parse HEAD^{tree} | sed "s|..|&/|") &&
+	rm r5/.git/objects/$del &&
+	test_must_fail git -C r5 pack-objects --rev --stdout 2>bad_tree <<-EOF &&
+	HEAD
+	EOF
+	grep "bad tree object" bad_tree
+'
+
 # Test blob:limit=<n>[kmg] filter.
 # We boundary test around the size parameter.  The filter is strictly less than
 # the value, so size 500 and 1000 should have the same results, but 1001 should
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index d4ff0b3be..efe5a2467 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -195,6 +195,28 @@ test_expect_success 'verify sparse:oid=oid-ish omits top-level files' '
 	test_cmp observed expected
 '
 
+test_expect_success 'rev-list W/ --missing=print and --missing=allow-any for trees' '
+	TREE=$(git -C r3 rev-parse HEAD:dir1) &&
+
+	# Create a spare repo because we will be deleting objects from this one.
+	git clone r3 r3.b &&
+
+	rm r3.b/.git/objects/$(echo $TREE | sed "s|^..|&/|") &&
+
+	git -C r3.b rev-list --quiet --missing=print --objects HEAD \
+		>missing_objs 2>rev_list_err &&
+	echo "?$TREE" >expected &&
+	test_cmp expected missing_objs &&
+
+	# do not complain when a missing tree cannot be parsed
+	test_must_be_empty rev_list_err &&
+
+	git -C r3.b rev-list --missing=allow-any --objects HEAD \
+		>objs 2>rev_list_err &&
+	! grep $TREE objs &&
+	test_must_be_empty rev_list_err
+'
+
 # Delete some loose objects and use rev-list, but WITHOUT any filtering.
 # This models previously omitted objects that we did not receive.
 
-- 
2.19.1.331.ge82ca0e54c-goog


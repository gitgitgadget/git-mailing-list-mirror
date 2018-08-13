Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2923E1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 18:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbeHMU6U (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 16:58:20 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:52245 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729753AbeHMU6T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 16:58:19 -0400
Received: by mail-qt0-f201.google.com with SMTP id g7-v6so13886239qtp.19
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 11:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=25N9ezxZsp1mGdtCRz0BWwCTx7gA0Q4TAHWl4bf/YGM=;
        b=sBn/CjXIIaFxHP+3LL3plaJTRrWTTe39YynlLcapJTbMtznvkjGNqDNu3ZMC4KcIGo
         KFlL5L2YaEoAcMibmULGU+YNmv1yS2J7xmYx4/vQcZN+Zq7pDTe5KHDL754fac9LBM2p
         dVAh85UnIkt2DMEaWXIGCaw8ONBMBXrvvEOK7Q2xTLqVJqZsgBfWHJ1JecuUDdOG2Emv
         q8GVjOi5v6jpok3Us+vE0A/XQew8tfqBqo+2f6YEAq4Zy/gnS1ty/GeMUJJUua+u93yi
         KN9rOoikZl68tfv8/XSINXKLkbuEtJ7wBNevzKMiSqD2o8847y7yPO3gOY27G7t7q6nN
         S9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=25N9ezxZsp1mGdtCRz0BWwCTx7gA0Q4TAHWl4bf/YGM=;
        b=pTAE22U+DOkt7q3nwBa/XiEaW9p1ML73wSNvByG+clKJ6MmEPuUhi7Ml4mA6J+xu/m
         VkRSmKtQ1hnFU3p0DjZFKei21ty3LZypv6S447fLEMOXKDhs+LYsT39DXkbWAokSY8o6
         sGrDHJ/kCSi/uwW/Xm5x1/QCTu9NQXuhMylyQDLk7coDMTa/gtp0R0xunvgK0sYL7hdc
         NPs8YRxtiUzkR3NlOaYPSKRpwIXXLYw2nXVgoCmkVE1e7CyOCgH7D5tOQFxhTMjCxJ17
         hn7+dizk+7Vzl/V2529o5ZF7IZR++r0CWoIIx7v4oh2zjPXsmJK9ORVssj3w6NvqQFQK
         BEkg==
X-Gm-Message-State: AOUpUlH/GyD71Xw05Pvkp/xlHtNCw4le6crbktCu1JTdm4/pJ7NzWXi2
        CXGyqpWszD4EF/mWfb7jGWkQgAUptB8xVs8GMoJI+UiVQnmLYuwv+y0X13YRsdDcNHU6rp2zgSj
        f8rcJGBVwm9Va7JMjEBI4DVZ8l1KXFJNNL+sWHaHhAzwXTtmm3ge/iZ9DXcg=
X-Google-Smtp-Source: AA+uWPwuqUiRpAiTEfnqw6+rBsRZVt4Boj76ejBv5SH5ODcfvkRCUfp8HF9DTsx6Tab2YrfmE1RGGfrXZI4V
X-Received: by 2002:a37:360a:: with SMTP id d10-v6mr11370197qka.0.1534184099325;
 Mon, 13 Aug 2018 11:14:59 -0700 (PDT)
Date:   Mon, 13 Aug 2018 11:14:30 -0700
In-Reply-To: <cover.1534183648.git.matvore@google.com>
Message-Id: <6d6b06e870b5d6dbe9bb88bd80fcce34ba4dcccf.1534183648.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1534183648.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH v3 3/5] rev-list: handle missing tree objects properly
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

Previously, we assumed only blob objects could be missing. This patch
makes rev-list handle missing trees like missing blobs. A missing tree
will cause an error if --missing indicates an error should be caused,
and the hash is printed even if the tree is missing.

In list-objects.c we no longer print a message to stderr if a tree
object is missing (quiet_on_missing is always true). I couldn't find
any place where this would matter, or where the caller of
traverse_commit_list would need to be fixed to show the error. However,
in the future it would be trivial to make the caller show the message if
we needed to.

This is not tested very thoroughly, since we cannot create promisor
objects in tests without using an actual partial clone. t0410 has a
promise_and_delete utility function, but the is_promisor_object function
does not return 1 for objects deleted in this way. More tests will will
come in a patch that implements a filter that can be used with git
clone.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 builtin/rev-list.c                     | 10 ++++++----
 list-objects.c                         | 17 +++++++++--------
 t/t5317-pack-objects-filter-objects.sh | 13 +++++++++++++
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 5b07f3f4a..ea0daf0c4 100644
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
diff --git a/list-objects.c b/list-objects.c
index ccc529e5e..aedcd0228 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -143,8 +143,7 @@ static void process_tree(struct traversal_context *ctx,
 	struct rev_info *revs = ctx->revs;
 	int baselen = base->len;
 	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
-	int gently = revs->ignore_missing_links ||
-		     revs->exclude_promisor_objects;
+	int parsed;
 
 	if (!revs->tree_objects)
 		return;
@@ -152,20 +151,21 @@ static void process_tree(struct traversal_context *ctx,
 		die("bad tree object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
-	if (parse_tree_gently(tree, gently) < 0) {
+	parsed = parse_tree_gently(tree, /*quiet_on_missing=*/1) >= 0;
+	if (!parsed) {
 		if (revs->ignore_missing_links)
 			return;
 
+		if (!is_promisor_object(&obj->oid))
+			die("bad tree object %s", oid_to_hex(&obj->oid));
+
 		/*
 		 * Pre-filter known-missing tree objects when explicitly
 		 * requested.  This may cause the actual filter to report
 		 * an incomplete list of missing objects.
 		 */
-		if (revs->exclude_promisor_objects &&
-		    is_promisor_object(&obj->oid))
+		if (revs->exclude_promisor_objects)
 			return;
-
-		die("bad tree object %s", oid_to_hex(&obj->oid));
 	}
 
 	strbuf_addstr(base, name);
@@ -180,7 +180,8 @@ static void process_tree(struct traversal_context *ctx,
 	if (base->len)
 		strbuf_addch(base, '/');
 
-	process_tree_contents(ctx, tree, base);
+	if (parsed)
+		process_tree_contents(ctx, tree, base);
 
 	if (!(obj->flags & USER_GIVEN) && ctx->filter_fn) {
 		r = ctx->filter_fn(LOFS_END_TREE, obj,
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 6710c8bc8..5e35f33bf 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -59,6 +59,19 @@ test_expect_success 'verify normal and blob:none packfiles have same commits/tre
 	test_cmp observed expected
 '
 
+test_expect_success 'get an error for missing tree object' '
+	git init r5 &&
+	echo foo > r5/foo &&
+	git -C r5 add foo &&
+	git -C r5 commit -m "foo" &&
+	del=$(git -C r5 rev-parse HEAD^{tree} | sed "s|..|&/|") &&
+	rm r5/.git/objects/$del &&
+	test_must_fail git -C r5 pack-objects --rev --stdout 2>bad_tree <<-EOF &&
+	HEAD
+	EOF
+	grep -q "bad tree object" bad_tree
+'
+
 # Test blob:limit=<n>[kmg] filter.
 # We boundary test around the size parameter.  The filter is strictly less than
 # the value, so size 500 and 1000 should have the same results, but 1001 should
-- 
2.18.0.597.ga71716f1ad-goog


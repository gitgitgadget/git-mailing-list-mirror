Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A49B1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 00:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeJRIhp (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 04:37:45 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:48970 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeJRIhp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 04:37:45 -0400
Received: by mail-ot1-f73.google.com with SMTP id 30so8959279ota.15
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 17:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xe0jIQOpCK/+/1JjbB3j8YknbFgcn9Oa626+HPK48QI=;
        b=dt24qgPR6F5H/MFrjw9XP08xh+3H33+b6ILwd4RksGYZ77a/nWlYeRLcvwTpXFknrD
         9R3g7WvI+FxSo3cu8ilVPG13D9bGlev75zvRsNC8zcsAN0mTwM44+MXkR/FAVZDG4FO2
         MnXZJWLygErfElsYEaMaaxy3qn0LOtSSVRnm52O0T7MNN1hlymCXVVgU0bAisX/JT9gX
         1rmxgSClc1L1yRJl/jewwCXkP+zCe+EtMe2ae7rXO745KHhPQ8tpmFzXDq4QxTylJKCZ
         Pp8JAYL2OmczAjh9bDLTfMONRtwK66EN3mPULtJAs2FcA15NY2eyOqQHEM6PF1GnDW1x
         elRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xe0jIQOpCK/+/1JjbB3j8YknbFgcn9Oa626+HPK48QI=;
        b=XVVvrk2ob9v/ysgLcf3ENgYScACYvzKwdq3hLIU4gqSGW356jgKnu4r3yGb07pOmEI
         AcJ9rKxBYLQufFCk5xTTQarhKHHdsvjWyQcedFeDcSpaEmtBvLlgjQ6q4pFwo/+rDmU7
         wbie3qPgW38acSWg0ovXdnteCu9Iuq3aSHCQJ5cBw8Qw/oOtzixA/z85AbIcfKBYg/e+
         CmGcHVQSQcjyUAYES11w9gPmJryac2rmD2WLHBKH1eCKxcoLLR+ZaVsIwAgv3XGuktEb
         pHeKOsZrIpfirf6iENivpryVPaBj17rDTo2tzHr5c+pJAHc/Vrd+Sxx9qyAj1paqTZjc
         bh9A==
X-Gm-Message-State: ABuFfohi+N0UBRhYCcG+HfJ9kGoyKKMHxrZf6seu8t0ehtR3vmhwzCyF
        rQsjtuGN7pLayrln45Q4pXfdgHvJafb5i3RHMRgs78C1F8K2vWvazwIA7dNb9n8T7lwzpSS8wLn
        JKalZX95U8blU2dpUHIgY2bKmYHMsU4ojIjV9ccGphMeqZ49Q0web+EwSPcY=
X-Google-Smtp-Source: ACcGV63ZbjXgiKa08XY62tCUdnYw4kM+oqSaKTzMMTLozC91RmXn7PZPu98RUiHrQzF7QyHpN0lzu1Uhytvf
X-Received: by 2002:a9d:2625:: with SMTP id a34mr23493744otb.62.1539823167622;
 Wed, 17 Oct 2018 17:39:27 -0700 (PDT)
Date:   Wed, 17 Oct 2018 17:39:15 -0700
Message-Id: <20181018003915.60237-1-matvore@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH v2] list-objects: support for skipping tree traversal
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, peff@peff.net,
        jonathantanmy@google.com, gitster@pobox.com, jrn@google.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tree:0 filter does not need to traverse the trees that it has
filtered out, so optimize list-objects and list-objects-filter to skip
traversing the trees entirely. Before this patch, we iterated over all
children of the tree, and did nothing for all of them, which was
wasteful.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter.c               | 11 +++++++++--
 list-objects-filter.h               |  6 ++++++
 list-objects.c                      |  5 ++++-
 t/t6112-rev-list-filters-objects.sh | 13 +++++++++++++
 4 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index 09b2b05d54..765f3df3b0 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -102,9 +102,16 @@ static enum list_objects_filter_result filter_trees_none(
 
 	case LOFS_BEGIN_TREE:
 	case LOFS_BLOB:
-		if (filter_data->omits)
+		if (filter_data->omits) {
 			oidset_insert(filter_data->omits, &obj->oid);
-		return LOFR_MARK_SEEN; /* but not LOFR_DO_SHOW (hard omit) */
+			/* _MARK_SEEN but not _DO_SHOW (hard omit) */
+			return LOFR_MARK_SEEN;
+		} else {
+			/*
+			 * Not collecting omits so no need to to traverse tree.
+			 */
+			return LOFR_SKIP_TREE | LOFR_MARK_SEEN;
+		}
 
 	case LOFS_END_TREE:
 		assert(obj->type == OBJ_TREE);
diff --git a/list-objects-filter.h b/list-objects-filter.h
index a6f6b4990b..52b4a84da9 100644
--- a/list-objects-filter.h
+++ b/list-objects-filter.h
@@ -24,6 +24,11 @@ struct oidset;
  *              In general, objects should only be shown once, but
  *              this result DOES NOT imply that we mark it SEEN.
  *
+ * _SKIP_TREE : Used in LOFS_BEGIN_TREE situation - indicates that
+ *              the tree's children should not be iterated over. This
+ *              is used as an optimization when all children will
+ *              definitely be ignored.
+ *
  * Most of the time, you want the combination (_MARK_SEEN | _DO_SHOW)
  * but they can be used independently, such as when sparse-checkout
  * pattern matching is being applied.
@@ -45,6 +50,7 @@ enum list_objects_filter_result {
 	LOFR_ZERO      = 0,
 	LOFR_MARK_SEEN = 1<<0,
 	LOFR_DO_SHOW   = 1<<1,
+	LOFR_SKIP_TREE = 1<<2,
 };
 
 enum list_objects_filter_situation {
diff --git a/list-objects.c b/list-objects.c
index c2c5dd98ce..c41cc80db5 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -11,6 +11,7 @@
 #include "list-objects-filter-options.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "trace.h"
 
 struct traversal_context {
 	struct rev_info *revs;
@@ -184,7 +185,9 @@ static void process_tree(struct traversal_context *ctx,
 	if (base->len)
 		strbuf_addch(base, '/');
 
-	if (!failed_parse)
+	if (r & LOFR_SKIP_TREE)
+		trace_printf("Skipping contents of tree %s...\n", base->buf);
+	else if (!failed_parse)
 		process_tree_contents(ctx, tree, base);
 
 	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn) {
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index c2c2d5bea1..bb8ce66050 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -281,6 +281,19 @@ test_expect_success 'verify tree:0 includes trees in "filtered" output' '
 	test_cmp expected filtered_types
 '
 
+# Make sure tree:0 does not iterate through any trees.
+
+test_expect_success 'filter a GIANT tree through tree:0' '
+	GIT_TRACE=1 git -C r3 rev-list \
+		--objects --filter=tree:0 HEAD 2>filter_trace &&
+	grep "Skipping contents of tree [.][.][.]" filter_trace >actual &&
+	# One line for each commit traversed.
+	test_line_count = 2 actual &&
+
+	# Make sure no other trees were considered besides the root.
+	! grep "Skipping contents of tree [^.]" filter_trace
+'
+
 # Delete some loose objects and use rev-list, but WITHOUT any filtering.
 # This models previously omitted objects that we did not receive.
 
-- 
2.19.1.568.g152ad8e336-goog


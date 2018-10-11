Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17AC21F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 23:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbeJLGit (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 02:38:49 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:33755 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeJLGit (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 02:38:49 -0400
Received: by mail-yw1-f74.google.com with SMTP id f66-v6so6145294ywa.0
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 16:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s7mj0io0b2w39jyV+Xn0sI29hueu29UyoFbRQ88Bs5s=;
        b=KHwECaDHy6YE0ma05uR4JX2MMSP78vk4voKIhGCi5d+gjjcuDFANuCL6jrtvjbt+y+
         XtBgYZvbxRi9hOKKYWFtJqzUoGQLnkqUkpcjN1zSXnKuPV6lRuQpfdODGvicrlPhN8rn
         u11Nvj/O2dnSFrbmvhKAbOv8b2kCNGS5yltQG1FZH03AzHSFcGxH+sm4zQvMfYGpgkB0
         PJS9v1DlfDMkWz1dW5oE8fs0i2R2uSqF/ztvt24zZKBJfVa1PhAccmKVdcajlell34jT
         W7u+FoAJSyAG3wV5Uz2XaZnj1d0dd7OleamXMj5NL5uDsMof7Xra3bvkzRPfBIsU/umm
         GHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s7mj0io0b2w39jyV+Xn0sI29hueu29UyoFbRQ88Bs5s=;
        b=hYkyAg5SNkl1QOdxtselXL45Gp9XVpAZ/aWmDHIEcorT9kj0JkDoTC5x0gVAhG9I2i
         jga+BZVN3fd+8NlEA+oPhrEjKsEk9koZBGT3/qgab0VyaGj69UPL1cSjP6xBcPAV+e6k
         dYS518RDSWG+EruST3Z6VaMeuqcuLt5uRKqOYXz1Z1tDZb6UybbzXzSugt6glFPtK34s
         1lcuukAaiM8RRq4npR6kWAsM1eDkuwbMmZrSX3lgJJVjBmmwnj4ejt0zW15BKENLTglt
         0Ovx1nAhUIhYTfaw0p+uAeX3ZvDJ1oya5H4tpJi+kkwgVtPBO+QI9oJWzPEI5Gw31Brq
         Q2DQ==
X-Gm-Message-State: ABuFfoicD2aasOCOA8urWMW2PXSj+hyetwz4eWe6pHF3PP+fxYbDD8og
        jZ1beT5LlaCC90diShKKOWVRL6tfrSlCuUsMc2B+lVpwCbwEejq8FMlNr5wLiHkJi8irBEy2TdN
        vz+W3zFHf5s/vXoGiodDuPO+NLkEPmss16XsFoh1sDHKPXW5KX4woZUhwW1k=
X-Google-Smtp-Source: ACcGV60uiCZEAedSdAIoFfineJo4J2zTqhWUEUnY0PXOhEvAyJyQRGkZRxpwNMbOifR2+OXXinS7CYaWRn9y
X-Received: by 2002:a25:b5cb:: with SMTP id d11-v6mr2182945ybg.80.1539299360579;
 Thu, 11 Oct 2018 16:09:20 -0700 (PDT)
Date:   Thu, 11 Oct 2018 16:09:00 -0700
In-Reply-To: <cover.1539298957.git.matvore@google.com>
Message-Id: <fe4cf0841d500a46ad8f10c00818b467023d0ffc.1539298957.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1539298957.git.matvore@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC PATCH 1/3] list-objects: support for skipping tree traversal
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
 t/t6112-rev-list-filters-objects.sh | 10 ++++++++++
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index 09b2b05d5..37fba456d 100644
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
+		}
+		else
+			/*
+			 * Not collecting omits so no need to to traverse tree.
+			 */
+			return LOFR_SKIP_TREE | LOFR_MARK_SEEN;
 
 	case LOFS_END_TREE:
 		assert(obj->type == OBJ_TREE);
diff --git a/list-objects-filter.h b/list-objects-filter.h
index a6f6b4990..52b4a84da 100644
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
index 7a1a0929d..d1e3d217c 100644
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
index 08e0c7db6..efb1bee2e 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -244,6 +244,16 @@ test_expect_success 'verify tree:0 includes trees in "filtered" output' '
 	test_cmp expected filtered_types
 '
 
+# Make sure tree:0 does not iterate through any trees.
+
+test_expect_success 'filter a GIANT tree through tree:0' '
+	GIT_TRACE=1 git -C r3 rev-list \
+		--objects --filter=tree:0 HEAD 2>filter_trace &&
+	grep "Skipping contents of tree [.][.][.]" filter_trace >actual &&
+	# One line for each commit traversed.
+	test_line_count = 2 actual
+'
+
 # Delete some loose objects and use rev-list, but WITHOUT any filtering.
 # This models previously omitted objects that we did not receive.
 
-- 
2.19.1.331.ge82ca0e54c-goog


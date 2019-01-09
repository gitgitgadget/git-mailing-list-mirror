Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22DBD1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 02:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfAIC7c (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 21:59:32 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:49144 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIC7b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 21:59:31 -0500
Received: by mail-vs1-f74.google.com with SMTP id w22so2544652vsj.15
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 18:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WihaPar9ecnvRCDDmJ2hZTPjx1+T0V9wgt/6Uzei9/g=;
        b=E2fHp1T6XrwA4vG8UzJKBsqp7xhbph+8DK1sOcLBeyVGZYnEaS0sxEoM4tixSWR7Ft
         qiNoHcKEJyeyMvlRdYLPuS5PX0PukPlaSrTPGGsjzDDXQjcVAb+eF1IgrM4Hk2L/AeFM
         p0O8GfDSHOwuGf/YBw20nhPUbkzRxOM+7RgHjUMAgib8TZB8WTQOgZ+hbMycvOgHlF0a
         bLgOMBP58+YwwMEamwMKWDVQdfRAgDMIoupQJWn2gqgsAuOCY6TYcSJeAW9Zmu1CFU0A
         cEB2m1GmJHDTiPkEl1F6Z4CK/maFgkMeqX0ApRMh4mDByBmoOtuJaQGOHkuCyWuTl0NC
         P2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WihaPar9ecnvRCDDmJ2hZTPjx1+T0V9wgt/6Uzei9/g=;
        b=QPu/UAAq2MHngoaYXlOccnSYzULRl4pM1isO/BVKSXh1Gd0tju+zk/m0NVtAU3oszb
         zr95eVr350j2Nz21pEONqQOpd4iMW9D+ewb65zu0ObtGR+FkQ3pHzcA1aoH4ZExw/P5s
         01SL13wYeZOlAVI52tNGylh4MN6GhhxM0CMwkUC2IH4SGPIpYr6k8PWN/TINqlUSJuuq
         JBgLIf5atrIOyWYz0ThZWLaTKZB1/mE9xnT1IQ4lprM4rcaW+uW/MpjwukymUMQDRDr7
         BeV7daOSY332CaZ0qGrB5NnU8nQPPRHyv5YjiF4BsVFqEM0qr7McrUMSHEKIP4AKfKPo
         NhNA==
X-Gm-Message-State: AJcUukfNA28oth5Sz9NS+gRwpTAcafdBT+NxL6lTvU8VQbIVtPZrghZu
        6dklzIl/BY72bEcu7JnpF/0UNMgghVlBJCjaD8Tr8N+W2VWfvJ7N/j/1nhj6fav/Tssr/+u/tZ9
        syP29PvoZUTXkyBNj570h0BwPlHVjulA6InrAUzf0CmG5hkNe4HVgntCMsss=
X-Google-Smtp-Source: ALg8bN6Io5RHbLvbsiOv4TAX4z9yPONBYtJ2w5+E4pqZVjUHqTfWeAGAP8gHgKwXE5u0oEDSpdGFdBF89gEW
X-Received: by 2002:a1f:b291:: with SMTP id b139mr3037415vkf.18.1547002769821;
 Tue, 08 Jan 2019 18:59:29 -0800 (PST)
Date:   Tue,  8 Jan 2019 18:59:14 -0800
In-Reply-To: <20190109025914.247473-1-matvore@google.com>
Message-Id: <20190109025914.247473-3-matvore@google.com>
Mime-Version: 1.0
References: <20181210234030.176178-1-matvore@google.com> <20190109025914.247473-1-matvore@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v3 2/2] tree:<depth>: skip some trees even when collecting omits
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com,
        pclouds@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a tree has already been recorded as omitted, we don't need to
traverse it again just to collect its omits. Stop traversing trees a
second time when collecting omits.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter.c               | 18 ++++++++++++------
 t/t6112-rev-list-filters-objects.sh | 11 ++++++++++-
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index 786e0dd0b1..ee449de3f7 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -107,18 +107,19 @@ struct seen_map_entry {
 	size_t depth;
 };
 
-static void filter_trees_update_omits(
+/* Returns 1 if the oid was in the omits set before it was invoked. */
+static int filter_trees_update_omits(
 	struct object *obj,
 	struct filter_trees_depth_data *filter_data,
 	int include_it)
 {
 	if (!filter_data->omits)
-		return;
+		return 0;
 
 	if (include_it)
-		oidset_remove(filter_data->omits, &obj->oid);
+		return oidset_remove(filter_data->omits, &obj->oid);
 	else
-		oidset_insert(filter_data->omits, &obj->oid);
+		return oidset_insert(filter_data->omits, &obj->oid);
 }
 
 static enum list_objects_filter_result filter_trees_depth(
@@ -171,12 +172,17 @@ static enum list_objects_filter_result filter_trees_depth(
 		if (already_seen) {
 			filter_res = LOFR_SKIP_TREE;
 		} else {
+			int been_omitted = filter_trees_update_omits(
+				obj, filter_data, include_it);
 			seen_info->depth = filter_data->current_depth;
-			filter_trees_update_omits(obj, filter_data, include_it);
 
 			if (include_it)
 				filter_res = LOFR_DO_SHOW;
-			else if (filter_data->omits)
+			else if (filter_data->omits && !been_omitted)
+				/*
+				 * Must update omit information of children
+				 * recursively; they have not been omitted yet.
+				 */
 				filter_res = LOFR_ZERO;
 			else
 				filter_res = LOFR_SKIP_TREE;
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 706845f1d9..eb9e4119e2 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -283,7 +283,7 @@ test_expect_success 'verify tree:0 includes trees in "filtered" output' '
 
 # Make sure tree:0 does not iterate through any trees.
 
-test_expect_success 'filter a GIANT tree through tree:0' '
+test_expect_success 'verify skipping tree iteration when not collecting omits' '
 	GIT_TRACE=1 git -C r3 rev-list \
 		--objects --filter=tree:0 HEAD 2>filter_trace &&
 	grep "Skipping contents of tree [.][.][.]" filter_trace >actual &&
@@ -377,6 +377,15 @@ test_expect_success 'test tree:# filter provisional omit for blob and tree' '
 	expect_has_with_different_name r4 filt/subdir
 '
 
+test_expect_success 'verify skipping tree iteration when collecting omits' '
+	GIT_TRACE=1 git -C r4 rev-list --filter-print-omitted \
+		--objects --filter=tree:0 HEAD 2>filter_trace &&
+	grep "^Skipping contents of tree " filter_trace >actual &&
+
+	echo "Skipping contents of tree subdir/..." >expect &&
+	test_cmp expect actual
+'
+
 # Test tree:<depth> where a tree is iterated to twice - once where a subentry is
 # too deep to be included, and again where the blob inside it is shallow enough
 # to be included. This makes sure we don't use LOFR_MARK_SEEN incorrectly (we
-- 
2.20.1.97.g81188d93c3-goog


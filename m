Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB7B620A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 23:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbeLJXkz (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 18:40:55 -0500
Received: from mail-yb1-f201.google.com ([209.85.219.201]:40689 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeLJXky (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 18:40:54 -0500
Received: by mail-yb1-f201.google.com with SMTP id i15-v6so8680124ybp.7
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 15:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=00w5kY7d1spBsTs4luOb8NwdnWjtAqEx6BO13CNgtdI=;
        b=UPkUdeuw5URyMEj6qmXAAZCw7WqSuaPZ6Vd8feCYE4QhMrhKyuqa5k6R7f5/VdC/w6
         33BhQo10LYyS2YzZ01D1haAmqEFY2fMlJ77um8BYT5cU6+KCB/p4iAQX/gEaSxDp8bmB
         K0Bzv0Ux6lfzBrUvG0hmknVNqpZLATNhc/JmIKsIXz9PxXkUSnzStcNgUwTS+nQ1N+Le
         8sj25cvz0yMBTIXSJgeT2cCJyYuHFZsKe1bXA/bFg8tmCbCoJK62Kahibu/Mx0bT15hN
         MqkKcqIt9N3enTmFJZKf0PBnhV9VjCmNcv4QncAB1sMoCjvaLddyf6IG0KRed7TT6i25
         VwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=00w5kY7d1spBsTs4luOb8NwdnWjtAqEx6BO13CNgtdI=;
        b=VSYCLUS67OtkQa512RySzGB7gIkzkyB6mEKV1AyJSTEFhXKRavkbSLT9tqwOgxjHnc
         z5B3TOMcYtvf/OUSjm4hv62uvGUHJHjMfNoy/uZTThIC7HW95bdGw81jx8jjNLWFe3eb
         amuWRR3j1C2YxvHpJXzHI7Zwv39JuKA8W6QMT7qjMxQgqrJLI3MYAwOmT+rxpoXvV7Da
         lyCJ9bfn4ddN7iCPcNfveCFDY0cMnJMjPO1b1BDN9repijnZa9ofQjVQeyONh+4zOxIn
         c9RXch1mXvZ0Jgnds5hDi90HcmEKAsEZWWFVgIibVc2z22c6RwBrVRuwLPzkYPySvwq2
         lZ7A==
X-Gm-Message-State: AA+aEWZdDYXdC8JfMWL7TkcKGoxkB9SExUSoQogfSL4fkOxwY5sLo+x0
        5VasZMwHSL0C0KMgcIhTJXuvdsGoPxH9Z1i5msMPX9eMr2FYfpMGxVwwRFVrmuVt8IYHiKFHL1c
        4zGNJE6WjdzQF4RKBuIxrWm/J646BAE0cC+3iEl8s6emXsuk343R4ufWylE8=
X-Google-Smtp-Source: AFSGD/Vh2VHQ9rmbKLFQIaQ4WtSlGN6hjO60jb94C39Ffx9muWL5bSe8wFZUGwsPzR8UmhCgNtv+V8iGjiTn
X-Received: by 2002:a25:bb0d:: with SMTP id z13-v6mr9043673ybg.52.1544485253558;
 Mon, 10 Dec 2018 15:40:53 -0800 (PST)
Date:   Mon, 10 Dec 2018 15:40:30 -0800
In-Reply-To: <20181210234030.176178-1-matvore@google.com>
Message-Id: <20181210234030.176178-3-matvore@google.com>
Mime-Version: 1.0
References: <20181210234030.176178-1-matvore@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH v2 2/2] tree:<depth>: skip some trees even when collecting omits
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com, pclouds@gmail.com
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
 list-objects-filter.c               | 17 +++++++++++------
 t/t6112-rev-list-filters-objects.sh | 11 ++++++++++-
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index ca99f0dd02..3e9802c676 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -107,18 +107,18 @@ struct seen_map_entry {
 	size_t depth;
 };
 
-static void filter_trees_update_omits(
+static int filter_trees_update_omits(
 	struct object *obj,
 	struct filter_trees_depth_data *filter_data,
 	int include_it)
 {
 	if (!filter_data->omits)
-		return;
+		return 1;
 
 	if (include_it)
-		oidset_remove(filter_data->omits, &obj->oid);
+		return oidset_remove(filter_data->omits, &obj->oid);
 	else
-		oidset_insert(filter_data->omits, &obj->oid);
+		return oidset_insert(filter_data->omits, &obj->oid);
 }
 
 static enum list_objects_filter_result filter_trees_depth(
@@ -170,12 +170,17 @@ static enum list_objects_filter_result filter_trees_depth(
 		if (already_seen)
 			filter_res = LOFR_SKIP_TREE;
 		else {
+			int been_omitted = filter_trees_update_omits(
+				obj, filter_data, include_it);
 			seen_info->depth = filter_data->current_depth;
-			filter_trees_update_omits(obj, filter_data, include_it);
 
 			if (include_it)
 				filter_res = LOFR_DO_SHOW;
-			else if (filter_data->omits)
+			else if (!been_omitted)
+				/*
+				 * Must update omit information of children
+				 * recursively; they have not been omitted yet.
+				 */
 				filter_res = LOFR_ZERO;
 			else
 				filter_res = LOFR_SKIP_TREE;
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 54e7096d40..18b0b14d5a 100755
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
2.20.0.rc2.403.gdbc3b29805-goog


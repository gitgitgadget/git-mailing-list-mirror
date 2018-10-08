Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD2971F97F
	for <e@80x24.org>; Mon,  8 Oct 2018 21:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeJIFCI (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:02:08 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:46687 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeJIFCI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 01:02:08 -0400
Received: by mail-qt1-f202.google.com with SMTP id i14-v6so23088680qtf.13
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 14:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ATemAWzjDdT/kXBy0faqYsE1+mzzgGE6Tgvbweyb5XE=;
        b=AuF/8DkAKfQ2CEgmYRqJX+48cV/hmS+6JeM8LkIkukbxmfEecekLqFv64a8kkKUTa/
         eunODcuePqatcSs/Ct7DbSIn9kYdiSJPGic7zQ5UI8k77NvshBVxvclFMroNtjRxW3fd
         VafE0u0E5HAbnLNQrvj8PY0Jht5d1l820Kb9bMA6Qsic+PdGb70fZvSn0Cj7vGI0WOjK
         hgeAZbZ+InedQzVLmYol9SkJNuM0Ripvunyl6FsJyRHRLZ1iHEnn/T2MVBitsGxNPQnK
         NpHIG7sEUvSTaCBPdofF9oJJgiRrK6RHMvkyCwkH7IVg6U4V01wEy6tFxjRjfPjPB3gT
         UZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ATemAWzjDdT/kXBy0faqYsE1+mzzgGE6Tgvbweyb5XE=;
        b=IT3OXNUnTrvRfPy9ccm8gYpIa+783E0qg07+K+HNjm8omrmhFZqdJt0dSonTWk3upi
         WJzRleVw+oLBOyky0su/aakdD/yNR2i+AWEiGiAZiXmorHTh22wbK4f5ahWkKrCwnOnb
         hlt1xz09kRbmxBax0PG59sfRDdq/IZwGD96cDkCE1lfZbLObWzdnJMQDF9keJxQVWzp4
         MKE3qNndmvXoBAxMm95U5T+EbkUIvCHdLiM8J1qu+MwlK7l4zUkZUY/F+8fQHIE6sS+E
         YH0wHhdHhzppRgpErZ8GENgLn2ompLd0xzjpdel1OxnZzh66VX4N5TfnuUi4fuo1VQ+A
         LREw==
X-Gm-Message-State: ABuFfoivHFr/3XLJVOAEDnj6rNewWX8VsZhAWdd4CgDeA6Qmd2jWkb9N
        jEaLmRTDkcrnhN5EM6NVMVYkwy2Rz09kQ4rTw9rEjgZfd/sPpV7lMQ+eB/pyD+Y74CHXewgkwxy
        wyt48qQRJdG9WFftHwMe0yz139oWlXSi50xYf6y1mrQ23H/sQS1eq8CYEnu8yjocrVnlwYW8Qo+
        LB
X-Google-Smtp-Source: ACcGV61EY/na3gh/NzUVN8Hmp8A/9RRwDhuZsdu4sZycsq9/BbbMl41ZYGUXr8SauECUDfaxHjBFqWJcyZnEOOR4ITL9
X-Received: by 2002:a0c:d8f1:: with SMTP id w46mr7185652qvj.33.1539035299611;
 Mon, 08 Oct 2018 14:48:19 -0700 (PDT)
Date:   Mon,  8 Oct 2018 14:48:16 -0700
Message-Id: <20181008214816.42856-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH] unpack-trees: allow missing CE_SKIP_WORKTREE objs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whenever a sparse checkout occurs, the existence of all blobs in the
index is verified, whether or not they are included or excluded by the
.git/info/sparse-checkout specification. This degrades performance,
significantly in the case of a partial clone, because a lazy fetch
occurs whenever the existence of a missing blob is checked.

At the point of invoking cache_tree_update() in unpack_trees(),
CE_SKIP_WORKTREE is already set on all excluded blobs
(mark_new_skip_worktree() is called twice to set CE_NEW_SKIP_WORKTREE,
then apply_sparse_checkout() is called which copies over
CE_NEW_SKIP_WORKTREE to CE_SKIP_WORKTREE). cache_tree_update() can use
this information to know which blobs are excluded, and thus skip the
checking of these.

Because cache_tree_update() is used from multiple places, this new
behavior is guarded by a new flag WRITE_TREE_SKIP_WORKTREE_MISSING_OK.
Implement this new flag, and teach unpack_trees() to invoke
cache_tree_update() with this new flag.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache-tree.c                     |  6 +++++-
 cache-tree.h                     |  4 ++++
 t/t1090-sparse-checkout-scope.sh | 33 ++++++++++++++++++++++++++++++++
 unpack-trees.c                   |  1 +
 4 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index 5ce51468f0..340caf2d34 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -246,6 +246,8 @@ static int update_one(struct cache_tree *it,
 	int missing_ok = flags & WRITE_TREE_MISSING_OK;
 	int dryrun = flags & WRITE_TREE_DRY_RUN;
 	int repair = flags & WRITE_TREE_REPAIR;
+	int skip_worktree_missing_ok =
+		flags & WRITE_TREE_SKIP_WORKTREE_MISSING_OK;
 	int to_invalidate = 0;
 	int i;
 
@@ -356,7 +358,9 @@ static int update_one(struct cache_tree *it,
 		}
 
 		if (is_null_oid(oid) ||
-		    (mode != S_IFGITLINK && !missing_ok && !has_object_file(oid))) {
+		    (mode != S_IFGITLINK && !missing_ok &&
+		     !(skip_worktree_missing_ok && ce_skip_worktree(ce)) &&
+		     !has_object_file(oid))) {
 			strbuf_release(&buffer);
 			if (expected_missing)
 				return -1;
diff --git a/cache-tree.h b/cache-tree.h
index 0ab6784ffe..655d487619 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -40,6 +40,10 @@ void cache_tree_verify(struct index_state *);
 #define WRITE_TREE_DRY_RUN 4
 #define WRITE_TREE_SILENT 8
 #define WRITE_TREE_REPAIR 16
+/*
+ * Do not check for the presence of cache entry objects with CE_SKIP_WORKTREE.
+ */
+#define WRITE_TREE_SKIP_WORKTREE_MISSING_OK 32
 
 /* error return codes */
 #define WRITE_TREE_UNREADABLE_INDEX (-1)
diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
index 25d7c700f6..090b7fc3d3 100755
--- a/t/t1090-sparse-checkout-scope.sh
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -63,4 +63,37 @@ test_expect_success 'return to full checkout of master' '
 	test "$(cat b)" = "modified"
 '
 
+test_expect_success 'in partial clone, sparse checkout only fetches needed blobs' '
+	test_create_repo server &&
+	git clone "file://$(pwd)/server" client &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	echo a >server/a &&
+	echo bb >server/b &&
+	mkdir server/c &&
+	echo ccc >server/c/c &&
+	git -C server add a b c/c &&
+	git -C server commit -m message &&
+
+	test_config -C client core.sparsecheckout 1 &&
+	test_config -C client extensions.partialclone origin &&
+	echo "!/*" >client/.git/info/sparse-checkout &&
+	echo "/a" >>client/.git/info/sparse-checkout &&
+	git -C client fetch --filter=blob:none origin &&
+	git -C client checkout FETCH_HEAD &&
+
+	git -C client rev-list HEAD \
+		--quiet --objects --missing=print >unsorted_actual &&
+	(
+		printf "?" &&
+		git hash-object server/b &&
+		printf "?" &&
+		git hash-object server/c/c
+	) >unsorted_expect &&
+	sort unsorted_actual >actual &&
+	sort unsorted_expect >expect &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 51bfac6aa0..39e0e7a6c7 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1635,6 +1635,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 				o->result.cache_tree = cache_tree();
 			if (!cache_tree_fully_valid(o->result.cache_tree))
 				cache_tree_update(&o->result,
+						  WRITE_TREE_SKIP_WORKTREE_MISSING_OK |
 						  WRITE_TREE_SILENT |
 						  WRITE_TREE_REPAIR);
 		}
-- 
2.19.0.271.gfe8321ec05.dirty


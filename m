Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4C701F453
	for <e@80x24.org>; Fri,  1 Feb 2019 16:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbfBAQXD (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 11:23:03 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35822 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbfBAQXC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 11:23:02 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so3457638plo.2
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 08:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UsYzPFmfEv7A5r/dnG3QtX4UaoMx0fruIY07fmLeWiQ=;
        b=i6yMrpz9BMBue0VUw1JCbB8yOtzyvWgsBsUVdNm1S+RZiNEccTRmWaPYNbVQq6hZx3
         wiinHEW0x9uxOGolkZuYFAYUyw6cV1nwB4wpxU/iaYVhM6FtrbKa9vHKGlVCUg3dfkyM
         jeAENz1WnuUbrAmO7phxMuF183y+FwrtDUmxFco3bf8w3pI9TzKBVNXan+uaBX1Z6FE/
         bUTVOxPKpheDPvI91Zfixj/v48pTGK3YlGfmYWqW0hFnIfeQeq/xzicMxyDyElUdkWXE
         Ba6XLu1nMqr3bYhy0oxJIrSzu+UEt6jPkNUowBsNTDmvAG5DgspRMqUbhqsfrQKN3fha
         43cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UsYzPFmfEv7A5r/dnG3QtX4UaoMx0fruIY07fmLeWiQ=;
        b=rQdkPk+CfYTu4FrBlg+oP0xdF2w1IL+7vX3hTgoehnaAxnip7z1w59Bg6x1Jr8dSPK
         f1YMRF33m5bZlzMQ8IZ98zMjEIHC38YUbDyWXJ/5m2XRsvhu+RmOJB9tGIdLkZ5lchwo
         yKkWiHjLHINmUzLyVzCsjvaUOLy/q+nsZYiQNKgCntAksQd9X2w9ofB2ojGNLYaGyV9i
         yTV9muRiqhAv3H07qnLdWOnkVumLIxpt94MWI1GXqYZlvd8c2C6/ZWTJUdDqABZMsxwl
         pKyyDcQIKRL5dH2GdfRD6ITFWiiVC0XO4yzsYlPWErrmiH22Ff3fEy62LAgCWS9OVE6O
         8dYA==
X-Gm-Message-State: AJcUuke5WgyaRQ6WYlHfBpvUEyUc0UBIYis9jl41wqU4Aoxaebbsv9cS
        dFgywP3TKIhiWeMGUokk9Wis1MUz/NbiMQ==
X-Google-Smtp-Source: ALg8bN4vMPY4a9rMRcUBn8GpFqoLJ7aB03iEtI2qs6353bVM89SbmXUwzO/VJg2LtQdwv8TQgRA/mA==
X-Received: by 2002:a17:902:7882:: with SMTP id q2mr41297581pll.305.1549038182006;
        Fri, 01 Feb 2019 08:23:02 -0800 (PST)
Received: from localhost.localdomain ([2408:84e1:1:ce70:7c5c:7512:51d2:8f91])
        by smtp.gmail.com with ESMTPSA id x2sm11872694pfx.78.2019.02.01.08.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 08:23:01 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v9 6/6] pack-redundant: consistent sort method
Date:   Sat,  2 Feb 2019 00:21:52 +0800
Message-Id: <20190201162152.31136-7-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.103.ged0fc2ca7b
In-Reply-To: <20190130114736.30357-1-worldhello.net@gmail.com>
References: <20190130114736.30357-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

SZEDER reported that test case t5323 has different test result on MacOS.
This is because `cmp_pack_list_reverse` cannot give identical result
when two pack being sorted has the same size of remaining_objects.

Changes to the sorting function will make consistent test result for
t5323.

The new algorithm to find redundant packs is a trade-off to save memory
resources, and the result of it may be different with old one, and may
be not the best result sometimes.  Update t5323 for the new algorithm.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-redundant.c  | 24 ++++++++++++++++--------
 t/t5323-pack-redundant.sh | 18 +++++++++---------
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 15cdf233c4..29ff5e99cb 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -33,6 +33,7 @@ static struct pack_list {
 	struct packed_git *pack;
 	struct llist *unique_objects;
 	struct llist *remaining_objects;
+	size_t all_objects_size;
 } *local_packs = NULL, *altodb_packs = NULL;
 
 static struct llist_item *free_nodes;
@@ -340,19 +341,25 @@ static inline off_t pack_set_bytecount(struct pack_list *pl)
 	return ret;
 }
 
-static int cmp_pack_list_reverse(const void *a, const void *b)
+static int cmp_remaining_objects(const void *a, const void *b)
 {
 	struct pack_list *pl_a = *((struct pack_list **)a);
 	struct pack_list *pl_b = *((struct pack_list **)b);
-	size_t sz_a = pl_a->remaining_objects->size;
-	size_t sz_b = pl_b->remaining_objects->size;
 
-	if (sz_a == sz_b)
-		return 0;
-	else if (sz_a < sz_b)
+	if (pl_a->remaining_objects->size == pl_b->remaining_objects->size) {
+		/* have the same remaining_objects, big pack first */
+		if (pl_a->all_objects_size == pl_b->all_objects_size)
+			return 0;
+		else if (pl_a->all_objects_size < pl_b->all_objects_size)
+			return 1;
+		else
+			return -1;
+	} else if (pl_a->remaining_objects->size < pl_b->remaining_objects->size) {
+		/* sort by remaining objects, more objects first */
 		return 1;
-	else
+	} else {
 		return -1;
+	}
 }
 
 /* Sort pack_list, greater size of remaining_objects first */
@@ -370,7 +377,7 @@ static void sort_pack_list(struct pack_list **pl)
 	for (n = 0, p = *pl; p; p = p->next)
 		ary[n++] = p;
 
-	QSORT(ary, n, cmp_pack_list_reverse);
+	QSORT(ary, n, cmp_remaining_objects);
 
 	/* link them back again */
 	for (i = 0; i < n - 1; i++)
@@ -511,6 +518,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 		llist_insert_back(l.remaining_objects, (const struct object_id *)(base + off));
 		off += step;
 	}
+	l.all_objects_size = l.remaining_objects->size;
 	l.unique_objects = NULL;
 	if (p->pack_local)
 		return pack_list_insert(&local_packs, &l);
diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 897acaa365..e642240d71 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -210,19 +210,19 @@ test_expect_success 'create pack 4, 5' '
 #         | T A B C D E F G H I J K L M N O P Q R
 #     ----+--------------------------------------
 #     P1  | x x x x x x x                       x
-#     P2* |     ! ! ! !   ! ! !
-#     P3  |             x     x x x x x
+#     P2  |     x x x x   x x x
+#     P3* |             !     ! ! ! ! !
 #     P4  |                     x x x x     x
 #     P5  |               x x           x x
 #     ----+--------------------------------------
 #     ALL | x x x x x x x x x x x x x x x x x   x
 #
 #############################################################################
-test_expect_failure 'one of pack-2/pack-3 is redundant (failed on Mac)' '
+test_expect_success 'one of pack-2/pack-3 is redundant' '
 	(
 		cd "$master_repo" &&
 		cat >expect <<-EOF &&
-			P2:$P2
+			P3:$P3
 			EOF
 		git pack-redundant --all >out &&
 		format_packfiles <out >actual &&
@@ -250,7 +250,7 @@ test_expect_success 'create pack 6, 7' '
 #     ALL | x x x x x x x x x x x x x x x x x x x
 #
 #############################################################################
-test_expect_failure 'pack 2, 4, and 6 are redundant (failed on Mac)' '
+test_expect_success 'pack 2, 4, and 6 are redundant' '
 	(
 		cd "$master_repo" &&
 		cat >expect <<-EOF &&
@@ -285,7 +285,7 @@ test_expect_success 'create pack 8' '
 #     ALL | x x x x x x x x x x x x x x x x x x x
 #
 #############################################################################
-test_expect_failure 'pack-8 (subset of pack-1) is also redundant (failed on Mac)' '
+test_expect_success 'pack-8 (subset of pack-1) is also redundant' '
 	(
 		cd "$master_repo" &&
 		cat >expect <<-EOF &&
@@ -309,7 +309,7 @@ test_expect_success 'clean loose objects' '
 	)
 '
 
-test_expect_failure 'remove redundant packs and pass fsck (failed on Mac)' '
+test_expect_success 'remove redundant packs and pass fsck' '
 	(
 		cd "$master_repo" &&
 		git pack-redundant --all | xargs rm &&
@@ -329,7 +329,7 @@ test_expect_success 'setup shared.git' '
 	)
 '
 
-test_expect_failure 'no redundant packs without --alt-odb (failed on Mac)' '
+test_expect_success 'no redundant packs without --alt-odb' '
 	(
 		cd "$shared_repo" &&
 		git pack-redundant --all >out &&
@@ -362,7 +362,7 @@ test_expect_failure 'no redundant packs without --alt-odb (failed on Mac)' '
 #     ALL | x x x x x x x x x x x x x x x x x x x
 #
 #############################################################################
-test_expect_failure 'pack-redundant --verbose: show duplicate packs in stderr (failed on Mac)' '
+test_expect_success 'pack-redundant --verbose: show duplicate packs in stderr' '
 	(
 		cd "$shared_repo" &&
 		cat >expect <<-EOF &&
-- 
2.20.1.103.ged0fc2ca7b


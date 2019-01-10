Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 049C11F803
	for <e@80x24.org>; Thu, 10 Jan 2019 12:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfAJMFV (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 07:05:21 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40188 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfAJMFU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 07:05:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so5211979pfo.7
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 04:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jf8TnTfhSbw4KDZgdjQDqBI4e9cWjVlyf2vBihu61/Q=;
        b=Ky/AVE24mmK7U8EENoW4Fr1xBsyZtKjN5r71pZcg9bO/Nkaw/mv0EpW0DHtaQ/xFkw
         qgMgCuhEc2bo4qg52RXAQJpt1tc2UhD3joc3Evfnh36hcYKmZaYHI9UdbtXSsbXN2uN7
         Vw/KlCycJK4F5OtHAsm7pDqOR9PKmWzutSplcWTb5j/SRM8V5D+QGkRZU5/0T6fgAxrG
         s/D4/RcTYhnvrolxVLgr600NrZCqS9grOyUj6nN8Tls9nDLeGSLE1RbeS3hf4SL5yBUh
         5qdde93IIaBlM/s4a3PyeVwi9jvYxET3wpWqtBKB5jZkj3kCKZEEQMJjvKR70lHqjikd
         SEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jf8TnTfhSbw4KDZgdjQDqBI4e9cWjVlyf2vBihu61/Q=;
        b=Wfeja4VrbqAwPcm4LBUtWIAqU8G5jyUoYopaCZGxKWOCYcy1FtgJIaTR3W8hu/29eK
         rx9P1ghwKomy2IciXcaEt1DFp/pph12226QeJXwaGERtVXQgXOjqmYLZddM5ptRXav70
         f031oJYEjqsOhM0OXIBzTipGluOn8im/GcZ7ZXDN5lnt6ocHf4q58h4UCSl/ZgiKW1RD
         Her3614Ae8f1o6DtyZ4bZ9RBz5zWxJVs/ls3UFIc0mOUPfitCPGdn0mvXDUuJ0fhjNIV
         GyGhyiqc3BAfWbJjaHyXystILcA4uHKdrq7SDrSYFA++x43BJUmT/GwusPvsnDWH5vi4
         BkPQ==
X-Gm-Message-State: AJcUukd9tZs9Wy7H9mikJ2dLnqSdEAUgA9luddNVkxj63c/IBXhTOCF7
        WL+dErRaK1esZr+mZxYOAvjX/zVfK0c=
X-Google-Smtp-Source: ALg8bN4vWzdhMYacjt57SeAMFjei74Re0rboIXWc5jfPqIwR7o3aOWIM8kp8QEbIWfrpsIOJ/1eEkQ==
X-Received: by 2002:a62:8e19:: with SMTP id k25mr9931222pfe.185.1547121918923;
        Thu, 10 Jan 2019 04:05:18 -0800 (PST)
Received: from GotGit.hz.ali.com ([106.11.34.204])
        by smtp.gmail.com with ESMTPSA id b2sm137189403pfm.3.2019.01.10.04.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 04:05:18 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>, Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v5 4/5] pack-redundant: consistent sort method
Date:   Thu, 10 Jan 2019 20:01:41 +0800
Message-Id: <20190110120142.22271-5-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.101.gc01fadde4e
In-Reply-To: <20190109164731.GJ4673@szeder.dev>
References: <20190109164731.GJ4673@szeder.dev>
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
---
 builtin/pack-redundant.c  | 22 +++++++++++++++-------
 t/t5323-pack-redundant.sh |  2 +-
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 56591d283f..e9d2586e2e 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -33,6 +33,7 @@ static struct pack_list {
 	struct packed_git *pack;
 	struct llist *unique_objects;
 	struct llist *remaining_objects;
+	size_t all_objects_size;
 } *local_packs = NULL, *altodb_packs = NULL;
 
 struct pll {
@@ -421,16 +422,22 @@ static inline off_t pack_set_bytecount(struct pack_list *pl)
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
+	/* if have the same remaining_objects, big pack first */
+	if (pl_a->remaining_objects->size == pl_b->remaining_objects->size)
+		if (pl_a->all_objects_size == pl_b->all_objects_size)
+			return 0;
+		else if (pl_a->all_objects_size < pl_b->all_objects_size)
+			return 1;
+		else
+			return -1;
+
+	/* sort according to remaining objects, more remaining objects first */
+	if (pl_a->remaining_objects->size < pl_b->remaining_objects->size)
 		return 1;
 	else
 		return -1;
@@ -451,7 +458,7 @@ static void sort_pack_list(struct pack_list **pl)
 	for (n = 0, p = *pl; p; p = p->next)
 		ary[n++] = p;
 
-	QSORT(ary, n, cmp_pack_list_reverse);
+	QSORT(ary, n, cmp_remaining_objects);
 
 	/* link them back again */
 	for (i = 0; i < n - 1; i++)
@@ -593,6 +600,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 		llist_insert_back(l.remaining_objects, (const struct object_id *)(base + off));
 		off += step;
 	}
+	l.all_objects_size = l.remaining_objects->size;
 	/* this list will be pruned in cmp_two_packs later */
 	l.unique_objects = llist_copy(l.remaining_objects);
 	if (p->pack_local)
diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 7410426dee..2a09ff1bfb 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -90,7 +90,7 @@ test_expect_success 'create pack 4, 5' '
 '
 
 cat >expected <<EOF
-P2:$P2
+P3:$P3
 EOF
 
 test_expect_success 'one of pack-2/pack-3 is redundant' '
-- 
2.20.1.101.gc01fadde4e


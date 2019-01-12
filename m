Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97A15211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 09:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfALJUC (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Jan 2019 04:20:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41932 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfALJUC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jan 2019 04:20:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so8087078pfi.8
        for <git@vger.kernel.org>; Sat, 12 Jan 2019 01:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mecqdjPp3VEd96vniRP5A+cbE5dMcb7MhTXXr6z/jbw=;
        b=DYTsxzIvUZNOgdcBrGw7SiJeZMI3GmzGVsVgq9T4k6rJHKnRnFds/uQJfgs0psOOGR
         EnD/6yjrYfJoEL8auHkQw2eoXC1ggTWUAzMvsyBPZLha23SK6NdIGIM31VWzSk/BwhD2
         b68uw9i/tNDJzxNFQ3LiZvZFpRGOZ1XBsIwrvMWUgsfuTLN/twLHpufzwZOoW3UVnJma
         kX3H/hSMPkA7Njvtqmo2eLTp29D+rUZ4viCR76HrJ7MR42s+ZS46gqthpF8AsJiBzVSB
         phs2MY5/VRdfHiGnuBwM6ME9d1HrHywdI8W6uGsnSGyN1rabiNbo1ZzakMUuuG0l9dCJ
         /J8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mecqdjPp3VEd96vniRP5A+cbE5dMcb7MhTXXr6z/jbw=;
        b=XQtqKla+trjTzSVPUARkAJDDG3m2qUPTE4TBRhyixPvEhTz2WF7nIdGPqsJSc/xdRc
         L9wzqcocyCZp2ZA3L35wBlcli7ayvY4c2OXp+ZNCBHAhobg4fgcQLl2p6+qexAAVvaad
         o+wzJ0RBKdXWl7sDCfYKz8G2ijUzNKF62Xcshshy2i09y9mbAWKWKx595s7Veg7Mo1mV
         Q9mjm0r8LEcpnhHKnEeHvDHvWaABOdCRNbeKshjxkuvFxZD+9gYWO+7gMtH3aeltawyE
         tR14o4e7s+7YbaDZl4lj+gEJ2YpilFfPT5T0xsnzQIEbOvKvSGjm7uJ/CbbJ/KNOACAZ
         Yweg==
X-Gm-Message-State: AJcUukewcK0HCYpU/T4Rkiatx57Nh+SaxgfrcJQ0Jqh7hnglcYOrC/vh
        q/+fk20CpsF0nKb1xeK8gzw=
X-Google-Smtp-Source: ALg8bN7+7JvOkQkbzSJDDPgfUXtRcBmXK5yHE+d3cy9XYIvUXaGeBqKUhSCEawL+QBYTmVFNoO9mLA==
X-Received: by 2002:a62:c28e:: with SMTP id w14mr17836584pfk.115.1547284801580;
        Sat, 12 Jan 2019 01:20:01 -0800 (PST)
Received: from localhost.localdomain ([221.222.155.87])
        by smtp.gmail.com with ESMTPSA id i5sm27685510pfg.34.2019.01.12.01.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 01:20:00 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v6 5/5] pack-redundant: consistent sort method
Date:   Sat, 12 Jan 2019 17:17:54 +0800
Message-Id: <20190112091754.30985-6-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.0.3.gc45e608566
In-Reply-To: <20190110120142.22271-1-worldhello.net@gmail.com>
References: <20190110120142.22271-1-worldhello.net@gmail.com>
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
 builtin/pack-redundant.c  | 24 ++++++++++++++++--------
 t/t5323-pack-redundant.sh |  2 +-
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 64eec3e297..4448e58a10 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -33,6 +33,7 @@ static struct pack_list {
 	struct packed_git *pack;
 	struct llist *unique_objects;
 	struct llist *remaining_objects;
+	size_t all_objects_size;
 } *local_packs = NULL, *altodb_packs = NULL;
 
 static struct llist_item *free_nodes;
@@ -335,19 +336,25 @@ static inline off_t pack_set_bytecount(struct pack_list *pl)
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
@@ -365,7 +372,7 @@ static void sort_pack_list(struct pack_list **pl)
 	for (n = 0, p = *pl; p; p = p->next)
 		ary[n++] = p;
 
-	QSORT(ary, n, cmp_pack_list_reverse);
+	QSORT(ary, n, cmp_remaining_objects);
 
 	/* link them back again */
 	for (i = 0; i < n - 1; i++)
@@ -507,6 +514,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 		llist_insert_back(l.remaining_objects, (const struct object_id *)(base + off));
 		off += step;
 	}
+	l.all_objects_size = l.remaining_objects->size;
 	/* this list will be pruned in cmp_two_packs later */
 	l.unique_objects = llist_copy(l.remaining_objects);
 	if (p->pack_local)
diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 407838f0e8..663328ab30 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -133,7 +133,7 @@ test_expect_success 'create pack 4, 5' '
 '
 
 cat >expected <<EOF
-P2:$P2
+P3:$P3
 EOF
 
 test_expect_success 'one of pack-2/pack-3 is redundant' '
-- 
2.20.0.3.gc45e608566


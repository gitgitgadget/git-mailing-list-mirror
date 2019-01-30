Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EE221F453
	for <e@80x24.org>; Wed, 30 Jan 2019 11:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfA3LtL (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 06:49:11 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36443 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfA3LtL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 06:49:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so11313029pfc.3
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 03:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tz51dfTMaICRSidRsXeKk77escUc+/nB+JeBiMqpt2Q=;
        b=UxIq+472mF2Kw8MQthdzEulkmEpu1kCk8mSILVfU5nnjNpoVYvLBmGYa1nTLnqdWR5
         iCK38eakcS7I2RWZXpH1alvhxyoGqd+U1vNeYgDcN5jv1tUK6oGQhyTU3eIrT3j3P3VJ
         KERFb5cyX3cZ1vjKis3zBT2AT8mB9Sy5dUZuy9tG7nDqVqMqTuYsMW+R0AwG2/I+Yjtn
         Stif6KdPYT5bFmTftF9UN1WTXlThSK8ygjdEqU9oIVtEIl10Tnlm39Y6CieQDTnvCvU9
         oRPC47UD7gzm00IMef/X9UR7/B5OPD4h+OqDHqjAoyrM9Pqt0VsNCEzZMU6bUPLw1QoD
         zH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tz51dfTMaICRSidRsXeKk77escUc+/nB+JeBiMqpt2Q=;
        b=Tr29ilJIrBeUjaEiJE1VvtC6GIVCMp7vwHqJngJtux6vSOmmE+OaG4LlVnyg0IsI75
         JaOOKtItNP93NTFnUChOMBrbkDE7/O/awOdaxmlEZYqiP8evRVWh+nk7DAHQPmFXIooZ
         82+8/oUjRb0jGPSMZGxtjwmMUNlxsUUbRuYjKblMuPBdqlQm3Q94d3x2DNtoVv5YXCQw
         LqmhHsqToVwP6p6FHQPguUAbmns9MZsoZNHbwgthZMGBxMcSXeCE8pFy7nAvQC45zxHj
         zXCAKsBkyM/urMRafXFO0Ljy3Mr9FXMmAT6LKEMlk9QJInvvF5UBNoz7fCpFb9SVT+Y4
         NVmQ==
X-Gm-Message-State: AJcUukcaQMF3criEx+mNrKAB6gGR5QsW6sHUPnjk9Q/5QuF545hEJui6
        E6Z3KoxUIM+OEAq60cU2eI8=
X-Google-Smtp-Source: ALg8bN746pVlOrKvja79tB+q6CcpmXWSHqY31QiknQry2jV0S8WZPjOpMQBaEpXU3r8UXXj7nmD64Q==
X-Received: by 2002:a63:6207:: with SMTP id w7mr26278911pgb.90.1548848950453;
        Wed, 30 Jan 2019 03:49:10 -0800 (PST)
Received: from localhost.localdomain ([2408:84e1:e2:afd3:7c5c:7512:51d2:8f91])
        by smtp.gmail.com with ESMTPSA id v191sm2124473pgb.77.2019.01.30.03.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 03:49:09 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v7 6/6] pack-redundant: consistent sort method
Date:   Wed, 30 Jan 2019 19:47:36 +0800
Message-Id: <20190130114736.30357-7-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.103.ged0fc2ca7b
In-Reply-To: <20190112091754.30985-1-worldhello.net@gmail.com>
References: <20190112091754.30985-1-worldhello.net@gmail.com>
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
 t/t5323-pack-redundant.sh | 14 +++++++-------
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index c145852b8b..0316a400ad 100644
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
@@ -512,6 +519,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 		llist_insert_back(l.remaining_objects, (const struct object_id *)(base + off));
 		off += step;
 	}
+	l.all_objects_size = l.remaining_objects->size;
 	l.unique_objects = NULL;
 	if (p->pack_local)
 		return pack_list_insert(&local_packs, &l);
diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index d176a6eb91..4469128203 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -152,10 +152,10 @@ test_expect_success 'create pack 4, 5' '
 '
 
 cat >expected <<EOF
-P2:$P2
+P3:$P3
 EOF
 
-test_expect_failure 'one of pack-2/pack-3 is redundant' '
+test_expect_success 'one of pack-2/pack-3 is redundant' '
 	git pack-redundant --all >out &&
 	format_packfiles <out >actual &&
 	test_cmp expected actual
@@ -172,7 +172,7 @@ P4:$P4
 P6:$P6
 EOF
 
-test_expect_failure 'pack 2, 4, and 6 are redundant' '
+test_expect_success 'pack 2, 4, and 6 are redundant' '
 	git pack-redundant --all >out &&
 	format_packfiles <out >actual &&
 	test_cmp expected actual
@@ -189,7 +189,7 @@ P6:$P6
 P8:$P8
 EOF
 
-test_expect_failure 'pack-8 (subset of pack-1) is also redundant' '
+test_expect_success 'pack-8 (subset of pack-1) is also redundant' '
 	git pack-redundant --all >out &&
 	format_packfiles <out >actual &&
 	test_cmp expected actual
@@ -201,7 +201,7 @@ test_expect_success 'clean loose objects' '
 	test_must_be_empty out
 '
 
-test_expect_failure 'remove redundant packs and pass fsck' '
+test_expect_success 'remove redundant packs and pass fsck' '
 	git pack-redundant --all | xargs rm &&
 	git fsck --no-progress &&
 	git pack-redundant --all >out &&
@@ -215,7 +215,7 @@ test_expect_success 'setup shared.git' '
 	printf "../../master.git/objects" >objects/info/alternates
 '
 
-test_expect_failure 'no redundant packs without --alt-odb' '
+test_expect_success 'no redundant packs without --alt-odb' '
 	git pack-redundant --all >out &&
 	test_must_be_empty out
 '
@@ -227,7 +227,7 @@ P5:$P5
 P7:$P7
 EOF
 
-test_expect_failure 'pack-redundant --verbose: show duplicate packs in stderr' '
+test_expect_success 'pack-redundant --verbose: show duplicate packs in stderr' '
 	git pack-redundant --all --verbose >out 2>out.err &&
 	test_must_be_empty out &&
 	grep "pack$" out.err | format_packfiles >actual &&
-- 
2.20.1.103.ged0fc2ca7b


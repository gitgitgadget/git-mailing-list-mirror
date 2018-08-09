Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A9381F405
	for <e@80x24.org>; Thu,  9 Aug 2018 15:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732538AbeHISVk (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 14:21:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41370 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732503AbeHISVk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 14:21:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so5574805wrr.8
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 08:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=teBQeOT91KCycbwR1NXpfOu+f4cArq/biIYpDRwOKP4=;
        b=CSV/XwcVvYNjve0jdteBYWNrswbqRllw2bydtGYszdE7enYqhBGh+QEBKjYHMHewi4
         HY14SSGgqPBNG+wm08gjtEtRPLkc432eFygWwqzgwsU6Obgq2sEVYNhiSR1N30tkQjAu
         vFdzgnrD/yk+YYGMoCheT79iHFkIpVdF+Ji2X1enPuuj9fqdNx5veyB6ZoxeYYdhvcfi
         wKwpU/AqHkX2MaXskAIPHWHFaEb5mhjhxKeANnSbqVzTDJnQFz+PLKhqqhk3P4wVt2cl
         j50P2jqPuqIL89tF/G3hLuSepQryIV1Xt8KcY7M+JOWJb9ZgGeGY4N3ib47953tWGEFE
         1trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=teBQeOT91KCycbwR1NXpfOu+f4cArq/biIYpDRwOKP4=;
        b=FQ/HlZDro74xqxJp3aHoskyz6jzQWno1/GZeT6Bs0iIzvhJ3xovISv0AL39GsKXi4n
         tqqKfax+iWjl1AwedCOom1xsISZutisbLvIIgq/xWe5e6xaKYviyH5AKJWKgqcm024x2
         RhEhV9oIWsS7gB/gmWA50/SZ1XrtR35aUbxIWl+EUFFp+ElRCjltRPzMsO93jF+2sdh+
         Gm/7f3B2vHKumhfCK+WhUyeT7WpL/nfdIopzb/NrKGz572pzB4KqfsHq48fT2x8zHjER
         TnASGri++F90trytX2cYvFxTdS0CccDEt59m4A7KyJshRj5JPH+v0siLPJT7aZsdT8u7
         nyCw==
X-Gm-Message-State: AOUpUlEeQ8YTXi+t5TZzVCqwBnhMoQep5cAHbsdCCHuEzrBndIgUlrN5
        ILwvwqV0VgVlbDH3Duu5Vd0sA3UQ
X-Google-Smtp-Source: AA+uWPzxSUUuPdHh/TcNHPj8AdnKMtaN/dd5upX1Yps9BvLVI7ZVk2r2VfGou9dPAPOgQWh4M0m+og==
X-Received: by 2002:adf:f60a:: with SMTP id t10-v6mr1685909wrp.170.1533830167824;
        Thu, 09 Aug 2018 08:56:07 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id t69-v6sm10913762wmt.40.2018.08.09.08.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 08:56:07 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 8/8] pack-objects: move 'layer' into 'struct packing_data'
Date:   Thu,  9 Aug 2018 17:55:32 +0200
Message-Id: <20180809155532.26151-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.555.g17f9c4abba
In-Reply-To: <20180809155532.26151-1-chriscool@tuxfamily.org>
References: <20180809155532.26151-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reduces the size of 'struct object_entry' from 88 bytes
to 80 and therefore makes packing objects more efficient.

For example on a Linux repo with 12M objects,
`git pack-objects --all` needs extra 96MB memory even if the
layer feature is not used.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c |  4 ++--
 delta-islands.c        |  4 ++--
 pack-objects.c         |  6 ++++++
 pack-objects.h         | 20 ++++++++++++++++++--
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index fd3e514b31..d5d91eeed5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -611,7 +611,7 @@ static inline void add_to_write_order(struct object_entry **wo,
 			       unsigned int *endp,
 			       struct object_entry *e)
 {
-	if (e->filled || e->layer != write_layer)
+	if (e->filled || oe_layer(&to_pack, e) != write_layer)
 		return;
 	wo[(*endp)++] = e;
 	e->filled = 1;
@@ -714,7 +714,7 @@ static void compute_layer_order(struct object_entry **wo, unsigned int *wo_end)
 	 * Finally all the rest in really tight order
 	 */
 	for (i = last_untagged; i < to_pack.nr_objects; i++) {
-		if (!objects[i].filled && objects[i].layer == write_layer)
+		if (!objects[i].filled && oe_layer(&to_pack, &objects[i]) == write_layer)
 			add_family_to_write_order(wo, wo_end, &objects[i]);
 	}
 }
diff --git a/delta-islands.c b/delta-islands.c
index 3c8fe60801..92137f2eca 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -492,13 +492,13 @@ int compute_pack_layers(struct packing_data *to_pack)
 		struct object_entry *entry = &to_pack->objects[i];
 		khiter_t pos = kh_get_sha1(island_marks, entry->idx.oid.hash);
 
-		entry->layer = 1;
+		oe_set_layer(to_pack, entry, 1);
 
 		if (pos < kh_end(island_marks)) {
 			struct island_bitmap *bitmap = kh_value(island_marks, pos);
 
 			if (island_bitmap_get(bitmap, island_counter_core))
-				entry->layer = 0;
+				oe_set_layer(to_pack, entry, 0);
 		}
 	}
 
diff --git a/pack-objects.c b/pack-objects.c
index 30314572e6..98389460c2 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -163,6 +163,9 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 
 		if (pdata->tree_depth)
 			REALLOC_ARRAY(pdata->tree_depth, pdata->nr_alloc);
+
+		if (pdata->layer)
+			REALLOC_ARRAY(pdata->layer, pdata->nr_alloc);
 	}
 
 	new_entry = pdata->objects + pdata->nr_objects++;
@@ -181,5 +184,8 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 	if (pdata->tree_depth)
 		pdata->tree_depth[pdata->nr_objects - 1] = 0;
 
+	if (pdata->layer)
+		pdata->layer[pdata->nr_objects - 1] = 0;
+
 	return new_entry;
 }
diff --git a/pack-objects.h b/pack-objects.h
index 3cb5527eeb..ad3c208764 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -101,8 +101,6 @@ struct object_entry {
 	unsigned no_try_delta:1;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
 
-	unsigned char layer;
-
 	unsigned preferred_base:1; /*
 				    * we do not pack this, but is available
 				    * to be used as the base object to delta
@@ -147,6 +145,7 @@ struct packing_data {
 
 	/* delta islands */
 	unsigned int *tree_depth;
+	unsigned char *layer;
 };
 
 void prepare_packing_data(struct packing_data *pdata);
@@ -369,4 +368,21 @@ static inline void oe_set_tree_depth(struct packing_data *pack,
 	pack->tree_depth[e - pack->objects] = tree_depth;
 }
 
+static inline unsigned char oe_layer(struct packing_data *pack,
+				     struct object_entry *e)
+{
+	if (!pack->layer)
+		return 0;
+	return pack->layer[e - pack->objects];
+}
+
+static inline void oe_set_layer(struct packing_data *pack,
+				struct object_entry *e,
+				unsigned char layer)
+{
+	if (!pack->layer)
+		ALLOC_ARRAY(pack->layer, pack->nr_objects);
+	pack->layer[e - pack->objects] = layer;
+}
+
 #endif
-- 
2.18.0.555.g17f9c4abba


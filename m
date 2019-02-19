Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D6721F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbfBSAFr (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:05:47 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34626 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732147AbfBSAFo (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:05:44 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 49FD060997;
        Tue, 19 Feb 2019 00:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534743;
        bh=dirQ7xr11Sisxi8H2UaPZ7PLORagH7dGcrdo9rD/WUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=D6NKZLPatxVHGVKn+3z8MILEHGMAD5HGE2jifPG5sBmHrWabwSZT9OGaUQVfwX82P
         aQcqypiZj2xWBjUEYbabPvZyA3XDxqaz91BtnV1OZRWB0vfLQBH0ObwLRome3SS0D+
         2zTrPhmVnDGhTKyuGiEGjonoFEqNeEMTEAE6hJt9yvJLjOgMJC3c2FlXs93PUKAV5V
         THgDG6qj8/krbQMHPnvuClBpMBQMMAfnm3QyfHr+CcFaanpEIhk+lqXoRw3/m2205c
         h/kBfPDxf8SbVICIG0qcPttLx1QZ8KFoQPU2whw9RMSGXMKC9fjge2CIn6OuhiGanD
         MQGy/Zi2gw2JZJ6GSQUHH2PcXt2VT1be8vwLGmlEb2f8T/NeT/7cC6uIvP1AhVGCSt
         ZhkzWwB5uSD5bPQaK1Nmn5yfXyPkDJk48GcnpU1fRKaAPRJpBJPXWBygz7yZtAvyJB
         QN1dGQO39JadKfqLx5WAMbadmW1hN7ARYf30xZx+Y4/mmYbMYbK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 06/35] pack-bitmap: switch hard-coded constants to the_hash_algo
Date:   Tue, 19 Feb 2019 00:04:57 +0000
Message-Id: <20190219000526.476553-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190219000526.476553-1-sandals@crustytoothpaste.net>
References: <20190219000526.476553-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch two hard-coded uses of 20 to references to the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 pack-bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 6d6fa68563..603492c237 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -138,7 +138,7 @@ static int load_bitmap_header(struct bitmap_index *index)
 {
 	struct bitmap_disk_header *header = (void *)index->map;
 
-	if (index->map_size < sizeof(*header) + 20)
+	if (index->map_size < sizeof(*header) + the_hash_algo->rawsz)
 		return error("Corrupted bitmap index (missing header data)");
 
 	if (memcmp(header->magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE)) != 0)
@@ -157,7 +157,7 @@ static int load_bitmap_header(struct bitmap_index *index)
 				"(Git requires BITMAP_OPT_FULL_DAG)");
 
 		if (flags & BITMAP_OPT_HASH_CACHE) {
-			unsigned char *end = index->map + index->map_size - 20;
+			unsigned char *end = index->map + index->map_size - the_hash_algo->rawsz;
 			index->hashes = ((uint32_t *)end) - index->pack->num_objects;
 		}
 	}

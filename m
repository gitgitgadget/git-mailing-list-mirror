Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 408D51F424
	for <e@80x24.org>; Sat, 31 Mar 2018 10:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753222AbeCaKDm (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 06:03:42 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38365 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753179AbeCaKDk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 06:03:40 -0400
Received: by mail-lf0-f65.google.com with SMTP id u3-v6so15106997lff.5
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 03:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9b5Q2eyewgzbIkgrNxcqR6QvpMjm0xbhgveRl39SWE4=;
        b=i02m3STx9MVbZyRKw11U15P22h8/PA/66RsOb+AtcDr6jg1B1xnaRk4Cvj/ZGQZBFb
         Byje0goWBv5FngapbKXKw7j8/syGunuhA0mM3LMiSCF9MhFO+h5K74am0HuQ5AMQmdIZ
         9AncHe3Kqga4tCA6cSZcMIXorRIDMdA10jW5YkB7iSwh3zi/OTK0Q/4kzV/6qqO2yvpz
         Mc+GMDlz/zYJoTGKpHSpd/9WuelS+H94ULeLPBGw6YaogTFnMmxHnXbSnX4ke2NRTZ5A
         Mf5NasLtvNR8zHtnFtfgBvyM/6IQopki7uJeXWq36dY4Z6NvTFm/uIXlJngNbLpt5Dpv
         RT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9b5Q2eyewgzbIkgrNxcqR6QvpMjm0xbhgveRl39SWE4=;
        b=mLWN6h+x7zASMm7pg28Wk6MQYmWgsDqR9wRZZvg7WY/3UYnYHnAX2QpTl8Db5Cjbvc
         atyhwrKc+8cTWuME1vxKqyup8IITGOQYi2BC3XuIdwDZlWevnHLKt1ga9KD49j475JFy
         IUc9dCFZFJQuA3uqg+ZtqDtCuhjq0yF68v1S5/UmA3HIpQOApTKznhRkf3xJweOpUdWP
         8TybUM/yzJwteO8XaXerS935vCZ/iqsqvTCUet99sEf1vPJOvVEA0RqbXYBWGPsj96m+
         58xpeksZUVji+sDGuxcAhCaJTEV1DTqMGtx/klYFvKCfboODOrwZ6sfQZ6Eg7nDwYZCj
         qwRQ==
X-Gm-Message-State: ALQs6tC6+nkH+pkhLKeVoN6mQuxswEG815yowzmfpOtuLgiOiI9P4sBj
        Q+1ByxnXMfk2MyiskJvBvWw=
X-Google-Smtp-Source: AIpwx4/Ib1ogf/H64sewdgHCHOyx9tLOEt7NyTvUwTIA2DnKEZf2K6+IzcHv7q12t4XDLFgAyght9Q==
X-Received: by 10.46.129.67 with SMTP id t3mr1475060ljg.123.1522490619082;
        Sat, 31 Mar 2018 03:03:39 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id a1sm1799175ljj.90.2018.03.31.03.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Mar 2018 03:03:38 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v8 14/15] pack-objects: reorder members to shrink struct object_entry
Date:   Sat, 31 Mar 2018 12:03:10 +0200
Message-Id: <20180331100311.32373-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc2.515.g4feb9b7923
In-Reply-To: <20180331100311.32373-1-pclouds@gmail.com>
References: <20180324063353.24722-1-pclouds@gmail.com>
 <20180331100311.32373-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previous patches leave lots of holes and padding in this struct. This
patch reorders the members and shrinks the struct down to 80 bytes
(from 136 bytes on 64-bit systems, before any field shrinking is done)
with 16 bits to spare (and a couple more in in_pack_header_size when
we really run out of bits).

This is the last in a series of memory reduction patches (see
"pack-objects: a bit of document about struct object_entry" for the
first one).

Overall they've reduced repack memory size on linux-2.6.git from
3.747G to 3.424G, or by around 320M, a decrease of 8.5%. The runtime
of repack has stayed the same throughout this series. Ævar's testing
on a big monorepo he has access to (bigger than linux-2.6.git) has
shown a 7.9% reduction, so the overall expected improvement should be
somewhere around 8%.

See 87po42cwql.fsf@evledraar.gmail.com on-list
(https://public-inbox.org/git/87po42cwql.fsf@evledraar.gmail.com/) for
more detailed numbers and a test script used to produce the numbers
cited above.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 pack-objects.h | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/pack-objects.h b/pack-objects.h
index b5114a70a7..60192cce1f 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -26,6 +26,10 @@ enum dfs_state {
 };
 
 /*
+ * The size of struct nearly determines pack-objects's memory
+ * consumption. This struct is packed tight for that reason. When you
+ * add or reorder something in this struct, think a bit about this.
+ *
  * basic object info
  * -----------------
  * idx.oid is filled up before delta searching starts. idx.crc32 is
@@ -74,34 +78,44 @@ enum dfs_state {
  */
 struct object_entry {
 	struct pack_idx_entry idx;
+	void *delta_data;	/* cached delta (uncompressed) */
+	off_t in_pack_offset;
+	uint32_t hash;			/* name hint hash */
 	unsigned size_:OE_SIZE_BITS;
 	unsigned size_valid:1;
-	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
-	off_t in_pack_offset;
 	uint32_t delta_idx;	/* delta base object */
 	uint32_t delta_child_idx; /* deltified objects who bases me */
 	uint32_t delta_sibling_idx; /* other deltified objects who
 				     * uses the same base as me
 				     */
-	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
 	unsigned delta_size_valid:1;
+	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	unsigned z_delta_size:OE_Z_DELTA_BITS;
+	unsigned type_valid:1;
 	unsigned type_:TYPE_BITS;
+	unsigned no_try_delta:1;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
-	unsigned type_valid:1;
-	uint32_t hash;			/* name hint hash */
-	unsigned char in_pack_header_size;
 	unsigned preferred_base:1; /*
 				    * we do not pack this, but is available
 				    * to be used as the base object to delta
 				    * objects against.
 				    */
-	unsigned no_try_delta:1;
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 	unsigned dfs_state:OE_DFS_STATE_BITS;
+	unsigned char in_pack_header_size;
 	unsigned depth:OE_DEPTH_BITS;
+
+	/*
+	 * pahole results on 64-bit linux (gcc and clang)
+	 *
+	 *   size: 80, bit_padding: 20 bits, holes: 8 bits
+	 *
+	 * and on 32-bit (gcc)
+	 *
+	 *   size: 76, bit_padding: 20 bits, holes: 8 bits
+	 */
 };
 
 struct packing_data {
-- 
2.17.0.rc2.515.g4feb9b7923


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC7CC1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 18:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752983AbeCPSc6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 14:32:58 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38555 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752902AbeCPScy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 14:32:54 -0400
Received: by mail-lf0-f66.google.com with SMTP id y2-v6so14615733lfc.5
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 11:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/lzjBJxVWQyEuODWrYYmtWPaL184/nRJIQ5NJGrUsuc=;
        b=GPF/DM5wCXpXuZe3IaZCtvFzkUIkU8XFUGKg/SbjM9upbnD3Mfqri9JSC1eTKyUEOl
         Q8yAA+GEHX0pdxgJxxPszRszpF7+qGhqcoKB0a0laXDXf/zUux7EYrhMOjzn7d1/Aapy
         eAnJ4cI6sZBAICIdedz93ZBG180M28mGNhgjELlN50NXXnRn9y1iiR738HMQxAxVzf5g
         ZzcHOQVsGC4eIJvpy/Iy2fIhHX3Vt1ZkcCkeMrQj43YKDZ26PTeMG709fsuVfBxqhGvP
         6oU2GuX+rqfR0yW53lmUqq8ZLQBYvNRIWEgQ2HjYwVL8SPU2m1zRJTfycAs47iUdP88+
         af0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/lzjBJxVWQyEuODWrYYmtWPaL184/nRJIQ5NJGrUsuc=;
        b=Cd3QEah/tsXlh1xMhnjjq2H0+ubXMvj92J5MF1R3EUea2Jti5uOTPS5D2wccQUAlCI
         jDKqEJc7LgJV/ris7n+HsTvltRzRTyq79RMZwl+SnKwAbBLE6WgTsMbFnefD6hV3rCs5
         koo0CXc3JDbQi+ACBmR8X6KgsMsW6vrFLeSzEaQVakRAcbS+hdoWidBHmMKrVY8hgm2f
         5sDRBnRQgpX5001wY3KYLD1Ljtm1zk8XuZckgV59GvIKlQALeKZFNHgtenqsnTc1IrT/
         yJMx9DLtdgfgHMoU2hlQAvsQ8hi3eA4PW8stpJ0MQkBK1ZMZwglVj3lmTL9udOajVYGF
         YPyA==
X-Gm-Message-State: AElRT7G484lq1Kqh+IWX7aLe84zJIc2ec2Hh4YYe+U8FZfsHZhtrgflc
        zLDQAdZVzXxNFt9kJ8UTRyY=
X-Google-Smtp-Source: AG47ELtP9M1KXq2a81QxlBWG4JERIKOLgvNUXqymy5iPBMd/Tk8L4Jk25yy+B97J5MQmd+W/b+4eGA==
X-Received: by 10.46.125.10 with SMTP id y10mr2129549ljc.23.1521225173244;
        Fri, 16 Mar 2018 11:32:53 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j199-v6sm1033275lfe.53.2018.03.16.11.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Mar 2018 11:32:52 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v4 08/11] pack-objects: shrink z_delta_size field in struct object_entry
Date:   Fri, 16 Mar 2018 19:31:57 +0100
Message-Id: <20180316183200.31014-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180316183200.31014-1-pclouds@gmail.com>
References: <20180308114232.10508-1-pclouds@gmail.com>
 <20180316183200.31014-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We only cache deltas when it's smaller than a certain limit. This limit
defaults to 1000 but save its compressed length in a 64-bit field.
Shrink that field down to 16 bits, so you can only cache 65kb deltas.
Larger deltas must be recomputed at when the pack is written down.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt |  3 ++-
 builtin/pack-objects.c   | 22 ++++++++++++++++------
 pack-objects.h           |  3 ++-
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9bd3f5a789..00fa824448 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2449,7 +2449,8 @@ pack.deltaCacheLimit::
 	The maximum size of a delta, that is cached in
 	linkgit:git-pack-objects[1]. This cache is used to speed up the
 	writing object phase by not having to recompute the final delta
-	result once the best match for all objects is found. Defaults to 1000.
+	result once the best match for all objects is found.
+	Defaults to 1000. Maximum value is 65535.
 
 pack.threads::
 	Specifies the number of threads to spawn when searching for best
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cdbad57082..9a0962cf31 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2105,12 +2105,19 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		 * between writes at that moment.
 		 */
 		if (entry->delta_data && !pack_to_stdout) {
-			entry->z_delta_size = do_compress(&entry->delta_data,
-							  entry->delta_size);
-			cache_lock();
-			delta_cache_size -= entry->delta_size;
-			delta_cache_size += entry->z_delta_size;
-			cache_unlock();
+			unsigned long size;
+
+			size = do_compress(&entry->delta_data, entry->delta_size);
+			entry->z_delta_size = size;
+			if (entry->z_delta_size == size) {
+				cache_lock();
+				delta_cache_size -= entry->delta_size;
+				delta_cache_size += entry->z_delta_size;
+				cache_unlock();
+			} else {
+				FREE_AND_NULL(entry->delta_data);
+				entry->z_delta_size = 0;
+			}
 		}
 
 		/* if we made n a delta, and if n is already at max
@@ -3089,6 +3096,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (depth >= (1 << OE_DEPTH_BITS))
 		die(_("delta chain depth %d is greater than maximum limit %d"),
 		    depth, (1 << OE_DEPTH_BITS));
+	if (cache_max_small_delta_size >= (1 << OE_Z_DELTA_BITS))
+		die(_("pack.deltaCacheLimit is greater than maximum limit %d"),
+		    1 << OE_Z_DELTA_BITS);
 
 	argv_array_push(&rp, "pack-objects");
 	if (thin) {
diff --git a/pack-objects.h b/pack-objects.h
index 7f32de2a35..a66c37e35a 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -4,6 +4,7 @@
 #define OE_DFS_STATE_BITS	2
 #define OE_DEPTH_BITS		12
 #define OE_IN_PACK_BITS		14
+#define OE_Z_DELTA_BITS		16
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -78,7 +79,7 @@ struct object_entry {
 				     */
 	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
-	unsigned long z_delta_size;	/* delta data size (compressed) */
+	unsigned z_delta_size:OE_Z_DELTA_BITS;
 	unsigned type_:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
 	unsigned type_valid:1;
-- 
2.16.2.903.gd04caf5039


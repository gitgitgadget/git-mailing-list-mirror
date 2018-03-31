Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 137AA1F424
	for <e@80x24.org>; Sat, 31 Mar 2018 10:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeCaKDi (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 06:03:38 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40132 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752442AbeCaKDd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 06:03:33 -0400
Received: by mail-lf0-f68.google.com with SMTP id e5-v6so15128202lfb.7
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 03:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=55RsGGjInz12+CEOvcgNTAVILUAqajn/xrPXHoR5gwQ=;
        b=DgVGKxoRpCmxMR4zLINIHzAa6hyjBf9yPg87bgY2X61jVevWjpJZBp0QlKVepJDt+T
         4r2naKNm8TC6nbwNOTUTiz4Y96ddHbZn1OGcw8VOyBsyJ6fKmb80hDj2yzGahTnIb2tJ
         EITq3ngCjRtbfOuMWQeSU7rvidMPH5bccxhSo15INt8ucjInqZzv38Tt7gDokkTfs16Y
         EFHbj2tQZwHu65mko2MhXaUZbLm1PhO9n0HsIsTy+T4L7VGCd9nPJQdPJQIBBPGpF2fU
         uKuylab78OwQL+3EMPqDU24BKAGwm2qh4eizp3lRYbOlT3h4hiQmanXoL2PG8Jos8oVX
         lE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=55RsGGjInz12+CEOvcgNTAVILUAqajn/xrPXHoR5gwQ=;
        b=r1d78IjZcDFHHfxop1TtvMZejADkRW234BvBrUiNaMl22tUonyJHitEZdtvwxDqClJ
         CZfVp7wlvrpxnDQdU54xlrb4A/Xn3+icaBAEupLTTgkBW3cCNZPtdHNHOowCjK+MM8SX
         D8AxnepPswsMjtF5BxeI+aY3NWoB4dlSvVJhIH9mvQtYdFKrmK9VJgy30WyTkOALjNUc
         YGPf+6ZGVn0KyTrsmWi/JkzlBTSqNsvXDxs2F4cLdWfJOfMRO8J6269mkBqaatwH30bO
         cwrISo/AmXDydXW3IgJ1MRccSwkha36gL4CAWJUnehNpEFbPO1RPUmjC509BRkRLJAUy
         ZXlQ==
X-Gm-Message-State: ALQs6tAn5J5q30TTpzk0l0uIFlQAl/aHvO14G5m3NhB493/offKAsbnC
        zyCJXtKOfyamV/Dn+s2IPYkSRA==
X-Google-Smtp-Source: AIpwx48wkFMfo7kprlc/x6LurbN5aUF4ZZoFEPYAmucQRmQ7Zypl+zfqOr4hYBz+w5SLgo4uFO6Sig==
X-Received: by 10.46.151.136 with SMTP id y8mr1508776lji.84.1522490612324;
        Sat, 31 Mar 2018 03:03:32 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id a1sm1799175ljj.90.2018.03.31.03.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Mar 2018 03:03:31 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v8 09/15] pack-objects: shrink z_delta_size field in struct object_entry
Date:   Sat, 31 Mar 2018 12:03:05 +0200
Message-Id: <20180331100311.32373-10-pclouds@gmail.com>
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

We only cache deltas when it's smaller than a certain limit. This limit
defaults to 1000 but save its compressed length in a 64-bit field.
Shrink that field down to 20 bits, so you can only cache 1MB deltas.
Larger deltas must be recomputed at when the pack is written down.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt |  3 ++-
 builtin/pack-objects.c   | 24 ++++++++++++++++++------
 pack-objects.h           |  3 ++-
 3 files changed, 22 insertions(+), 8 deletions(-)

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
index 118c8fd993..34e285a1b7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2100,12 +2100,19 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
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
+			if (size < (1U << OE_Z_DELTA_BITS)) {
+				entry->z_delta_size = size;
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
@@ -3086,6 +3093,11 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			depth, (1 << OE_DEPTH_BITS) - 1);
 		depth = (1 << OE_DEPTH_BITS) - 1;
 	}
+	if (cache_max_small_delta_size >= (1U << OE_Z_DELTA_BITS)) {
+		warning(_("pack.deltaCacheLimit is too high, forcing %d"),
+			(1U << OE_Z_DELTA_BITS) - 1);
+		cache_max_small_delta_size = (1U << OE_Z_DELTA_BITS) - 1;
+	}
 
 	argv_array_push(&rp, "pack-objects");
 	if (thin) {
diff --git a/pack-objects.h b/pack-objects.h
index 272ddeeedb..5613a3d040 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -4,6 +4,7 @@
 #define OE_DFS_STATE_BITS	2
 #define OE_DEPTH_BITS		12
 #define OE_IN_PACK_BITS		10
+#define OE_Z_DELTA_BITS		20
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -75,7 +76,7 @@ struct object_entry {
 				     */
 	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
-	unsigned long z_delta_size;	/* delta data size (compressed) */
+	unsigned z_delta_size:OE_Z_DELTA_BITS;
 	unsigned type_:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
 	unsigned type_valid:1;
-- 
2.17.0.rc2.515.g4feb9b7923


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A90721FAE2
	for <e@80x24.org>; Sat, 17 Mar 2018 14:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753017AbeCQOK7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 10:10:59 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33225 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752662AbeCQOK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 10:10:58 -0400
Received: by mail-lf0-f65.google.com with SMTP id x205-v6so19351456lfa.0
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 07:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3e79hPnJ3+PWtCoSlt/jiSJ40dVjaXf5dyjhxyZbE0U=;
        b=omYjXbxnmzukzUemwhwfr3JPh59o4W518YzryGlM8L2XIi1uoqR0+TXAaLxqh4lDMj
         /6PGKbLUGi770rh6mBN1Z7q11i+BARDV4lUQz0tR1v17PQ8kF8l4qcAO6PerXYuW8Hwt
         WWW4x2W1cZcDBQ0ktexL7eTl4JgJw61rxAEYTZTanA2ND9Ue1Fk0egrWFQ3M0EACR8cw
         AHAovUo3KnED3ydOOgVlBRh3Bs1xKKe40EV4fLmiNUpdgQG6eTTxRsH7hafI2Zvnklk/
         TnLhPvQV/56q2JJ6SHk6FoNB0X7bflsxIJabjRj3FBdN169KOrazef44nSa9M4B9VqUa
         pMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3e79hPnJ3+PWtCoSlt/jiSJ40dVjaXf5dyjhxyZbE0U=;
        b=OzkzPuIQTw4KVnle3HQPZ/4gyrxiVDE8LANFLrZUYMB9yvmJRPcFVHZ80RYwlv4CL/
         K7cArdfpvaiup5udcpbIRPH7Sb6jZ08FXq8jiKCr5aLe2d7MZ5Mk/s7kgclzkCZqHzYz
         F6fk0y01vtExDC45PYps4abL+GeaT0LabKHndK6m+ySX3xdwfp2WaXHV+GeyxzIqS95j
         wYjILTPNMaEUwLUPpaX2u3zbZg5BdZQizR124ePl2stFLNdboCjRSNn/+XMMEVV7yu/e
         bE2mrx+ij2K3CuKVC4vyfWnULxvwXfHdfDoGsCYH89QgO+6cPx3Qb3ocAX422FIk3C+L
         gz2A==
X-Gm-Message-State: AElRT7E5cVZEecFKd64b5kJEpoOSOAD+dTxEduh4TT5vkQD6wNxPJSty
        gC/nUWQ8hogAdx9JJMmm40w=
X-Google-Smtp-Source: AG47ELsMlcLSbCN6chRqoJz0onF23oJR8/DAC5McFzBPEhnL8+fsG1yLK0qLWMi3vCXrgRQ7kSmOHg==
X-Received: by 2002:a19:e59d:: with SMTP id i29-v6mr4189399lfk.66.1521295856577;
        Sat, 17 Mar 2018 07:10:56 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f7-v6sm625648lfb.2.2018.03.17.07.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 07:10:55 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v5 08/11] pack-objects: shrink z_delta_size field in struct object_entry
Date:   Sat, 17 Mar 2018 15:10:30 +0100
Message-Id: <20180317141033.21545-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.347.gf9cf61673a
In-Reply-To: <20180317141033.21545-1-pclouds@gmail.com>
References: <20180316183200.31014-1-pclouds@gmail.com>
 <20180317141033.21545-1-pclouds@gmail.com>
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
index 379bd1ab92..71ca1ba2ce 100644
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
+			if (size < (1 << OE_Z_DELTA_BITS)) {
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
index 0b831c8f12..63222a76b0 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -4,6 +4,7 @@
 #define OE_DFS_STATE_BITS	2
 #define OE_DEPTH_BITS		12
 #define OE_IN_PACK_BITS		14
+#define OE_Z_DELTA_BITS		16
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -79,7 +80,7 @@ struct object_entry {
 				     */
 	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
-	unsigned long z_delta_size;	/* delta data size (compressed) */
+	unsigned z_delta_size:OE_Z_DELTA_BITS;
 	unsigned type_:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
 	unsigned type_valid:1;
-- 
2.17.0.rc0.347.gf9cf61673a


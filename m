Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E16B81F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 06:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751872AbeCXGen (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 02:34:43 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38523 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbeCXGeR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 02:34:17 -0400
Received: by mail-lf0-f66.google.com with SMTP id u3-v6so353175lff.5
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 23:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=09s8l5QA+IbTyNs8hB+A7GbwOo0KHukXvYBmP6Uqa44=;
        b=vKqtIuJNxKyqgWUUvpTw0YkVsh/O6B1sx0sUie4EhqJ+/BkBaLkU7S0biLg+n9w5mH
         8qv41JyeCrZu9BOJbY2RxWHy1ebLvVsOr/ThvPQW3SyTM3P9C9V88C3MrGfJpcoDMVbj
         ydIcqqghLcybUk+/Y6xi1b+rX3Ej15VHa4acSg+jQbPsw5qxczoWG2dzou33+DwlJAmU
         yCe/QzgSICZNFrVTdKhMcHhoDTkkhuxvrlERiFBOBfY/JzCXywO7uXftyp120QFNqUR0
         ni/9pOmjmAfcTDH1PvsvyBUcI/oFm1cq4UUubzpwPNnkfIElA4XV2n4gSem53OPar4Q+
         e2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=09s8l5QA+IbTyNs8hB+A7GbwOo0KHukXvYBmP6Uqa44=;
        b=qTu1z6cWE+dpelsQlrgCPRG7W5NuCKXAfneugmjDAl8sqZePRtQQb657a9CDcnBgA/
         /qJawtr8DplMAUs8AaYwGoi0vuuMrmaPhC2u1FU0troaGhaSWH9qLgapojRB+dE3MRzA
         M7HpImvYCmraHMbHd0k2RQc1o5mu9L6MAOaPwmb3b7lF8Qe8HflhjydhEDavYoRdlBan
         r5paD/BFi/EiFoLRSzb0y+nKEymfWn2RNU0OactcWsSyn1yi5S2duNCJ43IbwwtKgYJO
         3MzXoA36vMnkd+Vcpo5RSi0Ft4PObi/KIgVptlrYljsr3aIYlWuYNWENDNruq5/gfnMF
         XyTQ==
X-Gm-Message-State: AElRT7HbVysPb8rzS0pYqF475R8XhftLsHI42OFyoeWPsV2Bv4dOMQXY
        CONpIbUe0jOyXjEIQhcNzGk=
X-Google-Smtp-Source: AG47ELvmb2qIMOOHXuslQPWQccdVfu1aUL0SmVUnsqbNM6pJZ8DTg8HOdI8SkA721a4d179QQKDcXQ==
X-Received: by 2002:a19:5055:: with SMTP id z21-v6mr16152966lfj.4.1521873255795;
        Fri, 23 Mar 2018 23:34:15 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h8sm2251703lja.41.2018.03.23.23.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 23:34:14 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v7 08/13] pack-objects: shrink z_delta_size field in struct object_entry
Date:   Sat, 24 Mar 2018 07:33:48 +0100
Message-Id: <20180324063353.24722-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324063353.24722-1-pclouds@gmail.com>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
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
index f7d3f6a1a8..b3e19815f1 100644
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
@@ -3084,6 +3091,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (depth >= (1 << OE_DEPTH_BITS))
 		die(_("delta chain depth %d is greater than maximum limit %d"),
 		    depth, (1 << OE_DEPTH_BITS) - 1);
+	if (cache_max_small_delta_size >= (1 << OE_Z_DELTA_BITS))
+		die(_("pack.deltaCacheLimit is greater than maximum limit %d"),
+		    (1 << OE_Z_DELTA_BITS) - 1);
 
 	argv_array_push(&rp, "pack-objects");
 	if (thin) {
diff --git a/pack-objects.h b/pack-objects.h
index 433c194ffe..415b961245 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -4,6 +4,7 @@
 #define OE_DFS_STATE_BITS	2
 #define OE_DEPTH_BITS		12
 #define OE_IN_PACK_BITS		10
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
2.17.0.rc0.348.gd5a49e0b6f


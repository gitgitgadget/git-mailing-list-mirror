Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E69E11F404
	for <e@80x24.org>; Sun, 18 Mar 2018 14:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754382AbeCROZ5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 10:25:57 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39202 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754340AbeCROZu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 10:25:50 -0400
Received: by mail-lf0-f68.google.com with SMTP id f75-v6so21709859lfg.6
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 07:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jjdBwZk/uRVbuib44j2M/r2BKmF+T0It1+mMJc34XVk=;
        b=cNF8kz+pKZf1vxtFubCqxY1+rV/48Bpetkwggau1r1n4/RFkbSDBwYgyi0GL/nNP/6
         HiR1G/m+gn+jOqGSfCzvQqEq0yYr4FNFj+9FIGPeYNLfukR/jzpMtm6W8HZzjZkjj2e+
         DbXuILwVMIK2tRYCIycJ1aTIUhE7yZIP4baXqPDMp2lpeoBioJIiZX3BnODTb+70nclN
         SaY/MbGItjCtxq5LLw0kkO5WvMpVLKvlIS3Z3mBxkCy9C6HCmieIcu8+kaveS51C8u3L
         yG7xCslnfhwfbFD+u5QpG+K0eDINBEZfk3pWn+o9UfXzqZ48yvq25hzPuz+0wK0VFmwy
         SkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jjdBwZk/uRVbuib44j2M/r2BKmF+T0It1+mMJc34XVk=;
        b=bL39YqogoJPyIdvSPQbBDWjoB59oeRjRVRLcgXbeyDHBXhK2BYuH/Fc61r27wZ7vv6
         2V6S11NHc8HXZfLIfZRb7WwWF/szG4brEs4SLH04yKRWMeG0BnLhtryJ0lr1KyxYYQe8
         4LsdNL6cG+cdcr8Tkzin4A35k7Bd/KmwTE8uLJi5oVzrP9e9x+b4Rg2GWcQlkwSrFXmu
         ooQSvrvThH84vWDxVVuXAQ9vHVDGvvqGzItwZQo4RSnS3yvuIFWKDuV1uLNha44PYvD4
         GcP/IA3MENErq4m3CrhGYUyeBN//PajjocjtJpSWINtAq2ulq6p2wkW5elpf0QHD30PL
         vXlw==
X-Gm-Message-State: AElRT7Fw7OyxDxZ0LV32VZrK33KoPFJv4hOSWO6fruLwm6n5YAuS3+7b
        Op87WuvlR7lTVraEXsz8qms=
X-Google-Smtp-Source: AG47ELvaGjnpNXj90FamBculLhBvPc4zSF0s/Ru6DIlK3z0/LT5tZ8ngxCTIT2iF6QIt3NGbaHlg9A==
X-Received: by 2002:a19:519a:: with SMTP id g26-v6mr5664433lfl.50.1521383149359;
        Sun, 18 Mar 2018 07:25:49 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n24sm2551554ljg.22.2018.03.18.07.25.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Mar 2018 07:25:48 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v6 08/11] pack-objects: shrink z_delta_size field in struct object_entry
Date:   Sun, 18 Mar 2018 15:25:23 +0100
Message-Id: <20180318142526.9378-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.347.gf9cf61673a
In-Reply-To: <20180318142526.9378-1-pclouds@gmail.com>
References: <20180317141033.21545-1-pclouds@gmail.com>
 <20180318142526.9378-1-pclouds@gmail.com>
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
index b39234f7fb..372afe48c4 100644
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
 		    depth, (1 << OE_DEPTH_BITS) - 1);
+	if (cache_max_small_delta_size >= (1 << OE_Z_DELTA_BITS))
+		die(_("pack.deltaCacheLimit is greater than maximum limit %d"),
+		    (1 << OE_Z_DELTA_BITS) - 1);
 
 	argv_array_push(&rp, "pack-objects");
 	if (thin) {
diff --git a/pack-objects.h b/pack-objects.h
index 594a213554..c12219385a 100644
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


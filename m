Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622F41FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 11:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965954AbeCHLnh (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 06:43:37 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42493 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965506AbeCHLng (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 06:43:36 -0500
Received: by mail-pl0-f65.google.com with SMTP id 93-v6so3163930plc.9
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 03:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GyygIoJB0eMEPKisx2ylheuCTtifgSCW/f+yyUz7wRY=;
        b=oQkZq6/50RdFa1axOrEm5494ZCRwThNFWUkVHvT8ofwkOc2H5pOXJD6EmV1fRhGywe
         mJ51WWUnbl9aUoNMHjWfeyDnJI6BL4bu3oTVVUxr5Fia2wi3N45bU09QDSCdLGWwVR1B
         aKWmPpwkTvuMnijVf67ZsuR/FN1TGKxqIj9YvcZfC/x2tu9isHqHH8V9Cvi1j+RI5Ich
         J78Epaq7T7aqok5x/5EMfLUkyWXDWWetsPlZRLwL4ZSDOQHelXWxrHhk8TMQ6qvKYiv0
         pERAerXk+STVB14qhKRy07Vz8IR99fHRwtbOHfI3g7HdoSGCKKKhGkWpvNYajLu4DSj5
         qsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GyygIoJB0eMEPKisx2ylheuCTtifgSCW/f+yyUz7wRY=;
        b=FHFAufqip4RqByKWYJL7PJ0im5LKCDoQOagoCuhKwnUtHHIx33VrsBcPEMv/BxTfqt
         rP4H+37pDkgkn0WmT6/nnU50NH9UrjOb2L0TzVu1f+yEyT3AkoTKlwVlLO30GreDxhzg
         G9JGu+iGECHHE0gkrhZgJOCxy13SklngRUrx1KcKAdNh77DHK/QUsrTxXyZHYSa2TaSi
         EtML6o1wViRrMWmUVhSQwlkcBfiiuFKRY/y9oW+5j65iNspJ8+mkF1m7wq7YpbFYK5vc
         vTyNQbVTMDKJ4PdB8aYfGt+zFcwsRsPYLaxCVq7knlURQxH93xAXc6XhgJnWiMJVuncs
         Piow==
X-Gm-Message-State: APf1xPBimjzAPLmtxXx7tLCr4OnwoY9AQ5tdL4huKHmRYeYdxd8MZ4jv
        bQul0KRcQeF2OprhXNxugt0=
X-Google-Smtp-Source: AG47ELt4LqYmN6vayyyfSBZqUzZBVDVLwpzjslZX04EnIqSps+KzEqF4OR6jzWuPaSefwQCtdE7fYA==
X-Received: by 2002:a17:902:8484:: with SMTP id c4-v6mr23397257plo.271.1520509416155;
        Thu, 08 Mar 2018 03:43:36 -0800 (PST)
Received: from ash ([27.78.177.129])
        by smtp.gmail.com with ESMTPSA id p65sm8782465pfj.61.2018.03.08.03.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 03:43:35 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 08 Mar 2018 18:43:31 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH/RFC v3 10/12] pack-objects: shrink z_delta_size field in struct object_entry
Date:   Thu,  8 Mar 2018 18:42:30 +0700
Message-Id: <20180308114232.10508-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.873.g32ff258c87
In-Reply-To: <20180308114232.10508-1-pclouds@gmail.com>
References: <20180303024706.31465-1-pclouds@gmail.com>
 <20180308114232.10508-1-pclouds@gmail.com>
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

This saves us 8 bytes (some from previous bit padding).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt |  3 ++-
 builtin/pack-objects.c   | 22 ++++++++++++++++------
 pack-objects.h           | 11 ++++++++---
 3 files changed, 26 insertions(+), 10 deletions(-)

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
index 82a4a95888..39920061e9 100644
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
 	if (depth > (1 << OE_DEPTH_BITS))
 		die(_("delta chain depth %d is greater than maximum limit %d"),
 		    depth, (1 << OE_DEPTH_BITS));
+	if (cache_max_small_delta_size >= (1 << OE_Z_DELTA_BITS))
+		die(_("pack.deltaCacheLimit is greater than maximum limit %d"),
+		    1 << OE_Z_DELTA_BITS);
 
 	argv_array_push(&rp, "pack-objects");
 	if (thin) {
diff --git a/pack-objects.h b/pack-objects.h
index 3c15cf7b23..cbb39ab568 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -4,6 +4,7 @@
 #define OE_DFS_STATE_BITS	2
 #define OE_DEPTH_BITS		12
 #define OE_IN_PACK_BITS		14
+#define OE_Z_DELTA_BITS		16
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -80,7 +81,6 @@ struct object_entry {
 	uint32_t hash;			/* name hint hash */
 	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
-	unsigned long z_delta_size;	/* delta data size (compressed) */
 	unsigned char in_pack_header_size; /* note: spare bits available! */
 	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	unsigned type:TYPE_BITS;
@@ -93,13 +93,18 @@ struct object_entry {
 	unsigned no_try_delta:1;
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
-	unsigned dfs_state:OE_DFS_STATE_BITS;
 
 	/* XXX 8 bits hole, try to pack */
 
+	unsigned dfs_state:OE_DFS_STATE_BITS;
 	unsigned depth:OE_DEPTH_BITS;
+	/*
+	 * if delta_data contains a compressed delta, this contains
+	 * the compressed length
+	*/
+	unsigned z_delta_size:OE_Z_DELTA_BITS;
 
-	/* size: 96, bit_padding: 18 bits */
+	/* size: 88, bit_padding: 2 bits */
 };
 
 struct packing_data {
-- 
2.16.2.873.g32ff258c87


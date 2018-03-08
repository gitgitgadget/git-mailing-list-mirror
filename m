Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABB9C1FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 11:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935833AbeCHLnR (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 06:43:17 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46960 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935780AbeCHLnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 06:43:16 -0500
Received: by mail-pl0-f66.google.com with SMTP id y8-v6so3152092pll.13
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 03:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V6/gZlo93m577pV1BC6uWiRq+bICTiPrwl7FQcr6+Ss=;
        b=Vn37C6/ezxeIJ2pP0NgJuYQdYbYXajAR0Vym48Wc4ghMDB2SOcRaKWBuTkwpj3ZLd5
         /couXx4NszAD5nJgzeAwbffU9IQX4ULc7vG/E77xAC00MGp/Qzkv96miB+GN/ugeav1d
         n4NnxpJcVjhSzcQ1EysLDQwXLrp297JCLTgLFgdyPju0FcjfmS+7IzVslOsYDs/ovyGN
         AnqqmoNPahmekasypFHu8ieuU/5kUMRrx1QG8pdu/exQQu/FI1rpRbq1eoX9RL61d5J+
         6Qktf8dWFqfzTmqDAVH6R8xAxj1J1wFi9RdTxxnEFowGkOTv7COFWou1soXmkHiGteWI
         Wb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V6/gZlo93m577pV1BC6uWiRq+bICTiPrwl7FQcr6+Ss=;
        b=cc3y7WNmvMoVbO5Koy6NaBv0UH7xmdNby3v3jbnkRc6W978/e5I6+GwaOqEoDX4PS5
         d61IstKp85CtcDPhamZBeZXntE3Bra044ej/Ol3CWQtoMJOhG4SsBgoxDqqQenzUf5t4
         /IDNHYVIIVMG617rP5xMu2mVcysrMcH62xhYzoZDIjnSe5Et0wgIx7F+3Tw/yWVlGj+I
         09vogv/5x5Di7toOHNPDcV5ggguFUWW66on/YLXXX8PUgts43DfLLofOZEDL/8gL4RP5
         P0CeHeySiyjJM6h5OviCEsB5sdC68mtfFZsguV//p9bnQVrnhwoZUl0Qo03O5ZnHMY/I
         Bmcw==
X-Gm-Message-State: APf1xPDWVBB6DJZ9VVwPZY4uJ2m/7C5XSCLC7m5J4zroEf6XIaeQuXRW
        ZgbxR+vq/cEKvtS+mIluH+8=
X-Google-Smtp-Source: AG47ELsBPMFvU8IsO/hzs87hdMm8rRru3keu7BXsboStPQ32UOl0UObFv/ZibgbL2D4r+dNRG75h4w==
X-Received: by 2002:a17:902:8a89:: with SMTP id p9-v6mr23641564plo.379.1520509396355;
        Thu, 08 Mar 2018 03:43:16 -0800 (PST)
Received: from ash ([27.78.177.129])
        by smtp.gmail.com with ESMTPSA id n7sm33340619pgd.87.2018.03.08.03.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 03:43:15 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 08 Mar 2018 18:43:11 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH/RFC v3 06/12] pack-objects: move in_pack_pos out of struct object_entry
Date:   Thu,  8 Mar 2018 18:42:26 +0700
Message-Id: <20180308114232.10508-7-pclouds@gmail.com>
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

This field is only need for pack-bitmap, which is an optional
feature. Move it to a separate array that is only allocated when
pack-bitmap is used (it's not freed in the same way that objects[] is
not). This saves us 8 bytes in struct object_entry.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c |  3 ++-
 pack-bitmap-write.c    |  8 +++++---
 pack-bitmap.c          |  2 +-
 pack-bitmap.h          |  4 +++-
 pack-objects.h         | 18 ++++++++++++++++--
 5 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cfd97da7db..7bb5544883 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -878,7 +878,8 @@ static void write_pack_file(void)
 
 			if (write_bitmap_index) {
 				bitmap_writer_set_checksum(oid.hash);
-				bitmap_writer_build_type_index(written_list, nr_written);
+				bitmap_writer_build_type_index(
+					&to_pack, written_list, nr_written);
 			}
 
 			finish_tmp_packfile(&tmpname, pack_tmp_name,
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index e01f992884..256a63f892 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -48,7 +48,8 @@ void bitmap_writer_show_progress(int show)
 /**
  * Build the initial type index for the packfile
  */
-void bitmap_writer_build_type_index(struct pack_idx_entry **index,
+void bitmap_writer_build_type_index(struct packing_data *to_pack,
+				    struct pack_idx_entry **index,
 				    uint32_t index_nr)
 {
 	uint32_t i;
@@ -57,12 +58,13 @@ void bitmap_writer_build_type_index(struct pack_idx_entry **index,
 	writer.trees = ewah_new();
 	writer.blobs = ewah_new();
 	writer.tags = ewah_new();
+	ALLOC_ARRAY(to_pack->in_pack_pos, to_pack->nr_objects);
 
 	for (i = 0; i < index_nr; ++i) {
 		struct object_entry *entry = (struct object_entry *)index[i];
 		enum object_type real_type;
 
-		entry->in_pack_pos = i;
+		oe_set_in_pack_pos(to_pack, entry, i);
 
 		switch (entry->type) {
 		case OBJ_COMMIT:
@@ -147,7 +149,7 @@ static uint32_t find_object_pos(const unsigned char *sha1)
 			"(object %s is missing)", sha1_to_hex(sha1));
 	}
 
-	return entry->in_pack_pos;
+	return oe_in_pack_pos(writer.to_pack, entry);
 }
 
 static void show_object(struct object *object, const char *name, void *data)
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9270983e5f..865d9ecc4e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1032,7 +1032,7 @@ int rebuild_existing_bitmaps(struct packing_data *mapping,
 		oe = packlist_find(mapping, sha1, NULL);
 
 		if (oe)
-			reposition[i] = oe->in_pack_pos + 1;
+			reposition[i] = oe_in_pack_pos(mapping, oe) + 1;
 	}
 
 	rebuild = bitmap_new();
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 3742a00e14..5ded2f139a 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -44,7 +44,9 @@ int rebuild_existing_bitmaps(struct packing_data *mapping, khash_sha1 *reused_bi
 
 void bitmap_writer_show_progress(int show);
 void bitmap_writer_set_checksum(unsigned char *sha1);
-void bitmap_writer_build_type_index(struct pack_idx_entry **index, uint32_t index_nr);
+void bitmap_writer_build_type_index(struct packing_data *to_pack,
+				    struct pack_idx_entry **index,
+				    uint32_t index_nr);
 void bitmap_writer_reuse_bitmaps(struct packing_data *to_pack);
 void bitmap_writer_select_commits(struct commit **indexed_commits,
 		unsigned int indexed_commits_nr, int max_bitmaps);
diff --git a/pack-objects.h b/pack-objects.h
index 2ccd6359d2..9ab0ce300d 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -77,7 +77,6 @@ struct object_entry {
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	unsigned long z_delta_size;	/* delta data size (compressed) */
 	uint32_t hash;			/* name hint hash */
-	unsigned int in_pack_pos;
 	unsigned char in_pack_header_size; /* note: spare bits available! */
 	unsigned type:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
@@ -92,7 +91,7 @@ struct object_entry {
 	unsigned dfs_state:OE_DFS_STATE_BITS;
 	unsigned depth:OE_DEPTH_BITS;
 
-	/* size: 120, bit_padding: 8 bits */
+	/* size: 112, bit_padding: 8 bits */
 };
 
 struct packing_data {
@@ -101,6 +100,8 @@ struct packing_data {
 
 	int32_t *index;
 	uint32_t index_size;
+
+	unsigned int *in_pack_pos;
 };
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
@@ -131,4 +132,17 @@ static inline uint32_t pack_name_hash(const char *name)
 	return hash;
 }
 
+static inline unsigned int oe_in_pack_pos(const struct packing_data *pack,
+					  const struct object_entry *e)
+{
+	return pack->in_pack_pos[e - pack->objects];
+}
+
+static inline void oe_set_in_pack_pos(const struct packing_data *pack,
+				      const struct object_entry *e,
+				      unsigned int pos)
+{
+	pack->in_pack_pos[e - pack->objects] = pos;
+}
+
 #endif
-- 
2.16.2.873.g32ff258c87


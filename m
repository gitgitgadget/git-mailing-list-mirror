Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD93E1F404
	for <e@80x24.org>; Sun, 18 Mar 2018 14:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754372AbeCROZy (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 10:25:54 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39197 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754327AbeCROZq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 10:25:46 -0400
Received: by mail-lf0-f67.google.com with SMTP id f75-v6so21709721lfg.6
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 07:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ffQbPhgh5cPelCybT1v1tQnYmvr9/QE4f1qxGyRGwFU=;
        b=vZjkzLQRBtVFdU23vxajsf1wDYKyMqTB6cpX3DwKCccBthfzgiOVajkykTOzDD5d0T
         W6b37n3S+XCbVLrag4hhpm5/aNwSEAF7WUR96/oo6pQpSKJri39JcNzMoCDpQb2ZsMKi
         ZxXxlldbU+75vf1V/1Utvql3FzpGLdwtmwhroP4RXVKj5qnSUD0L8k860h+SV23eOM/y
         pWmy5TMCJ3Ipy9NkF2fCxEU9OEO6IXRnReZx/JKNFbAugFuvimFpQfzsbZxBk4lfGgTv
         nWKFlODRJDEAUh5e+4hK1ZZwgMEP4bOpoZWtQ7q0xqUncODgPBaOgcJJYaWs4Ey1T04J
         zKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ffQbPhgh5cPelCybT1v1tQnYmvr9/QE4f1qxGyRGwFU=;
        b=pcfCnfRhK7ocQqtMQVs73VkIh52D0+FVcuLD1ndmCTqpyR22St4VABb9tt3lE7o7Xm
         VCPzxukFdvRCmsPL3V/JOZBg7LMAuP18pa4i3crJq6V/U2OYNWLPqgMoCU4r49fVGQeK
         wiyEBUN077i0YWDcOLSo7O4fYi5GN+F+ILqn+Cf7+I9ZcZqibySaRpYmrSq60VBMCsTs
         6GUMw5laRnsaZSm7wFOfGvdr/lFo+XkLzwI5Cee8tyP5PsBRTb7aC2eV4DOCLBvk79tG
         K0QetW4vGmIN6yH/G3ltmubmNQQGgPZmlKhDQEtLYO6qwAlH6CoJ6AHhR094+PlAAtNz
         BXFQ==
X-Gm-Message-State: AElRT7EQCt8r7Gyn/LfNef7fjinPfyMwdX7NHom1duFALxiSt0MuOUk9
        ujk60lUb5d1LWGELQrCWbL8=
X-Google-Smtp-Source: AG47ELuT9jMFL7vM5SMIsGEdFRdN+oBpHq+9hxE3hcZg4I67dzcnJoQzpqMg4TtM9EUpcLq2eXy7Kw==
X-Received: by 2002:a19:a705:: with SMTP id q5-v6mr5563355lfe.2.1521383145190;
        Sun, 18 Mar 2018 07:25:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n24sm2551554ljg.22.2018.03.18.07.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Mar 2018 07:25:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v6 05/11] pack-objects: move in_pack_pos out of struct object_entry
Date:   Sun, 18 Mar 2018 15:25:20 +0100
Message-Id: <20180318142526.9378-6-pclouds@gmail.com>
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

This field is only need for pack-bitmap, which is an optional
feature. Move it to a separate array that is only allocated when
pack-bitmap is used (it's not freed in the same way that objects[] is
not).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c |  3 ++-
 pack-bitmap-write.c    |  8 +++++---
 pack-bitmap.c          |  2 +-
 pack-bitmap.h          |  4 +++-
 pack-objects.h         | 16 +++++++++++++++-
 5 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 205e1f646c..e1244918a5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -879,7 +879,8 @@ static void write_pack_file(void)
 
 			if (write_bitmap_index) {
 				bitmap_writer_set_checksum(oid.hash);
-				bitmap_writer_build_type_index(written_list, nr_written);
+				bitmap_writer_build_type_index(
+					&to_pack, written_list, nr_written);
 			}
 
 			finish_tmp_packfile(&tmpname, pack_tmp_name,
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index fd11f08940..f7c897515b 100644
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
 
 		switch (oe_type(entry)) {
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
index 59407aae3c..4a11653657 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -79,7 +79,6 @@ struct object_entry {
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
 	unsigned type_valid:1;
 	uint32_t hash;			/* name hint hash */
-	unsigned int in_pack_pos;
 	unsigned char in_pack_header_size;
 	unsigned preferred_base:1; /*
 				    * we do not pack this, but is available
@@ -99,6 +98,8 @@ struct packing_data {
 
 	int32_t *index;
 	uint32_t index_size;
+
+	unsigned int *in_pack_pos;
 };
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
@@ -144,4 +145,17 @@ static inline void oe_set_type(struct object_entry *e,
 	e->type_ = (unsigned)type;
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
2.17.0.rc0.347.gf9cf61673a


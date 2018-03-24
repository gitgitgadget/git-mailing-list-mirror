Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71EA01F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 06:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbeCXGeT (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 02:34:19 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35183 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeCXGeN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 02:34:13 -0400
Received: by mail-lf0-f66.google.com with SMTP id t132-v6so21280277lfe.2
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 23:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xl5ffy3nIUHePCSgqj5+DNwrs6dFCg/R1iNw4h5Hl48=;
        b=BTZ9bOelILjakFY+C8HQpqMv1ewVBc4DAfLs76KqrclqgV3wekrAinYSiwTw8lTtDl
         hH17VeKvDE4XgZ2DzSogXN17bGsLqN4CyosrPCHy6SP/pD/H62uZOyICSHVHZoZnEkC7
         gwWfLITwnH5ZTa274N5/YadLskKg4RpYyaIjaovup/YocLi/5V3BV0Xv3KFbrZzz/fmD
         sihDbRP6gIdr+LDjGdh3kkKXHTHUj5ueccjeG32vU1yJ4V2Ep20X39r5ANdMal2ucgHn
         IK9jIEu9h/ujIBK1sQDmDe1ozAhAEAbK1IQSAB1k/MidVHJE+/Wopn7QcnWg0Z4hYIKP
         3x0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xl5ffy3nIUHePCSgqj5+DNwrs6dFCg/R1iNw4h5Hl48=;
        b=R/51xGjRRRUWYDOJ3+GKRC5gmg4uub5Mu9+P/uX8Y5yaQiJStXLoLoow9KlTKD1P/P
         CUVAzaY/UgKI9Pdv09MXjhPz9CcANolRoJhUlLZpqf3H9+bqkZaUuU+ufss6OHcpL15q
         oEK/J0zUSKSfq/4lfEJ2EjRSPwlFO15Ob5QQVhnYqyhYAJi5IuneZa4Ca6GkDxgxi1ug
         De00uSiyiQ8zyhR4HTqRUg0QrTbaXR1WQNfrlB0lHId+v0H1eAFQ1V88BTgMXYQYhFzG
         TTZxESe3XcuTKp81Aobm0WyY/UopybPr+rWQZplVIS05fAQ/RiCB4y7HUyIyx4FcZ/oY
         bl/A==
X-Gm-Message-State: AElRT7EIrK+/RyNdLCwsix8qdppjxf08RFAP87j2YL3Cvkvsi2StfnAm
        jIPpRkRaXYMloV36OplGyUc=
X-Google-Smtp-Source: AG47ELthXLg/O0KJa44gd/scM0HQ0e59Uk0y7pLackobwnqQFbdn/B+pZAy6Dfr5FG0EU6w5Z7LFhw==
X-Received: by 2002:a19:9904:: with SMTP id b4-v6mr20592951lfe.51.1521873252146;
        Fri, 23 Mar 2018 23:34:12 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h8sm2251703lja.41.2018.03.23.23.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 23:34:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v7 05/13] pack-objects: move in_pack_pos out of struct object_entry
Date:   Sat, 24 Mar 2018 07:33:45 +0100
Message-Id: <20180324063353.24722-6-pclouds@gmail.com>
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
2.17.0.rc0.348.gd5a49e0b6f


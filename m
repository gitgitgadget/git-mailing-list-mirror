Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01B731FAE2
	for <e@80x24.org>; Sat, 31 Mar 2018 10:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753106AbeCaKDb (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 06:03:31 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40124 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752442AbeCaKD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 06:03:29 -0400
Received: by mail-lf0-f68.google.com with SMTP id e5-v6so15128036lfb.7
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 03:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7R9nCjXsP/5LoYZPObQk3wsMkkK+rpc3l6y5bEYcJpw=;
        b=b14Meyt5d6d+w9dBIHmnR0QWYHWW8/fSvNmKK1M3gKstV3rQZU+Ni5lrGhQE4sSI1R
         q2pB+I4CoP9k4SLBKmu8IpBw3eO3Jm0Z5yBRuueZc5Dk7x+3tErYVpVLTJsMG1HQdbpw
         nNHg1p4Gy98dH04myACnhelR+9OOwmXwi33lo79U8srY2S2uhwiGjikEH82x0b6E/tKm
         gRQllCPt4BWyi+eVkD3Y6wBk9Z71Ti/kFCKdGgSoCOFV/cDDY1cLRtAoOf9EaYaIsH29
         vDmxxBFNUlofGrXfGmI8lg5SjSiaPuxBt5cYZLyBP4dSaqubByvq6KPaFrq+wIoF9yTv
         fg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7R9nCjXsP/5LoYZPObQk3wsMkkK+rpc3l6y5bEYcJpw=;
        b=dCdNPADbBwGFvsGehs0Tmk9+01FqE61R/ST5dZd8+JyOI5M1d+3np11nqOCaR7Paob
         5FgN3bk/ZzRyCMDX8FqnFu1gFnIwazdN7gYzN5SwgL5llqSJaGTBondnWkfSJOaVVnbC
         8YPjQKSoejolmaCh7jrWtqj5pRLX69D8UPNTwn3hS/Ux7mBe0SzMeaqaY4mjwKIRvQk5
         sHohwm71pcFidhetBkx2Z2gf/FOIxIFY2OTZbYHq+qQdCgd7rKHwUnnXZOqeeei3bG0B
         lgJiUjdvSUYcBdIx7FXWeQX0ZFTv2dML+Zs0i+CEMad4g7+416u6HF38P0lPm7A+f2sU
         JEbA==
X-Gm-Message-State: ALQs6tD0UdHTOviFPzNUExYwnyes3CMjKoCjf3SWKOXxGn+P2t5nOzOv
        VgbpiRv7uaz4IwpMk9HW/0Q=
X-Google-Smtp-Source: AIpwx4+H2usoAFgGxjFh3x+VzwLtT0ay1YZprOnGvKljZPs8yCkVXqzr87G3PiVca7H2kN3LDHcRvA==
X-Received: by 10.46.58.16 with SMTP id h16mr1386838lja.146.1522490608369;
        Sat, 31 Mar 2018 03:03:28 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id a1sm1799175ljj.90.2018.03.31.03.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Mar 2018 03:03:27 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v8 06/15] pack-objects: move in_pack_pos out of struct object_entry
Date:   Sat, 31 Mar 2018 12:03:02 +0200
Message-Id: <20180331100311.32373-7-pclouds@gmail.com>
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

This field is only need for pack-bitmap, which is an optional
feature. Move it to a separate array that is only allocated when
pack-bitmap is used (like objects[], it is not freed, since we need it
until the end of the process)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c |  3 ++-
 pack-bitmap-write.c    |  8 +++++---
 pack-bitmap.c          |  2 +-
 pack-bitmap.h          |  4 +++-
 pack-objects.h         | 16 +++++++++++++++-
 5 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2ce05626d2..7a672366bf 100644
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
index cdce1648de..71ea992c3c 100644
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
2.17.0.rc2.515.g4feb9b7923


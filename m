Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FD101F404
	for <e@80x24.org>; Sat, 17 Mar 2018 14:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbeCQOLS (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 10:11:18 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33221 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752836AbeCQOKx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 10:10:53 -0400
Received: by mail-lf0-f67.google.com with SMTP id x205-v6so19351330lfa.0
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 07:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=srj8YrmJyNXTZ6vaFln/hrwrbgLI5AW47KVMCitCGJA=;
        b=qqzWT2y4l5gTkv2I5B1AQHBvcYtNbJav/ldAERPIfpxf6aGv2ai2ijP2I9yPloEhP8
         MV3yssWfL7DU94gKrma8XId5ngVrGtO+yZ/ZhCF8uWxRmBCISONgZEwL/OWOt7+LJPR1
         CuKfCI05a83873JAt/zevIDlI6bH++8fQwapzp5nUo0nakbjieQHtj6eTL9qglWsxQe6
         dG7l7iWr5wAK2SBY6A3BwOl8nxQdUGsPkpQjDPRzupMPO2+LgRQqhOShqo4lf2cejCB3
         FaRqxH1j5DnFC/qtc84xQ/O2C9pEvzkGAXKpBcg5aC2dRl4KYv5I5pHq5Sayv/zoKsar
         EHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=srj8YrmJyNXTZ6vaFln/hrwrbgLI5AW47KVMCitCGJA=;
        b=KqbOo8jXorz81/Cahcgb58uZNepYIjrwQwcLgfmJDJOpZjnLgKTwGznhVdsO25L5to
         9T8vQFnP5eak4lymGRYxPp9rCQjlByyPYq9CYAneN6BbkYAhOpawI7c5OfoT46o4lQC6
         /WdF9WpJHmItMKP9oArWNx/4ak1Wbla15cJCfK5pSMEROy1zyS1J2BrEAuE33tsKrj15
         L/x+2p/NqRkTT9bmj22y/pbMRZO9B5Na3xZmpKeZ2Yvx+9A4FVwioF9zcIfjQZZkn/mq
         30+zB/XhWUcrq1EYhrNjGfP8nhJwqKkS2JQBeQnRHFmLZ0V761n8GeJ5jccAfdTWCLq/
         1Pag==
X-Gm-Message-State: AElRT7GBjOuHzCV4CWEfVthYNqcEQJX4nzEsjNljX5BoKSftiLuCZiAA
        /fS05C4/2KREwDngYEfnRtE=
X-Google-Smtp-Source: AG47ELsa9m7KdU9/g8cWe0TPyd8pL4jtJkCXcOprtQMMyWPBqgQc0uAZ+Cy9HIpCm4dnzP+HVmd3fg==
X-Received: by 2002:a19:914a:: with SMTP id y10-v6mr4067781lfj.91.1521295852396;
        Sat, 17 Mar 2018 07:10:52 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f7-v6sm625648lfb.2.2018.03.17.07.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 07:10:51 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v5 05/11] pack-objects: move in_pack_pos out of struct object_entry
Date:   Sat, 17 Mar 2018 15:10:27 +0100
Message-Id: <20180317141033.21545-6-pclouds@gmail.com>
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
index 829c80ffcc..727d200770 100644
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
index a4d8d29c04..b832ee2b5e 100644
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


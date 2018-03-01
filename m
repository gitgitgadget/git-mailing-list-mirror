Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 890901FAE2
	for <e@80x24.org>; Thu,  1 Mar 2018 09:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966790AbeCAJLr (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 04:11:47 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46313 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966685AbeCAJLk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 04:11:40 -0500
Received: by mail-pf0-f195.google.com with SMTP id z10so2175972pfh.13
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 01:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IKL9F5GW+ob8u53COoSlXnQEJu/rhzhBZj7XCYuB0X0=;
        b=cWqSntqwp8p2079ep7I2obiFIsWzE9QypsvBwvetBUK0qQhack9oJDmJ2VEGuzgRlU
         WNJP9NT4HTo51wc+5vZTNnzlh206blzWlTBCW/re8NTcrlv1hiF7GOqkoLtsbm02kFKP
         xomTQU9s6r6oAVDM1kSABQY08i/rel4RBqNNr5HBE6uAIX6hPHvMsAghLPG2u3Fb1O/G
         fjBZAHD7I+eSNdnQFtl3P8jPR+/uHoHCxF7jTPbgDRl+Df0+HZva1o51/yhhWr7u+GAe
         ra7digFkxCopgfsSo1OuvN2eU5qrZ9ykrylLE7o8tKlSPTecZ7cys7vht5xHEM7AXmCF
         Fijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IKL9F5GW+ob8u53COoSlXnQEJu/rhzhBZj7XCYuB0X0=;
        b=hDPwEXicxpkNvZE1ZAxSMdnkmYFENiAtkmRJvDpKGtdg+zh1GH/3/YCsphwACCXlGJ
         nRzkZXPS/a6wCIEdhFCsoxZAtmyTPlqSJKt128wmna6qW07oE/qP4dwUxDPrWVg+rW0V
         5oZ0UfoCyUUN18nchAnLLPzRSlmE3EdGP0VS7yl6LTSNllEK8ybHU1a7fY79PO/P7iEx
         qcb8K6/jGu7edwtU+JMH7OA34ijFODrs4nWp1zOEOw/e9Kd0XBZwv4XEmX/GsWAwEc2r
         fcVObLNu/BcpSEWPlTEL93VRjU9mkhwDVg2e7AW2LfX/TnUnfRW2XrKQgdM7EZxt9vwG
         pVMA==
X-Gm-Message-State: APf1xPD75xydDEUVpzRk69m/SpPOgINfYbHXBBPcKyk50MLnMtFc1S1z
        UqGaYZEwjqgjga+wAfmRyzYSrA==
X-Google-Smtp-Source: AG47ELvabq6XnJoXfEWzmknDve4Cbc51TPqMeh57OjmtMNGV7c+KBLGEhkmWRMqCwITBjJKQ4ysxbg==
X-Received: by 10.101.69.205 with SMTP id m13mr976964pgr.323.1519895499227;
        Thu, 01 Mar 2018 01:11:39 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id p1sm6760448pgr.67.2018.03.01.01.11.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Mar 2018 01:11:38 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 01 Mar 2018 16:11:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/11] pack-objects: move in_pack_pos out of struct object_entry
Date:   Thu,  1 Mar 2018 16:10:47 +0700
Message-Id: <20180301091052.32267-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180301091052.32267-1-pclouds@gmail.com>
References: <20180228092722.GA25627@ash>
 <20180301091052.32267-1-pclouds@gmail.com>
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
 builtin/pack-objects.c | 3 ++-
 pack-bitmap-write.c    | 8 +++++---
 pack-bitmap.c          | 2 +-
 pack-bitmap.h          | 4 +++-
 pack-objects.h         | 8 ++++++--
 5 files changed, 17 insertions(+), 8 deletions(-)

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
index e01f992884..1360a93311 100644
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
+		IN_PACK_POS(to_pack, entry) = i;
 
 		switch (entry->type) {
 		case OBJ_COMMIT:
@@ -147,7 +149,7 @@ static uint32_t find_object_pos(const unsigned char *sha1)
 			"(object %s is missing)", sha1_to_hex(sha1));
 	}
 
-	return entry->in_pack_pos;
+	return IN_PACK_POS(writer.to_pack, entry);
 }
 
 static void show_object(struct object *object, const char *name, void *data)
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9270983e5f..f21479fe16 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1032,7 +1032,7 @@ int rebuild_existing_bitmaps(struct packing_data *mapping,
 		oe = packlist_find(mapping, sha1, NULL);
 
 		if (oe)
-			reposition[i] = oe->in_pack_pos + 1;
+			reposition[i] = IN_PACK_POS(mapping, oe) + 1;
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
index 017cc3425f..3bef28196c 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -4,6 +4,9 @@
 #define OE_DFS_STATE_BITS 2
 #define OE_DEPTH_BITS 12
 
+#define IN_PACK_POS(to_pack, obj) \
+	(to_pack)->in_pack_pos[(struct object_entry *)(obj) - (to_pack)->objects]
+
 /*
  * State flags for depth-first search used for analyzing delta cycles.
  *
@@ -31,7 +34,6 @@ struct object_entry {
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	unsigned long z_delta_size;	/* delta data size (compressed) */
 	uint32_t hash;			/* name hint hash */
-	unsigned int in_pack_pos;
 	unsigned char in_pack_header_size; /* note: spare bits available! */
 	unsigned type:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
@@ -46,7 +48,7 @@ struct object_entry {
 	unsigned dfs_state:OE_DFS_STATE_BITS;
 	unsigned depth:OE_DEPTH_BITS;
 
-	/* size: 120, padding: 4 */
+	/* size: 112 */
 };
 
 struct packing_data {
@@ -55,6 +57,8 @@ struct packing_data {
 
 	int32_t *index;
 	uint32_t index_size;
+
+	unsigned int *in_pack_pos;
 };
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
-- 
2.16.1.435.g8f24da2e1a


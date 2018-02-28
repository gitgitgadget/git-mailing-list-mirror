Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BC101F576
	for <e@80x24.org>; Wed, 28 Feb 2018 09:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeB1J1b (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 04:27:31 -0500
Received: from mail-pl0-f44.google.com ([209.85.160.44]:43613 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeB1J12 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 04:27:28 -0500
Received: by mail-pl0-f44.google.com with SMTP id f23-v6so1163131plr.10
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 01:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FtXMz8K13xKN3puJ9n3Kw/hGnopfIxiEe93+z49pkfg=;
        b=t5EVo75kPYjRsLgcsUliERLzburSpz87zf7hlmMWaGlUalW4WZOxy/D3TVJ0ggBdhq
         36jVRq720VPfFg26nGc73B4HoXvd9SxhvlRv6KSCLxmS+fbRhDXQg2VhCZhB14dict+j
         r+3cKXYGc1XThfXTkkF304w9yg5cdqzueZUXUomXOkpXWmqd6GlznjJdcA9mmhw2jN4k
         faCmKRXuxcRyhKUnU//FZRprqHGabab1CFQuJnv9vZoGc1+8cxxuWRYBD+VpwLbkvwmt
         jPFWzQ+u6/781SpsxsTOuLuuteZIv7s0AmED6YO/DQRxla8eR5Yu3u5YFszY39wkr3L2
         0+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FtXMz8K13xKN3puJ9n3Kw/hGnopfIxiEe93+z49pkfg=;
        b=P6ZDMUbOHTHEfmgqnwcvtZwDHERhed9MsPZK2rZQpoDWIXiwfgUWXbWKgQD6r/4WTM
         +m17IGCWr0AB4kMMh34LQxR/guwOHZWNSmMEuKcpdlkL3ygJcAHhBB229HL+fgzeUNYI
         V+TJAu0Q0MbCUY94vPOU49KVppSukLHK6LmEIJ6g1kI3KfBgXP71a5jO2nvdZ5OTRUux
         0xsmzrBp6mZIlbgLALUSKWEfJ0qUdoVi5en+vcL04at3S91zXrcoCAyQ2vBe6H9Fi9w3
         cFPEZF1UYdWALY96qoLEa/TTycalpNtOqP4GX1K/MWBnxTeApJY8quxo1715WiIcQKYK
         xE8w==
X-Gm-Message-State: APf1xPCNJewJsMX50t2SrrL7ueDO0av3BzT9BZ58TTwdY8aLtVQTk62D
        +/BNvPTQlKGer5ADUylWHYWOzg==
X-Google-Smtp-Source: AH8x225Jgo8pp4fHEI3gzrb+yAAvXLVROQeq1x9fddgRv0Y4YaFp/VReyKCE1B0Vy35a0qckSWfNwA==
X-Received: by 2002:a17:902:b20f:: with SMTP id t15-v6mr16736025plr.349.1519810047740;
        Wed, 28 Feb 2018 01:27:27 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id s68sm2233681pgb.43.2018.02.28.01.27.25
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2018 01:27:27 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 28 Feb 2018 16:27:22 +0700
Date:   Wed, 28 Feb 2018 16:27:22 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     git@vger.kernel.org
Subject: Reduce pack-objects memory footprint?
Message-ID: <20180228092722.GA25627@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

linux-2.6.git current has 6483999 objects. "git gc" on my poor laptop
consumes 1.7G out of 4G RAM, pushing lots of data to swap and making
all apps nearly unusuable (granted the problem is partly Linux I/O
scheduler too). So I wonder if we can reduce pack-objects memory
footprint a bit.

This demonstration patch (probably breaks some tests) would reduce the
size of struct object_entry from from 136 down to 112 bytes on
x86-64. There are 6483999 of these objects, so the saving is 17% or
148 MB.

If we go further, notice that nr_objects is uint32_t, we could convert
the three pointers

	struct object_entry *delta;
	struct object_entry *delta_child;
	struct object_entry *delta_sibling;

to

	uint32_t delta;
	uint32_t delta_child;
	uint32_t delta_sibling;

which saves 12 bytes (or another 74 MB). 222 MB total is plenty of
space to keep some file cache from being evicted.

Is it worth doing this? The struct packing makes it harder to read
(and more fragile too). I added some more artifical limit like max
depth of 2^11. But I think 4096+ depth is getting unreasonable.

-- 8< --
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5c674b2843..6a9804daec 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -877,8 +877,11 @@ static void write_pack_file(void)
 			strbuf_addf(&tmpname, "%s-", base_name);
 
 			if (write_bitmap_index) {
+				ALLOC_ARRAY(to_pack.in_pack_pos, to_pack.nr_objects);
 				bitmap_writer_set_checksum(oid.hash);
-				bitmap_writer_build_type_index(written_list, nr_written);
+				bitmap_writer_build_type_index(written_list,
+							       nr_written,
+							       &to_pack);
 			}
 
 			finish_tmp_packfile(&tmpname, pack_tmp_name,
@@ -1407,6 +1410,7 @@ static void check_object(struct object_entry *entry)
 		unsigned long avail;
 		off_t ofs;
 		unsigned char *buf, c;
+		enum object_type type;
 
 		buf = use_pack(p, &w_curs, entry->in_pack_offset, &avail);
 
@@ -1415,8 +1419,9 @@ static void check_object(struct object_entry *entry)
 		 * since non-delta representations could still be reused.
 		 */
 		used = unpack_object_header_buffer(buf, avail,
-						   &entry->in_pack_type,
+						   &type,
 						   &entry->size);
+		entry->in_pack_type = type;
 		if (used == 0)
 			goto give_up;
 
@@ -1559,6 +1564,7 @@ static void drop_reused_delta(struct object_entry *entry)
 {
 	struct object_entry **p = &entry->delta->delta_child;
 	struct object_info oi = OBJECT_INFO_INIT;
+	enum object_type type;
 
 	while (*p) {
 		if (*p == entry)
@@ -1570,7 +1576,7 @@ static void drop_reused_delta(struct object_entry *entry)
 	entry->depth = 0;
 
 	oi.sizep = &entry->size;
-	oi.typep = &entry->type;
+	oi.typep = &type;
 	if (packed_object_info(entry->in_pack, entry->in_pack_offset, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
@@ -1580,7 +1586,8 @@ static void drop_reused_delta(struct object_entry *entry)
 		 */
 		entry->type = sha1_object_info(entry->idx.oid.hash,
 					       &entry->size);
-	}
+	} else
+		entry->type = type;
 }
 
 /*
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index e01f992884..5c9957a095 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -49,7 +49,8 @@ void bitmap_writer_show_progress(int show)
  * Build the initial type index for the packfile
  */
 void bitmap_writer_build_type_index(struct pack_idx_entry **index,
-				    uint32_t index_nr)
+				    uint32_t index_nr,
+				    struct packing_data *to_pack)
 {
 	uint32_t i;
 
@@ -62,7 +63,7 @@ void bitmap_writer_build_type_index(struct pack_idx_entry **index,
 		struct object_entry *entry = (struct object_entry *)index[i];
 		enum object_type real_type;
 
-		entry->in_pack_pos = i;
+		to_pack->in_pack_pos[entry - to_pack->objects] = i;
 
 		switch (entry->type) {
 		case OBJ_COMMIT:
@@ -147,7 +148,7 @@ static uint32_t find_object_pos(const unsigned char *sha1)
 			"(object %s is missing)", sha1_to_hex(sha1));
 	}
 
-	return entry->in_pack_pos;
+	return writer.to_pack->in_pack_pos[entry - writer.to_pack->objects];
 }
 
 static void show_object(struct object *object, const char *name, void *data)
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9270983e5f..595914fa43 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1032,7 +1032,7 @@ int rebuild_existing_bitmaps(struct packing_data *mapping,
 		oe = packlist_find(mapping, sha1, NULL);
 
 		if (oe)
-			reposition[i] = oe->in_pack_pos + 1;
+			reposition[i] = mapping->in_pack_pos[oe - mapping->objects] + 1;
 	}
 
 	rebuild = bitmap_new();
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 3742a00e14..2558f7662a 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -44,7 +44,9 @@ int rebuild_existing_bitmaps(struct packing_data *mapping, khash_sha1 *reused_bi
 
 void bitmap_writer_show_progress(int show);
 void bitmap_writer_set_checksum(unsigned char *sha1);
-void bitmap_writer_build_type_index(struct pack_idx_entry **index, uint32_t index_nr);
+void bitmap_writer_build_type_index(struct pack_idx_entry **index,
+				    uint32_t index_nr,
+				    struct packing_data *);
 void bitmap_writer_reuse_bitmaps(struct packing_data *to_pack);
 void bitmap_writer_select_commits(struct commit **indexed_commits,
 		unsigned int indexed_commits_nr, int max_bitmaps);
diff --git a/pack-objects.h b/pack-objects.h
index 03f1191659..caecad23b6 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -1,6 +1,18 @@
 #ifndef PACK_OBJECTS_H
 #define PACK_OBJECTS_H
 
+/*
+ * State flags for depth-first search used for analyzing delta cycles.
+ *
+ * The depth is measured in delta-links to the base (so if A is a delta
+ * against B, then A has a depth of 1, and B a depth of 0).
+ */
+enum dfs_state {
+	DFS_NONE = 0,
+	DFS_ACTIVE,
+	DFS_DONE
+};
+
 struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;	/* uncompressed size */
@@ -14,11 +26,10 @@ struct object_entry {
 	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	unsigned long z_delta_size;	/* delta data size (compressed) */
-	enum object_type type;
-	enum object_type in_pack_type;	/* could be delta */
 	uint32_t hash;			/* name hint hash */
-	unsigned int in_pack_pos;
 	unsigned char in_pack_header_size;
+	unsigned type:3;	 /* enum object_type */
+	unsigned in_pack_type:3; /* enum object_type - could be delta */
 	unsigned preferred_base:1; /*
 				    * we do not pack this, but is available
 				    * to be used as the base object to delta
@@ -27,19 +38,8 @@ struct object_entry {
 	unsigned no_try_delta:1;
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
-
-	/*
-	 * State flags for depth-first search used for analyzing delta cycles.
-	 *
-	 * The depth is measured in delta-links to the base (so if A is a delta
-	 * against B, then A has a depth of 1, and B a depth of 0).
-	 */
-	enum {
-		DFS_NONE = 0,
-		DFS_ACTIVE,
-		DFS_DONE
-	} dfs_state;
-	int depth;
+	unsigned dfs_state:3;	/* enum dfs_state */
+	unsigned depth:11;
 };
 
 struct packing_data {
@@ -48,6 +48,8 @@ struct packing_data {
 
 	int32_t *index;
 	uint32_t index_size;
+
+	int *in_pack_pos;
 };
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
-- 8< --

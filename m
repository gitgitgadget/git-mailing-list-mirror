Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B06FD1FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 11:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965481AbeCHLnX (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 06:43:23 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36626 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935780AbeCHLnW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 06:43:22 -0500
Received: by mail-pg0-f67.google.com with SMTP id i14so2119954pgv.3
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 03:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=trVcMjzQg7+1UNB49TO6Tl+9grqy4zLe2iNUidRTEpA=;
        b=HHyoJ/hLJrQ7vl7LXDKk/FCjByCm09e7AgJPzpgIqWt11Q75zbboRYMuhGYzGxven9
         djDqtDiDRUeyClzep2PfgIXg9g206cQ3vP7xQK02esrUITvXU+ovQhb7+8+A9Cqps9/1
         +gClHMJvdDaui+tQRYOWjOuwR1z89JawvV2ojTs1axX4fnAm3cDEVDLvJkKXr6IITGLL
         mQBl/pO2ZkWiSar9lTDW4hzBhMkhkdhL5ENILe3WGxrR3jIFsyjUZNlEiPsjPaezEpMN
         KarIV6QKtxZpBAJ/QK69cFpIqDrJ2lvUGNPmQm0Yh8LBlCRiSOW0XFlgzMzOxZs8PYaa
         X/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=trVcMjzQg7+1UNB49TO6Tl+9grqy4zLe2iNUidRTEpA=;
        b=uIUmz/xNRZYJXEFjUqr5AhllzD0tHEM28wBAjQA1uEMUNlrRHmd5q1uQuFI4VZLaAx
         oF8HXC7NAQaVKpfpbWzqNV4qD5hsXC/iuvW985EVzacJXXWhQO8dK7IxwQWQRa4UBzLK
         FcM8AoW+wq10VvSIo9xVAyFn+s8Bom94EmHYeTGM7hreXwHWyvlohacFrHqYD0CTpI+e
         vC4YO1zy1M4pH1S4nnxr5igYylqXIGBCuN/NGkaVu9koAQHnAk34cN/Iqu+owtB3hU43
         eGqh4OVb7S6ts1vRq7oDIxdgzn928bzOy1siL8cVf6czwBCApZcU8voboRJWSibqevwt
         K2YQ==
X-Gm-Message-State: APf1xPDrSNn5AqS69UGm65GHpjdYwTm6LqD1DIX6Xi7YSRUhJoYr9qg7
        UeXwO9CzOyCSkOZUcl0K1M0=
X-Google-Smtp-Source: AG47ELv3wmFE9vEe0op34CEQ6TDwzuDbP7cwF2fXBqPE3f35FNAewd9jqPHem+9hU7kLOzpRT1033A==
X-Received: by 10.101.97.139 with SMTP id c11mr20650081pgv.449.1520509401270;
        Thu, 08 Mar 2018 03:43:21 -0800 (PST)
Received: from ash ([27.78.177.129])
        by smtp.gmail.com with ESMTPSA id i12sm12460510pgr.9.2018.03.08.03.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 03:43:20 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 08 Mar 2018 18:43:16 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH/RFC v3 07/12] pack-objects: move in_pack out of struct object_entry
Date:   Thu,  8 Mar 2018 18:42:27 +0700
Message-Id: <20180308114232.10508-8-pclouds@gmail.com>
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

Instead of using 8 bytes (on 64 bit arch) to store a pointer to a
pack. Use an index isntead since the number of packs should be
relatively small.

This limits the number of packs we can handle to 16k. For now if you hit
16k pack files limit, pack-objects will simply fail [1].

This technically saves 7 bytes. But we don't see any of that in
practice due to padding. The saving becomes real when we pack this
struct tighter later.

[1] The escape hatch is .keep file to limit the non-kept pack files
    below 16k limit. Then you can go for another pack-objects run to
    combine another 16k pack files. Repeat until you're satisfied.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-pack-objects.txt |  9 ++++++
 builtin/pack-objects.c             | 40 +++++++++++++++---------
 cache.h                            |  1 +
 pack-objects.h                     | 49 ++++++++++++++++++++++++++++--
 4 files changed, 83 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 3503c9e3e6..b8d936ccf5 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -269,6 +269,15 @@ Unexpected missing object will raise an error.
 	locally created objects [without .promisor] and objects from the
 	promisor remote [with .promisor].)  This is used with partial clone.
 
+LIMITATIONS
+-----------
+
+This command could only handle 16384 existing pack files at a time.
+If you have more than this, you need to exclude some pack files with
+".keep" file and --honor-pack-keep option, to combine 16k pack files
+in one, then remove these .keep files and run pack-objects one more
+time.
+
 SEE ALSO
 --------
 linkgit:git-rev-list[1]
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7bb5544883..7df525e201 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -29,6 +29,8 @@
 #include "list.h"
 #include "packfile.h"
 
+#define IN_PACK(obj) oe_in_pack(&to_pack, obj)
+
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
 	N_("git pack-objects [<options>...] <base-name> [< <ref-list> | < <object-list>]"),
@@ -367,7 +369,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 				unsigned long limit, int usable_delta)
 {
-	struct packed_git *p = entry->in_pack;
+	struct packed_git *p = IN_PACK(entry);
 	struct pack_window *w_curs = NULL;
 	struct revindex_entry *revidx;
 	off_t offset;
@@ -478,7 +480,7 @@ static off_t write_object(struct hashfile *f,
 
 	if (!reuse_object)
 		to_reuse = 0;	/* explicit */
-	else if (!entry->in_pack)
+	else if (!IN_PACK(entry))
 		to_reuse = 0;	/* can't reuse what we don't have */
 	else if (entry->type == OBJ_REF_DELTA || entry->type == OBJ_OFS_DELTA)
 				/* check_object() decided it for us ... */
@@ -1024,7 +1026,7 @@ static int want_object_in_pack(const struct object_id *oid,
 	if (*found_pack) {
 		want = want_found_object(exclude, *found_pack);
 		if (want != -1)
-			return want;
+			goto done;
 	}
 
 	list_for_each(pos, &packed_git_mru) {
@@ -1047,11 +1049,16 @@ static int want_object_in_pack(const struct object_id *oid,
 			if (!exclude && want > 0)
 				list_move(&p->mru, &packed_git_mru);
 			if (want != -1)
-				return want;
+				goto done;
 		}
 	}
 
-	return 1;
+	want = 1;
+done:
+	if (want && *found_pack && !(*found_pack)->index)
+		oe_add_pack(&to_pack, *found_pack);
+
+	return want;
 }
 
 static void create_object_entry(const struct object_id *oid,
@@ -1074,7 +1081,7 @@ static void create_object_entry(const struct object_id *oid,
 	else
 		nr_result++;
 	if (found_pack) {
-		entry->in_pack = found_pack;
+		oe_set_in_pack(entry, found_pack);
 		entry->in_pack_offset = found_offset;
 	}
 
@@ -1399,8 +1406,8 @@ static void cleanup_preferred_base(void)
 
 static void check_object(struct object_entry *entry)
 {
-	if (entry->in_pack) {
-		struct packed_git *p = entry->in_pack;
+	if (IN_PACK(entry)) {
+		struct packed_git *p = IN_PACK(entry);
 		struct pack_window *w_curs = NULL;
 		const unsigned char *base_ref = NULL;
 		struct object_entry *base_entry;
@@ -1535,14 +1542,16 @@ static int pack_offset_sort(const void *_a, const void *_b)
 {
 	const struct object_entry *a = *(struct object_entry **)_a;
 	const struct object_entry *b = *(struct object_entry **)_b;
+	const struct packed_git *a_in_pack = IN_PACK(a);
+	const struct packed_git *b_in_pack = IN_PACK(b);
 
 	/* avoid filesystem trashing with loose objects */
-	if (!a->in_pack && !b->in_pack)
+	if (!a_in_pack && !b_in_pack)
 		return oidcmp(&a->idx.oid, &b->idx.oid);
 
-	if (a->in_pack < b->in_pack)
+	if (a_in_pack < b_in_pack)
 		return -1;
-	if (a->in_pack > b->in_pack)
+	if (a_in_pack > b_in_pack)
 		return 1;
 	return a->in_pack_offset < b->in_pack_offset ? -1 :
 			(a->in_pack_offset > b->in_pack_offset);
@@ -1578,7 +1587,7 @@ static void drop_reused_delta(struct object_entry *entry)
 
 	oi.sizep = &entry->size;
 	oi.typep = &type;
-	if (packed_object_info(entry->in_pack, entry->in_pack_offset, &oi) < 0) {
+	if (packed_object_info(IN_PACK(entry), entry->in_pack_offset, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
 		 * fall back to sha1_object_info, which may find another copy.
@@ -1848,8 +1857,8 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	 * it, we will still save the transfer cost, as we already know
 	 * the other side has it and we won't send src_entry at all.
 	 */
-	if (reuse_delta && trg_entry->in_pack &&
-	    trg_entry->in_pack == src_entry->in_pack &&
+	if (reuse_delta && IN_PACK(trg_entry) &&
+	    IN_PACK(trg_entry) == IN_PACK(src_entry) &&
 	    !src_entry->preferred_base &&
 	    trg_entry->in_pack_type != OBJ_REF_DELTA &&
 	    trg_entry->in_pack_type != OBJ_OFS_DELTA)
@@ -3191,6 +3200,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	/* make sure IN_PACK(0) return NULL */
+	oe_add_pack(&to_pack, NULL);
+
 	if (progress)
 		progress_state = start_progress(_("Counting objects"), 0);
 	if (!use_internal_rev_list)
diff --git a/cache.h b/cache.h
index 862bdff83a..b90feb3802 100644
--- a/cache.h
+++ b/cache.h
@@ -1635,6 +1635,7 @@ extern struct packed_git {
 	int index_version;
 	time_t mtime;
 	int pack_fd;
+	int index;		/* for builtin/pack-objects.c */
 	unsigned pack_local:1,
 		 pack_keep:1,
 		 freshened:1,
diff --git a/pack-objects.h b/pack-objects.h
index 9ab0ce300d..59c44b3420 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -3,6 +3,7 @@
 
 #define OE_DFS_STATE_BITS	2
 #define OE_DEPTH_BITS		12
+#define OE_IN_PACK_BITS		14
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -18,6 +19,10 @@ enum dfs_state {
 };
 
 /*
+ * The size of struct nearly determines pack-objects's memory
+ * consumption. This struct is packed tight for that reason. When you
+ * add or reorder something in this struct, think a bit about this.
+ *
  * basic object info
  * -----------------
  * idx.oid is filled up before delta searching starts. idx.crc32 and
@@ -66,7 +71,6 @@ enum dfs_state {
 struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;	/* uncompressed size */
-	struct packed_git *in_pack;	/* already in pack */
 	off_t in_pack_offset;
 	struct object_entry *delta;	/* delta base object */
 	struct object_entry *delta_child; /* deltified objects who bases me */
@@ -78,6 +82,7 @@ struct object_entry {
 	unsigned long z_delta_size;	/* delta data size (compressed) */
 	uint32_t hash;			/* name hint hash */
 	unsigned char in_pack_header_size; /* note: spare bits available! */
+	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	unsigned type:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
 	unsigned preferred_base:1; /*
@@ -89,9 +94,12 @@ struct object_entry {
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 	unsigned dfs_state:OE_DFS_STATE_BITS;
+
+	/* XXX 8 bits hole, try to pack */
+
 	unsigned depth:OE_DEPTH_BITS;
 
-	/* size: 112, bit_padding: 8 bits */
+	/* size: 112, padding: 4, bit_padding: 18 bits */
 };
 
 struct packing_data {
@@ -102,6 +110,8 @@ struct packing_data {
 	uint32_t index_size;
 
 	unsigned int *in_pack_pos;
+	int in_pack_count;
+	struct packed_git *in_pack[1 << OE_IN_PACK_BITS];
 };
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
@@ -145,4 +155,39 @@ static inline void oe_set_in_pack_pos(const struct packing_data *pack,
 	pack->in_pack_pos[e - pack->objects] = pos;
 }
 
+static inline unsigned int oe_add_pack(struct packing_data *pack,
+				       struct packed_git *p)
+{
+	if (pack->in_pack_count >= (1 << OE_IN_PACK_BITS))
+		die(_("too many packs to handle in one go. "
+		      "Please add .keep files to exclude\n"
+		      "some pack files and keep the number "
+		      "of non-kept files below %d."),
+		    1 << OE_IN_PACK_BITS);
+	if (p) {
+		if (p->index > 0)
+			die("BUG: this packed is already indexed");
+		p->index = pack->in_pack_count;
+	}
+	pack->in_pack[pack->in_pack_count] = p;
+	return pack->in_pack_count++;
+}
+
+static inline struct packed_git *oe_in_pack(const struct packing_data *pack,
+					    const struct object_entry *e)
+{
+	return pack->in_pack[e->in_pack_idx];
+
+}
+
+static inline void oe_set_in_pack(struct object_entry *e,
+				  struct packed_git *p)
+{
+	if (p->index <= 0)
+		die("BUG: found_pack should be NULL "
+		    "instead of having non-positive index");
+	e->in_pack_idx = p->index;
+
+}
+
 #endif
-- 
2.16.2.873.g32ff258c87


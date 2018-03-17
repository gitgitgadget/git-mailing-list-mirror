Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03DCC1FAE4
	for <e@80x24.org>; Sat, 17 Mar 2018 14:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753199AbeCQOLR (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 10:11:17 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35150 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752858AbeCQOKz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 10:10:55 -0400
Received: by mail-lf0-f67.google.com with SMTP id t132-v6so19329357lfe.2
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 07:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OnKI5Yb4Fj+qv77YUM7V5RczBJYDXL3qxIJpc5hb870=;
        b=I6kBPbXXNqzkjvnz2Wdw07yq4dIpwuEKssOaK2AuZbcW8dfhxbaWdreJb5HIX3TWUs
         Kudfi8G45/4Qlz3Yjsl9YZLqPKE6lQ5AqgIpBpCp0eTQYsKoA1buMB6TZpg+gGCwhSc6
         hzJPD9/7jEUg+OdZaX2ShfocktzOBQBL6N93Zz1J4/NQM7MLz6WhjR72E+oxqDd5aqAm
         KYtaTXWgihQyO3BLIJxXV9faK0673+3HfzRZKgppGgkxw6LGuklD7MRWl+tidQmGlYWE
         Nrqbt7z7aLOOzgSpwY6pAi4si3qBGCie6eMq5hIacFV93z9Cw8+N6w7sHoVnNYC0qREh
         USYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OnKI5Yb4Fj+qv77YUM7V5RczBJYDXL3qxIJpc5hb870=;
        b=FfoF+9WkLDW2e19ZgDFLtIqZVDmnMIXsEieZ0b3Bwyuk/SrUuRMzY+h5S2HOXE3eDm
         FKvreGAYpFYVZyuxkoa4qDm/dbyvID+F8Umc4koIN9si/hczhX2oONDGt6T1A+GDgA4m
         jkuYpRKFc2vRwZD4j8KE2BUPd3Cf+Qs+cTeF9v863Cp28N4zQufs6qOdQOG5IKcFnuJu
         L4yx25HSsU6VP642k/FJ10B5Q2U9FfvvpvesecvGaJmWp1kDA9GOvLWYTeOSDADNANLy
         tUl4bv836wuVLy0ryvFl9ZARRw1sQ2wEd06O1oPEUX69VuCY2jLElNeo2ybHfH1TcGNi
         Xy9g==
X-Gm-Message-State: AElRT7Gth2XQhadW0SeDmS3+Jb17Z4NsGeG/QOsfq21/8u/P/Lqn9OS+
        cGGnm2QbcUhQu+BSW3qvuc8=
X-Google-Smtp-Source: AG47ELsAXiAOPEvUkbBPT/ZMnRVqHT6dXNOpnQpQxWw7U3Pnzjgoktx45z0Zw68H0eggMVNkPpJEHA==
X-Received: by 2002:a19:590c:: with SMTP id n12-v6mr4076641lfb.10.1521295853717;
        Sat, 17 Mar 2018 07:10:53 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f7-v6sm625648lfb.2.2018.03.17.07.10.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 07:10:52 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v5 06/11] pack-objects: move in_pack out of struct object_entry
Date:   Sat, 17 Mar 2018 15:10:28 +0100
Message-Id: <20180317141033.21545-7-pclouds@gmail.com>
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

Instead of using 8 bytes (on 64 bit arch) to store a pointer to a
pack. Use an index instead since the number of packs should be
relatively small.

This limits the number of packs we can handle to 16k. For now if you hit
16k pack files limit, pack-objects will simply fail [1].

[1] The escape hatch is .keep file to limit the non-kept pack files
    below 16k limit. Then you can go for another pack-objects run to
    combine another 16k pack files. Repeat until you're satisfied.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-pack-objects.txt |  9 ++++++
 builtin/pack-objects.c             | 40 +++++++++++++++++----------
 cache.h                            |  1 +
 pack-objects.h                     | 44 +++++++++++++++++++++++++++++-
 4 files changed, 79 insertions(+), 15 deletions(-)

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
index 727d200770..eaf78fa41a 100644
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
 	else if (oe_type(entry) == OBJ_REF_DELTA ||
 		 oe_type(entry) == OBJ_OFS_DELTA)
@@ -1025,7 +1027,7 @@ static int want_object_in_pack(const struct object_id *oid,
 	if (*found_pack) {
 		want = want_found_object(exclude, *found_pack);
 		if (want != -1)
-			return want;
+			goto done;
 	}
 
 	list_for_each(pos, &packed_git_mru) {
@@ -1048,11 +1050,16 @@ static int want_object_in_pack(const struct object_id *oid,
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
index b832ee2b5e..933f71a86b 100644
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
  * idx.oid is filled up before delta searching starts. idx.crc32 is
@@ -65,7 +70,7 @@ enum dfs_state {
 struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;	/* uncompressed size */
-	struct packed_git *in_pack;	/* already in pack */
+	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	off_t in_pack_offset;
 	struct object_entry *delta;	/* delta base object */
 	struct object_entry *delta_child; /* deltified objects who bases me */
@@ -100,6 +105,8 @@ struct packing_data {
 	uint32_t index_size;
 
 	unsigned int *in_pack_pos;
+	int in_pack_count;
+	struct packed_git *in_pack[1 << OE_IN_PACK_BITS];
 };
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
@@ -158,4 +165,39 @@ static inline void oe_set_in_pack_pos(const struct packing_data *pack,
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
2.17.0.rc0.347.gf9cf61673a


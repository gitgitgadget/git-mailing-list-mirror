Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 427481F42D
	for <e@80x24.org>; Sat, 31 Mar 2018 10:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753150AbeCaKDd (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 06:03:33 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42823 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753079AbeCaKDb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 06:03:31 -0400
Received: by mail-lf0-f68.google.com with SMTP id a22-v6so15117895lfg.9
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 03:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DVw0hnUsuPEAcAH9BtNJzo3ATGfSEM38JFNd0Msglzo=;
        b=Wqp/BXgLbKjWQ5w49V4hM7jv94nLKVZ/BFBBqTF7tvot5XwQdTXykv0Nb8oPSh31VN
         Zz+iqlmJqMNCeq9inWs7VpYQFaxoH4lfw+aKBm+ER7UCFRbcvdjBy55W/KKG3QISPzmg
         iSDOKs5q1L6uCZe5nBZeTIHXDZ5XPITI0+7bKZIwb6TCpZAyZTdoEECFDITvEN//FUeK
         5TX6GAWzrfDxZDsQUxTTqTeDfTcGo6LXaaaIcQckKuU4jP4AK4BPdDqs/iEnOdqap902
         sMAanW3d5NffS/33cKJAEwWdt1PiG8Se4i7TxrM2CHnQ8H7LAiS1MG7xk92nySJzMXOe
         YE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DVw0hnUsuPEAcAH9BtNJzo3ATGfSEM38JFNd0Msglzo=;
        b=B6hi05sTjXOzlWhYAIftWyBhwJeirphNuVMfUTrmP4uzx8pf9G432V/6FLLbJbhKmY
         ACMe7ezbZEgiTkEM8A7b16Yw9F7D5eJ5e/DMw9Pf4pa6LeZP0v8W0OeKkPjeZWHclL04
         otck+L+QFVnc7dh6u819E3Cqxp/L7MccgK22mAwwknqMCH3CN0wYTmh6FiMZEorKLiAR
         odd24DSsV/WewzscW6BelHuIKQfnqPsjYE6wqANW9gODma0tCaj/q7/Ayh+5xZxiJ/dM
         Lp1aCIxxxwHonw4xMmQK/LPU4l+KBgSrTd+OHqFXQnx4H7aJJPxn9onR1/3jvyh5Pgnl
         k/mw==
X-Gm-Message-State: ALQs6tDu3+ilYtKwTcsfCXY6+kzHl/Vw0F8dUg5iY/yEFmYVIjovG46G
        FXcpt1kfyf+cYz074CIq69jdIw==
X-Google-Smtp-Source: AIpwx48TQ7G6MFyJyuvDl9qG8AuFVfIqBw2Uul4K0zZ8pxTGtfHhzRu3vgxKYl0jbWO+rd2BCH8oGA==
X-Received: by 10.46.146.131 with SMTP id d3mr1422257ljh.18.1522490609574;
        Sat, 31 Mar 2018 03:03:29 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id a1sm1799175ljj.90.2018.03.31.03.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Mar 2018 03:03:28 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v8 07/15] pack-objects: move in_pack out of struct object_entry
Date:   Sat, 31 Mar 2018 12:03:03 +0200
Message-Id: <20180331100311.32373-8-pclouds@gmail.com>
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

Instead of using 8 bytes (on 64 bit arch) to store a pointer to a
pack. Use an index instead since the number of packs should be
relatively small.

This limits the number of packs we can handle to 1k. Since we can't be
sure people can never run into the situation where they have more than
1k pack files. Provide a fall back route for it.

If we find out they have too many packs, the new in_pack_by_idx[]
array (which has at most 1k elements) will not be used. Instead we
allocate in_pack[] array that holds nr_objects elements. This is
similar to how the optional in_pack_pos field is handled.

The new simple test is just to make sure the too-many-packs code path
is at least executed. The true test is running

    make test GIT_TEST_FULL_IN_PACK_ARRAY=1

to take advantage of other special case tests.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 28 +++++++++++-------
 cache.h                |  1 +
 pack-objects.c         | 66 ++++++++++++++++++++++++++++++++++++++++++
 pack-objects.h         | 36 ++++++++++++++++++++++-
 t/README               |  4 +++
 t/t5300-pack-object.sh |  5 ++++
 6 files changed, 128 insertions(+), 12 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7a672366bf..4e5812a053 100644
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
@@ -1074,7 +1076,7 @@ static void create_object_entry(const struct object_id *oid,
 	else
 		nr_result++;
 	if (found_pack) {
-		entry->in_pack = found_pack;
+		oe_set_in_pack(&to_pack, entry, found_pack);
 		entry->in_pack_offset = found_offset;
 	}
 
@@ -1399,8 +1401,8 @@ static void cleanup_preferred_base(void)
 
 static void check_object(struct object_entry *entry)
 {
-	if (entry->in_pack) {
-		struct packed_git *p = entry->in_pack;
+	if (IN_PACK(entry)) {
+		struct packed_git *p = IN_PACK(entry);
 		struct pack_window *w_curs = NULL;
 		const unsigned char *base_ref = NULL;
 		struct object_entry *base_entry;
@@ -1535,14 +1537,16 @@ static int pack_offset_sort(const void *_a, const void *_b)
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
@@ -1578,7 +1582,7 @@ static void drop_reused_delta(struct object_entry *entry)
 
 	oi.sizep = &entry->size;
 	oi.typep = &type;
-	if (packed_object_info(entry->in_pack, entry->in_pack_offset, &oi) < 0) {
+	if (packed_object_info(IN_PACK(entry), entry->in_pack_offset, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
 		 * fall back to sha1_object_info, which may find another copy.
@@ -1848,8 +1852,8 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
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
@@ -3193,6 +3197,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	prepare_packing_data(&to_pack);
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
diff --git a/pack-objects.c b/pack-objects.c
index 9558d13834..09f0a88865 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -2,6 +2,8 @@
 #include "object.h"
 #include "pack.h"
 #include "pack-objects.h"
+#include "packfile.h"
+#include "config.h"
 
 static uint32_t locate_object_entry_hash(struct packing_data *pdata,
 					 const unsigned char *sha1,
@@ -86,6 +88,64 @@ struct object_entry *packlist_find(struct packing_data *pdata,
 	return &pdata->objects[pdata->index[i] - 1];
 }
 
+static void prepare_in_pack_by_idx(struct packing_data *pdata)
+{
+	struct packed_git **mapping, *p;
+	int cnt = 0, nr = 1U << OE_IN_PACK_BITS;
+
+	ALLOC_ARRAY(mapping, nr);
+	/*
+	 * oe_in_pack() on an all-zero'd object_entry
+	 * (i.e. in_pack_idx also zero) should return NULL.
+	 */
+	mapping[cnt++] = NULL;
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next, cnt++) {
+		if (cnt == nr) {
+			free(mapping);
+			return;
+		}
+		p->index = cnt;
+		mapping[cnt] = p;
+	}
+	pdata->in_pack_by_idx = mapping;
+}
+
+/*
+ * A new pack appears after prepare_in_pack_by_idx() has been
+ * run. This is likely a race.
+ *
+ * We could map this new pack to in_pack_by_idx[] array, but then we
+ * have to deal with full array anyway. And since it's hard to test
+ * this fall back code, just stay simple and fall back to using
+ * in_pack[] array.
+ */
+void oe_map_new_pack(struct packing_data *pack,
+		     struct packed_git *p)
+{
+	uint32_t i;
+
+	REALLOC_ARRAY(pack->in_pack, pack->nr_alloc);
+
+	for (i = 0; i < pack->nr_objects; i++)
+		pack->in_pack[i] = oe_in_pack(pack, pack->objects + i);
+
+	FREE_AND_NULL(pack->in_pack_by_idx);
+}
+
+/* assume pdata is already zero'd by caller */
+void prepare_packing_data(struct packing_data *pdata)
+{
+	if (git_env_bool("GIT_TEST_FULL_IN_PACK_ARRAY", 0)) {
+		/*
+		 * do not initialize in_pack_by_idx[] to force the
+		 * slow path in oe_in_pack()
+		 */
+	} else {
+		prepare_in_pack_by_idx(pdata);
+	}
+}
+
 struct object_entry *packlist_alloc(struct packing_data *pdata,
 				    const unsigned char *sha1,
 				    uint32_t index_pos)
@@ -95,6 +155,9 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 	if (pdata->nr_objects >= pdata->nr_alloc) {
 		pdata->nr_alloc = (pdata->nr_alloc  + 1024) * 3 / 2;
 		REALLOC_ARRAY(pdata->objects, pdata->nr_alloc);
+
+		if (!pdata->in_pack_by_idx)
+			REALLOC_ARRAY(pdata->in_pack, pdata->nr_alloc);
 	}
 
 	new_entry = pdata->objects + pdata->nr_objects++;
@@ -107,5 +170,8 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 	else
 		pdata->index[index_pos] = pdata->nr_objects;
 
+	if (pdata->in_pack)
+		pdata->in_pack[pdata->nr_objects - 1] = NULL;
+
 	return new_entry;
 }
diff --git a/pack-objects.h b/pack-objects.h
index 71ea992c3c..4a8aa56042 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -3,6 +3,7 @@
 
 #define OE_DFS_STATE_BITS	2
 #define OE_DEPTH_BITS		12
+#define OE_IN_PACK_BITS		10
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -65,7 +66,7 @@ enum dfs_state {
 struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;	/* uncompressed size */
-	struct packed_git *in_pack;	/* already in pack */
+	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	off_t in_pack_offset;
 	struct object_entry *delta;	/* delta base object */
 	struct object_entry *delta_child; /* deltified objects who bases me */
@@ -100,8 +101,18 @@ struct packing_data {
 	uint32_t index_size;
 
 	unsigned int *in_pack_pos;
+
+	/*
+	 * Only one of these can be non-NULL and they have different
+	 * sizes. if in_pack_by_idx is allocated, oe_in_pack() returns
+	 * the pack of an object using in_pack_idx field. If not,
+	 * in_pack[] array is used the same way as in_pack_pos[]
+	 */
+	struct packed_git **in_pack_by_idx;
+	struct packed_git **in_pack;
 };
 
+void prepare_packing_data(struct packing_data *pdata);
 struct object_entry *packlist_alloc(struct packing_data *pdata,
 				    const unsigned char *sha1,
 				    uint32_t index_pos);
@@ -158,4 +169,27 @@ static inline void oe_set_in_pack_pos(const struct packing_data *pack,
 	pack->in_pack_pos[e - pack->objects] = pos;
 }
 
+static inline struct packed_git *oe_in_pack(const struct packing_data *pack,
+					    const struct object_entry *e)
+{
+	if (pack->in_pack_by_idx)
+		return pack->in_pack_by_idx[e->in_pack_idx];
+	else
+		return pack->in_pack[e - pack->objects];
+}
+
+void oe_map_new_pack(struct packing_data *pack,
+		     struct packed_git *p);
+static inline void oe_set_in_pack(struct packing_data *pack,
+				  struct object_entry *e,
+				  struct packed_git *p)
+{
+	if (!p->index)
+		oe_map_new_pack(pack, p);
+	if (pack->in_pack_by_idx)
+		e->in_pack_idx = p->index;
+	else
+		pack->in_pack[e - pack->objects] = p;
+}
+
 #endif
diff --git a/t/README b/t/README
index 09eb2b9768..c6130ff16d 100644
--- a/t/README
+++ b/t/README
@@ -302,6 +302,10 @@ environment set.
 
 GIT_TEST_SPLIT_INDEX forces split-index mode on the whole test suite.
 
+GIT_TEST_FULL_IN_PACK_ARRAY exercises the uncommon pack-objects code
+path where there are more than 1024 packs even if the actual number of
+packs in repository is below this limit.
+
 Naming Tests
 ------------
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 9c68b99251..5c076637ff 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -457,6 +457,11 @@ test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'pack-objects --threads=N or pack.
 	grep -F "no threads support, ignoring pack.threads" err
 '
 
+test_expect_success 'pack-objects in too-many-packs mode' '
+	GIT_TEST_FULL_IN_PACK_ARRAY=1 git repack -ad &&
+	git fsck
+'
+
 #
 # WARNING!
 #
-- 
2.17.0.rc2.515.g4feb9b7923


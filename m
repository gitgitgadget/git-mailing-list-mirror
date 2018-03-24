Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AEB51F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 06:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbeCXGeV (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 02:34:21 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40545 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbeCXGeP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 02:34:15 -0400
Received: by mail-lf0-f68.google.com with SMTP id e5-v6so21289429lfb.7
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 23:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IQFbAVhqaktPgxOTlCm7/GX3ZhvPNety+gFm80qM6Nc=;
        b=a/3atDnTQIpdADiA5n8NOLh7HRE4ZMgAVuLQnQVxaXViivxYXpNENksWlRX2Okq4JZ
         KtCnMUStdNawRP7LH27pz4Z5vyMKxoaODFAPbagZft81pndrpzlWPVDf5nmISJOSBHdO
         iO4jouLMwY6uKgNm9pEcgzG5LqMNpDF2juj7MBOsHPU73YQXa3nrEBPwt10RYsexPhC3
         jNCK8hjgrsezgenqYfFAs4JMs8/jfWfWn9swSyUYogTui29ZnZhtOcf43fkMwhw0iqqW
         bbO/XzO5shqA0ASlDKahTjOQzAIaFfAHcaheVa4aihnPeR+MDwrX58wSMyRkxv7+xh9A
         3EUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IQFbAVhqaktPgxOTlCm7/GX3ZhvPNety+gFm80qM6Nc=;
        b=FHQLpCyRbl0IRkUXfAh0G/73zWM0fDc75BWgoSPbY77ePemherY94HuvlvWHgLpnQq
         9tfruvgEiX3SxINOmUJe7l5NSUVDfInmSxrekFyieQh6mQcY4V3w9KJ16is7hPhI0bTL
         Q1BKL9D1VrtyYvdssyc9WoggOyvPAFqWXfZPqwJv7JLoIRsSjLmMuF9vbono8vYE7H84
         RJ0q6l3c68TpvvRat8bJgyxQQRak1Jgrh99yTVV/0loJ5O3/YjF7lTSemJGix5jtnWO6
         Vr0eb7TY5tnQp8Noc0B/KtnC95lJFK2FXfx+RMX11MJJTunNVCgr1oVf6UdBXH6IOOoc
         YD8A==
X-Gm-Message-State: AElRT7HfwfETq3mra3zidn/aXOIRGtlegb0IOeh2PzlJp1+wslOA3qIR
        +wEDDR2YW3MUTuV+EemkW3c=
X-Google-Smtp-Source: AG47ELtbjyniurTx462ZROIwR5xO94omZAq79FDl6t6a5TS8BJIgWZ5Q/u43eosFgpraMMq7LyBEWw==
X-Received: by 2002:a19:9fd3:: with SMTP id i202-v6mr20375471lfe.123.1521873253219;
        Fri, 23 Mar 2018 23:34:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h8sm2251703lja.41.2018.03.23.23.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 23:34:12 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v7 06/13] pack-objects: move in_pack out of struct object_entry
Date:   Sat, 24 Mar 2018 07:33:46 +0100
Message-Id: <20180324063353.24722-7-pclouds@gmail.com>
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
 builtin/pack-objects.c | 26 +++++++++++++++-----------
 cache.h                |  1 +
 pack-objects.c         | 36 ++++++++++++++++++++++++++++++++++++
 pack-objects.h         | 40 +++++++++++++++++++++++++++++++++++++++-
 t/README               |  4 ++++
 t/t5300-pack-object.sh |  5 +++++
 6 files changed, 100 insertions(+), 12 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e1244918a5..b41610569e 100644
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
index 9558d13834..13f2b2bff2 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -2,6 +2,7 @@
 #include "object.h"
 #include "pack.h"
 #include "pack-objects.h"
+#include "packfile.h"
 
 static uint32_t locate_object_entry_hash(struct packing_data *pdata,
 					 const unsigned char *sha1,
@@ -86,15 +87,47 @@ struct object_entry *packlist_find(struct packing_data *pdata,
 	return &pdata->objects[pdata->index[i] - 1];
 }
 
+static void prepare_in_pack_by_idx(struct packing_data *pdata)
+{
+	struct packed_git **mapping, *p;
+	int cnt = 0, nr = 1 << OE_IN_PACK_BITS;
+
+	if (getenv("GIT_TEST_FULL_IN_PACK_ARRAY")) {
+		/*
+		 * leave in_pack_by_idx NULL to force in_pack[] to be
+		 * used instead
+		 */
+		return;
+	}
+
+	ALLOC_ARRAY(mapping, nr);
+	mapping[cnt++] = NULL; /* zero index must be mapped to NULL */
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
 struct object_entry *packlist_alloc(struct packing_data *pdata,
 				    const unsigned char *sha1,
 				    uint32_t index_pos)
 {
 	struct object_entry *new_entry;
 
+	if (!pdata->nr_objects)
+		prepare_in_pack_by_idx(pdata);
 	if (pdata->nr_objects >= pdata->nr_alloc) {
 		pdata->nr_alloc = (pdata->nr_alloc  + 1024) * 3 / 2;
 		REALLOC_ARRAY(pdata->objects, pdata->nr_alloc);
+
+		if (!pdata->in_pack_by_idx)
+			REALLOC_ARRAY(pdata->in_pack, pdata->nr_alloc);
 	}
 
 	new_entry = pdata->objects + pdata->nr_objects++;
@@ -107,5 +140,8 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 	else
 		pdata->index[index_pos] = pdata->nr_objects;
 
+	if (pdata->in_pack)
+		pdata->in_pack[pdata->nr_objects - 1] = NULL;
+
 	return new_entry;
 }
diff --git a/pack-objects.h b/pack-objects.h
index 4a11653657..cae4f4fe01 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -3,6 +3,7 @@
 
 #define OE_DFS_STATE_BITS	2
 #define OE_DEPTH_BITS		12
+#define OE_IN_PACK_BITS		10
 
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
@@ -100,6 +105,15 @@ struct packing_data {
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
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
@@ -158,4 +172,28 @@ static inline void oe_set_in_pack_pos(const struct packing_data *pack,
 	pack->in_pack_pos[e - pack->objects] = pos;
 }
 
+static inline struct packed_git *oe_in_pack(const struct packing_data *pack,
+					    const struct object_entry *e)
+{
+	if (pack->in_pack_by_idx)
+		return pack->in_pack_by_idx[e->in_pack_idx];
+	else
+		return pack->in_pack[e - pack->objects];
+
+}
+
+static inline void oe_set_in_pack(struct packing_data *pack,
+				  struct object_entry *e,
+				  struct packed_git *p)
+{
+	if (pack->in_pack_by_idx) {
+		if (p->index <= 0)
+			die("BUG: found_pack should be NULL "
+					"instead of having non-positive index");
+			e->in_pack_idx = p->index;
+	} else
+		pack->in_pack[e - pack->objects] = p;
+
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
2.17.0.rc0.348.gd5a49e0b6f


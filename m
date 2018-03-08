Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DF711FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 11:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965823AbeCHLn2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 06:43:28 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33118 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965506AbeCHLn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 06:43:27 -0500
Received: by mail-pg0-f67.google.com with SMTP id g12so2120769pgs.0
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 03:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SA21INJr92EzjilSaELUFEDDOLGkH3pUdqsdkHzrZ9w=;
        b=sUh6GB4TJD2RIBvq7Aeez+vI/X5WswT3sZZwT/1r61VFMnuARyM8cAVeXsErc9ZGL9
         G8UN+GjSwAjcYWsNNpFWpB8sFd0x7lj36o859WfFZznZO/n1NSIbahzppR+ADf/1jYwK
         c/eIFk0h0nIS/tKdnt/sVWkDihs+SGM6WeMQAzahUct2E/E8s7d0XaZoKDGg7/G62tWN
         kJmee6aUhqKWzx9vJ+2zIt3d6U07PYCdokYjvCAxuSu1hja2fVpQdtdR5DMoLmsI5woe
         bmF2k34x4uFMxGi47PDkJafk6uX2LKwTqIB/qNhxPwqLxkP2Mkw6+S2o1hOGEvy9mdog
         jEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SA21INJr92EzjilSaELUFEDDOLGkH3pUdqsdkHzrZ9w=;
        b=EspPfy5getie2yAWhJ/OhFp7SN6Ev+jCVUPhxsp0JJtQOa4e1eWwLUReHFGotPdVyG
         n4GvzQPX6bERjRRMDHNKECJMRzU0sVJvWwG1hsi3G+Cb6KDzzVPXIacSyPo3lSxZdiFH
         3pCR9In02a6gosVz9jRqb1TZYQldB2GjwcZ4AUj2/OCjBmyrfvEvk2QRH5RJG1IzpLHX
         ppXPRcjXl6XNV1QhJJGDDT9Gcl+TOTQ7xT5eIgOq4Nbo3Oqn9kuLwoBpSyjhKFgMMRM3
         xMvqsSoAp16bsvU/crVSEBjS4bi2BUyDzsQ7ajNqodtIcyWDoxnJSefNc2B0vTW4umAG
         4Uyw==
X-Gm-Message-State: APf1xPB7rMEhmEmvNkgxW8Jn/lTUp0Mzf92J+JIG0gNZisBmR+l4bXJD
        y7gEVQqWmMBnBAGSc2bGwxnQLg==
X-Google-Smtp-Source: AG47ELuqkwfcJ1aclR55EZXv3fo5auQpEOgyNqxhpc3/w0AbOOfH34Nt/AgeGAO7GYrCPcGcNxNQeQ==
X-Received: by 10.101.101.204 with SMTP id y12mr21310036pgv.450.1520509406164;
        Thu, 08 Mar 2018 03:43:26 -0800 (PST)
Received: from ash ([27.78.177.129])
        by smtp.gmail.com with ESMTPSA id b21sm39826140pfn.145.2018.03.08.03.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 03:43:25 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 08 Mar 2018 18:43:21 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH/RFC v3 08/12] pack-objects: refer to delta objects by index instead of pointer
Date:   Thu,  8 Mar 2018 18:42:28 +0700
Message-Id: <20180308114232.10508-9-pclouds@gmail.com>
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

Notice that packing_data::nr_objects is uint32_t, we could only handle
maximum 4G objects and can address all of them with an uint32_t. If we
use a pointer here, we waste 4 bytes on 64 bit architecture.

Convert these delta pointers to indexes. Since we need to handle NULL
pointers as well, the index is shifted by one [1].

There are holes in this struct but this patch is already big. Struct
packing can be done separately. Even with holes, we save 8 bytes per
object_entry.

[1] This means we can only index 2^32-2 objects even though nr_objects
    could contain 2^32-1 objects. It should not be a problem in
    practice because when we grow objects[], nr_alloc would probably
    blow up long before nr_objects hits the wall.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 116 ++++++++++++++++++++++-------------------
 pack-objects.h         |  71 ++++++++++++++++++++++---
 2 files changed, 127 insertions(+), 60 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7df525e201..82a4a95888 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -30,6 +30,12 @@
 #include "packfile.h"
 
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
+#define DELTA(obj) oe_delta(&to_pack, obj)
+#define DELTA_CHILD(obj) oe_delta_child(&to_pack, obj)
+#define DELTA_SIBLING(obj) oe_delta_sibling(&to_pack, obj)
+#define SET_DELTA(obj, val) oe_set_delta(&to_pack, obj, val)
+#define SET_DELTA_CHILD(obj, val) oe_set_delta_child(&to_pack, obj, val)
+#define SET_DELTA_SIBLING(obj, val) oe_set_delta_sibling(&to_pack, obj, val)
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
@@ -127,11 +133,11 @@ static void *get_delta(struct object_entry *entry)
 	buf = read_sha1_file(entry->idx.oid.hash, &type, &size);
 	if (!buf)
 		die("unable to read %s", oid_to_hex(&entry->idx.oid));
-	base_buf = read_sha1_file(entry->delta->idx.oid.hash, &type,
+	base_buf = read_sha1_file(DELTA(entry)->idx.oid.hash, &type,
 				  &base_size);
 	if (!base_buf)
 		die("unable to read %s",
-		    oid_to_hex(&entry->delta->idx.oid));
+		    oid_to_hex(&DELTA(entry)->idx.oid));
 	delta_buf = diff_delta(base_buf, base_size,
 			       buf, size, &delta_size, 0);
 	if (!delta_buf || delta_size != entry->delta_size)
@@ -288,12 +294,12 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		size = entry->delta_size;
 		buf = entry->delta_data;
 		entry->delta_data = NULL;
-		type = (allow_ofs_delta && entry->delta->idx.offset) ?
+		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
 	} else {
 		buf = get_delta(entry);
 		size = entry->delta_size;
-		type = (allow_ofs_delta && entry->delta->idx.offset) ?
+		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
 	}
 
@@ -317,7 +323,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		 * encoding of the relative offset for the delta
 		 * base from this object's position in the pack.
 		 */
-		off_t ofs = entry->idx.offset - entry->delta->idx.offset;
+		off_t ofs = entry->idx.offset - DELTA(entry)->idx.offset;
 		unsigned pos = sizeof(dheader) - 1;
 		dheader[pos] = ofs & 127;
 		while (ofs >>= 7)
@@ -343,7 +349,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 			return 0;
 		}
 		hashwrite(f, header, hdrlen);
-		hashwrite(f, entry->delta->idx.oid.hash, 20);
+		hashwrite(f, DELTA(entry)->idx.oid.hash, 20);
 		hdrlen += 20;
 	} else {
 		if (limit && hdrlen + datalen + 20 >= limit) {
@@ -379,8 +385,8 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 		      dheader[MAX_PACK_OBJECT_HEADER];
 	unsigned hdrlen;
 
-	if (entry->delta)
-		type = (allow_ofs_delta && entry->delta->idx.offset) ?
+	if (DELTA(entry))
+		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
 	hdrlen = encode_in_pack_object_header(header, sizeof(header),
 					      type, entry->size);
@@ -408,7 +414,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	}
 
 	if (type == OBJ_OFS_DELTA) {
-		off_t ofs = entry->idx.offset - entry->delta->idx.offset;
+		off_t ofs = entry->idx.offset - DELTA(entry)->idx.offset;
 		unsigned pos = sizeof(dheader) - 1;
 		dheader[pos] = ofs & 127;
 		while (ofs >>= 7)
@@ -427,7 +433,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 			return 0;
 		}
 		hashwrite(f, header, hdrlen);
-		hashwrite(f, entry->delta->idx.oid.hash, 20);
+		hashwrite(f, DELTA(entry)->idx.oid.hash, 20);
 		hdrlen += 20;
 		reused_delta++;
 	} else {
@@ -467,13 +473,13 @@ static off_t write_object(struct hashfile *f,
 	else
 		limit = pack_size_limit - write_offset;
 
-	if (!entry->delta)
+	if (!DELTA(entry))
 		usable_delta = 0;	/* no delta */
 	else if (!pack_size_limit)
 	       usable_delta = 1;	/* unlimited packfile */
-	else if (entry->delta->idx.offset == (off_t)-1)
+	else if (DELTA(entry)->idx.offset == (off_t)-1)
 		usable_delta = 0;	/* base was written to another pack */
-	else if (entry->delta->idx.offset)
+	else if (DELTA(entry)->idx.offset)
 		usable_delta = 1;	/* base already exists in this pack */
 	else
 		usable_delta = 0;	/* base could end up in another pack */
@@ -488,7 +494,7 @@ static off_t write_object(struct hashfile *f,
 				/* ... but pack split may override that */
 	else if (entry->type != entry->in_pack_type)
 		to_reuse = 0;	/* pack has delta which is unusable */
-	else if (entry->delta)
+	else if (DELTA(entry))
 		to_reuse = 0;	/* we want to pack afresh */
 	else
 		to_reuse = 1;	/* we have it in-pack undeltified,
@@ -540,12 +546,12 @@ static enum write_one_status write_one(struct hashfile *f,
 	}
 
 	/* if we are deltified, write out base object first. */
-	if (e->delta) {
+	if (DELTA(e)) {
 		e->idx.offset = 1; /* now recurse */
-		switch (write_one(f, e->delta, offset)) {
+		switch (write_one(f, DELTA(e), offset)) {
 		case WRITE_ONE_RECURSIVE:
 			/* we cannot depend on this one */
-			e->delta = NULL;
+			SET_DELTA(e, NULL);
 			break;
 		default:
 			break;
@@ -607,34 +613,34 @@ static void add_descendants_to_write_order(struct object_entry **wo,
 			/* add this node... */
 			add_to_write_order(wo, endp, e);
 			/* all its siblings... */
-			for (s = e->delta_sibling; s; s = s->delta_sibling) {
+			for (s = DELTA_SIBLING(e); s; s = DELTA_SIBLING(s)) {
 				add_to_write_order(wo, endp, s);
 			}
 		}
 		/* drop down a level to add left subtree nodes if possible */
-		if (e->delta_child) {
+		if (DELTA_CHILD(e)) {
 			add_to_order = 1;
-			e = e->delta_child;
+			e = DELTA_CHILD(e);
 		} else {
 			add_to_order = 0;
 			/* our sibling might have some children, it is next */
-			if (e->delta_sibling) {
-				e = e->delta_sibling;
+			if (DELTA_SIBLING(e)) {
+				e = DELTA_SIBLING(e);
 				continue;
 			}
 			/* go back to our parent node */
-			e = e->delta;
-			while (e && !e->delta_sibling) {
+			e = DELTA(e);
+			while (e && !DELTA_SIBLING(e)) {
 				/* we're on the right side of a subtree, keep
 				 * going up until we can go right again */
-				e = e->delta;
+				e = DELTA(e);
 			}
 			if (!e) {
 				/* done- we hit our original root node */
 				return;
 			}
 			/* pass it off to sibling at this level */
-			e = e->delta_sibling;
+			e = DELTA_SIBLING(e);
 		}
 	};
 }
@@ -645,7 +651,7 @@ static void add_family_to_write_order(struct object_entry **wo,
 {
 	struct object_entry *root;
 
-	for (root = e; root->delta; root = root->delta)
+	for (root = e; DELTA(root); root = DELTA(root))
 		; /* nothing */
 	add_descendants_to_write_order(wo, endp, root);
 }
@@ -660,8 +666,8 @@ static struct object_entry **compute_write_order(void)
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		objects[i].tagged = 0;
 		objects[i].filled = 0;
-		objects[i].delta_child = NULL;
-		objects[i].delta_sibling = NULL;
+		SET_DELTA_CHILD(&objects[i], NULL);
+		SET_DELTA_SIBLING(&objects[i], NULL);
 	}
 
 	/*
@@ -671,11 +677,11 @@ static struct object_entry **compute_write_order(void)
 	 */
 	for (i = to_pack.nr_objects; i > 0;) {
 		struct object_entry *e = &objects[--i];
-		if (!e->delta)
+		if (!DELTA(e))
 			continue;
 		/* Mark me as the first child */
-		e->delta_sibling = e->delta->delta_child;
-		e->delta->delta_child = e;
+		e->delta_sibling_idx = DELTA(e)->delta_child_idx;
+		SET_DELTA_CHILD(DELTA(e), e);
 	}
 
 	/*
@@ -1498,10 +1504,10 @@ static void check_object(struct object_entry *entry)
 			 * circular deltas.
 			 */
 			entry->type = entry->in_pack_type;
-			entry->delta = base_entry;
+			SET_DELTA(entry, base_entry);
 			entry->delta_size = entry->size;
-			entry->delta_sibling = base_entry->delta_child;
-			base_entry->delta_child = entry;
+			entry->delta_sibling_idx = base_entry->delta_child_idx;
+			SET_DELTA_CHILD(base_entry, entry);
 			unuse_pack(&w_curs);
 			return;
 		}
@@ -1572,17 +1578,19 @@ static int pack_offset_sort(const void *_a, const void *_b)
  */
 static void drop_reused_delta(struct object_entry *entry)
 {
-	struct object_entry **p = &entry->delta->delta_child;
+	unsigned *idx = &to_pack.objects[entry->delta_idx - 1].delta_child_idx;
 	struct object_info oi = OBJECT_INFO_INIT;
 	enum object_type type;
 
-	while (*p) {
-		if (*p == entry)
-			*p = (*p)->delta_sibling;
+	while (*idx) {
+		struct object_entry *oe = &to_pack.objects[*idx - 1];
+
+		if (oe == entry)
+			*idx = oe->delta_sibling_idx;
 		else
-			p = &(*p)->delta_sibling;
+			idx = &oe->delta_sibling_idx;
 	}
-	entry->delta = NULL;
+	SET_DELTA(entry, NULL);
 	entry->depth = 0;
 
 	oi.sizep = &entry->size;
@@ -1624,7 +1632,7 @@ static void break_delta_chains(struct object_entry *entry)
 
 	for (cur = entry, total_depth = 0;
 	     cur;
-	     cur = cur->delta, total_depth++) {
+	     cur = DELTA(cur), total_depth++) {
 		if (cur->dfs_state == DFS_DONE) {
 			/*
 			 * We've already seen this object and know it isn't
@@ -1649,7 +1657,7 @@ static void break_delta_chains(struct object_entry *entry)
 		 * it's not a delta, we're done traversing, but we'll mark it
 		 * done to save time on future traversals.
 		 */
-		if (!cur->delta) {
+		if (!DELTA(cur)) {
 			cur->dfs_state = DFS_DONE;
 			break;
 		}
@@ -1672,7 +1680,7 @@ static void break_delta_chains(struct object_entry *entry)
 		 * We keep all commits in the chain that we examined.
 		 */
 		cur->dfs_state = DFS_ACTIVE;
-		if (cur->delta->dfs_state == DFS_ACTIVE) {
+		if (DELTA(cur)->dfs_state == DFS_ACTIVE) {
 			drop_reused_delta(cur);
 			cur->dfs_state = DFS_DONE;
 			break;
@@ -1687,7 +1695,7 @@ static void break_delta_chains(struct object_entry *entry)
 	 * an extra "next" pointer to keep going after we reset cur->delta.
 	 */
 	for (cur = entry; cur; cur = next) {
-		next = cur->delta;
+		next = DELTA(cur);
 
 		/*
 		 * We should have a chain of zero or more ACTIVE states down to
@@ -1870,7 +1878,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
 	/* Now some size filtering heuristics. */
 	trg_size = trg_entry->size;
-	if (!trg_entry->delta) {
+	if (!DELTA(trg_entry)) {
 		max_size = trg_size/2 - 20;
 		ref_depth = 1;
 	} else {
@@ -1946,7 +1954,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	if (!delta_buf)
 		return 0;
 
-	if (trg_entry->delta) {
+	if (DELTA(trg_entry)) {
 		/* Prefer only shallower same-sized deltas. */
 		if (delta_size == trg_entry->delta_size &&
 		    src->depth + 1 >= trg->depth) {
@@ -1975,7 +1983,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		free(delta_buf);
 	}
 
-	trg_entry->delta = src_entry;
+	SET_DELTA(trg_entry, src_entry);
 	trg_entry->delta_size = delta_size;
 	trg->depth = src->depth + 1;
 
@@ -1984,13 +1992,13 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 
 static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
 {
-	struct object_entry *child = me->delta_child;
+	struct object_entry *child = DELTA_CHILD(me);
 	unsigned int m = n;
 	while (child) {
 		unsigned int c = check_delta_limit(child, n + 1);
 		if (m < c)
 			m = c;
-		child = child->delta_sibling;
+		child = DELTA_SIBLING(child);
 	}
 	return m;
 }
@@ -2059,7 +2067,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		 * otherwise they would become too deep.
 		 */
 		max_depth = depth;
-		if (entry->delta_child) {
+		if (DELTA_CHILD(entry)) {
 			max_depth -= check_delta_limit(entry, 0);
 			if (max_depth <= 0)
 				goto next;
@@ -2109,7 +2117,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		 * depth, leaving it in the window is pointless.  we
 		 * should evict it first.
 		 */
-		if (entry->delta && max_depth <= n->depth)
+		if (DELTA(entry) && max_depth <= n->depth)
 			continue;
 
 		/*
@@ -2117,7 +2125,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		 * currently deltified object, to keep it longer.  It will
 		 * be the first base object to be attempted next.
 		 */
-		if (entry->delta) {
+		if (DELTA(entry)) {
 			struct unpacked swap = array[best_base];
 			int dist = (window + idx - best_base) % window;
 			int dst = best_base;
@@ -2438,7 +2446,7 @@ static void prepare_pack(int window, int depth)
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = to_pack.objects + i;
 
-		if (entry->delta)
+		if (DELTA(entry))
 			/* This happens if we decided to reuse existing
 			 * delta from a pack.  "reuse_delta &&" is implied.
 			 */
diff --git a/pack-objects.h b/pack-objects.h
index 59c44b3420..1c0ad4c9ef 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -72,11 +72,13 @@ struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;	/* uncompressed size */
 	off_t in_pack_offset;
-	struct object_entry *delta;	/* delta base object */
-	struct object_entry *delta_child; /* deltified objects who bases me */
-	struct object_entry *delta_sibling; /* other deltified objects who
-					     * uses the same base as me
-					     */
+	uint32_t delta_idx;	/* delta base object */
+	uint32_t delta_child_idx; /* deltified objects who bases me */
+	uint32_t delta_sibling_idx; /* other deltified objects who
+				     * uses the same base as me
+				     */
+	/* XXX 4 bytes hole, try to pack */
+
 	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	unsigned long z_delta_size;	/* delta data size (compressed) */
@@ -99,7 +101,7 @@ struct object_entry {
 
 	unsigned depth:OE_DEPTH_BITS;
 
-	/* size: 112, padding: 4, bit_padding: 18 bits */
+	/* size: 104, padding: 4, bit_padding: 18 bits */
 };
 
 struct packing_data {
@@ -190,4 +192,61 @@ static inline void oe_set_in_pack(struct object_entry *e,
 
 }
 
+static inline struct object_entry *oe_delta(
+		const struct packing_data *pack,
+		const struct object_entry *e)
+{
+	if (e->delta_idx)
+		return &pack->objects[e->delta_idx - 1];
+	return NULL;
+}
+
+static inline void oe_set_delta(struct packing_data *pack,
+				struct object_entry *e,
+				struct object_entry *delta)
+{
+	if (delta)
+		e->delta_idx = (delta - pack->objects) + 1;
+	else
+		e->delta_idx = 0;
+}
+
+static inline struct object_entry *oe_delta_child(
+		const struct packing_data *pack,
+		const struct object_entry *e)
+{
+	if (e->delta_child_idx)
+		return &pack->objects[e->delta_child_idx - 1];
+	return NULL;
+}
+
+static inline void oe_set_delta_child(struct packing_data *pack,
+				      struct object_entry *e,
+				      struct object_entry *delta)
+{
+	if (delta)
+		e->delta_child_idx = (delta - pack->objects) + 1;
+	else
+		e->delta_child_idx = 0;
+}
+
+static inline struct object_entry *oe_delta_sibling(
+		const struct packing_data *pack,
+		const struct object_entry *e)
+{
+	if (e->delta_sibling_idx)
+		return &pack->objects[e->delta_sibling_idx - 1];
+	return NULL;
+}
+
+static inline void oe_set_delta_sibling(struct packing_data *pack,
+					struct object_entry *e,
+					struct object_entry *delta)
+{
+	if (delta)
+		e->delta_sibling_idx = (delta - pack->objects) + 1;
+	else
+		e->delta_sibling_idx = 0;
+}
+
 #endif
-- 
2.16.2.873.g32ff258c87


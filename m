Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 935ED20899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbdHIBX0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:23:26 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36665 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752542AbdHIBXX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:23 -0400
Received: by mail-pf0-f171.google.com with SMTP id c28so21285103pfe.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=UjnWXnkKihrCRMQkQGPqymtLzgZ+kfa94e+6eM6umzY=;
        b=uWhS4NZJBCOIt9u1vneMFusCLBosy9DpYO7DVB8sE5QhbKZZ/PfZC78asGwfjOcySx
         dabffdNQYlwpypIxKLPt1hLCKcHJLs7RQ/XInsQwi6FIqLwE+w/080r3zxaNT0HQXgCm
         DUrLgHzc2Rdr1OH54jiTXoJgXG8dRm2wuLWnTzAdvp+oUJezbHeyWLBckXRbO4KfZNLU
         boYAq2MONZJm7aaA9eWROrpuNxC/b7po/1IiZbBueb46Lq5H3i5sbxYxE02tvBjA3yRB
         KKSD/L5T5cqDevTDOp0wkYgPecjadGoK/VcvTWE/uphceNL0l4eKJ/HmdaRZhnKeYONA
         Fmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=UjnWXnkKihrCRMQkQGPqymtLzgZ+kfa94e+6eM6umzY=;
        b=mZDtJfmviezLPcIji6ctb1MVcks1C0Jz2GN3AvE0NjaMFt5NrQ5r8uKlR7qGbZmta/
         Rsh9wsKMgh+JaiwB73heUgHF0iL3sJLpv7Rqu61L2gMnRLBlNZTyilJQk67hIboLwvM3
         sg/Aj251LJvWnRPJX8kHTey67c18llDkuuci6bCAYRF8XjUXd+9tVL2Dv3t5nD8Vzp/s
         WWRZ9dhnGy2tW/lWpi7sShAfmZP/HN3IIDLidnhGvttILScGAJDjE7rQL6Wk/9ZVXPYM
         COhqtrjjCdvnbM2MxzWaAQAn8ol4bP2Xgu7ui6Kk5i4FoLPcgQHyOmjrwh+YIIQ2mzQY
         R8Ow==
X-Gm-Message-State: AHYfb5igFo2ZkJsqaLGe5Qi/JfBywrIJTNgBLa0mIKj3jfgrDKg8BW14
        S2LAv0Nw6ulCBZQwGhcpoA==
X-Received: by 10.84.204.133 with SMTP id b5mr6967696ple.124.1502241802130;
        Tue, 08 Aug 2017 18:23:22 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:21 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 17/25] pack: move packed_object_info(), unpack_entry()
Date:   Tue,  8 Aug 2017 18:22:49 -0700
Message-Id: <204e94a451a5e9847a3d0c0e7fbdfbf17c9714a1.1502241234.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502241234.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1502241234.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both sha1_file.c and packfile.c now need read_object(), so a copy of
read_object() was created in packfile.c.

This patch makes both mark_bad_packed_object() and has_packed_and_bad()
global. Unlike most of the other patches in this series, these 2
functions need to remain global.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     |   7 -
 pack.h      |  11 +
 packfile.c  | 660 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sha1_file.c | 676 ++----------------------------------------------------------
 4 files changed, 685 insertions(+), 669 deletions(-)

diff --git a/cache.h b/cache.h
index 1ae3333a0..b14098bf1 100644
--- a/cache.h
+++ b/cache.h
@@ -1186,9 +1186,6 @@ extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
 extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
 
-/* global flag to enable extra checks when accessing packed objects */
-extern int do_check_packed_object_crc;
-
 extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
 extern int finalize_object_file(const char *tmpfile, const char *filename);
@@ -1621,8 +1618,6 @@ extern int odb_mkstemp(struct strbuf *template, const char *pattern);
  */
 extern int odb_pack_keep(const char *name);
 
-extern void clear_delta_base_cache(void);
-
 /*
  * Make sure that a pointer access into an mmap'd index file is within bounds,
  * and can provide at least 8 bytes of data.
@@ -1660,7 +1655,6 @@ extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
 extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
 
 extern int is_pack_valid(struct packed_git *);
-extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
 
 /*
  * Iterate over the files in the loose-object parts of the object
@@ -1771,7 +1765,6 @@ struct object_info {
 /* Do not retry packed storage after checking packed and loose storage */
 #define OBJECT_INFO_QUICK 8
 extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
-extern int packed_object_info(struct packed_git *pack, off_t offset, struct object_info *);
 
 /* Dumb servers support */
 extern int update_server_info(int);
diff --git a/pack.h b/pack.h
index 5e3552392..2e6f357c3 100644
--- a/pack.h
+++ b/pack.h
@@ -171,4 +171,15 @@ extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsig
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
 
+extern void clear_delta_base_cache(void);
+
+/* global flag to enable extra checks when accessing packed objects */
+extern int do_check_packed_object_crc;
+
+extern int packed_object_info(struct packed_git *pack, off_t offset, struct object_info *);
+extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
+
+extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
+extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
+
 #endif
diff --git a/packfile.c b/packfile.c
index a4db78ea0..a3745f9df 100644
--- a/packfile.c
+++ b/packfile.c
@@ -4,6 +4,8 @@
 #include "dir.h"
 #include "mergesort.h"
 #include "delta.h"
+#include "list.h"
+#include "streaming.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -974,3 +976,661 @@ int unpack_object_header(struct packed_git *p,
 
 	return type;
 }
+
+void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1)
+{
+	unsigned i;
+	for (i = 0; i < p->num_bad_objects; i++)
+		if (!hashcmp(sha1, p->bad_object_sha1 + GIT_SHA1_RAWSZ * i))
+			return;
+	p->bad_object_sha1 = xrealloc(p->bad_object_sha1,
+				      st_mult(GIT_MAX_RAWSZ,
+					      st_add(p->num_bad_objects, 1)));
+	hashcpy(p->bad_object_sha1 + GIT_SHA1_RAWSZ * p->num_bad_objects, sha1);
+	p->num_bad_objects++;
+}
+
+const struct packed_git *has_packed_and_bad(const unsigned char *sha1)
+{
+	struct packed_git *p;
+	unsigned i;
+
+	for (p = packed_git; p; p = p->next)
+		for (i = 0; i < p->num_bad_objects; i++)
+			if (!hashcmp(sha1, p->bad_object_sha1 + 20 * i))
+				return p;
+	return NULL;
+}
+
+static off_t get_delta_base(struct packed_git *p,
+				    struct pack_window **w_curs,
+				    off_t *curpos,
+				    enum object_type type,
+				    off_t delta_obj_offset)
+{
+	unsigned char *base_info = use_pack(p, w_curs, *curpos, NULL);
+	off_t base_offset;
+
+	/* use_pack() assured us we have [base_info, base_info + 20)
+	 * as a range that we can look at without walking off the
+	 * end of the mapped window.  Its actually the hash size
+	 * that is assured.  An OFS_DELTA longer than the hash size
+	 * is stupid, as then a REF_DELTA would be smaller to store.
+	 */
+	if (type == OBJ_OFS_DELTA) {
+		unsigned used = 0;
+		unsigned char c = base_info[used++];
+		base_offset = c & 127;
+		while (c & 128) {
+			base_offset += 1;
+			if (!base_offset || MSB(base_offset, 7))
+				return 0;  /* overflow */
+			c = base_info[used++];
+			base_offset = (base_offset << 7) + (c & 127);
+		}
+		base_offset = delta_obj_offset - base_offset;
+		if (base_offset <= 0 || base_offset >= delta_obj_offset)
+			return 0;  /* out of bound */
+		*curpos += used;
+	} else if (type == OBJ_REF_DELTA) {
+		/* The base entry _must_ be in the same pack */
+		base_offset = find_pack_entry_one(base_info, p);
+		*curpos += 20;
+	} else
+		die("I am totally screwed");
+	return base_offset;
+}
+
+/*
+ * Like get_delta_base above, but we return the sha1 instead of the pack
+ * offset. This means it is cheaper for REF deltas (we do not have to do
+ * the final object lookup), but more expensive for OFS deltas (we
+ * have to load the revidx to convert the offset back into a sha1).
+ */
+static const unsigned char *get_delta_base_sha1(struct packed_git *p,
+						struct pack_window **w_curs,
+						off_t curpos,
+						enum object_type type,
+						off_t delta_obj_offset)
+{
+	if (type == OBJ_REF_DELTA) {
+		unsigned char *base = use_pack(p, w_curs, curpos, NULL);
+		return base;
+	} else if (type == OBJ_OFS_DELTA) {
+		struct revindex_entry *revidx;
+		off_t base_offset = get_delta_base(p, w_curs, &curpos,
+						   type, delta_obj_offset);
+
+		if (!base_offset)
+			return NULL;
+
+		revidx = find_pack_revindex(p, base_offset);
+		if (!revidx)
+			return NULL;
+
+		return nth_packed_object_sha1(p, revidx->nr);
+	} else
+		return NULL;
+}
+
+static int retry_bad_packed_offset(struct packed_git *p, off_t obj_offset)
+{
+	int type;
+	struct revindex_entry *revidx;
+	const unsigned char *sha1;
+	revidx = find_pack_revindex(p, obj_offset);
+	if (!revidx)
+		return OBJ_BAD;
+	sha1 = nth_packed_object_sha1(p, revidx->nr);
+	mark_bad_packed_object(p, sha1);
+	type = sha1_object_info(sha1, NULL);
+	if (type <= OBJ_NONE)
+		return OBJ_BAD;
+	return type;
+}
+
+#define POI_STACK_PREALLOC 64
+
+static enum object_type packed_to_object_type(struct packed_git *p,
+					      off_t obj_offset,
+					      enum object_type type,
+					      struct pack_window **w_curs,
+					      off_t curpos)
+{
+	off_t small_poi_stack[POI_STACK_PREALLOC];
+	off_t *poi_stack = small_poi_stack;
+	int poi_stack_nr = 0, poi_stack_alloc = POI_STACK_PREALLOC;
+
+	while (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
+		off_t base_offset;
+		unsigned long size;
+		/* Push the object we're going to leave behind */
+		if (poi_stack_nr >= poi_stack_alloc && poi_stack == small_poi_stack) {
+			poi_stack_alloc = alloc_nr(poi_stack_nr);
+			ALLOC_ARRAY(poi_stack, poi_stack_alloc);
+			memcpy(poi_stack, small_poi_stack, sizeof(off_t)*poi_stack_nr);
+		} else {
+			ALLOC_GROW(poi_stack, poi_stack_nr+1, poi_stack_alloc);
+		}
+		poi_stack[poi_stack_nr++] = obj_offset;
+		/* If parsing the base offset fails, just unwind */
+		base_offset = get_delta_base(p, w_curs, &curpos, type, obj_offset);
+		if (!base_offset)
+			goto unwind;
+		curpos = obj_offset = base_offset;
+		type = unpack_object_header(p, w_curs, &curpos, &size);
+		if (type <= OBJ_NONE) {
+			/* If getting the base itself fails, we first
+			 * retry the base, otherwise unwind */
+			type = retry_bad_packed_offset(p, base_offset);
+			if (type > OBJ_NONE)
+				goto out;
+			goto unwind;
+		}
+	}
+
+	switch (type) {
+	case OBJ_BAD:
+	case OBJ_COMMIT:
+	case OBJ_TREE:
+	case OBJ_BLOB:
+	case OBJ_TAG:
+		break;
+	default:
+		error("unknown object type %i at offset %"PRIuMAX" in %s",
+		      type, (uintmax_t)obj_offset, p->pack_name);
+		type = OBJ_BAD;
+	}
+
+out:
+	if (poi_stack != small_poi_stack)
+		free(poi_stack);
+	return type;
+
+unwind:
+	while (poi_stack_nr) {
+		obj_offset = poi_stack[--poi_stack_nr];
+		type = retry_bad_packed_offset(p, obj_offset);
+		if (type > OBJ_NONE)
+			goto out;
+	}
+	type = OBJ_BAD;
+	goto out;
+}
+
+static struct hashmap delta_base_cache;
+static size_t delta_base_cached;
+
+static LIST_HEAD(delta_base_cache_lru);
+
+struct delta_base_cache_key {
+	struct packed_git *p;
+	off_t base_offset;
+};
+
+struct delta_base_cache_entry {
+	struct hashmap hash;
+	struct delta_base_cache_key key;
+	struct list_head lru;
+	void *data;
+	unsigned long size;
+	enum object_type type;
+};
+
+static unsigned int pack_entry_hash(struct packed_git *p, off_t base_offset)
+{
+	unsigned int hash;
+
+	hash = (unsigned int)(intptr_t)p + (unsigned int)base_offset;
+	hash += (hash >> 8) + (hash >> 16);
+	return hash;
+}
+
+static struct delta_base_cache_entry *
+get_delta_base_cache_entry(struct packed_git *p, off_t base_offset)
+{
+	struct hashmap_entry entry;
+	struct delta_base_cache_key key;
+
+	if (!delta_base_cache.cmpfn)
+		return NULL;
+
+	hashmap_entry_init(&entry, pack_entry_hash(p, base_offset));
+	key.p = p;
+	key.base_offset = base_offset;
+	return hashmap_get(&delta_base_cache, &entry, &key);
+}
+
+static int delta_base_cache_key_eq(const struct delta_base_cache_key *a,
+				   const struct delta_base_cache_key *b)
+{
+	return a->p == b->p && a->base_offset == b->base_offset;
+}
+
+static int delta_base_cache_hash_cmp(const void *unused_cmp_data,
+				     const void *va, const void *vb,
+				     const void *vkey)
+{
+	const struct delta_base_cache_entry *a = va, *b = vb;
+	const struct delta_base_cache_key *key = vkey;
+	if (key)
+		return !delta_base_cache_key_eq(&a->key, key);
+	else
+		return !delta_base_cache_key_eq(&a->key, &b->key);
+}
+
+static int in_delta_base_cache(struct packed_git *p, off_t base_offset)
+{
+	return !!get_delta_base_cache_entry(p, base_offset);
+}
+
+/*
+ * Remove the entry from the cache, but do _not_ free the associated
+ * entry data. The caller takes ownership of the "data" buffer, and
+ * should copy out any fields it wants before detaching.
+ */
+static void detach_delta_base_cache_entry(struct delta_base_cache_entry *ent)
+{
+	hashmap_remove(&delta_base_cache, ent, &ent->key);
+	list_del(&ent->lru);
+	delta_base_cached -= ent->size;
+	free(ent);
+}
+
+static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
+	unsigned long *base_size, enum object_type *type)
+{
+	struct delta_base_cache_entry *ent;
+
+	ent = get_delta_base_cache_entry(p, base_offset);
+	if (!ent)
+		return unpack_entry(p, base_offset, type, base_size);
+
+	if (type)
+		*type = ent->type;
+	if (base_size)
+		*base_size = ent->size;
+	return xmemdupz(ent->data, ent->size);
+}
+
+static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
+{
+	free(ent->data);
+	detach_delta_base_cache_entry(ent);
+}
+
+void clear_delta_base_cache(void)
+{
+	struct list_head *lru, *tmp;
+	list_for_each_safe(lru, tmp, &delta_base_cache_lru) {
+		struct delta_base_cache_entry *entry =
+			list_entry(lru, struct delta_base_cache_entry, lru);
+		release_delta_base_cache(entry);
+	}
+}
+
+static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
+	void *base, unsigned long base_size, enum object_type type)
+{
+	struct delta_base_cache_entry *ent = xmalloc(sizeof(*ent));
+	struct list_head *lru, *tmp;
+
+	delta_base_cached += base_size;
+
+	list_for_each_safe(lru, tmp, &delta_base_cache_lru) {
+		struct delta_base_cache_entry *f =
+			list_entry(lru, struct delta_base_cache_entry, lru);
+		if (delta_base_cached <= delta_base_cache_limit)
+			break;
+		release_delta_base_cache(f);
+	}
+
+	ent->key.p = p;
+	ent->key.base_offset = base_offset;
+	ent->type = type;
+	ent->data = base;
+	ent->size = base_size;
+	list_add_tail(&ent->lru, &delta_base_cache_lru);
+
+	if (!delta_base_cache.cmpfn)
+		hashmap_init(&delta_base_cache, delta_base_cache_hash_cmp, NULL, 0);
+	hashmap_entry_init(ent, pack_entry_hash(p, base_offset));
+	hashmap_add(&delta_base_cache, ent);
+}
+
+int packed_object_info(struct packed_git *p, off_t obj_offset,
+		       struct object_info *oi)
+{
+	struct pack_window *w_curs = NULL;
+	unsigned long size;
+	off_t curpos = obj_offset;
+	enum object_type type;
+
+	/*
+	 * We always get the representation type, but only convert it to
+	 * a "real" type later if the caller is interested.
+	 */
+	if (oi->contentp) {
+		*oi->contentp = cache_or_unpack_entry(p, obj_offset, oi->sizep,
+						      &type);
+		if (!*oi->contentp)
+			type = OBJ_BAD;
+	} else {
+		type = unpack_object_header(p, &w_curs, &curpos, &size);
+	}
+
+	if (!oi->contentp && oi->sizep) {
+		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
+			off_t tmp_pos = curpos;
+			off_t base_offset = get_delta_base(p, &w_curs, &tmp_pos,
+							   type, obj_offset);
+			if (!base_offset) {
+				type = OBJ_BAD;
+				goto out;
+			}
+			*oi->sizep = get_size_from_delta(p, &w_curs, tmp_pos);
+			if (*oi->sizep == 0) {
+				type = OBJ_BAD;
+				goto out;
+			}
+		} else {
+			*oi->sizep = size;
+		}
+	}
+
+	if (oi->disk_sizep) {
+		struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
+		*oi->disk_sizep = revidx[1].offset - obj_offset;
+	}
+
+	if (oi->typep || oi->typename) {
+		enum object_type ptot;
+		ptot = packed_to_object_type(p, obj_offset, type, &w_curs,
+					     curpos);
+		if (oi->typep)
+			*oi->typep = ptot;
+		if (oi->typename) {
+			const char *tn = typename(ptot);
+			if (tn)
+				strbuf_addstr(oi->typename, tn);
+		}
+		if (ptot < 0) {
+			type = OBJ_BAD;
+			goto out;
+		}
+	}
+
+	if (oi->delta_base_sha1) {
+		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
+			const unsigned char *base;
+
+			base = get_delta_base_sha1(p, &w_curs, curpos,
+						   type, obj_offset);
+			if (!base) {
+				type = OBJ_BAD;
+				goto out;
+			}
+
+			hashcpy(oi->delta_base_sha1, base);
+		} else
+			hashclr(oi->delta_base_sha1);
+	}
+
+	oi->whence = in_delta_base_cache(p, obj_offset) ? OI_DBCACHED :
+							  OI_PACKED;
+
+out:
+	unuse_pack(&w_curs);
+	return type;
+}
+
+static void *unpack_compressed_entry(struct packed_git *p,
+				    struct pack_window **w_curs,
+				    off_t curpos,
+				    unsigned long size)
+{
+	int st;
+	git_zstream stream;
+	unsigned char *buffer, *in;
+
+	buffer = xmallocz_gently(size);
+	if (!buffer)
+		return NULL;
+	memset(&stream, 0, sizeof(stream));
+	stream.next_out = buffer;
+	stream.avail_out = size + 1;
+
+	git_inflate_init(&stream);
+	do {
+		in = use_pack(p, w_curs, curpos, &stream.avail_in);
+		stream.next_in = in;
+		st = git_inflate(&stream, Z_FINISH);
+		if (!stream.avail_out)
+			break; /* the payload is larger than it should be */
+		curpos += stream.next_in - in;
+	} while (st == Z_OK || st == Z_BUF_ERROR);
+	git_inflate_end(&stream);
+	if ((st != Z_STREAM_END) || stream.total_out != size) {
+		free(buffer);
+		return NULL;
+	}
+
+	return buffer;
+}
+
+static void write_pack_access_log(struct packed_git *p, off_t obj_offset)
+{
+	static struct trace_key pack_access = TRACE_KEY_INIT(PACK_ACCESS);
+	trace_printf_key(&pack_access, "%s %"PRIuMAX"\n",
+			 p->pack_name, (uintmax_t)obj_offset);
+}
+
+int do_check_packed_object_crc;
+
+#define UNPACK_ENTRY_STACK_PREALLOC 64
+struct unpack_entry_stack_ent {
+	off_t obj_offset;
+	off_t curpos;
+	unsigned long size;
+};
+
+static void *read_object(const unsigned char *sha1, enum object_type *type,
+			 unsigned long *size)
+{
+	struct object_info oi = OBJECT_INFO_INIT;
+	void *content;
+	oi.typep = type;
+	oi.sizep = size;
+	oi.contentp = &content;
+
+	if (sha1_object_info_extended(sha1, &oi, 0) < 0)
+		return NULL;
+	return content;
+}
+
+void *unpack_entry(struct packed_git *p, off_t obj_offset,
+		   enum object_type *final_type, unsigned long *final_size)
+{
+	struct pack_window *w_curs = NULL;
+	off_t curpos = obj_offset;
+	void *data = NULL;
+	unsigned long size;
+	enum object_type type;
+	struct unpack_entry_stack_ent small_delta_stack[UNPACK_ENTRY_STACK_PREALLOC];
+	struct unpack_entry_stack_ent *delta_stack = small_delta_stack;
+	int delta_stack_nr = 0, delta_stack_alloc = UNPACK_ENTRY_STACK_PREALLOC;
+	int base_from_cache = 0;
+
+	write_pack_access_log(p, obj_offset);
+
+	/* PHASE 1: drill down to the innermost base object */
+	for (;;) {
+		off_t base_offset;
+		int i;
+		struct delta_base_cache_entry *ent;
+
+		ent = get_delta_base_cache_entry(p, curpos);
+		if (ent) {
+			type = ent->type;
+			data = ent->data;
+			size = ent->size;
+			detach_delta_base_cache_entry(ent);
+			base_from_cache = 1;
+			break;
+		}
+
+		if (do_check_packed_object_crc && p->index_version > 1) {
+			struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
+			off_t len = revidx[1].offset - obj_offset;
+			if (check_pack_crc(p, &w_curs, obj_offset, len, revidx->nr)) {
+				const unsigned char *sha1 =
+					nth_packed_object_sha1(p, revidx->nr);
+				error("bad packed object CRC for %s",
+				      sha1_to_hex(sha1));
+				mark_bad_packed_object(p, sha1);
+				unuse_pack(&w_curs);
+				return NULL;
+			}
+		}
+
+		type = unpack_object_header(p, &w_curs, &curpos, &size);
+		if (type != OBJ_OFS_DELTA && type != OBJ_REF_DELTA)
+			break;
+
+		base_offset = get_delta_base(p, &w_curs, &curpos, type, obj_offset);
+		if (!base_offset) {
+			error("failed to validate delta base reference "
+			      "at offset %"PRIuMAX" from %s",
+			      (uintmax_t)curpos, p->pack_name);
+			/* bail to phase 2, in hopes of recovery */
+			data = NULL;
+			break;
+		}
+
+		/* push object, proceed to base */
+		if (delta_stack_nr >= delta_stack_alloc
+		    && delta_stack == small_delta_stack) {
+			delta_stack_alloc = alloc_nr(delta_stack_nr);
+			ALLOC_ARRAY(delta_stack, delta_stack_alloc);
+			memcpy(delta_stack, small_delta_stack,
+			       sizeof(*delta_stack)*delta_stack_nr);
+		} else {
+			ALLOC_GROW(delta_stack, delta_stack_nr+1, delta_stack_alloc);
+		}
+		i = delta_stack_nr++;
+		delta_stack[i].obj_offset = obj_offset;
+		delta_stack[i].curpos = curpos;
+		delta_stack[i].size = size;
+
+		curpos = obj_offset = base_offset;
+	}
+
+	/* PHASE 2: handle the base */
+	switch (type) {
+	case OBJ_OFS_DELTA:
+	case OBJ_REF_DELTA:
+		if (data)
+			die("BUG: unpack_entry: left loop at a valid delta");
+		break;
+	case OBJ_COMMIT:
+	case OBJ_TREE:
+	case OBJ_BLOB:
+	case OBJ_TAG:
+		if (!base_from_cache)
+			data = unpack_compressed_entry(p, &w_curs, curpos, size);
+		break;
+	default:
+		data = NULL;
+		error("unknown object type %i at offset %"PRIuMAX" in %s",
+		      type, (uintmax_t)obj_offset, p->pack_name);
+	}
+
+	/* PHASE 3: apply deltas in order */
+
+	/* invariants:
+	 *   'data' holds the base data, or NULL if there was corruption
+	 */
+	while (delta_stack_nr) {
+		void *delta_data;
+		void *base = data;
+		void *external_base = NULL;
+		unsigned long delta_size, base_size = size;
+		int i;
+
+		data = NULL;
+
+		if (base)
+			add_delta_base_cache(p, obj_offset, base, base_size, type);
+
+		if (!base) {
+			/*
+			 * We're probably in deep shit, but let's try to fetch
+			 * the required base anyway from another pack or loose.
+			 * This is costly but should happen only in the presence
+			 * of a corrupted pack, and is better than failing outright.
+			 */
+			struct revindex_entry *revidx;
+			const unsigned char *base_sha1;
+			revidx = find_pack_revindex(p, obj_offset);
+			if (revidx) {
+				base_sha1 = nth_packed_object_sha1(p, revidx->nr);
+				error("failed to read delta base object %s"
+				      " at offset %"PRIuMAX" from %s",
+				      sha1_to_hex(base_sha1), (uintmax_t)obj_offset,
+				      p->pack_name);
+				mark_bad_packed_object(p, base_sha1);
+				base = read_object(base_sha1, &type, &base_size);
+				external_base = base;
+			}
+		}
+
+		i = --delta_stack_nr;
+		obj_offset = delta_stack[i].obj_offset;
+		curpos = delta_stack[i].curpos;
+		delta_size = delta_stack[i].size;
+
+		if (!base)
+			continue;
+
+		delta_data = unpack_compressed_entry(p, &w_curs, curpos, delta_size);
+
+		if (!delta_data) {
+			error("failed to unpack compressed delta "
+			      "at offset %"PRIuMAX" from %s",
+			      (uintmax_t)curpos, p->pack_name);
+			data = NULL;
+			free(external_base);
+			continue;
+		}
+
+		data = patch_delta(base, base_size,
+				   delta_data, delta_size,
+				   &size);
+
+		/*
+		 * We could not apply the delta; warn the user, but keep going.
+		 * Our failure will be noticed either in the next iteration of
+		 * the loop, or if this is the final delta, in the caller when
+		 * we return NULL. Those code paths will take care of making
+		 * a more explicit warning and retrying with another copy of
+		 * the object.
+		 */
+		if (!data)
+			error("failed to apply delta");
+
+		free(delta_data);
+		free(external_base);
+	}
+
+	if (final_type)
+		*final_type = type;
+	if (final_size)
+		*final_size = size;
+
+	unuse_pack(&w_curs);
+
+	if (delta_stack != small_delta_stack)
+		free(delta_stack);
+
+	return data;
+}
diff --git a/sha1_file.c b/sha1_file.c
index 9e5444334..fe7e0db76 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -717,32 +717,6 @@ void *xmmap(void *start, size_t length,
 	return ret;
 }
 
-static void mark_bad_packed_object(struct packed_git *p,
-				   const unsigned char *sha1)
-{
-	unsigned i;
-	for (i = 0; i < p->num_bad_objects; i++)
-		if (!hashcmp(sha1, p->bad_object_sha1 + GIT_SHA1_RAWSZ * i))
-			return;
-	p->bad_object_sha1 = xrealloc(p->bad_object_sha1,
-				      st_mult(GIT_MAX_RAWSZ,
-					      st_add(p->num_bad_objects, 1)));
-	hashcpy(p->bad_object_sha1 + GIT_SHA1_RAWSZ * p->num_bad_objects, sha1);
-	p->num_bad_objects++;
-}
-
-static const struct packed_git *has_packed_and_bad(const unsigned char *sha1)
-{
-	struct packed_git *p;
-	unsigned i;
-
-	for (p = packed_git; p; p = p->next)
-		for (i = 0; i < p->num_bad_objects; i++)
-			if (!hashcmp(sha1, p->bad_object_sha1 + 20 * i))
-				return p;
-	return NULL;
-}
-
 /*
  * With an in-core object data in "map", rehash it to make sure the
  * object name actually matches "sha1" to detect object corruption.
@@ -1099,628 +1073,6 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
-static off_t get_delta_base(struct packed_git *p,
-				    struct pack_window **w_curs,
-				    off_t *curpos,
-				    enum object_type type,
-				    off_t delta_obj_offset)
-{
-	unsigned char *base_info = use_pack(p, w_curs, *curpos, NULL);
-	off_t base_offset;
-
-	/* use_pack() assured us we have [base_info, base_info + 20)
-	 * as a range that we can look at without walking off the
-	 * end of the mapped window.  Its actually the hash size
-	 * that is assured.  An OFS_DELTA longer than the hash size
-	 * is stupid, as then a REF_DELTA would be smaller to store.
-	 */
-	if (type == OBJ_OFS_DELTA) {
-		unsigned used = 0;
-		unsigned char c = base_info[used++];
-		base_offset = c & 127;
-		while (c & 128) {
-			base_offset += 1;
-			if (!base_offset || MSB(base_offset, 7))
-				return 0;  /* overflow */
-			c = base_info[used++];
-			base_offset = (base_offset << 7) + (c & 127);
-		}
-		base_offset = delta_obj_offset - base_offset;
-		if (base_offset <= 0 || base_offset >= delta_obj_offset)
-			return 0;  /* out of bound */
-		*curpos += used;
-	} else if (type == OBJ_REF_DELTA) {
-		/* The base entry _must_ be in the same pack */
-		base_offset = find_pack_entry_one(base_info, p);
-		*curpos += 20;
-	} else
-		die("I am totally screwed");
-	return base_offset;
-}
-
-/*
- * Like get_delta_base above, but we return the sha1 instead of the pack
- * offset. This means it is cheaper for REF deltas (we do not have to do
- * the final object lookup), but more expensive for OFS deltas (we
- * have to load the revidx to convert the offset back into a sha1).
- */
-static const unsigned char *get_delta_base_sha1(struct packed_git *p,
-						struct pack_window **w_curs,
-						off_t curpos,
-						enum object_type type,
-						off_t delta_obj_offset)
-{
-	if (type == OBJ_REF_DELTA) {
-		unsigned char *base = use_pack(p, w_curs, curpos, NULL);
-		return base;
-	} else if (type == OBJ_OFS_DELTA) {
-		struct revindex_entry *revidx;
-		off_t base_offset = get_delta_base(p, w_curs, &curpos,
-						   type, delta_obj_offset);
-
-		if (!base_offset)
-			return NULL;
-
-		revidx = find_pack_revindex(p, base_offset);
-		if (!revidx)
-			return NULL;
-
-		return nth_packed_object_sha1(p, revidx->nr);
-	} else
-		return NULL;
-}
-
-static int retry_bad_packed_offset(struct packed_git *p, off_t obj_offset)
-{
-	int type;
-	struct revindex_entry *revidx;
-	const unsigned char *sha1;
-	revidx = find_pack_revindex(p, obj_offset);
-	if (!revidx)
-		return OBJ_BAD;
-	sha1 = nth_packed_object_sha1(p, revidx->nr);
-	mark_bad_packed_object(p, sha1);
-	type = sha1_object_info(sha1, NULL);
-	if (type <= OBJ_NONE)
-		return OBJ_BAD;
-	return type;
-}
-
-#define POI_STACK_PREALLOC 64
-
-static enum object_type packed_to_object_type(struct packed_git *p,
-					      off_t obj_offset,
-					      enum object_type type,
-					      struct pack_window **w_curs,
-					      off_t curpos)
-{
-	off_t small_poi_stack[POI_STACK_PREALLOC];
-	off_t *poi_stack = small_poi_stack;
-	int poi_stack_nr = 0, poi_stack_alloc = POI_STACK_PREALLOC;
-
-	while (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
-		off_t base_offset;
-		unsigned long size;
-		/* Push the object we're going to leave behind */
-		if (poi_stack_nr >= poi_stack_alloc && poi_stack == small_poi_stack) {
-			poi_stack_alloc = alloc_nr(poi_stack_nr);
-			ALLOC_ARRAY(poi_stack, poi_stack_alloc);
-			memcpy(poi_stack, small_poi_stack, sizeof(off_t)*poi_stack_nr);
-		} else {
-			ALLOC_GROW(poi_stack, poi_stack_nr+1, poi_stack_alloc);
-		}
-		poi_stack[poi_stack_nr++] = obj_offset;
-		/* If parsing the base offset fails, just unwind */
-		base_offset = get_delta_base(p, w_curs, &curpos, type, obj_offset);
-		if (!base_offset)
-			goto unwind;
-		curpos = obj_offset = base_offset;
-		type = unpack_object_header(p, w_curs, &curpos, &size);
-		if (type <= OBJ_NONE) {
-			/* If getting the base itself fails, we first
-			 * retry the base, otherwise unwind */
-			type = retry_bad_packed_offset(p, base_offset);
-			if (type > OBJ_NONE)
-				goto out;
-			goto unwind;
-		}
-	}
-
-	switch (type) {
-	case OBJ_BAD:
-	case OBJ_COMMIT:
-	case OBJ_TREE:
-	case OBJ_BLOB:
-	case OBJ_TAG:
-		break;
-	default:
-		error("unknown object type %i at offset %"PRIuMAX" in %s",
-		      type, (uintmax_t)obj_offset, p->pack_name);
-		type = OBJ_BAD;
-	}
-
-out:
-	if (poi_stack != small_poi_stack)
-		free(poi_stack);
-	return type;
-
-unwind:
-	while (poi_stack_nr) {
-		obj_offset = poi_stack[--poi_stack_nr];
-		type = retry_bad_packed_offset(p, obj_offset);
-		if (type > OBJ_NONE)
-			goto out;
-	}
-	type = OBJ_BAD;
-	goto out;
-}
-
-static struct hashmap delta_base_cache;
-static size_t delta_base_cached;
-
-static LIST_HEAD(delta_base_cache_lru);
-
-struct delta_base_cache_key {
-	struct packed_git *p;
-	off_t base_offset;
-};
-
-struct delta_base_cache_entry {
-	struct hashmap hash;
-	struct delta_base_cache_key key;
-	struct list_head lru;
-	void *data;
-	unsigned long size;
-	enum object_type type;
-};
-
-static unsigned int pack_entry_hash(struct packed_git *p, off_t base_offset)
-{
-	unsigned int hash;
-
-	hash = (unsigned int)(intptr_t)p + (unsigned int)base_offset;
-	hash += (hash >> 8) + (hash >> 16);
-	return hash;
-}
-
-static struct delta_base_cache_entry *
-get_delta_base_cache_entry(struct packed_git *p, off_t base_offset)
-{
-	struct hashmap_entry entry;
-	struct delta_base_cache_key key;
-
-	if (!delta_base_cache.cmpfn)
-		return NULL;
-
-	hashmap_entry_init(&entry, pack_entry_hash(p, base_offset));
-	key.p = p;
-	key.base_offset = base_offset;
-	return hashmap_get(&delta_base_cache, &entry, &key);
-}
-
-static int delta_base_cache_key_eq(const struct delta_base_cache_key *a,
-				   const struct delta_base_cache_key *b)
-{
-	return a->p == b->p && a->base_offset == b->base_offset;
-}
-
-static int delta_base_cache_hash_cmp(const void *unused_cmp_data,
-				     const void *va, const void *vb,
-				     const void *vkey)
-{
-	const struct delta_base_cache_entry *a = va, *b = vb;
-	const struct delta_base_cache_key *key = vkey;
-	if (key)
-		return !delta_base_cache_key_eq(&a->key, key);
-	else
-		return !delta_base_cache_key_eq(&a->key, &b->key);
-}
-
-static int in_delta_base_cache(struct packed_git *p, off_t base_offset)
-{
-	return !!get_delta_base_cache_entry(p, base_offset);
-}
-
-/*
- * Remove the entry from the cache, but do _not_ free the associated
- * entry data. The caller takes ownership of the "data" buffer, and
- * should copy out any fields it wants before detaching.
- */
-static void detach_delta_base_cache_entry(struct delta_base_cache_entry *ent)
-{
-	hashmap_remove(&delta_base_cache, ent, &ent->key);
-	list_del(&ent->lru);
-	delta_base_cached -= ent->size;
-	free(ent);
-}
-
-static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
-	unsigned long *base_size, enum object_type *type)
-{
-	struct delta_base_cache_entry *ent;
-
-	ent = get_delta_base_cache_entry(p, base_offset);
-	if (!ent)
-		return unpack_entry(p, base_offset, type, base_size);
-
-	if (type)
-		*type = ent->type;
-	if (base_size)
-		*base_size = ent->size;
-	return xmemdupz(ent->data, ent->size);
-}
-
-static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
-{
-	free(ent->data);
-	detach_delta_base_cache_entry(ent);
-}
-
-void clear_delta_base_cache(void)
-{
-	struct list_head *lru, *tmp;
-	list_for_each_safe(lru, tmp, &delta_base_cache_lru) {
-		struct delta_base_cache_entry *entry =
-			list_entry(lru, struct delta_base_cache_entry, lru);
-		release_delta_base_cache(entry);
-	}
-}
-
-static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
-	void *base, unsigned long base_size, enum object_type type)
-{
-	struct delta_base_cache_entry *ent = xmalloc(sizeof(*ent));
-	struct list_head *lru, *tmp;
-
-	delta_base_cached += base_size;
-
-	list_for_each_safe(lru, tmp, &delta_base_cache_lru) {
-		struct delta_base_cache_entry *f =
-			list_entry(lru, struct delta_base_cache_entry, lru);
-		if (delta_base_cached <= delta_base_cache_limit)
-			break;
-		release_delta_base_cache(f);
-	}
-
-	ent->key.p = p;
-	ent->key.base_offset = base_offset;
-	ent->type = type;
-	ent->data = base;
-	ent->size = base_size;
-	list_add_tail(&ent->lru, &delta_base_cache_lru);
-
-	if (!delta_base_cache.cmpfn)
-		hashmap_init(&delta_base_cache, delta_base_cache_hash_cmp, NULL, 0);
-	hashmap_entry_init(ent, pack_entry_hash(p, base_offset));
-	hashmap_add(&delta_base_cache, ent);
-}
-
-int packed_object_info(struct packed_git *p, off_t obj_offset,
-		       struct object_info *oi)
-{
-	struct pack_window *w_curs = NULL;
-	unsigned long size;
-	off_t curpos = obj_offset;
-	enum object_type type;
-
-	/*
-	 * We always get the representation type, but only convert it to
-	 * a "real" type later if the caller is interested.
-	 */
-	if (oi->contentp) {
-		*oi->contentp = cache_or_unpack_entry(p, obj_offset, oi->sizep,
-						      &type);
-		if (!*oi->contentp)
-			type = OBJ_BAD;
-	} else {
-		type = unpack_object_header(p, &w_curs, &curpos, &size);
-	}
-
-	if (!oi->contentp && oi->sizep) {
-		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
-			off_t tmp_pos = curpos;
-			off_t base_offset = get_delta_base(p, &w_curs, &tmp_pos,
-							   type, obj_offset);
-			if (!base_offset) {
-				type = OBJ_BAD;
-				goto out;
-			}
-			*oi->sizep = get_size_from_delta(p, &w_curs, tmp_pos);
-			if (*oi->sizep == 0) {
-				type = OBJ_BAD;
-				goto out;
-			}
-		} else {
-			*oi->sizep = size;
-		}
-	}
-
-	if (oi->disk_sizep) {
-		struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
-		*oi->disk_sizep = revidx[1].offset - obj_offset;
-	}
-
-	if (oi->typep || oi->typename) {
-		enum object_type ptot;
-		ptot = packed_to_object_type(p, obj_offset, type, &w_curs,
-					     curpos);
-		if (oi->typep)
-			*oi->typep = ptot;
-		if (oi->typename) {
-			const char *tn = typename(ptot);
-			if (tn)
-				strbuf_addstr(oi->typename, tn);
-		}
-		if (ptot < 0) {
-			type = OBJ_BAD;
-			goto out;
-		}
-	}
-
-	if (oi->delta_base_sha1) {
-		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
-			const unsigned char *base;
-
-			base = get_delta_base_sha1(p, &w_curs, curpos,
-						   type, obj_offset);
-			if (!base) {
-				type = OBJ_BAD;
-				goto out;
-			}
-
-			hashcpy(oi->delta_base_sha1, base);
-		} else
-			hashclr(oi->delta_base_sha1);
-	}
-
-	oi->whence = in_delta_base_cache(p, obj_offset) ? OI_DBCACHED :
-							  OI_PACKED;
-
-out:
-	unuse_pack(&w_curs);
-	return type;
-}
-
-static void *unpack_compressed_entry(struct packed_git *p,
-				    struct pack_window **w_curs,
-				    off_t curpos,
-				    unsigned long size)
-{
-	int st;
-	git_zstream stream;
-	unsigned char *buffer, *in;
-
-	buffer = xmallocz_gently(size);
-	if (!buffer)
-		return NULL;
-	memset(&stream, 0, sizeof(stream));
-	stream.next_out = buffer;
-	stream.avail_out = size + 1;
-
-	git_inflate_init(&stream);
-	do {
-		in = use_pack(p, w_curs, curpos, &stream.avail_in);
-		stream.next_in = in;
-		st = git_inflate(&stream, Z_FINISH);
-		if (!stream.avail_out)
-			break; /* the payload is larger than it should be */
-		curpos += stream.next_in - in;
-	} while (st == Z_OK || st == Z_BUF_ERROR);
-	git_inflate_end(&stream);
-	if ((st != Z_STREAM_END) || stream.total_out != size) {
-		free(buffer);
-		return NULL;
-	}
-
-	return buffer;
-}
-
-static void *read_object(const unsigned char *sha1, enum object_type *type,
-			 unsigned long *size);
-
-static void write_pack_access_log(struct packed_git *p, off_t obj_offset)
-{
-	static struct trace_key pack_access = TRACE_KEY_INIT(PACK_ACCESS);
-	trace_printf_key(&pack_access, "%s %"PRIuMAX"\n",
-			 p->pack_name, (uintmax_t)obj_offset);
-}
-
-int do_check_packed_object_crc;
-
-#define UNPACK_ENTRY_STACK_PREALLOC 64
-struct unpack_entry_stack_ent {
-	off_t obj_offset;
-	off_t curpos;
-	unsigned long size;
-};
-
-void *unpack_entry(struct packed_git *p, off_t obj_offset,
-		   enum object_type *final_type, unsigned long *final_size)
-{
-	struct pack_window *w_curs = NULL;
-	off_t curpos = obj_offset;
-	void *data = NULL;
-	unsigned long size;
-	enum object_type type;
-	struct unpack_entry_stack_ent small_delta_stack[UNPACK_ENTRY_STACK_PREALLOC];
-	struct unpack_entry_stack_ent *delta_stack = small_delta_stack;
-	int delta_stack_nr = 0, delta_stack_alloc = UNPACK_ENTRY_STACK_PREALLOC;
-	int base_from_cache = 0;
-
-	write_pack_access_log(p, obj_offset);
-
-	/* PHASE 1: drill down to the innermost base object */
-	for (;;) {
-		off_t base_offset;
-		int i;
-		struct delta_base_cache_entry *ent;
-
-		ent = get_delta_base_cache_entry(p, curpos);
-		if (ent) {
-			type = ent->type;
-			data = ent->data;
-			size = ent->size;
-			detach_delta_base_cache_entry(ent);
-			base_from_cache = 1;
-			break;
-		}
-
-		if (do_check_packed_object_crc && p->index_version > 1) {
-			struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
-			off_t len = revidx[1].offset - obj_offset;
-			if (check_pack_crc(p, &w_curs, obj_offset, len, revidx->nr)) {
-				const unsigned char *sha1 =
-					nth_packed_object_sha1(p, revidx->nr);
-				error("bad packed object CRC for %s",
-				      sha1_to_hex(sha1));
-				mark_bad_packed_object(p, sha1);
-				unuse_pack(&w_curs);
-				return NULL;
-			}
-		}
-
-		type = unpack_object_header(p, &w_curs, &curpos, &size);
-		if (type != OBJ_OFS_DELTA && type != OBJ_REF_DELTA)
-			break;
-
-		base_offset = get_delta_base(p, &w_curs, &curpos, type, obj_offset);
-		if (!base_offset) {
-			error("failed to validate delta base reference "
-			      "at offset %"PRIuMAX" from %s",
-			      (uintmax_t)curpos, p->pack_name);
-			/* bail to phase 2, in hopes of recovery */
-			data = NULL;
-			break;
-		}
-
-		/* push object, proceed to base */
-		if (delta_stack_nr >= delta_stack_alloc
-		    && delta_stack == small_delta_stack) {
-			delta_stack_alloc = alloc_nr(delta_stack_nr);
-			ALLOC_ARRAY(delta_stack, delta_stack_alloc);
-			memcpy(delta_stack, small_delta_stack,
-			       sizeof(*delta_stack)*delta_stack_nr);
-		} else {
-			ALLOC_GROW(delta_stack, delta_stack_nr+1, delta_stack_alloc);
-		}
-		i = delta_stack_nr++;
-		delta_stack[i].obj_offset = obj_offset;
-		delta_stack[i].curpos = curpos;
-		delta_stack[i].size = size;
-
-		curpos = obj_offset = base_offset;
-	}
-
-	/* PHASE 2: handle the base */
-	switch (type) {
-	case OBJ_OFS_DELTA:
-	case OBJ_REF_DELTA:
-		if (data)
-			die("BUG: unpack_entry: left loop at a valid delta");
-		break;
-	case OBJ_COMMIT:
-	case OBJ_TREE:
-	case OBJ_BLOB:
-	case OBJ_TAG:
-		if (!base_from_cache)
-			data = unpack_compressed_entry(p, &w_curs, curpos, size);
-		break;
-	default:
-		data = NULL;
-		error("unknown object type %i at offset %"PRIuMAX" in %s",
-		      type, (uintmax_t)obj_offset, p->pack_name);
-	}
-
-	/* PHASE 3: apply deltas in order */
-
-	/* invariants:
-	 *   'data' holds the base data, or NULL if there was corruption
-	 */
-	while (delta_stack_nr) {
-		void *delta_data;
-		void *base = data;
-		void *external_base = NULL;
-		unsigned long delta_size, base_size = size;
-		int i;
-
-		data = NULL;
-
-		if (base)
-			add_delta_base_cache(p, obj_offset, base, base_size, type);
-
-		if (!base) {
-			/*
-			 * We're probably in deep shit, but let's try to fetch
-			 * the required base anyway from another pack or loose.
-			 * This is costly but should happen only in the presence
-			 * of a corrupted pack, and is better than failing outright.
-			 */
-			struct revindex_entry *revidx;
-			const unsigned char *base_sha1;
-			revidx = find_pack_revindex(p, obj_offset);
-			if (revidx) {
-				base_sha1 = nth_packed_object_sha1(p, revidx->nr);
-				error("failed to read delta base object %s"
-				      " at offset %"PRIuMAX" from %s",
-				      sha1_to_hex(base_sha1), (uintmax_t)obj_offset,
-				      p->pack_name);
-				mark_bad_packed_object(p, base_sha1);
-				base = read_object(base_sha1, &type, &base_size);
-				external_base = base;
-			}
-		}
-
-		i = --delta_stack_nr;
-		obj_offset = delta_stack[i].obj_offset;
-		curpos = delta_stack[i].curpos;
-		delta_size = delta_stack[i].size;
-
-		if (!base)
-			continue;
-
-		delta_data = unpack_compressed_entry(p, &w_curs, curpos, delta_size);
-
-		if (!delta_data) {
-			error("failed to unpack compressed delta "
-			      "at offset %"PRIuMAX" from %s",
-			      (uintmax_t)curpos, p->pack_name);
-			data = NULL;
-			free(external_base);
-			continue;
-		}
-
-		data = patch_delta(base, base_size,
-				   delta_data, delta_size,
-				   &size);
-
-		/*
-		 * We could not apply the delta; warn the user, but keep going.
-		 * Our failure will be noticed either in the next iteration of
-		 * the loop, or if this is the final delta, in the caller when
-		 * we return NULL. Those code paths will take care of making
-		 * a more explicit warning and retrying with another copy of
-		 * the object.
-		 */
-		if (!data)
-			error("failed to apply delta");
-
-		free(delta_data);
-		free(external_base);
-	}
-
-	if (final_type)
-		*final_type = type;
-	if (final_size)
-		*final_size = size;
-
-	unuse_pack(&w_curs);
-
-	if (delta_stack != small_delta_stack)
-		free(delta_stack);
-
-	return data;
-}
-
 const unsigned char *nth_packed_object_sha1(struct packed_git *p,
 					    uint32_t n)
 {
@@ -2091,6 +1443,20 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 	return type;
 }
 
+static void *read_object(const unsigned char *sha1, enum object_type *type,
+			 unsigned long *size)
+{
+	struct object_info oi = OBJECT_INFO_INIT;
+	void *content;
+	oi.typep = type;
+	oi.sizep = size;
+	oi.contentp = &content;
+
+	if (sha1_object_info_extended(sha1, &oi, 0) < 0)
+		return NULL;
+	return content;
+}
+
 int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 		      unsigned char *sha1)
 {
@@ -2109,20 +1475,6 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 	return 0;
 }
 
-static void *read_object(const unsigned char *sha1, enum object_type *type,
-			 unsigned long *size)
-{
-	struct object_info oi = OBJECT_INFO_INIT;
-	void *content;
-	oi.typep = type;
-	oi.sizep = size;
-	oi.contentp = &content;
-
-	if (sha1_object_info_extended(sha1, &oi, 0) < 0)
-		return NULL;
-	return content;
-}
-
 /*
  * This function dies on corrupt objects; the callers who want to
  * deal with them should arrange to call read_object() and give error
-- 
2.14.0.434.g98096fd7a8-goog


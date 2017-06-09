Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E941F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 19:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbdFITXt (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 15:23:49 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34298 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdFITXs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 15:23:48 -0400
Received: by mail-pf0-f181.google.com with SMTP id 15so3914138pfc.1
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 12:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=KHjrkTfS54X01KcX5K3iaEVs8XevKvW2I93Q8nCtzmE=;
        b=aitNA34qscuAP7z8eVuCaKnRpdA2mq9451lsw6l95NkszDYOcQOKelhyPojRmLTJoL
         W8mIErdXinvonPeUiKACVVFGDNBtjSBpGoTEY2EYom5hGf2dWax9+T/KpTXrDTNgFaQy
         pI+yL/K31BRk/EnFYFN/qkuFy6EBLpABBSVwwIF8XgewQZYTHDoUeVNlNYzEZjpOE4DR
         t5uIyn+RzCEBANSHnnEuh5aKR0w6W+amSwSwB0mxeErd4jaegEaDoEE/qKovAQffbgyy
         1TCVz8R21Vu7dvU0caUNn1HJ2X3JfnRULIyJDeTiIb1q4xS5EE/TRmMdoWClQUevaYox
         scyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=KHjrkTfS54X01KcX5K3iaEVs8XevKvW2I93Q8nCtzmE=;
        b=EUZ8FITy6+r/ZuvuohL+YnnG+HDuMFKK+OXafMwmz7Ts2AiwteRMFuZaK2b7fEfrr1
         6CQWQrVdov4DoF9s0PJrhYeezcqeE0RNJHoF5b3JykBM8pkYF8fAOJ3LLAqCyS9MpoyZ
         wEkC9hdPgwObUUHaF+21yPLS2lA3yNTbcmYD+tfwQTHQzlcVyLdAQQ74RmM3VuS5iCOb
         82Xq69b20I8Q2AlGC30o7VWdrLS2fBA8p4o267+LmpATvYl8xhI8yk39Hi20eNup3cW4
         jVkF0UP0olvWJDeA3oW5/fnBsY+sSSmp7N/vguQftv+Fh1ObL0ThVivxHxbKWmFKTH/b
         0aSQ==
X-Gm-Message-State: AODbwcDzXPgAGtu+TTwmbqkGsbXxzaGb+K3zNGFsv8fQkyMOuf9O3AR6
        uV5R1De45ZEBq9hoHAAhwQ==
X-Received: by 10.84.137.3 with SMTP id 3mr41905264plm.68.1497036216819;
        Fri, 09 Jun 2017 12:23:36 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id f72sm5757924pfe.4.2017.06.09.12.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 12:23:35 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH 3/4] sha1_file: consolidate storage-agnostic object fns
Date:   Fri,  9 Jun 2017 12:23:25 -0700
Message-Id: <7a361745f52ecebd9595862ee0a857b1ea28b316.1497035376.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <cover.1497035376.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com>
In-Reply-To: <cover.1497035376.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is patch 2 of 2 to consolidate all storage-agnostic object
information functions.

In sha1_file.c, there are a few functions that provide information on an
object regardless of its storage (cached, loose, or packed). Looking
through all non-static functions in sha1_file.c that take in an unsigned
char * pointer, the relevant ones are:
 - sha1_object_info_extended
 - sha1_object_info (auto-fixed by sha1_object_info_extended)
 - read_sha1_file_extended (uses read_object)
 - read_object_with_reference (auto-fixed by read_sha1_file_extended)
 - has_sha1_file_with_flags
 - assert_sha1_type (auto-fixed by sha1_object_info)

Looking at the 3 primary functions (sha1_object_info_extended,
read_object, has_sha1_file_with_flags), they independently implement
mechanisms such as object replacement, retrying the packed store after
failing to find the object in the packed store then the loose store, and
being able to mark a packed object as bad and then retrying the whole
process. Consolidating these mechanisms would be a great help to
maintainability.

Therefore, consolidate all 3 functions into 1 function.

Note that has_sha1_file_with_flags() does not try cached storage,
whereas the other 2 functions do - this functionality is preserved.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 sha1_file.c | 294 ++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 165 insertions(+), 129 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index ac4d77ccc..deb08b0f1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1959,7 +1959,7 @@ static int parse_sha1_header_extended(const char *hdr, enum object_type *typep,
 	}
 
 	type = type_from_string_gently(type_buf, type_len, 1);
-	if (oi->typename)
+	if (oi && oi->typename)
 		strbuf_add(oi->typename, type_buf, type_len);
 	/*
 	 * Set type to 0 if its an unknown object and
@@ -2001,12 +2001,13 @@ static int parse_sha1_header_extended(const char *hdr, enum object_type *typep,
 
 int parse_sha1_header(const char *hdr, unsigned long *sizep)
 {
-	struct object_info oi = OBJECT_INFO_INIT;
-	return parse_sha1_header_extended(hdr, NULL, sizep, &oi,
+	return parse_sha1_header_extended(hdr, NULL, sizep, NULL,
 					  LOOKUP_REPLACE_OBJECT);
 }
 
-static void *unpack_sha1_file(void *map, unsigned long mapsize, enum object_type *type, unsigned long *size, const unsigned char *sha1)
+static void *unpack_sha1_file(void *map, unsigned long mapsize,
+			      enum object_type *type, unsigned long *size,
+			      const unsigned char *sha1)
 {
 	int ret;
 	git_zstream stream;
@@ -2274,18 +2275,18 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 		}
 	}
 
-	if (oi->disk_sizep) {
+	if (oi && oi->disk_sizep) {
 		struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
 		*oi->disk_sizep = revidx[1].offset - obj_offset;
 	}
 
-	if (typep || oi->typename) {
+	if (typep || (oi && oi->typename)) {
 		enum object_type ptot;
 		ptot = packed_to_object_type(p, obj_offset, type, &w_curs,
 					     curpos);
 		if (typep)
 			*typep = ptot;
-		if (oi->typename) {
+		if (oi && oi->typename) {
 			const char *tn = typename(ptot);
 			if (tn)
 				strbuf_addstr(oi->typename, tn);
@@ -2296,7 +2297,7 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 		}
 	}
 
-	if (oi->delta_base_sha1) {
+	if (oi && oi->delta_base_sha1) {
 		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
 			const unsigned char *base;
 
@@ -2438,8 +2439,10 @@ static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
 	if (!ent)
 		return unpack_entry(p, base_offset, type, base_size);
 
-	*type = ent->type;
-	*base_size = ent->size;
+	if (type)
+		*type = ent->type;
+	if (base_size)
+		*base_size = ent->size;
 	return xmemdupz(ent->data, ent->size);
 }
 
@@ -2907,43 +2910,20 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
 }
 
 static int sha1_loose_object_info(const unsigned char *sha1,
+				  void *map, unsigned long mapsize,
 				  enum object_type *typep,
 				  unsigned long *sizep,
 				  struct object_info *oi,
 				  int flags)
 {
 	int status = 0;
-	unsigned long mapsize;
-	void *map;
 	git_zstream stream;
 	char hdr[32];
 	struct strbuf hdrbuf = STRBUF_INIT;
 
-	if (oi->delta_base_sha1)
+	if (oi && oi->delta_base_sha1)
 		hashclr(oi->delta_base_sha1);
-
-	/*
-	 * If we don't care about type or size, then we don't
-	 * need to look inside the object at all. Note that we
-	 * do not optimize out the stat call, even if the
-	 * caller doesn't care about the disk-size, since our
-	 * return value implicitly indicates whether the
-	 * object even exists.
-	 */
-	if (!typep && !oi->typename && !sizep) {
-		const char *path;
-		struct stat st;
-		if (stat_sha1_file(sha1, &st, &path) < 0)
-			return -1;
-		if (oi->disk_sizep)
-			*oi->disk_sizep = st.st_size;
-		return 0;
-	}
-
-	map = map_sha1_file(sha1, &mapsize);
-	if (!map)
-		return -1;
-	if (oi->disk_sizep)
+	if (oi && oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
 	if ((flags & LOOKUP_UNKNOWN_OBJECT)) {
 		if (unpack_sha1_header_to_strbuf(&stream, map, mapsize, hdr, sizeof(hdr), &hdrbuf) < 0)
@@ -2963,29 +2943,25 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 							flags)) < 0)
 		status = error("unable to parse %s header", sha1_to_hex(sha1));
 	git_inflate_end(&stream);
-	munmap(map, mapsize);
 	if (status && typep)
 		*typep = status;
 	strbuf_release(&hdrbuf);
 	return (status < 0) ? status : 0;
 }
 
-int sha1_object_info_extended(const unsigned char *sha1,
-			      enum object_type *typep,
-			      unsigned long *sizep, struct object_info *oi,
-			      unsigned flags)
+static int get_cached_object(const unsigned char *sha1, enum object_type *typep,
+			     unsigned long *sizep, struct object_info *oi,
+			     void **buf)
 {
-	struct cached_object *co;
-	struct pack_entry e;
-	int rtype;
-	const unsigned char *real = lookup_replace_object_extended(sha1, flags);
+	struct cached_object *co = find_cached_object(sha1);
+	if (!co)
+		return 0;
 
-	co = find_cached_object(real);
-	if (co) {
-		if (typep)
-			*typep = co->type;
-		if (sizep)
-			*sizep = co->size;
+	if (typep)
+		*typep = co->type;
+	if (sizep)
+		*sizep = co->size;
+	if (oi) {
 		if (oi->disk_sizep)
 			*(oi->disk_sizep) = 0;
 		if (oi->delta_base_sha1)
@@ -2993,75 +2969,160 @@ int sha1_object_info_extended(const unsigned char *sha1,
 		if (oi->typename)
 			strbuf_addstr(oi->typename, typename(co->type));
 		oi->whence = OI_CACHED;
+	}
+	if (buf)
+		*buf = xmemdupz(co->buf, co->size);
+	return 1;
+}
+
+static int get_loose_object(const unsigned char *sha1, enum object_type *typep,
+			    unsigned long *sizep, struct object_info *oi,
+			    void **buf, int tolerate_bad_type)
+{
+	const char *path;
+	struct stat st;
+
+	if (!typep && !sizep && !oi && !buf)
+		return has_loose_object(sha1);
+
+	if (buf || typep || sizep || (oi && oi->typename)) {
+		/* Need to look inside the object */
+		unsigned long mapsize;
+		int ret = 1;
+		void *map = map_sha1_file(sha1, &mapsize);
+		if (!map)
+			return 0;
+		if (buf) {
+			*buf = unpack_sha1_file(map, mapsize, typep, sizep,
+						sha1);
+			if (!*buf)
+				return 0;
+			/* avoid redundant type and size calculations */
+			typep = NULL;
+			sizep = NULL;
+		}
+		if (typep || sizep || oi) {
+			int f = tolerate_bad_type ? LOOKUP_UNKNOWN_OBJECT : 0;
+			if (sha1_loose_object_info(sha1, map, mapsize, typep,
+						   sizep, oi, f)) {
+				ret = 0;
+				goto cleanup;
+			}
+			if (oi)
+				oi->whence = OI_LOOSE;
+		}
+cleanup:
+		munmap(map, mapsize);
+		return ret;
+	}
+
+	/*
+	 * If we don't care about type or size, then we don't
+	 * need to look inside the object at all. Note that we
+	 * do not optimize out the stat call, even if the
+	 * caller doesn't care about the disk-size, since our
+	 * return value implicitly indicates whether the
+	 * object even exists.
+	 */
+	if (stat_sha1_file(sha1, &st, &path) < 0)
 		return 0;
+	if (oi) {
+		if (oi->disk_sizep)
+			*oi->disk_sizep = st.st_size;
+		oi->whence = OI_LOOSE;
 	}
+	return 1;
+}
 
-	if (!find_pack_entry(real, &e)) {
-		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, typep, sizep, oi, flags)) {
-			oi->whence = OI_LOOSE;
+static int get_packed_object(struct pack_entry *e, enum object_type *typep,
+			     unsigned long *sizep, struct object_info *oi,
+			     void **buf)
+{
+	int rtype;
+	if (buf) {
+		*buf = cache_or_unpack_entry(e->p, e->offset, sizep, typep);
+		if (!*buf)
 			return 0;
+		/* avoid redundant type and size calculations */
+		typep = NULL;
+		sizep = NULL;
+	}
+	if (typep || sizep || oi) {
+		rtype = packed_object_info(e->p, e->offset, typep, sizep, oi);
+		if (rtype < 0)
+			return 0;
+	}
+	if (oi) {
+		if (in_delta_base_cache(e->p, e->offset)) {
+			oi->whence = OI_DBCACHED;
+		} else {
+			oi->whence = OI_PACKED;
+			oi->u.packed.offset = e->offset;
+			oi->u.packed.pack = e->p;
+			oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
+						 rtype == OBJ_OFS_DELTA);
 		}
+	}
+	return 1;
+}
+
+/* start at 1 << 5 to leave room for LOOKUP_ flags */
+#define GET_OBJECT_QUICK (1 << 5)
+#define GET_OBJECT_IGNORE_CACHED (1 << 6)
+static int get_object(const unsigned char *sha1, enum object_type *typep,
+		      unsigned long *sizep, struct object_info *oi,
+		      void **buf, unsigned flags)
+{
+	struct pack_entry e;
+	const unsigned char *real = lookup_replace_object_extended(sha1, flags);
+
+	if (!(flags & GET_OBJECT_IGNORE_CACHED) &&
+	    get_cached_object(real, typep, sizep, oi, buf))
+		return 1;
+
+	if (!find_pack_entry(real, &e)) {
+		/* Most likely it's a loose object. */
+		if (get_loose_object(real, typep, sizep, oi, buf,
+				     flags & LOOKUP_UNKNOWN_OBJECT))
+			return 1;
 
 		/* Not a loose object; someone else may have just packed it. */
+		if (flags & GET_OBJECT_QUICK)
+			return 0;
 		reprepare_packed_git();
 		if (!find_pack_entry(real, &e))
-			return -1;
+			return 0;
 	}
 
-	rtype = packed_object_info(e.p, e.offset, typep, sizep, oi);
-	if (rtype < 0) {
-		mark_bad_packed_object(e.p, real);
-		return sha1_object_info_extended(real, typep, sizep, oi, 0);
-	} else if (in_delta_base_cache(e.p, e.offset)) {
-		oi->whence = OI_DBCACHED;
-	} else {
-		oi->whence = OI_PACKED;
-		oi->u.packed.offset = e.offset;
-		oi->u.packed.pack = e.p;
-		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
-					 rtype == OBJ_OFS_DELTA);
-	}
+	if (get_packed_object(&e, typep, sizep, oi, buf))
+		return 1;
 
-	return 0;
+	/*
+	 * Try to fetch the required object anyway from another pack or loose.
+	 * This should happen only in the presence of a corrupted
+	 * pack, and is better than failing outright.
+	 */
+	mark_bad_packed_object(e.p, real);
+	return get_object(real, typep, sizep, oi, buf, flags);
+}
+
+int sha1_object_info_extended(const unsigned char *sha1,
+			      enum object_type *typep, unsigned long *sizep,
+			      struct object_info *oi, unsigned flags)
+{
+	return get_object(sha1, typep, sizep, oi, NULL, flags) ? 0 : -1;
 }
 
 /* returns enum object_type or negative */
 int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 {
 	enum object_type type;
-	struct object_info oi = OBJECT_INFO_INIT;
-
-	if (sha1_object_info_extended(sha1, &type, sizep, &oi,
+	if (sha1_object_info_extended(sha1, &type, sizep, NULL,
 				      LOOKUP_REPLACE_OBJECT) < 0)
 		return -1;
 	return type;
 }
 
-static void *read_packed_sha1(const unsigned char *sha1,
-			      enum object_type *type, unsigned long *size)
-{
-	struct pack_entry e;
-	void *data;
-
-	if (!find_pack_entry(sha1, &e))
-		return NULL;
-	data = cache_or_unpack_entry(e.p, e.offset, size, type);
-	if (!data) {
-		/*
-		 * We're probably in deep shit, but let's try to fetch
-		 * the required object anyway from another pack or loose.
-		 * This should happen only in the presence of a corrupted
-		 * pack, and is better than failing outright.
-		 */
-		error("failed to read object %s at offset %"PRIuMAX" from %s",
-		      sha1_to_hex(sha1), (uintmax_t)e.offset, e.p->pack_name);
-		mark_bad_packed_object(e.p, sha1);
-		data = read_object(sha1, type, size);
-	}
-	return data;
-}
-
 int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 		      unsigned char *sha1)
 {
@@ -3083,28 +3144,10 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 static void *read_object(const unsigned char *sha1, enum object_type *type,
 			 unsigned long *size)
 {
-	unsigned long mapsize;
-	void *map, *buf;
-	struct cached_object *co;
-
-	co = find_cached_object(sha1);
-	if (co) {
-		*type = co->type;
-		*size = co->size;
-		return xmemdupz(co->buf, co->size);
-	}
-
-	buf = read_packed_sha1(sha1, type, size);
-	if (buf)
-		return buf;
-	map = map_sha1_file(sha1, &mapsize);
-	if (map) {
-		buf = unpack_sha1_file(map, mapsize, type, size, sha1);
-		munmap(map, mapsize);
+	void *buf;
+	if (get_object(sha1, type, size, NULL, &buf, 0))
 		return buf;
-	}
-	reprepare_packed_git();
-	return read_packed_sha1(sha1, type, size);
+	return NULL;
 }
 
 /*
@@ -3456,7 +3499,7 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
 
 	if (has_loose_object(sha1))
 		return 0;
-	buf = read_packed_sha1(sha1, &type, &len);
+	buf = read_object(sha1, &type, &len);
 	if (!buf)
 		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), len) + 1;
@@ -3482,18 +3525,11 @@ int has_sha1_pack(const unsigned char *sha1)
 
 int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
 {
-	struct pack_entry e;
-
+	int f = GET_OBJECT_IGNORE_CACHED |
+		(flags & HAS_SHA1_QUICK ? GET_OBJECT_QUICK : 0);
 	if (!startup_info->have_repository)
 		return 0;
-	if (find_pack_entry(sha1, &e))
-		return 1;
-	if (has_loose_object(sha1))
-		return 1;
-	if (flags & HAS_SHA1_QUICK)
-		return 0;
-	reprepare_packed_git();
-	return find_pack_entry(sha1, &e);
+	return get_object(sha1, NULL, NULL, NULL, NULL, f);
 }
 
 int has_object_file(const struct object_id *oid)
-- 
2.13.1.508.gb3defc5cc-goog


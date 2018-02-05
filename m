Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 959731F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeBFAJv (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:09:51 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42858 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeBFAJt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:09:49 -0500
Received: by mail-pl0-f68.google.com with SMTP id 11so101522plc.9
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qQ/Xb9ji6KAZxM4hoGSIeY+xg01S5XEBLzvIwDngjzo=;
        b=JhipYMpd5NPyALXx2s6kddQtqaB6xUVaAoiatUKbLE30y+AMsyW1qnisrBatasW0Tu
         50kx5QlQiNEJY+4f9uF5AdyqBOA8fzaIsp2y0tOl3LydKT0BcmcCD0QOxRw5UJh8mUAX
         B2XdrtxBrTOb07yeGOYcGtrj1e2eUIHtgIM3cUgakhbuhz9YQoHhHW9Qap78eweon4V3
         a9BoER3kxWOH0ymv75GMnOKmcsEzEg97gDR8zexco7XVDNLJmnYedKVin5wxC7IcO089
         CZhoq8zTw3gI18NHebvW/TcLMiFj4f94dYVFwG6FEsx2Cp79ZZib2mGqB8jXC8JwDr5x
         /XKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qQ/Xb9ji6KAZxM4hoGSIeY+xg01S5XEBLzvIwDngjzo=;
        b=rUBxhLFUdR/lyBBnFlLP8hsHrOz6jWrvJ8K3nAljK3cfSTbVcN1FiuQleAnKRtyGXC
         jg0IlfG4V1Wu1/+X9NM2FKeqi3WLb+N19fhOYiO54dwwKDGOR/ZGSaUaci0h6Adfrm04
         q1HTHDqrfYFreHS1pZYPUaN51tpSoSkR5nmIwBi0cNlUGDTDUqRv1Vq/pPbo80j6+gFJ
         0pzOkuoz8VtLuI2sFPyEXAS5cLKwJscY2aYlloQGgmE9F+mt+ueCO2x5LERA/sRRIPHx
         OuCKk3bGG1QLUktWfGmMZsjY33O7oqcySO7aiTVRHK9WBJdPqPiVmXBjnHYvWmCGxv+h
         swKQ==
X-Gm-Message-State: APf1xPCrSr7hWDYeUd6/Ar77fMPLQoQB2CF1uyGmjv90SkJzw8d7ds4U
        NIObv1WxUIzxACwL/zp2cb4vD5M3v/c=
X-Google-Smtp-Source: AH8x224Q4l5TmDzAfd4dQpokW0V8gghuP9c5Q6g17yrhaHfE7+a8UwMs14uF1RwYS2J8EcfKiZ4N4w==
X-Received: by 2002:a17:902:3064:: with SMTP id u91-v6mr497538plb.421.1517875788108;
        Mon, 05 Feb 2018 16:09:48 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id c29sm18258350pfd.172.2018.02.05.16.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:09:47 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 074/194] object-store: allow sha1_object_info to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:55:35 -0800
Message-Id: <20180205235735.216710-54-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This involves also adapting sha1_object_info_extended and a some
internal functions that are used to implement these. It all has to
happen in one patch, because of a single recursive chain of calls visits
all these functions.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object-store.h | 13 ++++++-------
 packfile.c     | 58 ++++++++++++++++++++++++++++------------------------------
 packfile.h     |  8 ++++----
 sha1_file.c    | 24 +++++++++++++-----------
 4 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/object-store.h b/object-store.h
index 4ff60e3be0..6930cfef82 100644
--- a/object-store.h
+++ b/object-store.h
@@ -91,10 +91,7 @@ static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *
 }
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
-
-#define sha1_object_info(r, sha1, size) \
-	sha1_object_info_##r(sha1, size)
-extern int sha1_object_info_the_repository(const unsigned char *, unsigned long *);
+extern int sha1_object_info(struct repository *r, const unsigned char *sha1, unsigned long *sizep);
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, struct object_id *oid, unsigned flags);
@@ -166,8 +163,10 @@ struct object_info {
 #define OBJECT_INFO_SKIP_CACHED 4
 /* Do not retry packed storage after checking packed and loose storage */
 #define OBJECT_INFO_QUICK 8
-#define sha1_object_info_extended(r, s, oi, f) \
-		sha1_object_info_extended_##r(s, oi, f)
-extern int sha1_object_info_extended_the_repository(const unsigned char *, struct object_info *, unsigned flags);
+
+extern int sha1_object_info_extended(struct repository *r,
+				     const unsigned char *sha1,
+				     struct object_info *oi,
+				     unsigned flags);
 
 #endif /* OBJECT_STORE_H */
diff --git a/packfile.c b/packfile.c
index 178d2e0ddd..6a8d5edf6d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1082,9 +1082,9 @@ static const unsigned char *get_delta_base_sha1(struct packed_git *p,
 		return NULL;
 }
 
-#define retry_bad_packed_offset(r, p, o) \
-	retry_bad_packed_offset_##r(p, o)
-static int retry_bad_packed_offset_the_repository(struct packed_git *p, off_t obj_offset)
+static int retry_bad_packed_offset(struct repository *r,
+				   struct packed_git *p,
+				   off_t obj_offset)
 {
 	int type;
 	struct revindex_entry *revidx;
@@ -1094,7 +1094,7 @@ static int retry_bad_packed_offset_the_repository(struct packed_git *p, off_t ob
 		return OBJ_BAD;
 	sha1 = nth_packed_object_sha1(p, revidx->nr);
 	mark_bad_packed_object(p, sha1);
-	type = sha1_object_info(the_repository, sha1, NULL);
+	type = sha1_object_info(r, sha1, NULL);
 	if (type <= OBJ_NONE)
 		return OBJ_BAD;
 	return type;
@@ -1102,13 +1102,12 @@ static int retry_bad_packed_offset_the_repository(struct packed_git *p, off_t ob
 
 #define POI_STACK_PREALLOC 64
 
-#define packed_to_object_type(r, p, o, t, w, c) \
-	packed_to_object_type_##r(p, o, t, w, c)
-static enum object_type packed_to_object_type_the_repository(struct packed_git *p,
-							     off_t obj_offset,
-							     enum object_type type,
-							     struct pack_window **w_curs,
-							     off_t curpos)
+static enum object_type packed_to_object_type(struct repository *r,
+					      struct packed_git *p,
+					      off_t obj_offset,
+					      enum object_type type,
+					      struct pack_window **w_curs,
+					      off_t curpos)
 {
 	off_t small_poi_stack[POI_STACK_PREALLOC];
 	off_t *poi_stack = small_poi_stack;
@@ -1135,7 +1134,7 @@ static enum object_type packed_to_object_type_the_repository(struct packed_git *
 		if (type <= OBJ_NONE) {
 			/* If getting the base itself fails, we first
 			 * retry the base, otherwise unwind */
-			type = retry_bad_packed_offset(the_repository, p, base_offset);
+			type = retry_bad_packed_offset(r, p, base_offset);
 			if (type > OBJ_NONE)
 				goto out;
 			goto unwind;
@@ -1163,7 +1162,7 @@ static enum object_type packed_to_object_type_the_repository(struct packed_git *
 unwind:
 	while (poi_stack_nr) {
 		obj_offset = poi_stack[--poi_stack_nr];
-		type = retry_bad_packed_offset(the_repository, p, obj_offset);
+		type = retry_bad_packed_offset(r, p, obj_offset);
 		if (type > OBJ_NONE)
 			goto out;
 	}
@@ -1250,15 +1249,15 @@ static void detach_delta_base_cache_entry(struct delta_base_cache_entry *ent)
 	free(ent);
 }
 
-#define cache_or_unpack_entry(r, p, bo, bs, t) cache_or_unpack_entry_##r(p, bo, bs, t)
-static void *cache_or_unpack_entry_the_repository(struct packed_git *p, off_t base_offset,
-	unsigned long *base_size, enum object_type *type)
+static void *cache_or_unpack_entry(struct repository *r, struct packed_git *p,
+				   off_t base_offset, unsigned long *base_size,
+				   enum object_type *type)
 {
 	struct delta_base_cache_entry *ent;
 
 	ent = get_delta_base_cache_entry(p, base_offset);
 	if (!ent)
-		return unpack_entry(the_repository, p, base_offset, type, base_size);
+		return unpack_entry(r, p, base_offset, type, base_size);
 
 	if (type)
 		*type = ent->type;
@@ -1312,8 +1311,8 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	hashmap_add(&delta_base_cache, ent);
 }
 
-int packed_object_info_the_repository(struct packed_git *p, off_t obj_offset,
-				      struct object_info *oi)
+int packed_object_info(struct repository *r, struct packed_git *p,
+		       off_t obj_offset, struct object_info *oi)
 {
 	struct pack_window *w_curs = NULL;
 	unsigned long size;
@@ -1325,7 +1324,7 @@ int packed_object_info_the_repository(struct packed_git *p, off_t obj_offset,
 	 * a "real" type later if the caller is interested.
 	 */
 	if (oi->contentp) {
-		*oi->contentp = cache_or_unpack_entry(the_repository, p, obj_offset, oi->sizep,
+		*oi->contentp = cache_or_unpack_entry(r, p, obj_offset, oi->sizep,
 						      &type);
 		if (!*oi->contentp)
 			type = OBJ_BAD;
@@ -1359,7 +1358,7 @@ int packed_object_info_the_repository(struct packed_git *p, off_t obj_offset,
 
 	if (oi->typep || oi->typename) {
 		enum object_type ptot;
-		ptot = packed_to_object_type(the_repository, p, obj_offset,
+		ptot = packed_to_object_type(r, p, obj_offset,
 					     type, &w_curs, curpos);
 		if (oi->typep)
 			*oi->typep = ptot;
@@ -1448,10 +1447,10 @@ struct unpack_entry_stack_ent {
 	unsigned long size;
 };
 
-#define read_object(r, s, t, sz) read_object_##r(s, t, sz)
-static void *read_object_the_repository(const unsigned char *sha1,
-					enum object_type *type,
-					unsigned long *size)
+static void *read_object(struct repository *r,
+			 const unsigned char *sha1,
+			 enum object_type *type,
+			 unsigned long *size)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 	void *content;
@@ -1459,14 +1458,13 @@ static void *read_object_the_repository(const unsigned char *sha1,
 	oi.sizep = size;
 	oi.contentp = &content;
 
-	if (sha1_object_info_extended(the_repository, sha1, &oi, 0) < 0)
+	if (sha1_object_info_extended(r, sha1, &oi, 0) < 0)
 		return NULL;
 	return content;
 }
 
-void *unpack_entry_the_repository(struct packed_git *p, off_t obj_offset,
-				  enum object_type *final_type,
-				  unsigned long *final_size)
+void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
+		   enum object_type *final_type, unsigned long *final_size)
 {
 	struct pack_window *w_curs = NULL;
 	off_t curpos = obj_offset;
@@ -1596,7 +1594,7 @@ void *unpack_entry_the_repository(struct packed_git *p, off_t obj_offset,
 				      sha1_to_hex(base_sha1), (uintmax_t)obj_offset,
 				      p->pack_name);
 				mark_bad_packed_object(p, base_sha1);
-				base = read_object(the_repository, base_sha1, &type, &base_size);
+				base = read_object(r, base_sha1, &type, &base_size);
 				external_base = base;
 			}
 		}
diff --git a/packfile.h b/packfile.h
index 6d10871d25..f8d2825cce 100644
--- a/packfile.h
+++ b/packfile.h
@@ -125,8 +125,7 @@ extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
 extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
 
 extern int is_pack_valid(struct packed_git *);
-#define unpack_entry(r, p, of, ot, s) unpack_entry_##r(p, of, ot, s)
-extern void *unpack_entry_the_repository(struct packed_git *, off_t, enum object_type *, unsigned long *);
+extern void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
@@ -136,8 +135,9 @@ extern void release_pack_memory(size_t);
 /* global flag to enable extra checks when accessing packed objects */
 extern int do_check_packed_object_crc;
 
-#define packed_object_info(r, p, o, oi) packed_object_info_##r(p, o, oi)
-extern int packed_object_info_the_repository(struct packed_git *pack, off_t offset, struct object_info *);
+extern int packed_object_info(struct repository *r,
+			      struct packed_git *pack,
+			      off_t offset, struct object_info *);
 
 extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
 extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
diff --git a/sha1_file.c b/sha1_file.c
index 7e06ece5f3..c296b76329 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1237,13 +1237,14 @@ static int sha1_loose_object_info(struct repository *r,
 	return (status < 0) ? status : 0;
 }
 
-int sha1_object_info_extended_the_repository(const unsigned char *sha1, struct object_info *oi, unsigned flags)
+int sha1_object_info_extended(struct repository *r, const unsigned char *sha1,
+			      struct object_info *oi, unsigned flags)
 {
 	static struct object_info blank_oi = OBJECT_INFO_INIT;
 	struct pack_entry e;
 	int rtype;
 	const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
-				    lookup_replace_object(the_repository, sha1) :
+				    lookup_replace_object(r, sha1) :
 				    sha1;
 
 	if (is_null_sha1(real))
@@ -1272,17 +1273,17 @@ int sha1_object_info_extended_the_repository(const unsigned char *sha1, struct o
 		}
 	}
 
-	if (!find_pack_entry(the_repository, real, &e)) {
+	if (!find_pack_entry(r, real, &e)) {
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(the_repository, real, oi, flags))
+		if (!sha1_loose_object_info(r, real, oi, flags))
 			return 0;
 
 		/* Not a loose object; someone else may have just packed it. */
 		if (flags & OBJECT_INFO_QUICK) {
 			return -1;
 		} else {
-			reprepare_packed_git(the_repository);
-			if (!find_pack_entry(the_repository, real, &e))
+			reprepare_packed_git(r);
+			if (!find_pack_entry(r, real, &e))
 				return -1;
 		}
 	}
@@ -1294,11 +1295,10 @@ int sha1_object_info_extended_the_repository(const unsigned char *sha1, struct o
 		 */
 		return 0;
 
-	rtype = packed_object_info(the_repository, e.p, e.offset, oi);
+	rtype = packed_object_info(r, e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
-		return sha1_object_info_extended(the_repository, real, oi,
-						 0);
+		return sha1_object_info_extended(r, real, oi, 0);
 	} else if (oi->whence == OI_PACKED) {
 		oi->u.packed.offset = e.offset;
 		oi->u.packed.pack = e.p;
@@ -1310,14 +1310,16 @@ int sha1_object_info_extended_the_repository(const unsigned char *sha1, struct o
 }
 
 /* returns enum object_type or negative */
-int sha1_object_info_the_repository(const unsigned char *sha1, unsigned long *sizep)
+int sha1_object_info(struct repository *r,
+		     const unsigned char *sha1,
+		     unsigned long *sizep)
 {
 	enum object_type type;
 	struct object_info oi = OBJECT_INFO_INIT;
 
 	oi.typep = &type;
 	oi.sizep = sizep;
-	if (sha1_object_info_extended(the_repository, sha1, &oi,
+	if (sha1_object_info_extended(r, sha1, &oi,
 				      OBJECT_INFO_LOOKUP_REPLACE) < 0)
 		return -1;
 	return type;
-- 
2.15.1.433.g936d1b9894.dirty


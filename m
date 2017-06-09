Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 266F51F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 19:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751802AbdFITXk (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 15:23:40 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34292 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbdFITXg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 15:23:36 -0400
Received: by mail-pf0-f179.google.com with SMTP id 15so3913951pfc.1
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 12:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=TyMh9vrd4ET9vR+xKFMucQZHLbJzO3llG6hjZ22cVNw=;
        b=nBmmR4Q4+Cdf/EzLsw9AWx4OAdu6agEBmth1cX2uUaB44jD+sg3zWjQQxDYSLOAm6C
         QXgN4FlhAqHlwj4Ko6mx/2i9FrazFfZgRqCKyei0z+LTV0WJ73ai8JNQd94M7lfTMfjb
         lWGiR+1w6kmIthqzFv+FH/LeCVtIVRFEWMw/+BJEOE+SHqL4QvTYAHu6Vkjw3oQ0D2gn
         6lmS00iZZAAy8WMLiidkYTVVRfapApUv8lW5s38j0Jwk4yR0r6F8tO2hRexoPVrHoRfp
         CHpr0Q+97oVMcsvqd8lXcI1sBfpjawhte0MtEX/jvCDkxw/rjad4yS2xGbDAbpAuWbom
         BzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=TyMh9vrd4ET9vR+xKFMucQZHLbJzO3llG6hjZ22cVNw=;
        b=OpgFF/6zUEeaH8VFEOlZEIiH4SLA7XEqeg9tNxxN/N+hipEnN4T6PqoCEJQGIJcW7w
         cF3byNv2DOkUSd4VPDS8cR+CwU7iAq8T9I+vjCFq1SCfJ2TxETfgP7EgPzo3I9GUgKdH
         XwXBJhzKXGWHDwz6Xq4aqaHOyGwP99njJMxlBI4wbfntWVGlToN+VEyX1DMQnZEKfThf
         lDflZ4tbcC1Tq/G6hqv35ci5wjBwIg+/5TWXtlQreWc3ZLMMduzf5BMN7PpVS1FrybdL
         NUZxKRYXY7IreLzBaX00KM5Af+OxPj6GCqMQnPC7XewdfoRM+N+6lpgtvbt9UGpHDKMS
         cglg==
X-Gm-Message-State: AODbwcB2+AD8QllBovJOYxefyrPjMzqicNcovdsNcjY+NWCGKMfkVr2O
        1LneN/7LY+uBVejA/7DmQw==
X-Received: by 10.84.130.99 with SMTP id 90mr42309493plc.165.1497036215161;
        Fri, 09 Jun 2017 12:23:35 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id f72sm5757924pfe.4.2017.06.09.12.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 12:23:33 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH 2/4] sha1_file: extract type and size from object_info
Date:   Fri,  9 Jun 2017 12:23:24 -0700
Message-Id: <b090fef9ff8593a6d77c3d3363b4af7e73ac12dc.1497035376.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <cover.1497035376.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com>
In-Reply-To: <cover.1497035376.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is patch 1 of 2 to consolidate all storage-agnostic object
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

Such a consolidated function would need to handle the read_object() case
(which returns the object data, type, and size) and the
sha1_object_info_extended() case (which returns the object type, size,
and some additional information, not all of which can be "turned off" by
passing NULL in "struct object_info").

To make it easier to implement and use such a function, remove the type
and size fields from "struct object_info", making them additional
parameters in sha1_object_info_extended (and related functions) instead.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/cat-file.c     | 29 +++++++++++---------
 builtin/pack-objects.c |  5 ++--
 cache.h                |  6 ++---
 sha1_file.c            | 72 ++++++++++++++++++++++++++++----------------------
 streaming.c            |  4 +--
 5 files changed, 62 insertions(+), 54 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 4bffd7a2d..5bb16c045 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -75,7 +75,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	switch (opt) {
 	case 't':
 		oi.typename = &sb;
-		if (sha1_object_info_extended(oid.hash, &oi, flags) < 0)
+		if (sha1_object_info_extended(oid.hash, NULL, NULL, &oi,
+					      flags) < 0)
 			die("git cat-file: could not get object info");
 		if (sb.len) {
 			printf("%s\n", sb.buf);
@@ -85,8 +86,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		break;
 
 	case 's':
-		oi.sizep = &size;
-		if (sha1_object_info_extended(oid.hash, &oi, flags) < 0)
+		if (sha1_object_info_extended(oid.hash, NULL, &size, &oi,
+					      flags) < 0)
 			die("git cat-file: could not get object info");
 		printf("%lu\n", size);
 		return 0;
@@ -194,10 +195,12 @@ struct expand_data {
 	int split_on_whitespace;
 
 	/*
-	 * After a mark_query run, this object_info is set up to be
-	 * passed to sha1_object_info_extended. It will point to the data
+	 * After a mark_query run, these fields are set up to be
+	 * passed to sha1_object_info_extended. They will point to the data
 	 * elements above, so you can retrieve the response from there.
 	 */
+	enum object_type *typep;
+	unsigned long *sizep;
 	struct object_info info;
 
 	/*
@@ -224,12 +227,12 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 			strbuf_addstr(sb, oid_to_hex(&data->oid));
 	} else if (is_atom("objecttype", atom, len)) {
 		if (data->mark_query)
-			data->info.typep = &data->type;
+			data->typep = &data->type;
 		else
 			strbuf_addstr(sb, typename(data->type));
 	} else if (is_atom("objectsize", atom, len)) {
 		if (data->mark_query)
-			data->info.sizep = &data->size;
+			data->sizep = &data->size;
 		else
 			strbuf_addf(sb, "%lu", data->size);
 	} else if (is_atom("objectsize:disk", atom, len)) {
@@ -280,7 +283,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 {
 	const struct object_id *oid = &data->oid;
 
-	assert(data->info.typep);
+	assert(data->typep);
 
 	if (data->type == OBJ_BLOB) {
 		if (opt->buffer_output)
@@ -323,7 +326,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 			die("object %s disappeared", oid_to_hex(oid));
 		if (type != data->type)
 			die("object %s changed type!?", oid_to_hex(oid));
-		if (data->info.sizep && size != data->size)
+		if (data->sizep && size != data->size)
 			die("object %s changed size!?", oid_to_hex(oid));
 
 		batch_write(opt, contents, size);
@@ -337,7 +340,8 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 	struct strbuf buf = STRBUF_INIT;
 
 	if (!data->skip_object_info &&
-	    sha1_object_info_extended(data->oid.hash, &data->info, LOOKUP_REPLACE_OBJECT) < 0) {
+	    sha1_object_info_extended(data->oid.hash, data->typep, data->sizep,
+				      &data->info, LOOKUP_REPLACE_OBJECT) < 0) {
 		printf("%s missing\n",
 		       obj_name ? obj_name : oid_to_hex(&data->oid));
 		fflush(stdout);
@@ -454,7 +458,8 @@ static int batch_objects(struct batch_options *opt)
 
 	if (opt->all_objects) {
 		struct object_info empty = OBJECT_INFO_INIT;
-		if (!memcmp(&data.info, &empty, sizeof(empty)))
+		if (!data.typep && !data.sizep &&
+		    !memcmp(&data.info, &empty, sizeof(empty)))
 			data.skip_object_info = 1;
 	}
 
@@ -463,7 +468,7 @@ static int batch_objects(struct batch_options *opt)
 	 * since we will want to decide whether or not to stream.
 	 */
 	if (opt->print_contents)
-		data.info.typep = &data.type;
+		data.typep = &data.type;
 
 	if (opt->all_objects) {
 		struct oid_array sa = OID_ARRAY_INIT;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f672225de..9cecc82b2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1557,9 +1557,8 @@ static void drop_reused_delta(struct object_entry *entry)
 	entry->delta = NULL;
 	entry->depth = 0;
 
-	oi.sizep = &entry->size;
-	oi.typep = &entry->type;
-	if (packed_object_info(entry->in_pack, entry->in_pack_offset, &oi) < 0) {
+	if (packed_object_info(entry->in_pack, entry->in_pack_offset,
+			       &entry->type, &entry->size, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
 		 * fall back to sha1_object_info, which may find another copy.
diff --git a/cache.h b/cache.h
index 4d92aae0e..bf09962e4 100644
--- a/cache.h
+++ b/cache.h
@@ -1830,8 +1830,6 @@ extern int for_each_packed_object(each_packed_object_fn, void *, unsigned flags)
 
 struct object_info {
 	/* Request */
-	enum object_type *typep;
-	unsigned long *sizep;
 	off_t *disk_sizep;
 	unsigned char *delta_base_sha1;
 	struct strbuf *typename;
@@ -1866,8 +1864,8 @@ struct object_info {
  */
 #define OBJECT_INFO_INIT {NULL}
 
-extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
-extern int packed_object_info(struct packed_git *pack, off_t offset, struct object_info *);
+extern int sha1_object_info_extended(const unsigned char *, enum object_type *typep, unsigned long *sizep, struct object_info *, unsigned flags);
+extern int packed_object_info(struct packed_git *pack, off_t offset, enum object_type *typep, unsigned long *sizep, struct object_info *);
 
 /* Dumb servers support */
 extern int update_server_info(int);
diff --git a/sha1_file.c b/sha1_file.c
index a52b27541..ac4d77ccc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1936,8 +1936,10 @@ static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long s
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
-			       unsigned int flags)
+static int parse_sha1_header_extended(const char *hdr, enum object_type *typep,
+				      unsigned long *sizep,
+				      struct object_info *oi,
+				      unsigned int flags)
 {
 	const char *type_buf = hdr;
 	unsigned long size;
@@ -1968,8 +1970,8 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 		type = 0;
 	else if (type < 0)
 		die("invalid object type");
-	if (oi->typep)
-		*oi->typep = type;
+	if (typep)
+		*typep = type;
 
 	/*
 	 * The length must follow immediately, and be in canonical
@@ -1988,8 +1990,8 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 		}
 	}
 
-	if (oi->sizep)
-		*oi->sizep = size;
+	if (sizep)
+		*sizep = size;
 
 	/*
 	 * The length must be followed by a zero byte
@@ -2000,9 +2002,8 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 int parse_sha1_header(const char *hdr, unsigned long *sizep)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
-
-	oi.sizep = sizep;
-	return parse_sha1_header_extended(hdr, &oi, LOOKUP_REPLACE_OBJECT);
+	return parse_sha1_header_extended(hdr, NULL, sizep, &oi,
+					  LOOKUP_REPLACE_OBJECT);
 }
 
 static void *unpack_sha1_file(void *map, unsigned long mapsize, enum object_type *type, unsigned long *size, const unsigned char *sha1)
@@ -2240,6 +2241,7 @@ static enum object_type packed_to_object_type(struct packed_git *p,
 }
 
 int packed_object_info(struct packed_git *p, off_t obj_offset,
+		       enum object_type *typep, unsigned long *sizep,
 		       struct object_info *oi)
 {
 	struct pack_window *w_curs = NULL;
@@ -2253,7 +2255,7 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 	 */
 	type = unpack_object_header(p, &w_curs, &curpos, &size);
 
-	if (oi->sizep) {
+	if (sizep) {
 		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
 			off_t tmp_pos = curpos;
 			off_t base_offset = get_delta_base(p, &w_curs, &tmp_pos,
@@ -2262,13 +2264,13 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 				type = OBJ_BAD;
 				goto out;
 			}
-			*oi->sizep = get_size_from_delta(p, &w_curs, tmp_pos);
-			if (*oi->sizep == 0) {
+			*sizep = get_size_from_delta(p, &w_curs, tmp_pos);
+			if (*sizep == 0) {
 				type = OBJ_BAD;
 				goto out;
 			}
 		} else {
-			*oi->sizep = size;
+			*sizep = size;
 		}
 	}
 
@@ -2277,12 +2279,12 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 		*oi->disk_sizep = revidx[1].offset - obj_offset;
 	}
 
-	if (oi->typep || oi->typename) {
+	if (typep || oi->typename) {
 		enum object_type ptot;
 		ptot = packed_to_object_type(p, obj_offset, type, &w_curs,
 					     curpos);
-		if (oi->typep)
-			*oi->typep = ptot;
+		if (typep)
+			*typep = ptot;
 		if (oi->typename) {
 			const char *tn = typename(ptot);
 			if (tn)
@@ -2905,6 +2907,8 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
 }
 
 static int sha1_loose_object_info(const unsigned char *sha1,
+				  enum object_type *typep,
+				  unsigned long *sizep,
 				  struct object_info *oi,
 				  int flags)
 {
@@ -2926,7 +2930,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	 * return value implicitly indicates whether the
 	 * object even exists.
 	 */
-	if (!oi->typep && !oi->typename && !oi->sizep) {
+	if (!typep && !oi->typename && !sizep) {
 		const char *path;
 		struct stat st;
 		if (stat_sha1_file(sha1, &st, &path) < 0)
@@ -2951,20 +2955,25 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	if (status < 0)
 		; /* Do nothing */
 	else if (hdrbuf.len) {
-		if ((status = parse_sha1_header_extended(hdrbuf.buf, oi, flags)) < 0)
+		if ((status = parse_sha1_header_extended(hdrbuf.buf, typep,
+							 sizep, oi, flags)) < 0)
 			status = error("unable to parse %s header with --allow-unknown-type",
 				       sha1_to_hex(sha1));
-	} else if ((status = parse_sha1_header_extended(hdr, oi, flags)) < 0)
+	} else if ((status = parse_sha1_header_extended(hdr, typep, sizep, oi,
+							flags)) < 0)
 		status = error("unable to parse %s header", sha1_to_hex(sha1));
 	git_inflate_end(&stream);
 	munmap(map, mapsize);
-	if (status && oi->typep)
-		*oi->typep = status;
+	if (status && typep)
+		*typep = status;
 	strbuf_release(&hdrbuf);
 	return (status < 0) ? status : 0;
 }
 
-int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
+int sha1_object_info_extended(const unsigned char *sha1,
+			      enum object_type *typep,
+			      unsigned long *sizep, struct object_info *oi,
+			      unsigned flags)
 {
 	struct cached_object *co;
 	struct pack_entry e;
@@ -2973,10 +2982,10 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 
 	co = find_cached_object(real);
 	if (co) {
-		if (oi->typep)
-			*(oi->typep) = co->type;
-		if (oi->sizep)
-			*(oi->sizep) = co->size;
+		if (typep)
+			*typep = co->type;
+		if (sizep)
+			*sizep = co->size;
 		if (oi->disk_sizep)
 			*(oi->disk_sizep) = 0;
 		if (oi->delta_base_sha1)
@@ -2989,7 +2998,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 
 	if (!find_pack_entry(real, &e)) {
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, oi, flags)) {
+		if (!sha1_loose_object_info(real, typep, sizep, oi, flags)) {
 			oi->whence = OI_LOOSE;
 			return 0;
 		}
@@ -3000,10 +3009,10 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 			return -1;
 	}
 
-	rtype = packed_object_info(e.p, e.offset, oi);
+	rtype = packed_object_info(e.p, e.offset, typep, sizep, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
-		return sha1_object_info_extended(real, oi, 0);
+		return sha1_object_info_extended(real, typep, sizep, oi, 0);
 	} else if (in_delta_base_cache(e.p, e.offset)) {
 		oi->whence = OI_DBCACHED;
 	} else {
@@ -3023,9 +3032,8 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 	enum object_type type;
 	struct object_info oi = OBJECT_INFO_INIT;
 
-	oi.typep = &type;
-	oi.sizep = sizep;
-	if (sha1_object_info_extended(sha1, &oi, LOOKUP_REPLACE_OBJECT) < 0)
+	if (sha1_object_info_extended(sha1, &type, sizep, &oi,
+				      LOOKUP_REPLACE_OBJECT) < 0)
 		return -1;
 	return type;
 }
diff --git a/streaming.c b/streaming.c
index 9afa66b8b..ee5d1f684 100644
--- a/streaming.c
+++ b/streaming.c
@@ -111,9 +111,7 @@ static enum input_source istream_source(const unsigned char *sha1,
 	unsigned long size;
 	int status;
 
-	oi->typep = type;
-	oi->sizep = &size;
-	status = sha1_object_info_extended(sha1, oi, 0);
+	status = sha1_object_info_extended(sha1, type, &size, oi, 0);
 	if (status < 0)
 		return stream_error;
 
-- 
2.13.1.508.gb3defc5cc-goog


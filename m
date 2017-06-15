Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0921720401
	for <e@80x24.org>; Thu, 15 Jun 2017 20:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbdFOUj7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 16:39:59 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36637 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752551AbdFOUjx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 16:39:53 -0400
Received: by mail-pg0-f54.google.com with SMTP id a70so11357339pge.3
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 13:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=CbNMJE8hwG5pjX1BnWOfuWHsMDx3J1LDEnzK25Duk6o=;
        b=DFSKVdW6co0bdA7LhZe7JNZFB0zeyLEfkMu8sLDOCDdlYrqrcb97Vc1t8++Hkohhx5
         XrD4GYCvC0+m9H28kMswIbkI7so8Hmqjd9OBUFUAa04EhVZVmSRQ1mg5jhnI0X+yDSM3
         RpOR0XraBJhHhQP6mFyzB1vWgMu0E50+MXwein2jEPqrt50O/2i+sWDHr+yeZ9XI7z00
         5v2LeJOsPIyR6jAtZLfnUMvKrrAlgtbzwSgNGmBAEstQwgnVqLOUNn8Ofikcw04Yirhw
         unG8eB5M6szdul/STM3PR3n6aPksOn5ztvt7blAV5u0yFWf4JXph5aTyiu5w+Ct70LML
         rvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=CbNMJE8hwG5pjX1BnWOfuWHsMDx3J1LDEnzK25Duk6o=;
        b=CvmwxvodItNggRqRrKBeTnPuSP1jweosOEbqAJFyDqMjkan2Rg/tCbtdGD9crziTOg
         8EM5wBRzqjkgdCJDKhr/I62tLrtm1ilWUxVqa9wd7iOd6SI2jKAEdeAq+Gdv7iD7Ik/u
         zpEuFa+bOdPuUOBl6LpTUErB5WcfvsBQGMDk5SM8d8OZWm7v1VZ1Z8C6uXIyrAjDX9ss
         T2TkNf3kTf4LdhNzPFKgOlDuwGH13wdOE2groT/MyhqR5AOCXNLMGoCWSOSzKDhLRfk3
         KkBZcm5r2oxQm2Cwr4ylQZuRFR7odAxfuwuFaOZtPWiH3PFOGgkkiWVIIw9xF1sgw/y1
         NKoQ==
X-Gm-Message-State: AKS2vOyEny/O02yjXYdMNRgUHKfHMik1Ijke7jfVUu5DisEgR6UOPeSs
        a9QFJkrTb/r+m8Ed5pfAiA==
X-Received: by 10.84.132.14 with SMTP id 14mr5656159ple.271.1497559182292;
        Thu, 15 Jun 2017 13:39:42 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id i2sm274226pfe.89.2017.06.15.13.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 13:39:41 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 3/4] sha1_file: consolidate storage-agnostic object fns
Date:   Thu, 15 Jun 2017 13:39:30 -0700
Message-Id: <d78ecc7f35c88b3145ac55c845a3fd756b0fd5ad.1497558850.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <cover.1497558850.git.jonathantanmy@google.com>
References: <cover.1497558850.git.jonathantanmy@google.com>
In-Reply-To: <cover.1497558850.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com> <cover.1497558850.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

However, has_sha1_file_with_flags() does things that the other 2 don't
(skipping cached storage, allowing a "quick" mode that skips retrying
the packed storage after trying the loose storage, and refreshing any
loose files found).

Therefore, consolidate only the other 2 functions by extending
sha1_object_info_extended() to support the functionality needed, and
then modifying read_object() to use sha1_object_info_extended().

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     |  1 +
 sha1_file.c | 84 ++++++++++++++++++++++++++++++-------------------------------
 2 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/cache.h b/cache.h
index 4d92aae0e..63a73af17 100644
--- a/cache.h
+++ b/cache.h
@@ -1835,6 +1835,7 @@ struct object_info {
 	off_t *disk_sizep;
 	unsigned char *delta_base_sha1;
 	struct strbuf *typename;
+	void **contentp;
 
 	/* Response */
 	enum {
diff --git a/sha1_file.c b/sha1_file.c
index a38319443..60b487c70 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2005,19 +2005,6 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, LOOKUP_REPLACE_OBJECT);
 }
 
-static void *unpack_sha1_file(void *map, unsigned long mapsize, enum object_type *type, unsigned long *size, const unsigned char *sha1)
-{
-	int ret;
-	git_zstream stream;
-	char hdr[8192];
-
-	ret = unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr));
-	if (ret < Z_OK || (*type = parse_sha1_header(hdr, size)) < 0)
-		return NULL;
-
-	return unpack_sha1_rest(&stream, hdr, *size, sha1);
-}
-
 unsigned long get_size_from_delta(struct packed_git *p,
 				  struct pack_window **w_curs,
 			          off_t curpos)
@@ -2326,8 +2313,10 @@ static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
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
 
@@ -2388,9 +2377,16 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 	 * We always get the representation type, but only convert it to
 	 * a "real" type later if the caller is interested.
 	 */
-	type = unpack_object_header(p, &w_curs, &curpos, &size);
+	if (oi->contentp) {
+		*oi->contentp = cache_or_unpack_entry(p, obj_offset, oi->sizep,
+						      &type);
+		if (!*oi->contentp)
+			type = OBJ_BAD;
+	} else {
+		type = unpack_object_header(p, &w_curs, &curpos, &size);
+	}
 
-	if (oi->sizep) {
+	if (!oi->contentp && oi->sizep) {
 		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
 			off_t tmp_pos = curpos;
 			off_t base_offset = get_delta_base(p, &w_curs, &tmp_pos,
@@ -2679,8 +2675,10 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 		free(external_base);
 	}
 
-	*final_type = type;
-	*final_size = size;
+	if (final_type)
+		*final_type = type;
+	if (final_size)
+		*final_size = size;
 
 	unuse_pack(&w_curs);
 
@@ -2914,6 +2912,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	git_zstream stream;
 	char hdr[32];
 	struct strbuf hdrbuf = STRBUF_INIT;
+	unsigned long size_scratch;
 
 	if (oi->delta_base_sha1)
 		hashclr(oi->delta_base_sha1);
@@ -2926,7 +2925,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	 * return value implicitly indicates whether the
 	 * object even exists.
 	 */
-	if (!oi->typep && !oi->typename && !oi->sizep) {
+	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
 		if (stat_sha1_file(sha1, &st, &path) < 0)
@@ -2939,6 +2938,10 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	map = map_sha1_file(sha1, &mapsize);
 	if (!map)
 		return -1;
+
+	if (!oi->sizep)
+		oi->sizep = &size_scratch;
+
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
 	if ((flags & LOOKUP_UNKNOWN_OBJECT)) {
@@ -2956,10 +2959,18 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 				       sha1_to_hex(sha1));
 	} else if ((status = parse_sha1_header_extended(hdr, oi, flags)) < 0)
 		status = error("unable to parse %s header", sha1_to_hex(sha1));
-	git_inflate_end(&stream);
+
+	if (status >= 0 && oi->contentp)
+		*oi->contentp = unpack_sha1_rest(&stream, hdr,
+						 *oi->sizep, sha1);
+	else
+		git_inflate_end(&stream);
+
 	munmap(map, mapsize);
 	if (status && oi->typep)
 		*oi->typep = status;
+	if (oi->sizep == &size_scratch)
+		oi->sizep = NULL;
 	strbuf_release(&hdrbuf);
 	return (status < 0) ? status : 0;
 }
@@ -2983,6 +2994,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 			hashclr(oi->delta_base_sha1);
 		if (oi->typename)
 			strbuf_addstr(oi->typename, typename(co->type));
+		if (oi->contentp)
+			*oi->contentp = xmemdupz(co->buf, co->size);
 		oi->whence = OI_CACHED;
 		return 0;
 	}
@@ -3075,28 +3088,15 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
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
+	struct object_info oi = OBJECT_INFO_INIT;
+	void *content;
+	oi.typep = type;
+	oi.sizep = size;
+	oi.contentp = &content;
 
-	buf = read_packed_sha1(sha1, type, size);
-	if (buf)
-		return buf;
-	map = map_sha1_file(sha1, &mapsize);
-	if (map) {
-		buf = unpack_sha1_file(map, mapsize, type, size, sha1);
-		munmap(map, mapsize);
-		return buf;
-	}
-	reprepare_packed_git();
-	return read_packed_sha1(sha1, type, size);
+	if (sha1_object_info_extended(sha1, &oi, 0))
+		return NULL;
+	return content;
 }
 
 /*
-- 
2.13.1.518.g3df882009-goog


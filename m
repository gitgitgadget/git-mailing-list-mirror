Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBC9D208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751777AbdHRWVH (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:21:07 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36447 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbdHRWVD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:21:03 -0400
Received: by mail-pg0-f45.google.com with SMTP id i12so72235749pgr.3
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ItVAXuQhqD57y9E3ZEJjwreo6EKlVmN6F+28CjNTsww=;
        b=QFgrtMoIuCZpRlShd2iFWrj6yU+Yqb0ny8Lir0TgOQCCyBwn6mJjHoNsWxgecwNXvo
         b08keIX09XIAS/zFbDFX4iYUF6AeF/LfJRZWypA9F07SmkEFtHefkLSOvJMRB3X0xcpn
         hmmdCue+WIRq66Rrc7zO2bgLObCi2G/tFJyvKMPMqmo8+1A14Sf0HHokNnBYx76bims0
         q8SMbQRJvMjPCQYkvKOLM320A0j1Sb7uZgNuOuegMn9F1Fgy1VxF8mY9508LAvFm4f8a
         n9GfVI3SiG9bqgySL/q0cz2NGAR4OMc9qyt5gdgxB19rj8MlC/g6BEV/hTFL6T1XfVSz
         rurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ItVAXuQhqD57y9E3ZEJjwreo6EKlVmN6F+28CjNTsww=;
        b=M2xWxqHvxfkenbC99OxdIMsyQk42PxNkObMZIo/QPXpDZXbDRatP5ZqwJuBxFEZdZ0
         ++IlDneSXK7x99YwQBjxVloiYeSmjFKqdSXe9+ydRfn6jcLDJVKvZMwFUb4Belraj2A4
         M6t6fujD2wBndVOmzGHJPT2Huxy9B0AD35AcPvFK+vBSFP24KlY2KVGfEnkxqrXqdqVL
         CbqOssuY5kjpyr0pWwkCn/HdKmVovitBnVC7Ws2Um/MJefVcKCnsLCNpxEpvKda+I5+j
         C0xyfh0G8Z7LFsYfwztna5jLsLmXxXBV4vGa88uteMrIG0j+NSgRVdbZ8jeXiEfDDvo0
         ECZQ==
X-Gm-Message-State: AHYfb5g7SoCQbgMZnsmykUxYd38+HOkkpgA2q31x1a/ocWwShPEfwm9X
        qfUgXsKm4LaKSZOt39+0uQ==
X-Received: by 10.99.117.71 with SMTP id f7mr9543645pgn.245.1503094862607;
        Fri, 18 Aug 2017 15:21:02 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:21:01 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 16/23] pack: move nth_packed_object_{sha1,oid}
Date:   Fri, 18 Aug 2017 15:20:31 -0700
Message-Id: <6e2c343f22add6bd10c87905a90b1307b952ce26.1503094448.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1503094448.git.jonathantanmy@google.com>
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1503094448.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     | 14 --------------
 packfile.c  | 31 +++++++++++++++++++++++++++++++
 packfile.h  | 16 +++++++++++++++-
 sha1_file.c | 31 -------------------------------
 4 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/cache.h b/cache.h
index 11aa18e6a..83aa3cc62 100644
--- a/cache.h
+++ b/cache.h
@@ -1636,20 +1636,6 @@ extern int odb_pack_keep(const char *name);
  */
 extern void check_pack_index_ptr(const struct packed_git *p, const void *ptr);
 
-/*
- * Return the SHA-1 of the nth object within the specified packfile.
- * Open the index if it is not already open.  The return value points
- * at the SHA-1 within the mmapped index.  Return NULL if there is an
- * error.
- */
-extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t n);
-/*
- * Like nth_packed_object_sha1, but write the data into the object specified by
- * the the first argument.  Returns the first argument on success, and NULL on
- * error.
- */
-extern const struct object_id *nth_packed_object_oid(struct object_id *, struct packed_git *, uint32_t n);
-
 /*
  * Return the offset of the nth object within the specified packfile.
  * The index must already be opened.
diff --git a/packfile.c b/packfile.c
index 624cc109e..e9b16da94 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1636,3 +1636,34 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 
 	return data;
 }
+
+const unsigned char *nth_packed_object_sha1(struct packed_git *p,
+					    uint32_t n)
+{
+	const unsigned char *index = p->index_data;
+	if (!index) {
+		if (open_pack_index(p))
+			return NULL;
+		index = p->index_data;
+	}
+	if (n >= p->num_objects)
+		return NULL;
+	index += 4 * 256;
+	if (p->index_version == 1) {
+		return index + 24 * n + 4;
+	} else {
+		index += 8;
+		return index + 20 * n;
+	}
+}
+
+const struct object_id *nth_packed_object_oid(struct object_id *oid,
+					      struct packed_git *p,
+					      uint32_t n)
+{
+	const unsigned char *hash = nth_packed_object_sha1(p, n);
+	if (!hash)
+		return NULL;
+	hashcpy(oid->hash, hash);
+	return oid;
+}
diff --git a/packfile.h b/packfile.h
index c28eaccc6..56d70caa0 100644
--- a/packfile.h
+++ b/packfile.h
@@ -63,6 +63,21 @@ extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
+/*
+ * Return the SHA-1 of the nth object within the specified packfile.
+ * Open the index if it is not already open.  The return value points
+ * at the SHA-1 within the mmapped index.  Return NULL if there is an
+ * error.
+ */
+extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t n);
+/*
+ * Like nth_packed_object_sha1, but write the data into the object specified by
+ * the the first argument.  Returns the first argument on success, and NULL on
+ * error.
+ */
+extern const struct object_id *nth_packed_object_oid(struct object_id *, struct packed_git *, uint32_t n);
+
+
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
@@ -79,5 +94,4 @@ extern int packed_object_info(struct packed_git *pack, off_t offset, struct obje
 
 extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
 extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
-
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index e537ba089..34fbe8e51 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1074,37 +1074,6 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
-const unsigned char *nth_packed_object_sha1(struct packed_git *p,
-					    uint32_t n)
-{
-	const unsigned char *index = p->index_data;
-	if (!index) {
-		if (open_pack_index(p))
-			return NULL;
-		index = p->index_data;
-	}
-	if (n >= p->num_objects)
-		return NULL;
-	index += 4 * 256;
-	if (p->index_version == 1) {
-		return index + 24 * n + 4;
-	} else {
-		index += 8;
-		return index + 20 * n;
-	}
-}
-
-const struct object_id *nth_packed_object_oid(struct object_id *oid,
-					      struct packed_git *p,
-					      uint32_t n)
-{
-	const unsigned char *hash = nth_packed_object_sha1(p, n);
-	if (!hash)
-		return NULL;
-	hashcpy(oid->hash, hash);
-	return oid;
-}
-
 void check_pack_index_ptr(const struct packed_git *p, const void *vptr)
 {
 	const unsigned char *ptr = vptr;
-- 
2.14.1.480.gb18f417b89-goog


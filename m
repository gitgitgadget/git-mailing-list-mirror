Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03664208B5
	for <e@80x24.org>; Wed,  9 Aug 2017 01:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbdHIBXa (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:23:30 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:38045 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752559AbdHIBXX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:23 -0400
Received: by mail-pg0-f42.google.com with SMTP id l64so21494251pge.5
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4JDGqtWuH9mXaMsXIrnJ+hHYadlrJK3fIyfq1o+pgo8=;
        b=pQtC0xmX/akIJLGnDrJQV3/XWkGY0JHzUIB8YxqPxM2NxkZWN/kR22HuWmUSLNGFXS
         iFBjx9gTmy0CKRnjQLC3TvtcovkkU+SOvN3C7f81VsQd9izFw4MzpcyGedkRrWrhpGWC
         Zs3RsBrelBkifJZVlDPg80xDNguxpbisgnjxvCdpYQO6A5fw3ehu/afVZd1l8fiadI5P
         dkWR4i5dOCUCcpXxam0lFsiYh/V/4qB0WVqpR7zZ/X4xl/4nZqLA6hPr21sZ4/QqlROq
         6y3W91lTBssZEko8gbz5WIG5gh9F3V8GaHVWptbrGucI3YHoZGcCKL0Ovu5jPkuxP36R
         7zsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4JDGqtWuH9mXaMsXIrnJ+hHYadlrJK3fIyfq1o+pgo8=;
        b=ERD4P3Dvdj8MQhaTNM3SVcOJZtGxEKK4x7AnSQ2fvWkOsWMsJKz/4HlAHnqM+i79W0
         PN8dNZ0ilSX69VN/fG1m/VHSBSJJfvhWES6Oo3P2BoO9OCnK4UPXCJ/VjTjJWPJ8al8/
         4HIPFgPUdT5YtrsZD+rHuQROVtKgNqvBcUqBKFG6Yxl00B9caW6xUgVExsMGRoDK4HZO
         N01hap3QrM6GywXyKPULtetMgtjofgt6EfH+Jc5SATNFYbrcI2wzg0UhCfjW6d4iY+Zo
         mFCPdH/Hi0w9JFjavuuPs7fZddk9Fgsf3SHmi9MsrZ+gBLkXPEKJnY4PsG1XZqVBHkg4
         wDmg==
X-Gm-Message-State: AHYfb5j90vljaOr4l9/7IKwgA7GhidiCVO/+t4+4He6kMMJhhR+SfFR1
        OA1nq3/yk4A+peiEbjkqeA==
X-Received: by 10.99.107.9 with SMTP id g9mr5829441pgc.147.1502241803023;
        Tue, 08 Aug 2017 18:23:23 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:22 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 18/25] pack: move nth_packed_object_{sha1,oid}
Date:   Tue,  8 Aug 2017 18:22:50 -0700
Message-Id: <ea143618a51a8286a425137a870a636be6d95a35.1502241234.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502241234.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1502241234.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     | 14 --------------
 pack.h      | 14 ++++++++++++++
 packfile.c  | 31 +++++++++++++++++++++++++++++++
 sha1_file.c | 31 -------------------------------
 4 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/cache.h b/cache.h
index b14098bf1..f083d532e 100644
--- a/cache.h
+++ b/cache.h
@@ -1628,20 +1628,6 @@ extern int odb_pack_keep(const char *name);
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
diff --git a/pack.h b/pack.h
index 2e6f357c3..023c97b37 100644
--- a/pack.h
+++ b/pack.h
@@ -182,4 +182,18 @@ extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsign
 extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
 extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
 
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
 #endif
diff --git a/packfile.c b/packfile.c
index a3745f9df..b16cf648a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1634,3 +1634,34 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 
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
diff --git a/sha1_file.c b/sha1_file.c
index fe7e0db76..4cd2b1809 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1073,37 +1073,6 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
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
2.14.0.434.g98096fd7a8-goog


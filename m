Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DB7C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DA91611C7
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351486AbhI3Njl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351661AbhI3Nj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 09:39:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC86C061775
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d6so10079587wrc.11
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I/ufrHjsdVvWwigEmMNMHptrIhfYfXRz47MbA15bDpM=;
        b=AbmmktqQj3AsH3elVgyrfSC8lYl9Tq5YUAXAMNy/S0TKf5G3Objx/ckXzWCqeyuZuO
         XlWX6GHD7fCDEf8H6Mm1bZqoPX9R6sSZ3Iu6vHMos10Dft1z1ciBetYV/1RabgmePVVH
         nNArPUE9yr9T2798T1E1Hf9rcidtCZS4s0oBzzH5n3pbpRGyXIBO36b7KvZba0W4tTFA
         UPZtNIaQAF/gdktsNyWx1fE8KAofcanA5zqwRaANQyKFR82sE1nRDbE4tMycIgJJ9X1S
         jOr08BlxcOqyIeNFCQCKPwrD4h6OQD8lEPjjCmf3MgeurYbSwL9nduTmq0XdQMnsSXJ3
         OlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I/ufrHjsdVvWwigEmMNMHptrIhfYfXRz47MbA15bDpM=;
        b=klRI6HGe6r8TaFVjRqR39revba8bE1dGYeL3uEIdOX1rJuDNK0RTP1pz+VLGdWRMOU
         wtnHAgwxMYThNH3bgyWkWTvbkoinWOimuOAC3clABufTuZ2iXAB7PlebYEf86+APx9cZ
         uSj7amz8wO/dYATg47uxtsLwIyjBsZcJknUleuwFx79Ji/T4BO9XjwcBarBnRbPuEMIC
         MdV4kojF6yM1fRdVkvKixTmP5fiDE8p3nZUikmHOfaUofni2gI//W6U3Fz873YZF7cwV
         1aLc5zLAp/hrCdbCcRDxwVBJSh0wELH5XblK8HErrZoBEEpq1Gqvr9vEmsqwEDVGew9/
         Ex1A==
X-Gm-Message-State: AOAM532UJivxl/dygyx13ENeijikHZmWxW+0quHwXDixZHV4GApQJr8i
        lVNU37fakI3dpguE70LWFSRZsblzk0f9vEXB
X-Google-Smtp-Source: ABdhPJzT+WAyvANsN0+Y3fHQiJUXjlJ2dvnHKOZsKQX3djJKIaCLxiN7dQ/nrUyCopZCGELcKR4U0g==
X-Received: by 2002:a05:6000:2c3:: with SMTP id o3mr6242306wry.76.1633009058921;
        Thu, 30 Sep 2021 06:37:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o11sm4654713wmh.11.2021.09.30.06.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:37:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 13/17] object-file.c: use "enum" return type for unpack_loose_header()
Date:   Thu, 30 Sep 2021 15:37:18 +0200
Message-Id: <patch-v9-13.17-eb7c949c8b7-20210930T133300Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.g05459a61530
In-Reply-To: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
References: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com> <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a preceding commit we changed and documented unpack_loose_header()
from its previous behavior of returning any negative value or zero, to
only -1 or 0.

Let's add an "enum unpack_loose_header_result" type and use it for
these return values, and have the compiler assert that we're
exhaustively covering all of them.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h       | 19 +++++++++++++++----
 object-file.c | 34 +++++++++++++++++++++-------------
 streaming.c   | 23 +++++++++++++----------
 3 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/cache.h b/cache.h
index d7189aed8fc..7239e20a625 100644
--- a/cache.h
+++ b/cache.h
@@ -1324,7 +1324,10 @@ int git_open_cloexec(const char *name, int flags);
  * unpack_loose_header() initializes the data stream needed to unpack
  * a loose object header.
  *
- * Returns 0 on success. Returns negative values on error.
+ * Returns:
+ *
+ * - ULHR_OK on success
+ * - ULHR_BAD on error
  *
  * It will only parse up to MAX_HEADER_LEN bytes unless an optional
  * "hdrbuf" argument is non-NULL. This is intended for use with
@@ -1332,9 +1335,17 @@ int git_open_cloexec(const char *name, int flags);
  * reporting. The full header will be extracted to "hdrbuf" for use
  * with parse_loose_header().
  */
-int unpack_loose_header(git_zstream *stream, unsigned char *map,
-			unsigned long mapsize, void *buffer,
-			unsigned long bufsiz, struct strbuf *hdrbuf);
+enum unpack_loose_header_result {
+	ULHR_OK,
+	ULHR_BAD,
+};
+enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
+						    unsigned char *map,
+						    unsigned long mapsize,
+						    void *buffer,
+						    unsigned long bufsiz,
+						    struct strbuf *hdrbuf);
+
 struct object_info;
 int parse_loose_header(const char *hdr, struct object_info *oi,
 		       unsigned int flags);
diff --git a/object-file.c b/object-file.c
index 1327872cbf4..e0f508415dd 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1255,10 +1255,12 @@ void *map_loose_object(struct repository *r,
 	return map_loose_object_1(r, NULL, oid, size);
 }
 
-int unpack_loose_header(git_zstream *stream,
-			unsigned char *map, unsigned long mapsize,
-			void *buffer, unsigned long bufsiz,
-			struct strbuf *header)
+enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
+						    unsigned char *map,
+						    unsigned long mapsize,
+						    void *buffer,
+						    unsigned long bufsiz,
+						    struct strbuf *header)
 {
 	int status;
 
@@ -1274,13 +1276,13 @@ int unpack_loose_header(git_zstream *stream,
 	status = git_inflate(stream, 0);
 	obj_read_lock();
 	if (status < Z_OK)
-		return -1;
+		return ULHR_BAD;
 
 	/*
 	 * Check if entire header is unpacked in the first iteration.
 	 */
 	if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
-		return 0;
+		return ULHR_OK;
 
 	/*
 	 * We have a header longer than MAX_HEADER_LEN. The "header"
@@ -1288,7 +1290,7 @@ int unpack_loose_header(git_zstream *stream,
 	 * --allow-unknown-type".
 	 */
 	if (!header)
-		return -1;
+		return ULHR_BAD;
 
 	/*
 	 * buffer[0..bufsiz] was not large enough.  Copy the partial
@@ -1309,7 +1311,7 @@ int unpack_loose_header(git_zstream *stream,
 		stream->next_out = buffer;
 		stream->avail_out = bufsiz;
 	} while (status != Z_STREAM_END);
-	return -1;
+	return ULHR_BAD;
 }
 
 static void *unpack_loose_rest(git_zstream *stream,
@@ -1474,13 +1476,19 @@ static int loose_object_info(struct repository *r,
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
 
-	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
-				allow_unknown ? &hdrbuf : NULL) < 0)
+	switch (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
+				    allow_unknown ? &hdrbuf : NULL)) {
+	case ULHR_OK:
+		break;
+	case ULHR_BAD:
 		status = error(_("unable to unpack %s header"),
 			       oid_to_hex(oid));
-	if (status < 0)
-		; /* Do nothing */
-	else if (hdrbuf.len) {
+		break;
+	}
+
+	if (status < 0) {
+		/* Do nothing */
+	} else if (hdrbuf.len) {
 		if ((status = parse_loose_header(hdrbuf.buf, oi, flags)) < 0)
 			status = error(_("unable to parse %s header with --allow-unknown-type"),
 				       oid_to_hex(oid));
diff --git a/streaming.c b/streaming.c
index cb3c3cf6ff6..6df0247a4cb 100644
--- a/streaming.c
+++ b/streaming.c
@@ -229,17 +229,16 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 	st->u.loose.mapped = map_loose_object(r, oid, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
 		return -1;
-	if ((unpack_loose_header(&st->z,
-				 st->u.loose.mapped,
-				 st->u.loose.mapsize,
-				 st->u.loose.hdr,
-				 sizeof(st->u.loose.hdr),
-				 NULL) < 0) ||
-	    (parse_loose_header(st->u.loose.hdr, &oi, 0) < 0)) {
-		git_inflate_end(&st->z);
-		munmap(st->u.loose.mapped, st->u.loose.mapsize);
-		return -1;
+	switch (unpack_loose_header(&st->z, st->u.loose.mapped,
+				    st->u.loose.mapsize, st->u.loose.hdr,
+				    sizeof(st->u.loose.hdr), NULL)) {
+	case ULHR_OK:
+		break;
+	case ULHR_BAD:
+		goto error;
 	}
+	if (parse_loose_header(st->u.loose.hdr, &oi, 0) < 0)
+		goto error;
 
 	st->u.loose.hdr_used = strlen(st->u.loose.hdr) + 1;
 	st->u.loose.hdr_avail = st->z.total_out;
@@ -248,6 +247,10 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 	st->read = read_istream_loose;
 
 	return 0;
+error:
+	git_inflate_end(&st->z);
+	munmap(st->u.loose.mapped, st->u.loose.mapsize);
+	return -1;
 }
 
 
-- 
2.33.0.1374.g05459a61530


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70A5C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD76611ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbhETM12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbhETM0w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:26:52 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343B3C0AF7BC
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:26 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w12so11189036edx.1
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tlbvbX2iLXerpoyY+8TzkQgj47ePtOp5uXVOwnSIBXA=;
        b=tlGXSCJ2UU9OkO+EbSSrIRT8v93CeN5YYBn9HKK0LOUVDBC/o9SyOxou9uhjETFttm
         dqYGlgH1tOj1IHzRWmv0puZ7snitGPQyEruO1VPNxJzS+9VLRggGD4bJGQOwTn9GZWLa
         Vk1RSiWQgp7fsRCEQLJSG1ytKTpAJrugN0v1NV+6MnpeHvdoDeqX8usF0gbcl7PicEwE
         tbCntoZYSBdNsntczcLCGXrB+ylwex5NYWNp4a0FJElNZzHLAHsH1HXKpjENkmoVIrk3
         tq0PlEDKhL+jVNe1pc0GjXLswRYf2S9zqmTiy4EOcrQqQ+Pu/uJsefi4Lo3mJ5Zi5mnM
         f5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tlbvbX2iLXerpoyY+8TzkQgj47ePtOp5uXVOwnSIBXA=;
        b=nrHQ/ZRzvPTw2hrOfJbcHRMmLNu4r4CULnG13qvdJCYljiNy2lUTXag9dmKjGEU2Ve
         eve0t+xN9CDyVMYM0NVxG1d3gc2MEQJ/BNHFHfz0XiOatsvJbq4EyyzoL4zKgB+FQb1O
         04VjHyNyZDsHUPyts0vZhHIVD7b9oDkVxZHeGYVAdkHSCi16Ns8dYSxPrg9NbLPkPzhI
         dH8bRMlaUSshtgwUXMohdx4ryeKaPFT1tbFvyksHncL9H5HqlR6YUeHD+wd3+4rz3ViY
         Dm2+cFog7YEDQIbP2X+pxYeo+a5vkdP01MwZ04waA3usWS6ef+VjSYw4xudBDVlYG+fb
         9Hnw==
X-Gm-Message-State: AOAM530C2hP6b3EY8sgIgft12zWpBYPZNup0BCbj3NMXSo9wHHWV0zb2
        bizHB2E013kC2Vcv/p+kGmw9EUhqx184Dw==
X-Google-Smtp-Source: ABdhPJw8Yxuez4qoWv5n5oeo86dZs1Y++fX9KQu7p2roTxctH05+wUFqmyFfWrVfHUokarbyYF3l3g==
X-Received: by 2002:aa7:d844:: with SMTP id f4mr4315417eds.203.1621509804105;
        Thu, 20 May 2021 04:23:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jy21sm1243273ejc.13.2021.05.20.04.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:23:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 11/17] object-file.c: stop dying in parse_loose_header()
Date:   Thu, 20 May 2021 13:23:05 +0200
Message-Id: <patch-11.17-ee28089219-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g73369325f8d
In-Reply-To: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com> <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Start the libification of parse_loose_header() by making it return
error codes and data instead of invoking die() by itself. For now
we'll move the relevant die() call to loose_object_info() and
read_loose_object() to keep this change smaller, but in subsequent
commits we'll also libify those.

The reason this makes sense is that with the refactoring of
parse_loose_header_extended() in an earlier commit the public
interface for parse_loose_header() no longer just accepts a "unsigned
long *sizep". Rather it accepts a "struct object_info *", that
structure will be populated with information about the object.

It thus makes sense to further libify the interface so that it stops
calling die() when it encounters OBJ_BAD, and instead rely on its
callers to check the populated "oi->typep".

This also allows us to simplify away the
unpack_loose_header_to_strbuf() function added in
46f034483eb (sha1_file: support reading from a loose object of unknown
type, 2015-05-03). Its code was mostly copy/pasted between it and both
of unpack_loose_header() and unpack_loose_short_header(). We now have
a single unpack_loose_header() function which accepts an optional
"struct strbuf *" instead.

I think the remaining unpack_loose_header() function could be further
simplified, we're carrying some complexity just to be able to emit a
garbage type longer than MAX_HEADER_LEN, we could alternatively just
say "we found a garbage type <first 32 bytes>..." instead, but let's
leave this in place for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c  | 105 ++++++++++++++++++++-----------------------------
 object-store.h |  25 ++++++++++--
 streaming.c    |   7 +++-
 3 files changed, 70 insertions(+), 67 deletions(-)

diff --git a/object-file.c b/object-file.c
index 115054389c..d4bdf86657 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1210,11 +1210,12 @@ void *map_loose_object(struct repository *r,
 	return map_loose_object_1(r, NULL, oid, size);
 }
 
-static int unpack_loose_short_header(git_zstream *stream,
-				     unsigned char *map, unsigned long mapsize,
-				     void *buffer, unsigned long bufsiz)
+int unpack_loose_header(git_zstream *stream,
+			unsigned char *map, unsigned long mapsize,
+			void *buffer, unsigned long bufsiz,
+			struct strbuf *header)
 {
-	int ret;
+	int status;
 
 	/* Get the data stream */
 	memset(stream, 0, sizeof(*stream));
@@ -1225,44 +1226,25 @@ static int unpack_loose_short_header(git_zstream *stream,
 
 	git_inflate_init(stream);
 	obj_read_unlock();
-	ret = git_inflate(stream, 0);
+	status = git_inflate(stream, 0);
 	obj_read_lock();
-
-	return ret;
-}
-
-int unpack_loose_header(git_zstream *stream,
-			unsigned char *map, unsigned long mapsize,
-			void *buffer, unsigned long bufsiz)
-{
-	int status = unpack_loose_short_header(stream, map, mapsize,
-					       buffer, bufsiz);
-
 	if (status < Z_OK)
 		return status;
 
-	/* Make sure we have the terminating NUL */
-	if (!memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
-		return -1;
-	return 0;
-}
-
-static int unpack_loose_header_to_strbuf(git_zstream *stream, unsigned char *map,
-					 unsigned long mapsize, void *buffer,
-					 unsigned long bufsiz, struct strbuf *header)
-{
-	int status;
-
-	status = unpack_loose_short_header(stream, map, mapsize, buffer, bufsiz);
-	if (status < Z_OK)
-		return -1;
-
 	/*
 	 * Check if entire header is unpacked in the first iteration.
 	 */
 	if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
 		return 0;
 
+	/*
+	 * We have a header longer than MAX_HEADER_LEN. We abort early
+	 * unless under we're running as e.g. "cat-file
+	 * --allow-unknown-type".
+	 */
+	if (!header)
+		return -1;
+
 	/*
 	 * buffer[0..bufsiz] was not large enough.  Copy the partial
 	 * result out to header, and then append the result of further
@@ -1340,9 +1322,7 @@ static void *unpack_loose_rest(git_zstream *stream,
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-int parse_loose_header(const char *hdr,
-		       struct object_info *oi,
-		       unsigned int flags)
+int parse_loose_header(const char *hdr, struct object_info *oi)
 {
 	const char *type_buf = hdr;
 	unsigned long size;
@@ -1364,15 +1344,6 @@ int parse_loose_header(const char *hdr,
 	type = type_from_string_gently(type_buf, type_len, 1);
 	if (oi->type_name)
 		strbuf_add(oi->type_name, type_buf, type_len);
-	/*
-	 * Set type to 0 if its an unknown object and
-	 * we're obtaining the type using '--allow-unknown-type'
-	 * option.
-	 */
-	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE) && (type < 0))
-		type = 0;
-	else if (type < 0)
-		die(_("invalid object type"));
 	if (oi->typep)
 		*oi->typep = type;
 
@@ -1399,7 +1370,14 @@ int parse_loose_header(const char *hdr,
 	/*
 	 * The length must be followed by a zero byte
 	 */
-	return *hdr ? -1 : type;
+	if (*hdr)
+		return -1;
+
+	/*
+	 * The format is valid, but the type may still be bogus. The
+	 * Caller needs to check its oi->typep.
+	 */
+	return 0;
 }
 
 static int loose_object_info(struct repository *r,
@@ -1410,9 +1388,12 @@ static int loose_object_info(struct repository *r,
 	unsigned long mapsize;
 	void *map;
 	git_zstream stream;
+	int hdr_ret;
 	char hdr[MAX_HEADER_LEN];
 	struct strbuf hdrbuf = STRBUF_INIT;
 	unsigned long size_scratch;
+	enum object_type type_scratch;
+	int allow_unknown = flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 
 	if (oi->delta_base_oid)
 		oidclr(oi->delta_base_oid);
@@ -1443,27 +1424,23 @@ static int loose_object_info(struct repository *r,
 
 	if (!oi->sizep)
 		oi->sizep = &size_scratch;
+	if (!oi->typep)
+		oi->typep = &type_scratch;
 
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
-	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE)) {
-		if (unpack_loose_header_to_strbuf(&stream, map, mapsize, hdr, sizeof(hdr), &hdrbuf) < 0)
-			status = error(_("unable to unpack %s header with --allow-unknown-type"),
-				       oid_to_hex(oid));
-	} else if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0) {
+
+	hdr_ret = unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
+				      allow_unknown ? &hdrbuf : NULL);
+	if (hdr_ret < 0) {
 		status = error(_("unable to unpack %s header"),
 			       oid_to_hex(oid));
 	}
-
-	if (status < 0) {
-		/* Do nothing */
-	} else if (hdrbuf.len) {
-		if ((status = parse_loose_header(hdrbuf.buf, oi, flags)) < 0)
-			status = error(_("unable to parse %s header with --allow-unknown-type"),
-				       oid_to_hex(oid));
-	} else if ((status = parse_loose_header(hdr, oi, flags)) < 0) {
+	if (!status && parse_loose_header(hdrbuf.len ? hdrbuf.buf : hdr, oi) < 0) {
 		status = error(_("unable to parse %s header"), oid_to_hex(oid));
 	}
+	if (!allow_unknown && *oi->typep < 0)
+		die(_("invalid object type"));
 
 	if (status >= 0 && oi->contentp) {
 		*oi->contentp = unpack_loose_rest(&stream, hdr,
@@ -1481,7 +1458,8 @@ static int loose_object_info(struct repository *r,
 		*oi->typep = status;
 	if (oi->sizep == &size_scratch)
 		oi->sizep = NULL;
-	strbuf_release(&hdrbuf);
+	if (oi->typep == &type_scratch)
+		oi->typep = NULL;
 	oi->whence = OI_LOOSE;
 	return (status < 0) ? status : 0;
 }
@@ -2547,6 +2525,7 @@ int read_loose_object(const char *path,
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
 	struct object_info oi = OBJECT_INFO_INIT;
+	oi.typep = type;
 	oi.sizep = size;
 
 	*contents = NULL;
@@ -2557,17 +2536,19 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0) {
+	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
+				NULL) < 0) {
 		error(_("unable to unpack header of %s"), path);
 		goto out;
 	}
 
-	*type = parse_loose_header(hdr, &oi, 0);
-	if (*type < 0) {
+	if (parse_loose_header(hdr, &oi) < 0) {
 		error(_("unable to parse header of %s"), path);
 		git_inflate_end(&stream);
 		goto out;
 	}
+	if (*type < 0)
+		die(_("invalid object type"));
 
 	if (*type == OBJ_BLOB && *size > big_file_threshold) {
 		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)
diff --git a/object-store.h b/object-store.h
index d443964447..740edcac30 100644
--- a/object-store.h
+++ b/object-store.h
@@ -477,11 +477,30 @@ int for_each_object_in_pack(struct packed_git *p,
 int for_each_packed_object(each_packed_object_fn, void *,
 			   enum for_each_object_flags flags);
 
+/**
+ * unpack_loose_header() initializes the data stream needed to unpack
+ * a loose object header.
+ *
+ * Returns 0 on success. Returns negative values on error.
+ *
+ * It will only parse up to MAX_HEADER_LEN bytes unless an optional
+ * "hdrbuf" argument is non-NULL. This is intended for use with
+ * OBJECT_INFO_ALLOW_UNKNOWN_TYPE to extract the bad type for (error)
+ * reporting. The full header will be extracted to "hdrbuf" for use
+ * with parse_loose_header().
+ */
 int unpack_loose_header(git_zstream *stream, unsigned char *map,
 			unsigned long mapsize, void *buffer,
-			unsigned long bufsiz);
-int parse_loose_header(const char *hdr, struct object_info *oi,
-		       unsigned int flags);
+			unsigned long bufsiz, struct strbuf *hdrbuf);
+
+/**
+ * parse_loose_header() parses the starting "<type> <len>\0" of an
+ * object. If it doesn't follow that format -1 is returned. To check
+ * the validity of the <type> populate the "typep" in the "struct
+ * object_info". It will be OBJ_BAD if the object type is unknown.
+ */
+int parse_loose_header(const char *hdr, struct object_info *oi);
+
 int check_object_signature(struct repository *r, const struct object_id *oid,
 			   void *buf, unsigned long size, const char *type);
 int finalize_object_file(const char *tmpfile, const char *filename);
diff --git a/streaming.c b/streaming.c
index 8beac62cbb..c3dc241d6a 100644
--- a/streaming.c
+++ b/streaming.c
@@ -225,6 +225,7 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 	oi.sizep = &st->size;
+	oi.typep = type;
 
 	st->u.loose.mapped = map_loose_object(r, oid, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
@@ -233,8 +234,10 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 				 st->u.loose.mapped,
 				 st->u.loose.mapsize,
 				 st->u.loose.hdr,
-				 sizeof(st->u.loose.hdr)) < 0) ||
-	    (parse_loose_header(st->u.loose.hdr, &oi, 0) < 0)) {
+				 sizeof(st->u.loose.hdr),
+				 NULL) < 0) ||
+	    (parse_loose_header(st->u.loose.hdr, &oi) < 0) ||
+	    *type < 0) {
 		git_inflate_end(&st->z);
 		munmap(st->u.loose.mapped, st->u.loose.mapsize);
 		return -1;
-- 
2.32.0.rc0.406.g73369325f8d


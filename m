Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4432C07E9B
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A41576135E
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhGJNke (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 09:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhGJNk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 09:40:26 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FD0C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k16-20020a05600c1c90b02901f4ed0fcfe7so8054565wms.5
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L5H4hFaSm9UsltCDDCgD6keWG6HJ+dGf9zSZhGWm27o=;
        b=iGkTeIpwygGWEErWwqgPnwX5aH/3pipEBJ3RYGZkxz5TSafXvjh1oBrn8uinDyrCLJ
         7coQYpjDDxpcFaH12BE9fOvR7u1/2XnzpL8Dq5SNLoqliJkljG8IR9nJ1ukAxoPc7n/o
         PnZpY+JDKH/EL9aRcRGN2IWKyHk2cUmeNy7WwQfbw7H8VpUVJ4+EDkTygZ7tclcMZtkF
         dkrkNmAhlUBKNyi3ouOrK+ccAh3dg6cL+pwh1//3CgjqVG8Cj/mK047i/SaICJKmqB5V
         wL56x69CUyTRvI2z5XmVjWVlJpSJxQOSoMw034pYskL9IT4qwS8B7aqTTyEtgU3R18y7
         yr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L5H4hFaSm9UsltCDDCgD6keWG6HJ+dGf9zSZhGWm27o=;
        b=phsftaKlHLkBSXFt6SbEjKqULZ57y2gTVVjAOokmBtVSIG5l/UlvlMfG/qE6YixeZP
         wJdjg+6ShinRDke4Tu1AHghX0MS7IfdNiasFHEKWr0V2kniRDlXTutI2KoC80+1u1ATq
         ZTcuzeDJ+kE1HtFcQ0ha4eNr2jaQmGqT3LbhIIFYMPpl5iVwTLlnTONdbymQFfIIk9Nf
         Wugia+fjmCd7XtXTW4+iUXZQvqRx3buhIrJ+g0k1cRq8bDjRLFUtm2ssfPPlLMGNACUm
         pmUa2Pvc6GC+QXO6PsYBl7QBOl6iaRxm8bpNAzJd0gnsae+jmyPn0hJqrO+wE46Hmeez
         v45g==
X-Gm-Message-State: AOAM531ozjxd/73hSv9DBKDyI1jy4AzFefjZ5iHCmOm3+4v7rkJe58Rl
        4bPVOss0ooJaKPsH/oyNhA8HX+OnNr4qUw==
X-Google-Smtp-Source: ABdhPJyQQsxA/5UOJUep121MOIPfEKlip+KW+fd6kAuQ3E53UHQqucG86MExoT0p+2R+z8V9wmIs+Q==
X-Received: by 2002:a7b:ca43:: with SMTP id m3mr45167512wml.74.1625924259309;
        Sat, 10 Jul 2021 06:37:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm17612787wmq.9.2021.07.10.06.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 06:37:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 12/21] object-file.c: simplify unpack_loose_short_header()
Date:   Sat, 10 Jul 2021 15:37:15 +0200
Message-Id: <patch-12.21-dae5cfabd57-20210710T133203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com> <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Combine the unpack_loose_short_header(),
unpack_loose_header_to_strbuf() and unpack_loose_header() functions
into one.

The unpack_loose_header_to_strbuf() function was added in
46f034483eb (sha1_file: support reading from a loose object of unknown
type, 2015-05-03).

Its code was mostly copy/pasted between it and both of
unpack_loose_header() and unpack_loose_short_header(). We now have a
single unpack_loose_header() function which accepts an optional
"struct strbuf *" instead.

I think the remaining unpack_loose_header() function could be further
simplified, we're carrying some complexity just to be able to emit a
garbage type longer than MAX_HEADER_LEN, we could alternatively just
say "we found a garbage type <first 32 bytes>..." instead. But let's
leave the current behavior in place for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c  | 60 ++++++++++++++++++--------------------------------
 object-store.h | 14 +++++++++++-
 streaming.c    |  3 ++-
 3 files changed, 37 insertions(+), 40 deletions(-)

diff --git a/object-file.c b/object-file.c
index 646ca7f85d6..ef3a1517fed 100644
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
+	 * We have a header longer than MAX_HEADER_LEN. The "header"
+	 * here is only non-NULL when we run "cat-file
+	 * --allow-unknown-type".
+	 */
+	if (!header)
+		return -1;
+
 	/*
 	 * buffer[0..bufsiz] was not large enough.  Copy the partial
 	 * result out to header, and then append the result of further
@@ -1410,9 +1392,11 @@ static int loose_object_info(struct repository *r,
 	unsigned long mapsize;
 	void *map;
 	git_zstream stream;
+	int hdr_ret;
 	char hdr[MAX_HEADER_LEN];
 	struct strbuf hdrbuf = STRBUF_INIT;
 	unsigned long size_scratch;
+	int allow_unknown = flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 
 	if (oi->delta_base_oid)
 		oidclr(oi->delta_base_oid);
@@ -1446,11 +1430,10 @@ static int loose_object_info(struct repository *r,
 
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
@@ -2555,7 +2538,8 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0) {
+	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
+				NULL) < 0) {
 		error(_("unable to unpack header of %s"), path);
 		goto out;
 	}
diff --git a/object-store.h b/object-store.h
index d443964447c..31327a7f6c3 100644
--- a/object-store.h
+++ b/object-store.h
@@ -477,9 +477,21 @@ int for_each_object_in_pack(struct packed_git *p,
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
+			unsigned long bufsiz, struct strbuf *hdrbuf);
 int parse_loose_header(const char *hdr, struct object_info *oi,
 		       unsigned int flags);
 int check_object_signature(struct repository *r, const struct object_id *oid,
diff --git a/streaming.c b/streaming.c
index 8beac62cbb7..cb3c3cf6ff6 100644
--- a/streaming.c
+++ b/streaming.c
@@ -233,7 +233,8 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 				 st->u.loose.mapped,
 				 st->u.loose.mapsize,
 				 st->u.loose.hdr,
-				 sizeof(st->u.loose.hdr)) < 0) ||
+				 sizeof(st->u.loose.hdr),
+				 NULL) < 0) ||
 	    (parse_loose_header(st->u.loose.hdr, &oi, 0) < 0)) {
 		git_inflate_end(&st->z);
 		munmap(st->u.loose.mapped, st->u.loose.mapsize);
-- 
2.32.0.636.g43e71d69cff


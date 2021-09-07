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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D473DC433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF17860E52
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343941AbhIGLAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 07:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343848AbhIGK7u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:50 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6A5C0612A6
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:42 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i3so6502567wmq.3
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k/byc6j7Bpgd+6guaK79Q+lG8HWsTzOjCAUjuk1pnlg=;
        b=Xsbd4PLCA5kdZQg7xzxo5+NpDOia9Ak+G1IqENUX51w77tMT03nuaIIblvPj8OFoge
         AQzOHuaGJORN8V09E97qC0L5LBgT8xwB+z80ILJn9O9oq7zUatmWH8kArc/hNhPtRP0N
         r/sc7baqZwqAaDuMvK8BAZ0sUieuBm/LFmVIBn06nllde4TOBFCY3kgqZOmxaPh+Fz8Y
         gkFSU5oyijmWMCutrJY2vWdVLSLk+TrXPykYqRz9nGNB0CN1+oBlBsh/JNvBaC/rBQGG
         fPJZy/6eZ3GOGQHejaoygpbetPIo9DqiBIf8K5JXLTfpDH3kI7fLe+qQYcansT1hvE3b
         XkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k/byc6j7Bpgd+6guaK79Q+lG8HWsTzOjCAUjuk1pnlg=;
        b=tskhBs7SLMcaY7Q/oSRi6vfguPuWe4MpSAl7qiVCrzGXhc1wCKdvJxsAcxVg9bX7SK
         4T+uaiF2FRPTOUqhIkmndQAHqAAo6CRoo2AbccZVrhPxp4076qSEhe3e6/5J1OI3rfD+
         i7PjXKORt37iJLYOLhc/jYjS9RVuOw166AjEXB0MryyzHSVTlQWHdGVRi5rzIpRzjuvI
         2W04tT1l+Df/IbhGF2qlFNdXlPzHuQ54iemIhX5KTBiS7f9Xe4XMvwlMVAu1WzP3UPCj
         WPf+LmvYkxzbIABOswrhz3AcCv8OoYejjqxvIB6hieaGQPiW6WYxsrYji9iwuYQUZFb9
         ZD6w==
X-Gm-Message-State: AOAM531+aLYRNUueA4ltruR3t6P8AX2zIGt9VvcwJIlVKcutWWkhdCZk
        lyDrgTN4jW3RKpNtzVgM9xaCVXrvfPdKZQ==
X-Google-Smtp-Source: ABdhPJykgtbgpssOwqLxjx3WXjQdJYd95CYiNKhPZJn0/PrUEO5JwHd0kKmoI/VKey6+02sTEcJlFg==
X-Received: by 2002:a05:600c:2114:: with SMTP id u20mr3362904wml.65.1631012320750;
        Tue, 07 Sep 2021 03:58:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 18/22] object-file.c: use "enum" return type for unpack_loose_header()
Date:   Tue,  7 Sep 2021 12:58:13 +0200
Message-Id: <patch-v6-18.22-1b7173a5b5b-20210907T104559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com> <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commits we changed and documented
unpack_loose_header() from return any negative value or zero, to only
-2, -1 or 0. Let's instead add an "enum unpack_loose_header_result"
type and use it, and have the compiler assert that we're exhaustively
covering all return values. This gets rid of the need for having a
"default" BUG() case in loose_object_info().

I'm on the fence about whether this is more readable or worth it, but
since it was suggested in [1] to do this let's go for it.

1. https://lore.kernel.org/git/20210527175433.2673306-1-jonathantanmy@google.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c  | 20 ++++++++++----------
 object-store.h | 27 ++++++++++++++++++++-------
 streaming.c    | 27 ++++++++++++++++-----------
 3 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/object-file.c b/object-file.c
index 0cb5287d3ef..9484c7ce2be 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1233,10 +1233,12 @@ void *map_loose_object(struct repository *r,
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
 
@@ -1411,7 +1413,7 @@ static int loose_object_info(struct repository *r,
 	unsigned long mapsize;
 	void *map;
 	git_zstream stream;
-	int hdr_ret;
+	enum unpack_loose_header_result hdr_ret;
 	char hdr[MAX_HEADER_LEN];
 	struct strbuf hdrbuf = STRBUF_INIT;
 	unsigned long size_scratch;
@@ -1457,18 +1459,16 @@ static int loose_object_info(struct repository *r,
 	hdr_ret = unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
 				      allow_unknown ? &hdrbuf : NULL);
 	switch (hdr_ret) {
-	case 0:
+	case UNPACK_LOOSE_HEADER_RESULT_OK:
 		break;
-	case -1:
+	case UNPACK_LOOSE_HEADER_RESULT_BAD:
 		status = error(_("unable to unpack %s header"),
 			       oid_to_hex(oid));
 		break;
-	case -2:
+	case UNPACK_LOOSE_HEADER_RESULT_BAD_TOO_LONG:
 		status = error(_("header for %s too long, exceeds %d bytes"),
 			       oid_to_hex(oid), MAX_HEADER_LEN);
 		break;
-	default:
-		BUG("unknown hdr_ret value %d", hdr_ret);
 	}
 	if (!status) {
 		if (!parse_loose_header(hdrbuf.len ? hdrbuf.buf : hdr, oi))
diff --git a/object-store.h b/object-store.h
index e896b813f24..ac55b02f15a 100644
--- a/object-store.h
+++ b/object-store.h
@@ -485,23 +485,36 @@ int for_each_object_in_pack(struct packed_git *p,
 int for_each_packed_object(each_packed_object_fn, void *,
 			   enum for_each_object_flags flags);
 
+enum unpack_loose_header_result {
+	UNPACK_LOOSE_HEADER_RESULT_BAD_TOO_LONG = -2,
+	UNPACK_LOOSE_HEADER_RESULT_BAD = -1,
+	UNPACK_LOOSE_HEADER_RESULT_OK,
+
+};
+
 /**
  * unpack_loose_header() initializes the data stream needed to unpack
  * a loose object header.
  *
- * Returns 0 on success. Returns negative values on error. If the
- * header exceeds MAX_HEADER_LEN -2 will be returned.
+ * Returns UNPACK_LOOSE_HEADER_RESULT_OK on success. Returns
+ * UNPACK_LOOSE_HEADER_RESULT_BAD values on error, or if the header
+ * exceeds MAX_HEADER_LEN UNPACK_LOOSE_HEADER_RESULT_BAD_TOO_LONG will
+ * be returned.
  *
  * It will only parse up to MAX_HEADER_LEN bytes unless an optional
  * "hdrbuf" argument is non-NULL. This is intended for use with
  * OBJECT_INFO_ALLOW_UNKNOWN_TYPE to extract the bad type for (error)
  * reporting. The full header will be extracted to "hdrbuf" for use
- * with parse_loose_header(), -2 will still be returned from this
- * function to indicate that the header was too long.
+ * with parse_loose_header(), UNPACK_LOOSE_HEADER_RESULT_BAD_TOO_LONG
+ * will still be returned from this function to indicate that the
+ * header was too long.
  */
-int unpack_loose_header(git_zstream *stream, unsigned char *map,
-			unsigned long mapsize, void *buffer,
-			unsigned long bufsiz, struct strbuf *hdrbuf);
+enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
+						    unsigned char *map,
+						    unsigned long mapsize,
+						    void *buffer,
+						    unsigned long bufsiz,
+						    struct strbuf *hdrbuf);
 
 /**
  * parse_loose_header() parses the starting "<type> <len>\0" of an
diff --git a/streaming.c b/streaming.c
index c3dc241d6a5..3e5045c004d 100644
--- a/streaming.c
+++ b/streaming.c
@@ -224,24 +224,25 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 			      enum object_type *type)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
+	enum unpack_loose_header_result hdr_ret;
 	oi.sizep = &st->size;
 	oi.typep = type;
 
 	st->u.loose.mapped = map_loose_object(r, oid, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
 		return -1;
-	if ((unpack_loose_header(&st->z,
-				 st->u.loose.mapped,
-				 st->u.loose.mapsize,
-				 st->u.loose.hdr,
-				 sizeof(st->u.loose.hdr),
-				 NULL) < 0) ||
-	    (parse_loose_header(st->u.loose.hdr, &oi) < 0) ||
-	    *type < 0) {
-		git_inflate_end(&st->z);
-		munmap(st->u.loose.mapped, st->u.loose.mapsize);
-		return -1;
+	hdr_ret = unpack_loose_header(&st->z, st->u.loose.mapped,
+				      st->u.loose.mapsize, st->u.loose.hdr,
+				      sizeof(st->u.loose.hdr), NULL);
+	switch (hdr_ret) {
+	case UNPACK_LOOSE_HEADER_RESULT_OK:
+		break;
+	case UNPACK_LOOSE_HEADER_RESULT_BAD:
+	case UNPACK_LOOSE_HEADER_RESULT_BAD_TOO_LONG:
+		goto error;
 	}
+	if (parse_loose_header(st->u.loose.hdr, &oi) < 0 || *type < 0)
+		goto error;
 
 	st->u.loose.hdr_used = strlen(st->u.loose.hdr) + 1;
 	st->u.loose.hdr_avail = st->z.total_out;
@@ -250,6 +251,10 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 	st->read = read_istream_loose;
 
 	return 0;
+error:
+	git_inflate_end(&st->z);
+	munmap(st->u.loose.mapped, st->u.loose.mapsize);
+	return -1;
 }
 
 
-- 
2.33.0.815.g21c7aaf6073


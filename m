Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96219C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E0760E9B
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349420AbhIUDAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349465AbhIUC0k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:26:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A792C1E3A4D
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t8so25606613wri.1
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+7ySqHFXMX8wu3pEPJ8kINGE2FfV+eNQZ1IXAeboVH8=;
        b=fGfxffl878swgsHTBpnT/LvS2/cCrVmaxlbBtr8TDGjlZ8W6NJ+0C7TNT2UQeMnowQ
         lKLTMa9TrrtYz3KsRvDLnYGax8aA5I7ct+tteWeIjd/l5e2BUI8ub9rUdBlneV1oW/Gn
         GN4yggwzmFWgtJWtPnTCZAoH7ZPzKx/EzYO1K8PQmGGbcNcBdgnMEzi22drvGKPxbCFP
         s+mwM6TUKghjMJUZnhXXLxoWAJ43gbHnkZMi1wzmfTSiTjeP857RMo+hukj/6Vi8qaWk
         BlA1tvFe5MbxXbkFii1qu1TqHfuw8SY42hBx3YJqKcaYBTp7nMzPwl5EE1XUGtpDU34N
         shzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+7ySqHFXMX8wu3pEPJ8kINGE2FfV+eNQZ1IXAeboVH8=;
        b=evWkZoacE3OeRIPGP24YAB5/2y2jXSuWhddsCENY6TugrEH435r3bzJlG9affmVB2F
         FrsNHgi9nDQCdInA5w7+s7XKHOhhnb5VfXpkZCvHIX5GUsT5RSrKb0vXJk4uXYNeJR8Q
         R1josZnOq89+d4BOc8+1IZewVy6xsyEo5s8Redd9VxaQGg0Yyl/mo/JCkiqQCaepHtHa
         qFdwpUGljUJSPP5uoJcSrGDCsAJGIXfXsLUkkiOWOqSeovv0bYSOrfhRjkiEx68mEsOD
         0wwbSXklUFeeS1kATjmkleF0nBZc63yiVTC7xN3gVQApUUHpelsOskMwjIue5GIM9s5p
         FN0Q==
X-Gm-Message-State: AOAM533HyJPHILLw3uEcCGN3ohrT4B4dPMVECmzTGfz+Z1rMiCH2q3oj
        yv9D5zYcMFJEA1OTZNNHAAdTC4K8i77M3A==
X-Google-Smtp-Source: ABdhPJze3PEl/Gfex/9VLYamqEXVastwV1Mx94TVxjQkM/bm5ufJGPInD/YcZ8yuZn7uhAtyOZdmGA==
X-Received: by 2002:a1c:7413:: with SMTP id p19mr632432wmc.98.1632164677435;
        Mon, 20 Sep 2021 12:04:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm8157772wrg.60.2021.09.20.12.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:04:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 13/17] object-file.c: use "enum" return type for unpack_loose_header()
Date:   Mon, 20 Sep 2021 21:04:17 +0200
Message-Id: <patch-v7-13.17-755fde00b46-20210920T190305Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.g29a6526ae47
In-Reply-To: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
References: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
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
index 9ad81d452ad..90dde86828e 100644
--- a/cache.h
+++ b/cache.h
@@ -1318,7 +1318,10 @@ int git_open_cloexec(const char *name, int flags);
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
@@ -1326,9 +1329,17 @@ int git_open_cloexec(const char *name, int flags);
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
index 8dd35f768bb..b214a152ca8 100644
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
 
@@ -1252,13 +1254,13 @@ int unpack_loose_header(git_zstream *stream,
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
@@ -1266,7 +1268,7 @@ int unpack_loose_header(git_zstream *stream,
 	 * --allow-unknown-type".
 	 */
 	if (!header)
-		return -1;
+		return ULHR_BAD;
 
 	/*
 	 * buffer[0..bufsiz] was not large enough.  Copy the partial
@@ -1287,7 +1289,7 @@ int unpack_loose_header(git_zstream *stream,
 		stream->next_out = buffer;
 		stream->avail_out = bufsiz;
 	} while (status != Z_STREAM_END);
-	return -1;
+	return ULHR_BAD;
 }
 
 static void *unpack_loose_rest(git_zstream *stream,
@@ -1452,13 +1454,19 @@ static int loose_object_info(struct repository *r,
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
2.33.0.1098.g29a6526ae47


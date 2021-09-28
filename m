Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4E2C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 754D761262
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbhI1CU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 22:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbhI1CUu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 22:20:50 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112C1C06176D
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id t16-20020a1c7710000000b003049690d882so752779wmi.5
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xcg4+LCcJJ5IPtvEtv8hp1X0fWyHojV4w8MVvyc3nwY=;
        b=HaS1XIf5wxFicm4ehERDqgS/Y73lwEYQFJFCD8g/yPIa6b4/XWs4BjzZwYCJVRhAR1
         O+QsyOAy1DUIU9EPGvBtZ2ZrE+8rTnnasc8elK8iDKVP0exe06N9P3gn2YhlHddHQ2zt
         oTt578sg2NgOMC+kmamQYmv0u7HpiIn01TM0BQlCVGrYdoz/0iB6zvZ2NxOchU2YlPAu
         8kd1eDk5M1ZBxB/p5girh+2VFVISyqZquOxqQnlDyY5Jh401dijLSk8MQTE4DINpvSWe
         aecxCmwy8fbGA16ayDoECSKTU8RpbwE4ngAyEVColSiBqXaK5hElYfu+nprEP1Vo+TRy
         i2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xcg4+LCcJJ5IPtvEtv8hp1X0fWyHojV4w8MVvyc3nwY=;
        b=s/44EDl+2r3ZNyGoE58f7EtGWqvDKWZLZATX4XPeoKVsa93IPs0hXQBpMgq8yorYrr
         2NFm3dbWFGx9afAGG0goI/i2YmdliH9OKWzT0Jozv+HZAUOHJGXKrTLrWhPLIQWaGxcU
         j5DghmSKUn6kJrQXfIBivUefl+TOBZWysMERQ3eUuWcwa0qjg933bC2DlVun6d/qyL2a
         oI3hoHaQWtmSxP1DSu22LOJXOJiXFBnRRyyHms74lRy92s5J0J+XXQAj0OT6poO7mI9i
         hVh7SAguA5zJ+oWKKcSQbob4sliOSDtGd3xQ50jJM4qE60zlXNbZ5DBvxu8Oo8bzxhwe
         uU1Q==
X-Gm-Message-State: AOAM533TQ21614rAgZ9p/I6Z8zL/U4Hh18+Z1J0Q6z1mWtL6/8VCiICu
        cogjNkHj3tNFi+pnpgNyiwC40tIQF5tF5A==
X-Google-Smtp-Source: ABdhPJxuifthq6TlWTD6iXBks4MpwJufH+7U8r8l6zLpIuc/VHHE13Qpy4H2AvKWwe2uIzQurRIhSw==
X-Received: by 2002:a1c:7e10:: with SMTP id z16mr2197046wmc.141.1632795549423;
        Mon, 27 Sep 2021 19:19:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c132sm1126987wma.22.2021.09.27.19.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:19:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 12/17] object-file.c: simplify unpack_loose_short_header()
Date:   Tue, 28 Sep 2021 04:18:53 +0200
Message-Id: <patch-v8-12.17-314d34357dd-20210928T021616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1327.g9926af6cb02
In-Reply-To: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
References: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com> <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
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
 cache.h       | 17 ++++++++++++++-
 object-file.c | 58 ++++++++++++++++++---------------------------------
 streaming.c   |  3 ++-
 3 files changed, 38 insertions(+), 40 deletions(-)

diff --git a/cache.h b/cache.h
index 35f254dae4a..d7189aed8fc 100644
--- a/cache.h
+++ b/cache.h
@@ -1319,7 +1319,22 @@ char *xdg_cache_home(const char *filename);
 
 int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
-int unpack_loose_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
+
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
+int unpack_loose_header(git_zstream *stream, unsigned char *map,
+			unsigned long mapsize, void *buffer,
+			unsigned long bufsiz, struct strbuf *hdrbuf);
 struct object_info;
 int parse_loose_header(const char *hdr, struct object_info *oi,
 		       unsigned int flags);
diff --git a/object-file.c b/object-file.c
index 6b91c4edcf6..1327872cbf4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1255,11 +1255,12 @@ void *map_loose_object(struct repository *r,
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
@@ -1270,35 +1271,8 @@ static int unpack_loose_short_header(git_zstream *stream,
 
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
-	if (status < Z_OK)
-		return -1;
-
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
 	if (status < Z_OK)
 		return -1;
 
@@ -1308,6 +1282,14 @@ static int unpack_loose_header_to_strbuf(git_zstream *stream, unsigned char *map
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
@@ -1457,6 +1439,7 @@ static int loose_object_info(struct repository *r,
 	char hdr[MAX_HEADER_LEN];
 	struct strbuf hdrbuf = STRBUF_INIT;
 	unsigned long size_scratch;
+	int allow_unknown = flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 
 	if (oi->delta_base_oid)
 		oidclr(oi->delta_base_oid);
@@ -1490,11 +1473,9 @@ static int loose_object_info(struct repository *r,
 
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
-	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE)) {
-		if (unpack_loose_header_to_strbuf(&stream, map, mapsize, hdr, sizeof(hdr), &hdrbuf) < 0)
-			status = error(_("unable to unpack %s header with --allow-unknown-type"),
-				       oid_to_hex(oid));
-	} else if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
+
+	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
+				allow_unknown ? &hdrbuf : NULL) < 0)
 		status = error(_("unable to unpack %s header"),
 			       oid_to_hex(oid));
 	if (status < 0)
@@ -2602,7 +2583,8 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0) {
+	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
+				NULL) < 0) {
 		error(_("unable to unpack header of %s"), path);
 		goto out;
 	}
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
2.33.0.1327.g9926af6cb02


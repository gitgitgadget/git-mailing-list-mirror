Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871B9C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9DD611C7
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351502AbhI3Njh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351656AbhI3NjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 09:39:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924F4C061773
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i23so10161254wrb.2
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jADtJ3dhg2ojKhEz6bEsoX3ycrLX826AOaawl+abLRk=;
        b=njtvy/8+ns7PXIqhgDdWe930QI++5UnicHiUW3qLqZiNvBSZbAb+Y1xwB/bVp6lcYn
         mBCZrVDpQ78N3CJaZPtGY4ivORpBD0k16ET9s2S8BewS7rBhylcZ/vsgYHtN7KIrGgNI
         5P1/NgqQjB2xImG32dZbQ8ykHQh7WA9wPil4athAoPNRaXqpR+UOfEU9x8BGhkHDnisi
         2/XvqJvDFlRleE9kKNk+94NUSiUm4e46rjdicv27vNkuuEP1mK0q3Nu3krub//0aMkQ7
         mEUJAq+KULMKqnza9HlyY8mQWCIUSjpgwUMpqFwabainiivfTAwZvVhg5DZQ29LPCjNs
         QPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jADtJ3dhg2ojKhEz6bEsoX3ycrLX826AOaawl+abLRk=;
        b=Y/1DXZOdA2Im2EzV3O9vJoeAnuRxHj4Z4wMvjUBOTlP5aQJMPwYqTGiCcJI27QWxrP
         Vx8K6/YHwmCgUSNB47RYCX+SG9ILPO9ZsGfj5xqpgnLo8gJShOOdNR/vttwIxLKIRC1j
         lLwFfn5xeWHnFLy1ezbUgygMoQpfdb4+rAZohaFgGJNG3eMFoTwyXoDgzKSMMV8OrA88
         9/guUTr+TTdu/JuHzja0fyRA1r1BAD9f3fsb6fcDNCt2zzqd4UqSr5eKXS3bRB+dG5Ch
         VVUGwka6I6mqqMNfrc8/2gYY806WcIY09rkc34IwhrQU++53/rfn1NJm1essiYP1WTol
         1XSQ==
X-Gm-Message-State: AOAM533GJkMc0de86l6dp81rYUI8YGL7caqPlgEDBQjwK9QocFyqmJMF
        oc5RwvH2EG9TUyJi0qWAfxkfSXqTFPMM4CKH
X-Google-Smtp-Source: ABdhPJza/OXYEx/8XPGsFcajelz7Jpj4hkESsOGVHofuqvccjeciwGFVJGgg2rZZXyJVyV4aQ0eIPA==
X-Received: by 2002:adf:e788:: with SMTP id n8mr6143991wrm.431.1633009057877;
        Thu, 30 Sep 2021 06:37:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o11sm4654713wmh.11.2021.09.30.06.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:37:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 12/17] object-file.c: simplify unpack_loose_short_header()
Date:   Thu, 30 Sep 2021 15:37:17 +0200
Message-Id: <patch-v9-12.17-dffe5581f6f-20210930T133300Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.g05459a61530
In-Reply-To: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
References: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com> <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
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
2.33.0.1374.g05459a61530


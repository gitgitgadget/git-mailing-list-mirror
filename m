Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8803DC433FE
	for <git@archiver.kernel.org>; Thu, 19 May 2022 20:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244645AbiESUJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 16:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244628AbiESUJh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 16:09:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399898E1AD
        for <git@vger.kernel.org>; Thu, 19 May 2022 13:09:36 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay35so1864138wmb.5
        for <git@vger.kernel.org>; Thu, 19 May 2022 13:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=48w8Uwh2KKt4APH5F5gouMQ0Yghho4tBdfBowTt0sjo=;
        b=iWJC8Qth3+eeykxreUrwiMXy1j1UCkGLkekJuOrH7XRsOtdcWTpLd4d+gfXe3sX5Aq
         hK2FTTpG6kfSXq07tcUMlPrutfjj7g2eQjD61RRRpFkqyHOpl4939VwcZZ17kalLpqie
         +pu0MOYdvM60iQw8weW84/WviIqCXrKQs34ofDvIxvOxUsGFvPhYomFlz3DNDaC7YBAD
         UZ9Kc3elio3PvFqf54yoFUU61A3aQo1RO2xVV+nHKeIfadXydkWg+oe60Mvq8QaEZ4ET
         p+bGP1d9rJrQspeS8bOb+1sxW9M/LAYq8hTUExqM9J8h26mmfL80WCzCwHkVKED2tELH
         kTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=48w8Uwh2KKt4APH5F5gouMQ0Yghho4tBdfBowTt0sjo=;
        b=PQnwZGnqnwy6hwNQIT+PFDn2u+q0gjVHRGynN9ReuW0ngwedaDTjz4L/D+1Uf2Jvya
         5KKkLGdtpKAfOmJr99N3JC94EjQILs5vJgigYS4vxUuZF9N3z9ApJKsKx55TxFa+YrW1
         Ya9/A4U1r8bFG1O5wv4lbzY9oM0HlgYTWC3DwT1ELK+Ehz7bYXhwac3zKw14DaIP+zAb
         8baxvNvQDTHYxVr/eQzc4opYwG7NyjJkR8xh0Z39gvl5V9p3KwhJTg8E0qjXZgtoHNFG
         /kqovL5TdNixHRiObdLWOf06tx7iGukuTMEGuAaAWLZj68vaytdcoXgmRyA5Qf76fNgQ
         4sDw==
X-Gm-Message-State: AOAM5308y341igCYYxKZGVsecd7Z6cCuKL+jmnOxkKo3jVkcxzh1tDap
        NeoS0mLreO3fZVBfVLZOkEN4pZnVhsDdYg==
X-Google-Smtp-Source: ABdhPJxrrLVDNDwmd4ShdN+QH+Uzd8GKUOh1cMFCmEBis2wHvx4TKl8J7H4RO6MTJ7gWXVDFqBoEwQ==
X-Received: by 2002:a7b:cc17:0:b0:38d:af7:3848 with SMTP id f23-20020a7bcc17000000b0038d0af73848mr5389719wmh.41.1652990974535;
        Thu, 19 May 2022 13:09:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay13-20020a05600c1e0d00b003944821105esm428152wmb.2.2022.05.19.13.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 13:09:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 2/2] object-file API: have unpack_loose_header() return "int" again
Date:   Thu, 19 May 2022 22:09:17 +0200
Message-Id: <RFC-patch-2.2-af0dfd017af-20220519T195055Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.957.g2c13267e09b
In-Reply-To: <RFC-cover-0.2-00000000000-20220519T195055Z-avarab@gmail.com>
References: <377be0e9-8a0f-4a86-0a66-3b08c0284dae@github.com> <RFC-cover-0.2-00000000000-20220519T195055Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Revert the API change in my 5848fb11acd (object-file.c: return
ULHR_TOO_LONG on "header too long", 2021-10-01) in favor of having
unpack_loose_header() return a simple negative value on error.

The more complex API was needed to give us flexibility that we didn't
really need. We only used the ULHR_TOO_LONG return case for headers
which "cat-file --allow-unknown-type" is needed for. Let's instead
error() on those unconditionally.

The slight change in the "error" message is that we won't include the
OID in the error in that case, but we will include it in the "unable
to unpack" error emitted by loose_object_info().

As noted in the preceding commit we were mishandling the case where
we'll now error() with "could not find end of corrupt long header".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h             | 22 ++++------------------
 object-file.c       | 46 +++++++++++++++++----------------------------
 streaming.c         | 11 +++--------
 t/t1006-cat-file.sh |  6 ++++--
 4 files changed, 28 insertions(+), 57 deletions(-)

diff --git a/cache.h b/cache.h
index aa24d5a609f..629c4a84b90 100644
--- a/cache.h
+++ b/cache.h
@@ -1330,13 +1330,7 @@ int git_open_cloexec(const char *name, int flags);
 
 /**
  * unpack_loose_header() initializes the data stream needed to unpack
- * a loose object header.
- *
- * Returns:
- *
- * - ULHR_OK on success
- * - ULHR_BAD on error
- * - ULHR_TOO_LONG if the header was too long
+ * a loose object header. A negative value indicates an error.
  *
  * It will only parse up to MAX_HEADER_LEN bytes unless an optional
  * "hdrbuf" argument is non-NULL. This is intended for use with
@@ -1344,17 +1338,9 @@ int git_open_cloexec(const char *name, int flags);
  * reporting. The full header will be extracted to "hdrbuf" for use
  * with parse_loose_header().
  */
-enum unpack_loose_header_result {
-	ULHR_OK,
-	ULHR_BAD,
-	ULHR_TOO_LONG,
-};
-enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
-						    unsigned char *map,
-						    unsigned long mapsize,
-						    void *buffer,
-						    unsigned long bufsiz,
-						    struct strbuf *hdrbuf);
+int unpack_loose_header(git_zstream *stream, unsigned char *map,
+			unsigned long mapsize, void *buffer,
+			unsigned long bufsiz, struct strbuf *header);
 
 /**
  * parse_loose_header() parses the starting "<type> <len>\0" of an
diff --git a/object-file.c b/object-file.c
index 1babe9791f6..1d2901d0e78 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1245,12 +1245,9 @@ void *map_loose_object(struct repository *r,
 	return map_loose_object_1(r, NULL, oid, size);
 }
 
-enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
-						    unsigned char *map,
-						    unsigned long mapsize,
-						    void *buffer,
-						    unsigned long bufsiz,
-						    struct strbuf *header)
+int unpack_loose_header(git_zstream *stream, unsigned char *map,
+			unsigned long mapsize, void *buffer,
+			unsigned long bufsiz, struct strbuf *header)
 {
 	int status;
 
@@ -1266,13 +1263,13 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 	status = git_inflate(stream, 0);
 	obj_read_lock();
 	if (status < Z_OK)
-		return ULHR_BAD;
+		return -1;
 
 	/*
 	 * Check if entire header is unpacked in the first iteration.
 	 */
 	if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
-		return ULHR_OK;
+		return 0;
 
 	/*
 	 * We have a header longer than MAX_HEADER_LEN. The "header"
@@ -1280,7 +1277,8 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 	 * --allow-unknown-type".
 	 */
 	if (!header)
-		return ULHR_TOO_LONG;
+		return error(_("header too long, exceeds %d bytes"),
+			     MAX_HEADER_LEN);
 
 	/*
 	 * buffer[0..bufsiz] was not large enough.  Copy the partial
@@ -1301,7 +1299,7 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 		stream->next_out = buffer;
 		stream->avail_out = bufsiz;
 	} while (status != Z_STREAM_END);
-	return ULHR_BAD;
+	return error(_("could not find end of corrupt long header"));
 }
 
 static void *unpack_loose_rest(git_zstream *stream,
@@ -1466,32 +1464,26 @@ static int loose_object_info(struct repository *r,
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
 
-	switch (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
-				    allow_unknown ? &hdrbuf : NULL)) {
-	case ULHR_OK:
+	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
+				allow_unknown ? &hdrbuf : NULL) < 0) {
+		status = error(_("unable to unpack %s header"),
+			       oid_to_hex(oid));
+	} else {
 		if (parse_loose_header(hdrbuf.len ? hdrbuf.buf : hdr, oi) < 0)
 			status = error(_("unable to parse %s header"), oid_to_hex(oid));
 		else if (!allow_unknown && *oi->typep < 0)
 			die(_("invalid object type"));
 
 		if (!oi->contentp)
-			break;
+			goto inflate_end;
 		*oi->contentp = unpack_loose_rest(&stream, hdr, *oi->sizep, oid);
 		if (*oi->contentp)
 			goto cleanup;
 
 		status = -1;
-		break;
-	case ULHR_BAD:
-		status = error(_("unable to unpack %s header"),
-			       oid_to_hex(oid));
-		break;
-	case ULHR_TOO_LONG:
-		status = error(_("header for %s too long, exceeds %d bytes"),
-			       oid_to_hex(oid), MAX_HEADER_LEN);
-		break;
 	}
 
+inflate_end:
 	git_inflate_end(&stream);
 cleanup:
 	munmap(map, mapsize);
@@ -2623,12 +2615,8 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	switch (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
-				    NULL)) {
-	case ULHR_OK:
-		break;
-	case ULHR_BAD:
-	case ULHR_TOO_LONG:
+	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
+				NULL) < 0) {
 		error(_("unable to unpack header of %s"), path);
 		goto out;
 	}
diff --git a/streaming.c b/streaming.c
index fe54665d86e..4456a60348b 100644
--- a/streaming.c
+++ b/streaming.c
@@ -230,15 +230,10 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 	st->u.loose.mapped = map_loose_object(r, oid, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
 		return -1;
-	switch (unpack_loose_header(&st->z, st->u.loose.mapped,
-				    st->u.loose.mapsize, st->u.loose.hdr,
-				    sizeof(st->u.loose.hdr), NULL)) {
-	case ULHR_OK:
-		break;
-	case ULHR_BAD:
-	case ULHR_TOO_LONG:
+	if (unpack_loose_header(&st->z, st->u.loose.mapped,
+				st->u.loose.mapsize, st->u.loose.hdr,
+				sizeof(st->u.loose.hdr), NULL) < 0)
 		goto error;
-	}
 	if (parse_loose_header(st->u.loose.hdr, &oi) < 0 || *type < 0)
 		goto error;
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index dadf3b14583..d742697d3bf 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -536,12 +536,14 @@ do
 			if test "$arg2" = "-p"
 			then
 				cat >expect <<-EOF
-				error: header for $bogus_long_sha1 too long, exceeds 32 bytes
+				error: header too long, exceeds 32 bytes
+				error: unable to unpack $bogus_long_sha1 header
 				fatal: Not a valid object name $bogus_long_sha1
 				EOF
 			else
 				cat >expect <<-EOF
-				error: header for $bogus_long_sha1 too long, exceeds 32 bytes
+				error: header too long, exceeds 32 bytes
+				error: unable to unpack $bogus_long_sha1 header
 				fatal: git cat-file: could not get object info
 				EOF
 			fi &&
-- 
2.36.1.957.g2c13267e09b


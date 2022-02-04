Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F6BC433FE
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 14:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359229AbiBDOHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 09:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356488AbiBDOHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 09:07:25 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C71C06173D
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 06:07:24 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r19so762626wrg.10
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 06:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vao8hCpO2JYmxWllFEFT1H6av0q8beZitby+enElfv8=;
        b=WzAXxMEpkPZXWXCkn1GetwMd3IzwoAPFwW4Lt+UlQvUGxQ9SZrgqGYHnrftjQzf9aW
         ui70fZ3ThtyRYoioUlBvNEWFa26mfhf0YWpzmiydS3RDR+IYzLTOVLvaLwpivbXHi9ur
         s50FARThFgDepqQa7HvsA5gzfKjvmtkSm5w43pXXIPb/CwizyXCoD6aPh4m4LtkCnchy
         nfeFFsJ+/QYhvzC8eqdKRo0kDwrdI9QZrhatCcMUKHCdwwEYGrtv0fofO4I41JYLau7u
         YAuEZlnC20G4sm/2/heM4mJSbYwi+0sGlZmg/wiEWLlNgC8mJm2NvttdLVk2aKz7o0Q3
         YMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vao8hCpO2JYmxWllFEFT1H6av0q8beZitby+enElfv8=;
        b=tcKMMMM73r4+b9+Sw8qhsPbG0CLd/IdVA/CZdsIh88vlKh5pO0DzfVKOl0Sv9H7HN+
         6m5aphdSaDeL2fL08sJGE4zRVBMGyB43omiAm4IzbnQjdWJlIieXV5VPWOzfeFxPktam
         VmFNashvYEszgARvhaDKE1nGBDBq2QtwcQosfIp5FbGR7RlEInbedNTXiu21yfrlpbCm
         XojHBUTnFL72wXBG/2oawcO9oLm/P89FoPR3LvoZZbiMtaNdN+EwzNZakvq30z8MKSLK
         9KItKZ265k8OMb+6JkRsEEx/hV8FvJZcAe1x78Ovh92IG5qMlMERwHSjFVOI/3vUNCwg
         NltA==
X-Gm-Message-State: AOAM531IT6PUsoB/t3830PF8XJh6HKW4DjmXs6Ix2vVZbA8PhnGDt8Im
        Bz7De/M/m1sAKvFxQUu3RtRkYsxok5bXPQ==
X-Google-Smtp-Source: ABdhPJx2P9hKX5V5zjz9oH/b6uixpoZQncHZfaQKhSz15z40WGTGjRqHxHO0/Zjum4vx/+KBkdZCuA==
X-Received: by 2002:adf:e0c2:: with SMTP id m2mr2688229wri.270.1643983643041;
        Fri, 04 Feb 2022 06:07:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u19sm618722wmm.0.2022.02.04.06.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 06:07:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v10 3/6] object-file.c: refactor write_loose_object() to several steps
Date:   Fri,  4 Feb 2022 15:07:09 +0100
Message-Id: <patch-v10-3.6-0e33d2a6e35-20220204T135538Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com>
References: <20220120112114.47618-1-chiyutianyi@gmail.com> <cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

When writing a large blob using "write_loose_object()", we have to pass
a buffer with the whole content of the blob, and this behavior will
consume lots of memory and may cause OOM. We will introduce a stream
version function ("stream_loose_object()") in later commit to resolve
this issue.

Before introducing that streaming function, do some refactoring on
"write_loose_object()" to reuse code for both versions.

Rewrite "write_loose_object()" as follows:

 1. Figure out a path for the (temp) object file. This step is only
    used in "write_loose_object()".

 2. Move common steps for starting to write loose objects into a new
    function "start_loose_object_common()".

 3. Compress data.

 4. Move common steps for ending zlib stream into a new function
    "end_loose_object_common()".

 5. Close fd and finalize the object file.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 129 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 89 insertions(+), 40 deletions(-)

diff --git a/object-file.c b/object-file.c
index edebdc91221..f5c579e42e3 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1943,6 +1943,87 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
 	return fd;
 }
 
+/**
+ * Common steps for loose object writers to start writing loose
+ * objects:
+ *
+ * - Create tmpfile for the loose object.
+ * - Setup zlib stream for compression.
+ * - Start to feed header to zlib stream.
+ *
+ * Returns a "fd", which should later be provided to
+ * end_loose_object_common().
+ */
+static int start_loose_object_common(struct strbuf *tmp_file,
+				     const char *filename, unsigned flags,
+				     git_zstream *stream,
+				     unsigned char *buf, size_t buflen,
+				     git_hash_ctx *c,
+				     char *hdr, int hdrlen)
+{
+	int fd;
+
+	fd = create_tmpfile(tmp_file, filename);
+	if (fd < 0) {
+		if (flags & HASH_SILENT)
+			return -1;
+		else if (errno == EACCES)
+			return error(_("insufficient permission for adding "
+				       "an object to repository database %s"),
+				     get_object_directory());
+		else
+			return error_errno(
+				_("unable to create temporary file"));
+	}
+
+	/*  Setup zlib stream for compression */
+	git_deflate_init(stream, zlib_compression_level);
+	stream->next_out = buf;
+	stream->avail_out = buflen;
+	the_hash_algo->init_fn(c);
+
+	/*  Start to feed header to zlib stream */
+	stream->next_in = (unsigned char *)hdr;
+	stream->avail_in = hdrlen;
+	while (git_deflate(stream, 0) == Z_OK)
+		; /* nothing */
+	the_hash_algo->update_fn(c, hdr, hdrlen);
+
+	return fd;
+}
+
+/**
+ * Common steps for loose object writers to end writing loose objects:
+ *
+ * - End the compression of zlib stream.
+ * - Get the calculated oid to "parano_oid".
+ * - fsync() and close() the "fd"
+ */
+static void end_loose_object_common(int fd, int ret, git_hash_ctx *c,
+				    git_zstream *stream,
+				    struct object_id *parano_oid,
+				    const struct object_id *expected_oid,
+				    const char *die_msg1_fmt,
+				    const char *die_msg2_fmt)
+{
+	if (ret != Z_STREAM_END)
+		die(_(die_msg1_fmt), ret, expected_oid);
+	ret = git_deflate_end_gently(stream);
+	if (ret != Z_OK)
+		die(_(die_msg2_fmt), ret, expected_oid);
+	the_hash_algo->final_oid_fn(parano_oid, c);
+
+	/*
+	 * We already did a write_buffer() to the "fd", let's fsync()
+	 * and close().
+	 *
+	 * We might still die() on a subsequent sanity check, but
+	 * let's not add to that confusion by not flushing any
+	 * outstanding writes to disk first.
+	 */
+	close_loose_object(fd);
+}
+
 static int write_loose_object(const struct object_id *oid, char *hdr,
 			      int hdrlen, const void *buf, unsigned long len,
 			      time_t mtime, unsigned flags)
@@ -1957,28 +2038,11 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 
 	loose_object_path(the_repository, &filename, oid);
 
-	fd = create_tmpfile(&tmp_file, filename.buf);
-	if (fd < 0) {
-		if (flags & HASH_SILENT)
-			return -1;
-		else if (errno == EACCES)
-			return error(_("insufficient permission for adding an object to repository database %s"), get_object_directory());
-		else
-			return error_errno(_("unable to create temporary file"));
-	}
-
-	/* Set it up */
-	git_deflate_init(&stream, zlib_compression_level);
-	stream.next_out = compressed;
-	stream.avail_out = sizeof(compressed);
-	the_hash_algo->init_fn(&c);
-
-	/* First header.. */
-	stream.next_in = (unsigned char *)hdr;
-	stream.avail_in = hdrlen;
-	while (git_deflate(&stream, 0) == Z_OK)
-		; /* nothing */
-	the_hash_algo->update_fn(&c, hdr, hdrlen);
+	fd = start_loose_object_common(&tmp_file, filename.buf, flags,
+				       &stream, compressed, sizeof(compressed),
+				       &c, hdr, hdrlen);
+	if (fd < 0)
+		return -1;
 
 	/* Then the data itself.. */
 	stream.next_in = (void *)buf;
@@ -1993,24 +2057,9 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		stream.avail_out = sizeof(compressed);
 	} while (ret == Z_OK);
 
-	if (ret != Z_STREAM_END)
-		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
-		    ret);
-	ret = git_deflate_end_gently(&stream);
-	if (ret != Z_OK)
-		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
-		    ret);
-	the_hash_algo->final_oid_fn(&parano_oid, &c);
-
-	/*
-	 * We already did a write_buffer() to the "fd", let's fsync()
-	 * and close().
-	 *
-	 * We might still die() on a subsequent sanity check, but
-	 * let's not add to that confusion by not flushing any
-	 * outstanding writes to disk first.
-	 */
-	close_loose_object(fd);
+	end_loose_object_common(fd, ret, &c, &stream, &parano_oid, oid,
+				N_("unable to deflate new object %s (%d)"),
+				N_("deflateEnd on object %s failed (%d)"));
 
 	if (!oideq(oid, &parano_oid))
 		die(_("confused by unstable object source data for %s"),
-- 
2.35.1.940.ge7a5b4b05f2


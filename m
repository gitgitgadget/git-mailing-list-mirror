Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D687C433F5
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 00:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241650AbiCSAZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 20:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241654AbiCSAZA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 20:25:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E76129270
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 17:23:39 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 185so823553wmc.3
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 17:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hFLsC62jqDEqqoAA5FtRoKZRZOWfdlualSdt5UoNFwo=;
        b=g2A3iiJoz6drRY3PHM07KufPGRzOO07EH8y+sXhWXTDesmpnSAYY3zDODfxq807a73
         mLfsK9yBTE5DvBoj7ppIcUkLm4MY9ftb4dBYglbV7bTUO9O4fcXh+UcbrkyZ6M/95xKr
         b6J7SLSMkMyyjo2Jv4+1MFH7hSTUnj+jhq1zAn/VVy9fOS0j30vhU+c6/SBTC1xTQpQS
         tE11DXaNqGKyo7hxTc9LPlkJ0vJ1kiY/DOgigW0m+YOZCkfcA5xUz+bl+2FQ5RAzpOni
         K2eERc4IMEuACBT8J5qbxGMx+Swy7ht74pweOGnlftXpZpdvD5cQ9tsiUK5faph2IWe7
         wkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hFLsC62jqDEqqoAA5FtRoKZRZOWfdlualSdt5UoNFwo=;
        b=xjHotE4U36h7/88Tyz4DggCWg7sYokd02nLf8h//L7DGpNcMqyvN3Yg+L6UpDKfG0g
         nf9RNA0EQTgyzDTkLZ/2WJXENd2JtU7nOmak2DAwBoQPd9ROk+wKQygEG3tn44qzewSx
         BAnMqTeBmU5KMzm/J/xPXr5DdSlCaY+oVIYuaqyJx3KUm9aK9udGl8qKbjGUtdcFiuOY
         KcWVQtwAn3mpO9zUs/tAWO/Qds6H9nWJN8tYX6VA5Zcl0VwNIV3FFiQntuuCFpzFvef4
         rnMnBhs9RQlWQ1PcKthppDZQHgtypPRItkV150jCvAZmfP/SQfBO4ow8GTJ/bXSHwI1b
         8sOQ==
X-Gm-Message-State: AOAM533L8isvtK2SvZvozjnWbo5GlUYJoMriykn2jgMs+mdTFiAy0EPX
        kF0Pq7n8GANo7IpABSYcZK2noZnKHfxjOg==
X-Google-Smtp-Source: ABdhPJyP7Cbc3aFXGPdgzyqh3U//FLE8T3fQRAOskXI5pYQ6z7ow6jVMKRBibfZJVeZzyyGJWIjC6Q==
X-Received: by 2002:a7b:ce83:0:b0:37b:f1f1:3a0c with SMTP id q3-20020a7bce83000000b0037bf1f13a0cmr10207078wmj.10.1647649417471;
        Fri, 18 Mar 2022 17:23:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u25-20020a05600c211900b00389d4bdb3d2sm14865519wml.36.2022.03.18.17.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 17:23:36 -0700 (PDT)
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
Subject: [PATCH v11 3/8] object-file.c: refactor write_loose_object() to several steps
Date:   Sat, 19 Mar 2022 01:23:20 +0100
Message-Id: <patch-v11-3.8-f7b02c307fc-20220319T001411Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1438.g8874c8eeb35
In-Reply-To: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
References: <cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com> <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
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
index 4c140eda6bf..4fcaf7a36ce 100644
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
2.35.1.1438.g8874c8eeb35


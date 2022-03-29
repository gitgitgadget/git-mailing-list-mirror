Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40925C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 13:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbiC2N6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 09:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiC2N6G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 09:58:06 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566BA223BE9
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 06:56:23 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o10so35364939ejd.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 06:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QIVuPPaIkwh901GDFQRzl6dW0h/Jnm3tQ4lUvqCLjHo=;
        b=jjOeoU6msPxtJdUI379bJwtiYR5K6MvRfx3SYxlpnuNKK3wINLgUHtXpOV+CjFz4UR
         XRGMj7NYEb6azdxWreRHAliJeGpXmMU1hYEkewOyuv9ztdSI0KM0v/sPswxPkxsMbcq1
         iSj5uws4hB4smAaHXTPKMt2zTe2i9u6p4gmanAw37J4vIh4jCR1duaxJhITBsyXjcn9v
         xBP8rSor4jh+S3l75bM5W/4ZZMKtXIV/wycsMMr55XhsiJQ939IWAPLtZvHRaw2i13Fj
         6wtk5fR+mzGMncFgDd6uc6orUY8k8REe9luUX76wBZgeE8F2lVIg+9G4+waqwK6cSl4p
         7JDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QIVuPPaIkwh901GDFQRzl6dW0h/Jnm3tQ4lUvqCLjHo=;
        b=KF+4KN7Xw81uFZMjXkoDFSD8G8cO9IMN/bhiZgRvGRrPoulZ/4J48OQaIbbxbnnvA5
         LrU9tvAATi5LhGy4U5kJfk9ISPtCLJ25tke3gppenyAJrzH6+oEjFL6R6FCnv4ffDRKx
         1QR6mTPZPM9Xt7PC3k6GO8HxK77zS4iwsnDv6d8u3ErBZPuRoSQp6uenZsE9GPTZU4tV
         skL+3EwwH77zvU8BkQRUD52xCmTe7K/5OGGS8PAMM3U2ZxtHnsxPIw8t9rQhbCTmF5II
         Z3ToG4G5KJw73rjIsXYYMC1fftLDV42z7VygiAwx+KCLVlKaoTHvwBKX3lvqKW4WfFTr
         dscw==
X-Gm-Message-State: AOAM532kWefNr5GncJowqCvfaTVHbNIW47bIJw7huTVoQe9IL0BmPPxF
        RU9kP7NhjnGT+Bt4A3zbhCz5Wk7VIKZIFA==
X-Google-Smtp-Source: ABdhPJy7fhT62sdyS2xM5rfSvFE6ardshErINB048mZUI4+N3uCdkTy0cYNm3CuEV7yjy0VVtvJX+g==
X-Received: by 2002:a17:907:7255:b0:6df:e82b:3e89 with SMTP id ds21-20020a170907725500b006dfe82b3e89mr34537607ejc.493.1648562181516;
        Tue, 29 Mar 2022 06:56:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ds5-20020a170907724500b006df8f39dadesm7006601ejc.218.2022.03.29.06.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 06:56:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v12 3/8] object-file.c: refactor write_loose_object() to several steps
Date:   Tue, 29 Mar 2022 15:56:08 +0200
Message-Id: <patch-v12-3.8-3dcaa5d6589-20220329T135446Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1548.g36973b18e52
In-Reply-To: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
References: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com> <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
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
 object-file.c | 102 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 76 insertions(+), 26 deletions(-)

diff --git a/object-file.c b/object-file.c
index 5da458eccbf..7f160929e00 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1955,6 +1955,75 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
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
+ * - Get the calculated oid to "oid".
+ * - fsync() and close() the "fd"
+ */
+static int end_loose_object_common(git_hash_ctx *c, git_zstream *stream,
+				   struct object_id *oid)
+{
+	int ret;
+
+	ret = git_deflate_end_gently(stream);
+	if (ret != Z_OK)
+		return ret;
+	the_hash_algo->final_oid_fn(oid, c);
+
+	return Z_OK;
+}
+
 static int write_loose_object(const struct object_id *oid, char *hdr,
 			      int hdrlen, const void *buf, unsigned long len,
 			      time_t mtime, unsigned flags)
@@ -1969,28 +2038,11 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 
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
@@ -2008,11 +2060,9 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	if (ret != Z_STREAM_END)
 		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
 		    ret);
-	ret = git_deflate_end_gently(&stream);
+	ret = end_loose_object_common(&c, &stream, &parano_oid);
 	if (ret != Z_OK)
-		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
-		    ret);
-	the_hash_algo->final_oid_fn(&parano_oid, &c);
+		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid), ret);
 	close_loose_object(fd);
 
 	if (!oideq(oid, &parano_oid))
-- 
2.35.1.1548.g36973b18e52


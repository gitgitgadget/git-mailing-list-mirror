Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEACEC43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 14:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348432AbiFJOsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 10:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349228AbiFJOr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 10:47:26 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48BCD42
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 07:47:24 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 129so24996867pgc.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 07:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=89OTghNx96Z8tbLE1mnclAjUAHwAy9ky/yWIZ9xFWWU=;
        b=J9fY8Rm0wxlvMHMhRaRLr1F5l55i19BFZ/lx1ba15e3b8dG1GQ1LQlukDIZV3NlAEb
         o0s24S4tu/SFvwvBdTj7ohBWZcM0MJOqe6V1+1s8s9L25xuZtQ5sgZBKCy/mrj5Pwj65
         W98P/UjJTWgE3c02exoHWmWfhYg5q8psMdeFsVBGNcdvTaBy5ELvy7P3nEwfruh5q55F
         gDIpLIxJjZ8jemAuO1axfhB/FawY+t4aP4icnLIXzWXFuntSA4sr3eXHsKLMfvNGY/Ka
         CaFqX4N2qkrsoIugSwxTuEjGRWIMDDOjl4qG3QXce8eHC5xy172PuGzwFhljascqTXAl
         WF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=89OTghNx96Z8tbLE1mnclAjUAHwAy9ky/yWIZ9xFWWU=;
        b=021eGtLl87Ze+7RdMOCtJEijpLf3q+6tLstmbyO8EWqrOQlBA/k0cri4VCgWDuvQ4i
         k1ChJJrd/6pXkhC3dFBx4Y2TxTSixhgA60mPGTbxdOvLYFzHqNE9F8LB8aUM3YQD7wso
         KZF2B4+O2ZuzKnd0zGsnMWbc5ho2ZDTYRN1mwiAtr6gd/rordWH7iPhwiwf736WKF4z9
         DCxtKkc/3PBXN7qRYMvrpbz2R2Q5n0CNb3ZxIHSTHDb3hnDgI/gr15eLrrtA6BzGJPnk
         DMSXuQ2EGyW1GJoEfURY+Nx/M0u2d00kTrMQDCehU2tXMOo6ig9PD28hSqkm5aO0Bduh
         wNrw==
X-Gm-Message-State: AOAM530HKbLM79aNWgZImLPnLJ8nn3QnOp7xp55Lgx686HD3Z8MaEg67
        334SKHigQod8l1PrV49QbW4=
X-Google-Smtp-Source: ABdhPJyt4wpLiUoU6Zerm4qvtmZRS11Oco4XOnGNoWN3xdnS8abIoyM3LILcnhwBm9f+Ar5VD/6/Pw==
X-Received: by 2002:a05:6a00:168a:b0:4f7:e161:83cd with SMTP id k10-20020a056a00168a00b004f7e16183cdmr46715559pfc.56.1654872444314;
        Fri, 10 Jun 2022 07:47:24 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id lx9-20020a17090b4b0900b001e292e30129sm1840434pjb.22.2022.06.10.07.47.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jun 2022 07:47:23 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     avarab@gmail.com
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>, chiyutianyi@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        neerajsi@microsoft.com, newren@gmail.com, philipoakley@iee.email,
        stolee@gmail.com, worldhello.net@gmail.com,
        Neeraj Singh <nksingh85@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v14 3/7] object-file.c: refactor write_loose_object() to several steps
Date:   Fri, 10 Jun 2022 22:46:03 +0800
Message-Id: <9bc8002282ddbb13b707c303281d88f377ecbdbe.1654871916.git.chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654871915.git.chiyutianyi@gmail.com>
References: <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com> <cover.1654871915.git.chiyutianyi@gmail.com>
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
 object-file.c | 101 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 75 insertions(+), 26 deletions(-)

diff --git a/object-file.c b/object-file.c
index e4a83012ba..f4d7f8c109 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1951,6 +1951,74 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
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
@@ -1968,28 +2036,11 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 
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
@@ -2007,11 +2058,9 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
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
 	close_loose_object(fd, tmp_file.buf);
 
 	if (!oideq(oid, &parano_oid))
-- 
2.36.1


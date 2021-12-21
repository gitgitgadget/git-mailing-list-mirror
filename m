Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59239C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 11:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbhLULy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 06:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbhLULy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 06:54:26 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F30C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 03:54:25 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id u16so4500161plg.9
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 03:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7xuPCcE6FjoGRXir7GTGrFu3V5hWaWradHSRqi+FXXs=;
        b=kLlir31wHoAu/AxBaCpwwcPk/OysfWAkp/L304IbKEbaAsyNluzWfhY+Aq9VsP1FdQ
         YKNdRIQYNzdlSjKn3suPw1aIozhXeYkrGBY8c28Lgp/gzOvvrnhG+/EFQmCYhI5JkLZW
         kCCPp9uSzQ29eDCksBTQM2XNLgpnQdKi3g3zGecN0bljxwPuGy3vLMXbJOGLHp6u14kj
         6GyPa3edI19WdHsE+VNM5Ga5OOceJhxjDr4OlOa81TQHgaqoMWElLViRg3/yOcN5fPM/
         rlebCSyqX5TbL6AE6Uf2B4lV7q0dU9BSx+0/j9lErBVD/amqCN/larekzppCJzqiqluP
         0jxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7xuPCcE6FjoGRXir7GTGrFu3V5hWaWradHSRqi+FXXs=;
        b=6sIx9zHvlPGcsW9ZkOV/3/Dm689v/rUzVHY1/mrzY++Abq0V1DPwyFmbooXGpgFn4g
         Ix+AwkuXutrqkF7BNBip5GhiFjrpHImnJkT1dDsNpvOZ/b+emJpViq9tS+f8htZyrLMR
         23HxKPmNaY9SQJJW/S09W5oIWPdm4TVF3YBqpwREzdTsiPMMMJ8zOC4PjQu4AVpLceI4
         hUWjy6Zl8jyIDd4s7JYgtLZG0LpL7gMJAeJMViGpYfMwLKdffc6fcc0EgqAW35FVSBWw
         0rRBVefxVBYTVl68ajxRrYHQylSWc6D4475nIdiDr9AalzLQ9tsNOSn9W4bPrZx0cjje
         uMDA==
X-Gm-Message-State: AOAM532joKRC6Wyp7UL3VpsuspIA7rBpqoRjgdNLy4xGOsx8wnXNUiWV
        wOCUwEDVPOW54PL4Ua5R2aI=
X-Google-Smtp-Source: ABdhPJyqcu33DkUixZmk5yMrxfsEyYOvd2tNkrPXbG6XhN0oxC5BxLw4NZp1aOaOCnzXZajcPD4iYg==
X-Received: by 2002:a17:902:e541:b0:149:35bd:b260 with SMTP id n1-20020a170902e54100b0014935bdb260mr2039922plf.41.1640087665417;
        Tue, 21 Dec 2021 03:54:25 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id s30sm20513742pfw.57.2021.12.21.03.54.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Dec 2021 03:54:24 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v7 3/5] object-file.c: refactor write_loose_object() to reuse in stream version
Date:   Tue, 21 Dec 2021 19:51:59 +0800
Message-Id: <20211221115201.12120-4-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.1.52.g80008efde6.agit.6.5.6
In-Reply-To: <20211217112629.12334-1-chiyutianyi@gmail.com>
References: <20211217112629.12334-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

We used to call "get_data()" in "unpack_non_delta_entry()" to read the
entire contents of a blob object, no matter how big it is. This
implementation may consume all the memory and cause OOM.

This can be improved by feeding data to "stream_loose_object()" in
stream instead of read into the whole buf.

As this new method "stream_loose_object()" has many similarities with
"write_loose_object()", we split up "write_loose_object()" into some
steps:
 1. Figuring out a path for the (temp) object file.
 2. Creating the tempfile.
 3. Setting up zlib and write header.
 4. Write object data and handle errors.
 5. Optionally, do someting after write, maybe force a loose object if
"mtime".

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c | 100 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 65 insertions(+), 35 deletions(-)

diff --git a/object-file.c b/object-file.c
index 6bba4766f9..e048f3d39e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1751,6 +1751,25 @@ static void write_object_file_prepare(const struct git_hash_algo *algo,
 	algo->final_oid_fn(oid, &c);
 }
 
+/*
+ * Move the just written object with proper mtime into its final resting place.
+ */
+static int finalize_object_file_with_mtime(const char *tmpfile,
+					   const char *filename,
+					   time_t mtime,
+					   unsigned flags)
+{
+	struct utimbuf utb;
+
+	if (mtime) {
+		utb.actime = mtime;
+		utb.modtime = mtime;
+		if (utime(tmpfile, &utb) < 0 && !(flags & HASH_SILENT))
+			warning_errno(_("failed utime() on %s"), tmpfile);
+	}
+	return finalize_object_file(tmpfile, filename);
+}
+
 /*
  * Move the just written object into its final resting place.
  */
@@ -1836,7 +1855,8 @@ static inline int directory_size(const char *filename)
  * We want to avoid cross-directory filename renames, because those
  * can have problems on various filesystems (FAT, NFS, Coda).
  */
-static int create_tmpfile(struct strbuf *tmp, const char *filename)
+static int create_tmpfile(struct strbuf *tmp, const char *filename,
+			  unsigned flags)
 {
 	int fd, dirlen = directory_size(filename);
 
@@ -1844,7 +1864,9 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
 	strbuf_add(tmp, filename, dirlen);
 	strbuf_addstr(tmp, "tmp_obj_XXXXXX");
 	fd = git_mkstemp_mode(tmp->buf, 0444);
-	if (fd < 0 && dirlen && errno == ENOENT) {
+	do {
+		if (fd >= 0 || !dirlen || errno != ENOENT)
+			break;
 		/*
 		 * Make sure the directory exists; note that the contents
 		 * of the buffer are undefined after mkstemp returns an
@@ -1854,17 +1876,48 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
 		strbuf_reset(tmp);
 		strbuf_add(tmp, filename, dirlen - 1);
 		if (mkdir(tmp->buf, 0777) && errno != EEXIST)
-			return -1;
+			break;
 		if (adjust_shared_perm(tmp->buf))
-			return -1;
+			break;
 
 		/* Try again */
 		strbuf_addstr(tmp, "/tmp_obj_XXXXXX");
 		fd = git_mkstemp_mode(tmp->buf, 0444);
+	} while (0);
+
+	if (fd < 0 && !(flags & HASH_SILENT)) {
+		if (errno == EACCES)
+			return error(_("insufficient permission for adding an "
+				       "object to repository database %s"),
+				     get_object_directory());
+		else
+			return error_errno(_("unable to create temporary file"));
 	}
+
 	return fd;
 }
 
+static void setup_stream_and_header(git_zstream *stream,
+				    unsigned char *compressed,
+				    unsigned long compressed_size,
+				    git_hash_ctx *c,
+				    char *hdr,
+				    int hdrlen)
+{
+	/* Set it up */
+	git_deflate_init(stream, zlib_compression_level);
+	stream->next_out = compressed;
+	stream->avail_out = compressed_size;
+	the_hash_algo->init_fn(c);
+
+	/* First header.. */
+	stream->next_in = (unsigned char *)hdr;
+	stream->avail_in = hdrlen;
+	while (git_deflate(stream, 0) == Z_OK)
+		; /* nothing */
+	the_hash_algo->update_fn(c, hdr, hdrlen);
+}
+
 static int write_loose_object(const struct object_id *oid, char *hdr,
 			      int hdrlen, const void *buf, unsigned long len,
 			      time_t mtime, unsigned flags)
@@ -1879,28 +1932,13 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 
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
+	fd = create_tmpfile(&tmp_file, filename.buf, flags);
+	if (fd < 0)
+		return -1;
 
-	/* First header.. */
-	stream.next_in = (unsigned char *)hdr;
-	stream.avail_in = hdrlen;
-	while (git_deflate(&stream, 0) == Z_OK)
-		; /* nothing */
-	the_hash_algo->update_fn(&c, hdr, hdrlen);
+	/* Set it up and write header */
+	setup_stream_and_header(&stream, compressed, sizeof(compressed),
+				&c, hdr, hdrlen);
 
 	/* Then the data itself.. */
 	stream.next_in = (void *)buf;
@@ -1929,16 +1967,8 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 
 	close_loose_object(fd);
 
-	if (mtime) {
-		struct utimbuf utb;
-		utb.actime = mtime;
-		utb.modtime = mtime;
-		if (utime(tmp_file.buf, &utb) < 0 &&
-		    !(flags & HASH_SILENT))
-			warning_errno(_("failed utime() on %s"), tmp_file.buf);
-	}
-
-	return finalize_object_file(tmp_file.buf, filename.buf);
+	return finalize_object_file_with_mtime(tmp_file.buf, filename.buf,
+					       mtime, flags);
 }
 
 static int freshen_loose_object(const struct object_id *oid)
-- 
2.34.1.52.g80008efde6.agit.6.5.6


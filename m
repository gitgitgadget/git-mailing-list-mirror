Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCBFC433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 11:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiATLWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 06:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiATLWo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 06:22:44 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D31C06175F
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 03:22:33 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id c66so4103796pfc.6
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 03:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BJsJpPtC71Tv8iVe5nL2JuvZQwHbj10PDai0YSFNGLE=;
        b=hLJtZCsuTJuUjYkhIXKJXOo/w8cRy3CPE+Ewh5vcY9UWoT9XgLKsTZaEqlgcKgojXZ
         4qrnritZKmORZIy6+q52suQvFqrAEePuaH6cr+rYpSkuNZJgmfr0FRqngobx5R0jutkm
         8Aof7X6NRtKiRmukd2f9YiYPfKUlQeUQAFQFM2dWBZjHhg0oswy7z/F/lhREQtdPKpcV
         gd0QJrLiMwpv5MUjtldtdA10HwjgLTVY0er1A2AAjD/0XEl8ijnj/t8jmyJe02ZWhdTW
         DrdF+R9FZ6ArZJ4S0h3fD84EbEfounyuCwhOkU7MAjLXF8MichF60D6mtFqrrwiKBdDT
         Zrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BJsJpPtC71Tv8iVe5nL2JuvZQwHbj10PDai0YSFNGLE=;
        b=CzGMpXq9akVon++omT0OeIrfL1cUEQ2c4yPs3a/r0Tc6Kg9anD9ptozEFJeweOri9v
         2LVElx3qxY7EdsqvExFWXr39sQABMFrC1fLo3r45S1t0iqH2OEHhi3zU0q7Jh7oLtnF1
         2pCy8/SFVao8UaGc+GNQHA5AdewZis9hrS3Kg4RnRwMQRTXn6qXOckZxKI/8cTIkH6Ee
         W5IiB3kELewpO6zofNL537GNx3dWvqqrAJZggZhRoFZ/4xoJlXi+AHZIwTcQur7p2/Jp
         HR39YF6CQ6UpEfRfqYEheqwNa2SbJm/j0uUR9C7kK9OhTxGXUlLNt+3TaFEnAAWgTv0M
         JsmQ==
X-Gm-Message-State: AOAM532qhTUwG1MPwHs96l3q5PVfWYkF0TlYbF6TdHktPXNO8+/Ln0Hj
        5erscYRH0MzeJQcSaa7VOno=
X-Google-Smtp-Source: ABdhPJzcgu/HPwki13xw2KbtA54UxzXOu92zXg0rnKwugwGlCsaJ9ODdKUKPDFxX67VKW4ByDp7++w==
X-Received: by 2002:a05:6a00:a20:b0:4bb:95f6:93b3 with SMTP id p32-20020a056a000a2000b004bb95f693b3mr35317792pfh.77.1642677752688;
        Thu, 20 Jan 2022 03:22:32 -0800 (PST)
Received: from localhost.localdomain ([58.100.34.57])
        by smtp.gmail.com with ESMTPSA id x18sm2998989pfh.192.2022.01.20.03.22.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jan 2022 03:22:32 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jiang Xin <worldhello.net@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v9 2/5] object-file.c: refactor write_loose_object() to several steps
Date:   Thu, 20 Jan 2022 19:21:11 +0800
Message-Id: <20220120112114.47618-3-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.1.52.gc288e771b4.agit.6.5.6
In-Reply-To: <20220108085419.79682-1-chiyutianyi@gmail.com>
References: <20220108085419.79682-1-chiyutianyi@gmail.com>
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
version function ("stream_loose_object()") in latter commit to resolve
this issue.

Before introducing a stream vesion function for writing loose object,
do some refactoring on "write_loose_object()" to reuse code for both
versions.

Rewrite "write_loose_object()" as follows:

 1. Figure out a path for the (temp) object file. This step is only
    used in "write_loose_object()".

 2. Move common steps for starting to write loose objects into a new
    function "start_loose_object_common()".

 3. Compress data.

 4. Move common steps for ending zlib stream into a new funciton
    "end_loose_object_common()".

 5. Close fd and finalize the object file.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c | 105 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 75 insertions(+), 30 deletions(-)

diff --git a/object-file.c b/object-file.c
index eb1426f98c..422b43212a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1857,6 +1857,59 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
 	return fd;
 }
 
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
+static void end_loose_object_common(int ret, git_hash_ctx *c,
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
+}
+
 static int write_loose_object(const struct object_id *oid, char *hdr,
 			      int hdrlen, const void *buf, unsigned long len,
 			      time_t mtime, unsigned flags)
@@ -1871,28 +1924,18 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 
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
+	/* Common steps for write_loose_object and stream_loose_object to
+	 * start writing loose oject:
+	 *
+	 *  - Create tmpfile for the loose object.
+	 *  - Setup zlib stream for compression.
+	 *  - Start to feed header to zlib stream.
+	 */
+	fd = start_loose_object_common(&tmp_file, filename.buf, flags,
+				       &stream, compressed, sizeof(compressed),
+				       &c, hdr, hdrlen);
+	if (fd < 0)
+		return -1;
 
 	/* Then the data itself.. */
 	stream.next_in = (void *)buf;
@@ -1907,14 +1950,16 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
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
+	/* Common steps for write_loose_object and stream_loose_object to
+	 * end writing loose oject:
+	 *
+	 *  - End the compression of zlib stream.
+	 *  - Get the calculated oid to "parano_oid".
+	 */
+	end_loose_object_common(ret, &c, &stream, &parano_oid, oid,
+				N_("unable to deflate new object %s (%d)"),
+				N_("deflateEnd on object %s failed (%d)"));
+
 	if (!oideq(oid, &parano_oid))
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
-- 
2.34.1.52.gc288e771b4.agit.6.5.6


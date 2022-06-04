Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FF3C43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 10:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbiFDKK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 06:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiFDKKl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 06:10:41 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE06618350
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 03:10:39 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t13so13251562wrg.9
        for <git@vger.kernel.org>; Sat, 04 Jun 2022 03:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=85TQoqNMFRWEUJHhdUZt6qNiCW2kbQ8upgPT+VTKhYE=;
        b=AuaqCGsvpjiqBqhPBfQMa4mQ9Y3B6+zFQma/r5Y1uPwFFkgwMViul2ZxKT+7+i2VvR
         g2acWZoBM8KLQ1kUx3HZoTqXg4VoHcE3Tm/FQKEUjDUbSYVJwmmB7HxdIceD17fwBEY7
         6CxNrQRbFo3qLAnHNp9Il9BP3NmVBLP8BJ0dMP9+ktS+kHlJm/0CjDMkWxlb39ClrMQW
         fazuBmwO3M47QADr2Y1DWMl29m4eQiyrlZg8jzmWcgTcIGAnb+91UpaON9tNM73eENA4
         Ey2Dj5QEyjSk9gPJ+19PuCsc3dSXGqcf9BeKoHwRlltyxckscddKfGF4Spl8E+Qf0lcN
         UwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=85TQoqNMFRWEUJHhdUZt6qNiCW2kbQ8upgPT+VTKhYE=;
        b=wYceGTjXRIMAgv0Yzk2O+CP1lA76Ra5ptXHmMMPjnbsw87NB2t3ukJ6hwH21FfHQJg
         te7gP32f1Y6KbX0QJ5UH+9s48M50kTVJ1tT4VgBwADpKtNlHfvlfCwUXf/KjxCFjOv02
         BeyqNyhT8a7NbM7KfOAnioAwQamH/GcWE7LTGNS4froW2EltH3pK3dIIdYUn7VyCfA2f
         S3csvilHaEaPbmFCnit/prwIXVIrGq9H+Er9DfeKzEU1NiDlc0PTx2bGucS8V9HBlmYa
         EKvCpGAzmndUn7eV3jASL5lMN9GZztg9xEOAyrhSXSXLzVllDwhbgG0ZDMJoXY1GEApa
         iOeA==
X-Gm-Message-State: AOAM532XSQdFv580Sv9WtK4Jnd9Q3YuDOBdBx7340oRfcK3BTCYgHhoP
        8GaN/rmJPi/LLR2WJySa+iqk0joqARlusg==
X-Google-Smtp-Source: ABdhPJyW4iRQ7pS1TNAAw0c3MTYbJnsZwXGiqiGYBsDQYM+ZDg2SLl+coUPJ3xWUXrZ6SxT0bzUJxQ==
X-Received: by 2002:a5d:64c6:0:b0:20e:7179:7d87 with SMTP id f6-20020a5d64c6000000b0020e71797d87mr12590047wri.592.1654337438194;
        Sat, 04 Jun 2022 03:10:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i12-20020a05600c354c00b0039765a7add4sm15069631wmq.29.2022.06.04.03.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 03:10:37 -0700 (PDT)
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
Subject: [PATCH v13 5/7] object-file.c: add "stream_loose_object()" to handle large object
Date:   Sat,  4 Jun 2022 12:10:26 +0200
Message-Id: <patch-v13-5.7-0b07b29836b-20220604T095113Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g52838f02905
In-Reply-To: <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
References: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com> <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

If we want unpack and write a loose object using "write_loose_object",
we have to feed it with a buffer with the same size of the object, which
will consume lots of memory and may cause OOM. This can be improved by
feeding data to "stream_loose_object()" in a stream.

Add a new function "stream_loose_object()", which is a stream version of
"write_loose_object()" but with a low memory footprint. We will use this
function to unpack large blob object in later commit.

Another difference with "write_loose_object()" is that we have no chance
to run "write_object_file_prepare()" to calculate the oid in advance.
In "write_loose_object()", we know the oid and we can write the
temporary file in the same directory as the final object, but for an
object with an undetermined oid, we don't know the exact directory for
the object.

Still, we need to save the temporary file we're preparing
somewhere. We'll do that in the top-level ".git/objects/"
directory (or whatever "GIT_OBJECT_DIRECTORY" is set to). Once we've
streamed it we'll know the OID, and will move it to its canonical
path.

"freshen_packed_object()" or "freshen_loose_object()" will be called
inside "stream_loose_object()" after obtaining the "oid".

Helped-by: René Scharfe <l.s.r@web.de>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c  | 100 +++++++++++++++++++++++++++++++++++++++++++++++++
 object-store.h |   8 ++++
 2 files changed, 108 insertions(+)

diff --git a/object-file.c b/object-file.c
index 7946fa5e088..9fd449693c4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2119,6 +2119,106 @@ static int freshen_packed_object(const struct object_id *oid)
 	return 1;
 }
 
+int stream_loose_object(struct input_stream *in_stream, size_t len,
+			struct object_id *oid)
+{
+	int fd, ret, err = 0, flush = 0;
+	unsigned char compressed[4096];
+	git_zstream stream;
+	git_hash_ctx c;
+	struct strbuf tmp_file = STRBUF_INIT;
+	struct strbuf filename = STRBUF_INIT;
+	int dirlen;
+	char hdr[MAX_HEADER_LEN];
+	int hdrlen;
+
+	/* Since oid is not determined, save tmp file to odb path. */
+	strbuf_addf(&filename, "%s/", get_object_directory());
+	hdrlen = format_object_header(hdr, sizeof(hdr), OBJ_BLOB, len);
+
+	/*
+	 * Common steps for write_loose_object and stream_loose_object to
+	 * start writing loose objects:
+	 *
+	 *  - Create tmpfile for the loose object.
+	 *  - Setup zlib stream for compression.
+	 *  - Start to feed header to zlib stream.
+	 */
+	fd = start_loose_object_common(&tmp_file, filename.buf, 0,
+				       &stream, compressed, sizeof(compressed),
+				       &c, hdr, hdrlen);
+	if (fd < 0) {
+		err = -1;
+		goto cleanup;
+	}
+
+	/* Then the data itself.. */
+	do {
+		unsigned char *in0 = stream.next_in;
+
+		if (!stream.avail_in && !in_stream->is_finished) {
+			const void *in = in_stream->read(in_stream, &stream.avail_in);
+			stream.next_in = (void *)in;
+			in0 = (unsigned char *)in;
+			/* All data has been read. */
+			if (in_stream->is_finished)
+				flush = 1;
+		}
+		ret = write_loose_object_common(&c, &stream, flush, in0, fd,
+						compressed, sizeof(compressed));
+		/*
+		 * Unlike write_loose_object(), we do not have the entire
+		 * buffer. If we get Z_BUF_ERROR due to too few input bytes,
+		 * then we'll replenish them in the next input_stream->read()
+		 * call when we loop.
+		 */
+	} while (ret == Z_OK || ret == Z_BUF_ERROR);
+
+	if (stream.total_in != len + hdrlen)
+		die(_("write stream object %ld != %"PRIuMAX), stream.total_in,
+		    (uintmax_t)len + hdrlen);
+
+	/* Common steps for write_loose_object and stream_loose_object to
+	 * end writing loose oject:
+	 *
+	 *  - End the compression of zlib stream.
+	 *  - Get the calculated oid.
+	 */
+	if (ret != Z_STREAM_END)
+		die(_("unable to stream deflate new object (%d)"), ret);
+	ret = end_loose_object_common(&c, &stream, oid);
+	if (ret != Z_OK)
+		die(_("deflateEnd on stream object failed (%d)"), ret);
+	close_loose_object(fd, tmp_file.buf);
+
+	if (freshen_packed_object(oid) || freshen_loose_object(oid)) {
+		unlink_or_warn(tmp_file.buf);
+		goto cleanup;
+	}
+
+	loose_object_path(the_repository, &filename, oid);
+
+	/* We finally know the object path, and create the missing dir. */
+	dirlen = directory_size(filename.buf);
+	if (dirlen) {
+		struct strbuf dir = STRBUF_INIT;
+		strbuf_add(&dir, filename.buf, dirlen);
+
+		if (mkdir_in_gitdir(dir.buf) && errno != EEXIST) {
+			err = error_errno(_("unable to create directory %s"), dir.buf);
+			strbuf_release(&dir);
+			goto cleanup;
+		}
+		strbuf_release(&dir);
+	}
+
+	err = finalize_object_file(tmp_file.buf, filename.buf);
+cleanup:
+	strbuf_release(&tmp_file);
+	strbuf_release(&filename);
+	return err;
+}
+
 int write_object_file_flags(const void *buf, unsigned long len,
 			    enum object_type type, struct object_id *oid,
 			    unsigned flags)
diff --git a/object-store.h b/object-store.h
index 539ea439046..5222ee54600 100644
--- a/object-store.h
+++ b/object-store.h
@@ -46,6 +46,12 @@ struct object_directory {
 	char *path;
 };
 
+struct input_stream {
+	const void *(*read)(struct input_stream *, unsigned long *len);
+	void *data;
+	int is_finished;
+};
+
 KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
 	struct object_directory *, 1, fspathhash, fspatheq)
 
@@ -269,6 +275,8 @@ static inline int write_object_file(const void *buf, unsigned long len,
 int write_object_file_literally(const void *buf, unsigned long len,
 				const char *type, struct object_id *oid,
 				unsigned flags);
+int stream_loose_object(struct input_stream *in_stream, size_t len,
+			struct object_id *oid);
 
 /*
  * Add an object file to the in-memory object store, without writing it
-- 
2.36.1.1124.g52838f02905


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEDEC433F5
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 00:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241670AbiCSAZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 20:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241656AbiCSAZA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 20:25:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DBA129267
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 17:23:40 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a1so12330304wrh.10
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 17:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/y8jbzPJyb7mtpwc16muIcITrGIfm2LZXN+ESJh5BNc=;
        b=YkKT9OpbicgKPgtYtMR2jir9huK6yy6gX2f87S3pBgoPophVyXsMVgSimSW0S2gQyk
         X0FJ3/m8dkg2JslLmU35u6Hz4xGlYS4V0Cj4bh2YdQuxjJhIJFxJzcCSSf8veyExJ+3b
         JGAUuFa+IM3ruqtuIyGwTIdYlZigbiOVp+/fxlDfwxFGEdRoWAy1wAYFdfjLDdymwdLn
         UkR1HGseQNesMzMuJJMj2DvGcO3aibU+WXHWYve5CaYowCl3iEhkbCMQlEUxIKeavO3H
         C0iRrYOnubrHbnwnJCC8szwZcFC0dGhgF+qdP9MdDH4DN/76BIsA8G1ww5CYR0ELcZ6Q
         k9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/y8jbzPJyb7mtpwc16muIcITrGIfm2LZXN+ESJh5BNc=;
        b=5pQpm+WzDLRe6YgI5zHpYl7SOgkuXART3iZmWt8DJ3qvqKefrs2S2Oa+Ye+AGJbyKs
         hl62jc4dp4sECJUIQvRcoh60QIkcxa3BZdTo/s2AEXsKks2cIJXMy1qw+wB/ioaWsS/r
         CJksESkXJauoA9h6FnId1WB2oSzb6+05JpsiuFR6cMt7bQSoQrZKeoVyxQQ8SGssIH7Z
         TDSTuQYHzaVD/yxHVz3G25kxQyKV/8Oh5xN1hkIGt5ANxlDAwuNzlacAmCSwH89aOvhF
         YyXPhSRApV6kWZ751YRu/+h5KGuQs+8faDFG+8+0u8BwvkzHeo7+WiZU2IwfSMzHJhSV
         46zQ==
X-Gm-Message-State: AOAM530t0cVn4SE5aIvSA2b5BeOVg+Gt2DzAcPgDBOILL60tWfPm2ELX
        8RcjBC2ti7VsrjkBzjX8cm/XSiVDFZ9U5g==
X-Google-Smtp-Source: ABdhPJw+pXsARxraYU5Fo7nK/7rOfYxU0mQQ1+HY3wL4VKQ075IFgKNjsCOYAQRHWVLJmqqQJDpEIg==
X-Received: by 2002:adf:c10b:0:b0:1ed:c40f:7f91 with SMTP id r11-20020adfc10b000000b001edc40f7f91mr9798486wre.276.1647649419242;
        Fri, 18 Mar 2022 17:23:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u25-20020a05600c211900b00389d4bdb3d2sm14865519wml.36.2022.03.18.17.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 17:23:38 -0700 (PDT)
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
Subject: [PATCH v11 5/8] object-file.c: add "stream_loose_object()" to handle large object
Date:   Sat, 19 Mar 2022 01:23:22 +0100
Message-Id: <patch-v11-5.8-db40f4160c4-20220319T001411Z-avarab@gmail.com>
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
 object-file.c  | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++
 object-store.h |  8 +++++
 2 files changed, 105 insertions(+)

diff --git a/object-file.c b/object-file.c
index b66dc24e4b8..548fef71b98 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2114,6 +2114,103 @@ static int freshen_packed_object(const struct object_id *oid)
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
+	end_loose_object_common(fd, ret, &c, &stream, oid, NULL,
+				N_("unable to stream deflate new object (%d)"),
+				N_("deflateEnd on stream object failed (%d)"));
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
index bd2322ed8ce..1099455bc2e 100644
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
 
@@ -261,6 +267,8 @@ static inline int write_object_file(const void *buf, unsigned long len,
 int write_object_file_literally(const void *buf, unsigned long len,
 				const char *type, struct object_id *oid,
 				unsigned flags);
+int stream_loose_object(struct input_stream *in_stream, size_t len,
+			struct object_id *oid);
 
 /*
  * Add an object file to the in-memory object store, without writing it
-- 
2.35.1.1438.g8874c8eeb35


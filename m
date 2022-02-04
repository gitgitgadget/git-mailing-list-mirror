Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88957C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 14:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359056AbiBDOHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 09:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359059AbiBDOH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 09:07:29 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929D9C061744
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 06:07:25 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id e8so11648117wrc.0
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 06:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qx2jN1+oovyW7PeJ0lgOI3FfhLdXaN8p+gdcJRMQqVk=;
        b=l+QkDK0Zr36bvweqdHE/ruq+BdTsuMpz/+Cy/V+VcHkkFtM2zGFjGqIsDa91XffH/M
         JLAnOO5kqQAwHhldEYHE3eP3IlLoxZdVsuLMQqIyOUtxRPKQVtORlXSk3esQ1k8T+kR2
         s31m8BhST0tKnjSmlq6UIdl/3jg9/IZDVUSQeMEJHPEM9tSP2/zS/LjsfFo7PGsHuSg8
         /sMiSEQeTDJoBmvLKbBdPFOkf7RuUkq+ZqXY07RgSaQrmc9MqoN/mhTxphrGDqrhXcYQ
         ZNP9jE9FPg/77YHcsKjwOvP6lj862lscPwWKNyYU0fd849GdtHTXg5XZ2xPxc6hE8KLx
         t4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qx2jN1+oovyW7PeJ0lgOI3FfhLdXaN8p+gdcJRMQqVk=;
        b=SBMQxEURrtD5Q8cXej/N8cKo22YFdYde8HM2IySSIv3tBtYDnJK0PyS9N2ue2D/P7R
         eDSXvERJSXVKY2+iMNKIU8498Gr0mGM+xu3o0HryvFZufOcm1vE6rRJJGQICtidmA1g7
         6KucgL1td9r7iJ444bCdkMmixQBHMmsLhzlZfKiaBvylgrJUpyYLJO4K+PFLKezANbJf
         z/LGXwkwnwWCDbfVxg/66klF54oqmuqKMlw2F047Yk77eLkRk88gsBULeWfp5+zllnCB
         9X/u/0+LaGqUtPVXt2EmDAkjYNDMwwRQE+Pu1zrY8NcDK5k4qShAjUBa+6a9LYaqrw8Z
         4ycw==
X-Gm-Message-State: AOAM530as2Gg2XpMC4mZkeQ7HBEG45arkbXCZjH65gRGblCF3TWxLFAz
        pzBaP4RM58E4LHAKmvL3CTsjDEd8L/xfYQ==
X-Google-Smtp-Source: ABdhPJwS+4mZ4Tp/Nnp7gnTXRBLznSkIV+91uWMgx5zyvVQ+moSzMER3mVgt78mdr/zjzkqSN3X2wQ==
X-Received: by 2002:a05:6000:170c:: with SMTP id n12mr2706595wrc.380.1643983643859;
        Fri, 04 Feb 2022 06:07:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u19sm618722wmm.0.2022.02.04.06.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 06:07:23 -0800 (PST)
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
Subject: [PATCH v10 4/6] object-file.c: add "stream_loose_object()" to handle large object
Date:   Fri,  4 Feb 2022 15:07:10 +0100
Message-Id: <patch-v10-4.6-9644df5c744-20220204T135538Z-avarab@gmail.com>
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
---
 object-file.c  | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++
 object-store.h |  8 ++++
 2 files changed, 107 insertions(+)

diff --git a/object-file.c b/object-file.c
index f5c579e42e3..2ef0bf0e5c3 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2095,6 +2095,105 @@ static int freshen_packed_object(const struct object_id *oid)
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
+	/* Common steps for write_loose_object and stream_loose_object to
+	 * start writing loose oject:
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
+		if (!stream.avail_in && !in_stream->is_finished) {
+			const void *in = in_stream->read(in_stream, &stream.avail_in);
+			stream.next_in = (void *)in;
+			in0 = (unsigned char *)in;
+			/* All data has been read. */
+			if (in_stream->is_finished)
+				flush = Z_FINISH;
+		}
+		ret = git_deflate(&stream, flush);
+		the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
+		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
+			die(_("unable to write loose object file"));
+		stream.next_out = compressed;
+		stream.avail_out = sizeof(compressed);
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
2.35.1.940.ge7a5b4b05f2


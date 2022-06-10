Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513A4C433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 14:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345716AbiFJOs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 10:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349657AbiFJOri (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 10:47:38 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C654A1DFC78
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 07:47:35 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 15so24061518pfy.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 07:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OSydusTpCLzo/fUiMaadZu62FxaITYOiofxgfkNJOjA=;
        b=bq4zPSqNRdpnxf0Bvd5/CPE/OwoCbM9VmlW6mAjds4YwsrZPLRwLzE0hEzEo3MzmHx
         rjzAlfEWusCPSmgkykLn+QrR7hgwdQ//iV6JIkrJbyW3bfD2VIRZuSfgl/RulUz0Zn2R
         A7ZWQC+o8Ff3dViKpHPVu1U77zjm9Q0J8MfPy5ZsWwCUD0rSR3QJA9ZMWPmxWUiC2U1m
         TOMg402JCustmrFqD/LBWPs9inXab/KyrMwqKR33ZSfMUhSZgPNtYnjrtl5EjDVRLQp/
         w+KiQ9n9ZNpF77QzHLcblV2Z7q2BcZZcXIV3Ub19zH8ie36etUC2sTNbnT9DdCT66aaE
         1+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OSydusTpCLzo/fUiMaadZu62FxaITYOiofxgfkNJOjA=;
        b=pfNGPY1UQMknmeaf83oQvos3tfHyRCnBc+3G9Eor2lJ6RCYoVYCTaBuOHuXgGwlbHO
         QMSP0biYrZXPu2Lf6u28O9EqBjE1UFIOhB/RKZJyKbI01yxFXZ1m6eXI0u22YPEF5E5p
         wxVDmDi5M8DkeDubru7IJRCaITeGeSlj6xBLPF68s+jchprbNu2rpbz4PKQFBXZ8cQpA
         0wskk060Tp1B7T1fGDsHj0emVPmYP7pryfaucz5bpArTAMMkPXDfmkiHecO1GKZtc4MJ
         G0LGHFe7gu9sUP/y48Ti2DCPyeBRbfBTboLC/rg4mA5+nIWZgev+mxnSokB8JLWLkudH
         B8iA==
X-Gm-Message-State: AOAM533deoz2U4zt8zt4F5OTbNfKiw4h3MzqA/h/D5ZvXoIfIz7LmrBr
        YkKu5viSQ6FLzuZg/2fThgQ=
X-Google-Smtp-Source: ABdhPJxEhvKvVa1Oqu/qAnrxfqbeOxuRs1dWUcpqQYiCfp5RHArjMM/L0j4zTADDfZMJvAvC8miy0g==
X-Received: by 2002:a05:6a00:194d:b0:51b:eb84:49b1 with SMTP id s13-20020a056a00194d00b0051beb8449b1mr36396563pfk.77.1654872455220;
        Fri, 10 Jun 2022 07:47:35 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id lx9-20020a17090b4b0900b001e292e30129sm1840434pjb.22.2022.06.10.07.47.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jun 2022 07:47:34 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     avarab@gmail.com
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>, chiyutianyi@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        neerajsi@microsoft.com, newren@gmail.com, philipoakley@iee.email,
        stolee@gmail.com, worldhello.net@gmail.com,
        Neeraj Singh <nksingh85@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v14 5/7] object-file.c: add "stream_loose_object()" to handle large object
Date:   Fri, 10 Jun 2022 22:46:05 +0800
Message-Id: <28a9588f9ceda2252d8ca9c4b3912177c45cb95c.1654871916.git.chiyutianyi@gmail.com>
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
inside "stream_loose_object()" after obtaining the "oid". After the
temporary file is written, we wants to mark the object to recent and we
may find that where indeed is already the object. We should remove the
temporary and do not leave a new copy of the object.

Helped-by: René Scharfe <l.s.r@web.de>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c  | 104 +++++++++++++++++++++++++++++++++++++++++++++++++
 object-store.h |   8 ++++
 2 files changed, 112 insertions(+)

diff --git a/object-file.c b/object-file.c
index cfae54762e..0b8383ad47 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2118,6 +2118,110 @@ static int freshen_packed_object(const struct object_id *oid)
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
+	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
+		prepare_loose_object_bulk_checkin();
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
+	/*
+	 * Common steps for write_loose_object and stream_loose_object to
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
index 539ea43904..5222ee5460 100644
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
2.36.1


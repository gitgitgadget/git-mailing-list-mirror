Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F18C433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 11:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiATLWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 06:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiATLWo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 06:22:44 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EC7C061760
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 03:22:36 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id pf13so5509713pjb.0
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 03:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IC4mYpN0/4sfgZirdG1vGwaVkgXKd0oYA1XTxuTF8cU=;
        b=LidNy+Bw/dwZHnSNmShoBRT7gZd28zs2QMUlZ2xzQhT4gNvliRqjU28jAJyhXPS15k
         D1CHeSHw8akR8jvR8X3vD3srX4cPZWvwfwm8nFaZtfkzPb+8lJEGg1xeNpQ1VpEev8XC
         eo0BkQDwHSCZfepqlPOzmdlA2rsB1ISt0CZrhNr+4KxFSWSfT6MzGwUwrttiKH9ZPdVv
         tQFxpC2/m017X2tXeagb2fqPLZPymce32rQ0x0WvE20MfWetGnTjO1LXWeATH/99UhFU
         9WX8yjzF3H0SaXyWhbQAiOI6upb9fO9O/rLMtYqvcYlo+QsDmIlz2v3gPVwqAkF0UNv1
         A1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IC4mYpN0/4sfgZirdG1vGwaVkgXKd0oYA1XTxuTF8cU=;
        b=QZVLyXswNCQedM3bogZ+BhBDMmJGDe3E/fz6VCS3JYfi556T7jxPF1Xyz2irU0/tld
         nr4RzZGCoMiSN9cgwqzOT694i7bFJJJ2CoeMo0Azpz6pjrry6BrFqEWy63sGfDDJlMDJ
         29iQRRctQK9j60MxlQYG4IJZ21OaKELL0TD0bPbKhEifVXqvro5MWKtbg1CIp3v8kpVv
         rIQ+v+lXh5eJvGe7HytOVDvwwqQGZxILzucpWrmYVDIFj6lCGBcUNfzc2Q9hOaLxbRGe
         0MY8D61Nj/Y5D7C/+fCT8L63qcteSJgy7qFuCjhrpl0M4YXXnF+yVjQZomAwAvbKZhbE
         I4ig==
X-Gm-Message-State: AOAM530ixMJ156Y35B0vOjyWAlAKYFT7YrSCU7ZI/Qdt42fOKUuT8RIZ
        sS8oHXit40GlwImwbmPnyqw=
X-Google-Smtp-Source: ABdhPJzN7gPCjzA97xmaIguhnYVGtFEkg3rNXATAQLRWlyU/BUHG2cyEwv22bClCQE7g3pAuu6xQIQ==
X-Received: by 2002:a17:902:e541:b0:14a:59cc:3095 with SMTP id n1-20020a170902e54100b0014a59cc3095mr36804744plf.151.1642677755623;
        Thu, 20 Jan 2022 03:22:35 -0800 (PST)
Received: from localhost.localdomain ([58.100.34.57])
        by smtp.gmail.com with ESMTPSA id x18sm2998989pfh.192.2022.01.20.03.22.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jan 2022 03:22:35 -0800 (PST)
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
Subject: [PATCH v9 3/5] object-file.c: add "stream_loose_object()" to handle large object
Date:   Thu, 20 Jan 2022 19:21:12 +0800
Message-Id: <20220120112114.47618-4-chiyutianyi@gmail.com>
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

If we want unpack and write a loose object using "write_loose_object",
we have to feed it with a buffer with the same size of the object, which
will consume lots of memory and may cause OOM. This can be improved by
feeding data to "stream_loose_object()" in a stream.

Add a new function "stream_loose_object()", which is a stream version of
"write_loose_object()" but with a low memory footprint. We will use this
function to unpack large blob object in latter commit.

Another difference with "write_loose_object()" is that we have no chance
to run "write_object_file_prepare()" to calculate the oid in advance.
In "write_loose_object()", we know the oid and we can write the
temporary file in the same directory as the final object, but for an
object with an undetermined oid, we don't know the exact directory for
the object, so we have to save the temporary file in ".git/objects/"
directory instead.

"freshen_packed_object()" or "freshen_loose_object()" will be called
inside "stream_loose_object()" after obtaining the "oid".

Helped-by: René Scharfe <l.s.r@web.de>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c  | 101 +++++++++++++++++++++++++++++++++++++++++++++++++
 object-store.h |   9 +++++
 2 files changed, 110 insertions(+)

diff --git a/object-file.c b/object-file.c
index 422b43212a..a738f47cb2 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1996,6 +1996,107 @@ static int freshen_packed_object(const struct object_id *oid)
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
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX, type_name(OBJ_BLOB), len) + 1;
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
+	end_loose_object_common(ret, &c, &stream, oid, NULL,
+				N_("unable to stream deflate new object (%d)"),
+				N_("deflateEnd on stream object failed (%d)"));
+
+	close_loose_object(fd);
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
 			    const char *type, struct object_id *oid,
 			    unsigned flags)
diff --git a/object-store.h b/object-store.h
index 952efb6a4b..cc41c64d69 100644
--- a/object-store.h
+++ b/object-store.h
@@ -34,6 +34,12 @@ struct object_directory {
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
 
@@ -232,6 +238,9 @@ static inline int write_object_file(const void *buf, unsigned long len,
 	return write_object_file_flags(buf, len, type, oid, 0);
 }
 
+int stream_loose_object(struct input_stream *in_stream, size_t len,
+			struct object_id *oid);
+
 int hash_object_file_literally(const void *buf, unsigned long len,
 			       const char *type, struct object_id *oid,
 			       unsigned flags);
-- 
2.34.1.52.gc288e771b4.agit.6.5.6


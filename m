Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B0BC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 11:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbhLULyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 06:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbhLULy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 06:54:29 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E086BC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 03:54:28 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id a11-20020a17090a854b00b001b11aae38d6so2988935pjw.2
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 03:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lIqUgiIIGqudgWavCOFk/d55BKq4TNgLX/VbG+IpJ9w=;
        b=COnbZXOCakXfC7tii+LF1YJ/ZL46I8/nWjt3ztoy9c/3AhXC3edGhYlT8DfBSFr7YE
         /PTwQchCByJFCamlKFTMTsZAVlUEg41W47A+KIZnYhFY/uEdrKfVr+wESqdMQZc3E3GV
         eM2NxnAddZic7EbCChZ0ezauPosIwiwwIJ1Y5QKYniu5uPti6zZmuy0pSy4Bh4okl+e6
         ULq340J/EysnCKMfeCSqhZ1uYBLMBhSFfX4v1AD9fCf8EciLvBBowje0n6nAbSI5xXoY
         mdHzUjcIEr1tWn9j/+guVzodQCG1QXiULQY4XeLwwUWIllf1dNESw8l74BwazIREvZPl
         aFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lIqUgiIIGqudgWavCOFk/d55BKq4TNgLX/VbG+IpJ9w=;
        b=t6O9uGQU/WfcyJ5mwh1x+9w9wMrcYThgjG/fa9epPPEztH9HKzKrmiB3aE+7nUTwWW
         sUC+/9loq9mhxgVC5EUl4+1vJKl66+91dGtqsBQTCEEEcyIOD3BcLOEpj+iGYVSJ12Wb
         kOHCbHoqUMiHFdvd8Hd3af/X33Ujtu8ywBQ1z9JLD60nJghcswyOcmIwokBMXr+/sk6N
         a6LTlCn7EkG+TqWxQO3ojQs8FDsAcYLuYzmWukDoVs/sCDU/N+y49AGSsaPrZlzvNYxK
         41WlpKH4lBpV+zYShF7EcooZcxhk0HQKwxqpRQFT3ZZ18UEt5O6kN1KcPUTUbInmvp7j
         TqTA==
X-Gm-Message-State: AOAM5319IGw2Jn2TMkpg7bnN0s3jvGKMronYWM95b+dRSJlYAfkA5eEB
        VN8Btve6voHq0I4irz+aDN0=
X-Google-Smtp-Source: ABdhPJxtrW13BFQcLrN3WxeYA7zGzs3dBzjGrHhIEQ6u+IVVd/tBkkStLWrDApOxn1OaxyZPZBZ0MA==
X-Received: by 2002:a17:90b:1812:: with SMTP id lw18mr3621680pjb.196.1640087668482;
        Tue, 21 Dec 2021 03:54:28 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id s30sm20513742pfw.57.2021.12.21.03.54.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Dec 2021 03:54:27 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v7 4/5] object-file.c: add "write_stream_object_file()" to support read in stream
Date:   Tue, 21 Dec 2021 19:52:00 +0800
Message-Id: <20211221115201.12120-5-chiyutianyi@gmail.com>
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

This can be improved by feeding data to "write_stream_object_file()"
in a stream. The input stream is implemented as an interface.

The difference with "write_loose_object()" is that we have no chance
to run "write_object_file_prepare()" to calculate the oid in advance.
In "write_loose_object()", we know the oid and we can write the
temporary file in the same directory as the final object, but for an
object with an undetermined oid, we don't know the exact directory for
the object, so we have to save the temporary file in ".git/objects/"
directory instead.

"freshen_packed_object()" or "freshen_loose_object()" will be called
inside "write_stream_object_file()" after obtaining the "oid".

Helped-by: René Scharfe <l.s.r@web.de>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c  | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++
 object-store.h |  9 ++++++
 2 files changed, 94 insertions(+)

diff --git a/object-file.c b/object-file.c
index e048f3d39e..d0573e2a61 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1989,6 +1989,91 @@ static int freshen_packed_object(const struct object_id *oid)
 	return 1;
 }
 
+int write_stream_object_file(struct input_stream *in_stream, size_t len,
+			     enum object_type type, time_t mtime,
+			     unsigned flags, struct object_id *oid)
+{
+	int fd, ret, flush = 0;
+	unsigned char compressed[4096];
+	git_zstream stream;
+	git_hash_ctx c;
+	struct object_id parano_oid;
+	static struct strbuf tmp_file = STRBUF_INIT;
+	static struct strbuf filename = STRBUF_INIT;
+	int dirlen;
+	char hdr[MAX_HEADER_LEN];
+	int hdrlen = sizeof(hdr);
+
+	/* Since "filename" is defined as static, it will be reused. So reset it
+	 * first before using it. */
+	strbuf_reset(&filename);
+	/* When oid is not determined, save tmp file to odb path. */
+	strbuf_addf(&filename, "%s/", get_object_directory());
+
+	fd = create_tmpfile(&tmp_file, filename.buf, flags);
+	if (fd < 0)
+		return -1;
+
+	hdrlen = format_object_header(hdr, hdrlen, type, len);
+
+	/* Set it up and write header */
+	setup_stream_and_header(&stream, compressed, sizeof(compressed),
+				&c, hdr, hdrlen);
+
+	/* Then the data itself.. */
+	do {
+		unsigned char *in0 = stream.next_in;
+		if (!stream.avail_in) {
+			const void *in = in_stream->read(in_stream, &stream.avail_in);
+			stream.next_in = (void *)in;
+			in0 = (unsigned char *)in;
+			/* All data has been read. */
+			if (len + hdrlen == stream.total_in + stream.avail_in)
+				flush = Z_FINISH;
+		}
+		ret = git_deflate(&stream, flush);
+		the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
+		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
+			die(_("unable to write loose object file"));
+		stream.next_out = compressed;
+		stream.avail_out = sizeof(compressed);
+	} while (ret == Z_OK || ret == Z_BUF_ERROR);
+
+	if (ret != Z_STREAM_END)
+		die(_("unable to deflate new object streamingly (%d)"), ret);
+	ret = git_deflate_end_gently(&stream);
+	if (ret != Z_OK)
+		die(_("deflateEnd on object streamingly failed (%d)"), ret);
+	the_hash_algo->final_oid_fn(&parano_oid, &c);
+
+	close_loose_object(fd);
+
+	oidcpy(oid, &parano_oid);
+
+	if (freshen_packed_object(oid) || freshen_loose_object(oid)) {
+		unlink_or_warn(tmp_file.buf);
+		return 0;
+	}
+
+	loose_object_path(the_repository, &filename, oid);
+
+	/* We finally know the object path, and create the missing dir. */
+	dirlen = directory_size(filename.buf);
+	if (dirlen) {
+		struct strbuf dir = STRBUF_INIT;
+		strbuf_add(&dir, filename.buf, dirlen - 1);
+
+		if (mkdir_in_gitdir(dir.buf) && errno != EEXIST) {
+			ret = error_errno(_("unable to create directory %s"), dir.buf);
+			strbuf_release(&dir);
+			return ret;
+		}
+		strbuf_release(&dir);
+	}
+
+	return finalize_object_file_with_mtime(tmp_file.buf, filename.buf, mtime, flags);
+}
+
 int write_object_file_flags(const void *buf, unsigned long len,
 			    const char *type, struct object_id *oid,
 			    unsigned flags)
diff --git a/object-store.h b/object-store.h
index 952efb6a4b..061b0cb2ba 100644
--- a/object-store.h
+++ b/object-store.h
@@ -34,6 +34,11 @@ struct object_directory {
 	char *path;
 };
 
+struct input_stream {
+	const void *(*read)(struct input_stream *, unsigned long *len);
+	void *data;
+};
+
 KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
 	struct object_directory *, 1, fspathhash, fspatheq)
 
@@ -232,6 +237,10 @@ static inline int write_object_file(const void *buf, unsigned long len,
 	return write_object_file_flags(buf, len, type, oid, 0);
 }
 
+int write_stream_object_file(struct input_stream *in_stream, size_t len,
+			     enum object_type type, time_t mtime,
+			     unsigned flags, struct object_id *oid);
+
 int hash_object_file_literally(const void *buf, unsigned long len,
 			       const char *type, struct object_id *oid,
 			       unsigned flags);
-- 
2.34.1.52.g80008efde6.agit.6.5.6


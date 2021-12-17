Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F370FC433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 11:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhLQL2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 06:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbhLQL2u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 06:28:50 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC80CC061748
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 03:28:48 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id i12so2007859pfd.6
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 03:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9b/kbTf93FICYFAHzMSp6LAyX1Enp1KYcKj79dnWGi8=;
        b=pVtInAOiE8Ysa5yHOb0lBfxCtVlr9H+H+ul6U4iTJaotlKeTwWWe5fEi6ye4wJ4K9O
         LBB6Du0hZvQNi1BD0PsUCCiNSzMAmj0j/QDKe1qTM9S+zo9F+AvyzJid6/uOPSn3iLUK
         Kx4up4JZLy1ZqZWmYJ3DCmGar11GGIOH8a7fuqHGeb46WDkaHbK13jWEQhmd+aNa4ho9
         ESohPgUWsbotD5ag3+dvMFZzyzvluBTRAv8N5uyGRyQ6YDJ7tYgCXTTUjfIk3+wybkto
         cJtk7V0ofGTzWJ7WHYB0Ip+zK284J+wfItjE90dd6vsRg0HkUDR9Qga9BrtTRYxZN1y4
         APzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9b/kbTf93FICYFAHzMSp6LAyX1Enp1KYcKj79dnWGi8=;
        b=Voo6veaHMUVox2BGIRCL8KkPNTHCtZ/c1y3TXPG7Y4ZGwiMKDmofePxr06WEQuzUNq
         6Wr1vVNHiZ2MGcRqz/Kk1tO65mmdWPPi5j5pfUvQz+WWL+Ny/rJK/5IxYp02XirM6e3t
         SL2Fj3/A5ps510A0CFnjg7eEJJsg2iEDeeywsu3ik3BZ/4TKQDtaF+PM4oX2O3/cWUtt
         +SnkkZbUrfR8abthVQBS0t4nXOhI4LzbELTr9h8mhyMobEVr4NYuWxdku8IPS4sL9Xaf
         AumQE6R4YTndhlveL5PdV568yprchX/cL8kmx0NVHoLZEVBrNYkis8F9xII67PTXDshI
         lvEg==
X-Gm-Message-State: AOAM533CVKiLAglztm3SbcgaB1/Q8Fv2+igX1EyVOBzTgiQWkHrfiXhW
        Vx5TDfhtR3FMZeU6P20ZlnI=
X-Google-Smtp-Source: ABdhPJyGuaVNN6wAb1TbZD/YGpcocyFCV74Aos07dOYCt0+nKLq6O6KGFv+KraVkKf9NpOExn4IV1w==
X-Received: by 2002:a05:6a00:b89:b0:4ae:d9a3:ccf9 with SMTP id g9-20020a056a000b8900b004aed9a3ccf9mr2681075pfj.13.1639740528370;
        Fri, 17 Dec 2021 03:28:48 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.97])
        by smtp.gmail.com with ESMTPSA id f10sm5194673pge.33.2021.12.17.03.28.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Dec 2021 03:28:48 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v6 4/6] object-file.c: make "write_object_file_flags()" to support read in stream
Date:   Fri, 17 Dec 2021 19:26:27 +0800
Message-Id: <20211217112629.12334-5-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.1.52.gfcc2252aea.agit.6.5.6
In-Reply-To: <20211210103435.83656-1-chiyutianyi@gmail.com>
References: <20211210103435.83656-1-chiyutianyi@gmail.com>
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

This can be improved by feeding data to "stream_loose_object()" in a
stream. The input stream is implemented as an interface.

When streaming a large blob object to "write_loose_object()", we have no
chance to run "write_object_file_prepare()" to calculate the oid in
advance. So we need to handle undetermined oid in a new function called
"stream_loose_object()".

In "write_loose_object()", we know the oid and we can write the
temporary file in the same directory as the final object, but for an
object with an undetermined oid, we don't know the exact directory for
the object, so we have to save the temporary file in ".git/objects/"
directory instead.

We will reuse "write_object_file_flags()" in "unpack_non_delta_entry()" to
read the entire data contents in stream, so a new flag "HASH_STREAM" is
added. When read in stream, we needn't prepare the "oid" before
"write_loose_object()", only generate the header.
"freshen_packed_object()" or "freshen_loose_object()" will be called
inside "stream_loose_object()" after obtaining the "oid".

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 cache.h        |  1 +
 object-file.c  | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++
 object-store.h |  5 +++
 3 files changed, 98 insertions(+)

diff --git a/cache.h b/cache.h
index cfba463aa9..6d68fd10a3 100644
--- a/cache.h
+++ b/cache.h
@@ -898,6 +898,7 @@ int ie_modified(struct index_state *, const struct cache_entry *, struct stat *,
 #define HASH_FORMAT_CHECK 2
 #define HASH_RENORMALIZE  4
 #define HASH_SILENT 8
+#define HASH_STREAM 16
 int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
diff --git a/object-file.c b/object-file.c
index dd29e5372e..2ef1d4fb00 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1994,6 +1994,88 @@ static int freshen_packed_object(const struct object_id *oid)
 	return 1;
 }
 
+static int stream_loose_object(struct object_id *oid, char *hdr, int hdrlen,
+			       const struct input_stream *in_stream,
+			       unsigned long len, time_t mtime, unsigned flags)
+{
+	int fd, ret, err = 0, flush = 0;
+	unsigned char compressed[4096];
+	git_zstream stream;
+	git_hash_ctx c;
+	struct object_id parano_oid;
+	static struct strbuf tmp_file = STRBUF_INIT;
+	static struct strbuf filename = STRBUF_INIT;
+	int dirlen;
+
+	/* When oid is not determined, save tmp file to odb path. */
+	strbuf_addf(&filename, "%s/", get_object_directory());
+
+	fd = create_tmpfile(&tmp_file, filename.buf, flags);
+	if (fd < 0) {
+		err = -1;
+		goto cleanup;
+	}
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
+		goto cleanup;
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
+		if (mkdir_in_gitdir(dir.buf) < 0) {
+			err = -1;
+			goto cleanup;
+		}
+	}
+
+	err = finalize_object_file_with_mtime(tmp_file.buf, filename.buf, mtime, flags);
+cleanup:
+	strbuf_release(&tmp_file);
+	strbuf_release(&filename);
+	return err;
+}
+
 int write_object_file_flags(const void *buf, unsigned long len,
 			    const char *type, struct object_id *oid,
 			    unsigned flags)
@@ -2001,6 +2083,16 @@ int write_object_file_flags(const void *buf, unsigned long len,
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
 
+	/* When streaming a large blob object (marked as HASH_STREAM),
+	 * we have no chance to run "write_object_file_prepare()" to
+	 * calculate the "oid" in advance.  Call "stream_loose_object()"
+	 * to write loose object in stream.
+	 */
+	if (flags & HASH_STREAM) {
+		hdrlen = generate_object_header(hdr, hdrlen, type, len);
+		return stream_loose_object(oid, hdr, hdrlen, buf, len, 0, flags);
+	}
+
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
 	 */
diff --git a/object-store.h b/object-store.h
index 952efb6a4b..4040e2c40a 100644
--- a/object-store.h
+++ b/object-store.h
@@ -34,6 +34,11 @@ struct object_directory {
 	char *path;
 };
 
+struct input_stream {
+	const void *(*read)(const struct input_stream *, unsigned long *len);
+	void *data;
+};
+
 KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
 	struct object_directory *, 1, fspathhash, fspatheq)
 
-- 
2.34.1.52.gfcc2252aea.agit.6.5.6


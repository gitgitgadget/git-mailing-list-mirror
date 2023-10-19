Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC8832C98
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 17:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="A68w18bZ"
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF096116
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:28:44 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a82c2eb50cso82534527b3.2
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697736524; x=1698341324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CXSMvWY7CKzijXjlyWkNKG+D2kaCAJngmGwvnqvSxtQ=;
        b=A68w18bZ3WWAmDNZAy9yoMA639gfuvXGO/cYedpDw+/ZCqoy0yEW67CSXLxIgzBj+Y
         wW4KGIgU4MRyXI9MDSTAFqOFRvme/6oMzaKBmqdanJE5Wz2VE15M2quzyKqsvaRk4Ool
         1qJR0VyTJLVnQcdCnD2Vn6OS/mxlEmddbkTfBqP1PFfHv3yBRIrBjoQHP4B++Zkv6UAU
         8KOJxUTYki4wCz8u3dw52LkA9Q+rmWgWDtfhcPaHAsbGF3YQGnPNP89BWr041+NeWo39
         h4V1NN1MfYxM8UfIK2R38XhPLvdOWfEXlovM0AUQ70ThDpHAab241J/ngM1mQe3h2UgQ
         fQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697736524; x=1698341324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXSMvWY7CKzijXjlyWkNKG+D2kaCAJngmGwvnqvSxtQ=;
        b=OxXW3C7X2TVFc/rXHMA7HDlxpxHq4IEKWYCg8/B3jJ8AldJKCwGPR05s3CXrgakuwT
         v6Sg1mKvOhqDLxtnafchZQp5M410SSBO2tmn2cTJPUDUM2fWEGm2740o5L/bgLR/sUfm
         +90Y6FJjwuOKJPDWMB3dm+xOU0UcnRMBc7l9brq22Xhqx1stXOEro4QE8ykvwgodjM+L
         TGAS8ESdb0Wdja0bqfXp5eaNLX/BVdlQEgBsjx5kf2VrbUb/8L2ztA1hs08+POMUNSG+
         T94NxHEHlQV7a7iusrbKzSMig+LD/WAfscrnKMk0ZQ8X8TbwdoJvZrFKxjWAXUYOvGLh
         r0mg==
X-Gm-Message-State: AOJu0YzkuHZT9q7iesTGvGl+CES1fJfdQxOJG1ocKR8UOjhRR8u8PaaF
	Ca9yB/dUaMHFQIBJIfwAkLYq/gBZRM6zyRP7p0wjYA==
X-Google-Smtp-Source: AGHT+IGaF/IeQ+ZQjGgDypGW4Bvd5FFze9sbZ9c0pijt0+iKs2g0dzn379DSd1d60RXhxM0CmLBT/g==
X-Received: by 2002:a0d:e606:0:b0:5a7:af9d:53fd with SMTP id p6-20020a0de606000000b005a7af9d53fdmr2921411ywe.9.1697736523872;
        Thu, 19 Oct 2023 10:28:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t22-20020a05620a0b1600b007757eddae8bsm903327qkg.62.2023.10.19.10.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 10:28:43 -0700 (PDT)
Date: Thu, 19 Oct 2023 13:28:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 1/7] bulk-checkin: extract abstract `bulk_checkin_source`
Message-ID: <97bb6e9f59e5092f0519c7d1141d0673313fdc33.1697736516.git.me@ttaylorr.com>
References: <cover.1697736516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697736516.git.me@ttaylorr.com>

A future commit will want to implement a very similar routine as in
`stream_blob_to_pack()` with two notable changes:

  - Instead of streaming just OBJ_BLOBs, this new function may want to
    stream objects of arbitrary type.

  - Instead of streaming the object's contents from an open
    file-descriptor, this new function may want to "stream" its contents
    from memory.

To avoid duplicating a significant chunk of code between the existing
`stream_blob_to_pack()`, extract an abstract `bulk_checkin_source`. This
concept currently is a thin layer of `lseek()` and `read_in_full()`, but
will grow to understand how to perform analogous operations when writing
out an object's contents from memory.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 61 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 6ce62999e5..c05d06e1e1 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -140,8 +140,41 @@ static int already_written(struct bulk_checkin_packfile *state, struct object_id
 	return 0;
 }
 
+struct bulk_checkin_source {
+	enum { SOURCE_FILE } type;
+
+	/* SOURCE_FILE fields */
+	int fd;
+
+	/* common fields */
+	size_t size;
+	const char *path;
+};
+
+static off_t bulk_checkin_source_seek_to(struct bulk_checkin_source *source,
+					 off_t offset)
+{
+	switch (source->type) {
+	case SOURCE_FILE:
+		return lseek(source->fd, offset, SEEK_SET);
+	default:
+		BUG("unknown bulk-checkin source: %d", source->type);
+	}
+}
+
+static ssize_t bulk_checkin_source_read(struct bulk_checkin_source *source,
+					void *buf, size_t nr)
+{
+	switch (source->type) {
+	case SOURCE_FILE:
+		return read_in_full(source->fd, buf, nr);
+	default:
+		BUG("unknown bulk-checkin source: %d", source->type);
+	}
+}
+
 /*
- * Read the contents from fd for size bytes, streaming it to the
+ * Read the contents from 'source' for 'size' bytes, streaming it to the
  * packfile in state while updating the hash in ctx. Signal a failure
  * by returning a negative value when the resulting pack would exceed
  * the pack size limit and this is not the first object in the pack,
@@ -157,7 +190,7 @@ static int already_written(struct bulk_checkin_packfile *state, struct object_id
  */
 static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 			       git_hash_ctx *ctx, off_t *already_hashed_to,
-			       int fd, size_t size, const char *path,
+			       struct bulk_checkin_source *source,
 			       unsigned flags)
 {
 	git_zstream s;
@@ -167,22 +200,28 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 	int status = Z_OK;
 	int write_object = (flags & HASH_WRITE_OBJECT);
 	off_t offset = 0;
+	size_t size = source->size;
 
 	git_deflate_init(&s, pack_compression_level);
 
-	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_BLOB, size);
+	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_BLOB,
+					      size);
 	s.next_out = obuf + hdrlen;
 	s.avail_out = sizeof(obuf) - hdrlen;
 
 	while (status != Z_STREAM_END) {
 		if (size && !s.avail_in) {
 			ssize_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
-			ssize_t read_result = read_in_full(fd, ibuf, rsize);
+			ssize_t read_result;
+
+			read_result = bulk_checkin_source_read(source, ibuf,
+							       rsize);
 			if (read_result < 0)
-				die_errno("failed to read from '%s'", path);
+				die_errno("failed to read from '%s'",
+					  source->path);
 			if (read_result != rsize)
 				die("failed to read %d bytes from '%s'",
-				    (int)rsize, path);
+				    (int)rsize, source->path);
 			offset += rsize;
 			if (*already_hashed_to < offset) {
 				size_t hsize = offset - *already_hashed_to;
@@ -258,6 +297,12 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	unsigned header_len;
 	struct hashfile_checkpoint checkpoint = {0};
 	struct pack_idx_entry *idx = NULL;
+	struct bulk_checkin_source source = {
+		.type = SOURCE_FILE,
+		.fd = fd,
+		.size = size,
+		.path = path,
+	};
 
 	seekback = lseek(fd, 0, SEEK_CUR);
 	if (seekback == (off_t) -1)
@@ -283,7 +328,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 			crc32_begin(state->f);
 		}
 		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
-					 fd, size, path, flags))
+					 &source, flags))
 			break;
 		/*
 		 * Writing this object to the current pack will make
@@ -295,7 +340,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 		hashfile_truncate(state->f, &checkpoint);
 		state->offset = checkpoint.offset;
 		flush_bulk_checkin_packfile(state);
-		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
+		if (bulk_checkin_source_seek_to(&source, seekback) == (off_t)-1)
 			return error("cannot seek back");
 	}
 	the_hash_algo->final_oid_fn(result_oid, &ctx);
-- 
2.42.0.405.g86fe3250c2


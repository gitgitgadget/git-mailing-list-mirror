Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34A7224DE
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="arSgZaDz"
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE4D10D
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:44:58 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so2981738276.1
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698101097; x=1698705897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M69HJlHcyV0wktY2lfvWR+t+JHaDI+2avkioFDrDme8=;
        b=arSgZaDzAIiDIK4Svq6afuyz2VOC/s2fjC0P8KZGSdnn5RVVyaszZZs+Up6zAJg8g/
         AAbShMIRrdlAez8aIN/evSHNe36zXad4eDQmRidJfmnRwoKYOKpnA//eBR7DQ+4plrPD
         PtE7djgjouWGXHf/X/KIoRG6O9WWGDBheJVXBJyYwP4mO+DfhKDp12gYCTz4MpwQ04Ot
         REvoNtQenLxKYxp8oe5WzAc7MaxzNC4/aiZ5Y4pBzzpDTYuZdtEdMluRMr4dIOCc2/W5
         wnVMWax7GHYovguCuCwB/LzLtTBcFhO+hQRDVyNzWrSJRh1LAigppepCQvQKznJAN8aW
         88MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698101097; x=1698705897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M69HJlHcyV0wktY2lfvWR+t+JHaDI+2avkioFDrDme8=;
        b=AEeo5xdECNNpwW1vErsuQgaqVwqi2SUJXi1Pg93tA/oTgIYtWwH2OWpH/RStQ/VGUu
         2BBZprU4LydvZq40hs4c8Ifah4+cnamIEpV8LioEIyNsddZlkrJ7sSSz7LJ4BFw8uh7M
         DQWZPosvOx9QQBah/gQXPiWVCUsI4/H7V3p4jcmdt1O7MhXBJs1oGRhLwEiL16du7grt
         GOHrP90Xmt8OXuW4jU0Djfx+Wwku2u0NOWmgHcg9EhcOiHsN2mPlnJbVThwv/WV0WZ4V
         69702UlpdJVK00CdG6eQuTmdfWfNb5Nn8hIaScGKVybw3QHFc7SiDH2tn9R6XqL/sk6f
         j2/w==
X-Gm-Message-State: AOJu0YwDuK3KqYNBks6loK3vqShF1uDZtsoKFLmxnFdTVyWRBpEzBJE2
	PcJeG+Yl/pXlsUIu0X2n1EDHrL7F+RFbpZrseH0jOw==
X-Google-Smtp-Source: AGHT+IF/GPHnwBbFW2mZ1jE7FoStvMUazfz0RElwNDHu2rderW1QvDe1evx3zjMP6J7Tw3t/h79jbw==
X-Received: by 2002:a05:6902:1504:b0:d9a:b70c:d32b with SMTP id q4-20020a056902150400b00d9ab70cd32bmr10919532ybu.41.1698101097219;
        Mon, 23 Oct 2023 15:44:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 205-20020a2505d6000000b00d814d8dfd69sm3075560ybf.27.2023.10.23.15.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 15:44:56 -0700 (PDT)
Date: Mon, 23 Oct 2023 18:44:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 1/5] bulk-checkin: extract abstract `bulk_checkin_source`
Message-ID: <696aa027e46ddec310812fad2d4b12082447d925.1698101088.git.me@ttaylorr.com>
References: <cover.1697736516.git.me@ttaylorr.com>
 <cover.1698101088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1698101088.git.me@ttaylorr.com>

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
 bulk-checkin.c | 65 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 8 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 6ce62999e5..174a6c24e4 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -140,8 +140,49 @@ static int already_written(struct bulk_checkin_packfile *state, struct object_id
 	return 0;
 }
 
+struct bulk_checkin_source {
+	off_t (*read)(struct bulk_checkin_source *, void *, size_t);
+	off_t (*seek)(struct bulk_checkin_source *, off_t);
+
+	union {
+		struct {
+			int fd;
+		} from_fd;
+	} data;
+
+	size_t size;
+	const char *path;
+};
+
+static off_t bulk_checkin_source_read_from_fd(struct bulk_checkin_source *source,
+					      void *buf, size_t nr)
+{
+	return read_in_full(source->data.from_fd.fd, buf, nr);
+}
+
+static off_t bulk_checkin_source_seek_from_fd(struct bulk_checkin_source *source,
+					      off_t offset)
+{
+	return lseek(source->data.from_fd.fd, offset, SEEK_SET);
+}
+
+static void init_bulk_checkin_source_from_fd(struct bulk_checkin_source *source,
+					     int fd, size_t size,
+					     const char *path)
+{
+	memset(source, 0, sizeof(struct bulk_checkin_source));
+
+	source->read = bulk_checkin_source_read_from_fd;
+	source->seek = bulk_checkin_source_seek_from_fd;
+
+	source->data.from_fd.fd = fd;
+
+	source->size = size;
+	source->path = path;
+}
+
 /*
- * Read the contents from fd for size bytes, streaming it to the
+ * Read the contents from 'source' for 'size' bytes, streaming it to the
  * packfile in state while updating the hash in ctx. Signal a failure
  * by returning a negative value when the resulting pack would exceed
  * the pack size limit and this is not the first object in the pack,
@@ -157,7 +198,7 @@ static int already_written(struct bulk_checkin_packfile *state, struct object_id
  */
 static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 			       git_hash_ctx *ctx, off_t *already_hashed_to,
-			       int fd, size_t size, const char *path,
+			       struct bulk_checkin_source *source,
 			       unsigned flags)
 {
 	git_zstream s;
@@ -167,22 +208,27 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
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
+			read_result = source->read(source, ibuf, rsize);
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
@@ -258,6 +304,9 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	unsigned header_len;
 	struct hashfile_checkpoint checkpoint = {0};
 	struct pack_idx_entry *idx = NULL;
+	struct bulk_checkin_source source;
+
+	init_bulk_checkin_source_from_fd(&source, fd, size, path);
 
 	seekback = lseek(fd, 0, SEEK_CUR);
 	if (seekback == (off_t) -1)
@@ -283,7 +332,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 			crc32_begin(state->f);
 		}
 		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
-					 fd, size, path, flags))
+					 &source, flags))
 			break;
 		/*
 		 * Writing this object to the current pack will make
@@ -295,7 +344,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 		hashfile_truncate(state->f, &checkpoint);
 		state->offset = checkpoint.offset;
 		flush_bulk_checkin_packfile(state);
-		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
+		if (source.seek(&source, seekback) == (off_t)-1)
 			return error("cannot seek back");
 	}
 	the_hash_algo->final_oid_fn(result_oid, &ctx);
-- 
2.42.0.425.g963d08ddb3.dirty


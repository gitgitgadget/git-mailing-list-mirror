Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7623FB26
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="foESqzsq"
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FAB3588
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:08:11 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-41b7ec4cceeso14614251cf.1
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697648884; x=1698253684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xa+7gCAWaHsWWVREEEId/KoMSu/bRPLyZxQYLtv6Uzw=;
        b=foESqzsqzc+aXvwfu5au0yhIcbq9VmUX8TyfHCLwm0IlHD+/Eo3yyeIQeat38sQ7YE
         uTl0uIPeYYrQ8lsBCkYWYCJOQeoGUVYaAeuZIMPSV6PYQyDx/qVZSkbSgfjGEwW6aw/4
         yPawhyIr5/PqZ82FzSgRB5P2vssxqas47gu6aaSMQBhYnOZhnMrlw8vthmRTrSrt/MR8
         QoATE4T3PT7+ZyXHxmyOWpq8Gr2p6O2atwJ8Au4ktSQ4nlEhIVPonWAasUOC4xwVmKh3
         a+r2YgsBqAMn/aovS5WVG5SODIjk8KPFjp18FfgrPT6TkEaa6eSiP6y3S5hCiS7uqJKI
         wn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648884; x=1698253684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xa+7gCAWaHsWWVREEEId/KoMSu/bRPLyZxQYLtv6Uzw=;
        b=aPmiCogiIi2QO+s6lhIwsWcntmiJco0VAQqra4bX+Nr3CTN73Suesb9XyVQ4uu2TyW
         KCnIiGkGvsv2I1NZJ3SwO4mtn1H0nYy6V76krT+woh5VLm2hBL5x9/xtLez2vNTfmqX4
         sd7C0gZi33CeFbysHKGnDtF3xsm64mZW52DSxZG9lIQInsFNwwaJtto6B45VBNJPBn3n
         1J5SORO7td41JObXyd+1kPM4CHKejUedYJxvhAJcTWDmHqMhhe2NyPoXt2HczPNxXvx+
         0ozW0isySG/34y302Rzqs46Ld3whWsL0SEclqOVnDOW2y6evRcUN2VB10fZfXP2/kn0i
         qFcQ==
X-Gm-Message-State: AOJu0Ywt/oWCZpgmdZMmJl2tcs1O3n2gMREfiRxXbR7jsr5OmimgEoX/
	VXUrC7aRb3A9MQdlDpTXfZssw6AASExApH8OQVo8jw==
X-Google-Smtp-Source: AGHT+IGxp/RPPNU9Kp5CGZ5oqAfd3q13hWzz8QOKUWbyloMtL6tf2RNWbSzW2ohbF9WmYxc9H7yItQ==
X-Received: by 2002:ac8:598a:0:b0:418:4e7:b82c with SMTP id e10-20020ac8598a000000b0041804e7b82cmr6913060qte.57.1697648883985;
        Wed, 18 Oct 2023 10:08:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l30-20020ac84cde000000b0041818df8a0dsm97451qtv.36.2023.10.18.10.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:08:03 -0700 (PDT)
Date: Wed, 18 Oct 2023 13:08:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 05/10] bulk-checkin: extract abstract `bulk_checkin_source`
Message-ID: <da52ec838025a59a3f4f4ffaf2e6f9098a37547e.1697648864.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697648864.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697648864.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index f4914fb6d1..fc1d902018 100644
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
@@ -325,6 +364,12 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	git_hash_ctx ctx;
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
@@ -342,10 +387,10 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	while (1) {
 		prepare_checkpoint(state, &checkpoint, idx, flags);
 		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
-					 fd, size, path, flags))
+					 &source, flags))
 			break;
 		truncate_checkpoint(state, &checkpoint, idx);
-		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
+		if (bulk_checkin_source_seek_to(&source, seekback) == (off_t)-1)
 			return error("cannot seek back");
 	}
 	finalize_checkpoint(state, &ctx, &checkpoint, idx, result_oid);
-- 
2.42.0.408.g97fac66ae4


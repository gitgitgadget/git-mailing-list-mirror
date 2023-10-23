Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7892523760
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 22:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VPQehhIu"
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0879C10E
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:45:01 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7c011e113so41993967b3.1
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698101100; x=1698705900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PCwa04nllI+txxAefr6o6HeUKTygNGiXBI3Nkz211y8=;
        b=VPQehhIuOfsQJu7sytnFZLokTXiRpaGF6JsY6MpipvM8wvSSm4xIOi06GA8nAzxW/4
         2gcHlSP9W2iDuechufl4Bos9a7btgtltxfldNovd+wvNYnIA+JlxDyt84KMNV0Rdvfwq
         T4BkRkxrpD12wIvO/2bikTKNGqeu6WYAVxdyw05qLkljyJj1agfr5vL2kRocXIpwxjSy
         tibate3g9zFefq/VvHhRfGoyIFC/eP2dZq9GYuHVWhZNN4b+GT8jrhTEB7OYO5SzpEno
         VO6XEVV5sWf/TQHnRLgKClNvT+ZY8VRV5COqUedvnZl4gyXsq/2gXsx/XM0vDXGsCxNk
         bF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698101100; x=1698705900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCwa04nllI+txxAefr6o6HeUKTygNGiXBI3Nkz211y8=;
        b=YdyYQQ0EA8dv7aCPSQ4f/z4LPIPlgNjuQB+EIrDpGuPvfUZi7J0dsYV2UHHf9Vkcdq
         LovO80JRD2r1zuFVTG79ePZOCpPjPWcFpXeKRGThPjy9/ypgXD5IuNxi0KqwZ0Kuej8D
         eC71gkFeGzJI5qZ9KgdIJpxF6knzHo+9bHUZksvhRRWmjpQZ7MSq1hQlatiNB31pmk08
         jut/NMZKCUTcTuckdpdTtTfEq+Bgog2kc4aVdkBU6ULhYyacqb9Bn8Y9ZB1TEY+dAtFh
         F9xSO5PTjgIVuAE3FXsYstmcccZhOy5iNQ31dEamjJQRT21rKEB8UFltop2pPqWjyt2k
         whaA==
X-Gm-Message-State: AOJu0YyQ6/veoRv0VZYvkRY7+yT2+qP3XAvoJQ+Rig91h+0hwFSXKEPz
	DLBLi1i17SyY0xM653Pv24xRoxMegi6ZHB9GvujeAA==
X-Google-Smtp-Source: AGHT+IGslSKc+WVPmno1V03qKSZAhHjsAI9v3Jw8Ag72SvceWq61ejaNTmeVh+1KQnb62oka7BXlEA==
X-Received: by 2002:a0d:eb4a:0:b0:5a7:ec86:fc84 with SMTP id u71-20020a0deb4a000000b005a7ec86fc84mr11554492ywe.21.1698101100019;
        Mon, 23 Oct 2023 15:45:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a23-20020a0dd817000000b005a8dbe385d1sm3515928ywe.12.2023.10.23.15.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 15:44:59 -0700 (PDT)
Date: Mon, 23 Oct 2023 18:44:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 2/5] bulk-checkin: generify `stream_blob_to_pack()` for
 arbitrary types
Message-ID: <596bd028a74f45c8f7ecf46dc5eb25f45ff5f523.1698101088.git.me@ttaylorr.com>
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

The existing `stream_blob_to_pack()` function is named based on the fact
that it knows only how to stream blobs into a bulk-checkin pack.

But there is no longer anything in this function which prevents us from
writing objects of arbitrary types to the bulk-checkin pack. Prepare to
write OBJ_TREEs by removing this assumption, adding an `enum
object_type` parameter to this function's argument list, and renaming it
to `stream_obj_to_pack()` accordingly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 61 +++++++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 174a6c24e4..79776e679e 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -196,10 +196,10 @@ static void init_bulk_checkin_source_from_fd(struct bulk_checkin_source *source,
  * status before calling us just in case we ask it to call us again
  * with a new pack.
  */
-static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
-			       git_hash_ctx *ctx, off_t *already_hashed_to,
-			       struct bulk_checkin_source *source,
-			       unsigned flags)
+static int stream_obj_to_pack(struct bulk_checkin_packfile *state,
+			      git_hash_ctx *ctx, off_t *already_hashed_to,
+			      struct bulk_checkin_source *source,
+			      enum object_type type, unsigned flags)
 {
 	git_zstream s;
 	unsigned char ibuf[16384];
@@ -212,8 +212,7 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 
 	git_deflate_init(&s, pack_compression_level);
 
-	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_BLOB,
-					      size);
+	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), type, size);
 	s.next_out = obuf + hdrlen;
 	s.avail_out = sizeof(obuf) - hdrlen;
 
@@ -293,27 +292,23 @@ static void prepare_to_stream(struct bulk_checkin_packfile *state,
 		die_errno("unable to write pack header");
 }
 
-static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
-				struct object_id *result_oid,
-				int fd, size_t size,
-				const char *path, unsigned flags)
+
+static int deflate_obj_to_pack(struct bulk_checkin_packfile *state,
+			       struct object_id *result_oid,
+			       struct bulk_checkin_source *source,
+			       enum object_type type,
+			       off_t seekback,
+			       unsigned flags)
 {
-	off_t seekback, already_hashed_to;
+	off_t already_hashed_to = 0;
 	git_hash_ctx ctx;
 	unsigned char obuf[16384];
 	unsigned header_len;
 	struct hashfile_checkpoint checkpoint = {0};
 	struct pack_idx_entry *idx = NULL;
-	struct bulk_checkin_source source;
 
-	init_bulk_checkin_source_from_fd(&source, fd, size, path);
-
-	seekback = lseek(fd, 0, SEEK_CUR);
-	if (seekback == (off_t) -1)
-		return error("cannot find the current offset");
-
-	header_len = format_object_header((char *)obuf, sizeof(obuf),
-					  OBJ_BLOB, size);
+	header_len = format_object_header((char *)obuf, sizeof(obuf), type,
+					  source->size);
 	the_hash_algo->init_fn(&ctx);
 	the_hash_algo->update_fn(&ctx, obuf, header_len);
 	the_hash_algo->init_fn(&checkpoint.ctx);
@@ -322,8 +317,6 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	if ((flags & HASH_WRITE_OBJECT) != 0)
 		CALLOC_ARRAY(idx, 1);
 
-	already_hashed_to = 0;
-
 	while (1) {
 		prepare_to_stream(state, flags);
 		if (idx) {
@@ -331,8 +324,8 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 			idx->offset = state->offset;
 			crc32_begin(state->f);
 		}
-		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
-					 &source, flags))
+		if (!stream_obj_to_pack(state, &ctx, &already_hashed_to,
+					source, type, flags))
 			break;
 		/*
 		 * Writing this object to the current pack will make
@@ -344,7 +337,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 		hashfile_truncate(state->f, &checkpoint);
 		state->offset = checkpoint.offset;
 		flush_bulk_checkin_packfile(state);
-		if (source.seek(&source, seekback) == (off_t)-1)
+		if (source->seek(source, seekback) == (off_t)-1)
 			return error("cannot seek back");
 	}
 	the_hash_algo->final_oid_fn(result_oid, &ctx);
@@ -366,6 +359,24 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	return 0;
 }
 
+static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
+				struct object_id *result_oid,
+				int fd, size_t size,
+				const char *path, unsigned flags)
+{
+	struct bulk_checkin_source source;
+	off_t seekback;
+
+	init_bulk_checkin_source_from_fd(&source, fd, size, path);
+
+	seekback = lseek(fd, 0, SEEK_CUR);
+	if (seekback == (off_t) -1)
+		return error("cannot find the current offset");
+
+	return deflate_obj_to_pack(state, result_oid, &source, OBJ_BLOB,
+				   seekback, flags);
+}
+
 void prepare_loose_object_bulk_checkin(void)
 {
 	/*
-- 
2.42.0.425.g963d08ddb3.dirty


Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF41241F7
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XQORGZpb"
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815F8DF
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:45:03 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d81d09d883dso3587128276.0
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698101102; x=1698705902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZhWzU306bJ5fvb6pmzE4F5FDInCiZk0yBmAdk6EUMg=;
        b=XQORGZpbBSpVgDmRWAPHC50Atl7aPnjzbaTCaMmTOXvwAiP2vchWzxo1vYeM5QVkrB
         v1xAIKUnZJ43TKZWWELUdKbCv3ycENHGf/zgzDgEC5NguKhl+cQpWuCKGPO7kseWjqtC
         YwUkHMsRVNkCY5lsHuol+1kyakEeHybjsg2bIHq18O8WinayAR7lseqcN3fD25AQXNec
         HScLaneLZxSyv0SNKeRfPxX65ehBsFiq0eUsZGkoeikOS5QNNvgv7fJgJtRlIgKsjI0N
         CHcuDMg/oRMrs+N3lTYA2h+O2YXzu5hNgokUJmlMv7iXdJZAfiuK/W1ibtHJbIV5ctKH
         Cf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698101102; x=1698705902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZhWzU306bJ5fvb6pmzE4F5FDInCiZk0yBmAdk6EUMg=;
        b=rp0u27FpSVIWcedFaUJNDqaeJmxVgLaHtgjq8CqUla39GY+hCnYzAitYgo+qtKXUDz
         rOSLyAte/93eHZhOqJtT8RLUmlrfG23Azsj8bm4C5zeNggLXJBexmMFqmXKDHZmHzHJ0
         BH5WAjlaQFdjLuaA6NheIv6O6CyR59NU2VdqR0huURkED/eK8CbJMKDuP/QF1gxqEvW4
         kLdHm829yDnQuzXQrvp7A8xuNgitW2MkxhSK/G2G7NE7+hDYnauQNTh4EW8+iIqqHTYX
         ja6TwvAukb2y2E66kEztcnyYgd64UpLApv+Qvq9X7EBgIf3U3wSdbJYUMAd+Vz8/ty8F
         DmDg==
X-Gm-Message-State: AOJu0YzHKdF4u27EXh2a/Tm46Ui7EWaoX8IwzMT1wahOuu7k0QGv15mo
	fnHXjt1basCujp4pCtFTcz1NwRm1lfnUpxOYFz7hJA==
X-Google-Smtp-Source: AGHT+IEQ00WeGI16h7XXkAkFQCSBJttQ6BwCFdOngxYLZIYS4ZbVeNVF+kFQRmjadK6yuBj9lvj1oA==
X-Received: by 2002:a25:d20e:0:b0:d9c:a485:332b with SMTP id j14-20020a25d20e000000b00d9ca485332bmr9755641ybg.4.1698101102513;
        Mon, 23 Oct 2023 15:45:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x17-20020a25ac91000000b00d995a8b956csm3067865ybi.51.2023.10.23.15.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 15:45:02 -0700 (PDT)
Date: Mon, 23 Oct 2023 18:45:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 3/5] bulk-checkin: introduce
 `index_blob_bulk_checkin_incore()`
Message-ID: <d8cf8e4395375f88fe4e1ade2b79a3be6ce5fb12.1698101088.git.me@ttaylorr.com>
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

Introduce `index_blob_bulk_checkin_incore()` which allows streaming
arbitrary blob contents from memory into the bulk-checkin pack.

In order to support streaming from a location in memory, we must
implement a new kind of bulk_checkin_source that does just that. These
implementation in spread out across:

  - init_bulk_checkin_source_incore()
  - bulk_checkin_source_read_incore()
  - bulk_checkin_source_seek_incore()

Note that, unlike file descriptors, which manage their own offset
internally, we have to keep track of how many bytes we've read out of
the buffer, and make sure we don't read past the end of the buffer.

This will be useful in a couple of more commits in order to provide the
`merge-tree` builtin with a mechanism to create a new pack containing
any objects it created during the merge, instead of storing those
objects individually as loose.

Similar to the existing `index_blob_bulk_checkin()` function, the
entrypoint delegates to `deflate_obj_to_pack_incore()`. That function in
turn delegates to deflate_obj_to_pack(), which is responsible for
formatting the pack header and then deflating the contents into the
pack.

Consistent with the rest of the bulk-checkin mechanism, there are no
direct tests here. In future commits when we expose this new
functionality via the `merge-tree` builtin, we will test it indirectly
there.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
 bulk-checkin.h |  4 +++
 2 files changed, 79 insertions(+)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 79776e679e..b728210bc7 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -148,6 +148,10 @@ struct bulk_checkin_source {
 		struct {
 			int fd;
 		} from_fd;
+		struct {
+			const void *buf;
+			size_t nr_read;
+		} incore;
 	} data;
 
 	size_t size;
@@ -166,6 +170,36 @@ static off_t bulk_checkin_source_seek_from_fd(struct bulk_checkin_source *source
 	return lseek(source->data.from_fd.fd, offset, SEEK_SET);
 }
 
+static off_t bulk_checkin_source_read_incore(struct bulk_checkin_source *source,
+					     void *buf, size_t nr)
+{
+	const unsigned char *src = source->data.incore.buf;
+
+	if (source->data.incore.nr_read > source->size)
+		BUG("read beyond bulk-checkin source buffer end "
+		    "(%"PRIuMAX" > %"PRIuMAX")",
+		    (uintmax_t)source->data.incore.nr_read,
+		    (uintmax_t)source->size);
+
+	if (nr > source->size - source->data.incore.nr_read)
+		nr = source->size - source->data.incore.nr_read;
+
+	src += source->data.incore.nr_read;
+
+	memcpy(buf, src, nr);
+	source->data.incore.nr_read += nr;
+	return nr;
+}
+
+static off_t bulk_checkin_source_seek_incore(struct bulk_checkin_source *source,
+					     off_t offset)
+{
+	if (!(0 <= offset && offset < source->size))
+		return (off_t)-1;
+	source->data.incore.nr_read = offset;
+	return source->data.incore.nr_read;
+}
+
 static void init_bulk_checkin_source_from_fd(struct bulk_checkin_source *source,
 					     int fd, size_t size,
 					     const char *path)
@@ -181,6 +215,22 @@ static void init_bulk_checkin_source_from_fd(struct bulk_checkin_source *source,
 	source->path = path;
 }
 
+static void init_bulk_checkin_source_incore(struct bulk_checkin_source *source,
+					    const void *buf, size_t size,
+					    const char *path)
+{
+	memset(source, 0, sizeof(struct bulk_checkin_source));
+
+	source->read = bulk_checkin_source_read_incore;
+	source->seek = bulk_checkin_source_seek_incore;
+
+	source->data.incore.buf = buf;
+	source->data.incore.nr_read = 0;
+
+	source->size = size;
+	source->path = path;
+}
+
 /*
  * Read the contents from 'source' for 'size' bytes, streaming it to the
  * packfile in state while updating the hash in ctx. Signal a failure
@@ -359,6 +409,19 @@ static int deflate_obj_to_pack(struct bulk_checkin_packfile *state,
 	return 0;
 }
 
+static int deflate_obj_to_pack_incore(struct bulk_checkin_packfile *state,
+				       struct object_id *result_oid,
+				       const void *buf, size_t size,
+				       const char *path, enum object_type type,
+				       unsigned flags)
+{
+	struct bulk_checkin_source source;
+
+	init_bulk_checkin_source_incore(&source, buf, size, path);
+
+	return deflate_obj_to_pack(state, result_oid, &source, type, 0, flags);
+}
+
 static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 				struct object_id *result_oid,
 				int fd, size_t size,
@@ -421,6 +484,18 @@ int index_blob_bulk_checkin(struct object_id *oid,
 	return status;
 }
 
+int index_blob_bulk_checkin_incore(struct object_id *oid,
+				   const void *buf, size_t size,
+				   const char *path, unsigned flags)
+{
+	int status = deflate_obj_to_pack_incore(&bulk_checkin_packfile, oid,
+						buf, size, path, OBJ_BLOB,
+						flags);
+	if (!odb_transaction_nesting)
+		flush_bulk_checkin_packfile(&bulk_checkin_packfile);
+	return status;
+}
+
 void begin_odb_transaction(void)
 {
 	odb_transaction_nesting += 1;
diff --git a/bulk-checkin.h b/bulk-checkin.h
index aa7286a7b3..1b91daeaee 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -13,6 +13,10 @@ int index_blob_bulk_checkin(struct object_id *oid,
 			    int fd, size_t size,
 			    const char *path, unsigned flags);
 
+int index_blob_bulk_checkin_incore(struct object_id *oid,
+				   const void *buf, size_t size,
+				   const char *path, unsigned flags);
+
 /*
  * Tell the object database to optimize for adding
  * multiple objects. end_odb_transaction must be called
-- 
2.42.0.425.g963d08ddb3.dirty


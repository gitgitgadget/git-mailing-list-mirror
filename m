Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0602D029
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LrHWB2w+"
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1D9101
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 09:31:29 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-41995d42c3bso35083021cf.1
        for <git@vger.kernel.org>; Tue, 17 Oct 2023 09:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697560288; x=1698165088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pIJdisFI6j/HucsYEabQZF+SDzcDzbR+3H1HGUdnYys=;
        b=LrHWB2w+rXDMpQJj+lBlWw9cvcIhkinkEnecs3JmK0rsEYx3DaPCRUCwmuf4iNlEt6
         DIGiRxATUTODsSdIQA4ruxyXQKSitpk9QR+Tgpd/1PY8hcXeKEKhOldsqoDrSov/IsVG
         OvPc5yKmQypt4kfbFMOed5OXnPPBLNpDRN1H9Qmj7bL2GqN85ABQpF4+4FUYPBW3qeW9
         Mj7ulVis3/m4L6hBhnJTBhJSSHwAR7nj0Af9/yaETDvm16jCUYxKQMDcWSkyIywCulJc
         hNRl3+qSyNbTQrQfxneg+6Ee5krmedJip1/96wsxFBxIjWGtCFP4/4qCL8ruCkNiKLpj
         UzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697560288; x=1698165088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIJdisFI6j/HucsYEabQZF+SDzcDzbR+3H1HGUdnYys=;
        b=nxsXKuk8qRIWzRlnNhM1HIlhIqvy8/iYgeOy4KUhk6FpsXpRtcIhYGZ+OJ4TFNMKJR
         LhvWFXu7vEBA5FvvZvCn2PeOwvDw2l7/f3FHCEnimCtt6BaowgwOS7G/fsZKrICg6RWz
         Q0MYyN+xuHV9DWNKvykMiP2x8zhcKPhWjlPHDjkircXxBt1SZVDkumOPK0sd1OMyBeqn
         fpsQDuOs9kJLXvhfj81R4WIsAQfgCaQFBVYnvPdRKLH4OAT4TTyF1TGwm47hy2yS0Y3m
         ze0us0Cf5y2Qjh+djcutC8/1dU4dc6J/5755q0hFaAxa3X7h9T2q+FzZ+LAcC44Lf6Hn
         /Msw==
X-Gm-Message-State: AOJu0YzgOn67PZakmx7YfRz7aiWyZVCx94x7pOoqC92jM5Ky9AFU/gOb
	a+SvUKWn5UFddEPMJu2ZKxCQSAem632C4QBra5AJIA==
X-Google-Smtp-Source: AGHT+IEn9zqXOxJ1ziBnbFD2F7w0cM5t80Y5ON8RuAMjnqYxSmbImKPMkF9rd+gbswDlpNmsiMWK4Q==
X-Received: by 2002:ac8:5ad5:0:b0:418:a03:66fd with SMTP id d21-20020ac85ad5000000b004180a0366fdmr3329475qtd.13.1697560287889;
        Tue, 17 Oct 2023 09:31:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ew3-20020a05622a514300b00410a9dd3d88sm734632qtb.68.2023.10.17.09.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:31:27 -0700 (PDT)
Date: Tue, 17 Oct 2023 12:31:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 5/7] bulk-checkin: introduce
 `index_blob_bulk_checkin_incore()`
Message-ID: <239bf39bfb21ef621a15839bade34446dcbc3103.1697560266.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697560266.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697560266.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Now that we have factored out many of the common routines necessary to
index a new object into a pack created by the bulk-checkin machinery, we
can introduce a variant of `index_blob_bulk_checkin()` that acts on
blobs whose contents we can fit in memory.

This will be useful in a couple of more commits in order to provide the
`merge-tree` builtin with a mechanism to create a new pack containing
any objects it created during the merge, instead of storing those
objects individually as loose.

Similar to the existing `index_blob_bulk_checkin()` function, the
entrypoint delegates to `deflate_blob_to_pack_incore()`, which is
responsible for formatting the pack header and then deflating the
contents into the pack. The latter is accomplished by calling
deflate_blob_contents_to_pack_incore(), which takes advantage of the
earlier refactoring and is responsible for writing the object to the
pack and handling any overage from pack.packSizeLimit.

The bulk of the new functionality is implemented in the function
`stream_obj_to_pack_incore()`, which is a generic implementation for
writing objects of arbitrary type (whose contents we can fit in-core)
into a bulk-checkin pack.

The new function shares an unfortunate degree of similarity to the
existing `stream_blob_to_pack()` function. But DRY-ing up these two
would likely be more trouble than it's worth, since the latter has to
deal with reading and writing the contents of the object.

Consistent with the rest of the bulk-checkin mechanism, there are no
direct tests here. In future commits when we expose this new
functionality via the `merge-tree` builtin, we will test it indirectly
there.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++++
 bulk-checkin.h |   4 ++
 2 files changed, 122 insertions(+)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index f4914fb6d1..25cd1ffa25 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -140,6 +140,69 @@ static int already_written(struct bulk_checkin_packfile *state, struct object_id
 	return 0;
 }
 
+static int stream_obj_to_pack_incore(struct bulk_checkin_packfile *state,
+				     git_hash_ctx *ctx,
+				     off_t *already_hashed_to,
+				     const void *buf, size_t size,
+				     enum object_type type,
+				     const char *path, unsigned flags)
+{
+	git_zstream s;
+	unsigned char obuf[16384];
+	unsigned hdrlen;
+	int status = Z_OK;
+	int write_object = (flags & HASH_WRITE_OBJECT);
+
+	git_deflate_init(&s, pack_compression_level);
+
+	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), type, size);
+	s.next_out = obuf + hdrlen;
+	s.avail_out = sizeof(obuf) - hdrlen;
+
+	if (*already_hashed_to < size) {
+		size_t hsize = size - *already_hashed_to;
+		if (hsize) {
+			the_hash_algo->update_fn(ctx, buf, hsize);
+		}
+		*already_hashed_to = size;
+	}
+	s.next_in = (void *)buf;
+	s.avail_in = size;
+
+	while (status != Z_STREAM_END) {
+		status = git_deflate(&s, Z_FINISH);
+		if (!s.avail_out || status == Z_STREAM_END) {
+			if (write_object) {
+				size_t written = s.next_out - obuf;
+
+				/* would we bust the size limit? */
+				if (state->nr_written &&
+				    pack_size_limit_cfg &&
+				    pack_size_limit_cfg < state->offset + written) {
+					git_deflate_abort(&s);
+					return -1;
+				}
+
+				hashwrite(state->f, obuf, written);
+				state->offset += written;
+			}
+			s.next_out = obuf;
+			s.avail_out = sizeof(obuf);
+		}
+
+		switch (status) {
+		case Z_OK:
+		case Z_BUF_ERROR:
+		case Z_STREAM_END:
+			continue;
+		default:
+			die("unexpected deflate failure: %d", status);
+		}
+	}
+	git_deflate_end(&s);
+	return 0;
+}
+
 /*
  * Read the contents from fd for size bytes, streaming it to the
  * packfile in state while updating the hash in ctx. Signal a failure
@@ -316,6 +379,50 @@ static void finalize_checkpoint(struct bulk_checkin_packfile *state,
 	}
 }
 
+static int deflate_obj_contents_to_pack_incore(struct bulk_checkin_packfile *state,
+					       git_hash_ctx *ctx,
+					       struct hashfile_checkpoint *checkpoint,
+					       struct object_id *result_oid,
+					       const void *buf, size_t size,
+					       enum object_type type,
+					       const char *path, unsigned flags)
+{
+	struct pack_idx_entry *idx = NULL;
+	off_t already_hashed_to = 0;
+
+	/* Note: idx is non-NULL when we are writing */
+	if (flags & HASH_WRITE_OBJECT)
+		CALLOC_ARRAY(idx, 1);
+
+	while (1) {
+		prepare_checkpoint(state, checkpoint, idx, flags);
+		if (!stream_obj_to_pack_incore(state, ctx, &already_hashed_to,
+					       buf, size, type, path, flags))
+			break;
+		truncate_checkpoint(state, checkpoint, idx);
+	}
+
+	finalize_checkpoint(state, ctx, checkpoint, idx, result_oid);
+
+	return 0;
+}
+
+static int deflate_blob_to_pack_incore(struct bulk_checkin_packfile *state,
+				       struct object_id *result_oid,
+				       const void *buf, size_t size,
+				       const char *path, unsigned flags)
+{
+	git_hash_ctx ctx;
+	struct hashfile_checkpoint checkpoint = {0};
+
+	format_object_header_hash(the_hash_algo, &ctx, &checkpoint, OBJ_BLOB,
+				  size);
+
+	return deflate_obj_contents_to_pack_incore(state, &ctx, &checkpoint,
+						   result_oid, buf, size,
+						   OBJ_BLOB, path, flags);
+}
+
 static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 				struct object_id *result_oid,
 				int fd, size_t size,
@@ -396,6 +503,17 @@ int index_blob_bulk_checkin(struct object_id *oid,
 	return status;
 }
 
+int index_blob_bulk_checkin_incore(struct object_id *oid,
+				   const void *buf, size_t size,
+				   const char *path, unsigned flags)
+{
+	int status = deflate_blob_to_pack_incore(&bulk_checkin_packfile, oid,
+						 buf, size, path, flags);
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
2.42.0.405.gdb2a2f287e


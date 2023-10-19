Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FEE225DA
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="NumIrpKt"
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B58112
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:28:41 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77896da2118so120946485a.1
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697736520; x=1698341320; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XezfIjuq4PRYiq61GTRmdoaxwizDMCYTHPCeYpOW1Fc=;
        b=NumIrpKtmcV80AgYXIGZEWhifQB7Kb4p15folbLUyJVLHWG6gKqQtWbEAKfEgtMeKl
         DnhpO7hT/pGpa4EKhG6Ajq13jeyP9NFcMblS5gfwk9+IBk1AAK+t0RP9dK1yXWNPzM9T
         eGbPtdbGpReEKVyM4TxNjmGwB29TmicYbi+oFoIOXGaVcJ/TiW4CkDNwX7vnVH7bImtL
         tHbXt+E9SfkLnzdik5plFKe4Tlaq8w7tCxUekUoNKozQlqqXUnZ21GMT90utHU84Llt5
         evVUk2wk06s28zyq3HmYVOM9zgNElLJJdDB+lqcABiTXS9jaVlPW+07/hYWqwfQYq6FW
         58qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697736520; x=1698341320;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XezfIjuq4PRYiq61GTRmdoaxwizDMCYTHPCeYpOW1Fc=;
        b=mo0fMZYItLZIe6Yy8qN3XedW7+P2QItMv5qOK8stZUXZB4f26aXx1IaXtoWyP61OZw
         kpVUHVi2ejSOQu+L8C+xwX+HM0Ohx7PTZ3zILVpP5nkYRIIEUjxNjK/jMxDvnoANX3ox
         5g4JtCGAH7K2B6tGe5804RByPTCXN7vgJzBM1uz3SFcpT+uQMqFSPDcPU4e+ichaLX1M
         30CUJL/qBoi75HcyK17ziLiJwlJBski4y6iqBWw8OATvcsuYZUVH9hpA7izXd/6s3z9a
         pDwHvT4GBt7g0PynqPi/n5Akc6tguXtXXc0cNEWeWT8fmXBzLAnFRnADfJNiy+pM1y/5
         Tlag==
X-Gm-Message-State: AOJu0YwKbSFQHVgIaWan3Twg4T/umU40Yy3vKchixrdiMk1CIOXgYF/q
	PvYNGmFAe7Ydyg6fXOAFycH9yn6nczj7RA0zM8dWng==
X-Google-Smtp-Source: AGHT+IEx6T6Ub8bhZkKAWuXOrVxAJNGFx9k2pPHZukxYtkudoBIInfK8KPetvK7aj0+y1c9/gP+0Bg==
X-Received: by 2002:a05:620a:4013:b0:775:806d:5389 with SMTP id h19-20020a05620a401300b00775806d5389mr3215972qko.70.1697736519890;
        Thu, 19 Oct 2023 10:28:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k27-20020a05620a143b00b0076c96e571f3sm902919qkj.26.2023.10.19.10.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 10:28:39 -0700 (PDT)
Date: Thu, 19 Oct 2023 13:28:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/7] merge-ort: implement support for packing objects
 together
Message-ID: <cover.1697736516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

(Rebased onto the current tip of 'master', which is 813d9a9188 (The
nineteenth batch, 2023-10-18) at the time of writing).

This series implements support for a new merge-tree option,
`--write-pack`, which causes any newly-written objects to be packed
together instead of being stored individually as loose.

I intentionally broke this off from the existing thread, since I
accidentally rerolled mine and Jonathan Tan's Bloom v2 series into it,
causing some confusion.

This is a new round that is significantly simplified thanks to
another very helpful suggestion[1] from Junio. By factoring out a common
"deflate object to pack" that takes an abstract bulk_checkin_source as a
parameter, all of the earlier refactorings can be dropped since we
retain only a single caller instead of multiple.

This resulted in a rather satisfying range-diff (included below, as
usual), and a similarly satisfying inter-diff:

    $ git diff --stat tb/ort-bulk-checkin.v3..
     bulk-checkin.c | 203 ++++++++++++++++---------------------------------
     1 file changed, 64 insertions(+), 139 deletions(-)

Beyond that, the changes since last time can be viewed in the range-diff
below. Thanks in advance for any review!

[1]: https://lore.kernel.org/git/xmqq34y7plj4.fsf@gitster.g/

Taylor Blau (7):
  bulk-checkin: extract abstract `bulk_checkin_source`
  bulk-checkin: generify `stream_blob_to_pack()` for arbitrary types
  bulk-checkin: refactor deflate routine to accept a
    `bulk_checkin_source`
  bulk-checkin: implement `SOURCE_INCORE` mode for `bulk_checkin_source`
  bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
  bulk-checkin: introduce `index_tree_bulk_checkin_incore()`
  builtin/merge-tree.c: implement support for `--write-pack`

 Documentation/git-merge-tree.txt |   4 +
 builtin/merge-tree.c             |   5 +
 bulk-checkin.c                   | 161 ++++++++++++++++++++++++++-----
 bulk-checkin.h                   |   8 ++
 merge-ort.c                      |  42 ++++++--
 merge-recursive.h                |   1 +
 t/t4301-merge-tree-write-tree.sh |  93 ++++++++++++++++++
 7 files changed, 280 insertions(+), 34 deletions(-)

Range-diff against v3:
 1:  2dffa45183 <  -:  ---------- bulk-checkin: factor out `format_object_header_hash()`
 2:  7a10dc794a <  -:  ---------- bulk-checkin: factor out `prepare_checkpoint()`
 3:  20c32d2178 <  -:  ---------- bulk-checkin: factor out `truncate_checkpoint()`
 4:  893051d0b7 <  -:  ---------- bulk-checkin: factor out `finalize_checkpoint()`
 5:  da52ec8380 !  1:  97bb6e9f59 bulk-checkin: extract abstract `bulk_checkin_source`
    @@ bulk-checkin.c: static int stream_blob_to_pack(struct bulk_checkin_packfile *sta
      			if (*already_hashed_to < offset) {
      				size_t hsize = offset - *already_hashed_to;
     @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
    - 	git_hash_ctx ctx;
    + 	unsigned header_len;
      	struct hashfile_checkpoint checkpoint = {0};
      	struct pack_idx_entry *idx = NULL;
     +	struct bulk_checkin_source source = {
    @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *st
      	seekback = lseek(fd, 0, SEEK_CUR);
      	if (seekback == (off_t) -1)
     @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
    - 	while (1) {
    - 		prepare_checkpoint(state, &checkpoint, idx, flags);
    + 			crc32_begin(state->f);
    + 		}
      		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
     -					 fd, size, path, flags))
     +					 &source, flags))
      			break;
    - 		truncate_checkpoint(state, &checkpoint, idx);
    + 		/*
    + 		 * Writing this object to the current pack will make
    +@@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
    + 		hashfile_truncate(state->f, &checkpoint);
    + 		state->offset = checkpoint.offset;
    + 		flush_bulk_checkin_packfile(state);
     -		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
     +		if (bulk_checkin_source_seek_to(&source, seekback) == (off_t)-1)
      			return error("cannot seek back");
      	}
    - 	finalize_checkpoint(state, &ctx, &checkpoint, idx, result_oid);
    + 	the_hash_algo->final_oid_fn(result_oid, &ctx);
 7:  04ec74e357 !  2:  9d633df339 bulk-checkin: generify `stream_blob_to_pack()` for arbitrary types
    @@ bulk-checkin.c: static int stream_blob_to_pack(struct bulk_checkin_packfile *sta
      	s.avail_out = sizeof(obuf) - hdrlen;
      
     @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
    - 
    - 	while (1) {
    - 		prepare_checkpoint(state, &checkpoint, idx, flags);
    + 			idx->offset = state->offset;
    + 			crc32_begin(state->f);
    + 		}
     -		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
     -					 &source, flags))
     +		if (!stream_obj_to_pack(state, &ctx, &already_hashed_to,
     +					&source, OBJ_BLOB, flags))
      			break;
    - 		truncate_checkpoint(state, &checkpoint, idx);
    - 		if (bulk_checkin_source_seek_to(&source, seekback) == (off_t)-1)
    + 		/*
    + 		 * Writing this object to the current pack will make
 -:  ---------- >  3:  d5bbd7810e bulk-checkin: refactor deflate routine to accept a `bulk_checkin_source`
 6:  4e9bac5bc1 =  4:  e427fe6ad3 bulk-checkin: implement `SOURCE_INCORE` mode for `bulk_checkin_source`
 8:  8667b76365 !  5:  48095afe80 bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
    @@ Commit message
         objects individually as loose.
     
         Similar to the existing `index_blob_bulk_checkin()` function, the
    -    entrypoint delegates to `deflate_blob_to_pack_incore()`, which is
    -    responsible for formatting the pack header and then deflating the
    -    contents into the pack. The latter is accomplished by calling
    -    deflate_obj_contents_to_pack_incore(), which takes advantage of the
    -    earlier refactorings and is responsible for writing the object to the
    -    pack and handling any overage from pack.packSizeLimit.
    -
    -    The bulk of the new functionality is implemented in the function
    -    `stream_obj_to_pack()`, which can handle streaming objects from memory
    -    to the bulk-checkin pack as a result of the earlier refactoring.
    +    entrypoint delegates to `deflate_obj_to_pack_incore()`. That function in
    +    turn delegates to deflate_obj_to_pack(), which is responsible for
    +    formatting the pack header and then deflating the contents into the
    +    pack.
     
         Consistent with the rest of the bulk-checkin mechanism, there are no
         direct tests here. In future commits when we expose this new
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## bulk-checkin.c ##
    -@@ bulk-checkin.c: static void finalize_checkpoint(struct bulk_checkin_packfile *state,
    - 	}
    +@@ bulk-checkin.c: static int deflate_obj_to_pack(struct bulk_checkin_packfile *state,
    + 	return 0;
      }
      
    -+static int deflate_obj_contents_to_pack_incore(struct bulk_checkin_packfile *state,
    -+					       git_hash_ctx *ctx,
    -+					       struct hashfile_checkpoint *checkpoint,
    -+					       struct object_id *result_oid,
    -+					       const void *buf, size_t size,
    -+					       enum object_type type,
    -+					       const char *path, unsigned flags)
    ++static int deflate_obj_to_pack_incore(struct bulk_checkin_packfile *state,
    ++				       struct object_id *result_oid,
    ++				       const void *buf, size_t size,
    ++				       const char *path, enum object_type type,
    ++				       unsigned flags)
     +{
    -+	struct pack_idx_entry *idx = NULL;
    -+	off_t already_hashed_to = 0;
     +	struct bulk_checkin_source source = {
     +		.type = SOURCE_INCORE,
     +		.buf = buf,
    @@ bulk-checkin.c: static void finalize_checkpoint(struct bulk_checkin_packfile *st
     +		.path = path,
     +	};
     +
    -+	/* Note: idx is non-NULL when we are writing */
    -+	if (flags & HASH_WRITE_OBJECT)
    -+		CALLOC_ARRAY(idx, 1);
    -+
    -+	while (1) {
    -+		prepare_checkpoint(state, checkpoint, idx, flags);
    -+
    -+		if (!stream_obj_to_pack(state, ctx, &already_hashed_to, &source,
    -+					type, flags))
    -+			break;
    -+		truncate_checkpoint(state, checkpoint, idx);
    -+		bulk_checkin_source_seek_to(&source, 0);
    -+	}
    -+
    -+	finalize_checkpoint(state, ctx, checkpoint, idx, result_oid);
    -+
    -+	return 0;
    -+}
    -+
    -+static int deflate_blob_to_pack_incore(struct bulk_checkin_packfile *state,
    -+				       struct object_id *result_oid,
    -+				       const void *buf, size_t size,
    -+				       const char *path, unsigned flags)
    -+{
    -+	git_hash_ctx ctx;
    -+	struct hashfile_checkpoint checkpoint = {0};
    -+
    -+	format_object_header_hash(the_hash_algo, &ctx, &checkpoint, OBJ_BLOB,
    -+				  size);
    -+
    -+	return deflate_obj_contents_to_pack_incore(state, &ctx, &checkpoint,
    -+						   result_oid, buf, size,
    -+						   OBJ_BLOB, path, flags);
    ++	return deflate_obj_to_pack(state, result_oid, &source, type, 0, flags);
     +}
     +
      static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
    @@ bulk-checkin.c: int index_blob_bulk_checkin(struct object_id *oid,
     +				   const void *buf, size_t size,
     +				   const char *path, unsigned flags)
     +{
    -+	int status = deflate_blob_to_pack_incore(&bulk_checkin_packfile, oid,
    -+						 buf, size, path, flags);
    ++	int status = deflate_obj_to_pack_incore(&bulk_checkin_packfile, oid,
    ++						buf, size, path, OBJ_BLOB,
    ++						flags);
     +	if (!odb_transaction_nesting)
     +		flush_bulk_checkin_packfile(&bulk_checkin_packfile);
     +	return status;
 9:  cba043ef14 !  6:  60568f9281 bulk-checkin: introduce `index_tree_bulk_checkin_incore()`
    @@ Commit message
         machinery will have enough to keep track of the converted object's hash
         in order to update the compatibility mapping.
     
    -    Within `deflate_tree_to_pack_incore()`, the changes should be limited
    -    to something like:
    +    Within some thin wrapper around `deflate_obj_to_pack_incore()` (perhaps
    +    `deflate_tree_to_pack_incore()`), the changes should be limited to
    +    something like:
     
             struct strbuf converted = STRBUF_INIT;
             if (the_repository->compat_hash_algo) {
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## bulk-checkin.c ##
    -@@ bulk-checkin.c: static int deflate_blob_to_pack_incore(struct bulk_checkin_packfile *state,
    - 						   OBJ_BLOB, path, flags);
    - }
    - 
    -+static int deflate_tree_to_pack_incore(struct bulk_checkin_packfile *state,
    -+				       struct object_id *result_oid,
    -+				       const void *buf, size_t size,
    -+				       const char *path, unsigned flags)
    -+{
    -+	git_hash_ctx ctx;
    -+	struct hashfile_checkpoint checkpoint = {0};
    -+
    -+	format_object_header_hash(the_hash_algo, &ctx, &checkpoint, OBJ_TREE,
    -+				  size);
    -+
    -+	return deflate_obj_contents_to_pack_incore(state, &ctx, &checkpoint,
    -+						   result_oid, buf, size,
    -+						   OBJ_TREE, path, flags);
    -+}
    -+
    - static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
    - 				struct object_id *result_oid,
    - 				int fd, size_t size,
     @@ bulk-checkin.c: int index_blob_bulk_checkin_incore(struct object_id *oid,
      	return status;
      }
    @@ bulk-checkin.c: int index_blob_bulk_checkin_incore(struct object_id *oid,
     +				   const void *buf, size_t size,
     +				   const char *path, unsigned flags)
     +{
    -+	int status = deflate_tree_to_pack_incore(&bulk_checkin_packfile, oid,
    -+						 buf, size, path, flags);
    ++	int status = deflate_obj_to_pack_incore(&bulk_checkin_packfile, oid,
    ++						buf, size, path, OBJ_TREE,
    ++						flags);
     +	if (!odb_transaction_nesting)
     +		flush_bulk_checkin_packfile(&bulk_checkin_packfile);
     +	return status;
10:  ae70508037 =  7:  b9be9df122 builtin/merge-tree.c: implement support for `--write-pack`
-- 
2.42.0.405.g86fe3250c2

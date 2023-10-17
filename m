Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549279CA59
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VlsKwqCo"
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A335A4
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 09:31:11 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-66d1a05b816so35575606d6.1
        for <git@vger.kernel.org>; Tue, 17 Oct 2023 09:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697560270; x=1698165070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4XesTADOASjQBDn25NZyhSSa98JvNK4a67lNy1oqXM=;
        b=VlsKwqCoYKFxbXV8WE7yg3LcKYhwyH8RHinAncP3faPGw8fu/cRjxIjxu4EVR2BJrT
         6b6yCC/1uiwLEJQeaUWPpnas/rJ4ogMq/JlAeQ7P5I2v45VBHr8PadQ01eejKo4zaiqL
         N2554OWWJ4YlM1roRiVDF8jFE2yDp0AeKYQRaMj/uaiXiZkoeBDSruNI5V1dGPLIM1qS
         leoEM8gTo8Vk2T7zhJkmJfqgxoTT6cFbzB/oruz/7igqZosowS4A+mEwaquUy7dOlSCG
         d0PI3/Cn2JcCD28I0c1nIQN5Th28u1zHIi0qWDgGUjsPgwb2Ln3KL0LEb0aoDssnlwQw
         21Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697560270; x=1698165070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4XesTADOASjQBDn25NZyhSSa98JvNK4a67lNy1oqXM=;
        b=sFkwUOcRskwacl/2Khr3S+MM+aIRF5lw+14eHFhy30j8jf0JQBEmpUPbUpc6GRJKw8
         cDq0DG5V6QZI+Tcpn7zd6n82uF7qqeojadLoFJpbbKJp3fL14AucebMw2xNLaj2wosYH
         R/Wekaih1/GJD9h0L3NdofmJS+oS7ttW6Y/Pecwp5ZNzlLEhCDDz4TTsGVwfmhViB/4e
         GAri4s74ILcXxCETrBrVQoVllLg9svO24U4EwVIvaRJsspYQCgf1HhvnrPFUqTeC3nJj
         LIkm2ptJUamvfHcipBfwbzyQG/bHnDcpU0CCYC1V9IyD6g+lPv5E8ccLVmjS2KiFSran
         QfuA==
X-Gm-Message-State: AOJu0YzU02GrvVXeTkua14CFvv6DLYpcuKYTI1DI9e7YHBvSQ/sO6e9A
	40sIShrvCrzqlB/HMbYJNRQw1fH9TX8nPiLoFANH7w==
X-Google-Smtp-Source: AGHT+IHvpn6wCbdzsyL5ob1ekEFcNwq7CVTQ8Fz3SCVtNPr1vu1OF8opDGuDUWDcouYkRxyeEhprFA==
X-Received: by 2002:ad4:5ba3:0:b0:66d:2fda:c9e0 with SMTP id 3-20020ad45ba3000000b0066d2fdac9e0mr2700160qvq.61.1697560270258;
        Tue, 17 Oct 2023 09:31:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f22-20020a05620a409600b0077890c8896bsm71400qko.134.2023.10.17.09.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:31:09 -0700 (PDT)
Date: Tue, 17 Oct 2023 12:31:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/7] merge-ort: implement support for packing objects
 together
Message-ID: <cover.1697560266.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696629697.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

(Previously based on 'eb/limit-bulk-checkin-to-blobs', which has since
been merged. This series is now based on the tip of 'master', which is
a9ecda2788 (The eighteenth batch, 2023-10-13) at the time of writing).

This series implements support for a new merge-tree option,
`--write-pack`, which causes any newly-written objects to be packed
together instead of being stored individually as loose.

Much is unchanged since last time, except for a small tweak to one of
the commit messages in response to feedback from Eric W. Biederman. The
series has also been rebased onto 'master', which had a couple of
conflicts that I resolved pertaining to:

  - 9eb5419799 (bulk-checkin: only support blobs in index_bulk_checkin,
    2023-09-26)
  - e0b8c84240 (treewide: fix various bugs w/ OpenSSL 3+ EVP API,
    2023-09-01)

They were mostly trivial resolutions, and the results can be viewed in
the range-diff included below.

(From last time: the motivating use-case behind these changes is to
better support repositories who invoke merge-tree frequently, generating
a potentially large number of loose objects, resulting in a possible
adverse effect on performance.)

Thanks in advance for any review!

Taylor Blau (7):
  bulk-checkin: factor out `format_object_header_hash()`
  bulk-checkin: factor out `prepare_checkpoint()`
  bulk-checkin: factor out `truncate_checkpoint()`
  bulk-checkin: factor our `finalize_checkpoint()`
  bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
  bulk-checkin: introduce `index_tree_bulk_checkin_incore()`
  builtin/merge-tree.c: implement support for `--write-pack`

 Documentation/git-merge-tree.txt |   4 +
 builtin/merge-tree.c             |   5 +
 bulk-checkin.c                   | 258 ++++++++++++++++++++++++++-----
 bulk-checkin.h                   |   8 +
 merge-ort.c                      |  42 +++--
 merge-recursive.h                |   1 +
 t/t4301-merge-tree-write-tree.sh |  93 +++++++++++
 7 files changed, 363 insertions(+), 48 deletions(-)

Range-diff against v1:
1:  37f4072815 ! 1:  edf1cbafc1 bulk-checkin: factor out `format_object_header_hash()`
    @@ bulk-checkin.c: static void prepare_to_stream(struct bulk_checkin_packfile *stat
      }
      
     +static void format_object_header_hash(const struct git_hash_algo *algop,
    -+				      git_hash_ctx *ctx, enum object_type type,
    ++				      git_hash_ctx *ctx,
    ++				      struct hashfile_checkpoint *checkpoint,
    ++				      enum object_type type,
     +				      size_t size)
     +{
     +	unsigned char header[16384];
    @@ bulk-checkin.c: static void prepare_to_stream(struct bulk_checkin_packfile *stat
     +
     +	algop->init_fn(ctx);
     +	algop->update_fn(ctx, header, header_len);
    ++	algop->init_fn(&checkpoint->ctx);
     +}
     +
      static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
    @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *st
     -					  OBJ_BLOB, size);
     -	the_hash_algo->init_fn(&ctx);
     -	the_hash_algo->update_fn(&ctx, obuf, header_len);
    -+	format_object_header_hash(the_hash_algo, &ctx, OBJ_BLOB, size);
    +-	the_hash_algo->init_fn(&checkpoint.ctx);
    ++	format_object_header_hash(the_hash_algo, &ctx, &checkpoint, OBJ_BLOB,
    ++				  size);
      
      	/* Note: idx is non-NULL when we are writing */
      	if ((flags & HASH_WRITE_OBJECT) != 0)
2:  9cc1f3014a ! 2:  b3f89d5853 bulk-checkin: factor out `prepare_checkpoint()`
    @@ Commit message
     
      ## bulk-checkin.c ##
     @@ bulk-checkin.c: static void format_object_header_hash(const struct git_hash_algo *algop,
    - 	algop->update_fn(ctx, header, header_len);
    + 	algop->init_fn(&checkpoint->ctx);
      }
      
     +static void prepare_checkpoint(struct bulk_checkin_packfile *state,
3:  f392ed2211 = 3:  abe4fb0a59 bulk-checkin: factor out `truncate_checkpoint()`
4:  9c6ca564ad = 4:  0b855a6eb7 bulk-checkin: factor our `finalize_checkpoint()`
5:  30ca7334c7 ! 5:  239bf39bfb bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
    @@ bulk-checkin.c: static void finalize_checkpoint(struct bulk_checkin_packfile *st
      
     +static int deflate_obj_contents_to_pack_incore(struct bulk_checkin_packfile *state,
     +					       git_hash_ctx *ctx,
    ++					       struct hashfile_checkpoint *checkpoint,
     +					       struct object_id *result_oid,
     +					       const void *buf, size_t size,
     +					       enum object_type type,
     +					       const char *path, unsigned flags)
     +{
    -+	struct hashfile_checkpoint checkpoint = {0};
     +	struct pack_idx_entry *idx = NULL;
     +	off_t already_hashed_to = 0;
     +
    @@ bulk-checkin.c: static void finalize_checkpoint(struct bulk_checkin_packfile *st
     +		CALLOC_ARRAY(idx, 1);
     +
     +	while (1) {
    -+		prepare_checkpoint(state, &checkpoint, idx, flags);
    ++		prepare_checkpoint(state, checkpoint, idx, flags);
     +		if (!stream_obj_to_pack_incore(state, ctx, &already_hashed_to,
     +					       buf, size, type, path, flags))
     +			break;
    -+		truncate_checkpoint(state, &checkpoint, idx);
    ++		truncate_checkpoint(state, checkpoint, idx);
     +	}
     +
    -+	finalize_checkpoint(state, ctx, &checkpoint, idx, result_oid);
    ++	finalize_checkpoint(state, ctx, checkpoint, idx, result_oid);
     +
     +	return 0;
     +}
    @@ bulk-checkin.c: static void finalize_checkpoint(struct bulk_checkin_packfile *st
     +				       const char *path, unsigned flags)
     +{
     +	git_hash_ctx ctx;
    ++	struct hashfile_checkpoint checkpoint = {0};
     +
    -+	format_object_header_hash(the_hash_algo, &ctx, OBJ_BLOB, size);
    ++	format_object_header_hash(the_hash_algo, &ctx, &checkpoint, OBJ_BLOB,
    ++				  size);
     +
    -+	return deflate_obj_contents_to_pack_incore(state, &ctx, result_oid,
    -+						   buf, size, OBJ_BLOB, path,
    -+						   flags);
    ++	return deflate_obj_contents_to_pack_incore(state, &ctx, &checkpoint,
    ++						   result_oid, buf, size,
    ++						   OBJ_BLOB, path, flags);
     +}
     +
      static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
6:  cb0f79cabb ! 6:  57613807d8 bulk-checkin: introduce `index_tree_bulk_checkin_incore()`
    @@ Commit message
         Within `deflate_tree_to_pack_incore()`, the changes should be limited
         to something like:
     
    +        struct strbuf converted = STRBUF_INIT;
             if (the_repository->compat_hash_algo) {
    -          struct strbuf converted = STRBUF_INIT;
               if (convert_object_file(&compat_obj,
                                       the_repository->hash_algo,
                                       the_repository->compat_hash_algo, ...) < 0)
    @@ Commit message
     
               format_object_header_hash(the_repository->compat_hash_algo,
                                         OBJ_TREE, size);
    -
    -          strbuf_release(&converted);
             }
    +        /* compute the converted tree's hash using the compat algorithm */
    +        strbuf_release(&converted);
     
         , assuming related changes throughout the rest of the bulk-checkin
         machinery necessary to update the hash of the converted object, which
    @@ Commit message
     
      ## bulk-checkin.c ##
     @@ bulk-checkin.c: static int deflate_blob_to_pack_incore(struct bulk_checkin_packfile *state,
    - 						   flags);
    + 						   OBJ_BLOB, path, flags);
      }
      
     +static int deflate_tree_to_pack_incore(struct bulk_checkin_packfile *state,
    @@ bulk-checkin.c: static int deflate_blob_to_pack_incore(struct bulk_checkin_packf
     +				       const char *path, unsigned flags)
     +{
     +	git_hash_ctx ctx;
    ++	struct hashfile_checkpoint checkpoint = {0};
     +
    -+	format_object_header_hash(the_hash_algo, &ctx, OBJ_TREE, size);
    ++	format_object_header_hash(the_hash_algo, &ctx, &checkpoint, OBJ_TREE,
    ++				  size);
     +
    -+	return deflate_obj_contents_to_pack_incore(state, &ctx, result_oid,
    -+						   buf, size, OBJ_TREE, path,
    -+						   flags);
    ++	return deflate_obj_contents_to_pack_incore(state, &ctx, &checkpoint,
    ++						   result_oid, buf, size,
    ++						   OBJ_TREE, path, flags);
     +}
     +
      static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
7:  e969210145 ! 7:  f21400f56c builtin/merge-tree.c: implement support for `--write-pack`
    @@ merge-ort.c
       * We have many arrays of size 3.  Whenever we have such an array, the
     @@ merge-ort.c: static int handle_content_merge(struct merge_options *opt,
      		if ((merge_status < 0) || !result_buf.ptr)
    - 			ret = err(opt, _("Failed to execute internal merge"));
    + 			ret = error(_("failed to execute internal merge"));
      
     -		if (!ret &&
     -		    write_object_file(result_buf.ptr, result_buf.size,
     -				      OBJ_BLOB, &result->oid))
    --			ret = err(opt, _("Unable to add %s to database"),
    --				  path);
    +-			ret = error(_("unable to add %s to database"), path);
     +		if (!ret) {
     +			ret = opt->write_pack
     +				? index_blob_bulk_checkin_incore(&result->oid,
    @@ merge-ort.c: static int handle_content_merge(struct merge_options *opt,
     +						    result_buf.size,
     +						    OBJ_BLOB, &result->oid);
     +			if (ret)
    -+				ret = err(opt, _("Unable to add %s to database"),
    -+					  path);
    ++				ret = error(_("unable to add %s to database"),
    ++					    path);
     +		}
      
      		free(result_buf.ptr);
-- 
2.42.0.405.gdb2a2f287e

Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E733D39C
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="puvr7gvW"
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8DFD6D
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:07:59 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7788db95652so118188085a.2
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697648867; x=1698253667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DxX7EPhtXJb5PyQLrCf4WvWzaWWyL5iK0TNeMkYGlsE=;
        b=puvr7gvWj9k7Ssr5eMmPZixD8OzD6brfzWGJ6SxedgU0u8hImtQOei611KDTjs+RRS
         4x6xgoG15tc6Pw8VNDKQWXUPcrmX/MKxnJBOHM2XFFZDh1/0/gK5/h4Sk6WiZRFP5G8v
         Z1797xTVnFx/86U/46mrglZ4wptH4B5TDomYs4/F1ubcQTi71O06p96kNNBJce/Y+TqM
         I2IPUa2mLvkmzZR5WX1jV/5ksDlZASdHyJjUK2K58T/8NqEWuwBfiNOiN9HWMZGIqMbk
         /8kx2RPGee+E2BGw37FULa+nWTfamactOhTeb+I57PN3+2rHoSKRWzL0uo3zD7XWcYQF
         skNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648867; x=1698253667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxX7EPhtXJb5PyQLrCf4WvWzaWWyL5iK0TNeMkYGlsE=;
        b=fbfuzEF5HJ7Uk/qRDIiFaGlGOJbIPfdRbPrxFbLi8Nhh5C1keXYP1K4eHkJ2wBHLVS
         wjeWIX1Rroj+7l1DPufp9m1fTSrPmRhXON68bPVKp+Fr+Cbq+S+UBLyMbmTiIjxbDumx
         emVRXw4D6og9VuzN+ZIJ0aksytylEV3a/XetWOaWOj29ki9lkqGVmM/p0fUhZYQ5PZ19
         qYzZ79PvnHkmihfycuSWnpRkM4lNsf9svndR7BtekmudWCAXhECsEKzAXV0lbYOxFoBg
         /kURUkkOXTMZ80e8CK+2AmLtqZoIMZjERbMyx6RjA4JwlROZB8ubz0dgMZ/9Xj8FiotP
         SY0w==
X-Gm-Message-State: AOJu0YwG6hpH2308rNTFR5ByETbhXqpphp6paWtuo1tnA+LS2nu2efeA
	Wsshv3xjK7vZUq3osY4qvBQ6HtJueLj862dVjJxg5Q==
X-Google-Smtp-Source: AGHT+IEheIgZF3OB5/1ETq4dETGvDZArbreL1wovuCEBP19JOaLuxBlKyo1AR4O91t9HIfqVMWEcig==
X-Received: by 2002:a05:6214:29e7:b0:66d:4f2a:3fd3 with SMTP id jv7-20020a05621429e700b0066d4f2a3fd3mr6267831qvb.0.1697648867171;
        Wed, 18 Oct 2023 10:07:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a19-20020a05620a103300b00767da10efb6sm95721qkk.97.2023.10.18.10.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:07:46 -0700 (PDT)
Date: Wed, 18 Oct 2023 13:07:45 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/10] merge-ort: implement support for packing objects
 together
Message-ID: <cover.1697648864.git.me@ttaylorr.com>
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
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series implements support for a new merge-tree option,
`--write-pack`, which causes any newly-written objects to be packed
together instead of being stored individually as loose.

The notable change from last time is in response to a suggestion[1] from
Junio to factor out an abstract bulk-checkin "source", which ended up
reducing the duplication between a couple of functions in the earlier
round by a significant degree.

Beyond that, the changes since last time can be viewed in the range-diff
below. Thanks in advance for any review!

[1]: https://lore.kernel.org/git/xmqq5y34wu5f.fsf@gitster.g/

Taylor Blau (10):
  bulk-checkin: factor out `format_object_header_hash()`
  bulk-checkin: factor out `prepare_checkpoint()`
  bulk-checkin: factor out `truncate_checkpoint()`
  bulk-checkin: factor out `finalize_checkpoint()`
  bulk-checkin: extract abstract `bulk_checkin_source`
  bulk-checkin: implement `SOURCE_INCORE` mode for `bulk_checkin_source`
  bulk-checkin: generify `stream_blob_to_pack()` for arbitrary types
  bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
  bulk-checkin: introduce `index_tree_bulk_checkin_incore()`
  builtin/merge-tree.c: implement support for `--write-pack`

 Documentation/git-merge-tree.txt |   4 +
 builtin/merge-tree.c             |   5 +
 bulk-checkin.c                   | 288 +++++++++++++++++++++++++------
 bulk-checkin.h                   |   8 +
 merge-ort.c                      |  42 ++++-
 merge-recursive.h                |   1 +
 t/t4301-merge-tree-write-tree.sh |  93 ++++++++++
 7 files changed, 381 insertions(+), 60 deletions(-)

Range-diff against v2:
 1:  edf1cbafc1 =  1:  2dffa45183 bulk-checkin: factor out `format_object_header_hash()`
 2:  b3f89d5853 =  2:  7a10dc794a bulk-checkin: factor out `prepare_checkpoint()`
 3:  abe4fb0a59 =  3:  20c32d2178 bulk-checkin: factor out `truncate_checkpoint()`
 4:  0b855a6eb7 !  4:  893051d0b7 bulk-checkin: factor our `finalize_checkpoint()`
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    bulk-checkin: factor our `finalize_checkpoint()`
    +    bulk-checkin: factor out `finalize_checkpoint()`
     
         In a similar spirit as previous commits, factor out the routine to
         finalize the just-written object from the bulk-checkin mechanism.
 -:  ---------- >  5:  da52ec8380 bulk-checkin: extract abstract `bulk_checkin_source`
 -:  ---------- >  6:  4e9bac5bc1 bulk-checkin: implement `SOURCE_INCORE` mode for `bulk_checkin_source`
 -:  ---------- >  7:  04ec74e357 bulk-checkin: generify `stream_blob_to_pack()` for arbitrary types
 5:  239bf39bfb !  8:  8667b76365 bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
    @@ Commit message
         entrypoint delegates to `deflate_blob_to_pack_incore()`, which is
         responsible for formatting the pack header and then deflating the
         contents into the pack. The latter is accomplished by calling
    -    deflate_blob_contents_to_pack_incore(), which takes advantage of the
    -    earlier refactoring and is responsible for writing the object to the
    +    deflate_obj_contents_to_pack_incore(), which takes advantage of the
    +    earlier refactorings and is responsible for writing the object to the
         pack and handling any overage from pack.packSizeLimit.
     
         The bulk of the new functionality is implemented in the function
    -    `stream_obj_to_pack_incore()`, which is a generic implementation for
    -    writing objects of arbitrary type (whose contents we can fit in-core)
    -    into a bulk-checkin pack.
    -
    -    The new function shares an unfortunate degree of similarity to the
    -    existing `stream_blob_to_pack()` function. But DRY-ing up these two
    -    would likely be more trouble than it's worth, since the latter has to
    -    deal with reading and writing the contents of the object.
    +    `stream_obj_to_pack()`, which can handle streaming objects from memory
    +    to the bulk-checkin pack as a result of the earlier refactoring.
     
         Consistent with the rest of the bulk-checkin mechanism, there are no
         direct tests here. In future commits when we expose this new
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## bulk-checkin.c ##
    -@@ bulk-checkin.c: static int already_written(struct bulk_checkin_packfile *state, struct object_id
    - 	return 0;
    - }
    - 
    -+static int stream_obj_to_pack_incore(struct bulk_checkin_packfile *state,
    -+				     git_hash_ctx *ctx,
    -+				     off_t *already_hashed_to,
    -+				     const void *buf, size_t size,
    -+				     enum object_type type,
    -+				     const char *path, unsigned flags)
    -+{
    -+	git_zstream s;
    -+	unsigned char obuf[16384];
    -+	unsigned hdrlen;
    -+	int status = Z_OK;
    -+	int write_object = (flags & HASH_WRITE_OBJECT);
    -+
    -+	git_deflate_init(&s, pack_compression_level);
    -+
    -+	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), type, size);
    -+	s.next_out = obuf + hdrlen;
    -+	s.avail_out = sizeof(obuf) - hdrlen;
    -+
    -+	if (*already_hashed_to < size) {
    -+		size_t hsize = size - *already_hashed_to;
    -+		if (hsize) {
    -+			the_hash_algo->update_fn(ctx, buf, hsize);
    -+		}
    -+		*already_hashed_to = size;
    -+	}
    -+	s.next_in = (void *)buf;
    -+	s.avail_in = size;
    -+
    -+	while (status != Z_STREAM_END) {
    -+		status = git_deflate(&s, Z_FINISH);
    -+		if (!s.avail_out || status == Z_STREAM_END) {
    -+			if (write_object) {
    -+				size_t written = s.next_out - obuf;
    -+
    -+				/* would we bust the size limit? */
    -+				if (state->nr_written &&
    -+				    pack_size_limit_cfg &&
    -+				    pack_size_limit_cfg < state->offset + written) {
    -+					git_deflate_abort(&s);
    -+					return -1;
    -+				}
    -+
    -+				hashwrite(state->f, obuf, written);
    -+				state->offset += written;
    -+			}
    -+			s.next_out = obuf;
    -+			s.avail_out = sizeof(obuf);
    -+		}
    -+
    -+		switch (status) {
    -+		case Z_OK:
    -+		case Z_BUF_ERROR:
    -+		case Z_STREAM_END:
    -+			continue;
    -+		default:
    -+			die("unexpected deflate failure: %d", status);
    -+		}
    -+	}
    -+	git_deflate_end(&s);
    -+	return 0;
    -+}
    -+
    - /*
    -  * Read the contents from fd for size bytes, streaming it to the
    -  * packfile in state while updating the hash in ctx. Signal a failure
     @@ bulk-checkin.c: static void finalize_checkpoint(struct bulk_checkin_packfile *state,
      	}
      }
    @@ bulk-checkin.c: static void finalize_checkpoint(struct bulk_checkin_packfile *st
     +{
     +	struct pack_idx_entry *idx = NULL;
     +	off_t already_hashed_to = 0;
    ++	struct bulk_checkin_source source = {
    ++		.type = SOURCE_INCORE,
    ++		.buf = buf,
    ++		.size = size,
    ++		.read = 0,
    ++		.path = path,
    ++	};
     +
     +	/* Note: idx is non-NULL when we are writing */
     +	if (flags & HASH_WRITE_OBJECT)
    @@ bulk-checkin.c: static void finalize_checkpoint(struct bulk_checkin_packfile *st
     +
     +	while (1) {
     +		prepare_checkpoint(state, checkpoint, idx, flags);
    -+		if (!stream_obj_to_pack_incore(state, ctx, &already_hashed_to,
    -+					       buf, size, type, path, flags))
    ++
    ++		if (!stream_obj_to_pack(state, ctx, &already_hashed_to, &source,
    ++					type, flags))
     +			break;
     +		truncate_checkpoint(state, checkpoint, idx);
    ++		bulk_checkin_source_seek_to(&source, 0);
     +	}
     +
     +	finalize_checkpoint(state, ctx, checkpoint, idx, result_oid);
 6:  57613807d8 =  9:  cba043ef14 bulk-checkin: introduce `index_tree_bulk_checkin_incore()`
 7:  f21400f56c = 10:  ae70508037 builtin/merge-tree.c: implement support for `--write-pack`
-- 
2.42.0.408.g97fac66ae4

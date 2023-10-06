Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762CFE94134
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 22:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjJFWCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 18:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjJFWCF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 18:02:05 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D96F0
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 15:02:04 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-65af7d102b3so15218866d6.1
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 15:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696629723; x=1697234523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cnYv87NMRNdPneI+Sydk5I4zX4G2dO52pP4tgONi3Hc=;
        b=FAYs9Pp4CsUNzf3Q39B0pft73AjnhiHIo9iYWYmdguALpRg/nMfK94+Z1m1Pc6Hhpu
         HaU/+7i1oqoRqbMlmg2qjZrb9rWpS55JjBSrCfVQf5ApLNmPqv6GVyvSMUorCaEkhBBa
         SBjVHhf/+KSTdDyGqwsUOCXFdNYLn8CO+RMCQuF5qx9eWqt5pTQPEZ/Z37yaxHuMdY9f
         GmXpslMVwPv71Bu/2GqPljLBfyyActid4fWzLVyqyClZU6b14OxC6VzTcSfvxXh4qYU9
         Yw9OqF/KtL6kiRzlFGIZsv2bd+yS+m4yv6lMkHeGlF5+49UdnZJ8tzIWbaqXtGg7HuHN
         NkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696629723; x=1697234523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnYv87NMRNdPneI+Sydk5I4zX4G2dO52pP4tgONi3Hc=;
        b=Id4rqLhuralID+j+d4uIyCMrnH2dMk8Q35zxfkXKBfS6IGuX0zuKM7DEoPZF5ckP5w
         qdcD9pMhLjx/tOuwtVUax4fos/W+Auw/elHEww3USuIVgW7hx/mcW8FE5eHEVmM3aUh7
         nBgj9e76VIILqGmlNIT9sGHRhrnT/OvNBEySULHJ4S5JYT3vdqwbnZ/HAxZ2jkFV6lsf
         LUrrMd4Y04AHjs8EPvkAYnXqUqcWjTTvNaQZUrs/ledD9rXrEdbSaZW0VTyyJoMw6llh
         6Nm2ZAHNY6Ob5WHuTEOQsCHYHxCiO3V7B90wERPs2QepjhtuzxFYGREzgHTrfxGodVRW
         281A==
X-Gm-Message-State: AOJu0YxFQC+l54kdWRX0FSxqkq2Rst4R5aQq4UZwlyCg4ahKWZQe8bFU
        Jz2PWoBt+7OQpekRv7w1z2XOMyE02yIjvTQrvpf4Fg==
X-Google-Smtp-Source: AGHT+IEMEMlnfejvUc+gLQkdue8rAnJhNBOGfkSD1Jw+1WqZH15Na9kD6JSb7LN8JugzyPXKnDi/hw==
X-Received: by 2002:a0c:df10:0:b0:658:9cf2:15df with SMTP id g16-20020a0cdf10000000b006589cf215dfmr11112302qvl.8.1696629722694;
        Fri, 06 Oct 2023 15:02:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h26-20020a0cb4da000000b0065b0a3ae7c7sm1717174qvf.113.2023.10.06.15.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 15:02:02 -0700 (PDT)
Date:   Fri, 6 Oct 2023 18:02:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        "Eric W. Biederman" <ebiederm@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/7] bulk-checkin: introduce
 `index_blob_bulk_checkin_incore()`
Message-ID: <30ca7334c7605a81b9a6bbb386627e436bf8ab33.1696629697.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696629697.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
 bulk-checkin.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++++
 bulk-checkin.h |   4 ++
 2 files changed, 120 insertions(+)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index a9497fcb28..319921efe7 100644
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
@@ -313,6 +376,48 @@ static void finalize_checkpoint(struct bulk_checkin_packfile *state,
 	}
 }
 
+static int deflate_obj_contents_to_pack_incore(struct bulk_checkin_packfile *state,
+					       git_hash_ctx *ctx,
+					       struct object_id *result_oid,
+					       const void *buf, size_t size,
+					       enum object_type type,
+					       const char *path, unsigned flags)
+{
+	struct hashfile_checkpoint checkpoint = {0};
+	struct pack_idx_entry *idx = NULL;
+	off_t already_hashed_to = 0;
+
+	/* Note: idx is non-NULL when we are writing */
+	if (flags & HASH_WRITE_OBJECT)
+		CALLOC_ARRAY(idx, 1);
+
+	while (1) {
+		prepare_checkpoint(state, &checkpoint, idx, flags);
+		if (!stream_obj_to_pack_incore(state, ctx, &already_hashed_to,
+					       buf, size, type, path, flags))
+			break;
+		truncate_checkpoint(state, &checkpoint, idx);
+	}
+
+	finalize_checkpoint(state, ctx, &checkpoint, idx, result_oid);
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
+
+	format_object_header_hash(the_hash_algo, &ctx, OBJ_BLOB, size);
+
+	return deflate_obj_contents_to_pack_incore(state, &ctx, result_oid,
+						   buf, size, OBJ_BLOB, path,
+						   flags);
+}
+
 static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 				struct object_id *result_oid,
 				int fd, size_t size,
@@ -392,6 +497,17 @@ int index_blob_bulk_checkin(struct object_id *oid,
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
2.42.0.8.g7a7e1e881e.dirty


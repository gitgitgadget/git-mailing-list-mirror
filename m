Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2313D965
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="o08AuR9l"
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47653840
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:08:17 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-41cbd2cf3bbso7211911cf.0
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697648893; x=1698253693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nusivuG2il7aIPPIQ3lBI1O3aqqCGeS+pUw+w/8YRn4=;
        b=o08AuR9lQFBbqJJtCx2x4/a3JintN+Xz+Azx1SQcb6fg7zmad6XKootdmIcNmFjXvQ
         VQmGYoL7rWDv8oFZZ672N3LR0RJbpYEfSZqzhygpHJUw9xAQr3++yvgDBFj/K19QT3CG
         k56KmK0NBWpdphYyIWPIQrbrRHRVtBy2AtZeySZPtROyA/AjplTHHATt+QdzYa045Da9
         lY61CbtgWyEfro75jk3HVD5LlmXnbccjy7SZYYccgPPZ1fxWO04SsMFZ+ERw2bixlWl6
         B8VN2OxCXHpQwMVnFTSTnV/R+gMjrbZ/TMJUts4cLGAarAFkSrnyrmoScNxYE1wSBtMR
         SX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648893; x=1698253693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nusivuG2il7aIPPIQ3lBI1O3aqqCGeS+pUw+w/8YRn4=;
        b=pTeqlb0kgUp3hVf2BF5XqfC50VB3VCl1vWG4U0i/vENqdfMFBWopGjf5numCrrGZ7M
         c8Gl2/1pOI8kHRMDpKtUoO1e2TwdVhAKPxwqgw5tZ87aN8tZVADgA35CLzQJZgcviiri
         +/bZSheqwX/XBtrYKq4aZys9KjeqyOqVAjUG9JmiY4pieeqACAVYDoMHryAi50mRxIz0
         xiPaOZRAqKyJHb+lAvAfgKz/3AX+LM2J8dkbfuGqzyO2LO/auwPB7eOGszQD1QU9HcX+
         l0Dipfc+FBPUt5qctuLX2zY091ux9fiC4zvuACqFCjEpRfsNOD+7O3Qk7+YKiPfGg7wr
         bKQg==
X-Gm-Message-State: AOJu0Yw+z7rCYN1ABTf6s8g97S5XvQulV35lF1OGuoKNFk77TqYQ22+F
	EqXPfQvZcZne5dAj89lx7T5ghUAK+NofSOK7UA9dyQ==
X-Google-Smtp-Source: AGHT+IEtvtBpwO4F11ZFWwiszhcQHIB0zCwyJTCamJH6Qyx/et0MSwvlwxfOWue5/PSmpObsApvJxw==
X-Received: by 2002:a05:622a:19a8:b0:403:a662:a3c1 with SMTP id u40-20020a05622a19a800b00403a662a3c1mr6733658qtc.29.1697648893009;
        Wed, 18 Oct 2023 10:08:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z6-20020ac86b86000000b004198ae7f841sm88836qts.90.2023.10.18.10.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:08:12 -0700 (PDT)
Date: Wed, 18 Oct 2023 13:08:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 08/10] bulk-checkin: introduce
 `index_blob_bulk_checkin_incore()`
Message-ID: <8667b763652ffa71b52b7bd78821e46a6e5fe5a9.1697648864.git.me@ttaylorr.com>
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
deflate_obj_contents_to_pack_incore(), which takes advantage of the
earlier refactorings and is responsible for writing the object to the
pack and handling any overage from pack.packSizeLimit.

The bulk of the new functionality is implemented in the function
`stream_obj_to_pack()`, which can handle streaming objects from memory
to the bulk-checkin pack as a result of the earlier refactoring.

Consistent with the rest of the bulk-checkin mechanism, there are no
direct tests here. In future commits when we expose this new
functionality via the `merge-tree` builtin, we will test it indirectly
there.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
 bulk-checkin.h |  4 ++++
 2 files changed, 68 insertions(+)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index f0115efb2e..9ae43648ba 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -370,6 +370,59 @@ static void finalize_checkpoint(struct bulk_checkin_packfile *state,
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
+	struct bulk_checkin_source source = {
+		.type = SOURCE_INCORE,
+		.buf = buf,
+		.size = size,
+		.read = 0,
+		.path = path,
+	};
+
+	/* Note: idx is non-NULL when we are writing */
+	if (flags & HASH_WRITE_OBJECT)
+		CALLOC_ARRAY(idx, 1);
+
+	while (1) {
+		prepare_checkpoint(state, checkpoint, idx, flags);
+
+		if (!stream_obj_to_pack(state, ctx, &already_hashed_to, &source,
+					type, flags))
+			break;
+		truncate_checkpoint(state, checkpoint, idx);
+		bulk_checkin_source_seek_to(&source, 0);
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
@@ -456,6 +509,17 @@ int index_blob_bulk_checkin(struct object_id *oid,
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
2.42.0.408.g97fac66ae4


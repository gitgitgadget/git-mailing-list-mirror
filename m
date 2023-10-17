Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874102D059
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vb3tCqoY"
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDD610F
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 09:31:32 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66cfd874520so38416106d6.2
        for <git@vger.kernel.org>; Tue, 17 Oct 2023 09:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697560291; x=1698165091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J2A8hcMW9oFp1Qg8zy8Z8vYpexHa6tGY5QnuDCf8HvQ=;
        b=vb3tCqoYf4eD+1N2a3MA/92PMtoCOCs6KBieA6WtIpMOlwEuycXiq4RPg3BDlMqYxx
         2s8YXLMEqNmKbuZHk7CpCCj9Lb8e3MTprUsHRYu7uCFnbfleIrEcQNMQmWLR+cqPOOHW
         rtpeIgBfxk8wB9dg6P1tHjBuuZtXanZFR9LGzJEaYIkPKUKqXfc4xzUv3iT0ySvdiLY6
         mSjy56QqGW+pn4Tp9uQ/5yjdAvwK47sQudSxZurErz4q3u8YF2ONoElCOOYP2LQGzLGX
         4iT6XvAdWfDf7E7jsmPJgEuN9esLCVbxm1lfF3iOhX1EOoMrmPHKC9+4+LDRNvtO7i95
         zWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697560291; x=1698165091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2A8hcMW9oFp1Qg8zy8Z8vYpexHa6tGY5QnuDCf8HvQ=;
        b=Ni9B0q9RscWoZ6+WQ+J6d/y4R1Lg86Ym/VXZyV/NA+Fxbl/qdedP/SAE8PyIcsMXnp
         nef7gKItH6RGeMrtv292IEIAkON6MCQawYWmEWoCoDdlXIFkMCMC7pfCkZyW388lGNuw
         92JBM0R/aPP7PGGBMs4qGceASstxlf/DYJgpMDgzhTynX2xXDWYj2UGmS/N6CR+GoeLb
         Wa8TRRaMVpiusEtprx7uXm3/98OYmaoruCU1HaEClujNoXikk7VFl4IcNWQlAUgLapk0
         bJmMzjtCkz/mtDT0VHu2G4B/mXmeXtrxVBivkJz6YsZ+TdEhr8slaskW7s2pysmXcmyv
         iMPg==
X-Gm-Message-State: AOJu0YyaZq4lN+DeGRfCJAoGNOw5f4MwfFTk6W7kt8FofSfWySxU9+Wu
	+Q1FCtZtTruRUg8QgsIHd+gTmF6+gFgkSktnY0v+uQ==
X-Google-Smtp-Source: AGHT+IHZN7klXtHwx1L6AhEkJD8wFqMqn7QHoLBe0NVrtwi51o8fuYl9hDEOwcWUMjGk8cMrc7sxTw==
X-Received: by 2002:a05:6214:258a:b0:66d:130c:bb9d with SMTP id fq10-20020a056214258a00b0066d130cbb9dmr3162940qvb.13.1697560291008;
        Tue, 17 Oct 2023 09:31:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id eu2-20020ad44f42000000b006575372c845sm676342qvb.119.2023.10.17.09.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:31:30 -0700 (PDT)
Date: Tue, 17 Oct 2023 12:31:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 6/7] bulk-checkin: introduce
 `index_tree_bulk_checkin_incore()`
Message-ID: <57613807d84d19fa2691fcf7fe81c4aa9a575d4b.1697560266.git.me@ttaylorr.com>
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

The remaining missing piece in order to teach the `merge-tree` builtin
how to write the contents of a merge into a pack is a function to index
tree objects into a bulk-checkin pack.

This patch implements that missing piece, which is a thin wrapper around
all of the functionality introduced in previous commits.

If and when Git gains support for a "compatibility" hash algorithm, the
changes to support that here will be minimal. The bulk-checkin machinery
will need to convert the incoming tree to compute its length under the
compatibility hash, necessary to reconstruct its header. With that
information (and the converted contents of the tree), the bulk-checkin
machinery will have enough to keep track of the converted object's hash
in order to update the compatibility mapping.

Within `deflate_tree_to_pack_incore()`, the changes should be limited
to something like:

    struct strbuf converted = STRBUF_INIT;
    if (the_repository->compat_hash_algo) {
      if (convert_object_file(&compat_obj,
                              the_repository->hash_algo,
                              the_repository->compat_hash_algo, ...) < 0)
        die(...);

      format_object_header_hash(the_repository->compat_hash_algo,
                                OBJ_TREE, size);
    }
    /* compute the converted tree's hash using the compat algorithm */
    strbuf_release(&converted);

, assuming related changes throughout the rest of the bulk-checkin
machinery necessary to update the hash of the converted object, which
are likewise minimal in size.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 27 +++++++++++++++++++++++++++
 bulk-checkin.h |  4 ++++
 2 files changed, 31 insertions(+)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 25cd1ffa25..fe13100e04 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -423,6 +423,22 @@ static int deflate_blob_to_pack_incore(struct bulk_checkin_packfile *state,
 						   OBJ_BLOB, path, flags);
 }
 
+static int deflate_tree_to_pack_incore(struct bulk_checkin_packfile *state,
+				       struct object_id *result_oid,
+				       const void *buf, size_t size,
+				       const char *path, unsigned flags)
+{
+	git_hash_ctx ctx;
+	struct hashfile_checkpoint checkpoint = {0};
+
+	format_object_header_hash(the_hash_algo, &ctx, &checkpoint, OBJ_TREE,
+				  size);
+
+	return deflate_obj_contents_to_pack_incore(state, &ctx, &checkpoint,
+						   result_oid, buf, size,
+						   OBJ_TREE, path, flags);
+}
+
 static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 				struct object_id *result_oid,
 				int fd, size_t size,
@@ -514,6 +530,17 @@ int index_blob_bulk_checkin_incore(struct object_id *oid,
 	return status;
 }
 
+int index_tree_bulk_checkin_incore(struct object_id *oid,
+				   const void *buf, size_t size,
+				   const char *path, unsigned flags)
+{
+	int status = deflate_tree_to_pack_incore(&bulk_checkin_packfile, oid,
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
index 1b91daeaee..89786b3954 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -17,6 +17,10 @@ int index_blob_bulk_checkin_incore(struct object_id *oid,
 				   const void *buf, size_t size,
 				   const char *path, unsigned flags);
 
+int index_tree_bulk_checkin_incore(struct object_id *oid,
+				   const void *buf, size_t size,
+				   const char *path, unsigned flags);
+
 /*
  * Tell the object database to optimize for adding
  * multiple objects. end_odb_transaction must be called
-- 
2.42.0.405.gdb2a2f287e


Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EBA347C9
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="EbmIGWah"
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D63CF
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:28:50 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d77ad095f13so8515505276.2
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697736530; x=1698341330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+DEeCy474bdzfkPR1WnB7ovUU7jUK0mCkLA5nybjF8=;
        b=EbmIGWah1t7gcxVP/vI5YD58zLpRDVoxrrJ2dyjh5oyNfvPSPNFxdWDrt5jPSbl3Y/
         XwHMxSa9q6vI/JnQbIlzt2bMVMuEvA5HMcB/UfKBGTyJRQKMJt8/ZVAWGZgactPIDajT
         rrzdDBHROuEnXtyi/Aul0Q4eug/c1W59OzM7/hKTxKuODVnnQMpmVJDmPNWlx+qgTuey
         Ng2Hrc/bzt/QfXDXDV/wbRGtf0bfV78hmzoZnOOLA5lStNiU1LujIfGud7isuGuzcEix
         n8GNcd6PYi+zg7Xv3NtwZDZ+rfIFuDDKg0m1mZSylXSxicsfmLpG+yD1MC9uIR819DWH
         7NcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697736530; x=1698341330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+DEeCy474bdzfkPR1WnB7ovUU7jUK0mCkLA5nybjF8=;
        b=B9CY5pA2QUmOgd/p4QHw/F/w49mNCRHHazaqHu3voPm9Qb8+a0ZQGA/7RoN426rmve
         tZMXi1jfGk9BBE8gEbBCX6Ydsz/ygaV2GSeSGIZ46J0V2/K5S6HaZlGQy5Nl4r79uWoa
         alqSaakqd+W9eQdk956sar3DtFYzQstYhu1Cz3zP4lqB+X9Uf7LnDAcCsk94V55lfxyt
         y+VL2sLc+MldHSIqI/BPJAfI96V5Gr6ERYxbhI8CFYQDlBg2OUlGr/FykCj7fgaXZkA9
         mAdmj4skjI6xb8EOy2w8dDzGB7BewNpRLpHezQN0dHdZSfoeUs2XI+3pAAx/snjv5V0M
         UvUw==
X-Gm-Message-State: AOJu0Yw9cvvfYX6bLRoUv4yvu/+XV5G1yHcXAyu/6PoncH3KbtK/Gf8j
	YzVk5Ae6a71qEeAGkT0KC313dq67G0mDl9Tg/3QDVw==
X-Google-Smtp-Source: AGHT+IFxkAyETLOZIuZ5HpSGeVEpOSIvlY8OXN3jSPSys2rXWcDLppIBHu8939vtp328qAJzM5vudg==
X-Received: by 2002:a25:3d5:0:b0:d9a:58e1:106d with SMTP id 204-20020a2503d5000000b00d9a58e1106dmr2911711ybd.52.1697736529860;
        Thu, 19 Oct 2023 10:28:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id lg8-20020a056214548800b0066d05ed3778sm15830qvb.56.2023.10.19.10.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 10:28:49 -0700 (PDT)
Date: Thu, 19 Oct 2023 13:28:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 3/7] bulk-checkin: refactor deflate routine to accept a
 `bulk_checkin_source`
Message-ID: <d5bbd7810ee8f90be4cf6028f6420f52d72d24d0.1697736516.git.me@ttaylorr.com>
References: <cover.1697736516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697736516.git.me@ttaylorr.com>

Prepare for a future change where we will want to use a routine very
similar to the existing `deflate_blob_to_pack()` but over arbitrary
sources (i.e. either open file-descriptors, or a location in memory).

Extract out a common "deflate_obj_to_pack()" routine that acts on a
bulk_checkin_source, instead of a (int, size_t) pair. Then rewrite
`deflate_blob_to_pack()` in terms of it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 52 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 7e6b52112e..28bc8d5ab4 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -285,30 +285,23 @@ static void prepare_to_stream(struct bulk_checkin_packfile *state,
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
-	struct bulk_checkin_source source = {
-		.type = SOURCE_FILE,
-		.fd = fd,
-		.size = size,
-		.path = path,
-	};
 
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
@@ -317,8 +310,6 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	if ((flags & HASH_WRITE_OBJECT) != 0)
 		CALLOC_ARRAY(idx, 1);
 
-	already_hashed_to = 0;
-
 	while (1) {
 		prepare_to_stream(state, flags);
 		if (idx) {
@@ -327,7 +318,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 			crc32_begin(state->f);
 		}
 		if (!stream_obj_to_pack(state, &ctx, &already_hashed_to,
-					&source, OBJ_BLOB, flags))
+					source, type, flags))
 			break;
 		/*
 		 * Writing this object to the current pack will make
@@ -339,7 +330,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 		hashfile_truncate(state->f, &checkpoint);
 		state->offset = checkpoint.offset;
 		flush_bulk_checkin_packfile(state);
-		if (bulk_checkin_source_seek_to(&source, seekback) == (off_t)-1)
+		if (bulk_checkin_source_seek_to(source, seekback) == (off_t)-1)
 			return error("cannot seek back");
 	}
 	the_hash_algo->final_oid_fn(result_oid, &ctx);
@@ -361,6 +352,25 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	return 0;
 }
 
+static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
+				struct object_id *result_oid,
+				int fd, size_t size,
+				const char *path, unsigned flags)
+{
+	struct bulk_checkin_source source = {
+		.type = SOURCE_FILE,
+		.fd = fd,
+		.size = size,
+		.path = path,
+	};
+	off_t seekback = lseek(fd, 0, SEEK_CUR);
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
2.42.0.405.g86fe3250c2


Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E453D3AE
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kPYiS3N2"
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D433845
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:08:17 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-778925998cbso58809285a.0
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697648896; x=1698253696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ygAZDf+SJgG4c9MIqaGaEA338zYBwYZtx0qiouBEqVc=;
        b=kPYiS3N2rlpH6V9N5aYyO1OmedJ/lCVvS8q3SEmg7Od87WeBr/LZVVKZXQ+cPPcJVD
         MK2zLmTQ3HA/QU8qyHAHMVi8OwTZruKpn43LpnnAUBjo98aiydOGf1nLwoHMUQcSFkK2
         Jb8PyvKhExbqI4mkD6kAdFgAyrjFXCVHLBhMIpy/1sUprtkbvqcTgUuCC6NsUysVVj7b
         bQDH8alH2uvwAKg5V/D0digLNM2mzG/aOh7IJ0XqekfRhhsRF4NuvwKXYvtgx9h96Z3p
         VZ8fohN7tEzJv4WIV5uZjFXsPEEXn99hlkKNPnLefWRkiLpMjxhXCONaRfYQk5YeKl94
         38Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648896; x=1698253696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygAZDf+SJgG4c9MIqaGaEA338zYBwYZtx0qiouBEqVc=;
        b=btsGKDmd4YU7qTZi+xsu4KSCBGyqOiThGiNBjvn4IYEceAJCD1IwZjCzy42ER78JRg
         lgSJarqgxja58wFiQSY6g0IpAFQ4Wgeb4zEDd1TLfJNwPrToqS3B5HCVhIh/MfOjwbSh
         K4aF1g9ikPUVQCGwxd91C/DAuRmfkvQrK7cZ4LCZJDnL7UFV9EDwEvc71seiM8ez75kd
         FEbVXdm4ED8uCN5OzP5GLCcILaSAtECzmW5+3TY9ZPHtEIWwmvBWKukIBAU8eXiYWG8f
         COcsJDrUGPn8ZVaUBZgBtsCkKnXC2AIo80SBVscO3EWxH9UvrjfJpWAxuoAmtfx6pub1
         Pw0A==
X-Gm-Message-State: AOJu0YxA1P5Uxs1XwoZWc/RUFn7AwY7nGTwC8t8Oi3I6lW2vO8GVHae7
	tt5q4gfs4N15nFwNwIyo0e7eASzS5F/Ijd1fGAp6KA==
X-Google-Smtp-Source: AGHT+IFkahsNR5g7J0bO/cUyxRd2NqikATx2PCvfNBVj1w/cCd1xjmAQWNpVvPf7EQGc/dtxiiraBg==
X-Received: by 2002:a05:620a:2891:b0:777:5e79:d280 with SMTP id j17-20020a05620a289100b007775e79d280mr6162349qkp.53.1697648895970;
        Wed, 18 Oct 2023 10:08:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m17-20020ae9e011000000b00774830b40d4sm101450qkk.47.2023.10.18.10.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:08:15 -0700 (PDT)
Date: Wed, 18 Oct 2023 13:08:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 09/10] bulk-checkin: introduce
 `index_tree_bulk_checkin_incore()`
Message-ID: <cba043ef14fbf6fdeacc213669bb95f1e6f81f8a.1697648864.git.me@ttaylorr.com>
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
index 9ae43648ba..d088a9c10b 100644
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
@@ -520,6 +536,17 @@ int index_blob_bulk_checkin_incore(struct object_id *oid,
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
2.42.0.408.g97fac66ae4


Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742BE3551E
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="A+I7sw3K"
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35472121
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:29:00 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41cc776ccb4so6608441cf.1
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697736539; x=1698341339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SJDkSjt2ki+3DLRlhDqakH7kpII7dPEZ57X0nfOaBPU=;
        b=A+I7sw3K9gQnssgSFGDeg30OOMzEqHvM0+YIrq0+NnswbBQmbVFIM7d6SMNqYbtxH5
         qY4gkrB5OrqvL0N75xutGf0DnDjZo518JbBvHc3S01QrDYdw6VVKV2BFK+oo1lUrrIOG
         CuHYmCJ6njMmizVaRzwX7gaCMVgPqE89NO1Ty2p8HnAgACACVAthCePUOcJCzSEL2uUA
         T7z4OIaVdzxHRny073dNDWvNSHoV74ch2ShE45BMMNaQ2ncEBI4R1HlPrTngRf+S1Ixx
         /003K+DOtJwAZARDCFAt2e5UOWKWXxEdXOeOSo0U23BFCXWQG6vZIA/qleku6Oh45sw4
         aNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697736539; x=1698341339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJDkSjt2ki+3DLRlhDqakH7kpII7dPEZ57X0nfOaBPU=;
        b=oIe9g9Xr7g56SAAjYAbPEi8Puv5O00cscS5PgldUgG8g5hHNJBCsSjfhqVl/OnLRCD
         lboyDdthvtBuk7OlghSh+8pH4yaJsaEWde/n2fVSxHdOKAnyPAMCDNVKYeTeAid66fAi
         mqaSZuozhTM9h1u6j5lpROItNG8JrsmJY3WdMJE2bG48rrHHTOOiW0AAOa/AnEkDBBaR
         MJ0rAZmK1H3j3wbNOwrImpVLdZrOVgipfoLLbw2zAmztVCzmEtuYtUh4UnfrqgaBUtmz
         SgsW4BshcKnMEfHm5X7WwibASNoeocELDGLaabDmLKWNFewWNz6ngVAGYi7w1y29pYDM
         LmDQ==
X-Gm-Message-State: AOJu0Yx28cBpKwQw2TuxPbSBA0X9xVT0PENu4ra8lIxsJRsgdE3277VS
	TeKh+LubwbWCHsQYfbchOVdcgrF5FewGS6Ma1zrJGg==
X-Google-Smtp-Source: AGHT+IFr5qZHpzHunS/epBrOCjQOnKtG8kB6PpNlPXd+EbLuiXcEdD3scwZ2UGnvrrZeSemq22kkGw==
X-Received: by 2002:ac8:5f8b:0:b0:412:2ed3:38ec with SMTP id j11-20020ac85f8b000000b004122ed338ecmr3571486qta.18.1697736539135;
        Thu, 19 Oct 2023 10:28:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o9-20020ac85a49000000b004199f47ccdbsm883731qta.51.2023.10.19.10.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 10:28:58 -0700 (PDT)
Date: Thu, 19 Oct 2023 13:28:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 6/7] bulk-checkin: introduce
 `index_tree_bulk_checkin_incore()`
Message-ID: <60568f9281c2588f777e3886610a1b40730fcc0f.1697736516.git.me@ttaylorr.com>
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

Within some thin wrapper around `deflate_obj_to_pack_incore()` (perhaps
`deflate_tree_to_pack_incore()`), the changes should be limited to
something like:

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
 bulk-checkin.c | 12 ++++++++++++
 bulk-checkin.h |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 655a583b06..c1faf75f5f 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -460,6 +460,18 @@ int index_blob_bulk_checkin_incore(struct object_id *oid,
 	return status;
 }
 
+int index_tree_bulk_checkin_incore(struct object_id *oid,
+				   const void *buf, size_t size,
+				   const char *path, unsigned flags)
+{
+	int status = deflate_obj_to_pack_incore(&bulk_checkin_packfile, oid,
+						buf, size, path, OBJ_TREE,
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
2.42.0.405.g86fe3250c2


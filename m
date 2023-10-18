Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A24A3D961
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KXm34lYm"
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562F630EC
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:08:03 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41c157bbd30so10545541cf.0
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697648870; x=1698253670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bemIE568wjYmkD8+0jqFSRkI1H3MvGZ4fBnPWLhW4Y=;
        b=KXm34lYm1xthuWIMiS1js+9P8P2W/x9UfHiNVyQrawob3czVSK1gyHh61bX03LDJOW
         Y2sqQ+huoMZPVKcF6+GlABkwfHaNBCmBbgFaG+pncrx+IAXM42dOzPDSZDnVG/PKc/SW
         LC4S87XSAasVmVaM0lyVoiSCd0aKBMjzoxwtvTeeiQUtYaZuu1Uaos7cdluFvujg+21y
         nUjbzrcrp+hzAkxgl06JJDgbiPs7a3vbp0/aetmng7NiSQR1/+DonaOB108IU54KpZRH
         03+heV2LjoTxFeAwtaIUXy8FBBPO60XfKkD+HR2Tl/fhWd35jndj/F2KpT5O6/98HT9U
         5hIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648870; x=1698253670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bemIE568wjYmkD8+0jqFSRkI1H3MvGZ4fBnPWLhW4Y=;
        b=lVHHK+mjNVD0BRyF+HYReFks/7LusFw4PgNA0sDES5G4Te2oU1SLXXHDi3EOBqRhE0
         7hpZQDDQ++at+hB06X6g32p8ob4aRg6QvsbTKpyTS4ZBKYPKU4JDj7Zoo0Ut2vkg3g6w
         dO1vIi0BELnpIppB8cQ6iBlaERbBaWexSuu8ZK2A7h/kNuvdYCEmHeS6l080ZMPUDffP
         /qwTc3ygZ5JnNpeAILkJ3e5XxVpidy7lgOU5Vevh0l2M2kSfujqdET8LoQuknfY6dI5K
         VU+SOBABvAFtKdfc7RwdWkd9X6Ee8nMiHBC8gmAGteYOPwP92SldONBcNqpQ4oq2DL/v
         2wOw==
X-Gm-Message-State: AOJu0YyGnQu+TKP/i6SUrM9Dc77xwhLL75D3HNm53pPNrbdzrGisYhCJ
	X1xT46mDD+zYeG0cGGViCEi7fe664pFj+I/8J4ctzQ==
X-Google-Smtp-Source: AGHT+IGYgKvORG9mKnBjLDinDoaTg6v4miW1iO+0/Ed4a3Kli0GSiMvau+565JUbn/cf+p1VItCOvw==
X-Received: by 2002:a05:622a:34f:b0:40d:589d:9ce5 with SMTP id r15-20020a05622a034f00b0040d589d9ce5mr6854624qtw.34.1697648870530;
        Wed, 18 Oct 2023 10:07:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x24-20020ac84a18000000b00417f330026bsm95197qtq.49.2023.10.18.10.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:07:50 -0700 (PDT)
Date: Wed, 18 Oct 2023 13:07:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 01/10] bulk-checkin: factor out
 `format_object_header_hash()`
Message-ID: <2dffa4518339a7b96a885db4c64431276bfeb4d6.1697648864.git.me@ttaylorr.com>
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

Before deflating a blob into a pack, the bulk-checkin mechanism prepares
the pack object header by calling `format_object_header()`, and writing
into a scratch buffer, the contents of which eventually makes its way
into the pack.

Future commits will add support for deflating multiple kinds of objects
into a pack, and will likewise need to perform a similar operation as
below.

This is a mostly straightforward extraction, with one notable exception.
Instead of hard-coding `the_hash_algo`, pass it in to the new function
as an argument. This isn't strictly necessary for our immediate purposes
here, but will prove useful in the future if/when the bulk-checkin
mechanism grows support for the hash transition plan.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 6ce62999e5..fd3c110d1c 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -247,6 +247,22 @@ static void prepare_to_stream(struct bulk_checkin_packfile *state,
 		die_errno("unable to write pack header");
 }
 
+static void format_object_header_hash(const struct git_hash_algo *algop,
+				      git_hash_ctx *ctx,
+				      struct hashfile_checkpoint *checkpoint,
+				      enum object_type type,
+				      size_t size)
+{
+	unsigned char header[16384];
+	unsigned header_len = format_object_header((char *)header,
+						   sizeof(header),
+						   type, size);
+
+	algop->init_fn(ctx);
+	algop->update_fn(ctx, header, header_len);
+	algop->init_fn(&checkpoint->ctx);
+}
+
 static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 				struct object_id *result_oid,
 				int fd, size_t size,
@@ -254,8 +270,6 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 {
 	off_t seekback, already_hashed_to;
 	git_hash_ctx ctx;
-	unsigned char obuf[16384];
-	unsigned header_len;
 	struct hashfile_checkpoint checkpoint = {0};
 	struct pack_idx_entry *idx = NULL;
 
@@ -263,11 +277,8 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	if (seekback == (off_t) -1)
 		return error("cannot find the current offset");
 
-	header_len = format_object_header((char *)obuf, sizeof(obuf),
-					  OBJ_BLOB, size);
-	the_hash_algo->init_fn(&ctx);
-	the_hash_algo->update_fn(&ctx, obuf, header_len);
-	the_hash_algo->init_fn(&checkpoint.ctx);
+	format_object_header_hash(the_hash_algo, &ctx, &checkpoint, OBJ_BLOB,
+				  size);
 
 	/* Note: idx is non-NULL when we are writing */
 	if ((flags & HASH_WRITE_OBJECT) != 0)
-- 
2.42.0.408.g97fac66ae4


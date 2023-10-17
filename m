Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F3C2D02E
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="k6vcL/vb"
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11EBB0
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 09:31:18 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41cb78cf0bfso1701401cf.2
        for <git@vger.kernel.org>; Tue, 17 Oct 2023 09:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697560278; x=1698165078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XA1jNB253C8JW5YaAnb1x1RlQnaHoKx+PjAakGcUEIo=;
        b=k6vcL/vbSjSZa9fXcaT3CmldOTFUPIJ2jyuPpSY39leGMjRBrnNHDhiQ3eN+Re2ITx
         ikTcAQTNhp0tUZ9BSkW7p6MTD4DqksLAHIjF1iICGEcaQlSA4f4HMV1bIk+jNhMAvM8U
         bud0DPPOa9Mozkfl7lPZrXU/lQ7z98jVzSWbX+VTI+JjsIQJH648z7VYzH+m5XDJZshO
         h0xAa61z8lXIwPncgUPxPndbMuPMWWDPtFXCRFzL3tGjMEnRg33sU+NmsKunC8onRjLE
         Sy4sssx7Fot/HEUXhVWL6mRQGMwxtA6vyifR3EL1UH64wUOU8QQXnDgdW0RMEwdPMPJP
         yE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697560278; x=1698165078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA1jNB253C8JW5YaAnb1x1RlQnaHoKx+PjAakGcUEIo=;
        b=Y4A1p8qKLMlD/bbLa1K0gjJtTX28U7KtjoT/fuC7St6oLt9gaCz0oEpZrebhFzFyzS
         9RQ5Oqe+0Kqc1n0jyUaLwkZsFncrJHXIHhhl0s+dTiATbj1XmCrLKjjiudmayLN2QqbV
         io4KS1Qv6fVHMSZq4NGL9zgmx33tUsn09OS6quUXfOmzKl7MMJazq7We/TC0gGjc3v6Y
         cLnaigA/GwMU4/7C+c+Gc5Q+94qiiW2SugXY9HiZN3kbAiKoX7x2LxWFEIIiG89BYRff
         W3vXipk8saLguKEqBp0TQ8B6pICzj3zw713JpwUCfY/9nBCmjJONnXWHMDulY9EoK3tp
         vOhA==
X-Gm-Message-State: AOJu0YxS4+iXXC8e7zd7/ElsCALRALW+M2/1n7L+Lc0V/vTKWgc9WTGe
	wIqV19dfnvHXaX2DFqAfPn24TvTSqJAS5Ha2LDHV6w==
X-Google-Smtp-Source: AGHT+IHUbnj+8apHB3tZ/hQWlS6BL7GOzJaPgPMAwOk2eFNKL4z9WuNAuX2l+Ece3uAKbOkVn0dS/g==
X-Received: by 2002:a05:622a:18c:b0:417:b269:4689 with SMTP id s12-20020a05622a018c00b00417b2694689mr2865213qtw.53.1697560277689;
        Tue, 17 Oct 2023 09:31:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d17-20020ac85451000000b0041cb8732d57sm168396qtq.38.2023.10.17.09.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:31:17 -0700 (PDT)
Date: Tue, 17 Oct 2023 12:31:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/7] bulk-checkin: factor out `prepare_checkpoint()`
Message-ID: <b3f89d5853174d2bbf694f6a3b89dc700575cf24.1697560266.git.me@ttaylorr.com>
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

In a similar spirit as the previous commit, factor out the routine to
prepare streaming into a bulk-checkin pack into its own function. Unlike
the previous patch, this is a verbatim copy and paste.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index fd3c110d1c..c1f5450583 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -263,6 +263,19 @@ static void format_object_header_hash(const struct git_hash_algo *algop,
 	algop->init_fn(&checkpoint->ctx);
 }
 
+static void prepare_checkpoint(struct bulk_checkin_packfile *state,
+			       struct hashfile_checkpoint *checkpoint,
+			       struct pack_idx_entry *idx,
+			       unsigned flags)
+{
+	prepare_to_stream(state, flags);
+	if (idx) {
+		hashfile_checkpoint(state->f, checkpoint);
+		idx->offset = state->offset;
+		crc32_begin(state->f);
+	}
+}
+
 static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 				struct object_id *result_oid,
 				int fd, size_t size,
@@ -287,12 +300,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	already_hashed_to = 0;
 
 	while (1) {
-		prepare_to_stream(state, flags);
-		if (idx) {
-			hashfile_checkpoint(state->f, &checkpoint);
-			idx->offset = state->offset;
-			crc32_begin(state->f);
-		}
+		prepare_checkpoint(state, &checkpoint, idx, flags);
 		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
 					 fd, size, path, flags))
 			break;
-- 
2.42.0.405.gdb2a2f287e


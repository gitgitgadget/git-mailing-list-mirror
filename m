Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928813419A
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="m2r5D9MI"
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB75106
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:28:48 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41cbf31da84so12602751cf.0
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697736527; x=1698341327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iQ79seosJVSXf5DET4/gvh4mgHAm7F22J5mTWmTlEb0=;
        b=m2r5D9MI5giywcXAnmA1euTsM1z373Rvp2jj94EB8nwH48XAuz68SnU62tSQVDDIck
         Zndj02/PnyEq+GEn28HTkhyop3p1/0fhCc8H4H555RTrFJ8lC8D6ig+b0oHrq9xHDoQ1
         EYywNe2nM+4mqyrLdfBYtlPBYjPwY9oLksmKwFU8znb+mzkvt/yrrz7vivLzVVIoc0aV
         syrqzO15H8p5qVnUPhlJyOGuY7AwHqnU26Lq4JcfdI417gMXcfg27h1diNztyQjfJ6W1
         l0IevElvsv2UZdVudihPLidz9yZgBedh2DZPPt2lJd5FBLLCnu2+hjRxjf1ZYOPtZuv7
         b/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697736527; x=1698341327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQ79seosJVSXf5DET4/gvh4mgHAm7F22J5mTWmTlEb0=;
        b=BYOYqUfZTAQwmY693DLXLorGKvKipvwvArPGbeJHSmSjqPMYOiqVdpqqTziU8q4yzN
         dD/VSOiCYthOS/f4FaA+s7IoWJposbcuphkYWix8Ni9RSG7v6nWyktRhMNDPc1O7DvKD
         jtmUw5DrhfSFDUBZFqJ2yLBXoBaIliyzPFBZi6Cke6NURD4vgfM7ZKYtbR1gS5GT1P+H
         OgQdVsQx4tmXyHJ6smDrLbBqcbS9PMEZQlTpdb09NpsAuv2gKKJJ5E76293ZLLiLG6v0
         vvi8ThLWVt74gzMQQjBJWKAEjUFQyBZQr27N+uAjZ8TTJDH+uqw7xF7Xru8nEenFViCZ
         ZTRA==
X-Gm-Message-State: AOJu0Yyp7UsFWJvsjsr2AQwECSP2S5p6mSh4+KYWnoN5wlgirrLbr8K5
	6YIHHd4OMw1iVp39n2SHI5kweXMeAoJ1S7KsjQAycQ==
X-Google-Smtp-Source: AGHT+IFvrnvIUC8jTKYgZbuyTy5ZqzMclypClo9Fwg3oZl3hioNElH8uSPV/a/k8gpWfpZbIc20Fmw==
X-Received: by 2002:ad4:5be2:0:b0:66d:44c9:ac8 with SMTP id k2-20020ad45be2000000b0066d44c90ac8mr3390774qvc.24.1697736526948;
        Thu, 19 Oct 2023 10:28:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f8-20020a0cf7c8000000b006564afc5908sm9341qvo.111.2023.10.19.10.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 10:28:46 -0700 (PDT)
Date: Thu, 19 Oct 2023 13:28:45 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 2/7] bulk-checkin: generify `stream_blob_to_pack()` for
 arbitrary types
Message-ID: <9d633df339f2a769bcae4d6328ca47915184e4aa.1697736516.git.me@ttaylorr.com>
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

The existing `stream_blob_to_pack()` function is named based on the fact
that it knows only how to stream blobs into a bulk-checkin pack.

But there is no longer anything in this function which prevents us from
writing objects of arbitrary types to the bulk-checkin pack. Prepare to
write OBJ_TREEs by removing this assumption, adding an `enum
object_type` parameter to this function's argument list, and renaming it
to `stream_obj_to_pack()` accordingly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index c05d06e1e1..7e6b52112e 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -188,10 +188,10 @@ static ssize_t bulk_checkin_source_read(struct bulk_checkin_source *source,
  * status before calling us just in case we ask it to call us again
  * with a new pack.
  */
-static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
-			       git_hash_ctx *ctx, off_t *already_hashed_to,
-			       struct bulk_checkin_source *source,
-			       unsigned flags)
+static int stream_obj_to_pack(struct bulk_checkin_packfile *state,
+			      git_hash_ctx *ctx, off_t *already_hashed_to,
+			      struct bulk_checkin_source *source,
+			      enum object_type type, unsigned flags)
 {
 	git_zstream s;
 	unsigned char ibuf[16384];
@@ -204,8 +204,7 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 
 	git_deflate_init(&s, pack_compression_level);
 
-	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_BLOB,
-					      size);
+	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), type, size);
 	s.next_out = obuf + hdrlen;
 	s.avail_out = sizeof(obuf) - hdrlen;
 
@@ -327,8 +326,8 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 			idx->offset = state->offset;
 			crc32_begin(state->f);
 		}
-		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
-					 &source, flags))
+		if (!stream_obj_to_pack(state, &ctx, &already_hashed_to,
+					&source, OBJ_BLOB, flags))
 			break;
 		/*
 		 * Writing this object to the current pack will make
-- 
2.42.0.405.g86fe3250c2


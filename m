Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB439CA66
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VWvMI4/T"
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDC9B0
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 09:31:15 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-774141bb415so357749085a.3
        for <git@vger.kernel.org>; Tue, 17 Oct 2023 09:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697560274; x=1698165074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hCmeGXai+JkrXjSHBFW1AM9uwKhigNCKnvl4mAcXjGE=;
        b=VWvMI4/Tm3GURmxwNCGbhhqPM1NoWecfxHOYi/FZtYDs2+PlHFiYQS9ssS3g8mbTv9
         +/QSFbS0FuqpytzHUnnSdOP0hSQ2i56gRct6CS5Qu8Q4mFtBZTNOaXB3xYSqShZBiqgN
         ZjNc8rFiYCCmhsE4eRqYq+p0XagP4pwZilst+SH9RtlOaZ2NSvU8RdXKCubmgHhihiYY
         PuWhw+C9F6yC2fvss/WjZNQtf8RMW7coQ2YCGAbXlH29aq6t3Jbl6tcEXv8vTMytrV1Q
         Uc+RYOixt9JLzzyix3qHjA94mg4R9QdY3X4WgkgJ+/Mk22BfNnJxnfZY7FCHtir1bFqb
         W5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697560274; x=1698165074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCmeGXai+JkrXjSHBFW1AM9uwKhigNCKnvl4mAcXjGE=;
        b=ozewp2S+M1HKw9NlpcXFfUoAWDK/zIEaomT9v+qS/nqeSj1R+EtMuADIJGJ18s8SN8
         v/4fldmYy8waJBSveE6TCQcpA8Sga16XJ+jDWdbWi2P3/VuP31MXbKVyGLlWz9klBbbv
         XvyVZC5haZL5a6yqUcVhYKABCQd203x2jYxlYmUzTFSeIY+39V1S6DjBg1bIHcPGH4/T
         8UNewH47IA/TuRLQFypOnAX/tVkuKi5e005RPjP/gK5DviTlFuMwvNZF5AJai0NP9gAt
         W1D2R9+hNCvHDbp33BJYbGe/nF3TUCX098TKTGzPvPrJpYw2cWcFwkiBKa5RZIxzhE2a
         GksA==
X-Gm-Message-State: AOJu0YyP8agx7FOacUOsz6S0G4fZLPSsfwgcjdP0WLWv62Udx6qI314o
	ybzRD2rXC+6Zqp5fOqBzKnsHAyIhiManIoVvmKccow==
X-Google-Smtp-Source: AGHT+IGdGeyXsOq+V2vTBh0WEF1+i7n0Ws2vPKvi06nkD4rwkgZhaGck2/d7wUKhcgWSj5aBn0xeMA==
X-Received: by 2002:a05:620a:2844:b0:777:4519:4d81 with SMTP id h4-20020a05620a284400b0077745194d81mr3056708qkp.58.1697560274103;
        Tue, 17 Oct 2023 09:31:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s17-20020ae9f711000000b0076f16e98851sm782354qkg.102.2023.10.17.09.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:31:13 -0700 (PDT)
Date: Tue, 17 Oct 2023 12:31:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/7] bulk-checkin: factor out `format_object_header_hash()`
Message-ID: <edf1cbafc166bce619541cadc1d6fc2c1d9b84d6.1697560266.git.me@ttaylorr.com>
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
2.42.0.405.gdb2a2f287e


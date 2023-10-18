Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FA23FB01
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="rizEGvnB"
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77607324B
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:08:07 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-66cfd0b2d58so45115336d6.2
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697648874; x=1698253674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BNgyPonwnkyrYBF3IPJVbzk9x7EP0eogM8Bn+m/YpI=;
        b=rizEGvnB7cv8Fhi1yh6zFEid3clfjSFKQWlmOEyXzb3gcOjjMJSHn8mutJ8OeT4kzg
         x9ir4G6ROH0EjTjOqYRaNeg3HbGB00tFU+MbHYxpWtGuSh7MxnKvMKueLlk4M+KfKa4o
         LBhKDyvtdg8dSY34OdCVYsQFwWGBRQ1S9Ujwiq1boNfuXZFgIcQ4MxH58zkv2ryezh5j
         rKFxdzYTLVq3784Q95lnr0sC/WNBqfP+lO9GplKBuunoG6qFzTvDlZv8Mz+0IiTlfUml
         3zzBd4bRbgXyQduS8b42hQ3e3HeSe5/Iv60TeMQqpy382nrvljG8CygF2czG/FyXKPo3
         l7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648874; x=1698253674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BNgyPonwnkyrYBF3IPJVbzk9x7EP0eogM8Bn+m/YpI=;
        b=UFaNbopVMB72xUxL9LOK+WBCBtSuREsgkaydYu8cktC+7gFo4bde7zOcnT3WGR0rNU
         EXfMjOmPwf2sO6+W3nz8uVaGnlQwzoBPymKGCF7YkPOCjBwyOFrKypbzvKi+SdNbvh/0
         YmFSPDPCpNgZPO4zL4AX1lI+i5Qn/gi28iI5MJ7TLavNVhip7KgsMozItHsAwUKkU/tQ
         2MIJzvO8R4LHxlHg9GnDqMdJI+T0oOFxm2WJ7srSmPpleKsB1DfFmeSPh+gyDOTbohU1
         RA7fwFDUkzh+xsaIuPTAcFnfc7wQhdy55b2Rsk2RJ9YaT6nhjz8pVmoSwOxlVWT29rkw
         327A==
X-Gm-Message-State: AOJu0Yy9rYwWwoiqP4xFmJk0ljH65ChSXZ78nx2znaun28lTnWp4NZlP
	nh8Ngxif/uq74mBr0pg7/h3lk5AdEAdnl4PIamFd3w==
X-Google-Smtp-Source: AGHT+IGDJLNuJujknARTXunV9G2wC09IBUoNMX1UgDOmyROVbex3UEE+6dZqz0T6H9j9wDLElad6xQ==
X-Received: by 2002:a05:6214:628:b0:65a:f332:10f6 with SMTP id a8-20020a056214062800b0065af33210f6mr7114438qvx.35.1697648874309;
        Wed, 18 Oct 2023 10:07:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l15-20020ad4452f000000b0065b22afe53csm96001qvu.94.2023.10.18.10.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:07:53 -0700 (PDT)
Date: Wed, 18 Oct 2023 13:07:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 02/10] bulk-checkin: factor out `prepare_checkpoint()`
Message-ID: <7a10dc794aad20cfc226184acda1d40b191164d5.1697648864.git.me@ttaylorr.com>
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
2.42.0.408.g97fac66ae4


Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFDA3C685
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="PbpGXYCf"
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71877326A
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:08:10 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66d13ac2796so42057976d6.2
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697648877; x=1698253677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fzYxvgYmm/IptMXg/jU7ny3eQ+8FXjm1uBaFK6DT4hY=;
        b=PbpGXYCfjxy03wXqE4OuZENJKpnwr9vOK/4Q+uN7icLLceFUb8vRXrnZP74PFDsNVo
         4MBVXjTY96OBKtetGh7stx6l9KTYI3GjWcD2mllcJyA1jgutqSTJ4jL5xWfWV87EXWpu
         haCUr2iJHZ7LlhTK1Iky0SiOSboa09qFUoyM2/m/0wyDPkk+HGDJKRFfAjtXbrGgkWjK
         gMAwHsKKIyhKShSbq5usv8oJFVoB5Yq8ACy6CSwvW9S4CcAYwBDV1oe3Bl8I/z4SRdKf
         1jGnsYhJwqrH+B2VgVsIErzYcDfl0iwoS9kpnHdZruAXIxrG5F1hZr9fH6teI7n5BlWP
         tqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648877; x=1698253677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzYxvgYmm/IptMXg/jU7ny3eQ+8FXjm1uBaFK6DT4hY=;
        b=ug+o/6BwOQxDCiyMrDUije0nAF+Ew6784SbWnn+l8b5tbYQCF+xxSR++/LivxwFJNW
         3nnTv2ttLJHi8PlJrpILgdK0BJQWNiAtk/ILCO0aYXfZgEqsRTQoELYLv7akJYgeXa9t
         yyc9eiIbchuIIm14hPkJJoBs4uwA2ywqIGjvHYfce9RMMWK9Y0+M+wCPSt8TSaWBnr+0
         P5gmGHHZ8lzXjcb5dVnT7nvEVKMKn7Mkc/z09iEeDV1Tu+X4iLuxp+QxcxjUm4LwIUhT
         3F+TY7LwUjbfGhV53gRkNKzdMkmdXbtRgahNElbl4gVjOW0iYBuPJkyUBrwecjuzkJEC
         n14w==
X-Gm-Message-State: AOJu0YzRAbhWbm1vaBpKczZrSzPN1Y+qHr7YG1R4SeEF607K8V5aeG+n
	3ZJxfw2cZTMEYy2dWpDRJpRj4nhCPLejMCIfgLrfag==
X-Google-Smtp-Source: AGHT+IE8cTi6CJ/dAOlXX+UU5pH5Ie2erz3NhPCdw9TZZNpPJSuQeH2e1Djq6qjff8n2a/T5JuJUuQ==
X-Received: by 2002:a05:6214:d8e:b0:65d:f1d:d383 with SMTP id e14-20020a0562140d8e00b0065d0f1dd383mr6251643qve.3.1697648877689;
        Wed, 18 Oct 2023 10:07:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u11-20020a05621411ab00b0065b1bcd0d33sm94519qvv.93.2023.10.18.10.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:07:57 -0700 (PDT)
Date: Wed, 18 Oct 2023 13:07:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 03/10] bulk-checkin: factor out `truncate_checkpoint()`
Message-ID: <20c32d2178560180692327d8b93fe2a7adcf6ffd.1697648864.git.me@ttaylorr.com>
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

In a similar spirit as previous commits, factor our the routine to
truncate a bulk-checkin packfile when writing past the pack size limit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index c1f5450583..b92d7a6f5a 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -276,6 +276,22 @@ static void prepare_checkpoint(struct bulk_checkin_packfile *state,
 	}
 }
 
+static void truncate_checkpoint(struct bulk_checkin_packfile *state,
+				struct hashfile_checkpoint *checkpoint,
+				struct pack_idx_entry *idx)
+{
+	/*
+	 * Writing this object to the current pack will make
+	 * it too big; we need to truncate it, start a new
+	 * pack, and write into it.
+	 */
+	if (!idx)
+		BUG("should not happen");
+	hashfile_truncate(state->f, checkpoint);
+	state->offset = checkpoint->offset;
+	flush_bulk_checkin_packfile(state);
+}
+
 static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 				struct object_id *result_oid,
 				int fd, size_t size,
@@ -304,16 +320,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
 					 fd, size, path, flags))
 			break;
-		/*
-		 * Writing this object to the current pack will make
-		 * it too big; we need to truncate it, start a new
-		 * pack, and write into it.
-		 */
-		if (!idx)
-			BUG("should not happen");
-		hashfile_truncate(state->f, &checkpoint);
-		state->offset = checkpoint.offset;
-		flush_bulk_checkin_packfile(state);
+		truncate_checkpoint(state, &checkpoint, idx);
 		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
 			return error("cannot seek back");
 	}
-- 
2.42.0.408.g97fac66ae4


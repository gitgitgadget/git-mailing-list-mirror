Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE622D042
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DTgHHpZR"
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F027109
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 09:31:25 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7788fb06997so19878385a.0
        for <git@vger.kernel.org>; Tue, 17 Oct 2023 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697560284; x=1698165084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ODk6o/m079r0X5JbwmFY+jZkbdxnP1Q6CXZnnzNLwLE=;
        b=DTgHHpZRjvAhRYw2/8q5hpk2W2Yl2vegUlrfBoHPHUbzDuCkfaq7lPc1ypFOskd1Ux
         AIwthzbv9rVzBpC+GTK0rwS5SmnR+/yoXC1xOjbbtfmT97u45QB4j72sPdLFxTa+b8j+
         Nn4qFnrB4cffpe4RHVZCkrCY2GOQLNhdaR21VdeixaDznEMVogBVjxqpok/I57w529/N
         j4TC+/IfJPenYqiWdnxvHPkDKmnd5+yIrWgOevYo6qXFrRstN/3mmplXsX5ELJ0iF8Z2
         S8z2kB9Rr0sFmT8JbhmYoTNCZDS/sNkfPwAnpv4Fs+mrsU5MY7vS7XE+2eZnHCQ5BbQh
         cahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697560284; x=1698165084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODk6o/m079r0X5JbwmFY+jZkbdxnP1Q6CXZnnzNLwLE=;
        b=XQGfKzeQuTRvgNgjwFHam59rYY6MC9+oMd8V+Xh/kDbe8SvoD9KAnqCGQjbahUOPWu
         9TzptWRDhmox/b1gbeorvNGA2QoBrT2WDPg0o9jsnBpYO/y/BOUFk+X3Vzrjpk4hkzbq
         GlX/xDyuKpIcCzTcV151as3Wo6jKLu47KGq9F5qSKZqXCyXoTHOrD3iy12Sg8797NBYk
         ERnqcITi1fq4krlhhSNA0oVN2C4Yw/om45X7u25Y8MOo2Pq4bJ5FJE3LUmIMh0btOmDf
         9BcCo0VWJO/YAsUWJj1LoCaRTFlgD3dnZVNj/SP7ZiXIQMDch7WAmkQtCQPtibdg2gT/
         jMlg==
X-Gm-Message-State: AOJu0YwQP5bE4OYg1jWVFVe6ziBtcXtstwPGnqRXiXRqSk2FdWG9hzBw
	z62PeWqgVq2D6DbeqVcBfK53q+NdRcKaJ8NEghFHug==
X-Google-Smtp-Source: AGHT+IG/STNhfrnhEhZ09JMXBTatFAh5wXa8RWNJzvwOt/HiNyc/+OKyDywX/yk+u8ZiXAQPwfNguQ==
X-Received: by 2002:a05:620a:2995:b0:778:8fdf:1b4 with SMTP id r21-20020a05620a299500b007788fdf01b4mr807478qkp.57.1697560284510;
        Tue, 17 Oct 2023 09:31:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y10-20020a05620a25ca00b0077402573fb4sm783328qko.124.2023.10.17.09.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:31:23 -0700 (PDT)
Date: Tue, 17 Oct 2023 12:31:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 4/7] bulk-checkin: factor our `finalize_checkpoint()`
Message-ID: <0b855a6eb7f147a9fc4c41dd183b768162345220.1697560266.git.me@ttaylorr.com>
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

In a similar spirit as previous commits, factor out the routine to
finalize the just-written object from the bulk-checkin mechanism.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index b92d7a6f5a..f4914fb6d1 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -292,6 +292,30 @@ static void truncate_checkpoint(struct bulk_checkin_packfile *state,
 	flush_bulk_checkin_packfile(state);
 }
 
+static void finalize_checkpoint(struct bulk_checkin_packfile *state,
+				git_hash_ctx *ctx,
+				struct hashfile_checkpoint *checkpoint,
+				struct pack_idx_entry *idx,
+				struct object_id *result_oid)
+{
+	the_hash_algo->final_oid_fn(result_oid, ctx);
+	if (!idx)
+		return;
+
+	idx->crc32 = crc32_end(state->f);
+	if (already_written(state, result_oid)) {
+		hashfile_truncate(state->f, checkpoint);
+		state->offset = checkpoint->offset;
+		free(idx);
+	} else {
+		oidcpy(&idx->oid, result_oid);
+		ALLOC_GROW(state->written,
+			   state->nr_written + 1,
+			   state->alloc_written);
+		state->written[state->nr_written++] = idx;
+	}
+}
+
 static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 				struct object_id *result_oid,
 				int fd, size_t size,
@@ -324,22 +348,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
 			return error("cannot seek back");
 	}
-	the_hash_algo->final_oid_fn(result_oid, &ctx);
-	if (!idx)
-		return 0;
-
-	idx->crc32 = crc32_end(state->f);
-	if (already_written(state, result_oid)) {
-		hashfile_truncate(state->f, &checkpoint);
-		state->offset = checkpoint.offset;
-		free(idx);
-	} else {
-		oidcpy(&idx->oid, result_oid);
-		ALLOC_GROW(state->written,
-			   state->nr_written + 1,
-			   state->alloc_written);
-		state->written[state->nr_written++] = idx;
-	}
+	finalize_checkpoint(state, &ctx, &checkpoint, idx, result_oid);
 	return 0;
 }
 
-- 
2.42.0.405.gdb2a2f287e


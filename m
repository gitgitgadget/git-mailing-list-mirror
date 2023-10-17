Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9332D034
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lFaR7eA9"
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BD8100
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 09:31:22 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b2e44c7941so129312b6e.2
        for <git@vger.kernel.org>; Tue, 17 Oct 2023 09:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697560281; x=1698165081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xMMzjQAvKSKV96pfGUqgGIgRkl7QuXFF9tdiE3RB3Jc=;
        b=lFaR7eA9ihslNQVTyIx0XHrXoq/B3fIQcKjEWfgVmebzvZE/7ami5kYupTAXA63LMg
         XdOVJacBWYo4CDnyQU1Z8EHEWviW0N7JMUbjMEmG32vQxHQ/bp2kcjrgr3GSh9KgO1hv
         aRyHqWbVCXD4Nl2HbIhyLteQmpAFXpTUWery1AbVHLtPtYQODJoY8Xu/lpn4I3dAR+dg
         lGLyUnGpUW/JKz76r22+RI7619KW/W7Rc1SxJ4qBYo02ZyMN8vy93oI5fcb1k2LrE1Mh
         3SmkymiucM6RL6JzGxmIYnmePhWwpDTZRUtFqcBIcfnFuPdmdyc9yrGTH1XqSYhZMePm
         PkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697560281; x=1698165081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMMzjQAvKSKV96pfGUqgGIgRkl7QuXFF9tdiE3RB3Jc=;
        b=VNFN+l5lxPcXe9/3HtBu52eGHQHlRw+NkWf7TpGcXH6PJBCIEXUjlt1s6n8msS8x4C
         zKPj2QOQVaOrlrSKiYIp3zkavJol+/ZTrMMUqvhSsEQjIvo2lpFMLhFRlBIlKxZSlsT1
         gp/Q71pkeznND5sr3AflUBAvKNbyqsijNml8pu9d//ihGb2rAmxfX0ogprHPmRoxPYBq
         U5LQwGFxxbWsz7LUhc1IPSRIWcj+fxRmHy9v2igMSslKku5/knPj3cmDJ2ubeJnvtzys
         90YIMlKKQY9vaHsE9gVL0SN+KxJ7PHR/3kOIngyZflYQSVjL99fEV0cArU6vBEezr7jE
         611w==
X-Gm-Message-State: AOJu0YyfWvMaewX+GFfPnqxUyk7aF3qDoRTQraktZJZf3tGThoBGGXrB
	pCPS2d7je7WlyTKhzgU4QA8vPE7+pz2qovV5vkqooQ==
X-Google-Smtp-Source: AGHT+IGIMVh0e8XAKRm0QBsRPoZ1DAws+qtgtdKY0il/db4SRmV+c3sTcC1/5Dk4r7SrXul1A2qAJg==
X-Received: by 2002:a05:6808:2990:b0:3af:c259:71e6 with SMTP id ex16-20020a056808299000b003afc25971e6mr2797634oib.5.1697560281055;
        Tue, 17 Oct 2023 09:31:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id br20-20020a05620a461400b0077731466526sm784192qkb.70.2023.10.17.09.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:31:20 -0700 (PDT)
Date: Tue, 17 Oct 2023 12:31:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 3/7] bulk-checkin: factor out `truncate_checkpoint()`
Message-ID: <abe4fb0a59468c95db1003d87f8f26ba937c2e4e.1697560266.git.me@ttaylorr.com>
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
2.42.0.405.gdb2a2f287e


Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B57142BE7
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="K22lRv0W"
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D864114
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:33:20 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-66cfd3a0e61so45732066d6.1
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697653999; x=1698258799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kIreURMbpMrMGWi/Xwgb/ztnwqGVTRyDmEVBfo+FjeQ=;
        b=K22lRv0WA9KgKY8/D2IFw7TvPU2QdwigW4g9remVUI0VOFUviz3yn57RPeV9sv4BC1
         oXTzhSyjhQUj0nOg9Lrw+U8XqkIsMi+FTGgsXlxUDIjjcUsh8rQ7Wcl2kTQadIsdzcB9
         g6LHjUQ7kIDB77XLhpdKsGTU5DfQDuB7+l+bT+Vay1muDrZu5evkTXYNDXp4x/p7Ph9c
         erqYYGVHxMV3eF1LzVVXxus78Fd+ffHWArAtLv2orsqv7ARa/HF1wXqXq2B/W70Ih+o4
         GUfcAw4kcvlDCPJpo3GSkCgih8mcYsEj9T6//UfLrYEK2a8tP7k8RZlxQxQPcS8nACl3
         nHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653999; x=1698258799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIreURMbpMrMGWi/Xwgb/ztnwqGVTRyDmEVBfo+FjeQ=;
        b=wjrthF9VDJy2rlRpxY65hpMJEf0ITKEbiSZJOm15SKmJLA3O1RVW3JQf+WIB5Dm1Fb
         RmGpkNJ5YFczawICjqwlTuqX1lmxji74t+opf/m9MazK2QtND+w4Ly3WpAR0M53fMTUW
         66sD1oxumn8Tt7jdijOZBm/LYtb9aM+e8nN5OBRKGtT4R+IL+bcO5w05NypM95m4Q1bW
         YG5oiIe+qura8hW/52ZnRcUvSHS1Chv0DovBnM7YC7Alcx62zbvLrEGqrHJcZJoyPeup
         HKmIRkdRgfWyO1eBc7npmlzkqSq2hXLKRHAHhTgZ4G1akiv7Pk8sqcv1D40XfZpHQif3
         B2bQ==
X-Gm-Message-State: AOJu0YwzxiVHLxA1kQ5o/DxBCdiF6MIW6B+gfnwAr7JXzjxVdpYD3vXL
	he9sABCLSqk5Q2MDyauYB3p01twEh1ydapa4mF/b4A==
X-Google-Smtp-Source: AGHT+IGFCHFh2XZlU/5UQPuJwqcQ9vKhVRV8oGUeuyI8cWraXJsWyGnikMo2eyw65EbJ24eD10dNcw==
X-Received: by 2002:a05:6214:2aa6:b0:66d:38e3:4ff7 with SMTP id js6-20020a0562142aa600b0066d38e34ff7mr146817qvb.10.1697653999581;
        Wed, 18 Oct 2023 11:33:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t7-20020ac86a07000000b004197d6d97c4sm146621qtr.24.2023.10.18.11.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:33:19 -0700 (PDT)
Date: Wed, 18 Oct 2023 14:33:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 15/17] object.h: fix mis-aligned flag bits table
Message-ID: <a289514faabb7749e2f422ab779a8cbd62521824.1697653929.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697653929.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697653929.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Bit position 23 is one column too far to the left.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object.h b/object.h
index 114d45954d..db25714b4e 100644
--- a/object.h
+++ b/object.h
@@ -62,7 +62,7 @@ void object_array_init(struct object_array *array);
 
 /*
  * object flag allocation:
- * revision.h:               0---------10         15             23------27
+ * revision.h:               0---------10         15               23------27
  * fetch-pack.c:             01    67
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
-- 
2.42.0.415.g8942f205c8


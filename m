Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43DD42C09
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vOFoyREu"
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB7611F
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:32:32 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b2e44c7941so949328b6e.2
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697653951; x=1698258751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qHGvlxqX2by4ndqlsFmQygviptCt2EfeSZBDIB5dfdU=;
        b=vOFoyREu+jM4oWOxpa9SinOJxtgWHXpqCXSlC5KChpKb8NLLUK7XdAzPoVHAvxeziZ
         Qg122lSNjwnGBVmXr14FdYSWHBW7EcNEwSolOzuEfsj9exmLCCsQ1TtjMrkWKFAmJUrT
         zGHz/weViWXqzGc4I2eVoGie/liovbrLDSYdbb1MPC1ZEn8AkLEIIYpp5fY9r+u99fQZ
         LFmVJtjM6fBAdIKoM9V9Ib4m5/mi1ckKIyO0uwRd9HWVkxBT9uLmzFZ2wwlGzHx4id/G
         b+Rd+0i0Dad0a87FpY7gxPkfCQy+PhCvOrrD1dzJ/+lTAdJR9GhisQQPv5uuKmJPBrEx
         5MAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653951; x=1698258751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHGvlxqX2by4ndqlsFmQygviptCt2EfeSZBDIB5dfdU=;
        b=Jc/E6F15ZBe3WQiBRs8jnr6+SmF/YQE61/FcOuW9RxRZgJ/9rSVngDzr2XHnGZqYQF
         yUHFhqm9cGSAB56ngmWOOlPOoly2QAnLJ6f2OSN0OkNQSuzNoXX/R+2RzFWytfNh4pP6
         FrLVX8QNxIrevpsehpzdBu0H+LVlsX4ndz5+OEZxcTB0d8ofPu3ke0FB0wFwnTD13qeK
         naE0zHCa06oj5+kq6BJTvbz+XwpoyS2wpBqXXxLH1+SunZ2f4dkYC3y/v71RAjwhdfH5
         o2NZIrZlST9iycOupqY0nMnL9hKIz47hwH/XdoZTUEhMesHPnJ7Ba6EtVhX7j4cexKn5
         +5FQ==
X-Gm-Message-State: AOJu0YzIWZ801kUO1STPb74urbOvJ4fFoyUb9JahkA0h/hJdeCkhonFu
	p3EMzeRWoAxb/6e+sg/2RYz18uMy2BxeM8KGJp7L/g==
X-Google-Smtp-Source: AGHT+IGKpTRfLFIZ/pzAhThwr5/ToqPtf4Zo8K1820lofn6QvJ6FYlau+9aueOMX3dC0DTWfWyqP0w==
X-Received: by 2002:a05:6808:df2:b0:3b2:e5b7:7869 with SMTP id g50-20020a0568080df200b003b2e5b77869mr5544oic.17.1697653951346;
        Wed, 18 Oct 2023 11:32:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z14-20020a0cf24e000000b0066d1e71e515sm141674qvl.113.2023.10.18.11.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:32:30 -0700 (PDT)
Date: Wed, 18 Oct 2023 14:32:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 01/17] t/t4216-log-bloom.sh: harden
 `test_bloom_filters_not_used()`
Message-ID: <e0fc51c3fb345c7e9ee3a64dca94e87ba2378382.1697653929.git.me@ttaylorr.com>
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

The existing implementation of test_bloom_filters_not_used() asserts
that the Bloom filter sub-system has not been initialized at all, by
checking for the absence of any data from it from trace2.

In the following commit, it will become possible to load Bloom filters
without using them (e.g., because `commitGraph.changedPathVersion` is
incompatible with the hash version with which the commit-graph's Bloom
filters were written).

When this is the case, it's possible to initialize the Bloom filter
sub-system, while still not using any Bloom filters. When this is the
case, check that the data dump from the Bloom sub-system is all zeros,
indicating that no filters were used.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t4216-log-bloom.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index fa9d32facf..487fc3d6b9 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -81,7 +81,19 @@ test_bloom_filters_used () {
 test_bloom_filters_not_used () {
 	log_args=$1
 	setup "$log_args" &&
-	! grep -q "statistics:{\"filter_not_present\":" "$TRASH_DIRECTORY/trace.perf" &&
+
+	if grep -q "statistics:{\"filter_not_present\":" "$TRASH_DIRECTORY/trace.perf"
+	then
+		# if the Bloom filter system is initialized, ensure that no
+		# filters were used
+		data="statistics:{"
+		data="$data\"filter_not_present\":0,"
+		data="$data\"maybe\":0,"
+		data="$data\"definitely_not\":0,"
+		data="$data\"false_positive\":0}"
+
+		grep -q "$data" "$TRASH_DIRECTORY/trace.perf"
+	fi &&
 	test_cmp log_wo_bloom log_w_bloom
 }
 
-- 
2.42.0.415.g8942f205c8


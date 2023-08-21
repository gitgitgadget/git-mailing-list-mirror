Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08593EE4996
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjHUVof (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjHUVod (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:44:33 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF7912C
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:30 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d743a5fe05aso3476667276.2
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692654269; x=1693259069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/I7tI3w2DMU4MzDAcYe5XwikCSrCjmf0gM0LYCrp5V8=;
        b=IKMvLLYatrdc7KJVeSVIuOGu5nHdTjTukj0g+kJRQjXHBeTlY/iPFl/c7HUllCRxHL
         FqsE0pmgIyLgii6+EgmCwE4zaW2Rx3cIdvSfDzQWJdwcPDcxA09IyVuj7YhxWl2NVNaX
         qF7r2Fd6CiSIbXZUMoIeSvQvo4W1v+FqQrwEuSyGyar0MuidaX3PZPIWSakFtfdNv9eY
         an5f8gGBb2iQnTpgXiWrsvg1w7YnVbZXqHshRJWKvTUzOxyHhv/juJOun67f0x2nG3Hn
         8tMt6bYrSBIuYmrKNsTQfv0HEwqlTqqKYjqlca49HStbAEBckV5sG+dG6RXJB9s4bFrQ
         JXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692654269; x=1693259069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/I7tI3w2DMU4MzDAcYe5XwikCSrCjmf0gM0LYCrp5V8=;
        b=VCWEzQPirJmPhVWd14lpWgRPTPphmb3dhlXWevXLfrzKDELQjDBidVoxejQ7iCSuvt
         W1L9XsEEMDk82rIH86idPR7qDlap+shbbfI2lXSlCUfEwXAjewqHN2cabC6Qg56BQaDm
         I0LoUkKBQyULLTHQXnETatef0W1yFWP6Iux9T1LWZM3sdaSCG6HfMkCd4ZRvdP07/Fsf
         elMnY/TH/rawsZ9H/Xhvc+U6T4LPsdOLrFVD0zEy1WkxA/vlTpKAQ9dobOgPtgPVwMXB
         7JF9WYu0xqyoqnXKd6ZdDWN6WzZeTZw2vvvlDULFO0cJgEhZRDfPzLVued5vvR6tO2I5
         zlrQ==
X-Gm-Message-State: AOJu0YwYcG0srgJpHEB8L08UX4v1pPz9LU1h7ZLpec6euJH0cX2HW0XR
        61GknSYwPde3MlhGgkO1tLLtURbEsAy+KCRkA5d1iw==
X-Google-Smtp-Source: AGHT+IHhsYLo1iTetjggrLtp/MJXtn8zSo5H8KQ13Ez08VEz13VQV2JAytLx4twaJbKfJTeDO53gwQ==
X-Received: by 2002:a25:2f17:0:b0:d12:25d:fd60 with SMTP id v23-20020a252f17000000b00d12025dfd60mr7755802ybv.9.1692654269552;
        Mon, 21 Aug 2023 14:44:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v193-20020a25c5ca000000b00d43697c429esm2067413ybe.50.2023.08.21.14.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:44:29 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:44:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 10/15] t/t4216-log-bloom.sh: harden
 `test_bloom_filters_not_used()`
Message-ID: <d7c2c517de81bec237653a92033bfb45e8f9eded.1692654233.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692654233.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index 775e59d864..a77caca789 100755
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
2.42.0.4.g52b49bb434


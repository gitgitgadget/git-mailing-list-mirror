Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C60C04E69
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 16:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjHGQid (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 12:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjHGQiV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 12:38:21 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9961BFA
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 09:37:52 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-579de633419so43813407b3.3
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691426271; x=1692031071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nCfkA5W3RP6Pxf5Ly4nFtwDqk8cbxLrMziHPtlJh+o4=;
        b=WsXESjhqB82ddAdsCeDq54DCvwuV54RtCz/PyVQQGMuiA4jyB9odlSIRvVBqxahf36
         9zOb0y/OpLcTtZvNvwiZ/zZeFCbLivcA2izOE5Y0lRRX0iBpucNLBZ3jkjfEEE+n7Jbm
         WAGbJ/pSee0ANknYvptRyPr1jRl+g3ITLw7ZKvvweMgu/ZqJ1WGq1FhRSVhtFdxqVb9M
         ZuHuL55prXsVcp6eWeqNSQwiEIRuDvcasZXTpLumEHE8Pw2ED4r+K/K/ZHoQNm04MGjb
         /bECmvfjCmx8hvdHvzU7TgdfCvWN/CAXA+vVWBmU3ohnqiMwdxCQf0A6uko91HMimE3q
         LeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426271; x=1692031071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCfkA5W3RP6Pxf5Ly4nFtwDqk8cbxLrMziHPtlJh+o4=;
        b=DlrOtChzCUte5wSh7wMZIZk8Xa24FFxD+gDYaZD/2h1ASOA2E39yvHYeSl+ABmxSSF
         6X+92AAfKHF4Q9qWzl1CEhUQomnaPzhx5eyzXWQ9NDBxrgd5VISsKFqL5M87HBC/79dO
         WxyisjEUI5Tb8YTnrHnZCsd+TMEi1C0Du1gUsmva6x/B+knd7HGO0zRlWUT9UPKYBceJ
         xB35g7BqnK1JdQkwa4UxOXdtXVVXROO5g/k5n4gxWGuUlU8g/TjSyuzsOOUK1yS2snd/
         HhJRqk1AHQeOAwAgUoK7J1dyY3D6OnKIe+ZGBUt53uXEvPF+JTJ3eRCmQXAC4pSRReGf
         /9rA==
X-Gm-Message-State: AOJu0YzsObNMv2Xijcn5PV8cFMcH+Sz4NLQdOVyzhA95FAteQJA9MxT6
        K06cPGxCBZ5Bf7hkOYetYX+6MXaG9+jgCwM8bRqEFw==
X-Google-Smtp-Source: AGHT+IFsL6iburxjlLhbjweasoZjf/MUOESd0apL6fjvaRC8iC3FDwzAPL+li9d2j0nYq8WP5H9S2g==
X-Received: by 2002:a0d:cb01:0:b0:569:479f:6d7f with SMTP id n1-20020a0dcb01000000b00569479f6d7fmr7432963ywd.43.1691426271515;
        Mon, 07 Aug 2023 09:37:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t20-20020a818314000000b00577139f85dfsm2750641ywf.22.2023.08.07.09.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 09:37:51 -0700 (PDT)
Date:   Mon, 7 Aug 2023 12:37:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 3/6] t/t4216-log-bloom.sh: harden
 `test_bloom_filters_not_used()`
Message-ID: <79552bc385a6246f38b6baa1276db13c7300332c.1691426160.git.me@ttaylorr.com>
References: <cover.1691426160.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1691426160.git.me@ttaylorr.com>
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
2.41.0.407.g6d1c33951b


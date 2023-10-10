Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578E8CD8CB6
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 20:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbjJJUd3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 16:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJJUd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 16:33:27 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8E58E
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:23 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77574c5979fso388089085a.3
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696970002; x=1697574802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=itRyMwkKKeI1echHpIQE/jBk1Zn2bEmG+N8VmsMr7h4=;
        b=HcQz9Z20gjjyuTcotSrBDUDMJrYO+LDHWcwqKEwrngmuDfLl/qdMpXbOul7NIpM+K9
         9B6JkOB+GZ7cyx/DiK8rLdfkEF2wnjriFg19F3mv4uYxyrnsdcQRJtD99Sudnm8RsbKP
         DTh9OuaWq5WT6VsQwOXQr3onHY4QIic2eDK+/3ULQvec70lwxGZsDW81hkArN7vxm2N/
         y3O/rgsK0H4ALeqH+z69JH2t6BewPy7X5a3W1TSnxbq/W52YL+oCNhmKQuiHVI++MVd1
         7py5I8vLDeBQaKUH5hX4SsWT2+974ndePnlvtoHTRTf7dxXAT/DdGEuIgPzw+rWFp8fj
         ABUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970002; x=1697574802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itRyMwkKKeI1echHpIQE/jBk1Zn2bEmG+N8VmsMr7h4=;
        b=vc3THQVZUTvhC4id81RoD3463HsK7ERLjs5RYJADr5ABsjJoIUubkYWpspiWrGtVHH
         zFE2U8YRGZDK8vInxC8ruvd5psnt1VNCJ05r094UjdvANPIb9OSPpeKvourBA9uf/jnR
         LDHzDa90aiLMOCE75HjrXSicueMMw9MQSmjs8QnXRQ7tu47lMG3DrH4mVHiuuXX6Y0MC
         FT02dwIfkyxEnv9G+p2WKuowjrlRart7zSJ9FxtUH7batLbchhMRttVQyBkBiVsfo6bL
         tA4a9ePdKfAHSsZ9pu8f97wtaHzYwsGIy5K+PbcNeLwjPs5v6MwXSVpm//Ypb2ATVRXV
         MzIw==
X-Gm-Message-State: AOJu0YwFUw4qkcauv7aF9ldouC/8xtA+5NXNVROzQsUGenrqVYsibu+G
        WpvKol8tViGXPqQvqX1vFrXXXSRkHCV2dW8W1ttvqA==
X-Google-Smtp-Source: AGHT+IHug1G+d3UNSu4TKft16mY0rNpFybgBdDLLgG/CVBIt3Yeib5n/n+c320XLC/ZVojOXrf89xQ==
X-Received: by 2002:a05:620a:40d2:b0:775:93aa:ce27 with SMTP id g18-20020a05620a40d200b0077593aace27mr23201364qko.3.1696970002033;
        Tue, 10 Oct 2023 13:33:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id vr3-20020a05620a55a300b007756fe0bb17sm4615151qkn.19.2023.10.10.13.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:33:21 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:33:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 01/17] t/t4216-log-bloom.sh: harden
 `test_bloom_filters_not_used()`
Message-ID: <fe671d616c6640fc41dcea7a9738b9b640420a2c.1696969994.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696969994.git.me@ttaylorr.com>
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
2.42.0.342.g8bb3a896ee


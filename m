Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65061C43219
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 21:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiKXVs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 16:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKXVs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 16:48:26 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823CA248C1
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 13:48:25 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id v7so2169845wmn.0
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 13:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2TZTXJSOqMgjnQUCUr8GcP6aPJzC8Qg3VrE2oyL528=;
        b=IA5JAg7ku5iLLYDQ75jLy8t09FXVsmnG69dMee33Kz5KUwxGFsifPYXibys6O3Ugfg
         BaVPV7rSRYjMmWN7nqwAVxOk6Ip9sDqdqsWWO6r4bEIhq7M+fI8EwkED2iV6glCU0oLA
         dxZPqoZg/1gOjVp+t8bXQXejlHrrPQ0DVBf2pOr1qzsCegoqLlhAv1/5q3umHHEjznzt
         mftdvRO82f5bVJJmVrZ5oaeGkSmzhRvQL5YlduL3nQ/iSHqWyeONw/0gA2xdtJ9GtmIC
         HOFLI0gUM4RL6+8Az46HwApwNPAwz99raUNpA8OttwKuc84gRF1LRN3zKazZy3h6bprN
         OZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2TZTXJSOqMgjnQUCUr8GcP6aPJzC8Qg3VrE2oyL528=;
        b=jcrChm+o++zWNUPeNXfaSxwzUiAmInplWWI/v0jZLGF2tndzi82418QgFYiz3YAJVJ
         0NBlcQvXoBrV4NAIl+RK2HspJy7pUg10wY43W5XR4iAjevBXg4c2vCBbxGTRWlnjmbuG
         HTUGUW2XL4ryo2TiXWRKEhHY774MuvPS7CEzXYjKopYDWbWJ67VtmI2drAbBSArvtlhi
         B1c/JuzYqh5IT2pOpxBvk9NeFJdHXApTQVnX+wQKEsXD4mldlWYZ3N88ELRyEXuxYKRb
         TCCtMBcV6IUFvemn4FUGsVbJ50ZllkmMsyyGBZi52KDH1h50JyNY13smzMViX/Bxjw13
         k7tw==
X-Gm-Message-State: ANoB5pnDkMARMNH3RMR7r38L0t1HmZ+RtLCb3fLvc6zYU4XEWtBP9ruc
        1GBhMdigkxj0lWf8iYtELfOgAWSJmGRvNw==
X-Google-Smtp-Source: AA0mqf6ojbuZRXayFE1hB4pYdXBARucN7GX2pdxja+Os1YXITneaVc7gEG6dUH2z37Jso2bdj5Ojmw==
X-Received: by 2002:a05:600c:3108:b0:3cf:8058:43b8 with SMTP id g8-20020a05600c310800b003cf805843b8mr12850705wmo.95.1669326503696;
        Thu, 24 Nov 2022 13:48:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d660e000000b00241bee11825sm2199558wru.103.2022.11.24.13.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 13:48:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] trace2 tests: guard pthread test with "PTHREAD"
Date:   Thu, 24 Nov 2022 22:48:21 +0100
Message-Id: <patch-1.1-f7f21c94a6c-20221124T214813Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.955.ge9b241be664
In-Reply-To: <010201d9002ee2f9940nexbridge.com>
References: <010201d9002ee2f9940nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 81071626ba1 (trace2: add global counter mechanism, 2022-10-24)
these tests have been failing when git is compiled with NO_PTHREADS=Y,
which is always the case e.g. if 'uname -s' is "NONSTOP_KERNEL".

Reported-by: Randall S. Becker <randall.becker@nexbridge.ca>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0211-trace2-perf.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 0b3436e8cac..b4e91351181 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -203,7 +203,7 @@ test_expect_success 'stopwatch timer test/test1' '
 	have_timer_event "main" "timer" "test" "test1" 5 actual
 '
 
-test_expect_success 'stopwatch timer test/test2' '
+test_expect_success PTHREAD 'stopwatch timer test/test2' '
 	test_when_finished "rm trace.perf actual" &&
 	test_config_global trace2.perfBrief 1 &&
 	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
@@ -249,7 +249,7 @@ test_expect_success 'global counter test/test1' '
 	have_counter_event "main" "counter" "test" "test1" 15 actual
 '
 
-test_expect_success 'global counter test/test2' '
+test_expect_success PTHREAD 'global counter test/test2' '
 	test_when_finished "rm trace.perf actual" &&
 	test_config_global trace2.perfBrief 1 &&
 	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
-- 
2.39.0.rc0.955.ge9b241be664


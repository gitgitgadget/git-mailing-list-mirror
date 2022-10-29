Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8762FA3743
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 03:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJ2DCZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 23:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJ2DCV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 23:02:21 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083F1219A
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 20:01:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sc25so17070240ejc.12
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 20:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kwx0yF4Nj9mf19/g/Y2NaXuIhylqEnk2CpPa2nDp/6U=;
        b=YIwYC0M38c9WsqoHk08TBfRdCIp2E8s68Y5Zb9ba78TUDlMsH/hc/gnpEAXI2Gj1S5
         GRe6OfCxnmvaJ1Rfr1B+/r83epYBpHhCL9PZn+kQFctJLlSUA+LpdC3Phtdicf5UBtNI
         DJMDJN8DRjTpI4pYYi8saz4COIyWKPdA1De5rTBOixuwH4PrIRFrThluYRNXFnSVpVV0
         sZ7RlKYt4IzIvFDJpoDeHYlVYGv6onXhBBUOzZDWVbC2L8DtpOJJZy1NqvjnL5YwKVGM
         TW+BnJ2OPBua+qW/H389zxgbedegxXXHjGrPkdlDksM+xecUqEzSrRiCv1cV2Plrb2ly
         55Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kwx0yF4Nj9mf19/g/Y2NaXuIhylqEnk2CpPa2nDp/6U=;
        b=q5pOnWSndadQfbQFripWIeRvJFjTzenZD+Y6ZULAJP3AjrOh1ltcGAW7Y8IlvgUOGa
         2t8jQ+jZQE2hVZmuwZoqd2/ql7LMdhUtULqWL5Pfm/o/FJkvcMwSku3JYzDkuBCyFKoJ
         oJTLO1hUL63IrKxgD0JhnGdKJJC9zG1jzqG2ggLywu+wRVsqZsaJcAJNBy32V+1T/hyF
         CbY8sx9EV1z0DcIBKWe1Z5gj7aMx3ESbR8xOGrVjgVmXl3zq4bSvERcbuKBpVMVZ6L5/
         TVEJTfMbqZR/aXDX/faoRBWzCJcvpQzS24dNv60nnOeaa7rjAvgkxLEjIQTHa6Kph0UT
         z+1Q==
X-Gm-Message-State: ACrzQf3SR3h9tMWuJp5zjFr3/s36TH0xNnnSBi7JXrWpKNdI7M/cCr2I
        k8nPgnxRLwPZ2Rw3e07v3Y3wxYCc6Oovgw==
X-Google-Smtp-Source: AMsMyM4omUYWJLTtLFKrG/uQHJd4PwdlUOIivoT5FZ3dEVgVBfn240/lMVPgEBRZuV/ABq6joM7K2g==
X-Received: by 2002:a17:907:3da5:b0:78e:793:4084 with SMTP id he37-20020a1709073da500b0078e07934084mr2174475ejc.285.1667012476240;
        Fri, 28 Oct 2022 20:01:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id dy14-20020a05640231ee00b00461621cae1fsm195393edb.16.2022.10.28.20.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:01:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] submodule tests: reset "trace.out" between "grep" invocations
Date:   Sat, 29 Oct 2022 04:59:46 +0200
Message-Id: <patch-2.3-708375e3104-20221029T025520Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-0.3-00000000000-20221029T025520Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20221029T025520Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix test patterns added in 62104ba14af (submodules: allow parallel
fetching, add tests and documentation, 2015-12-15) and
a028a1930c6 (fetching submodules: respect `submodule.fetchJobs` config
option, 2016-02-29).

In the former case we were leaving a trace.out file at the top-level
for any subsequent tests (there are none, currently). Let's clean the
file up instead.

In the latter case we were testing that a given configuration would
result in "N tasks" in the log, but we were grepping through the log
for all previous such tests, when we really meant to clear the logs
between the "grep" invocations.

In practice this resulted in no logic error, as e.g. "--fetch 7" would
not print out a "9 tasks" line, but let's be paranoid and stop
implicitly assuming that that's the case.

This change was originally left out of 51243f9f0f6 (run-command API:
don't fall back on online_cpus(), 2022-10-12), which added the
">trace.out" seen at the end of the context.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5526-fetch-submodules.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 75da8acf8f4..b9546ef8e5e 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -178,6 +178,7 @@ test_expect_success "submodule.recurse option triggers recursive fetch" '
 '
 
 test_expect_success "fetch --recurse-submodules -j2 has the same output behaviour" '
+	test_when_finished "rm -f trace.out" &&
 	add_submodule_commits &&
 	(
 		cd downstream &&
@@ -705,15 +706,22 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
 
 test_expect_success 'fetching submodules respects parallel settings' '
 	git config fetch.recurseSubmodules true &&
+	test_when_finished "rm -f downstream/trace.out" &&
 	(
 		cd downstream &&
 		GIT_TRACE=$(pwd)/trace.out git fetch &&
 		grep "1 tasks" trace.out &&
+		>trace.out &&
+
 		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 7 &&
 		grep "7 tasks" trace.out &&
+		>trace.out &&
+
 		git config submodule.fetchJobs 8 &&
 		GIT_TRACE=$(pwd)/trace.out git fetch &&
 		grep "8 tasks" trace.out &&
+		>trace.out &&
+
 		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 9 &&
 		grep "9 tasks" trace.out &&
 		>trace.out &&
-- 
2.38.0.1280.g8136eb6fab2


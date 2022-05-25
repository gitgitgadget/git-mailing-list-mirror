Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D95EC433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 11:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240594AbiEYL1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 07:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242067AbiEYL0f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 07:26:35 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6465B9CF50
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:32 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id y24so4543745wmq.5
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GVS5Tl2mP6W6/AAgHQTM9g2yxlA5NxN9Li1XJjgb5p8=;
        b=Wd8i3KeFp7xecqvPrMjXj6IY5smG1L/Jn8quKdD6lt5a5l99gIPxJCJbAmnJF+AtK5
         efNxMESWdBHEzpJ7avIN0KuBqoT0K1Ez7ZKLGIxS9iHvZME2rBgKkRXfXnPUQPksfNlP
         Gjn9hBKfu0Zt/7sOYPpwo/LMKcDIgCT+InWXTqxyxYqmirARYzWgEAM8oRQ+71ZZWoCk
         0pX5zs/kCL7DcIstWkAVcX17GfvlJjJIymr+mInWUtg+O3lmwkUBSnF77PTShSIu/g5J
         hA2iIQURcYf/VSwmARv4C3p94ZOC1jX5g4jNo0hCKiqJ8Q1tEAGBrSX/VHdfeyJ7HTm/
         CEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GVS5Tl2mP6W6/AAgHQTM9g2yxlA5NxN9Li1XJjgb5p8=;
        b=XPFYNkucUUG02TOUzHVfrWmy4f+qYav9+P/MZDM86odgkBnd2k2h9R+cRuD7NM9B2x
         PYQz+vBLm/iFkTvcP4Sk2KwLvOwvD8DPnSkMOoyHIQlMzJq17qAIyAzyA+C4eoYjEE+l
         1c6hiDLoG+qQ9SeHwtQaTt4I2QZPC5Xhh1hNiJW9wVsRO/WLt40rdIEYElJqNcwQIp5J
         zFx37Iol+zPFvz7n4HRB3uorVDbxnO24G4HcgUkwlxfKKdkoaNw8XO5BKNnrC4WmCBHP
         r9wiUCphnM/E0MMTOTn+jjT2kRtrWf05iV+oYyykNyEJju1xsAWaNejGx4/iiIPs4Qx4
         +DWg==
X-Gm-Message-State: AOAM532pux+5p9CtojZspPt1k+fSOv9zlD+6jYulgpl+oTvoFa5hVpea
        LqpCeqhRR3CazQD6Kec6gRxAr0/PK5f1/Q==
X-Google-Smtp-Source: ABdhPJw+XPxFnVzXYHUlPvWvP80q+AGvexQK0y0f9QthaMjDnErCNPnmsf4snIOCi570hf17BSJG2A==
X-Received: by 2002:a05:600c:600a:b0:397:4d8f:2655 with SMTP id az10-20020a05600c600a00b003974d8f2655mr7934344wmb.92.1653477990739;
        Wed, 25 May 2022 04:26:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z13-20020adfd0cd000000b0020d0dfcd10asm1851095wrh.65.2022.05.25.04.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:26:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 11/14] ci(github): mention where the full logs can be found
Date:   Wed, 25 May 2022 13:26:00 +0200
Message-Id: <patch-v6-11.14-68eed85162b-20220525T100743Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
References: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com> <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The full logs are contained in the `failed-tests-*.zip` artifacts that
are attached to the failed CI run. Since this is not immediately
obvious to the well-disposed reader, let's mention it explicitly.

Suggested-by: Victoria Dye <vdye@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/print-test-failures.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index f45e36bdefc..72fae2b0cc4 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -65,6 +65,7 @@ do
 		if test -n "$do_markup"
 		then
 			printf "\\e[33m\\e[1m=== Failed test: ${TEST_NAME} ===\\e[m\\n"
+			echo "The full logs are in the artifacts attached to this run."
 			cat "t/test-results/$TEST_MARKUP"
 		else
 			echo "------------------------------------------------------------------------"
-- 
2.36.1.1045.gf356b5617dd


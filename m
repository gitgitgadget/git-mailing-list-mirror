Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB748C433FE
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbiCINTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiCINTW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:19:22 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008F2179242
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:17:56 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so1476618wmf.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EI00vwRJmB1TVGS+VBFnKShGvbrK1AWYXtS78OSTvy8=;
        b=QxfKamsumbhmW1ugOcoPQhXRnsS4TVX5Pa8jEENFOuWiYiUlQ2hIWfhn5TQ/I9Lekm
         wP0c5/eytz0IEhW69x7aE5TCDaBnLYQRU0fzQicbL5SubBnpO/sX8HtkD4RLf7wSESiL
         3tmXXbkBW7RogI+sWRXNVEGstFono8OvYhRwLH0ozwg1cZBweDTb6ZQbTLPVq5J4QiRi
         s5YAiogTODCP0QQsLHPIg9ezpQB8LVylhFvtbjv1BH3J5pb0DV524PlaQ0IrZ4Lrl1w8
         E/PkvtZvMyryQbOpy3RDeH6JpCtOQzHwWkn3a24LWyTk1Xo8+9e24iJpRb0QUxDXEI+d
         YeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EI00vwRJmB1TVGS+VBFnKShGvbrK1AWYXtS78OSTvy8=;
        b=I+cHiYh28tx2CNCyFBRNWzOmT03sjhLZ8GmK3Q3zpunDnox+K+5ialKkVyjKPHLMtZ
         vmxBkeTtOH+FMoRKNSmzEVPIeV5EuUWYqEiIfSu+cFQEnEouCiPe70iw52SELTx65wbY
         gpYb4oscheToGJY4XRa4jYeew+ChHF/AW+Jtn3mOXr5Wh5HX6ccSXjUefdp4XBNRkPkt
         vKjGTh96baUnIxINi9kYPy5lBTBiFB1ppsRNTJPDnKfOIzQI6ioUFD71IZVp2EvWS9RE
         Fvk3FZ/yDVUmtFadCKPmHVUpu8KCCcuXLfrSkIKTl10+OHPYSgMZ49nRP5kWhiku9g8D
         Ro9A==
X-Gm-Message-State: AOAM532f8JrfXe7Q4X8wS7Z8pHHd1rJZZ7VKl/YEz2mGdBxFK0UZvgGA
        dN5ZWwayxVGimTNXNWqkfJN1xETZ4gFiKg==
X-Google-Smtp-Source: ABdhPJyVwKy+mLJcRCBaEg2rUED32aHt+a0q9Ip2U4DbH7psBGsufBYHaQ/9h/bw3DOLjgnMKALR6A==
X-Received: by 2002:a7b:c114:0:b0:381:f7ee:e263 with SMTP id w20-20020a7bc114000000b00381f7eee263mr7599476wmi.30.1646831875266;
        Wed, 09 Mar 2022 05:17:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:17:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/24] revisions API users: use release_revisions() in wt-status.c edge case
Date:   Wed,  9 Mar 2022 14:16:43 +0100
Message-Id: <patch-13.24-d18bfa5691f-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use release_revisions() for the "struct rev_info" in
has_unstaged_changes() which didn't require the addition of a "goto"
pattern, but needed us to refactor another "return fn(...)" pattern.

This change is split from preceding changes to make similar
conversions in those commits easier to review, as they are all
repetitions of the same pattern.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 wt-status.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index a68731ea0f7..89289e52603 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2537,7 +2537,9 @@ int has_unstaged_changes(struct repository *r, int ignore_submodules)
 	rev_info.diffopt.flags.quick = 1;
 	diff_setup_done(&rev_info.diffopt);
 	result = run_diff_files(&rev_info, 0);
-	return diff_result_code(&rev_info.diffopt, result);
+	result = diff_result_code(&rev_info.diffopt, result);
+	release_revisions(&rev_info);
+	return result;
 }
 
 /**
-- 
2.35.1.1295.g6b025d3e231


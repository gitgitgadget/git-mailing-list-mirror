Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798BFC63798
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA2A613AF
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhGVMOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 08:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbhGVMOk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 08:14:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B633C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:55:15 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k4so5842877wrc.8
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9xDLHXB2f/ASz+P6hhlWGWR2Hrfb6NKMRbR/o789aS8=;
        b=GoPXrWTKoSRLC9tBZtA9XBqr9X+oCO8W4y+WivZ9Y3oUlpF5cwRUfrPLzbQQ3EwbjK
         V4642srXsIym+tviB+E/LKVHJy3xx0uc7L2qwH1YvPVg12pKXreW0FthkvaMhtI8ReCo
         M4ihb1pQGDqb9AAmPSA1qzz31Y4qh/gg70dcC2HLsFktltLST7AQSBBZHcBh6suYRKcT
         cP3gXYUuZtWx2OPO7Fc2YZkRxp8cyutFNSSCgsZuyuMDeiCkBdjxGEBMsRTMtOuU2BAb
         mme7m3NFQ2whL9D56bv2JSSS6z7OUwBFnpW8beoMr0LRtAA/eixdgiSivOJetjNJ4V75
         FDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9xDLHXB2f/ASz+P6hhlWGWR2Hrfb6NKMRbR/o789aS8=;
        b=iflOTi8r/6zSV7hwAHvNsp4Uz/nw5IkpGjfdF14l1cg74sS1TVJ8e0VSeOzMAULiSF
         vaRcJy4AoL9XAGwZTPz/Y7Ha14xTRU8X7ttN78e6h1zvDIxWA3jn7vw9PbDX6dFWW7WM
         ULlzFv92LL/Q4aslQMMTwjUHStaSM94jEa5JKuigAYsP+z0aqybv34fZLThPt43ULD0w
         Rr8E+tRMPCmNuVAcQK7Tv8BlaiSlYGIP0QHVO+B+O+mWsMiZJmxv2cfck8mt1q5CxlMY
         gVEWGNA2SLYWLCWh+Idi2uXXWYFV+saCcy/jHULgk+mUiinVNvZwfeYFtaTRJVMSayXJ
         CasA==
X-Gm-Message-State: AOAM532X0DoBRFCQvv6vOX8i1kAaEY2WDmoLmXfBbsPst+O/lVM9J5zG
        UYyutXPYE4xk9zqOJj50SsC3WK0ku68AoQ==
X-Google-Smtp-Source: ABdhPJwMyxx+B/f9fAbnqRfTTlv5MNHEc2iWV9rG4JoRSu0Eb/VCS0VCVR36/LU5Y8jck1GyX18+6w==
X-Received: by 2002:a5d:634c:: with SMTP id b12mr47641367wrw.238.1626958513650;
        Thu, 22 Jul 2021 05:55:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g3sm29937483wru.95.2021.07.22.05.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:55:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/8] progress.c: stop eagerly fflush(stderr) when not a terminal
Date:   Thu, 22 Jul 2021 14:55:03 +0200
Message-Id: <patch-5.8-dea3df8ba6-20210722T125012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.957.gd9e39d72fe6
In-Reply-To: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com> <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's the clear intention of the combination of 137a0d0ef56 (Flush
progress message buffer in display()., 2007-11-19) and
85cb8906f0e (progress: no progress in background, 2015-04-13) to call
fflush(stderr) when we have a stderr in the foreground, but we ended
up always calling fflush(stderr) seemingly by omission. Let's not.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/progress.c b/progress.c
index 7fcc513717..1fade5808d 100644
--- a/progress.c
+++ b/progress.c
@@ -91,7 +91,8 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	}
 
 	if (show_update) {
-		if (is_foreground_fd(fileno(stderr)) || done) {
+		int stderr_is_foreground_fd = is_foreground_fd(fileno(stderr));
+		if (stderr_is_foreground_fd || done) {
 			const char *eol = done ? done : "\r";
 			size_t clear_len = counters_sb->len < last_count_len ?
 					last_count_len - counters_sb->len + 1 :
@@ -115,7 +116,8 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 				fprintf(stderr, "%s: %s%*s", progress->title,
 					counters_sb->buf, (int) clear_len, eol);
 			}
-			fflush(stderr);
+			if (stderr_is_foreground_fd)
+				fflush(stderr);
 		}
 		progress_update = 0;
 	}
-- 
2.32.0.957.gd9e39d72fe6


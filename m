Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFAAC433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 13:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiKDN0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiKDNZx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 09:25:53 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510382F3AC
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:25:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i21so7554555edj.10
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 06:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7w7gzaaZ3CrVbdB+BTzfRFNRbX4dE8SOAaAWOA3cbF0=;
        b=e2XYLiL0g9+LhKXviwDGGkZy5U8ZNegcBRsom6+1hW8gwaHub/jSxIzLgfA0v/ouOK
         pAE5AjbF1DNNE7HTiS4TSpju9+C1KG4yALHiXzIqZubWswEOgvfs++KwN6sUsMQ2gD7o
         NTVHd4fFs0KwyTlgDy4UADvnQNz5J8qWNRhHSbYCPMmdWhk6V7QAmFb2MBwnih9lp8ph
         d4eHsDZJKVldLcSYqiGPFO7TEjG2qfJ+XCh6XaQWgzkiFT9Mbot2wBUu6iXzELX8e9pq
         mFxIJhUVSxcKbc8l9iQAkoOWllPOobs/0AyKfp5wWbsXqoir8mNTui7N8MukUwE7NpFI
         Hnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7w7gzaaZ3CrVbdB+BTzfRFNRbX4dE8SOAaAWOA3cbF0=;
        b=ahQDCbu3aqPJSqHQxl//Kl6fTlvadgQfTmCaMsinZfBHER1jkiPNtx1ez0h5hwgXrN
         TWZZa9Ko904UaaIgXqWy/lBxHFp1Cp41gAALIrzeHnx7aDc2bHG433q5Pw8ETbnavKhX
         7rnFVE4OXeB7V3dh5xRcN1/RT2VLDqpd50uTyNcN8A6W+adSY/A82kz5NprK+nT0UCJ0
         tzGwnuNSW5Fst/1Lt3JYRzoXKt/HeqY9L0D8znznV12Umnj11mJIuYS/5Y1L9tyhZdpX
         wRrCyyj+oH6DS6VOpklRxWa8hcE+NB7wNywXiZZSsE5uZDGEEs+MGt/kbV8kvBsnUcVg
         c0Zg==
X-Gm-Message-State: ACrzQf22KeJ96GmteN171xzKOVrXtHeivCOUyNETWiNMS2CX67kVry7G
        CxxEORxA0e8MqBsbmZ137Y8bvUFpIOf/fg==
X-Google-Smtp-Source: AMsMyM75u5uKltqCwYtfxuDv6qVPH4doLGx/GlIIl3VmsSeyqqnqIqYVEtaOpyW7GdpsMOJZnB4dvg==
X-Received: by 2002:aa7:c14b:0:b0:461:c47d:48cf with SMTP id r11-20020aa7c14b000000b00461c47d48cfmr34794816edp.83.1667568302432;
        Fri, 04 Nov 2022 06:25:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906318600b007ae38d837c5sm652979ejy.174.2022.11.04.06.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:25:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/13] bisect--helper: remove dead --bisect-{next-check,autostart} code
Date:   Fri,  4 Nov 2022 14:22:47 +0100
Message-Id: <patch-10.13-c82d0bc39f1-20221104T132117Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1452.g710f45c7951
In-Reply-To: <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com> <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 911aba14205 (bisect--helper: retire `--bisect-next-check` subcommand,
2021-09-13), we removed the usage string and the implementation, but not
actually the option.

Since b0f6494f70f (bisect--helper: retire `--bisect-autostart`
subcommand, 2020-10-15), the `--bisect-autostart` option is no more. But
we kept the `enum` value of the command mode around. Let's drop it, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bisect--helper.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 32e427fa878..e13c60d54b2 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1318,10 +1318,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
 		BISECT_START,
-		BISECT_AUTOSTART,
 		BISECT_NEXT,
 		BISECT_STATE,
 		BISECT_LOG,
@@ -1334,8 +1332,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
-			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
 		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
 			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_CMDMODE(0, "bisect-start", &cmdmode,
-- 
2.38.0.1452.g710f45c7951


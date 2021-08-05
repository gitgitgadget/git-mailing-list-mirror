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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB2CC4320A
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C9FD610A8
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbhHEB0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 21:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237114AbhHEB0C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 21:26:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16907C061798
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 18:25:48 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m19so2292321wms.0
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 18:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7iwnWJVq41Y5ZqvqzclYw4hWW3WdnOcN0ZbvBOxaEK0=;
        b=IOKGjid/2GdHtPN7w5MnLQYvAWkUBAhFHnWEs0P2TY5S+aCbehJAeDLCpsgCLsLN9z
         TVjK1V1/ULOBjMByFyms3RRHXF5bDX/Ij0wj6eCRChSHxmbW7QfBYCsgSU/WO9CCGJSI
         JYyDp7vFClrKpW70JXtel6qob6HDmhcTHU1iRfgpO/sW0gYy/x5rtLZWS+GBDmIXsjbe
         T8yK0Nqg45gXF3ScDkNjlL61VSTMVSNR7+7OpuJb5VJsDBAYOaAQ3AUTIS3AYCEMPXRz
         +QZn5zSohWv+rtZNEORmzE5oBtsEOcQtaNBiaTdLMwr/sXp9ZLCvpXXks6e5Z6+uXPu2
         m6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7iwnWJVq41Y5ZqvqzclYw4hWW3WdnOcN0ZbvBOxaEK0=;
        b=F163aDM5ZSJ7MQ529EpHmpetNeZZMO5gfqcIuFPrprX+lzIfa8bxCjahlwZIcCNKGw
         v6uZKnPBoRyvPMK3J+e+SbGTbUIRZHg4Hcw3CkRoDLt9TjcY0SLBOg0L1BYWrs8VSDYa
         H+ZVj/iyffkdqNmWhzXRzp1OaFusulOkr5EL25tdGqx+sHYe4OupYl7g4aEr8V5wLUXU
         goaSih8QP+sIqsH9v/5kgvEPoOQMK4/CDdRMUdirNMeVSd9RRLcAA/3myYSFiOkKP1ue
         kpuqTrp5NQLMeXkrCtNrc3LLOpVbv8ZJlMcYhloSHCdggeZZ8Rt0inyedbDG/FzI2EyN
         GIIA==
X-Gm-Message-State: AOAM532hjoyItXWnoD2TAV+MSRwC8ATHJL6dPBzIQQzzU/fLMZb2l+w/
        OUXu96TWsjLPpE9WJ4Ak98RfnoxPQHz42Q==
X-Google-Smtp-Source: ABdhPJwGPjlFpn+ZpBlUou7eWcoN8vW7njCbJWVN7tJn5mXJjR7xm8IE0ywe+Qjwi4Wj315Wgcr7+w==
X-Received: by 2002:a7b:c390:: with SMTP id s16mr2227780wmj.148.1628126746467;
        Wed, 04 Aug 2021 18:25:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6sm4120176wru.50.2021.08.04.18.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 18:25:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 01/10] serve: mark has_capability() as static
Date:   Thu,  5 Aug 2021 03:25:34 +0200
Message-Id: <patch-v4-01.10-13bb1a06078-20210805T011823Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.597.gc569a812f0a
In-Reply-To: <cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com> <cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The has_capability() function introduced in ed10cb952d3 (serve:
introduce git-serve, 2018-03-15) has never been used anywhere except
serve.c, so let's mark it as static.

It was later changed from "extern" in 554544276a6 (*.[ch]: remove
extern from function declarations using spatch, 2019-04-29), but we
could have simply marked it as "static" instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 serve.c | 4 ++--
 serve.h | 4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/serve.c b/serve.c
index f11c0e07c45..7bf5f23ea6a 100644
--- a/serve.c
+++ b/serve.c
@@ -156,8 +156,8 @@ static int is_command(const char *key, struct protocol_capability **command)
 	return 0;
 }
 
-int has_capability(const struct strvec *keys, const char *capability,
-		   const char **value)
+static int has_capability(const struct strvec *keys, const char *capability,
+			  const char **value)
 {
 	int i;
 	for (i = 0; i < keys->nr; i++) {
diff --git a/serve.h b/serve.h
index fc2683e24d3..56da77a87af 100644
--- a/serve.h
+++ b/serve.h
@@ -1,10 +1,6 @@
 #ifndef SERVE_H
 #define SERVE_H
 
-struct strvec;
-int has_capability(const struct strvec *keys, const char *capability,
-		   const char **value);
-
 struct serve_options {
 	unsigned advertise_capabilities;
 	unsigned stateless_rpc;
-- 
2.33.0.rc0.597.gc569a812f0a


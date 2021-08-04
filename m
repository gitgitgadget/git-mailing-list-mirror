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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEDAC4320A
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF07610A8
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbhHDWzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 18:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbhHDWy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 18:54:59 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A2EC061798
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 15:54:45 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d8so3967986wrm.4
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 15:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y8XeVhwXbtxEG8JTEL0Qfc1270wRE+86bC+Z7M6/dHE=;
        b=FbAofwF7RIXU4QR2oiWgsNZepd/RV+/ndfGCDkT05zubLaz8RU8+v/MIXw4fxR4B4J
         ffjXF6m1KRlAW2ufCq+kYxEKkBThwgHZ5+6t0MmRMmJ4xu2n4H3/Lg55I1kWpyJRJ4GX
         xXgyqK/3/QlMbNE+bLSqLoB4vcQB+B0e23E6AQEJNRJq6vVnhGbw5G0LDIvmNa/nw2Qg
         z5+zg0XynXCLBukd4lDZS3RwnbFjmT+1kMXk8/YSldKzyFCpJf8m8vPdv8ITbukaFXBg
         wHqQUTEqOHBzqJDiHPks/uoYvUNXUjgz6jsiyldyFsmPDu92XSAggqsAt4aIUo4rPNs7
         Sm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y8XeVhwXbtxEG8JTEL0Qfc1270wRE+86bC+Z7M6/dHE=;
        b=oyC1E7+WtK2yMJDqwJL81xWwSYfDgIXz558SRkYDNv4/7/pCxhmcB7kqKS5972Uw06
         Y/47AOccK/xlVsCKwlMgH0tcJI572/g00fdvoW+ZQULEz/2kuOFBfD4aS2H91MkKAltp
         xZXQPFL367PRk2cZGMYloh5LLCush9CDdR/MMZjX6IWh/VQO1G2iaew4L63GHB8Utskv
         9pvuEuzo1Yh2ASPmeNSm1hLpT7qqu3H7tJCxcqyHX90d8k3oZXePEqxI+gHn9QOEzqBi
         gUqT4HmPwMBR1YVGDSOZLgkgm7MXrgfzI8wwEQCaRRtIvizsG9supKvU42lythNSOgqR
         fAEQ==
X-Gm-Message-State: AOAM5309Mts5hhakHqGQlWA0rkXNsBNstTaA6K2i9j4PLOMWh3d/Z3cX
        5wWpbQXMFdBFltWZRFYBWP+YJMTQBEI=
X-Google-Smtp-Source: ABdhPJwpw29r8+mbjjQltSRqvIh41FuZqlw+AeMNOMil+7PyzvrCwWc/ApZy48uVnV9k4452kmWt2Q==
X-Received: by 2002:adf:eccc:: with SMTP id s12mr1530587wro.331.1628117684068;
        Wed, 04 Aug 2021 15:54:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u11sm3968190wrt.89.2021.08.04.15.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 15:54:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/5] Makefile: move ".PHONY: cscope" near its target
Date:   Thu,  5 Aug 2021 00:54:36 +0200
Message-Id: <patch-v4-1.5-2ee725e2fba-20210804T225222Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.597.gc569a812f0a
In-Reply-To: <cover-v4-0.5-00000000000-20210804T225222Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20210804T225222Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the ".PHONY: cscope" rule to live alongside the "cscope" target
itself, not to be all the way near the bottom where we define the
"FORCE" rule.

That line was last modified in 2f76919517e (MinGW: avoid collisions
between "tags" and "TAGS", 2010-09-28).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9573190f1d7..671dde5c7a1 100644
--- a/Makefile
+++ b/Makefile
@@ -2756,6 +2756,7 @@ tags: FORCE
 	$(FIND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
 	mv tags+ tags
 
+.PHONY: cscope
 cscope:
 	$(RM) cscope*
 	$(FIND_SOURCE_FILES) | xargs cscope -b
@@ -3267,7 +3268,7 @@ endif
 
 .PHONY: all install profile-clean cocciclean clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-.PHONY: FORCE cscope
+.PHONY: FORCE
 
 ### Check documentation
 #
-- 
2.33.0.rc0.597.gc569a812f0a


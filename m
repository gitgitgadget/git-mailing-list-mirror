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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02572C433EB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB7E4619B5
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhC2QU6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 12:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhC2QUb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 12:20:31 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1665C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:20:30 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y124-20020a1c32820000b029010c93864955so8802026wmy.5
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ho8wLC3cTN194muTh8T7qzyEsxtRUAUtlG2/u/gbeM=;
        b=cSfkM0WGwnG38ilYkbzw4smITGuYZO89rmWC969lmmP4upywAIMj7nVRqYnXRiheOF
         5mTMnApzRZaDIitaKRymLidlKHMTYu9orZXxxz9Ud3/5E69en1qaZhNIyP5hcd62LQGs
         Fi1uG0q/P2THHwgzJjCPe9kLBLFkmdKQtNcunHLeahl1NoRO1eyf4jNLjtzSjYczzMe2
         D1qEcq+QUQyg952AkT5TN9Zs4DD8JpMAnhgwcQ5dDb4RSI/S9KmnJ87uUFxpv1wKEQqK
         Hhd1f9EIGNvxRVXfzlq5NEPovitbinVCVcPvm1KBvXBZDXOw7UhoHtifa8JaHKB/EdoB
         MBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ho8wLC3cTN194muTh8T7qzyEsxtRUAUtlG2/u/gbeM=;
        b=t7KUCrOhDpvlA+F2Sk1+FeVoR5XdOpcs4IGiQbEVIzE5WMW8qoNTjjn3a645HGstMr
         3t3o2bXZxg9X6ymFt4ekPR8B8glnbsLc4rA4/XVgdvhJBVtrfGh4NmgIyqN+Mv3SjyDY
         vewfKyumC8eL+Bj1G5xDyKllmesQ966CTvGTRtX/ftNT27Tj6s5/X/2D4m7S/XeThMxN
         CljLl4yBVtBJt/bcYd+r1IggQTd92VIUI8p1Lw2vicIkxakvCz46PoFTMHIqidI8NiWU
         CZvk3XwgPOrYg/tmSrHJwFoy2/nAbfjkGW2Tc0Ol3l2tsN2C2Talv0q03NbJXmG5OjXx
         yNtg==
X-Gm-Message-State: AOAM530EZA4LDKKq19qeeEiyCv0fH9t6DsY5yhG+MundvUuoBZUvqobr
        b3lp/tmEeZFLJ69zxathBvtz7IajHkyxKA==
X-Google-Smtp-Source: ABdhPJxWsSlniZXplbBQSVLPkJam8TiqDL+cnc0SlhRLmqQBCVuOVwC+PP22AGE3yUtEmvfKIAPu4g==
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr24820669wmj.67.1617034829490;
        Mon, 29 Mar 2021 09:20:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v18sm31835353wrf.41.2021.03.29.09.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:20:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/5] Makefile: don't "rm configure" before generating it
Date:   Mon, 29 Mar 2021 18:20:12 +0200
Message-Id: <patch-5.6-b04c4d29c53-20210329T161723Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.461.gd47399f6574
In-Reply-To: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
References: <20210307132001.7485-1-avarab@gmail.com> <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a "rm configure" before we make a new "configure" file via a
"configure+" temporary file. This was partially made redundant via the
new ".DELETE_ON_ERROR" target.

"Partially" because if we die partway we'll remove the "configure"
now, but as before we'll leave the "configure.ac+" in place. Ideally
we'd have another target for the "configure.ac+" so this would all
work properly, but due to the logic added in 122650457a6 (build: do
not automatically reconfigure unless configure.ac changed, 2013-01-02)
that's non-trivial to untangle.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 573bce20357..ce76c476a3c 100644
--- a/Makefile
+++ b/Makefile
@@ -2358,8 +2358,7 @@ $(SCRIPT_PYTHON_GEN): % : unimplemented.sh
 	mv $@+ $@
 endif # NO_PYTHON
 
-CONFIGURE_RECIPE = $(RM) configure configure.ac+ && \
-		   sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+CONFIGURE_RECIPE = sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 			configure.ac >configure.ac+ && \
 		   autoconf -o configure configure.ac+ && \
 		   $(RM) configure.ac+
-- 
2.31.1.461.gd47399f6574


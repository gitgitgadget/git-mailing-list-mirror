Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D22C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbiJZO5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbiJZO5O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:57:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF971187A8
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:57:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bk15so26776761wrb.13
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIhtgsEWUaF6zJLygOibmnb0xGyPAEO6/J5sSA/TuKg=;
        b=Yk2Pgi4BnG+1wdXDsOtTbi2PwY8uGYncWDflyIavh9AUo+K1pVskSSs8XsGgZ1Vf5f
         VJa2Dje9TFqA263LJa0Rdt+eEfW5MhwObkaB2aLKkOuTP7nNphwozvRHqxsksSWLAf3B
         uaUCfgdCaR9eGrO9ClDcnsG7pc0jB3E6L6iO6q2zlfmHIitcGZUVOasQ/SyDOOaS361m
         j41WrHdyo7VtSs2V3A5PWxbzey0jCcnLKDZco+lUJnxTCOsO3Fccsh3IUJoeGhaPih9P
         vZmx3A69xLosmV99uiClAeH87K7PhO2OPK3cQUS96VK5NzslVsFTwKSE+awusEgEsLGI
         4Emg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIhtgsEWUaF6zJLygOibmnb0xGyPAEO6/J5sSA/TuKg=;
        b=wUiyHfEeEshRIHBZ1FTrQ3T+OlIQIJPqQUW6u8KUlK4HNxZtjJEhkbdHu+UwHOwhwn
         zpLI4y1RKztjxhzT8spmY+ZvXpi/lKBGTm2Urje21sNN08QoSa69b+U87QsG5hChS7V3
         hfgpE/u+7FZrVvJPBSK0UewEdnwKvXIu6JgphMRyaefMOd5hwQ1AlYeAC/xz9q2YMT/n
         AmbEwYuds+tFGwkEHJgwzokeaee2d0+5c2FZ9Nau7QeMkkKcQ3SoY6A5Njv3qmCrHnTP
         m3kPNVqDsNJw97b1y8LuO3/bXMhIG31BdvGpVZGShQ2xGuZ3H0gTG2PDqDBGhijh5Lg2
         T88g==
X-Gm-Message-State: ACrzQf2hCgo442ECgNPFldWIWrAFnYc/kOgGabU/REEW5CTGqvwcER4k
        cHI7+TnO4QatSTvd+jY4poqHSRwwnEzNQg==
X-Google-Smtp-Source: AMsMyM4Qt+RfXSLm9ZSchkhKWH8rWgJAeq1cQevLmh12yBPjTvpQ/jW5UYCG2YYiMnHivuGfdMU9Kg==
X-Received: by 2002:a05:6000:60d:b0:236:660f:fd78 with SMTP id bn13-20020a056000060d00b00236660ffd78mr14171201wrb.388.1666796220135;
        Wed, 26 Oct 2022 07:57:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i25-20020a1c5419000000b003c7084d072csm2180351wmb.28.2022.10.26.07.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:56:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 8/9] Makefile: document default SHA-1 backend on OSX
Date:   Wed, 26 Oct 2022 16:56:46 +0200
Message-Id: <patch-v4-8.9-0af3ea78eaf-20221026T145255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since [1] the default SHA-1 backend on OSX has been
APPLE_COMMON_CRYPTO. Per [2] we'll skip using it on anything older
than Mac OS X 10.4 "Tiger"[3].

When "DC_SHA1" was made the default in [4] this interaction between it
and APPLE_COMMON_CRYPTO seems to have been missed in. Ever since
DC_SHA1 was "made the default" we've still used Apple's CommonCrypto
instead of sha1collisiondetection on modern versions of Darwin and
OSX.

1. 61067954ce1 (cache.h: eliminate SHA-1 deprecation warnings on Mac
   OS X, 2013-05-19)
2. 9c7a0beee09 (config.mak.uname: set NO_APPLE_COMMON_CRYPTO on older
   systems, 2014-08-15)
3. We could probably drop "NO_APPLE_COMMON_CRYPTO", as nobody's likely
   to care about such on old version of OSX anymore. But let's leave that
   for now.
4. e6b07da2780 (Makefile: make DC_SHA1 the default, 2017-03-17)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 9f7cf1f22d4..a0ca6456b85 100644
--- a/Makefile
+++ b/Makefile
@@ -518,6 +518,11 @@ include shared.mak
 # Define BLK_SHA1 to make use of optimized C SHA-1 routines bundled
 # with git (in the block-sha1/ directory).
 #
+# Define NO_APPLE_COMMON_CRYPTO on OSX to opt-out of using the
+# "APPLE_COMMON_CRYPTO" backend for SHA-1, which is currently the
+# default on that OS. On macOS 01.4 (Tiger) or older,
+# NO_APPLE_COMMON_CRYPTO is defined by default.
+#
 # === SHA-256 backend ===
 #
 # ==== Default SHA-256 backend ====
-- 
2.38.0.1251.g3eefdfb5e7a


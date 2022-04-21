Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE9DC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 12:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386257AbiDUM4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 08:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385925AbiDUM4s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 08:56:48 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DC332EE4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 05:53:59 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r187-20020a1c44c4000000b0038ccb70e239so5816474wma.3
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 05:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7NZllSdp7PJAfjWm2t10CFWgF6YZa54cQ/jKKiRAy0=;
        b=K/9uEQhytkiDvOO5G3/LQ2fjhHXFNBtKq2vOBGY9zlYeW0Oze5HLznxLEfnJHPed+P
         r4mcNsJVgr/BNbbPV3U3K+vYZqJYLc7K0JvYjNkjgcNe3j4U4Cj971i2BdMGpsJ5rLBk
         2TtggjuVV3AIq/fNEaLoZlU9e+eKnORCOAAzYqXghfb0Bvh5LBOtri1lBYWFqQMGYwV9
         1z9LcsmnSdecDPu3qdTR/QnpsJVMy6CNOogmo3cf/YXug8cFthW5acU/B3boDkcdAZMo
         3XZEQuXZ+31hDqDzAu3YX/F+MuzxxACj9bnT9FqC/wzmn9GlEwiMcDSqTC29xhf68Sfo
         Jo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7NZllSdp7PJAfjWm2t10CFWgF6YZa54cQ/jKKiRAy0=;
        b=b1VFtkzBkSl5t++aqCOaVWvnEBsy+RCFLYxQeqeMBMPegm4g6A2/4LvhwzN8YeqWO1
         8Ui60NeUpCaNLoVAYpQ2g5wyp7V7RqezdHiSxugAw/N5Xdlw8mjM5gqFwGA89raf88AI
         IjslZ7I9WRvgZPQmem7Bv/br6b/+YvaOexyElm+mck+ameJlLVOMtf9qCgg4Iv/fhuJx
         Fg2s46WErHsZ6lrYZQZ6LnRu2kwELlRfg+Jeu6ZK0haFVtmFIexokPMV9kaka5sz9Y7U
         +r2P7ujXEY5frp62RZtY7OD+LQ8w6rYndJHNV5lXJFzrMulnVNbIQnZ+Z9KuYnWR7knV
         BdfA==
X-Gm-Message-State: AOAM5301Lr77MkumvNVdJtu8oSnehQp85/NYT2ofI4BJPRaLZeZwA5bt
        i0tiMkODw17gRy6sseruHJRlIW6p0F2IaQ==
X-Google-Smtp-Source: ABdhPJyvHvHLFSoGg3VX70B4sORtEfGvqAbciEVG/8Rz0IyHR9IycJK6wYfdHUDBi6DxBDi3O3YoLA==
X-Received: by 2002:a05:600c:3d88:b0:391:7aa1:792b with SMTP id bi8-20020a05600c3d8800b003917aa1792bmr8631055wmb.8.1650545637703;
        Thu, 21 Apr 2022 05:53:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n68-20020a1c2747000000b0038e6b4d5395sm2163685wmn.16.2022.04.21.05.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 05:53:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] CI: run "brew install perforce" without past workarounds
Date:   Thu, 21 Apr 2022 14:53:51 +0200
Message-Id: <patch-1.2-dcedf03c2d7-20220421T124225Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.876.g4bfefc07680
In-Reply-To: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the alternating between --no-quarantine, --cask and fallback
"git pull" updating of the "perforce" package.

As can be seen in [1], [2] and [3] these were workarounds for various
past CI issues. Running "brew install perforce" works now in GitHub
CI, so there's no need to alternate between package names, and the
"git pull" method was a workaround for some staleness issue on the
Azure pipelines removed in [4].

We do have a really common issue with this failing, but that's
unrelated to any of those past fixes, and removing these old
workarounds makes dealing with that a lot easier.

1. 0eb3671ed96 (ci(osx): use new location of the `perforce` cask, 2019-10-23)
2. 5ed9fc3fc86 (ci: prevent `perforce` from being quarantined, 2020-02-27)
3. 3831132ace6 (ci/install-depends: attempt to fix "brew cask" stuff, 2021-01-14)
4. 6081d3898fe (ci: retire the Azure Pipelines definition, 2020-04-11)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/install-dependencies.sh | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index dbcebad2fb2..82fa87f97af 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -37,13 +37,7 @@ macos-latest)
 	test -z "$BREW_INSTALL_PACKAGES" ||
 	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
-	brew install --cask --no-quarantine perforce || {
-		# Update the definitions and try again
-		cask_repo="$(brew --repository)"/Library/Taps/homebrew/homebrew-cask &&
-		git -C "$cask_repo" pull --no-stat --ff-only &&
-		brew install --cask --no-quarantine perforce
-	} ||
-	brew install homebrew/cask/perforce
+	brew install perforce
 
 	if test -n "$CC_PACKAGE"
 	then
-- 
2.36.0.893.g80a51c675f6


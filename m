Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC4DECAAA1
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbiIEI1O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237049AbiIEI1A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:27:00 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D800EBD
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:26:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso7337550wmh.5
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=G7m050VEyZM9+Q9rjnzXkTgk+lDP8OXN3JrEFrYs/FM=;
        b=T1gl0nyBO+7uayhb1MlFL1egrdqh4RryLcCHPnhmGpIVJkdIRq74WXuNT4VKoBsTqJ
         Efp0mx/demGPa1vFKleN8T5uLE9A6QjDihtKYbN5g9wY6HR45Yib6U+kz3VKArCCwudn
         6yYluGA5fyskobwJFwIsKU5jD6gNDk1sGIFFIpx1vUmPWuY2ehhJtJu7/rpeKgWdI27c
         5bQkgIj0u6kiv7j/ZW48l0CxvaK94wEIwT54HpPakBksqTQORNArUiGClmUmoEVp4/yr
         lh0BrpFt4Ia6cLLAHN2omU2AuIMJ4pEkUnEBeQb9gQZA2+CNPHV7bBYu5L5IreAE6Iwd
         W2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=G7m050VEyZM9+Q9rjnzXkTgk+lDP8OXN3JrEFrYs/FM=;
        b=AFIyldm6r3FL2Y57JRcY65aAVpPPqLIRBMFOH0hJgHkT6GVjueTiVrxg2hKi5aFI0d
         krCyUfC58hySop5aRlH0Hj2b9GcTtRoAwNdnKm/Aj3BjBkXyHbMxuopUBVoKonXkuWkS
         /zx1K4txJ8MbNl1s3NLuMYEChOM2GaEG7RsfmF9IY+CNDFbaty+ZCyE3IEn5r9fav7m+
         gRBuPo7S6oa7yrckKeJQVB8bjSNDEbbvFY8YUNgm++dRU2SG+Jvrz9iAvwjWEeg1CukF
         nE0g6GIYAiX3NT8M5u7ArXPbUq9RNtGAOd0PXTArKiI6sik796PB76ivyWHvmvLnE9+L
         //VQ==
X-Gm-Message-State: ACgBeo1yZU63+U1ZHphozLmCzP5Xdo0p1GSXHjYjVcywA1ssRBe5VCPN
        36t/RVjTHr+U3djw05ZfylWfYN0FQ+ejhg==
X-Google-Smtp-Source: AA6agR5R4S/keTZXM/egyKpb+IO87Jen2mdYR3LiRIgZrDO0qaDsqIbWdDjllD/xg2r2h5Mk3VCZZg==
X-Received: by 2002:a05:600c:4e94:b0:3a5:b7e5:9e64 with SMTP id f20-20020a05600c4e9400b003a5b7e59e64mr10055372wmq.26.1662366417337;
        Mon, 05 Sep 2022 01:26:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:26:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/34] doc SYNOPSIS: consistently use ' for commands
Date:   Mon,  5 Sep 2022 10:26:17 +0200
Message-Id: <patch-06.34-0b946d60fcc-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of our commands use ''-quotation only for the name of the command
itself, and not its (optional) arguments. Let's do the same for these.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-fast-export.txt     | 2 +-
 Documentation/git-sparse-checkout.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 1978dbdc6ad..4643ddbe68f 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -9,7 +9,7 @@ git-fast-export - Git data exporter
 SYNOPSIS
 --------
 [verse]
-'git fast-export [<options>]' | 'git fast-import'
+'git fast-export' [<options>] | 'git fast-import'
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 3776705bf53..872436d7426 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -9,7 +9,7 @@ git-sparse-checkout - Reduce your working tree to a subset of tracked files
 SYNOPSIS
 --------
 [verse]
-'git sparse-checkout <subcommand> [<options>]'
+'git sparse-checkout' <subcommand> [<options>]
 
 
 DESCRIPTION
-- 
2.37.3.1425.g73df845bcb2


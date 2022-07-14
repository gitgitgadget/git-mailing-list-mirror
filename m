Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CA5C43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 19:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbiGNTk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 15:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240678AbiGNTkR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 15:40:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7278B4E604
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:40:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h17so3976043wrx.0
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mu5304LIRy4EjJa/BSabxbQ9vfo8KhdGjNbQqovpLRA=;
        b=Wq93WQfC1rtQhYqZ3OzQ10FDZocmCmEu4kK6o2KwDQ2YanVcgSd4vS6s5Q1qvzJPv6
         97ApdPtZvewJZUK5TOQkES2t6MPLj4vea8nAS7zkMcBecSdhxIyv0Rsc4Zv7ohk6Tm5d
         2QhzB3C6M+8SYitykd/zEpEVDqClOi1k2ZWxGXJuyZ0mtvSOu8hhorkWPO8OkkqWrbqj
         aVVDo9or6HS1yjyJwlm15o0QjrvlDVl4lz4I8Pcb6XoLFFSlivTZ7jFXdTOHgd1TewYs
         93WP94cAhkTDOVQhnYrzqsx/aoTR/CZAAa1lHoz5BSEFY2+TLg8ICLgDnLVGLpzcELiZ
         CGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mu5304LIRy4EjJa/BSabxbQ9vfo8KhdGjNbQqovpLRA=;
        b=EcUV0YpbtEN0aQ3c4MnEGGl3aJITgSPafg0gRfH325ry9fTqvSOxM5FqtAzpLX1r71
         hKcMoEWkr5QkHH9Tv1LzxBXb5q3/rOCAt6BYwBA8tqVx67AFGE6DOcGBTjytgbPIu5y5
         BV14/ozt2nqDbCeRWR+jf80/gN3aV9u9YOEsNj98NB5PAcA8hs/I/k6BucEp3yr5tAcs
         Lh90fL9G+iDwpTfV5qakOdHSuYX/Y0BMBOSKKRiCsWlhqQBh4Q7cth9Uh7XKS92fI1W8
         fxZsuszECi13gmYUIGHkgV5oS85OPXxw74z8r6KyLmhQP1iQmlcucfL+2mIOaDndw2e4
         OzQA==
X-Gm-Message-State: AJIora/Kr1bo9+zL0A7kxmogl68gB2DwiuZ8oG+M65bsACpYnBiY/xaS
        3M5EcDR2PvyDQq5DXhm0NPDYt1MsFxnzGg==
X-Google-Smtp-Source: AGRyM1vh/57Eo9ClLcYvR8/OfcEUEcs9Uhu8aqvPanj63nJdXNuZZTNs3JaUsEYfiYeocp+ffvDPRg==
X-Received: by 2002:adf:f64f:0:b0:21d:76c6:d98 with SMTP id x15-20020adff64f000000b0021d76c60d98mr9561219wrp.299.1657827601743;
        Thu, 14 Jul 2022 12:40:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600018c900b0021dac657337sm2145145wrq.75.2022.07.14.12.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 12:40:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/10] CI: don't have "git grep" invoke a pager in tree content check
Date:   Thu, 14 Jul 2022 21:39:45 +0200
Message-Id: <patch-08.10-8bcaeb1dd79-20220714T193808Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.996.g651fc6e809f
In-Reply-To: <cover-00.10-00000000000-20220714T193808Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220714T193808Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the omission of not adding "-P" (a.k.a. "--no-pager") to the "git"
invocation that spaws "git grep", added in 0e7696c64db (ci: disallow
directional formatting, 2021-11-04).

This didn't matter for the GitHub CI, but does when running the check
locally. A subsequent commit will start invoking it via a new check
from the top-level Makefile, and without this we'd visibly spawn a
pager when doing so.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/check-directional-formatting.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/check-directional-formatting.bash b/ci/check-directional-formatting.bash
index e6211b141aa..de8e6e486f0 100755
--- a/ci/check-directional-formatting.bash
+++ b/ci/check-directional-formatting.bash
@@ -23,5 +23,5 @@
 # U+2066..U+2069: LRI, RLI, FSI and PDI
 regex='(\u202a|\u202b|\u202c|\u202d|\u202e|\u2066|\u2067|\u2068|\u2069)'
 
-! LC_CTYPE=C git grep -El "$(LC_CTYPE=C.UTF-8 printf "$regex")" \
+! LC_CTYPE=C git -P grep -El "$(LC_CTYPE=C.UTF-8 printf "$regex")" \
 	-- ':(exclude,attr:binary)' ':(exclude)*.po'
-- 
2.37.1.996.g651fc6e809f


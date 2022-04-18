Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A55C433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346335AbiDRQdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346286AbiDRQc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488B130F58
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:39 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m15-20020a7bca4f000000b0038fdc1394b1so8544928wml.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TOSCkOQpZ77IOOC7gReIX1NmfoB3OafjccUDctIJ7mY=;
        b=j7f49CUsxgHQg7cGGaOYtDKv2d+LqPSZNv7v1HsWQgD5zf1D6ON6yC5Df8TjoOfZt+
         ijEvIM7tkvmbi/qL4ITt8QoMGOYQIfocMH6puLlnkwyOLa9EdoKOSV1911DCg8TYTyOG
         NL5IGjjKhKoVDJkzGcPGP6FEirUKsj2mo9LZeZ/Qu1NUp96hoRk94k6Ww4h0GRi5DdXF
         V9zHlp+h53Efmc2YP6EnbSNeS002N8ifi9/N8ESk43eBF0e6Nb8yE+ri47tlx82xdZ8A
         VSE+aiq6z2PK9m7MEUvyWLc80eWMsiZ1YwYskroMpuUIkYGp80pee2H+Xeh3/eTLJK9T
         c9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TOSCkOQpZ77IOOC7gReIX1NmfoB3OafjccUDctIJ7mY=;
        b=CfsW5qoODEGESZrIcPvHWQNKLvEwp7uBSVw0fIAFQcMbSH+FbHQyuItgMS54CJnbTG
         3XaU/hXtWmNNwgHPAJ99/XVwjdB/z+iW0hqleN6e41oUHilz6mEUpy+0Cvauktm0wUEE
         zYJnwKQzOmlQnNKKYWCWnmAZF5ZsCOuSur399QHV2Srff7nVkqT1IbdMWKqZ/xhUdTfQ
         aEysv6B2JPO9fBR86Dg2HgkKEkafdmLAhmHuY9tBzH65Or3pmiyJBrGtiDGvceTCOmkV
         KCyfz9KLj4984Ubq+ByWyDGcKi/a7r3k3quD6+MVveNi+Fn0COXivEbNJmsJhQ+dGwIa
         dTdg==
X-Gm-Message-State: AOAM532lAYnOyNCc7MrZC1XYtO+PTPRuqDxdXk9+UWLMwxL08aewhKzd
        LOSwVjOekeZQoE6k+Q5XeMRSi+uPEwaCqQ==
X-Google-Smtp-Source: ABdhPJwmrAtRDqM6syAo8fAYABLXnMeCqNeEdTv/+U/S2gN8boXNUVdnnpoIef8wlqI1u2dfSv6Qow==
X-Received: by 2002:a05:600c:3843:b0:392:9dd4:fbc6 with SMTP id s3-20020a05600c384300b003929dd4fbc6mr2499286wmr.31.1650299378258;
        Mon, 18 Apr 2022 09:29:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 27/31] CI: set SANITIZE=leak in MAKEFLAGS directly
Date:   Mon, 18 Apr 2022 18:29:04 +0200
Message-Id: <patch-v4-27.31-514de8d16b0-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As in the preceding commit's change to do likewise for CC, let's not
set SANITIZE in the environment. When I added the "linux-leaks" job in
in 956d2e4639b (tests: add a test mode for SANITIZE=leak, run it in
CI, 2021-09-23) I missed that I could do that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 977ee6293ef..ac96b7a1c61 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -197,7 +197,7 @@ linux-musl)
 	;;
 linux-leaks)
 	CC=gcc
-	setenv --build SANITIZE leak
+	MAKEFLAGS="$MAKEFLAGS SANITIZE=leak"
 	setenv --test GIT_TEST_PASSING_SANITIZE_LEAK true
 	;;
 esac
-- 
2.36.0.rc2.898.gdf6bbac50ff


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2CEC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391444AbiDUS2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391370AbiDUS1S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:27:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F614B878
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:24:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id q20so3715033wmq.1
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mJ/p4NFke3CntaRD5Ptns/VbtFyum0knDUI2LOiVivM=;
        b=Ty28r8ohRSiOEvG5AYmubGXhWDt6WEEtKfkHRqchKo4GpBRleuRjkXWZ8yAtMil1yG
         M33qz6uPTFcr/D2QX80FUmww6A2supLKwuuUagwmtv10GuwxbZk8AHXpsI/VGupinozA
         tAHzmDwaF4TnMPPXv4zENDAxPG5h12mYy+cOwbbNDLxCH1hwULgy9l2JGnSfs0UeKm0s
         54T8R4hvC6asg4lfAspbzzZAd0Fi9TYDV9QD0EM+qqmV8o9mzSnz7agj6/Lt5iWHtbmj
         VOVP6wtemrkubfXB1CWz67h5X9U8xI9rvifg/2WWz5djIVGexojXGAmW2pPgOLdNqrog
         SWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mJ/p4NFke3CntaRD5Ptns/VbtFyum0knDUI2LOiVivM=;
        b=EhrAaYZ3QOZlu1BE2uCX6WowH9oj081XOgisX99XW9XXpl/Trr0fiMCM671cnJC2rJ
         c1EQY1p/IgNnCThsV22STC7y5fmzJxHCNWkIShtrWN79SALAVmY8M/kvpHnUnlc8pl/P
         Ws1ndXAmGGrJNPZ6D5HxS89RVnC5qgiq4YFge/mNav663E3CFdQnTHlaZWlejBSPXDLL
         Baa2MqB33H10NeKBGF5sZTntTIo0652kBdn27VN1HAYEByAgQSGsbNUqHJUF4evr17il
         2GQ4Kp0GNdoT/pmMLCFHiPgYggNkr68O+rOvIrQr0yvFnAmFtCE5pJ74FBdsVAElN0Xm
         ardw==
X-Gm-Message-State: AOAM533m+1F01eyhgY34YYOWs6HPqDSuUK7ocwqN6548pkLOD1o0c1ND
        OyiaqrL75a8ww5CLx0m7fvBR86QP3x/ewA==
X-Google-Smtp-Source: ABdhPJydDXpwGNtcYIYsFbLYMiWU5Sv09BkiDyDJ63WTdcizEZwJSMKkL4vl7hJNVop8CR/821jOtw==
X-Received: by 2002:a1c:3587:0:b0:381:50ff:cbd with SMTP id c129-20020a1c3587000000b0038150ff0cbdmr9933131wma.140.1650565440186;
        Thu, 21 Apr 2022 11:24:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:23:59 -0700 (PDT)
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
Subject: [PATCH v5 26/29] CI: set SANITIZE=leak in MAKEFLAGS directly
Date:   Thu, 21 Apr 2022 20:23:21 +0200
Message-Id: <patch-v5-26.29-07a6c087297-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
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
index 8d19ca5ced8..b6e7a6647bb 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -225,7 +225,7 @@ linux-musl)
 	;;
 linux-leaks)
 	CC=gcc
-	setenv --build SANITIZE leak
+	MAKEFLAGS="$MAKEFLAGS SANITIZE=leak"
 	setenv --test GIT_TEST_PASSING_SANITIZE_LEAK true
 	;;
 esac
-- 
2.36.0.879.g3659959fcca


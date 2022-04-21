Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC474C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391430AbiDUSjh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391417AbiDUSjc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:39:32 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551B23915C
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:36:42 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p189so3724041wmp.3
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vYWESYHne+pdVldbGBz6F4rStUl2M3wv76bqGMzu4zQ=;
        b=oWFxBrSBVAja0iGDT2TWUb+u0RKg/21/Pdo1PA3etG6lUSYAzqSBH4bBA/Bk6+a+zv
         TQcfhMCfZcE4DruUuytgoKHxbSiSfaMBbl78ksNhqf+NddhUl7Uez9RjaZ5P/ySB61PV
         APaQQ1MT7HrzzixaAT0t+ei36no2LS15jBHYWNfzrMWiAB4TViw/AM+7REhYck/osWl3
         ARKYmByM+lHnE5BnBQkvNltMoPPgbOW3VINVTqGYJZ2FCpmhffZIewZ5aG4hC1KqxkA4
         zzAwHcz+To4wjBM7+RvuSYkL+4gQc5PXzW1lTB14uQyZqyUbUpHwm6xRaUJYBUGcTCq+
         KaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vYWESYHne+pdVldbGBz6F4rStUl2M3wv76bqGMzu4zQ=;
        b=XNHGjULjx/VggxGa5QXVqZxjLP7i640iuwkPX2rwDZapNd83W0Ta+tqCmONgLu8iw0
         pDZTBcKGlOCap2pPl0VivyhiGxcdKYYuRckG8Iin4NIa9txrqqBRblWsEaeyLYmcMZ2e
         Wjf2wTqRpTvuZ8Pg0rkOf4vquLl46IDq7YnODtgTfsJBCQd+KxjTDUX7eDOwy2/AqN6a
         ahi87+3ECrKfK37erHopjSuPf6lTq4OMmdziFIqrIS0aPQNGZmNSzKp5SgJfHTufyDlq
         si5YhFFX46rxuvr4jj4T6RrCCJjqoU+Qt1TX/hB9DZ+dYyEVlayT9Bt4y/dlNALg4Ipu
         xayw==
X-Gm-Message-State: AOAM530NBzUAYuILtYFdlBd5XaUERHB9O5p/FFe12aXVjZZZYcKZajXx
        FjN6jVv7af6ANC7jW+QRdSMm195Ux2lWBg==
X-Google-Smtp-Source: ABdhPJwdCSyRRyDxGicZ8m6tY2Qi66604W1RUpeMENvEFNEf2bu8zI09Su1oyPWq0NJVQ6GZFDmyRg==
X-Received: by 2002:a05:600c:354c:b0:38f:20d9:4f12 with SMTP id i12-20020a05600c354c00b0038f20d94f12mr661430wmq.24.1650566200700;
        Thu, 21 Apr 2022 11:36:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o40-20020a05600c512800b0038ebf2858cbsm3108624wms.16.2022.04.21.11.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:36:40 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v5 03/10] CI: don't include "test-results/" in ci/print-test-failures.sh output
Date:   Thu, 21 Apr 2022 20:36:27 +0200
Message-Id: <RFC-patch-v5-03.10-577a5be34f4-20220421T183001Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com>
References: <RFC-cover-v4-0.6-00000000000-20220413T195514Z-avarab@gmail.com> <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the ci/print-test-failures.sh output introduced in
657343a602e (travis-ci: move Travis CI code into dedicated scripts,
2017-09-10) to stop including "test-results/" in the heading, it was
more of an artifact of how the iteration was being done in that
initial version than anything else.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/print-test-failures.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index d00cd0e4944..23324021f13 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -41,7 +41,7 @@ do
 		TEST_MARKUP="${TEST_NAME}.markup"
 
 		echo "------------------------------------------------------------------------"
-		echo "$(tput setaf 1)test-results/${TEST_OUT}...$(tput sgr0)"
+		echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
 		echo "------------------------------------------------------------------------"
 		cat "t/test-results/${TEST_OUT}"
 
-- 
2.36.0.879.g3659959fcca


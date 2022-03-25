Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E45EC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiCYTas (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiCYTaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:30:16 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CC81F42DD
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:05:18 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so4937941wmb.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B9HeUVF68zOaKWCRUUgRw0K9njfK1kDlGM+JtUzluHc=;
        b=jjfPNjDgJXUsD4zzLXkhC+pSJdOB2h1xQ+EaO4A1mYCqzYSjaaTzR68OoGWFZv6kTw
         Ccdb7Mt35s4y6R7j8UfgcWqngiOeqt4sFMARbNwkGz+YzilR9P0T3J/n/bl345sosKz4
         6U340Ll7zkA8l7PIg3BZgexuDaujcyiPok/+eBIM8DHPkx8glZQHHKuuPN7K3KwQOOeT
         y2bWSX/76gsV2WLWZOUALEI4RjgvWQ0OAU28cQvKk7EUuRE59ApImfzYhsXR7AYlvBIc
         YlukUQngkyNmmFLRl3v6+40SHaEgYITNdZnqNk8ekX2H8I+0yIr3x7iXkgLQaPq12TsX
         tp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B9HeUVF68zOaKWCRUUgRw0K9njfK1kDlGM+JtUzluHc=;
        b=tGPUvVyHfwGQ4OPlqboTjIobfOhsyLaDdwFz8n935MqmCJpJ5QEzes+dACgcx3oHp5
         XeUHSxmJrwSDacizkSRnlzBjGiATXN2S4om9yJFybtVDu/A0jviJhtGekgr4OeFEXLQj
         Z6o9grCe2L+xSuoXmrpuJuJkcJ/7R43U7d4FP8b0b2Uc+9uXtcFpl0h6eUBrbWJbw0zw
         RBia3X2tJp4Nh1tac8QaQdnvxFd7emFhIu7zzhTyQvgLbMK3yGnRfq1HUlq65Ww7Rf3w
         9tP8YQEu+N1ICUrt9mdkII498S/05B8z1aXCsOqPYIQlwGFDvkp/tmNmtOWLHoJENVPi
         RV8g==
X-Gm-Message-State: AOAM533r6eMhlVB0QMcUJ0xZaE1qjtAa+Sc3aKwrz2n0Xwj7XdJz1y6F
        YROBvWxTcES4HZCkZwXAEU/Ws16oSrPdXg==
X-Google-Smtp-Source: ABdhPJwymHytlYFF9EbNLC5xWX55o6UGaSSLPQ5bKbSCM8b+EMtAhy1CO3orXB29fq/kSFaT2O/HGQ==
X-Received: by 2002:a1c:7219:0:b0:38c:a4f8:484f with SMTP id n25-20020a1c7219000000b0038ca4f8484fmr20550767wmc.99.1648233506348;
        Fri, 25 Mar 2022 11:38:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:25 -0700 (PDT)
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
Subject: [PATCH v2 08/25] CI: have "static-analysis" run "check-builtins", not "documentation"
Date:   Fri, 25 Mar 2022 19:37:59 +0100
Message-Id: <patch-v2-08.25-81e06f13d84-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the "make check-builtins" check from the "documentation" job to
the "static-analysis" job.

The "check-builtins" target added in c74390e4a1d (cherry is built-in,
do not ship git-cherry.sh, 2006-11-05) is unrelated to the
documentation, so it's odd that b98712b9aa9 (travis-ci: build
documentation, 2016-05-04) added it to the "documentation" job.

Let's just move it to the "ci-static-analysis" target, and while we're
at it improve the output with $(QUIET_CHECK).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                 | 3 ++-
 ci/test-documentation.sh | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d30862a23a2..82f4206188a 100644
--- a/Makefile
+++ b/Makefile
@@ -3378,7 +3378,7 @@ check-docs::
 ### Make sure built-ins do not have dups and listed in git.c
 #
 check-builtins::
-	./check-builtins.sh
+	$(QUIET_CHECK)./check-builtins.sh
 
 ### Test suite coverage testing
 #
@@ -3468,5 +3468,6 @@ ci-check-directional-formatting:
 
 .PHONY: ci-static-analysis
 ci-static-analysis: ci-check-directional-formatting
+ci-static-analysis: check-builtins
 ci-static-analysis: check-coccicheck
 ci-static-analysis: hdr-check
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index 9e0652c30dd..41e2b126311 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -14,7 +14,6 @@ filter_log () {
 	    "$1"
 }
 
-make check-builtins
 make check-docs
 
 # Build docs with AsciiDoc
-- 
2.35.1.1517.g20a06c426a7


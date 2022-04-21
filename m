Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F04EC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391336AbiDUS07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391289AbiDUS0i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:26:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F814B43E
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r187-20020a1c44c4000000b0038ccb70e239so6418340wma.3
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yDi1cqrfLPkuxHUYiccz2SbD/EgDesc5OV8tTagblpY=;
        b=lnVewjLSsFC4bL5xm8XptUmpFguVSabtrgJpnGax/UJyKj8lsvOI+LczfpiaIshw+B
         Ybzb0S0QYc7gtfrahN2upDWBFAZd8xwYbK/stp3R4UtBw4WmlNAo3tVwaf0/FF6xUWHW
         tett/kE+MTXfJVFZtO6ffyGnpOqSDuEDPPGQrEvC22Z5sRbOrtPYXy8/Bz8Y/O2b1NtI
         y8jSq/HPvSKP6lAl5kryKUt3Xzv2QJuYBtQ1Re8pnNUlyTpzO2TsNoxo+Xq8iDKoQpaG
         GVSaD12eASeGaK/nOxwj6t/w4mLnw8razlkvLWhSmYNR98kcXxQgGNaJ58xSMZgdkDdx
         HZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yDi1cqrfLPkuxHUYiccz2SbD/EgDesc5OV8tTagblpY=;
        b=iEg0wf1/TVJPkF7/pGZszQns3PPTZP41Ch/p+P18Zj+SGbVaYwaYTgegHfJKS6iLkr
         H0s74mwLm7t6AOpPpCi3jkkMUx5VXXt81LgVOS6awlw2RoKHf95DZCmptGjd5+85tLzB
         D8dhwBBytK34XWl2iqicK/46PAXLMkCuWJHu4D9qdVcHwkW9s9ytvbxpn8rL69j2Z+Ph
         SWPo16CbOGysWMnahNPdWyO+bQCiHgtSgLBz9V8Rpdsr13WwGnbLKSyca3ncDbfQoa9I
         6MyF49UtwYB7nsRi0O9F5PnUz9dctRUFMUis8NJ4bMsI8uZAS8vfpzQD+L7a2STLPIwq
         WoRw==
X-Gm-Message-State: AOAM532r11Q50JagMnWSkFNx+aeSjmdWlhzOhgvGZZwMNJu8UZY/8u85
        wZ+aXeWGZUhpbMrthbOebLrcrOqniwv28Q==
X-Google-Smtp-Source: ABdhPJxYRGK2MDZykmfEBWIr0eUpUhuUJuVjM7XV6RBl7qslfFQx80Kr2m92MQq2R+VESaVHb95gfw==
X-Received: by 2002:a7b:c119:0:b0:38e:d23c:1743 with SMTP id w25-20020a7bc119000000b0038ed23c1743mr613326wmi.28.1650565423412;
        Thu, 21 Apr 2022 11:23:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:23:42 -0700 (PDT)
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
Subject: [PATCH v5 09/29] CI: have "static-analysis" run "check-builtins", not "documentation"
Date:   Thu, 21 Apr 2022 20:23:04 +0200
Message-Id: <patch-v5-09.29-78c0c81af43-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
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
index 8717ea7e745..2e1ae6c6067 100644
--- a/Makefile
+++ b/Makefile
@@ -3402,7 +3402,7 @@ check-docs::
 ### Make sure built-ins do not have dups and listed in git.c
 #
 check-builtins::
-	./check-builtins.sh
+	$(QUIET_CHECK)./check-builtins.sh
 
 ### Test suite coverage testing
 #
@@ -3492,5 +3492,6 @@ ci-check-directional-formatting:
 
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
2.36.0.879.g3659959fcca


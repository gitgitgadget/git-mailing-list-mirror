Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CE2C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiKAWhH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiKAWgl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:36:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4711B789
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:36:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id k2so40811194ejr.2
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cv7Ha4jPIZFzajFvVVbIPnGzkWE2fHrj1dJoi+RdFQo=;
        b=T5d1NofFa4GM5S7ssKcSDE1uIOeaoV28Vg6svrJtgcWKEGGnQKV6YZWsFhU4C5m9v/
         ds+sXMdV1oNi+JMmjxTMWelC+CkDk5faBG1mv6vRp4QeMPzFAUzBfuQbwRX13WA/+Hu0
         nkYdeyPfpZQfb0V0US3ZT7r4pRi04wAbtVhN9Z3e2cfTH4dycobvjdnSMxFfqHLDrzlU
         jkjeA2trFGGgfTNIrkIJfy/rrU3qLKOTezW0wtEKJIy+KTdzUvcBF12UXmfseytUY7C7
         ie6vSPwMeV8RAQDtrWUfbVpRIhe1NXLZvd9pqfM00oI80DIbFTqsTgw23tKaoUs+Baik
         OX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cv7Ha4jPIZFzajFvVVbIPnGzkWE2fHrj1dJoi+RdFQo=;
        b=3fOc1hx8ToGpTMGTwEr7KASXv1xvaPXPM1WrC8crqSl7XhzD/lthT4jkM5MvUnalmS
         CZG4GuzPdbQ7rrR18WcsK8KiiuTF5946uYFM2EmvuleCnZ7CShF0uzH2X4geEYodPU6R
         Kmt6vbpzWeVB697VjykM6A0tqwpCtXYVon8r7auKN58uDSSe7wJdvFS6Y6P7VejsWgXY
         j3Chy3J9LtxtyXnix63Dqb0BvxKryhwSjy7wmfaK5c9+XjlSsII8tCrwfZfgmDEt+fhX
         fS/8JFiuGFmZLSxA98nXOCp9TKCfxLCAxVwuVtg488TQtrDj9MMKbJqWPnG9AJ7lYa3Q
         vYzw==
X-Gm-Message-State: ACrzQf25Rb4bvapnQvM5Eo6XpP5LQ13Nw2FP9Zs7SDwt8F3pdDpiT8mv
        Y2xrUXlwfGIIzbfLonFY/ypaTGaLBk42zQ==
X-Google-Smtp-Source: AMsMyM6BmcTT1qNlfrcpjXoWkqUoD4ZoFCl+YDO1ybi6vyzR04dgvCxlUkzAgJ37dB8rS7zNaRWQLA==
X-Received: by 2002:a17:906:3fd2:b0:78d:b793:5ef9 with SMTP id k18-20020a1709063fd200b0078db7935ef9mr20030416ejj.496.1667342165461;
        Tue, 01 Nov 2022 15:36:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id rp7-20020a170906d96700b0078dd4c89781sm4693845ejb.35.2022.11.01.15.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:36:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 05/13] Makefile: split off SPATCH_BATCH_SIZE comment from "cocci" heading
Date:   Tue,  1 Nov 2022 23:35:47 +0100
Message-Id: <patch-v5-05.13-b00ceccf1d1-20221101T222616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
References: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split off the "; setting[...]" part of the comment added in In
960154b9c17 (coccicheck: optionally batch spatch invocations,
2019-05-06), and restore what we had before that, which was a comment
indicating that variables for the "coccicheck" target were being set
here.

When 960154b9c17 amended the heading to discuss SPATCH_BATCH_SIZE it
left no natural place to add a new comment about other flags that
preceded it. As subsequent commits will add such comments we need to
split the existing comment up.

The wrapping for the "SPATCH_BATCH_SIZE" is now a bit odd, but
minimizes the diff size. As a subsequent commit will remove that
feature altogether this is worth it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d81b0931ddd..8c4751e1bd6 100644
--- a/Makefile
+++ b/Makefile
@@ -1302,10 +1302,11 @@ SP_EXTRA_FLAGS = -Wno-universal-initializer
 SANITIZE_LEAK =
 SANITIZE_ADDRESS =
 
-# For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
+# For the 'coccicheck' target
+SPATCH_FLAGS = --all-includes
+# Setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
 # Setting it to 0 will feed all files in a single spatch invocation.
-SPATCH_FLAGS = --all-includes
 SPATCH_BATCH_SIZE = 1
 
 # Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
-- 
2.38.0.1280.g8136eb6fab2


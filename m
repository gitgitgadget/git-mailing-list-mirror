Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042CDC4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiKAWhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiKAWgl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:36:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47398647A
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:36:07 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id f27so40782816eje.1
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToZjVXMHPb/KCSianxlKaWCBzKTx89aKBrYNYdCa1vU=;
        b=cFTIfgEGsAGXccICx8EvBqUynQKPA0Q5ZGPXixgxwrK48E86V+6mMW3nZsW/clJPqJ
         GiOWmuDl+vDhO4I5Qn/oa7raZRaANQiPTGceEFYrKTAGi+q8RJlO6oP8XRZFf0OkRDvb
         SD5hwGbmoxcvZkE7XudTUsosNZZB9c/LlkVoJ7+L0bPvOkvtpomRhRu7sdD1u4aBEHuq
         sVywEgbob+F5etT7noRvWSNFfH3ebkOM0RtUsWi8Jp8m7aTaAlXS7FBMNF5HHAVSYBXe
         jTg5GtmYDrVzQhvZ+IckYNxNjKiW4rtbSJWc0PFTSIL2Zl6LiMaGdEgmXVEjlD0xuTOz
         ++sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToZjVXMHPb/KCSianxlKaWCBzKTx89aKBrYNYdCa1vU=;
        b=kx13JWKU6C7TIlLSDL5uO3HoQbSq/Wa/zjZiIzpV5G4934C+ql8jZ7ZslefVeQ/7cA
         fNTGphNn9Y2+uOGk1rRhWgn+Aj/FVe7hdpYYCqqYTLArjcmYlaVEerZsGMhD8QOyAQCK
         utG9VvCPIOqRwJX6uUA4X9T4/b64yZMf2UY+uf8FptijQk+oWQCwpH1wU+dVwQj02W84
         F1A5nvITbWwFyX6TCslVkscWG1wkgzIFypEBZgB0XbIKpBY50/qGSY2XW0cvBFKHjUnL
         lh6HUuAgkHeaR0LrhtWDt4Tups+D0yXjPeDmDK38pRqiPkq2jGvmXokNnfqKKOl15fFT
         ZtjA==
X-Gm-Message-State: ACrzQf3rKsk2BCfKO7CbXzv+HS9KeXjY2Q3MAZJw1fzZw7JMlExfLcpc
        RCS/++lLKyT5BO0JpddvJU+OixY3HG+iPw==
X-Google-Smtp-Source: AMsMyM4O7+1j796YBLm1TYW7veMCxS0sRnPVbt+owEUBsB5N5ssMKS0DLzpYXsdamSHNjPWfmDG5MA==
X-Received: by 2002:a17:907:70b:b0:740:ef93:2ffb with SMTP id xb11-20020a170907070b00b00740ef932ffbmr19640361ejb.93.1667342166536;
        Tue, 01 Nov 2022 15:36:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id rp7-20020a170906d96700b0078dd4c89781sm4693845ejb.35.2022.11.01.15.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:36:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 06/13] cocci: split off include-less "tests" from SPATCH_FLAGS
Date:   Tue,  1 Nov 2022 23:35:48 +0100
Message-Id: <patch-v5-06.13-04d268e246b-20221101T222616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
References: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the "coccicheck-test" rule added in f7ff6597a75 (cocci: add a
"coccicheck-test" target and test *.cocci rules, 2022-07-05) to stop
using "--all-includes". The flags we'll need for the tests are
different than the ones we'll need for our main source code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8c4751e1bd6..6785e8175b5 100644
--- a/Makefile
+++ b/Makefile
@@ -1304,6 +1304,7 @@ SANITIZE_ADDRESS =
 
 # For the 'coccicheck' target
 SPATCH_FLAGS = --all-includes
+SPATCH_TEST_FLAGS =
 # Setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
 # Setting it to 0 will feed all files in a single spatch invocation.
@@ -1313,6 +1314,7 @@ SPATCH_BATCH_SIZE = 1
 TRACK_SPATCH_DEFINES =
 TRACK_SPATCH_DEFINES += $(SPATCH)
 TRACK_SPATCH_DEFINES += $(SPATCH_FLAGS)
+TRACK_SPATCH_DEFINES += $(SPATCH_TEST_FLAGS)
 TRACK_SPATCH_DEFINES += $(SPATCH_BATCH_SIZE)
 GIT-SPATCH-DEFINES: FORCE
 	@FLAGS='$(TRACK_SPATCH_DEFINES)'; \
@@ -3198,7 +3200,7 @@ $(COCCI_TEST_RES_GEN): .build/%.res : %.c
 $(COCCI_TEST_RES_GEN): .build/%.res : %.res
 $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinelle/%.cocci
 	$(call mkdir_p_parent_template)
-	$(QUIET_SPATCH_TEST)$(SPATCH) $(SPATCH_FLAGS) \
+	$(QUIET_SPATCH_TEST)$(SPATCH) $(SPATCH_TEST_FLAGS) \
 		--very-quiet --no-show-diff \
 		--sp-file $< -o $@ \
 		$(@:.build/%.res=%.c) && \
-- 
2.38.0.1280.g8136eb6fab2


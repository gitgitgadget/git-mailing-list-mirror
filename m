Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5320AC433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiKAWgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiKAWgh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:36:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6387D201AA
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:36:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ud5so40815298ejc.4
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9i0ODwq7p4KVBBc2IQQkiYby8hh3z3ZxvRjg5+jaQ7k=;
        b=Y6U85o1TGc9QwQsQ+hd0ubkheR7pQ3es6lbTjf5kCV4uqLKRejYa9RpRgPeSS7PAPQ
         8xzB3JEo98PcGAUMTVnRSryc1Hla7uABrUnAFJk5sMzY/CvuvRV16V+40dW90C3sdLVb
         uUptad2gECZPwavzhzq4SdCIScpxlEJDdsATKZ6aZwF0UQ8no3fTxg53XmoD6tL+s4w9
         GxK6G3TYkICyeGUSWi9SCagqQsRdH3sG5snu4uTy7o1j497+N54b0zMQQw2cZEUAYfH8
         LNb5RprsU53JioDeD832VKRkSgzuIR+OcfG5xS2M5NdyGENzyJkQ80fZK0adzgZpA05O
         SqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9i0ODwq7p4KVBBc2IQQkiYby8hh3z3ZxvRjg5+jaQ7k=;
        b=nNuLwoy2mr4F5gsiT3uYU7qGHYV2wPwBsCJn6V6gKxbtHz6X8N52MpL7nAf///fit9
         8K4Azk2TzvjueoL8d6B5ZczCZ0V7mI8J4y4sWBNJ/gvPUddmAqStkc9rrq1yt0OFrLEu
         0LhOypBfm5Qdw6q9PbDpLOCSH+VwDC80NTxgDY+S+d7osTnwpWEmGlo8TPFLSOC04oxE
         /5RwMh2j2IpSJiAlKK3niHWmY8QT9L+E6WVFrVS9nl4dmAdNMlpDfLwc2koLY5F86wwG
         Rn5T5zuuzeqhiWVoeW1oc8jL6JdZAdKV1gFAfH1VV1m42rUDm+VJ6AxO88gzA0933vcV
         pTyA==
X-Gm-Message-State: ACrzQf2g7eaw6Bar1kjZ/Z2p0MxakT39WqglpaCYt1Osv17oBfW07iHL
        fh3Wy5N2C+HQkgtOrBg33LNFteMaxpI4rQ==
X-Google-Smtp-Source: AMsMyM7upA2UVDaWBYEex0vM402/I6RNCJUeR3Zi9prDa/ry5n+yr+PBAPbBIGwroID6b685JOu9+w==
X-Received: by 2002:a17:907:760e:b0:7ad:e4c9:dc79 with SMTP id jx14-20020a170907760e00b007ade4c9dc79mr8346617ejc.308.1667342161713;
        Tue, 01 Nov 2022 15:36:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id rp7-20020a170906d96700b0078dd4c89781sm4693845ejb.35.2022.11.01.15.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:36:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 01/13] Makefile + shared.mak: rename and indent $(QUIET_SPATCH_T)
Date:   Tue,  1 Nov 2022 23:35:43 +0100
Message-Id: <patch-v5-01.13-1c77706db26-20221101T222616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
References: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In f7ff6597a75 (cocci: add a "coccicheck-test" target and test *.cocci
rules, 2022-07-05) we abbreviated "_TEST" to "_T" to have it align
with the rest of the "="'s above it.

Subsequent commits will add more QUIET_SPATCH_* variables, so let's
stop abbreviating this, and indent it in preparation for adding more
of these variables.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile   | 2 +-
 shared.mak | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 4927379184c..b07ee35e17d 100644
--- a/Makefile
+++ b/Makefile
@@ -3172,7 +3172,7 @@ $(COCCI_TEST_RES_GEN): .build/%.res : %.c
 $(COCCI_TEST_RES_GEN): .build/%.res : %.res
 $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinelle/%.cocci
 	$(call mkdir_p_parent_template)
-	$(QUIET_SPATCH_T)$(SPATCH) $(SPATCH_FLAGS) \
+	$(QUIET_SPATCH_TEST)$(SPATCH) $(SPATCH_FLAGS) \
 		--very-quiet --no-show-diff \
 		--sp-file $< -o $@ \
 		$(@:.build/%.res=%.c) && \
diff --git a/shared.mak b/shared.mak
index 33f43edbf9a..96b06acc455 100644
--- a/shared.mak
+++ b/shared.mak
@@ -69,8 +69,10 @@ ifndef V
 	QUIET_SP       = @echo '   ' SP $<;
 	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
 	QUIET_RC       = @echo '   ' RC $@;
-	QUIET_SPATCH   = @echo '   ' SPATCH $<;
-	QUIET_SPATCH_T = @echo '   ' SPATCH TEST $(@:.build/%=%);
+
+## Used in "Makefile": SPATCH
+	QUIET_SPATCH			= @echo '   ' SPATCH $<;
+	QUIET_SPATCH_TEST		= @echo '   ' SPATCH TEST $(@:.build/%=%);
 
 ## Used in "Documentation/Makefile"
 	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
-- 
2.38.0.1280.g8136eb6fab2


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53235C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiJNPcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiJNPbj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:31:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC145B516
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:35 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b4so8169698wrs.1
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLbmUgtl+mF/6MvyNI8rejJ8ApT7XS3QJDqdENaeE5I=;
        b=Z+gZVgErVGVPxyvQsr7dTPl5bXprI4izcnph367zsod9Jz9xX0hqawPMGDJdJQTt0u
         ydciEb89H4V5p6zhk0UulMpDRbUiDEKv6Xx/s/h8X6EzcE0vnHnus4RS8F3YUHT3z9/1
         BoU/rBk+tTF9Q64+ax59+N+9IHHZQekVpKBTKaRQjyRc+HBGWqqTzZBds50mUGHkZLre
         ucqi++eDE0IxdM760vkhhFZeT10YB2/k/tfZR0Eizo3E6TSDd+3jmNmVre4wf5GlRwJm
         bcGrenG/6RRyVYa9HQvPsUXyv5W8ypLc36INL4bl7DxJxD+HFy4wRUFIdF//zfjf2Ivc
         zdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLbmUgtl+mF/6MvyNI8rejJ8ApT7XS3QJDqdENaeE5I=;
        b=VvMvj49tNK8y4ydsfuh/8Xk9rMZcPlqd6cj/7+8y5eMhhYNMy+dW5PWSpvPGrz9iL5
         kdmoYHVrccvE7lykf/87TllIZNhicELENy+hO7i08ALtMFuQIGj/D2wtGSloLUSLO25k
         Lg5NevrqJkPfsUwBRvQAAyksFxNIHvOGD8aUgvX4ev5EbPNXTxCoIX4C1b3ssf08uJvc
         ftv1VZ2DvgbasTem+DFLgRcEbKqj/fZbPpuLrpkutHsqt6QD/zcIb366qCS9lC2NYrn/
         FGq7pkrpsHXmsX2wRo/2up1WxUWpwbKOKoVOqpP89pMaDDac8WumDfJK8QcSczHNdPqL
         Gvdw==
X-Gm-Message-State: ACrzQf00at27iYmntQ6VKZnKkGJO4PiuqhzBv/WQJDKH2yLX0av61ffy
        n6Pay7VRN1v8pJfiXr5ay64TdqPbfpNerA==
X-Google-Smtp-Source: AMsMyM4OUjewNF4xf4eSukW8abvnRdMQlWm/6pVr41iucECIL9DjwZ1Rfa2AdQsp6bomymfDy4vFkw==
X-Received: by 2002:a05:6000:1845:b0:22f:bfca:6439 with SMTP id c5-20020a056000184500b0022fbfca6439mr3826444wri.298.1665761492269;
        Fri, 14 Oct 2022 08:31:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id dn7-20020a05600c654700b003b47ff307e1sm2219053wmb.31.2022.10.14.08.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:31:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/11] Makefile + shared.mak: rename and indent $(QUIET_SPATCH_T)
Date:   Fri, 14 Oct 2022 17:31:17 +0200
Message-Id: <patch-v3-01.11-4494c91df9a-20221014T152552Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1092.g8c0298861b0
In-Reply-To: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com> <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
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
index 6bfb62cbe94..f641adab2fd 100644
--- a/Makefile
+++ b/Makefile
@@ -3164,7 +3164,7 @@ $(COCCI_TEST_RES_GEN): .build/%.res : %.c
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
2.38.0.1092.g8c0298861b0


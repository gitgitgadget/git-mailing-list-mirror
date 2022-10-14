Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C8FC433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiJNPcY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiJNPbn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:31:43 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464EC1D52C8
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:37 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bp11so8115919wrb.9
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ol2ZmjzxwxF4VR7SkQQMjvXiqxpqml71A92pk7pG/Ww=;
        b=WVnn14JaFt7jtnVanIJmcZpwDHg1GKy58kooRIYKGwJ5QbDerzIvPAJruURNUk5DeX
         rNxSegCvgcZu/4egcQ5AOVI10rPL+6qvAaJtiI+hVaR6tI/UKGU9LslODBsy5jcUsdrN
         mB5OxX/802VHwA72KlHS+w+qrnrynP/fxloro7RsGfUfrnG0mqSk7vEN7Pi1FYOu6/EO
         JfUp7S1ZjOQo7edGzJ6+fVmk8KXgf1xGorIIMLu/2OJqpJfT4AkW0y2+eAXhVdBdzASg
         rNfS71knnpLh4o4O2l70OPxSPpwYWQFPmaDxhQEBun5jJ15tdptPWKH3NNlnummfbtFo
         Xfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ol2ZmjzxwxF4VR7SkQQMjvXiqxpqml71A92pk7pG/Ww=;
        b=3hRcl95rs1KdFRyNx+uhlEYzhULaa7bkDlAMkDCQ/nM6FdcUYX/7aLm3SVGYTeWP0w
         RPi2qw4ELScKqprJaYhslzxaABzUnXtE6QNEhbqfqiz5YLXaF78zRp1LrZ9Qv9wAbr4a
         U5q3nAIOq21IRD+6ein7yEMaXidTeAdlguYDolj3qwHSR1hBRBYvSCQclue/zeKL8RFi
         +FWBq6a45uXi7QrgrnLbDlVL4+gE9VMKGG1vEcNGMIz5ASO5wiYHzPvh+X+H646cVVJe
         L4YAG/9RF2OasYgmRKmek8hdgKiksBpea5P9Cv1t2ftvEJ5kmROoWagz3SQhKLo3MhGA
         C+ow==
X-Gm-Message-State: ACrzQf2J5hCexRw7Gs9dVW0MLb5se9e7zOesszaUqvNMwtH5n0gxOYUd
        +XnzWgI2CjSXWcbF4F4EMm6fqpkjyNLgmg==
X-Google-Smtp-Source: AMsMyM6csYGO/sCppHOhAl04mFBTTnhb7gcc23rBPeKVgZEA7UjaSH2vHjrsdgxQaQV0/vdsw1pQjQ==
X-Received: by 2002:a05:6000:112:b0:22e:58ce:40d4 with SMTP id o18-20020a056000011200b0022e58ce40d4mr3807484wrx.193.1665761494962;
        Fri, 14 Oct 2022 08:31:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id dn7-20020a05600c654700b003b47ff307e1sm2219053wmb.31.2022.10.14.08.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:31:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/11] Makefile: add ability to TAB-complete cocci *.patch rules
Date:   Fri, 14 Oct 2022 17:31:19 +0200
Message-Id: <patch-v3-03.11-6dbfafa08fd-20221014T152552Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1092.g8c0298861b0
In-Reply-To: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com> <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Declare the contrib/coccinelle/<rule>.cocci.patch rules in such a way
as to allow TAB-completion, and slightly optimize the Makefile by
cutting down on the number of $(wildcard) in favor of defining
"coccicheck" and "coccicheck-pending" in terms of the same
incrementally filtered list.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index f641adab2fd..4647f317ede 100644
--- a/Makefile
+++ b/Makefile
@@ -3136,9 +3136,20 @@ check: $(GENERATED_H)
 		exit 1; \
 	fi
 
+COCCI_GLOB = $(wildcard contrib/coccinelle/*.cocci)
+COCCI_RULES = $(COCCI_GLOB)
+
+COCCICHECK_PENDING = $(filter %.pending.cocci,$(COCCI_RULES))
+COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_RULES))
+
+COCCICHECK_PATCHES = $(COCCICHECK:%=%.patch)
+COCCICHECK_PATCHES_PENDING = $(COCCICHECK_PENDING:%=%.patch)
+
 COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
 
-%.cocci.patch: %.cocci $(COCCI_SOURCES)
+COCCI_PATCHES = $(COCCI_RULES:%=%.patch)
+$(COCCI_PATCHES): $(COCCI_SOURCES)
+$(COCCI_PATCHES): %.patch: %
 	$(QUIET_SPATCH) \
 	if test $(SPATCH_BATCH_SIZE) = 0; then \
 		limit=; \
@@ -3175,11 +3186,11 @@ $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinell
 coccicheck-test: $(COCCI_TEST_RES_GEN)
 
 coccicheck: coccicheck-test
-coccicheck: $(addsuffix .patch,$(filter-out %.pending.cocci,$(wildcard contrib/coccinelle/*.cocci)))
+coccicheck: $(COCCICHECK_PATCHES)
 
 # See contrib/coccinelle/README
 coccicheck-pending: coccicheck-test
-coccicheck-pending: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.pending.cocci))
+coccicheck-pending: $(COCCICHECK_PATCHES_PENDING)
 
 .PHONY: coccicheck coccicheck-pending
 
-- 
2.38.0.1092.g8c0298861b0


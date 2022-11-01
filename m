Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C43AC4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiKAWg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiKAWgj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:36:39 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E95A201BD
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:36:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y14so40787638ejd.9
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hz75qdjgmxuIXxRyP7RyUMm4W1pPF0rrghOokrjmf9Y=;
        b=SfvJY1exRXdrrbpw8N9jY4rYv9wNfLpVKxPp5gqeIxtzwdPcib3zNOE/pwM9HQd5qQ
         W0GY0Ky9DXcIYyMPaOOxeeClki5BhlVN9U5hBclrkyfyyNTSwTKIhVb72tRaFZps9HBz
         quTiKPbiFsChbzwLe/jsTLzY4XvxOGDPzG6nVJX1Z2m4tLSaVXrm6W2AteoY3kpENLEc
         ODYdexHzHzYsJZtRf9B/IRHLjdhUd16euPh7xlm5DIwiPZNCDVjhO8lFDgfetK78n8+l
         Aiu6c2Lan0cezLeHQMDwM+Iu3pFhSipYZiEXqDvViyxu8/2xCVbAY/ly4mLOb5pqFy6b
         WuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hz75qdjgmxuIXxRyP7RyUMm4W1pPF0rrghOokrjmf9Y=;
        b=e8mtes5OGUtdwyBcOt9F7b/V/61iAVBIhOqw8lcL21ZPKddE9+BOP7vqSo6L6b5wDU
         bWtpbEp8U3NJz3G7BflP0mg+sFrEwwnOPXGyx/MPBPiXfVvl9gLUfNvZFLQUolk6gqta
         x6ggY5I8N3TRnlQLkAvDLoda6iGBPuO/47TLFWPoo29UxZUrYWTJ3MvJjh2A4EQy0CX8
         5KEY76ln9azsy7eKvTbqXx8Xy6PS9wgOyUnjj4Useq1qQIeyaNwz8fuMX7s7I7eL7O7c
         IJ0hlN0vzJni9Vbs/7IgJch5920XDdAIRSALHkZOImp0n4B9/pJZbhcxRilxrYXLBMne
         24rQ==
X-Gm-Message-State: ACrzQf0fKminyMjRSu4K831K22NFtEV5nVrU0kktKlvcvjj0nqblKEUS
        wt993CBqu02xz+MQcIvAwHp3Zhe6h27apA==
X-Google-Smtp-Source: AMsMyM7nUNYxXoU7Bphrw4NF6Zl2KCOEQnwW/Gc9MLvL6S5M2yJBUHKUFOexx2MTiKneRxJPQAHf5A==
X-Received: by 2002:a17:906:3b48:b0:7ad:fa67:1daa with SMTP id h8-20020a1709063b4800b007adfa671daamr1990376ejf.653.1667342163518;
        Tue, 01 Nov 2022 15:36:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id rp7-20020a170906d96700b0078dd4c89781sm4693845ejb.35.2022.11.01.15.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:36:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 03/13] Makefile: add ability to TAB-complete cocci *.patch rules
Date:   Tue,  1 Nov 2022 23:35:45 +0100
Message-Id: <patch-v5-03.13-6bf908044eb-20221101T222616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
References: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
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
index b07ee35e17d..828d332096a 100644
--- a/Makefile
+++ b/Makefile
@@ -3144,9 +3144,20 @@ check: $(GENERATED_H)
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
@@ -3183,11 +3194,11 @@ $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinell
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
2.38.0.1280.g8136eb6fab2


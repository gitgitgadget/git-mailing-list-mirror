Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1597C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbiJZOVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiJZOVB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:21:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB5443301
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:21:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id f27so11097800eje.1
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkm/7YChxLy5zLVgYYhTemskil+iMZiLCXOBjwNvXd8=;
        b=Tyv+e8aUyKsDIr9pXRUviYRa6TwaXQjFb5nAxSkVKGUqLVgcu2rJIb+s5YHNy5bShT
         l0I6pBjTzuj8TGqttGm6QLQIlFbzV2JgrrRUHmtyTz2myV8nIzmQ/DUs87KAQ4w2a8XR
         P9vyKo6oY+6xWYNU98NcsDSdrRWAor6GMiqVwOaTKTjoZYvDBSqYJ0KwqPoa8KXihMYf
         xqJNgKw3uCcPt6Iia2ZpcJ6eBokLxuU2rFu8a+Xu/GVKru1kru10q71xT7xTBr1pAIMG
         OBEv09Lrn4lNHgEyA18F3YtNL6prn0hJm+y0gGm1jVED75UX/qhLMobEVnID2egYB6Eu
         bIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkm/7YChxLy5zLVgYYhTemskil+iMZiLCXOBjwNvXd8=;
        b=Kq7Ytuva3eztJUcyDPmaoqiN0hQwXwEdlk+Fq5e0QMouvelE/fqWRvucx9SYoY5C2R
         FqeOH1EDECbGRVQMudqRbKi3KULdXzrQT/o2jZ0mhUEl4ktTAr03REbm92189UYSgfq5
         W4tLjUkdjMAVo29dXslFD3MhgsTBtPi6ksUKQnzYZ6uUHtJSaXb1+N+bGktTx3RfFswi
         D+VZexL6jNHaNzf5lY5w46sDvWy68iWWsJKLdQIfAxj1R3FlTAgzQzFMPeq6D34EXL9T
         KV2S3R7xxGxetChKwC+CTMzuw/jeLyZ2MT6gGUex/V/cjm7qz4fITX0Q+aHDAKNSH49v
         /ajg==
X-Gm-Message-State: ACrzQf0mAYLGF6bf1uBtWbvQHQCCA6rkBFPsO8shyr/AaG0QOD2Ssocf
        7HFUs37SxYZ3xrFU3kteTaiCwgEWZNU=
X-Google-Smtp-Source: AMsMyM7oqDu8GmuTmX1a1BQP3uZjuEpWGZRGWwYQwU6CLuDOHn7ZHRPGb1Pd7UAAbAgIB0sOTFhLTQ==
X-Received: by 2002:a17:907:b15:b0:7a7:19a3:e9e7 with SMTP id h21-20020a1709070b1500b007a719a3e9e7mr15216170ejl.361.1666794057282;
        Wed, 26 Oct 2022 07:20:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11-20020a50ea8b000000b004619f024864sm3605565edo.81.2022.10.26.07.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:20:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 03/12] Makefile: add ability to TAB-complete cocci *.patch rules
Date:   Wed, 26 Oct 2022 16:20:30 +0200
Message-Id: <patch-v4-03.12-210dbc6b101-20221026T141005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
References: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
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
index 0ca1781510e..b638a548182 100644
--- a/Makefile
+++ b/Makefile
@@ -3140,9 +3140,20 @@ check: $(GENERATED_H)
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
@@ -3179,11 +3190,11 @@ $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinell
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
2.38.0.1251.g3eefdfb5e7a


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1449C433E9
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 11:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C2D64D7F
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 11:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhBALSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 06:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbhBALSN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 06:18:13 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63501C061756
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 03:17:32 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id i8so7275260ejc.7
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 03:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nwq5nsRhT/4w7swwCTrVYAXbwr4AxduYhnq0dq+J32Q=;
        b=B42aPeEGMckPljx/M+CXWwuGq57qwKRmGSG3FSqyoBftBlFbn2s0oQbLmr2NJXN61p
         GI/xB4nQgDJhK4msZVkGVdgjntNPc74ukrdjOKp6CRspRrS7MfpmtoE6LsPjsqZq53gT
         A9HnIac7BGXFMje/tmLGhwuIEZ8UiqsORPtlD++lXiGB2PdNNUbFNs4E9E/kRtFTgNAg
         yMkSyQd20NAqyXXOyejo8fU9WLeUSftDbCt2qu2PWL0Au88Gx9F6rEkUfnOOOzQRZxNB
         2bBiF7313UNHG0So3C7qJx1f9DTW7Py0mTGaiV+LOKXjOibSxQykVrhPg3kMETLrF9PW
         xKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nwq5nsRhT/4w7swwCTrVYAXbwr4AxduYhnq0dq+J32Q=;
        b=LJCPNOd3pWKAO2+Ku0c27KRIINETMEjIkR/whED3w21kxn/9VR0pXh4qhmHrNSaPd1
         NuHlyptI8IS28SBH+vzNQpIR6O6QcP7M3N6GRsCW1dGSepYlUbrv/EJJ35EuJOZnfMel
         iX9xrRk0qivLfzivVNNHHlazEzV/OoslCWsE85JAQ5p0mDEDhffx7f8wjfkQCMp7rxQ1
         vLA/jmEXu7TCXtxHLpDd3bqv8SLdH1TnuChjKxvAmPoT8FamSl08a0geZmm8TsXMbRsS
         NuVUi/1hYGm92FwiXZNMCjfxEti8WaWphWCgRFovw0Uo4c/b8NXE5eLhvdR4sBHJ5mut
         B2gg==
X-Gm-Message-State: AOAM530SXCC9KvWqLoWq4TV/1Y0roXqP4Hju9otwqR3+2BTlLoYz85MT
        ItL2e7wO8fMfYYiijBwBxhZXkMPNkUNEMg==
X-Google-Smtp-Source: ABdhPJwqKsT1VanY7SkyHqhx8MOOCFZLnlW1Rn8XnRzKCJ+jbwyCxlWoFc0I8dfGwzWLVlFmDauJUg==
X-Received: by 2002:a17:906:f0d7:: with SMTP id dk23mr17212279ejb.131.1612178250735;
        Mon, 01 Feb 2021 03:17:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t19sm7760548ejc.62.2021.02.01.03.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 03:17:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/6] Makefile: split up long OBJECTS line
Date:   Mon,  1 Feb 2021 12:17:12 +0100
Message-Id: <20210201111715.10200-4-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210128182310.26787-1-avarab@gmail.com>
References: <20210128182310.26787-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the long OBJECTS line into multiple lines using the "+="
assignment we commonly use elsewhere in the Makefile when these lines
get unwieldy.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index ce18d9ceffd..c7caa4b0ae3 100644
--- a/Makefile
+++ b/Makefile
@@ -583,6 +583,7 @@ EXTRA_CPPFLAGS =
 FUZZ_OBJS =
 FUZZ_PROGRAMS =
 LIB_OBJS =
+OBJECTS =
 PROGRAM_OBJS =
 PROGRAMS =
 EXCLUDED_PROGRAMS =
@@ -2383,11 +2384,15 @@ XDIFF_OBJS += xdiff/xprepare.o
 XDIFF_OBJS += xdiff/xutils.o
 
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
-OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
-	$(XDIFF_OBJS) \
-	$(FUZZ_OBJS) \
-	common-main.o \
-	git.o
+
+OBJECTS += $(LIB_OBJS)
+OBJECTS += $(BUILTIN_OBJS)
+OBJECTS += $(PROGRAM_OBJS)
+OBJECTS += $(TEST_OBJS)
+OBJECTS += $(XDIFF_OBJS)
+OBJECTS += $(FUZZ_OBJS)
+OBJECTS += common-main.o
+OBJECTS += git.o
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
 endif
-- 
2.30.0.284.gd98b1dd5eaa7


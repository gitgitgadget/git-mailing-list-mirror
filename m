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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DBFC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 11:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC6DB64E57
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 11:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhBWLme (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 06:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbhBWLm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 06:42:28 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB72C06178A
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 03:41:48 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h98so17434406wrh.11
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 03:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q3otzpWYqUxrXMgwvsPgS8s3SYH2ytn/gcw2QqVGY40=;
        b=vJe9tiU17cJHqD3x9z1zKJEMRMWVFWmUKn5pTfVH26qGR1zWBRDzy7f9Bw3lpbv6WM
         Bfi11aW/wzaSjy6WrVFAqnLzn51KPtj25Be5S1Ss6G79KTQrlnFpm3+XG4wigOgkNtIK
         dAODeM41k2Gp2eSVz+YfdTf8mYbwUz3RM/Y9RRtCfTLgNirS6e0efYyaH2Ivc5/vT64V
         wEJ4WxmI+hadYzGCubmEFuzKQgJzBVMFOVwPRMoAtUYIwA68p4Lw7iw6l6+S6l2HkQ+W
         rckOMwstY56VtatM2m0btWoRM4+CLILuPI5tm5rqu19rrA8zgrCRboaSsbqSMiWlMd2p
         TP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q3otzpWYqUxrXMgwvsPgS8s3SYH2ytn/gcw2QqVGY40=;
        b=HctMmZlLQV7cdZVIhztjO3LZ9gRtVDKsuAa1A461t7ygJc4dWg4smG6vN+WLS7pbHc
         kiJOj7IY317vTJMogB9xFc8e9Ul53y040uYJG7lC+g6w4DlcSUZdCguV2wueW1wnsH66
         rLEQDjyLmkTlZteeiyUSO0ORfwXPF2h9+IdFjkD5C9HGHkJSoxWyvd0B7YPziQM+YqCX
         /f1ii66bnrzzwW8QwJiudT3ZVmLvaANkRb1yfzYuYSBIvqkQdwbKX+g3b0u3jb55yE7S
         geUUtxaXbJhYTNpmWG0UfDubEYrD4agQWK0pQWQWAZzrTdUs5ABQHzKVgX9BSV96eb7n
         vKfQ==
X-Gm-Message-State: AOAM530LMnMiiN7vrtpW4D/Ty3CwYqNb9I5P55CjiqEDT0M1HLTnwZuv
        jGOjYIwdKWSTrA9op2eVzHmmLkQhm9Wacg==
X-Google-Smtp-Source: ABdhPJxmvun8XLa14cu9DIRAKlK3Vd77kgNYzjmG0LDPtRDRl5xk/bgmUKq+rEBBFESS3NNQOqKP4A==
X-Received: by 2002:a05:6000:89:: with SMTP id m9mr17774310wrx.3.1614080506882;
        Tue, 23 Feb 2021 03:41:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n9sm2391336wmi.43.2021.02.23.03.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 03:41:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/6] Makefile: sort OBJECTS assignment for subsequent change
Date:   Tue, 23 Feb 2021 12:41:29 +0100
Message-Id: <20210223114132.24345-4-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210201111715.10200-1-avarab@gmail.com>
References: <20210201111715.10200-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the order of the OBJECTS assignment, this makes a follow-up
change where we split it up into two variables smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a5e389c9c36..6679153e24e 100644
--- a/Makefile
+++ b/Makefile
@@ -2376,12 +2376,12 @@ TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST
 
 OBJECTS += $(LIB_OBJS)
 OBJECTS += $(BUILTIN_OBJS)
+OBJECTS += common-main.o
+OBJECTS += git.o
 OBJECTS += $(PROGRAM_OBJS)
 OBJECTS += $(TEST_OBJS)
 OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
-OBJECTS += common-main.o
-OBJECTS += git.o
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
 endif
-- 
2.30.0.284.gd98b1dd5eaa7


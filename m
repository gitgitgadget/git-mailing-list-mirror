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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E0EC433E9
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 11:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F301B64E61
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 11:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhBWLmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 06:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbhBWLm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 06:42:29 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A857C06178B
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 03:41:49 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id 7so22263702wrz.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 03:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X8gZG+Wkzkhc9RbceJ3qMAtlJbvna34Qw6AU6eJFvSY=;
        b=nMBRXkiKyGCWLq/RqIj8xZmGgeZxaGqjRqq9Ahf/W9Dj1I9YJKZ0p4YpUziLd4Uh9m
         3q55NCtY/yEIxDd9GXH34bbj8iRRWxzTLt+mDHmHW2qbujsr0enIbynX0FuhZAyFP4oC
         I9kePsYYWvfrJKIxFJ0dakYSEFtIZCvdRWLlCZvuL4NcdveQBHrvdYATpcC+fXgsNC80
         q5CHhsaicrCwff0+a4nZwGn8VLVDoSa/cYqjX1qF9IcSXnGPlKVDVI4iadl5Sjbw8c4O
         uS3uGPVtqyqezmAMLS3Qia0glG+4j7hluoQvxBTxdYqxi7YGo8xq/mJ+0Rtu6aYYy1Jn
         EM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X8gZG+Wkzkhc9RbceJ3qMAtlJbvna34Qw6AU6eJFvSY=;
        b=DYWcvwRlnncq26mqxcR/9VA7hCpa/H3fa5MQPeSzZlBTHUXNNYkuahXqaoSpvgSsO7
         sM2I4N7IfKXri6fcFi/6YLY9XR3eJOUHcdAOGzo8UAG2WQ3klsjAP3IByTvF1x9oQZzY
         A3CTBoOrDbxaFcfNiu8OZTMyCgkptavlkDpO/FubI+IeId2U9fmd3mXYC0itNuv6ONlq
         Fal8IkZ6u8godTbn/FURrB7pHvUenU1SW2MEyF/lTqhBkgQeoqu0I/4gGdUlQu1SpN+X
         qDOQUTLXSX3/9KLA2KCao9ZKYFRWQsNc1hRlQYY9lfFYRZZLtyPtm8rQfAagqIeKgtgE
         qejg==
X-Gm-Message-State: AOAM533o+TqOYdIPYDnsbVGuFgjOKcWSQ12OicYTqf0OcOMU+pqn9I/L
        pmvM3ztb4yumceP3izZ7+Q5FxbQXCDTbHw==
X-Google-Smtp-Source: ABdhPJx39896OhUfx5vCXXv3tYMTvdnepPuCecxE+lwFe/c0jWjgWc6EKp2cBllcAn2sO/rdBfIxbg==
X-Received: by 2002:a5d:6b85:: with SMTP id n5mr18686080wrx.16.1614080507574;
        Tue, 23 Feb 2021 03:41:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n9sm2391336wmi.43.2021.02.23.03.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 03:41:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/6] Makefile: split OBJECTS into OBJECTS and GIT_OBJS
Date:   Tue, 23 Feb 2021 12:41:30 +0100
Message-Id: <20210223114132.24345-5-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210201111715.10200-1-avarab@gmail.com>
References: <20210201111715.10200-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new GIT_OBJS variable, with the objects sufficient to get to a
git.o or common-main.o.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 6679153e24e..8b087f68b3f 100644
--- a/Makefile
+++ b/Makefile
@@ -575,6 +575,7 @@ GENERATED_H =
 EXTRA_CPPFLAGS =
 FUZZ_OBJS =
 FUZZ_PROGRAMS =
+GIT_OBJS =
 LIB_OBJS =
 OBJECTS =
 PROGRAM_OBJS =
@@ -2374,10 +2375,12 @@ XDIFF_OBJS += xdiff/xutils.o
 
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
-OBJECTS += $(LIB_OBJS)
-OBJECTS += $(BUILTIN_OBJS)
-OBJECTS += common-main.o
-OBJECTS += git.o
+GIT_OBJS += $(LIB_OBJS)
+GIT_OBJS += $(BUILTIN_OBJS)
+GIT_OBJS += common-main.o
+GIT_OBJS += git.o
+
+OBJECTS += $(GIT_OBJS)
 OBJECTS += $(PROGRAM_OBJS)
 OBJECTS += $(TEST_OBJS)
 OBJECTS += $(XDIFF_OBJS)
-- 
2.30.0.284.gd98b1dd5eaa7


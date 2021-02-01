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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBEFC43381
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 11:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A8064E95
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 11:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhBALSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 06:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbhBALSO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 06:18:14 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774A4C0613D6
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 03:17:33 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z22so18364426edb.9
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 03:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cfhbbqga8uGsdk6oxcSYerSEOpIf9pxgZI9ez0v0blk=;
        b=qn6lBUBkZhi980SCarMwDQ3bjvII4oGYui06X1xX8yXYmJmaHx436cVRcCwtiOw4bW
         H5jCqqCyy0B9uS+cIJlZAs4oygxx+tRVGOzI6Sk0daKnNjOMY70mNiwtxEkuIXB7nbUK
         8b+X/bnC+IyiZGil9TDyB/4/MPRupJHLYdvuGeVerRa9MVhnVsC0Ng8BHpZGvpkeMiBL
         P/ojQA+IJWd/VyRdoztg1dOt8waeM3iyOz7y9S3JJdEDVZjlFzfZBpBaQRCeER3eAz4Z
         vOtKkWhhOjkxty9vy0eaLQ7TtstF/JaoU+sufeZGVG9g21P0KKQoNu08sHeJdx4ZTFqs
         bcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cfhbbqga8uGsdk6oxcSYerSEOpIf9pxgZI9ez0v0blk=;
        b=shENhfT4d0hHZAylF4DFvHtqErloqbl0wnjWZurQqArJcS5rantqBOxxSkluJmA8Qb
         kiHfbksDwl9jvTsE3vd3rNM7ARQZgJxKVTmVpQwDOauq6QlpY6zpfiGBOP9xZcGAamNg
         GNGo2K15kGeZYHGk507QLyD04yAzt9w8RmKKOEP7sY76n77h7YgxTnUMZEp+D9nF9zUv
         vfBEGWWVRCHXb/wIIwNDKctP+KrLt2SzpWAapH0y876RNv/uiBH3rs1N1Oz/d8/EoNfg
         7MddoAuFm4dTmZ8ifZg9UFSlPmMwEnMGCHqhiycxZvnYk57lVzmNmnadu7Jwl7hwljhF
         JBHA==
X-Gm-Message-State: AOAM532xufZSkaQOIBt4JsfC4K9KPR0nXUBxqf6OLf6KuMomsthWc367
        r1ghSYh8w+rlQWmDa75eIwEIg+l7mWThNw==
X-Google-Smtp-Source: ABdhPJwLdu7D5XtgZVk2HuAasz1KED6VlhfmudhIcH7Buq+tLFHQhVkgBrG13Hn8wcbxroPNTLXtUQ==
X-Received: by 2002:a05:6402:46:: with SMTP id f6mr18126938edu.163.1612178252002;
        Mon, 01 Feb 2021 03:17:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t19sm7760548ejc.62.2021.02.01.03.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 03:17:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/6] Makefile: sort OBJECTS assignment for subsequent change
Date:   Mon,  1 Feb 2021 12:17:13 +0100
Message-Id: <20210201111715.10200-5-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210128182310.26787-1-avarab@gmail.com>
References: <20210128182310.26787-1-avarab@gmail.com>
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
index c7caa4b0ae3..e2e90424b62 100644
--- a/Makefile
+++ b/Makefile
@@ -2387,12 +2387,12 @@ TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST
 
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


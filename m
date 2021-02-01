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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9157AC433E6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 11:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4643260295
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 11:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhBALSx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 06:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhBALSv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 06:18:51 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942E8C0613ED
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 03:17:34 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id l9so23760756ejx.3
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 03:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ViXZhr1l1Nkzqe5uyHtw1USZetjMX9w253j5QDEasy0=;
        b=eb7cJ6vbaZD9/Xr2GSvJ2NtIvt72Sf209zUK501rytvhoYFNm/rzZHabbk3cz4Qyvq
         F/UIQl3HCwWdfIC/K9yIDPDwsk403VnJtZ6JEcWoD2Qwp4BYvesRJozOFSc2bi0nl3Na
         05Rr6jCQqEYKd4FL4nzjpE+8sKtaV3aj667Pq6naVzfcE7xMs0YUjGrsz/4yp+LyjcQ3
         r0tnd1pJZBxHOcqqFRaYdbcYN+U4uvGy6SVhjkDk5uM7TxxN15yMoWp9ImUv0NmvGskM
         ln1nKcxwmffWntWg9ikK5ngOry8nzKpAeMmFF/0Pm0RHIfP8u8+MBKxnTiU59P7o2kHp
         68xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ViXZhr1l1Nkzqe5uyHtw1USZetjMX9w253j5QDEasy0=;
        b=aMDJ6BnBh0LPQ+T/vAV7Etq4wZF3fU5WzPi30YlGNxp8fzlC22TkKCTIWn6SqsSok/
         6wKuMgpFLjIRlpWp0RlrMapSfyhiJnsTaKsmVcSD8VQSJXyUrc1kBwy6V5hBmjHTx4Uf
         zs55amKSXEtXCxdUvy+v2H44xtxErnUWvMs7g1G3F76zdgt7D2j/ou2mfBknltHF7lpj
         Mb54jZwxKaVIW7xnX1+XnLkJ51ABnFGHnuMkynMNVFOM331vJI4qGEbKNNnpt+QXMleW
         miyaU+JqNpmR+4etjfLAP5lMR2Q1e9jRjcJJCOkxXYFdXPzfVU9uummcIoRgw+ubywBw
         gWtQ==
X-Gm-Message-State: AOAM533N4S3s8x8VIoT+Bg5B8mTEqDqRTJ72jWARu2qtmvVHzUdVuAIm
        XFN/NDohDpnUdbIQfxknoxwyKcHa8RJ93Q==
X-Google-Smtp-Source: ABdhPJyQAnhBbBYHXtDfU8tRLPCSAV/Q7T3WdR5jewMQFhbCOZntDB0SiXtuSjmA3fc20U/3lO0Mgg==
X-Received: by 2002:a17:906:c7d2:: with SMTP id dc18mr16861819ejb.149.1612178253060;
        Mon, 01 Feb 2021 03:17:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t19sm7760548ejc.62.2021.02.01.03.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 03:17:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/6] Makefile: split OBJECTS into OBJECTS and GIT_OBJS
Date:   Mon,  1 Feb 2021 12:17:14 +0100
Message-Id: <20210201111715.10200-6-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210128182310.26787-1-avarab@gmail.com>
References: <20210128182310.26787-1-avarab@gmail.com>
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
index e2e90424b62..07763353423 100644
--- a/Makefile
+++ b/Makefile
@@ -582,6 +582,7 @@ GENERATED_H =
 EXTRA_CPPFLAGS =
 FUZZ_OBJS =
 FUZZ_PROGRAMS =
+GIT_OBJS =
 LIB_OBJS =
 OBJECTS =
 PROGRAM_OBJS =
@@ -2385,10 +2386,12 @@ XDIFF_OBJS += xdiff/xutils.o
 
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


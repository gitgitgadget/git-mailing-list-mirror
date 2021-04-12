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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990A6C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6983A61278
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244378AbhDLRQc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243746AbhDLRQF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:16:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101AFC061344
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:47 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id 12so13746797wrz.7
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qpJmheN2XZvVbouPsb5i4B951vWq6vi9kgYGf0KBOkE=;
        b=qcFTw260kpKDIugWI3JSjSTgPXCmOscsd3hYvYkzX9x2bncK80A0GPLhKMoEgrdDQQ
         cdINhs2gdKejyFnTY0s8qG8ZlDGtFpzM3ZQ+OjInxEv8CXDeahC8guLJW6xUmuwMq/d8
         hvKyYSoroOAP6UP55UnVa/WQCjKoFL84oMUq8zccZHT/IO+d9IxnUFzWGIYe3O21Oi61
         p85OWI49e8DVqsaPqXKvMTDLs/IxoHsFQwL0agPZD4j9UytVg1hvO+S3lV0BsHjtjMxU
         jUr0lsZf6JtQU/dLD/F06OgV7sZJcQ4pJxtn8GxylY3xaQweYHbRjhk7L+5WTheDJANV
         qUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qpJmheN2XZvVbouPsb5i4B951vWq6vi9kgYGf0KBOkE=;
        b=UILGypHG9Tq6/PToewRAw42NSg8V19wZjXALnN9yPyxnaMZE2zl71BreNAyw2QoYtQ
         rmHB4dMac+B8kAf0QJ8/AZrsnIUCDldnHPIcPSLCcRSv5R5PB3F75LWmDqhGqXkkdquj
         VZtVUVHkjbq12R/wWKSsHgosjNAPVebvNrUBoVEKmv5+e+0ZWQoq3KJUWua/VdXCVLai
         mTwkJfUJ8nj942GK1umnrneqsxbkS+A2jfgrJjvz7KQSQw4+Gl30hoE6fREKC8U0RnUA
         AgkK2Fr9FP8I4z5xfgtYzAE6QjdRU33jdJgp5w+0d7HUS1OI/wlxsokLMrw1PR40DXWk
         9kxQ==
X-Gm-Message-State: AOAM530XTitouPONfQTfjcdaRLSPEE+GI8XrECiFkaSYr1/GZbKRLwhT
        /H9VJdKPge/zLYeKAYE+3eDxOApKqBCBUQ==
X-Google-Smtp-Source: ABdhPJy/LF0nilH+D0ZP61IRkPCb7R9GT5Ad6jkJhtlv/yQEUaRCVwLY4A+wpvN3283888hwH6lKSQ==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr14875333wrp.173.1618247745614;
        Mon, 12 Apr 2021 10:15:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/22] pickaxe/style: consolidate declarations and assignments
Date:   Mon, 12 Apr 2021 19:15:17 +0200
Message-Id: <patch-10.22-afe70b163a2-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor contains() to do its assignments at the same time that it
does its declarations.

This code could have been refactored in ef90ab66e8e (pickaxe: use
textconv for -S counting, 2012-10-28) when a function call between the
declarations and assignments was removed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diffcore-pickaxe.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index a9c6d60df22..a278b9b71d9 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -70,13 +70,9 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 
 static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
 {
-	unsigned int cnt;
-	unsigned long sz;
-	const char *data;
-
-	sz = mf->size;
-	data = mf->ptr;
-	cnt = 0;
+	unsigned int cnt = 0;
+	unsigned long sz = mf->size;
+	const char *data = mf->ptr;
 
 	if (regexp) {
 		regmatch_t regmatch;
-- 
2.31.1.639.g3d04783866f


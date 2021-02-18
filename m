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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48043C43381
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AE4864DFF
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBRAId (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 19:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhBRAIR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 19:08:17 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49220C061788
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:07:36 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n8so635447wrm.10
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=92thXRPE9YmPQud+eCCr6kuWNASGlVySPio2bvZGfAo=;
        b=PGW3ZIcKKU2Lp7z8awbjhY7RLYqvgC2liFPwQG7KYWZm4GvivoQ3niPBUq5EIBCfIh
         CNtzOMYK4Q7Cp5HgvUVcX0ZNsJx/42k1su5W2FEYv3kjwyDjD20dClqkv8P0V2qhZmW8
         jjFOJCi/XNyk6uZE8nknJfYDfnO/fyCb9AsjzMltjZHTE4cgFdXvZVgbZT7W5vq97/nQ
         E5vsBtqvUvS+m3mbazG33Z3GPBRBvt1F1Te5l1eGl9g7EEkSgtIz7LOrHoRs2E4hFcaB
         MwpAMH8zH2oRAzi2CQ+c2M+0mAJ4QkDlc/L0A6rBnDc2SoXbFpfTfIMv+BbauJj8lMRI
         ad9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=92thXRPE9YmPQud+eCCr6kuWNASGlVySPio2bvZGfAo=;
        b=fapAT0LbP8O8MltuhmdTx/Xz9DsQFYeX9hNK53QONXK0RiLMk/pX1RxO6VvixJJclq
         HcLJvy8a9ElqlPQOWrVLFVPfe959i27IH+Krxeq9cCU0gM4KO3WtKpU+b+dDAgz+yb0I
         Iw7PS9Rxw1JjYs1PxAd6uPp/JA4q/fqhdyq3FpqneWkRyxxh2LW5LlAIXqrbrBx/rd4Q
         PJw2ndi1D277N5Gz2nIrfel6jw+p184iTjDqBqFnFKJY3KwkgglYj5qxp1kF/iHtzKcG
         7Kj2XWL3bDJvb41ZbE817bPdFXVwrZuNdM/VTvkHxpU9kEW9MiHt6/tQHeXoapz9odFH
         E/AA==
X-Gm-Message-State: AOAM530pan86ITdajTz2qZZDcryuKFutEQZPV+5cP9O5Q69pCUcbnLPu
        CDyx9l2HLCPxkry1VF2KM8eph03OZwFUPg==
X-Google-Smtp-Source: ABdhPJzO0UjxHO7FgdWi3UKuYkjdzyADD0oKKu0plV9+iRT2Lv0PQEYtcpbM3AkvjH96pXp3xnutVQ==
X-Received: by 2002:a5d:554a:: with SMTP id g10mr1502356wrw.383.1613606854790;
        Wed, 17 Feb 2021 16:07:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r17sm6232795wrx.82.2021.02.17.16.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 16:07:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/10] grep/pcre2: prepare to add debugging to pcre2_malloc()
Date:   Thu, 18 Feb 2021 01:07:22 +0100
Message-Id: <20210218000728.13995-5-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210204210556.25242-1-avarab@gmail.com>
References: <20210204210556.25242-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change pcre2_malloc() in a way that'll make it easier for a debugging
fprintf() to spew out the allocated pointer.

This doesn't introduce any functional change, it just makes a
subsequent commit's diff easier to read. Changes code added in
513f2b0bbd4 (grep: make PCRE2 aware of custom allocator, 2019-10-16).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index b9adcd83e7a..f96d86c9293 100644
--- a/grep.c
+++ b/grep.c
@@ -45,7 +45,8 @@ static pcre2_general_context *pcre2_global_context;
 
 static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_data)
 {
-	return malloc(size);
+	void *pointer = malloc(size);
+	return pointer;
 }
 
 static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
-- 
2.30.0.284.gd98b1dd5eaa7


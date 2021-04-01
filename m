Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897A5C43611
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642A061078
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhDABug (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbhDABuK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:10 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D741C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j7so201719wrd.1
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YIfeJaOwJ2PF4AvCIcf7mIqwTKwspa0fWugQUcTQFgU=;
        b=O2Sdfhz0003IJNqN7DwyqlPld8PYDHg/VjHV7XRol+seGtZ1WiJ8eFQFaphSnFpEOy
         WIbQcofwxAkRjc0y0jjYQdtmnz17L8j14vJDysmiEIm1Jo96aJ6vlFGK0/VBjcHmY5hd
         Av3HSO8K09aogQQ9UeXfH2tZamX0ap6/gHEavBzUGuZDgvEvCZ6K225ZY4reTauKyjvX
         YuUpdtdBMA8ds7T3eqVXj+Pc81S52fdx/aFrrwO8y8OYuLIMvuAyyiiPYgxWacbkwWTV
         tYZ+6noceNusDBrmHnKahvjpeLcQ4l3vcarRl7PdhhJ4gtZHMqRykpsQ12vWuVXAVnOt
         1HcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YIfeJaOwJ2PF4AvCIcf7mIqwTKwspa0fWugQUcTQFgU=;
        b=bpgmGACVZ51tJyy4UTpE/blvcVIRJz8tMyCSiu2AzMpSTZEbtdGGQ3B3uNprDj1icw
         revvFhlJEUOkDLJIrYiWRe8ZatjPfeyPAX3V875vyYpERPzeyr4vWykLLuc0Q4jQkd6w
         aebtukJwsM5JZKqOX5NWnsHNZk44Q7gZiO27NaIRkOxPjzxD/MDxx3ohKk7o7Ea590Qa
         F3ZYqdzk3WDWmWnQF/A/3Roq4H5SxSIyQnwfoOycDdQHD2WJNl9+mEWsOL67ksB6fIm8
         j9g53TYuooFXteIXvGu1dptX+2UVloI9H73peh4jnakRoBdjGDsmVAHZMDbXxWQ+1w7F
         8U0g==
X-Gm-Message-State: AOAM532yUZvIT+hyUoo3W0TKNLw+ShxKarD3rLB7DXDamMJNkDhFS81f
        8TQELenofnWsRov1Ax1UcRRHRKRRG8k=
X-Google-Smtp-Source: ABdhPJw4kIrNvoHxxI/cuEnWowCCxEa+ayOFPDGEa/6FtYmvVUjdloe82bFDvW7+et9UDkAOfRqRdQ==
X-Received: by 2002:adf:9d82:: with SMTP id p2mr6686484wre.234.1617241808102;
        Wed, 31 Mar 2021 18:50:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm8682603wry.90.2021.03.31.18.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:07 -0700 (PDT)
Message-Id: <11c38f7277c5217b13065ee4c53f6f94e1c6a7a9.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:49:43 +0000
Subject: [PATCH v2 06/25] checkout-index: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before we iterate over all cache entries, ensure that the index is not
sparse. This loop in checkout_all() might be safe to iterate over a
sparse index, but let's put this protection here until it can be
carefully tested.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/checkout-index.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 023e49e271c2..2c2936a9dae0 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -119,6 +119,8 @@ static void checkout_all(const char *prefix, int prefix_length)
 	int i, errs = 0;
 	struct cache_entry *last_ce = NULL;
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr ; i++) {
 		struct cache_entry *ce = active_cache[i];
 		if (ce_stage(ce) != checkout_stage
-- 
gitgitgadget


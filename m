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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEC9C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567D560EC0
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbhHCPfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 11:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbhHCPfm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 11:35:42 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB73C061798
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 08:35:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n12-20020a05600c3b8cb029025a67bbd40aso2042263wms.0
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XYj/cvfiez+VFwKHVolZX/cURqSRdpnPS4TgCLART1M=;
        b=I/xxa82SmnJ1rVooC2BCL8MJ6vj0Bfi3GiyDxzcFAcBQfSxTHih0lIFxtl5dfE1Df8
         cK7912kI0Zj6reUaMBCTa1uLWA+zOF3zneiTkS8pHyU83GOiC68mJsYL6EJe0Vnz+W8G
         eI7YqWz/baWXDb+7pRzAC7ln7Jz4/NTjEtS2T0nXWXbSOWnD9Uq1ZfA/3PfeCpqD0lxF
         JuG61mihSPcUy+3JNfnqtZkc2oTSf0AgCLtiGO9Rtd//ZMMJj6N6vqicAwsfWC73lqnp
         Ca5A/h3gCwU2uG0ArSvjf1QUZaG0HbEV6wmZwUgd+82VW5v+0x+7tYw2tYfPefaj0C0A
         42GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XYj/cvfiez+VFwKHVolZX/cURqSRdpnPS4TgCLART1M=;
        b=dkHslPeKukcLd2cuLtCxtGsNk376LPd9G8wD9xFAIn9NwlQNeoHtLM2IgL8qLEA+2v
         TWT4Qk0YiiYIY20HcDhAHvJ6TnVvBqIhxsWB59DF81d6ng306EDVZRBZaRv54MmSL6E6
         Ir9y5KEaVcu6HIiPLkVEIvphI4ZodRuVNfUufGKySGK8BkdPpweXSJFgJAhgaZ+poD/q
         aepYpzh3TSFbZ97FU+rjgVm7D5Nfls/rzVZc3qrVjW7YIuvSizX7RqhDs9BEtZmLIP9y
         EpqOB1tjA8mmRr+/AiepR6rv4HgQ+uJTA6rr0P9C7QEvKASD3zZqSZcFKoCfhfVZCd9H
         aEcw==
X-Gm-Message-State: AOAM530TP0Bv1ppi4XxxlLJIC7zL0fJDH7KYLWuntKXhkjMiMCsXN/am
        4MlyxKmT2SV83IpsQsC5f2X52GiKSEI=
X-Google-Smtp-Source: ABdhPJxD7UKtQVXnS2lwGPOpdKG95cSzNgM1SMUoEh2Eow87xKk5bVtAfDN3HmVQEO88RKxvmcCVJQ==
X-Received: by 2002:a1c:413:: with SMTP id 19mr22569321wme.74.1628004929999;
        Tue, 03 Aug 2021 08:35:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5sm2828963wmh.31.2021.08.03.08.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:35:29 -0700 (PDT)
Message-Id: <010702d08417f86da033ae8a6093ec4b9ce6e19a.1628004920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 15:35:18 +0000
Subject: [PATCH 08/10] merge-strategies.txt: fix simple capitalization error
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 7044afba362..b4429954480 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -530,7 +530,7 @@ The `--rebase-merges` mode is similar in spirit to the deprecated
 where commits can be reordered, inserted and dropped at will.
 +
 It is currently only possible to recreate the merge commits using the
-`recursive` merge strategy; Different merge strategies can be used only via
+`recursive` merge strategy; different merge strategies can be used only via
 explicit `exec git merge -s <strategy> [...]` commands.
 +
 See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
-- 
gitgitgadget


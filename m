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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B990C43603
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60DB664F9E
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbhCPVSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbhCPVRe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE386C061756
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v4so8174243wrp.13
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XMPrdigUaOwO/FCayQIwQRRb3YFmU5o6ymNPf3M0zIA=;
        b=DS8dcE2ONJxGwDz3kC3bibcRbNZsu7vJEeuUYolpMmjJFvP5OVutLleE1LXeXz0uRt
         8WGnhvDORhNiu8oeAcFJ1iSH77SEFKkV+IiHkNQo/7BG3zseHkuoNPChKmxDJkdSFhwu
         2TekvlwmYFWBkfYfjQFhqSHVtVYYSpKXMbmlWNQVoIWvnwSmmnDlRyMg1hVhfoucNmA8
         TYvGzvL4AOJe5aX89adAM0iH/WSsL1zVqK170T0U0HxiFcZcJinocXZm8/WFfl42qdUP
         jObM+L7tD89ncAWH4I2HGt2CjM93visQwLZ5s/0bOiWxQlmkybbEypw6OfvhqnhmBIBo
         oTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XMPrdigUaOwO/FCayQIwQRRb3YFmU5o6ymNPf3M0zIA=;
        b=NNXvasUEFnsVllMZzcTqtUwkWty9cDghqHGsxUzArQhTRh0XrV2vpoJuRWAKjNOtOC
         O1m8bUgkg2uIXjJ4CqDBAHXDtzI98NyZKfwBTVfPmfNT77ZTZbAatXI/UBR/gW8/hC5H
         Lk9Pp6prnQvgjIOqnzzV3Fd4b17TU7Fqn3l1yqbdCBqbUcB7y1vv3rtKkT/AcyFM8ozj
         a2f9Im5MXFnzbw8/5Lg2nOpkX32kYB4rnDSuf7BYwoEvJ0lnVJgs9QsC8t+kWFLcPAU5
         CIdMaUeGD1YIP2IGfnaq/wVmm4Y4YPAVm4m/as9iktnAo59wRpT0e43WKGsMsHGdVEfc
         VQWA==
X-Gm-Message-State: AOAM532VrOnSaqoxi8lwI0SepiRBY3BkKMsufcKCly52gBomxeWUXmyK
        37UyINW4cgSZ4cYPfYD92dZ2wcj/d8Y=
X-Google-Smtp-Source: ABdhPJw9Q4Cfy+F9e5g5ioAH6T0mIyvdQVdtvstS6zPgLbKKbzrZyxxQx5RMSO5xBLJI32pfweo25w==
X-Received: by 2002:a5d:44c5:: with SMTP id z5mr875503wrr.319.1615929441747;
        Tue, 16 Mar 2021 14:17:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f126sm528082wmf.17.2021.03.16.14.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:21 -0700 (PDT)
Message-Id: <bfa0164cc3c167e383cdb5405526202432ae624e.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:16:54 +0000
Subject: [PATCH 06/27] checkout-index: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
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
 builtin/checkout-index.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 023e49e271c2..ba31a036f193 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -119,6 +119,7 @@ static void checkout_all(const char *prefix, int prefix_length)
 	int i, errs = 0;
 	struct cache_entry *last_ce = NULL;
 
+	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr ; i++) {
 		struct cache_entry *ce = active_cache[i];
 		if (ce_stage(ce) != checkout_stage
-- 
gitgitgadget


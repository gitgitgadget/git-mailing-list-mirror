Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E657AC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 23:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C58A460EEA
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 23:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbhHBXX1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 19:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbhHBXX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 19:23:26 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986DCC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 16:23:15 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so959244wmq.2
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 16:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sRMkGQ9d48liM5p3XqWstj4cz8j7g/2tUl9I/WtyjK8=;
        b=MkXR7YTSqeRs3ZpUU3KRaNeCshjWhGsMewuN7c1XtUW/eNz9DYg7QiGJiawS31Bo8m
         L2r9h4Zj+VxpmkOTk0GL5Sxw2hd1HacrxsXn/n43BjPJ7MtcQSrxpCVPuvswrkuv/4Zu
         j9SsbzP0duRnIZJI8n/pl8VNFO61rLKu8lbx1cu1+Q5GYO1/RKIpudyV2jrOVEd6Cv46
         8x2SzKrtdfPFKrUXV165GNyKhd0RhfPbvCxYoMCqX2eT4UhFGZIc2iYKX2jSSvgPgi6a
         OVZMmUU5R7yMadKdkAzSayayxuve1f3QSUWWpvRMmdCQPpRB7mqxYD4Au6J0Ug61/SrL
         M99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sRMkGQ9d48liM5p3XqWstj4cz8j7g/2tUl9I/WtyjK8=;
        b=LCFF8L3V02kBKNDwhRSZXmdlwsXD8Sv+CrdFZU8PTlVLjHBLU/0OM+tGmuvXhcWoq6
         616kj/vFirBAkK1w7Q36UX6ccgEIyyY1sx7HlZU7Hh3E2EwfYO835g3LfU5m/pe6eDzu
         aIfSw8c+mZ2cSBEqdYib5XWmbmv2TIYSLbqumj71Dzm11wPiqGXn32jowfRmToWN/xwy
         nsHUJNHUIqBWXxBpqpkTiEe+jHzo2t2BTyUjfnAW3mC/abX8OOtxlzbqKnHDiZA1IX9I
         kYnP9iBQIOonWWluTM8OPJxo6b4ELyQL1O+N5+8klcpdKLgHnotSEaH6Ih8hXuHscsyW
         6+Lw==
X-Gm-Message-State: AOAM5326MyHIdASbv3v4LRTMEqKyUNiFMJsyzOmTvi/OuW6Zv3A9wNoB
        I1Uu/yNkw8BYaj1D31wfq0w+kdQOdhM=
X-Google-Smtp-Source: ABdhPJxnM2TIXfJxivoyu3cqluH9oiXhLgsh16D2cBrkCMcxyYhn3v6mdpM1MD5rDCIQV4jDBxcLWg==
X-Received: by 2002:a7b:c083:: with SMTP id r3mr5168663wmh.65.1627946594309;
        Mon, 02 Aug 2021 16:23:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b20sm9830398wmj.48.2021.08.02.16.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 16:23:13 -0700 (PDT)
Message-Id: <dd13a65ef0f648f13cc220303092a657148c19ac.1627946590.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com>
References: <pull.1006.v2.git.1627943914.gitgitgadget@gmail.com>
        <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com>
From:   "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 23:23:08 +0000
Subject: [PATCH v3 2/4] clone: update submodule.recurse in config when using
 --recurse-submodule
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Mahi Kolla <mahikolla@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mahi Kolla <mahikolla@google.com>

When running 'git clone --recurse-submodules', developers expect various other commands such as 'pull' and 'checkout' to also run recursively into submodules.The submitted code updates the 'submodule.recurse' config value to true when 'git clone' is run with the '--recurse-submodules' option.

Signed-off-by: Mahi Kolla <mahikolla@google.com>
---
 t/t5606-clone-options.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 3daef8c941f..69c4bacf52f 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -19,7 +19,7 @@ test_expect_success 'setup' '
 test_expect_success 'clone --recurse-submodules sets submodule.recurse=true' '
 
         git clone --recurse-submodules parent clone-rec-submodule &&
-        test_config_global submodule.recurse true 
+        git config submodule.recurse true
 
 '
 
-- 
gitgitgadget


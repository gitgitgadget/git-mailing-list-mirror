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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C0AC43214
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B2C460F9C
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhHBRaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 13:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbhHBRaF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 13:30:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70913C0613D5
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 10:29:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id p5so22375108wro.7
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 10:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sRMkGQ9d48liM5p3XqWstj4cz8j7g/2tUl9I/WtyjK8=;
        b=aM2//tLA6kOkhz8nPUKjzcHDKctrRholefAOvwR1sC8A5XaX6dpS0uQkFxQf+ljlIb
         2ar6KFFPrweMEVI3pSgqaWIKP5fkcGPcjTekoQc9wSbroIen1ILQT0o2wfDyfkXKw0x/
         /ImplsPU/PMmFv2ZwHz+amEAYwKxHpw09AwsGmlyrew5wEs12BMqESkw53uS2Y29/Mcd
         Io+S5USD2oHplaT8ge88epLKoydyB6JHhREZR/sJ+5jTxXzhzeWRlpEuN3hfTIEJx/Sr
         V6G9eISPVbiyRhsj+g1lIgzCfzMvoqgwcO7adY58Ven8NO1JuZAsyS4nx2o/gGV324rX
         RAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sRMkGQ9d48liM5p3XqWstj4cz8j7g/2tUl9I/WtyjK8=;
        b=CVwRYu6twE/isMbvjzHw0LFE42div6quaOyw6ASKPkp8T8Yyt3vVtzb4Sr5/BDKwRR
         2mYsiCF7zu92qQj+2Y/24eqwaZInxwaB+refNBIXkqNjbDifTjKzA8boY2spmyGVYor4
         QcditLni9UfhBWBQiiLMGiFtc6gpljbQ3extJqGHxrB7oXTMmZsFfS4AMp9XuotSqVWX
         k0j+HWbSbNCtMjv6EeN5IvZNXK0niHZzR2SIAk5fRqXL+AjHK5hMfGnSOh2ul41o37dH
         vT9UtYFbOBiXON9TBMDcmfY3Kt8ltlkE8jbd5C2nkShW3W2PCe0PwVkIFXJJQuqxiH1H
         NNyA==
X-Gm-Message-State: AOAM531/mL7B0YKgG1/CJjG/GUJwMMIC17KNfqVubhr1yB24cCjqAkjc
        XhrYrXtlSgLSn4Bm60sRjzRztIno1SM=
X-Google-Smtp-Source: ABdhPJwwXNkQRKi+djFYEelFNFgA/QTn8yZ10uI4Bl/93eVt3KXJlJujpw2Us+wifumtKXiOFLDMqQ==
X-Received: by 2002:adf:fd90:: with SMTP id d16mr19828575wrr.105.1627925393150;
        Mon, 02 Aug 2021 10:29:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm13944524wrr.27.2021.08.02.10.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 10:29:52 -0700 (PDT)
Message-Id: <dd13a65ef0f648f13cc220303092a657148c19ac.1627925390.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1006.git.1627925390.gitgitgadget@gmail.com>
References: <pull.1006.git.1627925390.gitgitgadget@gmail.com>
From:   "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 17:29:50 +0000
Subject: [PATCH 2/2] clone: update submodule.recurse in config when using
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

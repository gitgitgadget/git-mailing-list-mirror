Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70D3C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 18:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6265961153
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 18:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbhD0SN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 14:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbhD0SNz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 14:13:55 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ED7C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 11:13:12 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id i26so5221386oii.3
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 11:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0xLVzJW6tpgTqLm3Rzmfj7pXMsHTFEovDglCCl956KY=;
        b=NZZRGJqDyc8uWwPsayNpb5l0xGOMU9ggMau5Jj14J2A6dVilqW4vseu5234xVnapeD
         pzCm14LaFAB9MEpMgEX3rEjDX8dkhl+LR8qTelPe0EuSYYJGbpEFE9tqVs8eIr/jZ7eY
         2xx48CJSbiGHMzjUI8nVsD76rzDZdkyFKLssJSw6Uvkmfk6SA6OMVK88SzvlVzHKOlv+
         eW3weBwaiPK4ks6Hf5mvVi6+DrTf/b/GRBQXDHWYs1Ry6aaHq/AF34XlOhhNg8JCZ/sW
         IW49R24QcUB5pN0iwShPnCLCoa13LMBLZQMlPQOmjBrO5t731gX+deQUw7z8n9/M8jzp
         lHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0xLVzJW6tpgTqLm3Rzmfj7pXMsHTFEovDglCCl956KY=;
        b=ASdGOGqaKsc6uOoqVyg6aKf0cBxgWt0zoFJa4msJ2BVMBn8Bs40ILaS1b66rikLO1u
         9SPdM7TAOOOTiTdYgPRzgQ++PXz1FATEhXZlYucvOfn7tusN7aqLamo+AUnaDWV+c0nr
         YgNKI0zrf49sWnw/GWhvy11FUFKP0LS28Pjsmxnlye2aaEjBzeCfyWY9menqvSMPUNqU
         78dKGhZCfei/5zm6WK80PP5/x++GhFtlAQARegz/xxof4V2U3d4K1DL33zvAmcCUrl7r
         ffvk1EeIlIUJxx9y5HmK26M7rlNmoRANGAZMbCt2ylx6S9PUmyyOatpa7i8BAsyCFxQq
         3XEA==
X-Gm-Message-State: AOAM531l52yH2PFK7/iN2cdIdZ5EzYK8NGPgoF5Phn+ARZFEGnZsxAOL
        C/mjY/vq8h36cw2Kudq2JyY=
X-Google-Smtp-Source: ABdhPJxqHwZ8uZXgPioRCSRqUrXjLYnCtx4SKUbaGTvH0JmEoJE968iuX94jPm3SkGNQwb8XmHLBYg==
X-Received: by 2002:aca:f008:: with SMTP id o8mr17195613oih.106.1619547191090;
        Tue, 27 Apr 2021 11:13:11 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3839:9ece:547d:49e5? ([2600:1700:e72:80a0:3839:9ece:547d:49e5])
        by smtp.gmail.com with ESMTPSA id 68sm120749otc.54.2021.04.27.11.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 11:13:10 -0700 (PDT)
Subject: Re: [PATCH 14/23] fsmonitor-fs-listen-macos: add macos header files
 for FSEvent
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <67fa7c7b8ac79b05d0773dc0affbe39b77aa4893.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7da80a62-7820-3fb8-a0e9-4356d9ea597e@gmail.com>
Date:   Tue, 27 Apr 2021 14:13:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <67fa7c7b8ac79b05d0773dc0affbe39b77aa4893.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2021 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Include MacOS system declarations to allow us to use FSEvent and
> CoreFoundation APIs.  We need GCC and clang versions because of
> compiler and header file conflicts.
...
> This is a known problem and tracked in GCC's bug tracker:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93082
> 
> In the meantime, let's not block things and go the slightly ugly route
> of declaring/defining the FSEvents constants, data structures and
> functions that we need, so that we can avoid above-mentioned issue.
> 
> Let's do this _only_ for GCC, though, so that the CI/PR builds (which
> build both with clang and with GCC) can guarantee that we _are_ using
> the correct data types.

I appreciate that this issue with header files is isolated to its own
patch.

Thanks,
-Stolee


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C99EC433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 16:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F3B23A3A
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 16:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732150AbhAUQtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 11:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732314AbhAUP6e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 10:58:34 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40475C061756
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 07:56:34 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id q205so2553754oig.13
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 07:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZLUZ3EJc1uJbVo+QAoAg/8GcF05G5Xbx3i+HMCErVXc=;
        b=PnCC/gkOv5lSLBy0BgEhHsJl8pfKAYFm+tAmYnM+weexfJB6xiY410cUwOvVuPDOi2
         lNj32q2DOWhqIMCy+tZlfGHnTATFLn26d7MUUHAT+LJZkfc1S34CKcD8+q0Rk7Z+oUc1
         8ymUUSFiAfoJg246T3Z68QcLsJFQk1jYJacITHq0C5WMPQA0I2xWQFSshejGBXbdC2WS
         UutCu41zfoLWxiaI1FDK3WMvpIb7jjtNRaa6AyLFwXt+ZZR05W4qLpRwdOL6BoV4UE8X
         rbJ+1oIl2dhi3ogQWZS4QaCQteQOcf2p+76mt2Udq151j1Smt7Cw9hWPwJAqrPIx7w96
         7J+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZLUZ3EJc1uJbVo+QAoAg/8GcF05G5Xbx3i+HMCErVXc=;
        b=sL5gBAzYYxnz5+o1sdy2jZJ8Bbizd65w5RANn/nErMplTsaGofAXNw4KbK6hY0unPT
         NB63MSw2fuccEqELuTAWiPLZy8KFwqjPz4LiQ00MkNKWleJI5zNj9FDcwYsklSRMmY/N
         iUL9t7dvv+Uxpi+4c3gYbL00Zd/P9OAhpUhx1YedoV8CJa6CF5B8y8DGISVq5uYkoaTk
         6wvAhBU2R7jZXY6ba5LcGqu1NPL0IgpwcgEiVXjMtzkYBKBEP/XYK4s8iyMBumYykDEs
         Bi24qU7/rRuv1xUAfBToeMF4IVdZ0g4PwjBwTw4UpUGpFwu3stAMOMB41QW8LKMDbRiO
         hLUA==
X-Gm-Message-State: AOAM532C2ro1v5YgDdsg2wb64GTpXBaP7XZre3an5W5FMXeMVPkO+SNR
        ev0BlhUmdyi4Rc4ED/zGyB4=
X-Google-Smtp-Source: ABdhPJwdj+URR65PAvo5Xb2UdT39HdRIPRPTMC70cIJvXaDgJHj3PmmSPBbfZjH5SlALjtPpOZyAVQ==
X-Received: by 2002:aca:5285:: with SMTP id g127mr173506oib.74.1611244593501;
        Thu, 21 Jan 2021 07:56:33 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:34b6:33df:b7f8:7bad? ([2600:1700:e72:80a0:34b6:33df:b7f8:7bad])
        by smtp.gmail.com with UTF8SMTPSA id w66sm230728oif.21.2021.01.21.07.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 07:56:32 -0800 (PST)
Subject: Re: [PATCH 3/9] fsmonitor: de-duplicate BUG()s around dirty bits
To:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
 <838922de2e9756c00f4a159b2b8722ae4d28b011.1611161639.git.gitgitgadget@gmail.com>
 <CAPx1GveERs+g6zymyc8AbVudRHz24=N-1WZg+1xj5j1z0prWyg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <29dc3650-e23d-e283-ae82-69637ae6605e@gmail.com>
Date:   Thu, 21 Jan 2021 10:56:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CAPx1GveERs+g6zymyc8AbVudRHz24=N-1WZg+1xj5j1z0prWyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/21/2021 7:53 AM, Chris Torek wrote:
> On Wed, Jan 20, 2021 at 8:58 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The index has an fsmonitor_dirty bitmap that records which index entries
>> are "dirty" based on the response from the FSMonitor. If this bitmap
>> ever grows larger than the index, then there was an error in how it was
>> constructed, and it was probably a developer's bug.
> 
> Curious: some of the tests were >=, some were > (not >=).  Now
> that they're shared in a function they are all ">".
> 
> It's pretty clear that for size-based ones, greater-than is the
> right test, but for position ones, isn't it still greater-or-equal?  So
> perhaps the calls that pass an actual position should add 1...

That's a good point. I should pass "pos + 1" in the appropriate
places.

Thanks,
-Stolee

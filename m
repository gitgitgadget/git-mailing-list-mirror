Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEF6C433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 18:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8986A61100
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 18:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349799AbhIHSPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 14:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349791AbhIHSPO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 14:15:14 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661ADC06179A
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 11:14:05 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id u4so2701437qta.2
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Apae0yJuYSFuVB+GwfCjiStu02Fc0IJxd5fKl8X3GNs=;
        b=T8vhRarKl/bRbzWHKhNlimakm9clYUXDcl0SN0SXEwQ7X0FPXkY1qhbR+bfVMud5b6
         eSgLM/+y4l+L3ISSEw7+LO6x4g1ZqnTw+SAdT2FKD6i57n8IW0QIMEBPUT/gbZeuO4D8
         /h8Yv0d44MgKsQaXQSAKI8NxDBIWiYr3Fzdbak+dkN0y2dWScNIzBkItJJ22y4r5+vmw
         MaLQCUj3qxEpoEwF8bAmBmmFcZxDCwt2QmFD0xU9EF6BZL4w4c4rxYg1hPVw7ksW4XeF
         2c/IWomGtDPGa04ze+XJC2bEj5O3bsPxL1NxHp1jKxb7jTVeBklMRPgpg0wHmRHCum3k
         2M3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Apae0yJuYSFuVB+GwfCjiStu02Fc0IJxd5fKl8X3GNs=;
        b=U7gDXfUbbXOVGFTY7ZNdsLfFZEyPwFME6aLdu39w8uKzmn1TIrgg89H/Rm6VPUTQPg
         krKWCVCen9TxpNUIgmOSD19FrsalX5ZB8BTUC37ukjaKCBSYMP5jO58WC8W7AKxMcmsP
         iP86E8JJgA/u2yi40f4erv82dl/w+kaqzjjV1m5R/1M7+/W81sUB2pJLfQI+m1B+1h5h
         VFxieRnv03V9UqnuLzp0nxHgnUAWClk9M8Xs9SfH6siIGbd9hQltjgx8YKI5Og3+Iu4A
         23mJRVk1hF6W/AV2ApE42QA731d/LPbBg/KXK0eSd7zyqEr0GWyS5VuN2VwQ2wwycgnd
         Boqg==
X-Gm-Message-State: AOAM533TPueyeMNbxWrhaKCRrl9+rLU8kgM0muvawkCq+snmXD7ayill
        +UO0c5MZrxE5V65x7XKRcv16ghtRCUI6WA==
X-Google-Smtp-Source: ABdhPJxGBg1kZ/Ksmw/wFht4MH9rHTeVXotIWCQ6Ph0D0pynGeQbqv68KudF8rjO7XXPOILkiFpCjg==
X-Received: by 2002:ac8:1e05:: with SMTP id n5mr5061032qtl.151.1631124844602;
        Wed, 08 Sep 2021 11:14:04 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id k186sm2352887qkd.47.2021.09.08.11.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 11:14:04 -0700 (PDT)
Subject: Re: [PATCH 4/5] rebase -i: don't fork git checkout
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Emily Shaffer <emilyshaffer@google.com>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
 <39ad40c9297531a2d42b7263a1d41b1ecbc23c0a.1631108472.git.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <f05dc55f-a7e4-b8f7-7b0c-5000bf48f803@gmail.com>
Date:   Wed, 8 Sep 2021 14:14:03 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <39ad40c9297531a2d42b7263a1d41b1ecbc23c0a.1631108472.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 2021-09-08 à 09:41, Phillip Wood via GitGitGadget a écrit :
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> The "apply" based rebase has avoided forking git checkout since
> ac7f467fef ("builtin/rebase: support running "git rebase <upstream>"",
> 2018-08-07). The code that handles the checkout was moved into libgit
> by b309a97108 ("reset: extract reset_head() from rebase", 2020-04-07)
> so lets start using it for the "merge" based rebase as well. This
> opens the way for us to stop calling the post-checkout hook in the
> future.
> 

While in general I think it's a good thing to avoid forking, this change
might result in behavioral differences. Any config that affects
'git checkout' but not the internal 'reset.c::reset_head' function might
play a role in the rebase UX.

One that immediately came to mind is 'submodule.recurse'. This initial 'onto'
checkout was pretty much the only part of 'git rebase' that did something useful
for submodules, so it's kind of sad to see it regress. [That is, until someone
takes the time to implement 'git rebase --recurse-submodules' and makes sure *all*
code paths that touch the working tree pay attention to this flag, and that will
probably necessitate 'git merge --recurse-submodules' first because of the 'merge'
backend... as far as I'm aware it's on Emily's list [1], it's also on mine but
I don't know when I'll get the time.]

Anyway, I'm not saying that we should not do what this patch is proposing, but
I think caveats such as that should be documented in the commit message, and maybe
an audit of other configs that might results in behavioural differences should be done.

Thanks,

Philippe.

[1] https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/t/#m0229af9183a84c2367f21e82adfbd21f08aa4437

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618A1C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 21:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E2960FDB
	for <git@archiver.kernel.org>; Fri, 14 May 2021 21:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhENVGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 17:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhENVGH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 17:06:07 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B37AC061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 14:04:17 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so430941otg.2
        for <git@vger.kernel.org>; Fri, 14 May 2021 14:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZB5fsZ8puulF1yAL1Xu8vTIOXmSTUBdiGsNWJcOfoVc=;
        b=stMIN08KFAjpX2mZbfEPANyyWalDde/zSRTxe0xwgcnTF1afB47mMnLnTPKtcyJCAd
         X3XVid6sYrib56K1Afu70ExvaX6TjqkG7M8E4gthh3eapLEzBLZF2QunPXTu7SGPs7kR
         RZ7VytsexGx9GIN1ehYfJvredfBM5B6Oz2Lk3UenfgkQguK4ps8nuIUMkQyILA5xWBHH
         8BK9CJ7Kiqh3hVZWH4wnfJVbWL2P/Wc6fXx8tFtQxOnIVjXo36ZWEii0pUOwwOsCyVP4
         CVryizVUO7Xp9++fgGihTi1D/fYFcf2rlxXC1G+cBT88V1MZV9pXfEQobU/T3I93Bhan
         Zgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZB5fsZ8puulF1yAL1Xu8vTIOXmSTUBdiGsNWJcOfoVc=;
        b=MoqvIxWO75RxC6MMXUpFYTbPFJl0bpdF0hGqIzyCX/N6bkLhWYG9X5T5ZhoPNArxKQ
         ZIzRqwv3Oz9Bn3PHllmVVCjSl6S3IU7lrUobr/CX43B09JGfTSV3UMQMgoe9s7M7Lmr9
         TSASbpHox6ShfUyza60Ykpylf25tVMcEYrxnRmmtE74Rc0HkZ9/KqK3sClex0sJmd4lJ
         abCSdTp508tPnUIWdJfrJocbZtUOQx91mVHMy3+FYCPNf/F6Zx21SWeOxsLg/OL1N9YQ
         1o60W1uAynQWDkCRRd2+a7Debk8A8wfOMNjIcgcNNuxIjwD/STCtXUzSPTo7nriNj2hJ
         w6oQ==
X-Gm-Message-State: AOAM530bcHRDtEmnIMPAzvyij6QMnCyTYIiOUzjQyuDLIRxOavSRsv4e
        b0ojifmYDE4GzwERMqYKNvE=
X-Google-Smtp-Source: ABdhPJyfJt42ySSCwSE0wCQ/A3esgROhezVYeuahJQ4bfoqqTimaC3LqNPq9GTa6ubpQIf4qk5RyTw==
X-Received: by 2002:a9d:7f1a:: with SMTP id j26mr40682082otq.244.1621026256315;
        Fri, 14 May 2021 14:04:16 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:6c05:727e:b905:fa7e? ([2600:1700:e72:80a0:6c05:727e:b905:fa7e])
        by smtp.gmail.com with ESMTPSA id i130sm1412575oif.49.2021.05.14.14.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 14:04:15 -0700 (PDT)
Subject: Re: [PATCH v2 00/13] Optimization batch 11: avoid repeatedly
 detecting same renames
To:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
 <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
 <CABPp-BGz-SGzbHAHOOjjo5FCBOgYehR0qa_rEn3saOw2gXt86g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <36465338-3c3c-c861-648c-711c3106a828@gmail.com>
Date:   Fri, 14 May 2021 17:04:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BGz-SGzbHAHOOjjo5FCBOgYehR0qa_rEn3saOw2gXt86g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/14/2021 1:37 PM, Elijah Newren wrote:
> On Mon, May 3, 2021 at 7:12 PM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> This series avoids repeatedly detecting the same renames in a sequence of
>> merges such as a rebase or cherry-pick of several commits. It's
>> unfortunately become a bit lengthy, but much of the length (the first five
>> patches) is owed to special testcases and documentation.
> 
> Since this obviously hasn't inspired much review, let me note that you
> can cut out 90% of the review size by skipping patches 2 & 5.
> 
> Patch 2 is essentially written as something approaching a formal
> proof, so yes it's dense and lengthy, but it's not at all required;
> there's no code there.  Think of it as insurance for if someone wants
> to introduce some new tricky optimizations or radically different
> features to the merge machinery, because the remember-renames
> optimization by its nature tends to interact with other optimizations.
> I figured because of that interaction that documenting why and how the
> remember renames optimization works at a much deeper level than is
> typical for optimizations or code in git in general that it might help
> with future maintenance...and it happened to help me catch two minor
> bugs.
> 
> Patch 5 is very much related to patch 2; it's testcases inspired by
> that document.  Most of those tests were just "what could possibly go
> wrong in a new from-scratch implementation of this optimization?"
> based on what's written in this proof-like document.  Most of the
> tests didn't turn up anything, but a couple found some small issues in
> my implementation.  I decided to just include all of them; it's nice
> to be thorough.
> 
> You can get 95% of the whole idea behind this optimization skipping
> those patches and reading Junio's great two-paragraph summary at
> https://lore.kernel.org/git/xmqqzgyrukic.fsf@gitster.g/, and then just
> read the other patches in this series.

Sorry, yes. I've been reading this a bit but haven't commented yet.

Patch 2 was enlightening and I appreciate the attention to detail
there. The overall argument made sense to me.

I can promise a completed review on Monday.

-Stolee

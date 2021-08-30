Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05726C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D388360F5C
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238050AbhH3RT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 13:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhH3RTz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 13:19:55 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD56AC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 10:18:57 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id n27so21123097oij.0
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sc2AMgfy+Ebmk/mxIPL5nQvKJBCWO6jhV9vOHQyMq1o=;
        b=fXuT2sIvPCbpQQVuqzvNzY0+W2VcZuvMz23T9igy9099PXZs/9SD6zj/ZkcWb6zG2l
         iulrWCXHcFcfW7bKgc7sO/HwCBk0kOi8CW1yNcJyZWd/yi/EiIGOZve6mbXnoXe9eknw
         UO7F/ycaJOwSV4nzp/xYPnP7HNnli8Q5Gd1GyoH+5RAQ1Zx1Xe1GnD6yjr1TXsyO3DS1
         qPMSpruOhG3r9gWoUC7LscqHNRw6i4nVv7VdagijTPf/3Nj49YOkj/f7BTOsjH5cZuHL
         GdNOpD7Dn+8pyPBOoEcdZ37IAX5CGnd9nXLjQXVCyKpQb8Kk5Lo7K+6tNTXnaOB32l8s
         Iaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sc2AMgfy+Ebmk/mxIPL5nQvKJBCWO6jhV9vOHQyMq1o=;
        b=ICFZVYiKEZupga/9i1yaWhbeQfme7GW9rS1DVYS7aasnux0oWEUunsvubEy7wP5JDV
         N6XWwRmd4L44pmI4pXLdHuN4P/vvgIBSn+CN1VJ9CkAcvcKHbTAqAdlouKixTxheWSbW
         GNGqW3SZ4U2gptxN2KdMa3BLZp4L+s7geeGkk4eqHI1cmdP9LOJfsiak9RkTeVaSwwef
         +TDnpXoQ8Y7FPuBH1vXx9ux8y5zDutij4+3z1idQxz7iZgoQiztCIsB234fYOVx9qbcW
         lj12gNF/DYImQCxenxci8zqMDX9XIINKtdMtGwcx/BsiPb7M8sSrnyp7JDVA5d4TX0Ml
         hXOA==
X-Gm-Message-State: AOAM532PwPa/roOA+jHxbszy3fjHP0siqUsl7KLB6SXZm+ymJWgXL/y4
        MdbGzlGcPOxujmuCnz86XIfEaeMvdZQ=
X-Google-Smtp-Source: ABdhPJw48sYKOyxICCXheBGmNmzvmVO5/T56itqENkj6HSyYoK5vK4qHrJFBBGtwQjBKBu/6OPTD8w==
X-Received: by 2002:a54:488c:: with SMTP id r12mr103562oic.115.1630343937033;
        Mon, 30 Aug 2021 10:18:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e4d6:1362:a8d2:be4e? ([2600:1700:e72:80a0:e4d6:1362:a8d2:be4e])
        by smtp.gmail.com with ESMTPSA id t21sm3289219otl.67.2021.08.30.10.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 10:18:56 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] merge: make sparse-aware with ORT
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
 <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
 <bb150483bcfd0469cd88bab735bc1178fb6628f5.1629841966.git.gitgitgadget@gmail.com>
 <CABPp-BEF0htk-Q-+wiF+XgTWRRtDc5FPJKauWZAivLGuMgWeAQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e8a875aa-181f-e71f-55ee-012edccf7ecb@gmail.com>
Date:   Mon, 30 Aug 2021 13:18:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEF0htk-Q-+wiF+XgTWRRtDc5FPJKauWZAivLGuMgWeAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/27/2021 6:43 PM, Elijah Newren wrote:
> On Tue, Aug 24, 2021 at 2:52 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
...
>> +       /*
>> +        * We are in a conflicted state. These conflicts might be inside
>> +        * sparse-directory entries, so expand the index preemtively.
> 
> Same typo I pointed out in v1.

Sorry, this comment is edited in a later patch and I fixed it there. Will
fix here, too.

>> +       ensure_not_expanded checkout -f update-deep &&
>> +       (
>> +               sane_unset GIT_TEST_MERGE_ALGORITHM &&
>> +               git -C sparse-index config pull.twohead ort &&
>> +               ensure_not_expanded merge -m merge update-folder1 &&
>> +               ensure_not_expanded merge -m merge update-folder2
>> +       )
>>  '
> 
> Should you use test_config rather than git config here?

That's a better pattern. It's not technically _required_ for these
tests because the repositories are completely rewritten at the start
of each new test, but it's best to be a good example.

> More importantly, why the subshell and unsetting of
> GIT_TEST_MERGE_ALGORITHM and the special worrying about pull.twohead?
> Wouldn't it be simpler to just set GIT_TEST_MERGE_ALGORITHM=ort,
> perhaps at the beginning of the file?
 
I don't set GIT_TEST_MERGE_ALGORITHM at the beginning of the file so
the rest of the tests are covered with both 'ort' and 'recursive' in
the CI test suite.

Using the config more carefully matches how I expect the 'ort'
strategy to be specified in practice (very temporarily, as it will
soon be the default).

Thanks,
-Stolee

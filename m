Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE1FC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 14:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A32B61175
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 14:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbhGLOtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 10:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhGLOtX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 10:49:23 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED9BC0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 07:46:34 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id p12-20020a05683019ccb02904b7e9d93563so7029337otp.13
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 07:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NWo5LXrZDGbZPIAiyiVsO6TigYhEAlM2Q+i0pJ0xISA=;
        b=kDuQ/iKlVrcVfeioEDrjkkxTkZU/BU2fUKi4dRKrRKa3HlCPSOI59JBYWduo7rVKHr
         /sxH9TsE0HG+M/y1Wt3xlWoe2a1GCZTGNFlLoHzq+q6rI3E8hrJD/oWPjfRHJEFEoOvM
         stpb8opolk2fNSajV2C3NAMi+6tPOAEoHXJ1K+Dxtg+Jx0iKC59XGp1vzAprFFWx+1U7
         pLpApP5MU/goGj7TjL2RJFK3ilkqK0UhPfcIowGLW1VPbcAWQ4PQkqVkoM8JKHWS5N01
         j195e+XU1SQRIUntpbQuvq9r+eDtH+QEaxDVsSVew7ziv+yR21F2dJl/SpikY8IrCoko
         yUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NWo5LXrZDGbZPIAiyiVsO6TigYhEAlM2Q+i0pJ0xISA=;
        b=ihhJdEKEM5MTHLh7Vk7NlhQaa9jDVX1SSRTuUYuMOYU+Fv2Z35rxxtQ+CyX8T8SpCZ
         RRKyU0+QDwnltPboIS2I1n//Ngtbf7RJlYAJ7lA9xUYaMZHRJN3oarHJcNnDgGaO/Tte
         Qz+dNmR20K5KWdHJ+sl5GtL4rIeDfUqr+0M5OFXUHIMgTxi3M7Xlmvgoh+X/4cW5yASc
         Xop0ayJW9R4s2FvgSk01PO0bFIGcgQpTbJREucpE1CuHhreWqaRjNcYo9se/GTjj2wTS
         DnYOSCuebRTvuaFrc71uI0h5udRT13wvJjFTa6/6FU77Srwo5njn9SarCde3D8lzvctp
         59Hw==
X-Gm-Message-State: AOAM532KmN1RHkhtAtAocZRUPiQKS85hJ9fGWBJKp4iZjVsbq8WUKhCy
        IpU/9wR8btGfF/MabwsHbbs=
X-Google-Smtp-Source: ABdhPJyu1Ou8qjSmbvbuFnkagusNMn45JperuznAY64lugmoPODILdd9QMcJzVxicmGyq+jN6ryw4w==
X-Received: by 2002:a9d:6b03:: with SMTP id g3mr4126413otp.187.1626101193691;
        Mon, 12 Jul 2021 07:46:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:91f8:61a:4701:b6c? ([2600:1700:e72:80a0:91f8:61a:4701:b6c])
        by smtp.gmail.com with ESMTPSA id i18sm109664oik.3.2021.07.12.07.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 07:46:33 -0700 (PDT)
Subject: Re: [PATCH v7 00/16] Sparse-index: integrate with status
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
 <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
 <CABPp-BHqoJjF9f6NKZ8jjQdj1bgUNgrwek5jcnGTRk2m-m8dBg@mail.gmail.com>
 <CABPp-BF2BLQm6864m+esquJ7og3fWHvTZeX_R-y4pnx9ApZ6XA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6cdb4ba8-fe85-2a65-8e6c-74d3b5c3ef96@gmail.com>
Date:   Mon, 12 Jul 2021 10:46:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BF2BLQm6864m+esquJ7og3fWHvTZeX_R-y4pnx9ApZ6XA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/8/2021 9:16 PM, Elijah Newren wrote:
> On Wed, Jun 30, 2021 at 7:32 AM Elijah Newren <newren@gmail.com> wrote:
>>
>> On Mon, Jun 28, 2021 at 7:04 PM Derrick Stolee via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>>
>>> This is the first "payoff" series in the sparse-index work. It makes 'git
>>> status' very fast when a sparse-index is enabled on a repository with
>>> cone-mode sparse-checkout (and a small populated set).
>>>
> ...
>>> Because the range-diff is a big difficult to read this time, I'll break the
>>> changes down on a patch-by-patch basis.
> 
> Thanks for doing this; it was helpful.
> 
>> This is SUPER exciting.  I've only read the cover letter, but it
>> strongly suggests you've not only handled all my feedback in previous
>> rounds, but got things pretty solidly nailed away.  I'll try to make
>> some time to go over it all soon.
> 
> You have indeed addressed nearly all my feedback in previous rounds,
> and I found few problems with all the new code in this round.
> Overall, this round is looking really good, though there are a couple
> things I called out in comments on individual patches that I'll
> summarize here:

This summary is nice. I will try to do a similar thing myself
in the future.

> Patch 9: a few minor suggestions for improving comments

Done.

> Patch 10: the new code is never triggered and probably should either
> be dropped or made part of a later series if the later series needs
> it.  Also, although it doesn't necessarily need to hold up this
> series, I found a bug affecting sparse-checkouts with or without
> sparse-index while trying to understand this patch.

I checked and this patch is not necessary until the next series,
so I will move it to that one.

> Patch 12: the code was slightly confusing to me, but I found that
> there seems to be an invariant it is based upon.  Adding an assert
> with a comment or just a comment about this invariant might help make
> the code more readable.

The assert() plus a better comment makes this patch cleaner.

> Patch 15: since the new tests in t1092 are written to compare
> sparse-checkout and sparse-index, it seems we should investigate a bug
> where the testsuite commands we invoke are giving incorrect behavior
> in both sparse-checkout and sparse-index.

I have made a note in an internal tracker to follow-up on this
along with some other behavior things that currently exist in
sparse-checkout as they should be pursued in a separate series.

I'm not ignoring your comments, but I would like to keep these
patches that change the underlying data structure from being
conflated with behavior changes. The fact that I am discovering
(and documenting in tests) the changes is only highlighting that
they already exist.

Thanks,
-Stolee

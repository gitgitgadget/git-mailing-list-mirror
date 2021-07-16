Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3E0C636CE
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 13:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A03561407
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 13:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240351AbhGPOC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240313AbhGPOCU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:02:20 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB86C061766
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 06:59:25 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id z1so8393916ils.0
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 06:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jOdNJxtOiDcIZVn41+tzQLmC0eb54UMSJYR0WxlOfXQ=;
        b=GunqIbILG2OxgiGN2iMJle8tdZea/6rZppGoDl4zrruueD+BEBxBCw4F21UJPKnI/h
         k6DCWcimVwHL3rAo5DZ0zbBpxqI2vGqPux0pC4Xgrwwert+vwS0lahBwRuqTXTxCFpo2
         2j3nMjIFF18FAVN+Bx1qd5ft7rWFIhqLFX4CCJrqizlnmOOloCYHbPtYpdRekGEkGNaa
         /JWVo2s/HVa30Lcj4xcxhZ/cg6jfEqA0jZNyPa6LviWmnH+LC//UFIJW6/bwJVUpBfqm
         zSz8VNV+xwiorHIiOhW73kTqpOZS3EtxNTvwm44gKTb/B/xxOtlL2tA+3669LS+G1aiv
         Y4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jOdNJxtOiDcIZVn41+tzQLmC0eb54UMSJYR0WxlOfXQ=;
        b=oGtUJQEaEtFHcnzhQHA2+XrJUJbl91BilIraleJ+CyiYHtOhBQLeSjoKSkfjuPVcX3
         mrEkYsNaw1U2Z8BiTfTUKSH3SfGCG6nRl8NATeZGbH94x7CEeYuGL59eWOqgZyPA3v4f
         xkHKh1yvZmdmHQHGaxXBQyomI9c1lOngnWD5ePYQ2OxuFlmf2vZYCOnO0XT0QUyDcrg3
         VVBq6CIoB4NWOl24o8IlzIhT7KQtgsMaEaYaFA6TK1Hujk15UlwNGRFoAiV5v7oybD4N
         cq2mTL6T9+P6/7loxJooB73PJ9Y6LINQ/ekezqaWCu0LYby5REStGAxRc3NO3UocZ9ZX
         /tzg==
X-Gm-Message-State: AOAM5311GjyBoCA41R87vdmF98adEbTrGzj8Yq6K2RveUfuIOpfRQ9zz
        DWyLeFh9P8pWWlgMCDWJwwA=
X-Google-Smtp-Source: ABdhPJyRNTYju29xBPWldlIS5d7I/ES69/91Lz4XRW/6V99KNtVTNygCxPR+VmeGUb+uZEzHX/bTog==
X-Received: by 2002:a92:c150:: with SMTP id b16mr6475696ilh.54.1626443963368;
        Fri, 16 Jul 2021 06:59:23 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:65b0:b974:e7b0:818c? ([2600:1700:e72:80a0:65b0:b974:e7b0:818c])
        by smtp.gmail.com with ESMTPSA id k21sm5251882ios.0.2021.07.16.06.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 06:59:22 -0700 (PDT)
Subject: Re: [PATCH 0/5] Sparse index: integrate with commit and checkout
From:   Derrick Stolee <stolee@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.973.git.1624932786.gitgitgadget@gmail.com>
 <CABPp-BF_i1QRCXaeKzqoc6Q2=3un-wku7aKUEdBbXfeVfTG8xg@mail.gmail.com>
 <b362c428-eec9-39e3-55a0-0738431e1d98@gmail.com>
Message-ID: <c127ceed-10fd-9ad0-e858-db79bec0cf8d@gmail.com>
Date:   Fri, 16 Jul 2021 09:59:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b362c428-eec9-39e3-55a0-0738431e1d98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/12/2021 2:46 PM, Derrick Stolee wrote:
> On 7/9/2021 5:26 PM, Elijah Newren wrote:
>> On Mon, Jun 28, 2021 at 7:13 PM Derrick Stolee via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>>
...
> This is a strange case in that we have a staged tree that is
> outside of the sparse-checkout cone. When running the 'git
> checkout df-conflict' command, the twoway_merge() method
> receives the following values:
> 
>  current: "folder1/" (tree OID)
>  oldtree: "" (NULL OID)
>  newtree: "folder1" (blob OID)
> 
> Is this value for 'oldtree' correct? It seems strange to me,
> so I'll look further into it.

This is correct. This 'oldtree' entry is actually the o->df_conflict
placeholder and is set to NULL inside the method.

> Further, I expect it to be simpler to modify the behavior
> here to match the full checkout case than to make the
> sparse-index case match the normal sparse-checkout case.
> The "natural" thing would be to keep the staged "folder1/"
> directory, but that would present as adding all contained
> content, not just the single staged entry.
Taking a closer look at the full checkout case, I discovered that the
'git checkout df-conflict' command succeeds in the full checkout case if I
apply it directly to the 'master' branch. In that situation, it completely
removes the staged change to folder1/edited-content! This seems like
incorrect behavior, and has nothing to do with the sparse-checkout feature.

It just happens that a sparse-checkout will have a _different_ kind of
incorrect behavior!

However, when adding the test on top of the ds/status-with-sparse-index
branch, the full checkout case matches the sparse-checkout! I bisected
this to the additions of files adjacent to folder1/ (folder1. folder1-,
etc) in e669ffb (t1092: expand repository data shape, 2021-07-14). If I
switch the test to conflict on folder2, then I get the strange behavior
that I was noticing on 'master'.

Some very subtle things are going on here, and they don't necessarily
involve the sparse index. Adding the sparse index to the mix creates a
third incorrect behavior to this already-broken case.

If we agree that the correct thing to do here is to reject the merge and
fail the command, then I can start working on making that change in
isolation (because _none_ of the existing behaviors are correct).

That leaves a question as to whether we should hold up this series for
that reason, or if I should pursue a fix to this kind of conflict as a
forward fix on top of it. What do you think, Elijah and Junio?

Thanks,
-Stolee

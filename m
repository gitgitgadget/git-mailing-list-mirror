Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C771C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 13:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 144276056B
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 13:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbhH3NfI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 09:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236797AbhH3NfE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 09:35:04 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086C3C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 06:34:11 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso18348936ota.8
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 06:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0piPsEsXiHY3QPkE690o6A7X2iBTjs1KIQloTQ5BIwg=;
        b=BbLzx6jotYQ1irTKtGWC8zaiPpMloKmmNtblpZEh0ZzfPJu08wrgsHGarWMo4e3P4s
         pwf7uaJxH0b/jeo8iBRZMHxq6jEaaha4EZQ1DDl2bV2l5aIGp7vdhKRwK2t5gfxDFZd9
         oKPDu5EFSn8qnESpfkLZkkKkcHU6iC2NvzTKGoQNN9Nzg8LxqKL1HuLaVgdRkf2JQbcp
         7e+rKdcYs5vbbZxDdilrrVFRGUbdVLaQcshEAryKjld6v4Q+ev6qfLgLp77cp9gLTvfo
         Q0ez72VABjB7QregKxOp/zWQoezFNP4NySjEdy8xTdU5amG1zqLJvsNUMfNukr0pImim
         yONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0piPsEsXiHY3QPkE690o6A7X2iBTjs1KIQloTQ5BIwg=;
        b=Q1AVRKygbho9MPJLQ47c6KM2BpXJSXwPcM+ouPZV3Cv415iFjFcdA2yCeeR5KEon/1
         fcLPUcHRMUHNReb465JHTO3mTqpcRxkn+suLL2FDypGlBep/05ztEYmkme51z7Z1WAk+
         ZnaC/mAabjtPbVV/Z4OKqBNmC6+mmy8/d6x6pbt942ZXL9VE+1+L30coRYpnptbkLaE0
         eAyPTDJjQrYWICtmvdZ47bLipl5N5iH3HsI7wvlHvO6VV2Rz9sqtPVUJ8kkm3SwooHgM
         eDCGmA8nzo7rUX+FK6p8n9PIsgyTbXYtemNJc26sxaluFFJCRqLVwSafAbdXI9wXgZVg
         Oimg==
X-Gm-Message-State: AOAM533rnZEVXLWFrFqDiPdwL50+BsXRcwCQWF3GnT+jgHJVKQburTlF
        gtV9+J1MJFpNL1nZ+2/Fry/xOVQYd4s=
X-Google-Smtp-Source: ABdhPJwsEJ8JiVS8yA8UiMIaiTyXvw7jkqgzsvdOTcE6f4lHYVEI/WT63DDU/6dyEOuwqjMvB16x7Q==
X-Received: by 2002:a9d:72c1:: with SMTP id d1mr13258722otk.290.1630330450294;
        Mon, 30 Aug 2021 06:34:10 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f479:1655:2af5:7e8e? ([2600:1700:e72:80a0:f479:1655:2af5:7e8e])
        by smtp.gmail.com with ESMTPSA id d10sm2998124ooj.24.2021.08.30.06.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 06:34:09 -0700 (PDT)
Subject: Re: [PATCH v4 00/10] Sparse index: delete ignored files outside
 sparse cone
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
 <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
 <CABPp-BG01tXnd_UhYJDX4Tm_EcXGju9CkB8BXU0XS-YAWEuaeQ@mail.gmail.com>
 <CABPp-BH2+Vq4gLnOyRg4AdNhZgZuFf5+XBW6JMmSzGxoppEctA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9b4adc13-d362-455f-60f6-fe7d16608ae6@gmail.com>
Date:   Mon, 30 Aug 2021 09:34:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BH2+Vq4gLnOyRg4AdNhZgZuFf5+XBW6JMmSzGxoppEctA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/27/2021 6:01 PM, Elijah Newren wrote:
> Sorry, one more thing...
> 
> On Fri, Aug 27, 2021 at 2:56 PM Elijah Newren <newren@gmail.com> wrote:
>>
>> On Tue, Aug 24, 2021 at 2:51 PM Derrick Stolee via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
> 
>>>   8:  febef675f05 !  9:  c19d93ec5d7 sparse-checkout: clear tracked sparse dirs
>>>      @@ Commit message
>>>           the sparse directory. This depends on the indexed version of the file,
>>>           so the sparse directory must be expanded.
>>>
>>>      +    We must take special care to look for untracked, non-ignored files in
>>>      +    these directories before deleting them. We do not want to delete any
>>>      +    meaningful work that the users were doing in those directories and
>>>      +    perhaps forgot to add and commit before switching sparse-checkout
>>>      +    definitions. Since those untracked files might be code files that
>>>      +    generated ignored build output, also do not delete any ignored files
>>>      +    from these directories in that case. The users can recover their state
>>>      +    by resetting their sparse-checkout definition to include that directory
>>>      +    and continue. Alternatively, they can see the warning that is presented
>>>      +    and delete the directory themselves to regain the performance they
>>>      +    expect.
> 
> Will deleting the directory regain the performance they expect, or is
> another step needed?  In other worse, will the sparsification of the
> paths under the no-longer-needed directory into a sparse directory
> entry just happen automatically as part of some other command like
> commit/add, or do they need to manually run `git sparse-checkout
> reapply`?

If the directory is gone, then their performance returns to as they
expect, since the next Git command will not need to expand the index
to detect the difference between tracked, untracked, and ignored files
within the sparse directory.

(Recall that the index is stored as sparse even if it expands to a
full one in-memory during execution.)

Thanks,
-Stolee

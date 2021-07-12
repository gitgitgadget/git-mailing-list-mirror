Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B03CC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 19:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E730261221
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 19:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhGLTog (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 15:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbhGLTof (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 15:44:35 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B2AC0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 12:41:46 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id z3so24989137oib.9
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 12:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E9sK6VGbiO/MI6i/PyiCvXyzR+FUUACs8I0k2helfyE=;
        b=gS1zX3Fb2QM7Db0aKUJL4PeOdhucp0VBGKprF+WwcJSAAGziVAINQe9iKYf1vb3hSA
         8qwuIGvRVVT6yL8FYrU89Q+1Ixk6/LYd9y0GRoJliW7A/wqRdjDPKvszwTAGyf7Jefjx
         Fcc+jTeCk41CAWK/8DpDYr0qraxHniliFGMzmoT29m+3Neg7mSiodTgo3ny7mCZqvgru
         Dg4UBYTKdjsP8q4kHFhbMdx0xJU4KM14AMooLRa4gt606BkMeYOqxaaoD1EQQwQsvgNX
         kclKPYCGn9VHuyFZPQQ8fkcBhAkkkQgPTD45MJh82sRJJ++APciB9XRNW5Nd2fPPOATD
         PHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E9sK6VGbiO/MI6i/PyiCvXyzR+FUUACs8I0k2helfyE=;
        b=tVBXTw2miSqhlHh5th87Q3zG9E3ENXCUj53wQPoxnsy3eRLEgXRVS7wgWphRnWWIyr
         aVWpmIhBWeS7ss1VQFBUFu1cEKEkci2Uy2Xjm5X4KNVWmol1wYb7XRPVn8YcjF4coiz1
         /Wbk2b5DM0nUOyR7VgbbN8cfMPm5k+t7v+42SDQJzuPkPX0Ng6On2TelQJkfDP6d7kw+
         /WQCTvVe8IpxEPOuuUY1NNpoIuxRw5YmxbBpToVh77V1DeqX/W6wq3SNbQm/x0XSTAeU
         CPfJEQgkpGlBfjJwEJtLD+grobwww5K+R6B2sxuW0FKReTLx+Pj7jz0ytZIOM1pz835K
         aA7A==
X-Gm-Message-State: AOAM530hXeXDPEmglZ7NCQjoSYvwkQ58eqatkRXvNh8hWxQmBqRy9BYF
        XajaTbnC1lYybnLOeBGWqQA=
X-Google-Smtp-Source: ABdhPJzMr6PcWQhgQCuLUSRj/BuJ0Km0Hzu5hfvf7nKT/i74MIogiBJp154DM/FjMsitbBQ8NQzjkQ==
X-Received: by 2002:aca:d601:: with SMTP id n1mr5057308oig.35.1626118906086;
        Mon, 12 Jul 2021 12:41:46 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:91f8:61a:4701:b6c? ([2600:1700:e72:80a0:91f8:61a:4701:b6c])
        by smtp.gmail.com with ESMTPSA id q26sm3250997oiw.25.2021.07.12.12.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 12:41:45 -0700 (PDT)
Subject: Re: [PATCH v7 15/16] wt-status: expand added sparse directory entries
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
 <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
 <717a3f49f97753149d5c435a83b3f1773dd4b1bb.1624932294.git.gitgitgadget@gmail.com>
 <CABPp-BE=qw9pO89hggUFbu=eovfL=7Os5BY8DZNd5Z=qU==wFg@mail.gmail.com>
 <3cf96b5f-3a8d-c00c-5d9e-c7095c058059@gmail.com>
 <CABPp-BGJ+LTubgS=zvGJjk3kgyfW-7UFEa=qg-0mdyrY32j0pQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d5b6f7c0-4837-45a0-5fab-68fd321e21ff@gmail.com>
Date:   Mon, 12 Jul 2021 15:41:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGJ+LTubgS=zvGJjk3kgyfW-7UFEa=qg-0mdyrY32j0pQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/12/2021 3:32 PM, Elijah Newren wrote:
> On Mon, Jul 12, 2021 at 6:56 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 7/8/2021 9:03 PM, Elijah Newren wrote:
>>> On Mon, Jun 28, 2021 at 7:05 PM Derrick Stolee via GitGitGadget
>>> <gitgitgadget@gmail.com> wrote:
>> ...
>>>> +test_expect_success 'reset mixed and checkout orphan' '
>>>> +       init_repos &&
>>>> +
>>>> +       test_all_match git checkout rename-out-to-in &&
>>>> +
>>>> +       # Sparse checkouts do not agree with full checkouts about
>>>> +       # how to report a directory/file conflict during a reset.
>>>> +       # This command would fail with test_all_match because the
>>>> +       # full checkout reports "T folder1/0/1" while a sparse
>>>> +       # checkout reports "D folder1/0/1". This matches because
>>>> +       # the sparse checkouts skip "adding" the other side of
>>>> +       # the conflict.
>>>
>>> The same issue I highlighted last time is still present.  If you
>>> insert an "exit 1" right here, then run
>>>     ./t1092-sparse-checkout-compatibility.sh --ver --imm -x
>>> until it stops, then
>>>     cd t/trash directory.t1092-sparse-checkout-compatibility/sparse-checkout
>>>     git ls-files -t | grep folder  # Note the files that are sparse
>>>     git reset --mixed HEAD~1
>>>     git ls-files -t | grep folder  # Note the files that are sparse --
>>> there are some that aren't that should be
>>>     git sparse-checkout reapply
>>>     git ls-files -t | grep folder  # Note the files that are sparse
>>>
>>> Granted, this is a bug with sparse-checkout without sparse-index, so
>>> not something new to your series.  But since you are using comparisons
>>> between regular sparse-checkouts and sparse-index to verify
>>> correctness, this seems problematic to me.
>>
>> I'll add it to the pile, but I want to continue having this series
>> focus on making the sparse-index work quickly without a change in
>> behavior from a normal index. Changing the behavior of the sparse-
>> checkout feature should be a separate series.
> 
> Hmm..perhaps there's some middle ground?  I appreciate that you want
> to have this series focus on making the sparse-index work without
> worrying about behavioral changes to sparse-checkout.  I'm concerned,
> though, that testcases tend to be treated as documentation of intended
> behavior, even when the tests are testing something else.  These tests
> are clearly triggering buggy behavior, and I think your comments and
> subsequent command may be affected by it.  I don't want to leave
> future folks (even ourselves) to have to try to explain away why the
> behavior expected in this test should not be expected.
> 
> Perhaps we can just add a comment that this testcase is triggering a
> bug in both sparse-checkout and sparse-index but we're only checking
> that the two match, and that once the bug is fix, the testcase itself
> may need tweaking?
 
I can get behind that approach: document the bug, but comment that it
_is_ a bug and should be changed in the future.

Thanks,
-Stolee

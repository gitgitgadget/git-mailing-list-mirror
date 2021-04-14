Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2599BC433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 16:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07B360FEF
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 16:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351818AbhDNQcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 12:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351634AbhDNQcG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 12:32:06 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A109C061574
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 09:31:44 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id k18so16287191oik.1
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 09:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aQh0eUV0koYA5u7OvXgHuHVr3FHBnizeB16dZVrA29o=;
        b=tCC/FX0I0z5i4Xr2yFFUyWqEOB/BwIRL3e784YA3KHaJnAeGZFfsBJwINiuCe3VxuL
         LpET2shC/NWcx9hHDtmX0XpxRdEibq7lkB7IZDNS6K/Ab6KP7+v1YS4ek7cgl246Q7WG
         U6g/ZArQz1nLKK6jF5WuXPLNbZMh2m4ynM5gYLmZBJU/psYP0fLyVul6VMdDY2r6Orv0
         L2kgxWGRPvhbotI+UyHf6GAE1Q0Vtq5s5TN4REefP8NRyA5sG1BXzCb/UgsBaHacbY7i
         dYkBVpz0w0yDEUQtVFqrmgtuaUV+8w2DWuRKt9SycI7gK+rPZ8fzEVGdwMgRYuC16iGE
         jRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aQh0eUV0koYA5u7OvXgHuHVr3FHBnizeB16dZVrA29o=;
        b=sacCQXMHfjrH+yuFFuL0HZqoran2cxXjkDHEYxMOC+Crxd6C319SIngg0QoKx/i4rK
         bWwdYIit7kC4TYXu/t2PcmHpcs6peKqw5r04WRR2rkqy5SGxtPFyQvUdGsIn91Cg2uMn
         Qxvwqr3/x0tsqM5G2Q7vt2jMnDbzygMaTmF5uOssr0IE0j37fcxHpg30w1NCN9u2uCns
         nXNj1kTXpcWfvFd9W/W0s+qrkPXqqZK0qszzychdBIIzYN2lP5pYlzXfqmqEjYWHdg/5
         aMqwcrU0TzIfjk8aKVJKi7irI8Mnz8vOXzaDdTbrne5pQPknyp1DnvN+qBHyGdlpMm25
         Wj4w==
X-Gm-Message-State: AOAM533hKFoNgG7/9+cDX905Lkw+7YLT4DsKft1ho4YwZyVQ9thzJBzR
        iN2ZJlhey3YmmxI2LyjRKjePfTSoEx/HVA==
X-Google-Smtp-Source: ABdhPJybvGFewhhEPDPJ21KLvm/wjdtjL+8G2Sp+gYQD0OHFjmUpNXpZGVVLS9Tnmx7CP6F+DZDj4g==
X-Received: by 2002:a54:4e96:: with SMTP id c22mr2954117oiy.176.1618417903598;
        Wed, 14 Apr 2021 09:31:43 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e5b3:d157:1c7e:e794? ([2600:1700:e72:80a0:e5b3:d157:1c7e:e794])
        by smtp.gmail.com with ESMTPSA id c12sm13565oou.26.2021.04.14.09.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 09:31:42 -0700 (PDT)
Subject: Re: [PATCH 00/10] Sparse-index: integrate with status and add
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
 <CAHd-oW7vCKC-XRM=rX37+jQn_XDzjtar9nNHKQ-4OHSZ=2=KFA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ddb08fd9-995e-dcb5-9e2c-60e3d761490b@gmail.com>
Date:   Wed, 14 Apr 2021 12:31:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAHd-oW7vCKC-XRM=rX37+jQn_XDzjtar9nNHKQ-4OHSZ=2=KFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/13/2021 4:45 PM, Matheus Tavares Bernardino wrote:
> Hi, Stolee
> 
> On Tue, Apr 13, 2021 at 11:02 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> This is the first "payoff" series in the sparse-index work. It makes 'git
>> status' and 'git add' very fast when a sparse-index is enabled on a
>> repository with cone-mode sparse-checkout (and a small populated set).
>>
>> This is based on ds/sparse-index-protections AND mt/add-rm-sparse-checkout.
> 
> I just noticed that our ds/sparse-index-protections and
> mt/add-rm-sparse-checkout had a small semantic conflict. It didn't
> appear before, but it does now with this new series.

Thank you for taking a close look.
 
> ds/sparse-index-protections added `ensure_full_index()` guards before
> the loops that traverse over all cache entries. At the same time,
> mt/add-rm-sparse-checkout added yet another one of these loops, at
> `pathspec.c::find_pathspecs_matching_skip_worktree()`. Although the
> new place didn't get the `ensure_full_index()` guard, all of its
> callers (in `add` and `rm`) did call `ensure_full_index()` before
> calling it, so it was fine.
>
> However, patches 7 and 8 remove some of these protections in `add`s
> code. And, as a result, if "dir" is a sparse directory entry, `git add
> [--refresh] dir/file` no longer emits the warning added at
> mt/add-rm-sparse-checkout.

You are right, it does not emit the warning. I will add a test that
ensures that behavior is the same across the two sparse repos in
t1092 as part of my v2 in this series.
 
> Adding `ensure_full_index()` at
> `find_pathspecs_matching_skip_worktree()` fixes the problem. We have
> to consider the performance implications, but they _might_ be
> acceptable as we only call this function when a pathspec given to
> `add` or `rm` does not match any non-ignored file inside the sparse
> checkout.

I'll want to do the right thing here to make the warning work, so
I'll take a look soon.

> Additionally, the tests I added at t3705 won't catch this problem,
> even when running with GIT_TEST_SPARSE_INDEX=true :( That's because
> they don't set core.sparseCheckout and core.sparseCheckoutCone, they
> only set individual index entries with the SKIP_WORKTREE bit. And
> therefore, the index is always written fully. Perhaps, should I reroll
> my series using cone mode for these tests?

Your series should not be re-rolled for this. Instead, this is valuable
feedback for this series: there is behavior in 'git add' that I am not
checking stays the same when the sparse-index is enabled. That's my
responsibility and I'll get it fixed.
 
> (And a semi-related question: do you plan on adding
> GIT_TEST_SPARSE_INDEX=true to one of the CI jobs? )

I do plan to add that, after things calm down. It won't do much right
now because it requires core.sparseCheckout[Cone] to be enabled. Not
many tests provide that, so they don't add much coverage. I thought at
one point to adjust the initial repo creation to include a
sparse-checkout in cone mode, but that would change too many tests.
I still haven't found the right way to expand the test coverage to
take advantage of our deep test suite for this feature.

Thanks,
-Stolee

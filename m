Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3442BC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 17:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07025206CC
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 17:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzcGmgLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfKURP0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:15:26 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37731 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKURP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 12:15:26 -0500
Received: by mail-qk1-f196.google.com with SMTP id e187so3730823qkf.4
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 09:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HRAtYQGORcvg8mK4/PwHtZj49lXWeSRP/cztHo1p+uU=;
        b=LzcGmgLeRUsqe/QxtvUCpH6leUz6LfsR+FNo13Stx/Ji+j81kb0zIhRq8VZtjFBJXj
         5yCyOkxjIP6ljmZNAwy7J/2UVcezpyvONgBZFlSY5ylgCEvbYsPWvTdnMQc3S0ylIrdT
         C3EiVYIwjDJmGjt+x4srBYTI5jAKr7XzBzx9ediBlDm8dvSC4W/I2SKZA+6kAuuo5MYF
         ospNuC3KgTghv8RfzqjmC1VYA1I/HqHLw6dS4SCMet8FlmdUq6XEHKW2EvYNMFk1N1Fj
         seuczaP9nEO6y3vfc33AMlnvF1jzcSw4CRt5NZAjxSkTZxXEe3cSbRNJCEzRbAXswf4U
         spDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HRAtYQGORcvg8mK4/PwHtZj49lXWeSRP/cztHo1p+uU=;
        b=OkEtXwdNaOqiAX2L+6klmKwPi2w8seGYTFDTE96FZmZyUftddh5N6/sFeC0Ne/cwgQ
         oTINjSq7EPExjfyQ2TmnWmXLGT6FO4BFogWEiP3NlFlJImSFShijvNNrjhvimI5KsPxB
         2mblcyFN7EbfQJ9CPZc7sWJ6lSoKlkzUFAFJXB6aQAdgqA/bIssvnkcsMDdIbaNd2Ac/
         Dqz+v8DpXrdaCo23MgYh83DswgG8Eyk4qhjhF0p6taOPS8PbCdLJ9ajpaRwZeHr8Yv4/
         bTIWQUBoFFheRo4ipRRw2ON+vgJMdo3CLxLGrY0GRhBMTMzFySkr2jEns24ZrLLZGjIU
         2tuw==
X-Gm-Message-State: APjAAAVksVQd19eKrdK98NM5wE+oXFIPZByUWGJAkOpVwDlP5lzPSkon
        nYiv/j0ua1A+ouCT07BJpzE=
X-Google-Smtp-Source: APXvYqwkQRLj0arlnMsT0LZeuJid/phnKqVyIFZMKhsEl25m6zSNDnTa6eTeS1sWfgAHYN1d7IDepg==
X-Received: by 2002:a37:4f83:: with SMTP id d125mr1174170qkb.205.1574356524839;
        Thu, 21 Nov 2019 09:15:24 -0800 (PST)
Received: from [10.0.1.19] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id 130sm1698481qkd.33.2019.11.21.09.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 09:15:24 -0800 (PST)
Subject: Re: [PATCH v5 02/17] sparse-checkout: create 'init' subcommand
To:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <a161cee0dfec76e7a08253083f488e2e6d26299e.1571666186.git.gitgitgadget@gmail.com>
 <20191121114936.GR23183@szeder.dev>
 <147bf5a9-6ae5-23ea-a007-68b8046c94ea@gmail.com>
 <20191121152744.GU23183@szeder.dev>
 <72a54009-5801-c92a-f108-faf38ebbdd4b@gmail.com>
 <20191121163706.GV23183@szeder.dev>
 <CABPp-BEVFyd9+22MhtREh57FYUJhBSj2vz3piUuk_hX8=Aq3UA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <42d485d5-9b9d-6ec3-0b52-0da916faf3ad@gmail.com>
Date:   Thu, 21 Nov 2019 12:15:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEVFyd9+22MhtREh57FYUJhBSj2vz3piUuk_hX8=Aq3UA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/21/2019 12:01 PM, Elijah Newren wrote:
> On Thu, Nov 21, 2019 at 8:37 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
>>
>> On Thu, Nov 21, 2019 at 10:36:10AM -0500, Derrick Stolee wrote:
>>>> But wait, I thought that only changes to files that are excluded from
>>>> the sparse-checkout are thrown away, but as it turns out it throws
>>>> away changes to files that are included in the sparse-checkout:
>>
>> For completeness, 'git sparse-checkout disable' throws away staged
>> changes as well, as it, too, runs 'git read-tree -um HEAD' (or its
>> equivalent).
>>
>>> Thanks for the additional details.
>>>
>>> This series intended to make the existing sparse-checkout behavior
>>> more useful to users by not requiring manual edits of the sparse-checkout
>>> file followed by 'git read-tree' commands. However, there do appear
>>> to be some serious improvements that we can make in the future.
>>>
>>> Keeping staged changes seems important, and we can address that in
>>> the near future.
>>
>> I think that at least for now 'git sparse-checkout' should flat out
>> refuse to init/set/disable if the working tree is not clean (but still
>> allow 'list', as that's a read-only operation), like the patch below.
>> Yeah, that way it wouldn't work in cases that appear to be safe
>> (unstaged changes), but it would prevent the data loss until we
>> carefully consider the circumstances under which these operations can
>> be safely allowed.
> 
> A big +1 for this from me.
> 
> We had an unfortunately large number of mis-merging and dataloss bugs
> in the merge machinery that were slowly fixed over the course of more
> than a decade[1], due to the fact that builtin/merge required
> index==HEAD and did so by placing a comment in the code notifying
> folks that the individual merge strategies were responsible to enforce
> it -- and, in practice, they *all* forgot to do so unless and until we
> discovered bugs.  So, count me as a strongly in favor of just
> preventatively enforcing safe conditions and then later relaxing them
> in special conditions if it can be proven safe.
> 
> [1] https://public-inbox.org/git/20190725174611.14802-4-newren@gmail.com/

Sounds good. Thanks, both.

-Stolee

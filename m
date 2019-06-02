Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD1BC1F462
	for <e@80x24.org>; Sun,  2 Jun 2019 14:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfFBORU (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jun 2019 10:17:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54025 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfFBORT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jun 2019 10:17:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id d17so1120380wmb.3
        for <git@vger.kernel.org>; Sun, 02 Jun 2019 07:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dSCCu9NBtRxoAMg1ENqxag6uQR0KwkCUPQ8B81d9HZA=;
        b=iuTwDvKNDGl8O6T63uzk4qiDtKSaUm8NQKqxKUpLLrOWSoUNWcryttR8FMlk1uWnPX
         LeSlveVBPwYRO5DdL5qgfhlvi++3HSQW3pBgsSdVY193yV9t6taF0VTKhKlsvO7KqK8c
         wrjkJSsgQY5OuP9Sw23FcqHvllNTp8BUQDlo78JRNx8YpIZOqk0/IA+ut5caoB8r/lYo
         k8u1vHtYb7BmfJMgp2eBaPnPIRWbnKAtww5jXBae0U8ZI2Qk5vNqG0tYF11AZRFw/grB
         VlP2jvojn5jgOsfwYBMLbrBd7oeX8EO3Nrs30jlQpcoxLidaUQ5XhQtj6TaitUGu664j
         4iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dSCCu9NBtRxoAMg1ENqxag6uQR0KwkCUPQ8B81d9HZA=;
        b=dj/iWlHJE5GFRibyTtxnsSYrGEPKMGPOzymTb7VrNJB3ZOlc71SvShlkEKMattEVEc
         CeIhjVViVNZYwC0edWz+QohrS37B5T2mE2L/AGlqAS3FX62DNlU/wv4g2DTC4ol4AyIE
         jPi4G/WcKB0fmSRKOFztlyflQxrro93NGcG2k6Kg/qbI+h9VfLlzplQtVV/1V2h5dd+H
         iarrNWzzQUMQ0VW32zEUXeiO6w0GDb+xwNewbb2tUvpu2GNSZngRQpHHDqHE9+waV2yJ
         Fpj15dQGnl0JtqOoEVJR7mfa5IJ4VKU0VOCIWME6RH2zoS/t5nDshkdQosJMcCswJg/8
         BtOg==
X-Gm-Message-State: APjAAAXZ4vuiotNz+jhs487To3R0Z8cSP1AjGdHryLHbuNz5/A3gPu/G
        mRUdQi+MR422G3euQ9RJst4RQBMr
X-Google-Smtp-Source: APXvYqwmCEH3X4qN6uxjwsMiEbsOLQnjvbaQhPpUr3Agh0J5lRvnCD0A15SpTp2z8bQFBknVklUo/Q==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr11384450wma.120.1559485036507;
        Sun, 02 Jun 2019 07:17:16 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id y133sm6546751wmg.5.2019.06.02.07.17.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 07:17:15 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] add -p: coalesce hunks before testing applicability
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Jochen Sprickerhof <jochen@sprickerhof.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20180828085858.3933-1-git@jochen.sprickerhof.de>
 <xmqq36uygyau.fsf@gitster-ct.c.googlers.com>
 <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>
 <20180903190114.GC17416@vis>
 <d6a8f77b-0a83-90ae-a7fb-a3954ac3b346@talktalk.net>
 <nycvar.QRO.7.76.6.1903221453360.41@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a23789e9-ee99-d23b-ee25-1acef8d8d114@gmail.com>
Date:   Sun, 2 Jun 2019 15:17:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1903221453360.41@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho


Sorry it's taken me so long to get round to replying to this

On 22/03/2019 14:06, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 13 Sep 2018, Phillip Wood wrote:
> 
>> On 03/09/2018 20:01, Jochen Sprickerhof wrote:
>>
>>> * Phillip Wood <phillip.wood@talktalk.net> [2018-08-30 14:47]:
>>>> When $newhunk is created it is marked as dirty to prevent
>>>> coalesce_overlapping_hunks() from coalescing it. This patch does not
>>>> change that. What is happening is that by calling
>>>> coalesce_overlapping_hunks() the hunks that are not currently selected
>>>> are filtered out and any hunks that can be coalesced are (I think that
>>>> in the test that starts passing with this patch the only change is the
>>>> filtering as there's only a single hunk selected).
>>>
>>> Agreed here. It would be enough to include the first hunk in the test to
>>> make it fail again. Still I would see the patch as going in the right
>>> direction as we need something like coalesce_overlapping_hunks() to make
>>> the hunks applicable after the edit.
>>
>> Yes in the long term we want to be able to coalesce edited hunks, but I
>> think it is confusing to call coalesce_overlapping_hunks() at the moment
>> as it will not coalesce the edited hunks.
> 
> Agreed. I actually have code to coalesce even edited hunks, but it is all
> in C.
> 
>>>> This is a subtle change to the test for the applicability of an
>>>> edited hunk. Previously when all the hunks were used to create the
>>>> test patch we could be certain that if the test patch applied then if
>>>> the user later selected any unselected hunk or deselected any
>>>> selected hunk then that operation would succeed. I'm not sure that is
>>>> true now (but I haven't thought about it for very long).
>>>
>>> I'm not sure here. If we use the same test from t3701, do s(plit),
>>> y(es), e(dit), it would fail later on. Can you come up with an
>>> example?
>>
>> I think that if you split a hunk, edit the first subhunk, transforming a
>> trailing context line to a deletion then try if you try to stage the
>> second subhunk it will fail. With your patch the edit will succeed as
>> the second subhunk is skipped when testing the edited patch. Then when
>> you try to stage the second subhunk it will fail as it's leading context
>> will contradict the trailing lines of the edited subhunk. With the old
>> method the edit failed but didn't store up trouble for the future.
> 
> Indeed, this is a problem I also stumbled over.
> 
>>>> We could restore the old test condition and coalesce the hunks by
>>>> copying all the hunks and setting $hunk->{USE}=1 when creating the
>>>> test patch if that turns out to be useful (it would be interesting to
>>>> see if the test still passes with that change).
>>>
>>> We set USE=1 for $newhunk already, or where would you set it?
>>
>> To match the old test it needs to be set on the hunks we've skipped or
>> haven't got to yet so they're all in the patch that's tested after
>> editing a hunk.
> 
> The way I fixed this in the C code is by teaching the equivalent of the
> `coalesce_overlapping_hunks()` function to simply ignore the equivalent of
> `$hunk->{USE}`: the function signature takes an additional `use_all`
> parameter, which will override the `use` field.

That sounds like a good solution. Thanks for working on the conversion 
to C, I'll try and find time look at the code on github.

Best Wishes

Phillip

> 
> Furthermore, my C code actually does the coalescing as part of the
> `reassemble_patch()` function, feeding the output directly into the
> `stdin` of the `git apply` process (with, or without `--check`).
> 
> And crucially, my C code does not try to assemble a new `hunks` array, but
> simply works in-place, reverting the changes if the hunk edits result in a
> patch that does not apply. The Perl version probably does not need that
> part, as it is pretty careless with memory (as Perl encourages to do).
> 
> See for yourself:
> https://github.com/dscho/git/commit/6f8ac4809280f2cd018683ab5199b004ada2350e#diff-f58d2179be56b196b9f35c6d24799a8eR337
> 
> Ciao,
> Dscho
> 
> P.S.: Yes, this is part of my work to complete Slavica's "`git add -i`
> in C" project. There are quite a few loose ends to tie, but I can already
> use it myself to call `git add -p`, which is what I care most about, as it
> regularly takes more than one second to spin up Perl on Windows, which is
> friggin' annoying, I tell ya.
> 

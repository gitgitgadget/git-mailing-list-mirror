Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10A0C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 11:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2D9C6195C
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 11:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhC3Lma (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 07:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhC3Ll6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 07:41:58 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FC0C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 04:41:57 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id o19so7965299qvu.0
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 04:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W/Ulw1NZoxjGc5sP1bzg3rPDCYvBuJz5d6/6LhnkqMs=;
        b=DAWA0xnn2DerFETYyB630b+Co3/WlJHjIMd5ODley/BqePwP1Zea048p7+0PVC50CZ
         8fUs+/wShIGiLnx43GtWBoxErbbLgxZnXW4GatfmbmuwzBV5rd074kuS9Y2bYCNLMWAE
         sljOMz2Adq0OWR8egWMUpvhJodFAx71/jhR6HJJejxM6ISj9uA3VTdhW62mHwgoKL0W2
         t6Jri3oeOBswZud/M1HNZjYyp8pNl4VT19cE9iIhX16yHENcUw5WnGi+nUKEYjrGjN4c
         J1aP8f2vrJH2QsyAutNpMxE3XqzkXDsnb8SvfWBXi6XhanQCOqryRCWeyT6aq0Dce/mf
         lgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W/Ulw1NZoxjGc5sP1bzg3rPDCYvBuJz5d6/6LhnkqMs=;
        b=Ko5iOxQynwyFpMQa7+suGWQLRKMflkzU3tuiolD+cAqi8VZAN7bl5p2qt0+hVj7k6c
         on0gydtfEL66OaLKJ5FJdr78kVGn9fBVpUF9ozdl1oHAw3jCDpGCTPlSIgKr5GSZpGn5
         XAZaxVKzjYDnUWbxuoUMxHW1vMZB8rYVmOjd6gvd5VOhyAuJXuCdaDUAO2MlHDQPkaoG
         0JfFz9VrcN5+Q4/RbI8nLlR8eZy7zj9GFIw3BSJ8G66PgPFhLvMn7O/IQO52PQUp4FEw
         S7ZYFrjUW7aixTEbX/nBXORKNcwNoyk0Ya63J8r2jOhxgQzCPCEKl5XmhUap/NSLixjH
         WhXA==
X-Gm-Message-State: AOAM533Krco8DECyDv89YxnqntvrcXH6Emlay2HwvkdG4oAtiU9hNaOt
        HBCj9IFjOOCxwaeHeaHGKc0=
X-Google-Smtp-Source: ABdhPJw1IJ6Yvpute1oYMCPeWGOyPHXAK52LYT1ovRdKES0R3K4VvIrS3q9o3VAqGgM4FtG8UwF+1Q==
X-Received: by 2002:a05:6214:b04:: with SMTP id u4mr29684012qvj.0.1617104516885;
        Tue, 30 Mar 2021 04:41:56 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:51d7:1436:793b:b3c9? ([2600:1700:e72:80a0:51d7:1436:793b:b3c9])
        by smtp.gmail.com with ESMTPSA id a138sm15394795qkg.29.2021.03.30.04.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 04:41:56 -0700 (PDT)
Subject: Re: [PATCH v4 07/20] test-read-cache: print cache entries with
 --table
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
 <7ebd9570b1ad81720569a770526651c62c152b9f.1616507069.git.gitgitgadget@gmail.com>
 <87r1k5pcmx.fsf@evledraar.gmail.com>
 <ca8a96a4-5897-2484-b195-57e5b3820576@gmail.com>
 <874kgzq4qi.fsf@evledraar.gmail.com>
 <CABPp-BGRwxn73sntpX8Q5aD-O192RZmOOy_jiU3SQp4-erivtg@mail.gmail.com>
 <87eeg0ng78.fsf@evledraar.gmail.com>
 <b1eee802-f20c-5381-366c-729755bfac8a@gmail.com>
 <87im59mufk.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <60e27a5c-b3d1-4a6a-51d5-bdc03591e02d@gmail.com>
Date:   Tue, 30 Mar 2021 07:41:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <87im59mufk.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/29/2021 7:06 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Mar 29 2021, Derrick Stolee wrote:
> 
>> On 3/28/2021 11:31 AM, Ævar Arnfjörð Bjarmason wrote:> It seems to me that the reason for that state is based on a
>>> misunderstanding about what we would and wouldn't add to builtin/*.c,
>>> i.e. that we wouldn't have something like a --debug option, but as
>>> ls-files shows that's not a problem.
> 
> At the risk of going in circles here...
> 
>> I feel _strongly_ that a change to the user-facing CLI should come
>> with a good reason and care about how it locks-in behavior for the
>> future.
> 
> And I agree with you. Where we disagree is whether lives in builtin/*.c
> == user-facing. I think --debug options are != that. It seems Junio
> downthread agrees with that.
> 
>> Any adjustment to 'git ls-files' deserves its own series and
>> attention[...]
> 
> A user-facing change to it yes, but I don't see how use of an (existing
> even) --debug option would warrant any more attention than a new test
> helper, less actually, it's less new code.

I disagree that we can change the expected output of --debug so
quickly, despite warnings in the documentation. Changing that format
or creating a new output format requires cognitive load, and we have
enough of that going on in this area as it is.

>> [...] not in an already-too-large series like this one.
...
> I'm just still perplexed at how you keep bringing up use of an
> internal-only --debug option as "user-facing", and here "already too
> large" when we're talking about a proposed alternate direction that
> would reduce the size.

I'm not saying "patch size" or "code size" but instead thinking of it
in terms of how many decisions need to be made. Changing a builtin
when it's not necessary adds to the complexity of the series and
interrupts its core goals.

Finally, I have mentioned that I will need extra data for testing a
new index format. I don't want to modify the builtin now in a way
that is insufficient for the needs in that future series.

> Just to clarify, upthread in [1] you said:
> 
>     And I recommend that you continue to pursue [these RFC patches] as
>     an independent series, but I'm not going to incorporate them into
>     this one[...]
> 
> So do I understand it right that you're referring to phase IV in your
> opinion being the first point where we'd consider piggy-backing on
> anything in builtin (that "user-facing" dilemma again...).

I'm saying that if you feel strongly about it, then please pursue the
changes to ls-files any time after this series (but probably after
the next) solidifies. Having the changes be in a separate series allows
time to inspect the behavior change to the builtin in a focused way.
 
> But at that point wouldn't you have your own ideas about some
> user-facing ls-files or other porcelain for this, so I'm not sure where
> to place the encouragement that I continue to pursue that RFC series,
> other than setting a reminder in my calendar for 6-12 months in the
> future :)

Otherwise, I will modify ls-files myself in this 6-12 month timeframe,
based on the established plan to remove the command_requires_full_index
setting.

Thanks,
-Stolee

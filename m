Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947B7C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A2C6603E9
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhIJLPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 07:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbhIJLPu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 07:15:50 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1B2C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:14:39 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 9so1927151edx.11
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=JjJu4G+GWmwSpo77o6fsRBEaOltEdu6Fc/d+9ovB3qM=;
        b=QNiQfCMJezGLAiKPUZ0RSzREjbvPwSbw1FJuaGVr6i7VoxcXPQJLPPhkTrx37d9RUh
         SHZA2mSLoPsnpvOOBHufmo6Fi/3KawRFR62sxYgLLkp+z1N1lBWyKa5bHG9yKcg/vYVk
         Gf3+qKvHbg4D3uNwHy3ux89SJSAh0wiN83qB10iKLKAkrxPWUCUILMxcB5X9/LJBTKvO
         owOrqoBrlTPtklCSFoET58cnZs6qsSuzUvuO29/sXgkCJrpn1FNtaiVtKVD4vpSbokbG
         FY3Y9oay9gJqqV48yr5fhLnJDMWGmZF6yvhfX7bCjnYrAb34A51pD/ql+XaD5vR15HKb
         rcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=JjJu4G+GWmwSpo77o6fsRBEaOltEdu6Fc/d+9ovB3qM=;
        b=0zC4HMGurmDdO1CemoqHyE6DjQ01+7CJXLDUhw/dr5nEjexL41oQSOw12qinuRyxUG
         1LoVxIrxzLOIL1HM8yYyIJaC5pDwKap/nmlGZL6UjLR8DBn+PDNSNlDg8XK58ZyGZUZv
         JzVrPyAUiJ2/CcWL1QF7rzfIZYr5efvGN/5cC6p7K1KWsuMUyrn+lHmTCKVJhsnF3Bb1
         khfyP7ZvrtUwM8cuLZ5y6PCgTMiIDtfDHiEFwTKRT6byv3Bdj6l3MAvLG3HjEU+iQ8bm
         xDH/ObV72FCHI7/z8HbWKQkJ0A12Q0Q0YH1p6ljCrn4+aPKEqSqLwWVP+E/dZV2M0LfX
         d6Yw==
X-Gm-Message-State: AOAM5337OO4kTXP6DT5BVOpb7YMfx9wSiCpVSQSK90ye9GkK/ekAtwsi
        215BBMKdeKRwIL87fNos4r8=
X-Google-Smtp-Source: ABdhPJx3ghslaym7POOZPInR32BoZpBXzi7F1ELaaBS7lz9W/6jnj5K4+jViCeaXlRy5Ptt60x2vzQ==
X-Received: by 2002:a05:6402:206d:: with SMTP id bd13mr8447855edb.196.1631272478063;
        Fri, 10 Sep 2021 04:14:38 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b5sm2282767ejq.56.2021.09.10.04.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 04:14:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 5/6] help: correct logic error in combining --all and
 --config
Date:   Fri, 10 Sep 2021 13:09:28 +0200
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
 <patch-5.6-bcc640d32a1-20210908T151949Z-avarab@gmail.com>
 <CAPig+cSK+wLPUDuGf1d41J_F5jQS+J=a=7kHQLV07-ZKZW9GsA@mail.gmail.com>
 <87bl52hn40.fsf@evledraar.gmail.com>
 <CAPig+cROO1VT9Umdtor9zc8eftyDTBg+ER2igZG+jxygM9gLJw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CAPig+cROO1VT9Umdtor9zc8eftyDTBg+ER2igZG+jxygM9gLJw@mail.gmail.com>
Message-ID: <87y284d6nc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Eric Sunshine wrote:

> On Wed, Sep 8, 2021 at 3:40 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>> On Wed, Sep 08 2021, Eric Sunshine wrote:
>> > I personally find it highly frustrating when a program merely dumps
>> > the usage statement without any explanation of what exactly it doesn't
>> > like about the command-line. Printing out a simple:
>> >
>> >     --all, --guides, --config are mutually exclusive
>> >
>> > message would go a long way toward reducing the frustration level.
>>
>> I'll make it emit something more helpful.
>>
>> More generally I've got quite a bit of parse_options() improvements
>> queued up locally that I've been trying to trickle in at the rate I can
>> get them through the list, review over at [1] would be much appreciated.
>> https://lore.kernel.org/git/cover-0.2-00000000000-20210901T110917Z-avara=
b@gmail.com/
>
> My review time is very limited these days (which is why most of my
> review comments lately are superficial), but I set aside some time to
> review that series for you[1]. Most of my review is subjective, but I
> did identify one lurking bug (assuming I understand the code
> correctly).

Thanks, I'll try to take a look at that in detail & re-roll soon.

> [1]: https://lore.kernel.org/git/f8560b11-ba56-0a52-8bb4-5b71f0657764@sun=
shineco.com/
>
>> I wonder if we can do this automatically, we already have the
>> builtin_help_usage, we could parse that in the general case and find
>> that certain options are mutually exclusive per the examples there.
>>
>> We'd then discover what option we parsed when usage_with_options() was
>> called, and automatically emit a useful message in these sorts of cases.
>>
>> Of course the usage strings might be incomplete or wrong, but part of
>> the point would be to find those cases & a test mode to die() if a
>> command was called with some option combinations not suggested as
>> working according to its documented usage...
>
> Perhaps, though I imagine it would have to employ some, um,
> "interesting" heuristics, and be quite hit-and-miss at first, at least
> until people get around to formalizing existing and new usage strings
> with the specific goal of supporting that feature.
>
> Speaking of heuristics and wishful thinking, when I read the cover
> letter of your series which I just reviewed, I thought at first that
> the end-goal would be to ignore whatever indentation the caller
> provided following each embedded newline, and instead insert the
> correct computed indentation automatically. This approach would
> obviate the need for the [1/2] indentation cleanup patch. However,
> doing so would require heuristics or at least manual help from the
> caller to indicate the proper indentation width. I also thought
> perhaps the intention of the series was to do the line-wrapping
> automatically (ignoring any caller-provided embedded newlines), thus
> ensuring that the lines were indented correctly _and_ fit the terminal
> width properly regardless, but that's a somewhat more substantial
> change.

Yeah, I considered it but decided not to mainly not for the heuristics
reason, but that any such thing means that you won't have the same
indentation in the C code. I.e. instead of:

    "git foo [--some-option]\n"
    "        [-even -more options]"

You'd have:

    "git foo [--some-option]\n"
    "[--even --more options]"

Which I think is just not as legible, but also in the general case you
get into the quagmire of how do align a thing like:

    "git [-c foo=3Dbar] something [--option]\n"
    "[--more-options]"

Are we doing to align on the "git " or "git [-c foo=3Dbar] something ", or
is it a "git something" where "something" is the name of a sub-command,
or is that a filename?

We control the source code so we can do it, but I thought it would be
nasty, and in any case any working solution wouldn't give you alignment
in the source code, so I dropped the idea.


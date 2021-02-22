Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A8EC433DB
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 09:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A3B64E13
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 09:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhBVJqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 04:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhBVJpx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 04:45:53 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B970C061574
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 01:44:59 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hs11so28276693ejc.1
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 01:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LtHL7nyO7U9bmSfaq86Xa2kF5ex9B4s6MQ+5EODs9S8=;
        b=XuaeNmLkKpT6BHcN0xeFQc3kuM708vU1scpvlQp1idKdktLtc3Yr6TxwY37H6eoWeR
         l/r7q1d2OXlOAPm3+av4eh+dRuzfom12/T8qj5kzqJ7iqbiMBGyWbTawgwtque/govUI
         bEnzsaKQz8NT41xvky+DQUgzESzqjY8UjmqaSdYGWYsod7dT1bppMbuL2OXQN5t1xGR2
         ZLTXk9u9pCURNq5ouEq2xDMT4FGxOHSgNLihQSN5kmGNEj8QcqbtehcVk72uPT9G+4xL
         XvMglK6CeObc+73PG9QY0uAeWXu4FlwksflfzuN3oPgQIQ/w9Wuwq+UHCm+dBWH1gGbl
         q/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=LtHL7nyO7U9bmSfaq86Xa2kF5ex9B4s6MQ+5EODs9S8=;
        b=RJGjmVCwPtlrT3s0tAfz2SXF/TpdMsPogT62wZi7ZzEYFMgfC52KWqHmvzIwz6Lf44
         4XMDsz4jdtYJwzGR2xI258ivE4feEZVoc9PGSD5qCGWZDur+r6qEImSiGngN175v72tC
         Ci0J5ry1+rZ91+gWPh3GPCBeqUvVKKdDYZo07DUjTFcyB1gXO47gM6LxkAL9bsIFggRE
         sqyOdHHsZbzIHTd+FxfKIUJ4ZajwEuiMj7LJXEECB1k0pPvR771jl0J5HSUzsdFeIhtx
         cZ9bCB/IQlp+tHpo87jzVVwsxE5UJmiIcupSdAbeBOMfW51Q8yynn8WOy3yhUIP3Hddx
         CbfQ==
X-Gm-Message-State: AOAM530Fp0B1EkbOf/764C9+9Vrty5YklLm5W0U3KexZdaRs6uhP2AOH
        7T2w/SNDIBau5bvcgVzdD3k=
X-Google-Smtp-Source: ABdhPJwh9KVxyTpUrXyzjOajykvfvvnyBARW83ZE6AIqAKX9IJcdb8Q/dkD50GFGv5Y9yQSlsMyVcg==
X-Received: by 2002:a17:906:28d6:: with SMTP id p22mr20545046ejd.365.1613987097352;
        Mon, 22 Feb 2021 01:44:57 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ia25sm8273615ejc.44.2021.02.22.01.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 01:44:56 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: New orphan worktree?
References: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
        <CABPp-BE1QXA0ohB9D-tqKpzDTok0BMsGQjotmcqMxfs9AL5noA@mail.gmail.com>
        <CAPig+cRzXd+zd+xVisaW+HToSaGzAE28acGmxwRxNU4bczHXbw@mail.gmail.com>
        <87wnv688u4.fsf@evledraar.gmail.com>
        <CAPig+cQ9oqMWjBkyRt-SQFuyfAGkMu1J-U6ZCCJqeL0a_3ynkw@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAPig+cQ9oqMWjBkyRt-SQFuyfAGkMu1J-U6ZCCJqeL0a_3ynkw@mail.gmail.com>
Date:   Mon, 22 Feb 2021 10:44:55 +0100
Message-ID: <87ft1o8mi0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 21 2021, Eric Sunshine wrote:

> On Wed, Feb 17, 2021 at 8:26 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Wed, Jan 06 2021, Eric Sunshine wrote:
>> > Yep, when/if --orphan is added to `git worktree add`, it should mimic
>> > the behavior of --orphan in git-switch rather than git-checkout.
>>
>> How would a mode for "worktree add --orphan" that mimics checkout rather
>> than switch even look like? The "checkout --orphan" special-case is
>> because we retain the index, so you need to "git rm -rf .".
>>
>> But with worktrees we always get a new index, so AFAICT the only way to
>> make it work like "checkout" would be to have it be the only mode that
>> copies over the current worktree's index.
>
> I hadn't actually put any thought into it aside from (1) `--orphan`
> being a likely candidate for `git worktree add`, and (2) my uses of
> orphan branches always involved `git checkout --orphan && git rm -rf
> .`. I never got as far as thinking about the actual implementation.
>
>> In any case I implemented a rough version of this today, and it uses the
>> "switch" semantics. I only discovered this ML thread afterwards.
>>
>> It's surely full of bugs, and needs test work (see all the BUG(...)),
>> but if someone's interested in taking it further all it should need is
>> some more tests & dealing with the edge cases of incompatible options
>> etc. It's Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@=
gmail.com>.
>
> Thanks. This looks like a good start.
>
>> +test_expect_success '"add" worktree orphan branch' '
>> +       git worktree add --orphan -b orphan here-orphan &&
>
> Rather than making --orphan a boolean flag, we'd probably want to
> mirror the behavior of the other commands and have <branch> be an
> argument consumed by --orphan:
>
>     git worktree add --orphan <branch> <path>
>
> That would make --orphan, -b, and -B mutually exclusive, much like
> they are for git-checkout, and much like -c, -C, and --orphan are
> mutually exclusive for git-switch.

I see now (but didn't before, I haven't really used "switch" before)
that that's how it works.

But that doesn't seem to make much sense as a UI, maybe I'm missing
something but how do you:

    git switch --orphan existing-branch

Just like you can:

    git switch -C existing-branch <start-point>

It's actually this exact use-case that prompted me to write the --orphan
patch. I wanted to create a "meta" orphan branch in my git.git, but had
an existing local "meta" (from Jeff King) that I'd happened to have
checked out long ago which I first needed to "git branch -D".

Wouldn't it make more sense for a feature like this & back-compat to
start with switch's "--orphan" implying "-c", but you could also supply
"--orphan -C" instead? And in worktree have -b and -B work like they do
for other branches.


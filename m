Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E431C4161D
	for <git@archiver.kernel.org>; Mon, 10 May 2021 11:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C83E611F0
	for <git@archiver.kernel.org>; Mon, 10 May 2021 11:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhEJLN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 07:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbhEJLJx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 07:09:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FEBC061201
        for <git@vger.kernel.org>; Mon, 10 May 2021 04:03:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id zg3so23868728ejb.8
        for <git@vger.kernel.org>; Mon, 10 May 2021 04:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=t7H2S9FYKpS7AaUUkJIbE2uuwH4WEvnC6IscN20WCAw=;
        b=GjCiyXn2NnYhwkWanPo/A0OtiWXCwE54APtnIQ15Ua39af7UE5Fd6KGymyMH4tsjn/
         92Y+aDo/qRCO+NdWSWaFKc6gW9l7Ct8s3gbs5HT5KzJCscyRh7xs0J1ccExUZMKhTJ5u
         LXSXfJIs3VnvzamXfx3iW2SJ71e2FO6fkh0mp/NrzU6XrJa6B49HNkyDIy0GACN33l97
         k86NfZY+6FOJc8RIAkl/PMgq7M1yk/Zgs7HQ8sHaeOn2z9hy7DkisjDy8k7KbV1M82iw
         OFS+O6ccm35LijZn28gDp8t0d5l+bhRzgRmptpCead7D0gcZ0775RAWkk+sRSRhQtmnV
         WWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=t7H2S9FYKpS7AaUUkJIbE2uuwH4WEvnC6IscN20WCAw=;
        b=DsNuEExBe9Q+x3Qo8tpZi62PAsom8xPbSaa9IaIXvoM3/zj33g0X73gnnsGKeWjHdQ
         Kbo2QkFP3ZImXaX2UI3CHxY3fhzeFNrvCkYyAYwCBfpupDbARAL9D+Oqe/SJ8iPCKVAO
         nVgKlm8crE0hE2PcLaqUi4D5mUN1w8wfDy0NDJL+g+FiVS1UGMFztV5/Jrkc6zMxPUJL
         A3c+5pl+EmEZ2zdMtjb3hcXhBx4Ujoup7NiMci+YCTf8yYx/XH4nR4Wh/ErLM+7DMFcD
         1ztiQo8UfKLXpd+fOIx3MIId2KeD0x3ghQiZIrSXzLCfSWtX4t3ZwbXUZ0+NzkBu5p66
         8AKA==
X-Gm-Message-State: AOAM531UbZnI6Np9cY63dwe7p5uUZq7AESmgc6xPPNYcNiTRn4rwPeyM
        HyQflITp9Arg0S9r2/dXKWw=
X-Google-Smtp-Source: ABdhPJwp1VoVCe69+QLDRhpI8Xky683iyGO/1WiM3rjKG3MIN5iifUgrDyrd2q3xA74PZB4lH8LhKA==
X-Received: by 2002:a17:907:1b1e:: with SMTP id mp30mr24993094ejc.532.1620644636316;
        Mon, 10 May 2021 04:03:56 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id y17sm4913497ejc.79.2021.05.10.04.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 04:03:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?G=C3=A1bor?= Farkas <gabor.farkas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git switch/restore, still experimental?
Date:   Mon, 10 May 2021 12:58:16 +0200
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
 <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
 <877dkdwgfe.fsf@evledraar.gmail.com> <xmqq35v01ua3.fsf@gitster.g>
 <6093cc63a4e81_325720840@natae.notmuch>
 <87h7jfvq09.fsf@evledraar.gmail.com>
 <609465b55e183_577f20852@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <609465b55e183_577f20852@natae.notmuch>
Message-ID: <8735uuvois.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 06 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, May 06 2021, Felipe Contreras wrote:

First of all, I think we're in rather violent agreement about the real
matter at hand here, and are at best talking about the design of the
keychain for the bikeshed...

>> > If you use natural language:
>> >
>> >   1. Git, switch to a new branch
>> >
>> >   2. Git, switch, create, branch
>> >
>> > One of these simply flows, the other is complete gibberish. I think
>> > anyone familiar with English can identify which is which.
>>=20
>> Well, there's "Git, create a new branch and switch to it"
>
> Which command is that?
>
>   git create branch --checkout?
>
> I'm following the order of the words from left to right.

I'm just pointing out that git in general and certainly not the *nix
tradition it follows tries to make commands readable in anything like
English sentence order. If you attempt to read "log", "status", "rebase"
etc. commands like that you'll at best end up sounding somewhat like
Yoda.

>> Also, there's the verb "make" in common use in git's command set
>> e.g. git-mktag, git-mktree, as well as mkdir(1), mkfifo(1) etc.
>
> Sure, although I wouldn't consider them main commands. I for one never
> use them.
>
>> In any case, unless we're talking about rewamping git's entire command
>> set (e.g. having a git-newtree or whatever) I'd like to think that it's
>> more productive to focus on making the commands/switches we have
>> internally consistent when possible, which is what I'm advocating in the
>> E-Mail that started this sub-thread.
>
> But we are talking about a new command, it is precisely at this point we
> need to think about what could have been if mistakes of the past had not
> happened.
>
> We should not repeat past mistakes without a very good reason.
>
> I don't think we should seek consistency for consistency's sake. Sure,
> consistency is good, but it's only one of many considerations.
>
> In this case however we have a rare occasion in which both consistency and
> natural language meet, we should not squander it.
>
> In fact, to be even more consistent we could add a -n option to git
> branch, which would be reduntant but more explicit, like --list.

Indeed, I agree with all of that. I.e. we should move to "switch" to
"-n" instead of "-c" etc., and add a "-n" to "branch" for
consistency. After all that's my upthread proposal...

I just don't think it's worth trying to make the argv readable as a
sentence, even if we had no backwards compatibility to worry about.

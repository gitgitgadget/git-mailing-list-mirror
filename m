Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151D1C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 18:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240293AbiEXSXA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 14:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240290AbiEXSW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 14:22:58 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BE98A30D
        for <git@vger.kernel.org>; Tue, 24 May 2022 11:22:58 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id n23so24218560edy.0
        for <git@vger.kernel.org>; Tue, 24 May 2022 11:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=fEsYQc1o8wtZRn7XWvWCcHI1wzttGxG94SsKRFtCE88=;
        b=lZ9OnYq7DGsTV9jaqaM805D9Pk8qKjRsaRf45bpCknCKcoD6sKa81HheUTZzvkDIbk
         uNZbM8xWkNkziG0WH2AA7AiDmjn6h4BjQ5TZoeoUFis9E5yppsNl0L59JnoxtFxqvH69
         vtRwVfIuQHgJIHEazCnvcnJMMeSnYhgJwz5C4yqrXM+G2lsHFk3KuI3I1PsiiFV6TC6b
         msE7IPqzFABLwt4HJZQpCKK9tld8DK0qe8C84gFMMAnDAZweoFpFL0523Tn1Yt5NMbrb
         cgMU3pvoJJ+xf07FfcOXCeplF4w8rJSexwXy+aGs01kj5fgr5J3Xq4Ntl+Cu35oTohqb
         +xQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=fEsYQc1o8wtZRn7XWvWCcHI1wzttGxG94SsKRFtCE88=;
        b=ozEfc+1AdTbgsnG8daLYxIJx4lsOXdkzVoed/wgJnoXVYk/sEaTIp+RUOiMcKBT3+K
         9A6OZGGeb9KQIGhRwmKkcp4zz1V06vJlQnZaeonEwMbyDtkoxh5eAOyjGVGtqbXOftRP
         Jh/ugmOzjSyGken7SwO/iexn67hCUOuWgjKcc1LwBu+aGnhsVgkctNU03AG0fq3bm04Y
         3wm/KZHbxS0xUhQKfsieRuBWxWXuBcDn7A65K5q8BHn+hGCc4uGJdjDA4qJyoB2HJ0Ja
         /kSMfhQ2xtfHxzDNVQ+BdxkpbQ+Zy3E6Nbz3ROUg0zK/tmLB6vIUy47MSdLaALXniAHb
         ZOLA==
X-Gm-Message-State: AOAM531p3Jw9KRixl7WfDvmob2uChXizyoZflvno4ZStc6Wp7/PI1k1X
        Dq/C7UY9EEjhIsw4yLqNvJo=
X-Google-Smtp-Source: ABdhPJzNeZo0kFkJErm31P77N0woNajW0s2MIwSQikuJ6hzPu6Pb57NR2MTH2p/pbuMI2yqlmww9Pg==
X-Received: by 2002:a05:6402:288f:b0:42a:ad43:a39b with SMTP id eg15-20020a056402288f00b0042aad43a39bmr29883768edb.342.1653416576311;
        Tue, 24 May 2022 11:22:56 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906550200b006f3ef214de1sm7363872ejp.71.2022.05.24.11.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 11:22:55 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntZBH-003UFL-4g;
        Tue, 24 May 2022 20:22:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 3/7] scalar: validate the optional enlistment argument
Date:   Tue, 24 May 2022 20:11:57 +0200
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
 <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
 <da9f52a82406ffc909e9c5f2b6b5e77818d972c0.1652210824.git.gitgitgadget@gmail.com>
 <220517.867d6k6wjr.gmgdl@evledraar.gmail.com> <xmqqbkvuwxps.fsf@gitster.g>
 <220520.86fsl43bkf.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2205201753300.352@tvgsbejvaqbjf.bet>
 <220521.86leuv199g.gmgdl@evledraar.gmail.com> <xmqqleuuazew.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2205241423260.352@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <nycvar.QRO.7.76.6.2205241423260.352@tvgsbejvaqbjf.bet>
Message-ID: <220524.86h75ex01s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 24 2022, Johannes Schindelin wrote:

> Hi Junio,
>
> On Sat, 21 May 2022, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>> >> Scalar is not (yet?) a Git command.
>> >
>> > "test-tool" isn't "git" either, so I think this argument is a
>> > non-starter.
>> >
>> > As the documentation for "test_must_fail" notes the distinction is
>> > whether something is "system-supplied". I.e. we're not going to test
>> > whether "grep" segfaults, but we should test our own code to see if it
>> > segfaults.
>> >
>> > The scalar code is code we ship and test, so we should use the helper
>> > that doesn't hide a segfault.
>> >
>> > I don't understand why you wouldn't think that's the obvious fix here,
>> > adding "scalar" to that whitelist is a one-line fix, and clearly yields
>> > a more useful end result than a test silently hiding segfaults.
>>
>> FWIW, I don't, either.
>
> Because we are still talking about code that lives as much encapsulated
> inside `contrib/scalar/` as possible.
>
> The `! scalar` call is in `contrib/scalar/t/t9099-scalar.sh`.
>
> To make it work with Git's test suite, you would have to bleed an
> implementation detail of something inside `contrib/` into
> `t/test-lib-functions.sh`.

The "scalar" command is already built by the top-level Makefile, so I
don't think the distinction you're trying to maintain here even exists
in practice.

I.e. if we ran with this strict reasoning then surely "scalar" belongs
on there just as much as "test-tool" does.

Both are built by our main build process, and thus should have
corresponding adjustments in our main test code, just as is already the
case for both "git" and "test-tool".

But even if that wasn't the case I'd still be of the view that we should
add "scalar" to that list.

It's just a matter of potential time sinks in the future. If we
introduce a hidden segfault in the scalar code and don't notice for some
time because we're using that test pattern that's going to suck, and
likely to waste a lot of time. We might even ship a broken command to
users.

Whereas having "scalar" on that list is going to be a relatively easy
matter of grepping and doing some boilerplate changes if and when we
ever "git rm" it entirely, or "promote it" from contrib or whatever.

I also think that just getting rid of that whitelist entirely is an
acceptable solution. Perhaps it's just being overzealous in forbidding
everything except "git", we should still not use it for the likes of
"grep", but we could just leave that to the documentation.

But I suspect Junio would disagree with that, so in lieu of that ...

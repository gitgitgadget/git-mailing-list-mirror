Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AF8C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 23:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbhLUXmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 18:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbhLUXmg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 18:42:36 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9743C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 15:42:35 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id j6so1295917edw.12
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 15:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=QMaOCNjnUPtJJSJEZj/PDFgEVAy/bvPGylOIkIgu1M4=;
        b=W/zExr4ZaZF6y6BpCE3Ft4mrgjfp/hFbNss3C64eBy2Dq+YPDLM9tsOFk3iIdqn8K5
         w/iGsjzF0JSsQ6LNt8z1NytZa3AmJYh5GrfHFJkDTPS8IhoszPaENV7JCfU/3ap5aX5m
         Y6D8mThDKppo5ImuJ5jPN8K+Zcd6t29aP56lpvAf9V142h8IcAvTDtiJfDleQCZ7Eowp
         rQuXRSdu4MAsD1rtO17ZGHVIeBVfB0UKdM+1wk4bgBEgrlqPd7ThDW2760wGsg2b4mDa
         FFS8vJ7zbFIT+rX5Jt+7IGsm/pEKRUh0UJYw4KInvJybMt/KrK2FkNAWyxHF1dqAC2sm
         FWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=QMaOCNjnUPtJJSJEZj/PDFgEVAy/bvPGylOIkIgu1M4=;
        b=xY/RofObx3k6WjlE1r8Tz0vg4s9WzPpFGPrvYnBkD0t1mHBCHVCh/8VSMAe3gqXgAe
         OTmxjExzKY1Nee+FUtAbygsWDAELZwyZMNmx1crW7WOF9E0LHp1XGP+n7wuspKd8Sh9p
         dAqQyyhQTpZMSUELsc+DM99JPZIqMrivZlKOk9ZvXR9Nd80sZ4em628FtJsz3o2JDt1X
         nulKav1XmumqtIyvIH/RGlkHZ6fOd7U2Gu1KSzAhB0yHmchuBAbxQL8Me+soMeESC2h3
         DOa/kSXUTXNu13ooyICiP0PiUkpEGBl+Dnh8ARuFtfOiUBwqpXyraeHqYdMhdHKxDAUr
         kioQ==
X-Gm-Message-State: AOAM53147cg/3zdA3BFYsb3RNnq2qvpLZqHrOPLAFy0XhRScYQG17BNT
        FqLU7Tt3z1wp+zbROy7WYtE=
X-Google-Smtp-Source: ABdhPJyC3OjKKejOj6W2rsGJ0/UFCtAGtOOKAeQ3rEnTlVNdKUwj8QtXpLanyxxa2QNVGk8tccH2UA==
X-Received: by 2002:a50:fc91:: with SMTP id f17mr530638edq.252.1640130154416;
        Tue, 21 Dec 2021 15:42:34 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s16sm79253edt.30.2021.12.21.15.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 15:42:34 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzom9-0010O2-EV;
        Wed, 22 Dec 2021 00:42:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 00/10] range-diff: fix segfault due to integer overflow
Date:   Wed, 22 Dec 2021 00:36:51 +0100
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2112101528200.90@tvgsbejvaqbjf.bet>
 <59ec39af-fdb1-a86a-d2be-37e5954e245f@iee.email>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <59ec39af-fdb1-a86a-d2be-37e5954e245f@iee.email>
Message-ID: <211222.86r1a5plsm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 21 2021, Philip Oakley wrote:

> Sorry for the late comment..
>
> On 10/12/2021 14:31, Johannes Schindelin wrote:
>> Hi =C3=86var,
>>
>> On Thu, 9 Dec 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>>> The difference between "master" and "git-for-windows/main" is large
>>> enough that comparing the two will segfault on my system. This is
>>> because the range-diff code does some expensive calculations and will
>>> overflow the "int" type.
>> You are holding this thing wrong.
>>
>> The `main` branch of Git for Windows uses merging rebases, therefore you
>> need to use a commit range like
>> `git-for-windows/main^{/^Start.the.merging}..git-for-windows/main` and
>> compare it to `git-for-windows/main..master`.
>
> I'm not sure that a Git repo has an established way of indicating to how
> it's branching/merging/releasing workflow is set up, especially for
> projects with non-normative use cases, such as Git for Windows. We don't
> have a git document for covering=C2=A0 the different workflows in common =
use
> for easy reference and consistent terminology.
>
> The merging rebase flow, with 'fake' merge does solve a problem that
> git.git doesn't have but could easily be a common process for 'friendly
> forks' that follow an upstream with local patches. The choice of
> '{/^Start.the.merging}' is currently specific to the Git-for-Windows
> case making it harder to discover this useful maintainer method.

Yes, but let's not get lost in the weeds here. As I noted I just picked
GFW as a handy example of a large history & that command as a handy
example of something that segfaults on "master".

So the point really isn't to say that we should fix range-diff becase
it'll allow us to run this practically useful command on a git.git fork.

> I fully agree that the range-diff should probably have a patch limit at
> some sensible value.

Why would it? If I'm willing to spend the CPU to produce a range-diff of
an absurdly large range and I've got the memory why shouldn't we support
it?

We don't in cases like xdiff where it's not trivial to just raise the
limits, but here it seems relatively easy.

I think limits to save users from spending CPU time they didn't expect
are reasonable, but then we can handle them like the diff/merge rename
detection limits, i.e. print a warning/advice, and allow the user to
opt-out.

That also doesn't really apply here since "diff/merge" will/might still
do something useful in those scenarios, whereas range-diff would just
have truncated output.

> The 'confusion' between the types size_t, long and int, does ripple
> through a lot of portable code, as shown in the series. Not an easy probl=
em.

Yes, although here we're not just casting and overflowing types, but
overflowing on multiplication and addition, whereas usually we'd just
overflow on "nr" being too big for "int" or similar.

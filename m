Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD181C433EF
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 16:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351218AbhLXQte (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 11:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbhLXQtc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 11:49:32 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952E2C061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 08:49:32 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id m21so36477398edc.0
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 08:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qW4hR3jolRXv9N4ssjVutMYtkfOt29rIjoeXa9hjf0U=;
        b=bz8Mu9n4O3W7IAT4MXNEbo5AJ3SYvRCtW6VX7zUo/6p0FAzH1ipQ1kgrW/JCZ2RsBE
         8alOQde7OjSPtw9SU3mh0ngl1qztThba6ioIjYqItViDVJdVoY6mKVmtuACMn24rsmGh
         tUYSdyzyFAzGi9hdY/+jcZgLLcGRx1AP7IPik5CkBhuX2+uucbJU5sxhdOReHPoPCih4
         RCTIuaf6gEI6vCdKiAk+tNv3bSNKY40jIsBD7jiHdPp+WqZbtYGxSF9Y0Xbsc14YGEJm
         z/y7pWD9SJOLUCevknxfj43Ks+OzJMNPKJyi1AUxx4LGcAp0DnseQgJgT3Km27ugd18c
         bDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qW4hR3jolRXv9N4ssjVutMYtkfOt29rIjoeXa9hjf0U=;
        b=cA7Sy4I/E6PNPCGX85OV5b86UApC8kf7pQXPJmNX9dwMORFWDbpW0N1Lxne6hfyp8B
         0tyQLdtkZf8w2cYeUhKyp5HzmhKJ8TkBUed/ANNRH3B/UElEjLgWAEOex5IL6j76Ha6D
         pRKq45kRcTAaMzG7YjkPg49fxv/6tP0f0abGOiDlOg5ZteIz7zPYXADWSNsuLEA1iGlw
         4hsxNoaY9SjiEyslAx/VyWIKibfq9nvyBP3lqvfG7FoFMp6XjfYAa1dKKQL6Kip/aG7J
         O49NPssVE/fOs4w7SiussRgjfF+ztOdVIIyV2ngywXY71VdMNoH0hIa8BY435ne2KXbZ
         2INg==
X-Gm-Message-State: AOAM533NNF66DhEsUbD7LYTBZv9Kggdk6i3Hkzj7alljjayb49cXK0FT
        Fei1YYrcG8eIyoXR1fjIXwQ=
X-Google-Smtp-Source: ABdhPJz65dObjhypLK2Ess1b7NAQurU3KbiOZTmQfTDNu9Fm9dsityX0vnI9uInSDkBv6vriOlayjQ==
X-Received: by 2002:a05:6402:1203:: with SMTP id c3mr6436997edw.253.1640364571071;
        Fri, 24 Dec 2021 08:49:31 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id qa30sm2832559ejc.54.2021.12.24.08.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 08:49:30 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n0nl3-000260-Cq;
        Fri, 24 Dec 2021 17:49:29 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 00/10] range-diff: fix segfault due to integer overflow
Date:   Fri, 24 Dec 2021 17:46:26 +0100
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2112101528200.90@tvgsbejvaqbjf.bet>
 <59ec39af-fdb1-a86a-d2be-37e5954e245f@iee.email>
 <211222.86r1a5plsm.gmgdl@evledraar.gmail.com>
 <c2bf8e3b-d758-6c60-506b-293d5be49eb6@iee.email>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <c2bf8e3b-d758-6c60-506b-293d5be49eb6@iee.email>
Message-ID: <211224.86zgoqgd7q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 24 2021, Philip Oakley wrote:

> On 21/12/2021 23:36, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Tue, Dec 21 2021, Philip Oakley wrote:
>>
>>> Sorry for the late comment..
>>>
>>> On 10/12/2021 14:31, Johannes Schindelin wrote:
>>>> Hi =C3=86var,
>>>>
>>>> On Thu, 9 Dec 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>>
>>>>> The difference between "master" and "git-for-windows/main" is large
>>>>> enough that comparing the two will segfault on my system. This is
>>>>> because the range-diff code does some expensive calculations and will
>>>>> overflow the "int" type.
>>>> You are holding this thing wrong.
>>>>
>>>> The `main` branch of Git for Windows uses merging rebases, therefore y=
ou
>>>> need to use a commit range like
>>>> `git-for-windows/main^{/^Start.the.merging}..git-for-windows/main` and
>>>> compare it to `git-for-windows/main..master`.
>>> I'm not sure that a Git repo has an established way of indicating to how
>>> it's branching/merging/releasing workflow is set up, especially for
>>> projects with non-normative use cases, such as Git for Windows. We don't
>>> have a git document for covering=C2=A0 the different workflows in commo=
n use
>>> for easy reference and consistent terminology.
>>>
>>> The merging rebase flow, with 'fake' merge does solve a problem that
>>> git.git doesn't have but could easily be a common process for 'friendly
>>> forks' that follow an upstream with local patches. The choice of
>>> '{/^Start.the.merging}' is currently specific to the Git-for-Windows
>>> case making it harder to discover this useful maintainer method.
>> Yes, but let's not get lost in the weeds here. As I noted I just picked
>> GFW as a handy example of a large history & that command as a handy
>> example of something that segfaults on "master".
>
> Had you already experienced the segfault locally, without using the GFW
> example? How many commits were present in that case?

Yes, I ran into it "orginally" just range-diffing as part of a local
build process.

I could dig up what revision range it was exactly, but does it matter?

> The GFW example seems like it's taken the discussion in the wrong directi=
on.
>
> For me:
> $ git log git/master..origin/main --pretty=3Doneline | wc -l
> 62105
>
> That's a lot of commits to have in a range diff. It's almost as big as
> the whole of git/master
>
> $ git log git/master --pretty=3Doneline | wc -l
> 65400
>
> Personally I'd like a way of trimming 'deadheads' that's a bit easier
> that needing to remember Dscho's magic string [1], but time will tell.

There are some repos that move forward by 500-1k commits/day, and people
do cherry-pick patches etc. So wanting to range-diff after a couple of
months is something you might do...

>> So the point really isn't to say that we should fix range-diff becase
>> it'll allow us to run this practically useful command on a git.git fork.
>>
>>> I fully agree that the range-diff should probably have a patch limit at
>>> some sensible value.
>> Why would it? If I'm willing to spend the CPU to produce a range-diff of
>> an absurdly large range and I've got the memory why shouldn't we support
>> it?
>
> There will always be a limit somewhere, and if it's not commit count or
> other easily explained & checked limit it will be hard to rationalise
> about why Git suddenly fails with an error (or segfault) in those
> humungous case.

I think it's fairly easy to explain the "your system wouldn't let us
malloc more, we're dying" that we get from xmalloc(), st_*() and the
like.

>>
>> We don't in cases like xdiff where it's not trivial to just raise the
>> limits, but here it seems relatively easy.
>>
>> I think limits to save users from spending CPU time they didn't expect
>> are reasonable, but then we can handle them like the diff/merge rename
>> detection limits, i.e. print a warning/advice, and allow the user to
>> opt-out.
>>
>> That also doesn't really apply here since "diff/merge" will/might still
>> do something useful in those scenarios, whereas range-diff would just
>> have truncated output.
>>
>>> The 'confusion' between the types size_t, long and int, does ripple
>>> through a lot of portable code, as shown in the series. Not an easy pro=
blem.
>> Yes, although here we're not just casting and overflowing types, but
>> overflowing on multiplication and addition, whereas usually we'd just
>> overflow on "nr" being too big for "int" or similar.
> I've been very slowly looking at the `long` limits on GFW which have
> very similar arithmetic issues for pointers, often with no clear answers.

Right, that's to do with the whole "long" or whatever use in the
object.c and related code, but I don't think that's applicable here, is
it?

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41553C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 15:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381426AbhLFP5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 10:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378362AbhLFPxI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 10:53:08 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9166FC061359
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 07:39:17 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z5so45053221edd.3
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 07:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RdKd9R4wvsjW5n3+OTNLZQEuUGJ8fM/KztanCVs96vw=;
        b=Z+ztJ6ni1jrU03MNfzlcXpH8Nw7jp+ibQb6nZ/00BxilBGTc1dskXdVPVXxp3/vDmH
         C8PVLgFhagA2CZFEQm14G2cfWIGI1Jkfm8SbMh/oKjh6aOtLOaONQl0sS2zds0a3WuY9
         hzqRwnf/r7Fo3DQPswZSsJrmaNbWa7IxB0YFLBqLxuLgGi13Uo8J0puNrodgbTte9VJO
         sQsZCBvoMkr8JrcKXPxF3ZTwj9gRmwE0UzlDgpIirjfUF9PbsBLwYXJuATu1GSvrF7QC
         OTAp4Fxm2086/YWpdlsZe8Boyy8hewrcLT5tl7JiAdd1WY2gT/Ox8m0p+egxFA5RtpEd
         xFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RdKd9R4wvsjW5n3+OTNLZQEuUGJ8fM/KztanCVs96vw=;
        b=a2dhphcJIOMa/BDw3Rsm0ScDpHCWrzy2FGR9C49mImUiJP2L3gJmU26FUR+PvYuJ8N
         /4cxJuI6ziM1ZcBLH62FHXpCfc4Hau2PV9fDHZI5u/bKPjCfYJiofBZIabyromwR7SOI
         Sh9HWgfjyny8yK234yFi5bbYjvZB7EiRPevYuqmiX4MTJ8JUXdbJSsrfy/RX6X+Y05rq
         Ppk1pAU0hyIOAyxSz9Q96pmfl9KQdJXdhs8YcdJ7ZFZ6KbSK7PouKk0uXKNbSL+s1v0c
         AQwTAtJjhx3K2lt3ilWyA7KWWJjDEawPfktHYC8utJ8pmBoK97wZGMyRuAFtihPGmXXJ
         riPA==
X-Gm-Message-State: AOAM5317mBOPKdbM8czkGhxSiLK9OoUC9ZNCWt+NNQwdeLtgPZbpVwOo
        1CKDs+eLkmT6d11cRlv0MdkoBKbpQ8Q=
X-Google-Smtp-Source: ABdhPJwPgh2xKxMsaTLCAmPPp0PEWf7oj38Zcmk4L2VZ9Sp7kDvGiTYAr3+5TEfUk0bWB0SBRk5krA==
X-Received: by 2002:a17:907:2627:: with SMTP id aq7mr45593696ejc.483.1638805156020;
        Mon, 06 Dec 2021 07:39:16 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ch28sm7982536edb.72.2021.12.06.07.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:39:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muG5C-000oSE-OF;
        Mon, 06 Dec 2021 16:39:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Jeff King <peff@peff.net>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [PATCH 2/2] git-worktree.txt: add missing `-v` to synopsis for
 `worktree list`
Date:   Mon, 06 Dec 2021 16:06:10 +0100
References: <20211203034420.47447-1-sunshine@sunshineco.com>
        <20211203034420.47447-3-sunshine@sunshineco.com>
        <211203.86k0gmt5fl.gmgdl@evledraar.gmail.com>
        <CAPig+cR7f1koM7d2GoHMcDhZkQe3=XJD2RVuMajXSpcwZiyGtQ@mail.gmail.com>
        <xmqqa6hfmn3u.fsf@gitster.g>
        <CAPig+cQ82UC3MRSswGtnCcB13wdhTNYzDex=tFSuFwFCjL3ErA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CAPig+cQ82UC3MRSswGtnCcB13wdhTNYzDex=tFSuFwFCjL3ErA@mail.gmail.com>
Message-ID: <211206.86bl1trbdp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 06 2021, Eric Sunshine wrote:

> On Sun, Dec 5, 2021 at 4:12 AM Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> > On Fri, Dec 3, 2021 at 4:15 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>> >> Aside: I've been thinking of hacking something up to just change all
>> >> these "[verse]" bits in the *.txt source to:
>> >>
>> >>     [verse]
>> >>     $(git worktree -h)
>> >>
>> >> And then have the doc build process pick that up, run 'git $name -h',=
 do
>> >> some light search/replacement (e.g. "$cmd" to "'$cmd'") and build the
>> >> docs like that.
>> >
>> > One caution that springs to mind is that there may be external tooling
>> > which processes these documentation files directly, and such a change
>> > might break them. (The one which popped to mind immediately was the
>> > git-scm.{org,com} website, though I don't know what their tooling
>> > looks like.)
>>
>> Also it would slow us down by making the .txt variant we see in the
>> source tree harder to read (or in this case, impossible to see without
>> building the documentation).
>
> Taking this point into consideration, a middle-ground alternative to
> =C3=86var's idea would be to add tooling which only compares (by some
> definition of "compare") the output of `git blah -h` with the synopsis
> in `git-blah.txt` and complains if there are significant differences
> (by some definition "significant" and "difference"). It doesn't
> automate-away the work of keeping the synopsis up-to-date, but at
> least would flag inconsistencies.

Or we could do the reverse and move the source code version of it to be
generated from the [verse] sections in the documentation.

Anyway, it's not something I was planning to work on any time soon, just
something I'd thought was a good idea for a while, especially given the
differences and divergenge. That can be viewed with:

    parallel -k '
        git {} -h 2>&1 | grep -e "^usage" -e "^   or";
        git help {} 2>&1 | grep -A20 SYNOPSIS | grep -B20 DESCRIPTION
    ' ::: $(git --list-cmds=3Dbuiltins) | less

It's a long-standing UX issue, and we keep re-introducing divergence
between the two.

If we're going to insist that the version in the *.txt file isn't
generated that categorically closes the door to some logical follow-ups.

E.g. having parse-options automatically generate alternates in cases
where options are mutually exclusive, or adding color output to this
where we color short/long options differently than arguments etc.

That and e.g. translators needing to do less work for the translated
manpages (we already have the translated output in the C code).

Well, I suppose we could have a generating step and then commit the
equivalent of the compiled file (or section) into git.git every time we
add/change an option.

In general I don't think it's a worthwhile goal to keep the .txt
versions of the docs as some human-readable 1=3D1 mapping to what you'd
get if you generated them. That's already not the case due to includes,
and e.g. in this case accepting some reasonable amount of
auto-generation would make them easier to maintain.

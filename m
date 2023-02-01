Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DA4C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 15:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjBAPWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 10:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjBAPWe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 10:22:34 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABFD7267D
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 07:22:09 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id s4so17234992qtx.6
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 07:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0uguLSydsc4uQVzDAMZx03aBxkPtj0v9HDBaEoYeew=;
        b=jtbjYCqB1yxv0WBM2qFMAkqukk3dYcXlR5Wtq9IDoXCPuQXFDFZ45xLvLAwhO8PWiW
         nLDoodT7DWwwT4DevncyP2efKu5iyXh4G9MDAxentDEaFZq9tTAsdbefnfwwHL8Hfgjk
         jyHm/tK2f0Ygmzu2qfgBrUi8g+yqCWQ7SCxo7iN3DEzmyW80H4/VMLqAjEbm41gy3uXi
         p6BTxj1G2W1UYhAGLitE5S28exxFQ03y6WgoTVH1Y8UoYCXPn0Csgm8N2Weu3bLH05mj
         v/gU++wfQBaUJuXcxjIi1f83PGJPJqyEYJ/Nr92o95e689FjXce2L04KQU5H3R9SYELo
         +RIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0uguLSydsc4uQVzDAMZx03aBxkPtj0v9HDBaEoYeew=;
        b=oESdmjxucLRO7+6ebO243Mjh2eqcy3zx4v9epQ9kVS6Ins1VEy0LQKAsPpQWJFwzHM
         BbrYSisseZO/S9KL/CA6wa1wfcpv3HKYl4kRapNhtOG1gHkCNFiPSCk8LS/9Gt2XxVqN
         dX95Vgj5CEuJu7W1saJ7P/P59O0XCRMmzjaWXuAq5pvtZiROSCzMS2/XvzzwEYtmfKgH
         +a8jQdrqSa6TquHyq/BzHR+pNRVIC+1D35K28Bwf0dhWoBoKkmvBzv4ePs0Ai5mWWj6j
         ykWwsLvI+qnd5x5asvCkOMXvwv6of10/RCexNoKCGcKuZVTCtBDYw+QpGBRv7/ufgwP9
         Gd8A==
X-Gm-Message-State: AO0yUKW+4CgB0ohHF0rThVECRfhoid79Q40KZLj9POWzLaKV9ydptgQR
        I/YSmTrEHwnf6isGOz2gP00Z/GDLOTddJ0wcjU4=
X-Google-Smtp-Source: AK7set/wFo6H1Z0fIubTIzxaQvJ840zXQ4Ck/U2EcHQKUPNvV+TFL6fAsI80wc/qW0cqK5lLRRkZCWZE8LZkZZ1MenU=
X-Received: by 2002:a05:622a:14d:b0:3b8:669d:4f2f with SMTP id
 v13-20020a05622a014d00b003b8669d4f2fmr326372qtw.364.1675264927824; Wed, 01
 Feb 2023 07:22:07 -0800 (PST)
MIME-Version: 1.0
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net> <20230131150555.ewiwsbczwep6ltbi@meerkat.local>
 <Y9mXB1LaYSUJBlwF@tapette.crustytoothpaste.net> <230201.86pmatr9mj.gmgdl@evledraar.gmail.com>
 <CANgJU+V0QRFwmTh8ZzY=28kmbUw=DvSLE24LioOXp6_ozq+RdA@mail.gmail.com>
 <20230201122152.GJ19419@kitsune.suse.cz> <CANgJU+VLseURimM++38WA81uFPbnoHiToOt4F4UFL9yVbQpBEw@mail.gmail.com>
 <230201.86cz6tqyvy.gmgdl@evledraar.gmail.com>
In-Reply-To: <230201.86cz6tqyvy.gmgdl@evledraar.gmail.com>
From:   demerphq <demerphq@gmail.com>
Date:   Wed, 1 Feb 2023 16:21:56 +0100
Message-ID: <CANgJU+VNY-VziRijSwyb1WF9s31hKroK+2VJ0qEGiYweiA59Ug@mail.gmail.com>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and a
 possible solution
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 1 Feb 2023 at 14:49, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com> wrote:
>
>
> On Wed, Feb 01 2023, demerphq wrote:
>
> > On Wed, 1 Feb 2023, 20:21 Michal Such=C3=A1nek, <msuchanek@suse.de> wro=
te:
> >>
> >> On Wed, Feb 01, 2023 at 12:34:06PM +0100, demerphq wrote:
> >> > Why does it have to be gzip? It is not that hard to come up with a
> >
> >> historical reasons?
> >
> > Currently git doesn't advertise that archive creation is stable
> > right[1]? So I wrote that with the assumption that this new
> > compression would only be used when making a new archive with a
> > hypothetical new '--stable' option. So historical reasons don't come
> > up. Or was there some other form of history that you meant?
>
> We haven't advertised it, but people have come to rely on it, as the
> widespread breakages reported when upgrading to v2.38.0 at the start of
> this thread show.
>
> That's unfortunate, and those people probably shouldn't have done that,
> but that's water under the bridge. I think it would be irresponsible to
> change the output willy-nilly at this point, especially when it seems
> rather easy to find some compromise everyone will be happy with.
>
> > I'm just trying to point out here that stable compression is doable
> > and doesn't need to be as complex as specifying a stable gzip format.
> > I am not even saying git should just do this, just that it /could/ if
> > it decided that stability was important, and that doing so wouldn't
> > involve the complexity that Avar was implying would be needed.  Simple
> > compression like LZ variants are pretty straightforward to implement,
> > achieve pretty good compression and can run pretty fast.
> >
> > Yves
> > [1] if it did the issue kicking off this thread would not have
> > happened as there would be a test that would have noticed the change.
>
> I have some patches I'm about to submit to address issues in this
> thread, and it does add *a* test for archive output stability.
>
> But I'm not at all confident that it's exhaustive. I just found it by
> experiment, by locating tests ouf ours where the "git archive" output at
> the end is different with gzip and "git archive gzip".
>
> But is it guaranteed to find all potential cases where repository
> content might trigger different output with different gzip
> implementations? I don't know, but probably not.

BTW, I just happened to be looking at the zstd docs (I am updating
code that uses it), I saw this:

Zstandard's format is stable and documented in
[RFC8878](https://datatracker.ietf.org/doc/html/rfc8878). Multiple
independent implementations are already available.
This repository represents the reference implementation, provided as
an open-source dual [BSD](LICENSE) and [GPLv2](COPYING) licensed **C**
library,
and a command line utility producing and decoding `.zst`, `.gz`, `.xz`
and `.lz4` files.
Should your project require another programming language,
a list of known ports and bindings is provided on [Zstandard
homepage](http://www.zstd.net/#other-languages).

So it sounds like that is a spec you could use. Not sure exactly what
they mean by "stable", but given the .gz compatibility maybe it would
be worth considering. Its a lot faster than zlib. (The library I
support includes Snappy, Zlib, and Zstd, and the latter is faster and
better than the other two.)

Yves
--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E270C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 17:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348665AbiAGR6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 12:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348655AbiAGR6M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 12:58:12 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27191C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 09:58:12 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id j83so19006506ybg.2
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 09:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LPN3ZDACG3K3P5NwMndTIgky1oMFWj2zHE1doqdQkwk=;
        b=VY8NzUud+I8tdNfx5AXM2CYq2J6vycY2n9TP+wjsRSE2ca3sIpl6SAz5GyMpcEUtGm
         7h1spAHp0Bg1Paf7NEWMWB9+qoqHDvwIvLqn7TayNQwEAtAfSKOV1Q5wD3YpSuQ79aiK
         nIodH4NlCMuKxCZ+eHgQHG4V5xGh7pX6vx9BJqkogXcibNZ5nQb7IBPzSjkta4NJUe1R
         h96S2ODCIw+7fHbR7z+EGNWeGQ5YTMd9dgntNj1B9ZQqu3hGtKLAnnGX54z5X7HW45OL
         v6mds82MboelUfGwYbOYLgoFdKHcron9KcM1kAQ+wbNDMILl5zkXrXl9ASJspsPUkyfx
         2IRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LPN3ZDACG3K3P5NwMndTIgky1oMFWj2zHE1doqdQkwk=;
        b=LmYyW946ro0CmrpQo9PDkhuncHVxM+bK+9AmpY+Ox8yfnmBVgA30gH57Ed+PdDyTW+
         YVQHNPOSOLOYhDYJG83b945y1gi3IPa0+PNw3gsLQVV5Qg9jsfn+KsMsasvdH3/X2d6u
         45qK9WwAxFX6B3OTPuwOLJRxP38iPXMtoHMEqZcMaAYd6HreEprA7/UxClZjAW/lWjZd
         kKl6/VdMTvfNcDgSLj0M0yaTfDTpTQHJ91bTyoxIqfnGe832FV9eQiJK02G63SvxYFhO
         LBxeAa++AqBhcB976HPtEPl1isEqGHPxHPDyH+3MBEn5I1irBGr3NYGStdnBda0/Fiwe
         +XFQ==
X-Gm-Message-State: AOAM532PeEJ2SAugM+dhxjoHIkNcPjgHr+JhVlpuI7EalfjUoquqpkFZ
        g4iOU/hCWlMciNwh/16Q+nZ4I2I0VZfQkGEVSY8=
X-Google-Smtp-Source: ABdhPJxs91YtgTF9Hpjkvuq+MBpIKFGwkoGl2BKeeNFQZWO83xa4+Oq4WxCB1jjzfR2Y4IfJ7tWn0UGqHRIgeFCKuO0=
X-Received: by 2002:a25:a522:: with SMTP id h31mr27314421ybi.631.1641578291182;
 Fri, 07 Jan 2022 09:58:11 -0800 (PST)
MIME-Version: 1.0
References: <20220105163324.73369-1-chriscool@tuxfamily.org> <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com>
In-Reply-To: <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 7 Jan 2022 18:58:00 +0100
Message-ID: <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Introduce new merge-tree-ort command
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 5, 2022 at 5:54 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, Jan 5, 2022 at 8:33 AM Christian Couder
> <christian.couder@gmail.com> wrote:

> > The current `git merge-tree` command though seems to have a number of
> > issues, especially:
> >
> >   - it's too much related to the old merge recursive strategy which is
> >     not the default anymore since v2.34.0 and is likely to be
> >     deprecated over time,
> >
> >   - it seems to output things in its own special format, which is not
> >     easy to customize, and which needs special code and logic to parse
>
> I agree we don't want those...but why would new merge-tree options
> have to use the old merge strategy or the old output format?

Yeah, it's not necessary if there are 2 separate modes, a "real" mode
(like what you implemented with --real in your recent patch series)
and a "trivial" mode (which is the name you give to the old code).

Adding modes like this to a command is likely to make the command and
its documentation more difficult to understand though. For example I
think that we created `git switch` because the different modes of `git
checkout` made the command hard to learn.

I gave other reasons in [1] why I prefer a separate command.

[1] https://lore.kernel.org/git/CAP8UFD1LgfZ0MT9=3DcMvxCcox++_MBBhWG9Twf42c=
MiXL42AdpQ@mail.gmail.com/

> > To move forward on this, this small RFC patch series introduces a new
> > `git merge-tree-ort` command with the following design:
>
> Slightly dislike the command name.

I am ok with changing the command name.

> `ort` was meant as a temporary,
> internal name.  I don't think it's very meaningful to users, so I was
> hoping to just make `recursive` mean `ort` after we had enough
> testing, and to delete merge-recursive.[ch] at that time.  Then `ort`
> merely becomes a historical footnote (...and perhaps part of the name
> of the file where the `recursive` algorithm is implemented).

I think something similar could still be done with `git
merge-tree-ort` or whatever name we give to this command. For example
we could first add --ort to `git merge-tree` and make it call `git
merge-tree-ort`, then after some time make --ort the default, then
after some more time remove `git merge-tree-ort`. And whenever we make
those changes we could also rename the builtin/merge-tree*.{h,c}
accordingly.

> >   - it uses merge-ort's API as is to perform the merge
> >
> >   - it gets back a tree oid and a cleanliness status from merge-ort's
> >     API and prints them out first
>
> Good so far.
>
> >   - it uses diff's API as is to output changed paths and code
> >
> >   - the diff API, actually diff_tree_oid() is called 3 times: once for
> >     the diff versus branch1 ("ours"), once for the diff versus branch2
> >     ("theirs"), and once for the diff versus the base.
>
> Why?  That seems to be a performance penalty for anyone that doesn't
> want/need the diffs, and since we return a tree, a caller can go and
> get whatever diffs they like.

I say somewhere else that I am planning to add options to disable this
or parts of this diff output.

I think it's still interesting for the command to be able to output
diffs, especially diffs of conflicting parts. In [2] =C3=86var said:

=3D> I.e. I'm not the first or last to have (not for anything serious)
=3D> implement a dry-run bare-repo merge with something like:
=3D>
=3D>     git merge-tree origin/master git-for-windows/main origin/seen >dif=
f
=3D>     # Better regex needed, but basically this
=3D>     grep "^\+<<<<<<< \.our$" diff && conflict=3Dt

Also `git merge-tree` currently outputs diffs, so I thought it would
be sad if the new command couldn't do it.

[2] https://lore.kernel.org/git/211109.861r3qdpt8.gmgdl@evledraar.gmail.com=
/

> > Therefore:
> >
> >   - its code is very simple and very easy to extend and customize, for
> >     example by passing diff or merge-ort options that the code would
> >     just pass on to the merge-ort and diff APIs respectively
> >
> >   - its output can easily be parsed using simple code
>
> These points are good.
>
> >     and existing diff parsers
> >
> > This of course means that merge-tree-ort's output is not backward
> > compatible with merge-tree's output, but it doesn't seem that there is
> > much value in keeping the same output anyway. On the contrary
> > merge-tree's output is likely to hold us back already.
> >
> > The first patch in the series adds the new command without any test
> > and documentation.
> >
> > The second patch in the series adds a few tests that let us see how
> > the command's output looks like in different very simple cases.
> >
> > Of course if this approach is considered valuable, I plan to add some
> > documentation, more tests and very likely a number of options before
> > submitting the next iteration.
>
> Was there something you didn't like about
> https://lore.kernel.org/git/pull.1114.git.git.1640927044.gitgitgadget@gma=
il.com/?

I was having a vacation at the time and even though I skimmed the
mailing list, I missed it. Sorry.

Also I thought that you might not be interested in this anymore as you
didn't reply to [1] and [2] where =C3=86var and I both said that we were
interested in your opinion on a git merge-tree on steroids.

> > I am not sure that it's worth showing the 3 diffs (versus branch1,
> > branch2 and base) by default. Maybe by default no diff at all should
> > be shown and the command should have --branch1 (or --ours), --branch2
> > (or --theirs) and --base options to ask for such output, but for an
> > RFC patch I thought it would be better to output the 3 diffs so that
> > people get a better idea of the approach this patch series is taking.
>
> I think not showing, neither by default

I am ok with not showing them by default.

> or at all would be better.
> All three of these are things users could easily generate for
> themselves with the tree we return.  I'm curious, though, what's the
> usecase for wanting these specific diffs?

I think I replied to this above.

> Two things you didn't return that users cannot get any other way: (1)
> conflict and warning messages, (2) list of conflicted paths.

Yeah, I wasn't sure how they could be returned with the merge-ort (or
maybe diff) API, and I thought that the current `git merge-tree`
doesn't report them, so I was aiming for something roughly just as
powerful as the current `git merge-tree`.

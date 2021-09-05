Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216ADC433EF
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 10:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1EE860FE6
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 10:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbhIEKGh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 06:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237534AbhIEKGh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 06:06:37 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3DEC061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 03:05:34 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id ay33so3852225qkb.10
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 03:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o2s5RCDj1flJaphCyks4o/McKwAb2xoJFGbVoKDnu3A=;
        b=BCBkJmKKo4Ej2y0uOhXf0wxZbk08rGhTRRczlPJX+vIXTErL+35Dnu6OQy+lQdpULi
         esmyPZznZu60ulhYUpTPdR86OV5VhX3U395bFtL4CB77+/O2Ug7rzusCwj4lb+qUzX/C
         kLpNPHkEXBlMHLeZZmL4Giq4hZsOguLWJUy0J3pPsF2NhyiN35uKD0ex9OdWUMwg08Fa
         O6jzDQBOuTxR3AtXaS42Jp94nmaxCsuntwyh+TqbQv5NUr3Rj1krLevmwCu1NF2b5+7Q
         L3mw9shSKEP8URzY5maDeE7poDTZtKfU4eRL2VNROI/x71nFABjNr8HRsAQXmIf5Vn/D
         s1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o2s5RCDj1flJaphCyks4o/McKwAb2xoJFGbVoKDnu3A=;
        b=sO+TiASC4Hb14qa3xgzkV0MddWBkcv2+XF3AVC/r3VtkioOcjBcMJ14CsVAhjYuPtf
         vGZ+RywcvD8y8CbADHZwzJbmTIP14o+pOn0kcFo8WLbtyeH3mDeP7f+gPbytYghYl/Os
         fKt8jDFSDW7i1l4k6desrTdEkgf9lE7sJSNWtOrGlOxtUGyTI3HcLmg8Q99pY/O9uV5k
         rQvpAZBLQKHXVc+w+Oy8+jn01slp7UvBkRJFGhzx6KImfgwkTZGlIjWZQ7IiZgIrUPZe
         y1ePylNsX2qQskxpXG7bTwKcqSfVK+2ixNB+tDM6mOnsVoc/q6DveeRYnTfGmfYcvJ32
         KxjA==
X-Gm-Message-State: AOAM5327J3EuJVoqMw/ONqj9SthuNYba7pF1gilXj5d0cU5AKgNtfzdx
        nt1eKtslOrvNhJtt6UDrVKb4GSFWQ5qd/wvYc5Y=
X-Google-Smtp-Source: ABdhPJyWgy7RN2iQvbzRZDIYnWWAixgH2Bo/YcXbc2a//y5SP2cEn3dt960K/KkrBsOXdp1ZoBZvYZ2sLsu3OQrCpbc=
X-Received: by 2002:a05:620a:430f:: with SMTP id u15mr6469686qko.32.1630836333407;
 Sun, 05 Sep 2021 03:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAG2t84Uaw-Kdp+EXU8CY1QYfykFQj-hGLJnTSH8MYO8Vi_yqgA@mail.gmail.com>
 <C357A648-8B13-45C3-9388-C0C7F7D40DAE@gmail.com> <dbe7d88d-4174-e080-03df-e35d0ac6004f@gmail.com>
 <YTNA6Qo6Yj5o9NmQ@coredump.intra.peff.net> <CAG2t84Xe2XwdwdAK42bRrwAeNaB3-A+WhgSsJGOoW9-rG1S9Xg@mail.gmail.com>
 <YTNH2vMPuEW4SBMo@coredump.intra.peff.net> <CABPp-BFyR19ch71W10oJDFuRX1OHzQ3si971pMn6dPtHKxJDXQ@mail.gmail.com>
 <87sfyjpiu3.fsf@evledraar.gmail.com>
In-Reply-To: <87sfyjpiu3.fsf@evledraar.gmail.com>
From:   Fedor Biryukov <fedor.birjukov@gmail.com>
Date:   Sun, 5 Sep 2021 12:05:22 +0200
Message-ID: <CAG2t84VNc=y2exEmq9UufBoeSSKqW45oXrjvtNfd7jBrsc0xtg@mail.gmail.com>
Subject: Re: Aborting 'rebase main feat' removes unversioned files
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Had a brief look at the code.
builtin/rebase.c is using rebase_head helper function defined in
rebase.c/h to do a checkout.
builtin/checkout.c does not use the rebase_head helper function.
I would expect both to use the same code defined in checkout.c/h, but
there is no such file.

On Sun, Sep 5, 2021 at 9:44 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Sat, Sep 04 2021, Elijah Newren wrote:
>
> > On Sat, Sep 4, 2021 at 3:19 AM Jeff King <peff@peff.net> wrote:
> >>
> >> On Sat, Sep 04, 2021 at 11:51:19AM +0200, Fedor Biryukov wrote:
> >>
> >> > There is no way this could be the intended behavior, but the good ne=
ws
> >> > is that I cannot reproduce it...
> >> > Looks like it occurs only in one git version (2.31.0.windows.1, IIRC=
).
> >> > And it does not occur in the latest git version: git version 2.33.0.=
windows.2.
> >>
> >> I think it is a bug, and it seems to reproduce easily for me (with bot=
h
> >> the current tip of master, and with v2.33.0). Here's the recipe you
> >> showed, with a little debugging at the end:
> >>
> >>   set -x
> >>   git init repo
> >>   cd repo
> >>   git commit -m base --allow-empty
> >>   git checkout -b feat
> >>   echo feat >readme.txt
> >>   git add readme.txt
> >>   git commit -m txt=3Dfeat
> >>   git checkout main
> >>   echo precious >readme.txt
> >>
> >>   cat readme.txt
> >>   git checkout feat
> >>   cat readme.txt
> >>   git rebase main feat
> >>   cat readme.txt
> >>
> >> This produces:
> >>
> >>   + cat readme.txt
> >>   precious
> >>   + git checkout feat
> >>   error: The following untracked working tree files would be overwritt=
en by checkout:
> >>         readme.txt
> >>   Please move or remove them before you switch branches.
> >>   Aborting
> >>   + cat readme.txt
> >>   precious
> >>   + git rebase main feat
> >>   Current branch feat is up to date.
> >>   + cat readme.txt
> >>   feat
> >>
> >> So git-checkout was not willing to overwrite the untracked content, bu=
t
> >> rebase was happy to obliterate it.
> >>
> >> It does the right thing in very old versions. Bisecting, it looks like
> >> the problem arrived in 5541bd5b8f (rebase: default to using the builti=
n
> >> rebase, 2018-08-08). So the bug is in the conversion from the legacy
> >> shell script to C (which makes sense; the shell version was just calli=
ng
> >> "git checkout", which we know does the right thing).
> >>
> >> -Peff
> >
> > Turns out this is quite a mess.  It's also related to the "don't
> > remove empty working directories" discussion we had earlier this
> > week[1], because we assumed all relevant codepaths correctly avoided
> > deleting untracked files and directories in the way.  But they don't.
> > And rebase isn't the only offender, because this is buried in
> > unpack_trees.  In fact, it traces back to (and before)
> >     fcc387db9b ("read-tree -m -u: do not overwrite or remove untracked
> > working tree files.", 2006-05-17)
> > which has additional commentary over at
> > https://lore.kernel.org/git/7v8xp1jc9h.fsf_-_@assigned-by-dhcp.cox.net/=
.
> > It appears that before this time, git happily nuked untracked files
> > and considered them expendable, in basically all cases.  However, this
> > patch continued considering them as expendable whenever opts->reset
> > was true.  There wasn't much comment about it at the time for the
> > reasoning of how opts->reset was handled, though trying to read
> > between the lines perhaps Junio was trying to limit the backward
> > compatibility concerns of introducing new errors to fewer code paths?
> > Anyway, Junio did mention `read-tree --reset` explicitly, but this
> > opts->reset usage also occurs in am, checkout, reset -- and anything
> > that calls the reset_head() function including: rebase, stash,
> > sequencer.c, and add-patch.c.
> >
> > So, then...should we preserve untracked (and non-ignored) files in all
> > these cases?  This rebase case seems clear, but others might be less
> > clear.  For example, should "git reset --hard" nuke untracked files
> > (what if it's a directory of untracked files getting nuked just to
> > place a single file in the location of the directory)?  The
> > documentation isn't explicit, but after reading it I would assume that
> > untracked files should be preserved.  Since we've had bugs in "git
> > reset --hard" before, such as requiring two invocations in order to
> > clear out unmerged entries (see [2] and [3]), that also suggests that
> > this is just another bug in the same area.  But the bug has been
> > around so long that people might be expecting it; our testsuite has
> > several cases that incidentally do.  Granted, it's better to throw an
> > error and require explicit extra steps than to nuke potentially
> > important work, but some folks might be unhappy with a change here.
> > Similarly with "git checkout -f".
> >
> > And stash.c, which operates in that edge case area has tests with
> > files nuked from the cache without nuking it from the working tree
> > (causing the working tree file to be considered untracked), and then
> > attempts to have multiple tests operate on that kind of case.  Those
> > cases look a bit buggy to me for other reasons (I'm still digging),
> > but those bugs are kind of hidden by the untracked file nuking bugs,
> > so fixing the latter requires fixing the former.  And stash.c is a
> > mess of shelling out to subcommands.  Ick.
> >
> > I have some partial patches, but don't know if I'll have anything to
> > post until I figure out the stash mess...
>
> I'd just like to applaud this effort, and also suggest that the most
> useful result of any such findings would be for us to produce some new
> test in t/ showing these various cases of nuking/clobbering and other
> "non-precious" edge cases in this logic. See[1] and its linked [2] for
> references to some of the past discussions around these cases.
>
> 1. https://lore.kernel.org/git/87a6q9kacx.fsf@evledraar.gmail.com/
> 2. https://lore.kernel.org/git/87ftsi68ke.fsf@evledraar.gmail.com/
>
> > [1] https://lore.kernel.org/git/YS8eEtwQvF7TaLCb@coredump.intra.peff.ne=
t/
> > [2] 25c200a700 ("t1015: demonstrate directory/file conflict recovery
> > failures", 2018-07-31)
> > [3] ad3762042a ("read-cache: fix directory/file conflict handling in
> > read_index_unmerged()", 2018-07-31)
>

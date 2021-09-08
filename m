Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C205C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8522961130
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbhIHAlr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 20:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhIHAlq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 20:41:46 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20200C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 17:40:40 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id k18-20020a4abd92000000b002915ed21fb8so208675oop.11
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 17:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5ycBX5vI40UG9ZjEBi4+mWIlwDb4isOO3rJ5YARoiUM=;
        b=bQ6HouXmBAgdkyDufGyTOV9CbQcCkf6cC6z9AVW3bT9731bJqV+ruPyVtElYQJiG1n
         s5h60IUuK/TdM3ggtKNHND+v1wGY8f8UdcpdHOINOXwfeZpKeIQWCxydgcH4KEosY6pI
         ZwyEsNDUSO7mk9cXGGMS9/8Pco9kb/4fMbqVcS3It5goE8Ar3l8Id0Wxf3oBbny+Z8ge
         WkW1v/Hb4QaBc+OwzBpB3ASrLswDGNv9ikDLpf3jAs/+Q5HG0uzIS4r2LtCONmKSXmNK
         F10a0NO7d384dKkok3teoGQfLnOlWA05cK8/HJPDcTyfZBGhPX8UEmiNbhxdGkGkMEJr
         YKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5ycBX5vI40UG9ZjEBi4+mWIlwDb4isOO3rJ5YARoiUM=;
        b=oGL+YczqZXzrG9CmHDCzzcIkJ1gtGJsCG/4ocpSU1OSWnVpZrJTqatZPcFBBVzdT7w
         jxnMYhaeyAuIh+5dwpFXeWbiRgS7K8TRcMF0ivFJCH1z64WINvCxBWiAkHhzMeTkF1oO
         J8S1OgVEUCgKNYikNXD/x5xE/JpSKDoqwoDCtmtACWdMuXPWDogueo+mdMRANOqZPKya
         rLkiw7MlP+28mrOaFmknm9HPXo5aGbJej5hhiP7hLmNY1KLH55RrvUfYORQSreoy4Or5
         mW4Ebpf8P7pLg3U186V1AoDAtGILXXJUKFqIrxDPW8s3XzRkbTAtdzPu1mBk05Ohqzxh
         VWyw==
X-Gm-Message-State: AOAM530REczmBA3nzZ60lIXWnV9wK52dX9cRoz1ddZcIbWIkf3dRqVmF
        4CNVSpe5WZOgcEam+QBTnTqWZ+0SQ4TWr9UbDep0IrX0
X-Google-Smtp-Source: ABdhPJyI5KRIdhUz7evv+j8x6c0ewh1wXDK23PbKoSZb4DvGHjCwrAETR+CB1DY1prq3pybWxOH8WEK9qUF918W6jmw=
X-Received: by 2002:a4a:c541:: with SMTP id j1mr805861ooq.15.1631061639251;
 Tue, 07 Sep 2021 17:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAG2t84Uaw-Kdp+EXU8CY1QYfykFQj-hGLJnTSH8MYO8Vi_yqgA@mail.gmail.com>
 <C357A648-8B13-45C3-9388-C0C7F7D40DAE@gmail.com> <dbe7d88d-4174-e080-03df-e35d0ac6004f@gmail.com>
 <YTNA6Qo6Yj5o9NmQ@coredump.intra.peff.net> <CAG2t84Xe2XwdwdAK42bRrwAeNaB3-A+WhgSsJGOoW9-rG1S9Xg@mail.gmail.com>
 <YTNH2vMPuEW4SBMo@coredump.intra.peff.net> <CABPp-BFyR19ch71W10oJDFuRX1OHzQ3si971pMn6dPtHKxJDXQ@mail.gmail.com>
 <87sfyjpiu3.fsf@evledraar.gmail.com>
In-Reply-To: <87sfyjpiu3.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Sep 2021 17:40:27 -0700
Message-ID: <CABPp-BFh2wGaDNjQD08bipE1t+B=0m0OBzXpYKR+17HADTHwCg@mail.gmail.com>
Subject: Re: Aborting 'rebase main feat' removes unversioned files
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 5, 2021 at 12:44 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
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

Yeah, I discovered the problems by making some testcases for the
avoid-removing-current-working-directory case, and then when I was
surprised by some behaviors I saw I started adding tests for the
(mistaken?) nuking of untracked files...and then saw this bug report.
While I've also been trying to add fixes for the issues I've found,
making the testcases (trying to figure out which commands had bugs and
how to trigger them) was definitely the hardest part of the effort so
far, and likely the most valuable.

> 1. https://lore.kernel.org/git/87a6q9kacx.fsf@evledraar.gmail.com/
> 2. https://lore.kernel.org/git/87ftsi68ke.fsf@evledraar.gmail.com/

The first item, preserving ignored files, is related but different (I
was specifically discussing non-ignored untracked files above).
However on the topic of precious ignored files...both checkout and
merge have a --[no-]overwriite-ignore flag to select this behavior.
Unfortunately, the merge command only passes that flag along to the
fast-forwarding code path and ignores it for all other merge backends.
But merge-ort could trivially be made to handle it (search for the
line of code that reads "if (1/* FIXME: opts->overwrite_ignore*/)" and
note opts->overwrite_ignore isn't a flag that exists, yet), and then
it'd just need to be threaded through merge/rebase/cherry-pick/revert
toplevel commands down to that line of code.  Also, my preliminary
patches touch on the ignore handling for other codepaths and make it
clear how one could support such a flag for those other cases; I'll
leave some comments in the cover letter when I submit it.  Anyway, if
we were to get those other codepaths all hooked up, perhaps we could
add a core.overwrite_ignored option defaulting to true and giving
people a place to just configure this once.  I would much rather a
global option than attempting to provide another class of file that
users have to configure (ignored but precious), especially as we have
had plenty of bugs and problems just dealing with the two classes of
'untracked' and 'ignored' already.

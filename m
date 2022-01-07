Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F383C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 19:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiAGTGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 14:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiAGTGV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 14:06:21 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B0CC061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 11:06:20 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id b13so25660466edd.8
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 11:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7CoQ33OxhDgTp071IIZxjtJQIAjSMYmZaZC9rANMwEc=;
        b=XlSXQWaekCRasFEu/Q8zvVBAy3cXBbMwTXKKismEFRjwQ2CHxoiSWXc+qkAB9paoul
         YK7v18RR/x8Y2x7Alf6uHqTTN30UKpgMTF0CtZ5dr/G5AlfoG82JOlXK0inOows7dWQF
         9dX3WNxpd2GszCGr4COH0IkqToULi5+5caobSgBxysWmipQM/0WiXrN/JKQMYOKGKAdd
         ioSvY90V0/V8GTUP7l7gMibIKZ2nm6jtEva6b6K4ThRBqwEjATdeVfW6SDDekH3qd5OF
         4MQcsCL9f6CkBAp8VW3LkC4XNM5xeGdDKPUYvjP6FAO32BC51+rKKuPZlS/gks4Lst36
         nbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7CoQ33OxhDgTp071IIZxjtJQIAjSMYmZaZC9rANMwEc=;
        b=w6TMwnWpsjCvqHNvaw/wS1VDp0AiF2fZoMULAhubfVq0lkA0XClFJDUo1zeB6wxJ7a
         uw45Dlw6PETrLLVMJ9K6DoB5S+++59nONk7ZIm3TS8VAERvhmvIxXMs4fVnyD+3wzOw4
         dCmXnX4Xhnu93ZihHpzwHpRmyRwL3SYSNdNuqwIBNZZIlCsPPW3OY7uvY8hqnCkKA4t7
         PkXK48IwT+3/sLsfw3jzPbyuhwel7OXRB+72ivXbwQzFpPOZfIRz+fCsNY7BXEaqLKeU
         kTLI6uzjqBIsm2CB/IGrLAgxWnC8sNFAxFDoy4nEtag6SfywsYomu2tXCfkbpZFy99gx
         wBvg==
X-Gm-Message-State: AOAM533SetV7//GO0zT1/c27jfViabev/zHIhxik5H+9LQBQJTIK2vyF
        QNaL5wpWFq081j2a1dAvutSU4DaO4m+TJahK9x/TA1VkL44O6g==
X-Google-Smtp-Source: ABdhPJyd4jiYg8U2IRRdfQj8LUy5lZ/OmhL2cD9GzmAvcQXcPRqaZk1PQZyDevgzM/PzGq2zw/0U4A4hvnn5UgWy0Rw=
X-Received: by 2002:a17:907:9808:: with SMTP id ji8mr52141678ejc.476.1641582379012;
 Fri, 07 Jan 2022 11:06:19 -0800 (PST)
MIME-Version: 1.0
References: <20220105163324.73369-1-chriscool@tuxfamily.org>
 <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com> <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com>
In-Reply-To: <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 7 Jan 2022 11:06:07 -0800
Message-ID: <CABPp-BHpuLjCYycBwweMW_NdQrS_r3ECmvLb8XjNW-_Rau5NTw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Introduce new merge-tree-ort command
To:     Christian Couder <christian.couder@gmail.com>
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

On Fri, Jan 7, 2022 at 9:58 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Jan 5, 2022 at 5:54 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Wed, Jan 5, 2022 at 8:33 AM Christian Couder
> > <christian.couder@gmail.com> wrote:
>
> > > The current `git merge-tree` command though seems to have a number of
> > > issues, especially:
> > >
> > >   - it's too much related to the old merge recursive strategy which i=
s
> > >     not the default anymore since v2.34.0 and is likely to be
> > >     deprecated over time,
> > >
> > >   - it seems to output things in its own special format, which is not
> > >     easy to customize, and which needs special code and logic to pars=
e
> >
> > I agree we don't want those...but why would new merge-tree options
> > have to use the old merge strategy or the old output format?
>
> Yeah, it's not necessary if there are 2 separate modes, a "real" mode
> (like what you implemented with --real in your recent patch series)
> and a "trivial" mode (which is the name you give to the old code).
>
> Adding modes like this to a command is likely to make the command and
> its documentation more difficult to understand though. For example I
> think that we created `git switch` because the different modes of `git
> checkout` made the command hard to learn.
>
> I gave other reasons in [1] why I prefer a separate command.
>
> [1] https://lore.kernel.org/git/CAP8UFD1LgfZ0MT9=3DcMvxCcox++_MBBhWG9Twf4=
2cMiXL42AdpQ@mail.gmail.com/

I can see where you're coming from, but I think the particular
comparison you use isn't quite apples to apples.  `git checkout` has a
"change branches" mode and a "revert specific paths" mode.  While
those have significant implementation overlap, they seem like
different concepts to users.  For merge-tree, the implementation is
completely orthogonal between the two modes, but the concept is
basically the same from the user viewpoint.  Yes, the output differs
in the two merge-tree modes, but command line arguments are often used
to tweak the output (much like diff has different output styles based
on various flags).  In fact, in [1] where you suggest a new command
you suggest that it should have "roughly the same features as git
merge-tree and a similar interface".  To me, that suggests that the
two may be good candidates for being similar commands.

That said, I'm not against a new command.  Personally, my main reason
for using merge-tree wasn't because that's where I thought it was best
to put it, but just that (IIRC) each of Dscho, Peff, and Junio
suggested that location.

My biggest gripe was just the command name...

> > > To move forward on this, this small RFC patch series introduces a new
> > > `git merge-tree-ort` command with the following design:
> >
> > Slightly dislike the command name.
>
> I am ok with changing the command name.

:-)

> > `ort` was meant as a temporary,
> > internal name.  I don't think it's very meaningful to users, so I was
> > hoping to just make `recursive` mean `ort` after we had enough
> > testing, and to delete merge-recursive.[ch] at that time.  Then `ort`
> > merely becomes a historical footnote (...and perhaps part of the name
> > of the file where the `recursive` algorithm is implemented).
>
> I think something similar could still be done with `git
> merge-tree-ort` or whatever name we give to this command. For example
> we could first add --ort to `git merge-tree` and make it call `git
> merge-tree-ort`, then after some time make --ort the default, then
> after some more time remove `git merge-tree-ort`. And whenever we make
> those changes we could also rename the builtin/merge-tree*.{h,c}
> accordingly.

User-facing names tend to take a while to remove; I'd rather start
with user-facing command and option names that are meaningful to users
in terms of what they want to accomplish.  I don't think `ort`
qualifies as such; I'd rather `ort` only be used by expert users (e.g.
folks wanting to test out a new merge algorithm they heard about
before it became the default).

> > >   - it uses merge-ort's API as is to perform the merge
> > >
> > >   - it gets back a tree oid and a cleanliness status from merge-ort's
> > >     API and prints them out first
> >
> > Good so far.
> >
> > >   - it uses diff's API as is to output changed paths and code
> > >
> > >   - the diff API, actually diff_tree_oid() is called 3 times: once fo=
r
> > >     the diff versus branch1 ("ours"), once for the diff versus branch=
2
> > >     ("theirs"), and once for the diff versus the base.
> >
> > Why?  That seems to be a performance penalty for anyone that doesn't
> > want/need the diffs, and since we return a tree, a caller can go and
> > get whatever diffs they like.
>
> I say somewhere else that I am planning to add options to disable this
> or parts of this diff output.
>
> I think it's still interesting for the command to be able to output
> diffs, especially diffs of conflicting parts.

Are you presuming that you can output a diff of conflicting parts?  A
diff on a modify/delete or can't-merge-binary-files won't show
anything, and won't provide any notification that there even was a
conflict.

> In [2] =C3=86var said:
>
> =3D> I.e. I'm not the first or last to have (not for anything serious)
> =3D> implement a dry-run bare-repo merge with something like:
> =3D>
> =3D>     git merge-tree origin/master git-for-windows/main origin/seen >d=
iff
> =3D>     # Better regex needed, but basically this
> =3D>     grep "^\+<<<<<<< \.our$" diff && conflict=3Dt

This code is pretty hacky; it presumes that content conflicts are the
only type of conflict.  Inability to merge binary files,
file/directory conflicts, mode conflicts, modify/delete conflicts,
various rename conflicts, etc. are all other types.  I'd rather not
encourage such hacks.

Returning whether there were conflicts in the exit status is far
cleaner.  Providing some mechanism for getting a list of files which
had conflicts may also be useful, but both of these are things where a
diff is the wrong tool.

> Also `git merge-tree` currently outputs diffs, so I thought it would
> be sad if the new command couldn't do it.
>
> [2] https://lore.kernel.org/git/211109.861r3qdpt8.gmgdl@evledraar.gmail.c=
om/

Hmm, I had a totally different opinion.  I felt the diffs in the
current merge-tree was a hack to deal with the fact that they didn't
have good tools to make use of the results, and ended up providing a
Rube-Goldberg scheme to do anything useful with it.

Providing a tree is a concrete and easily usable object for end users.
They can feed that tree to other git commands to do additional things,
and obviates the need for the Rube-Goldberg contraption.

> > Was there something you didn't like about
> > https://lore.kernel.org/git/pull.1114.git.git.1640927044.gitgitgadget@g=
mail.com/?
>
> I was having a vacation at the time and even though I skimmed the
> mailing list, I missed it. Sorry.

Ah, gotcha.  I was just curious if there was something you felt was
wrong and you wanted to propose an alternative.

> Also I thought that you might not be interested in this anymore as you
> didn't reply to [1] and [2] where =C3=86var and I both said that we were
> interested in your opinion on a git merge-tree on steroids.

Sorry,  I saw =C3=86var's email and noticed various assumptions I felt were
problematic, but noticed he said he was just spitballing (which is
totally fair).  I figured that rather than attempt to explain each
detail, it'd be better to update my code and provide it...and I then
ignored the rest of the thread and missed your question.  Sorry.  I
certainly meant to update this series and send it out earlier, but
there were multiple other series of mine that were also backed up and
several series I needed to review, so it took me a while to clean out
the queue a bit.

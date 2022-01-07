Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DBEC433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 19:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbiAGT75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 14:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiAGT74 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 14:59:56 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB579C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 11:59:55 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id u21so3588699edd.5
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 11:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HdmNuaXVgPeZNMURcYo46aW0ut6xGEZnexYGmRy/dAQ=;
        b=HLBrNgg+vIY/tZkxJCz15Ek8AKcV0p1VTzCrIKTxXGMHsq9QUVDvkQHDoh1A7NxEUl
         2VVQvXCt5km6l2M3dT+DV1Y7/JAG8V7cZP2LQQO8wJExPgvjPJrTsDG4JoiJz9cCPgJA
         /97OoXJtF6YaYx0Bqi5cmdC/yzFYGzZjaog6Y9ovUqZzP3P8gvl2dX9mqISbg98UePmW
         WvCRZ3CeMeODEaFKTNSFLnEArD5yg98mHqzxQuwCgT9UNOmC8vPTSSmHMZL6YyXGidrn
         rbMOX5clITV2EU4zCxUWGd2MM9YAxec1RTp+sn2TelqD3knYQdL7Y5R9WlPh5SMNllQ0
         MklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HdmNuaXVgPeZNMURcYo46aW0ut6xGEZnexYGmRy/dAQ=;
        b=I3WnUnKadcZKfW/K7DSrM2WgaKfpU1xlv1vVbERQvw10WShhIuvjBzM1Csdaz9r91M
         5SRuf+L4IUJ3KWRs6tJCBhAdZeHdxih7yiyJ1IwUOsG/CU5rNW4Q0yetMLianMOcU+A8
         MTPscaf32xdcQ2ki3gkA0o8Mbd6a8V4DBkpgDCS2zqdCQnNhUa/NhPsxXAHMlHSeg13H
         zcmKCfhC3QN+xywsw7JETBb+Iwi1L58bgU0uMcV1I+zN+2Z009ipPcKtI9cdDKvB6SyC
         U4D6qFlcDJT6IPoZ/kmvLQH3jbXxxjXFWaPnvSYAnXEUNkqCN87Nk5HaSvulC6vcpc+q
         nPVw==
X-Gm-Message-State: AOAM532gQG1SzR++RFzcbvFxMc5HIFqENoG5cLXi12aRe85ZR/3USw5a
        XNA+WVZxi1BM284SzHb/+ioI4YBP+aInxlXNLNjYGBT0ZomDTg==
X-Google-Smtp-Source: ABdhPJx61LFrDTS5CHpFVA/2kE6I809Ovnxnm4aSf/jE3L5yp1vtJNrpDXmOFc34//+zeefalK9cCfCtPzB23jOSwd4=
X-Received: by 2002:a17:907:968a:: with SMTP id hd10mr49922252ejc.269.1641585594380;
 Fri, 07 Jan 2022 11:59:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com> <CAP8UFD1Z74yuUmzPCr6X8-i2B1zaiT8kPxNDHxK5MeHw8OcnRg@mail.gmail.com>
In-Reply-To: <CAP8UFD1Z74yuUmzPCr6X8-i2B1zaiT8kPxNDHxK5MeHw8OcnRg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 7 Jan 2022 11:59:43 -0800
Message-ID: <CABPp-BE5breKX5TciAwzKi+BQnqy1aKq_v4tjiqiX7swrZf=PA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] RFC: Server side merges (no ref updating, no
 commit creating, no touching worktree or index)
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 7, 2022 at 10:46 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Jan 5, 2022 at 6:27 PM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>
> > This series attempts to guess what kind of output would be wanted, basi=
cally
> > choosing:
> >
> >  * clean merge or conflict signalled via exit status
>
> (Maybe s/signalled/signaled/)

I can't determine the difference after a few Google searches, and both
seem to be in dictionaries with the same meaning so I'm having
difficulty figuring out which is preferred.  Usually my searches will
either suggest that one is a misspelling or at least bring up whether
one is a regional variance, but I'm not seeing anything of the sort.

It can't hurt to switch, though, so I'm happy to switch.

> Not sure that's the best way by default. I think it's very likely that
> many users will be interested in parsing the command ouput, and they
> might prefer that merge related errors be signaled in a different way
> than other errors.

That's fair.

I was thinking in terms of various plumbing commands: hash-object,
mktree, commit-tree, read-tree, write-tree and update-ref.  Output
from commands in that last can be fed as input to other commands and
be chained together to do various interesting and useful things.  I
have done that at various times in the past.  I thought merge-tree
might augment that category of commands (particularly since Peff
suggested to make the command be low-level at the summit), and thus
outputting just a tree (at least by default) would make the command be
a useful building block within that context.  That was part of my
reason for including the code snippet

   NEWTREE=3D$(git merge-tree --real $BRANCH1 $BRANCH2)
   test $? -eq 0 || die "There were conflicts..."
   NEWCOMMIT=3D$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
   git update-ref $BRANCH1 $NEWCOMMIT

in the cover letter.

But merge-tree is much more likely to run into problems (i.e. into
merge conflicts), so maybe it doesn't belong in the same set, and the
NEWTREE definition perhaps deserves to have additional special case
command-line parsing that the user needs to do.

I'm curious about others' thoughts on this matter too.

> >  * stdout consists solely of printing the hash of the resulting tree (t=
hough
> >    that tree may include files that have conflict markers)
>
> Maybe users will want diffs, the conflicted list and other things on
> stdout, as they might want to parse it anyway, and it would be a
> burden to have to perform diffs, or get other interesting info in a
> different way or using a different process or call.

You mention the stdout thing both above and below, so I'll concentrate
here on the diffs part.

Do you have a specific usecase you have in mind where diffs are
wanted, separate from the two examples you gave in the other thread
(namely =C3=86var's misguided hack for looking for whether there were
conflicts, and a desire to just follow merge-tree's convoluted
precedent)?  I'd rather not add diffs pre-emptively on the basis that
users "might" want them, especially if they come with the huge gamut
of options =C3=86var was spitballing in [1] (some of which appeared to have
misguided assumptions relative to the possibility of renames and might
introduce edge and corner case bugs that'd be with us forever).  If we
don't have concrete usecases yet, I'd rather avoid adding such options
until we do have concrete usecases so we don't paint ourselves into a
corner.

[1] https://lore.kernel.org/git/211109.861r3qdpt8.gmgdl@evledraar.gmail.com=
/

> >  * new optional --messages flag for specifying a file where information=
al
> >    messages (e.g. conflict notices and files involved in three-way-cont=
ent
> >    merges) can be written; by default, this output is simply discarded
> >  * new optional --conflicted-list flag for specifying a file where the =
names
> >    of conflicted-files can be written in a NUL-character-separated list
>
> It would be nice if output was printed on stdout when the above flags
> are used without argument.

Oh, that's an interesting idea.  The --conflicted-list flag, though,
separates filenames by NUL characters, for simplicity of parsing.  If
I'm printing them to stdout, would that be problematic? (If so, should
it instead print them in e.g. ls-tree format, where it escapes
filenames only when necessary)?

> Thanks for working on this!

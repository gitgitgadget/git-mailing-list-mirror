Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D59C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B9B26121F
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbhJDN5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239038AbhJDN4a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 09:56:30 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F8FC06125A
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 06:46:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g14so14579762pfm.1
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 06:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YB1fGiDxu1sW+ILqfEyxqkO5Ng+TFWrhJovkxkj/z00=;
        b=ma+lO9H0T8hZxh+aJBC5b8odPiCdM7z1r5SlpxsRfL5fGODRLHC4XXBo5hgZsTcTL9
         P5xtBARswUG+8qTVddwHFMdyUaNHE3/4mCMeoO1EsXVqpwjmoOX27iLzg6fbjCwK8yvY
         ICf7F4AEcL67B9w0nFlJWMZKpDPSErmN+nI8GY2c/lCdXjrXaAd7dNUM6nW9uLSX5HiP
         cxCZOs17W0RuWill5LS/vD7z7mdThTdBob5J4WJvhImJ9P0aNpxaxziTyCQCE5pSgjC6
         FyEqlzIzA3sh+pA58UYmoTbxVj5MbuUtbKp69ZydpbYIZZ6ZPGAEpyOZaAfPQciOu0bB
         QGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YB1fGiDxu1sW+ILqfEyxqkO5Ng+TFWrhJovkxkj/z00=;
        b=BoVkzJbTOzNPv1SvLsJr20WFeCo7/ihun6/99SM/3lmF37M7887rV0idAvnkH7AzNQ
         y0aRqKPt8V8INPuMoGSfyjTb1DuhC88WGmP41yAE3mCrf3D+iqNdJEL4H6vfzSja31T4
         SldRZBdlfP7D46BqSqRKZx5c5QdllXX4jwH+vjoT6mvDDGhGWj/EF2pXL4J48yN4XFfD
         o4AdFVmdzWuQ/yeDl1kGWvDy/xzEAWV20LWtRvNGDpCzWkiMxPFm/YrpA4UACc0MCxHe
         L6Cb7K32cWK1w1Lekks2r0yzw1NxnL/AS1lK20NGD98bQFDlxnrm10r5qjCMXqXLhYUg
         MURA==
X-Gm-Message-State: AOAM531vAT/pOqI9W543i4MEP8Zcx0PVJzMsdz/iG8eWwznpMNloK1Ny
        yDHKZ7FJujDGt5TQTM2tFyjJJQU6vqxfrGIFfP4=
X-Google-Smtp-Source: ABdhPJw/VbAjjr2+bi79VFdI6wJpAL0wF+K19ofcuyJ4B1WCCDe+voM46Xm2WLXvYmodrqufXj8Aqe1CPSXEgtYBda8=
X-Received: by 2002:a62:17d3:0:b0:44c:6022:9428 with SMTP id
 202-20020a6217d3000000b0044c60229428mr5616276pfx.65.1633355177822; Mon, 04
 Oct 2021 06:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
In-Reply-To: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Oct 2021 06:45:00 -0700
Message-ID: <CABPp-BEr28xzbpEZc5dq-RVDupXy+h-+PH6CoANF4e0kmxqf0Q@mail.gmail.com>
Subject: Re: [PATCH 00/10] unpack-trees & dir APIs: fix memory leaks
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 3, 2021 at 5:46 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> This series fixes memory leaks in the unpack-trees and dir APIs for
> all their callers.

There are several good fixes in this series.  Thanks for working on them!

> There's been a discussion between myself & Elijah
> on his en/removing-untracked-fixes series[1] about the memory leak
> fixing aspect of his series.

Not really, the memory leak fixing aspect of my series was patch 2;
most of our discussion was on patch 4, including your footnote link.
Patch 4 did not in any way involve fixing a memory leak, which you
yourself later acknowledged.  So most of our discussion was mostly
about aspects _other_ than leak fixing.

> I've got locally queued patches that fix widespread memory leaks in
> the test suite and make much of it pass under SANITIZE=3Dleak, once the
> common leaks in revisions.c (git rev-list/show/log etc.), "checkout",
> "dir" and "unpack-trees" are fixed a lot of tests become entirely
> leak-free, as much code that needs to setup various basic things will
> require one of those commands.

Yaay!  This is great stuff!

> I think that the more narrow fixes[2] to the memory leaks around
> unpack-trees in Elijah's series[3] are better skipped and that series
> rebased on top of this one (I'll submit an RFC version of his that is
> rebased on this as a follow-up).

I *strongly* disagree.

> I.e. his solves a very small amount of the memory leaks in this area,
> whereas this is something I've got running as part of end-to-end
> SANITIZE=3Dleak testing, so I think that the difference in approaches we
> picked when it comes to fixing them is likely because of that.
>
> E.g. continuing to allocate the "struct dir_struct" on the heap in his
> version[4] in his is, I think, something that makes more sense for
> fixes that haven't pulled at the thread of how much merge-recursive.c
> is making that question of ownerhip confusing. There's also changen in
> his that'll become simpler as the complexity of the underlying APIs
> has gone away, e.g. [6].

*Sigh*.  unpack_trees_options->dir is not allocated on the heap at the
end of my series.  I could understand missing that in the patches, but
I've also pointed it out to you two additional times in discussions on
the patches so far.  And you supposedly looked at all the patches
again while rebasing and adding your signed-off-by.

You also continue to refer to our discussion as though it was about
leakfixes, even though the patch we discussed in my series did not
involve any leak fixing.  I pointed that out and you said you stood
corrected (last comment at
https://lore.kernel.org/git/87k0ivpzfx.fsf@evledraar.gmail.com/), but
now you're referring to it that way again?  Even after rebasing my
series and adding your Signed-off-by, suggesting you should understand
it?  The leakfix was a different patch of the series, namely patch #2.

I agree that merge-recursive.c has confusing points.  I totally agree.
Unfortunately, both your patches that touch merge-recursive.c make it
worse; more so than the problems you were trying to fix in that file.

> 1. https://lore.kernel.org/git/87ilyjviiy.fsf@evledraar.gmail.com/
> 2. https://lore.kernel.org/git/0c74285b25311c83bb158cf89a551160a0f3a5d3.1=
632760428.git.gitgitgadget@gmail.com/
> 3. https://lore.kernel.org/git/pull.1036.v3.git.1632760428.gitgitgadget@g=
mail.com/
> 4. https://lore.kernel.org/git/0d119142778dce8617dd9b2c102b5f5bfdc9dc0f.1=
632760428.git.gitgitgadget@gmail.com/
> 6. https://lore.kernel.org/git/f1a0700e598e52d6cdb507fe8a09c4fa9291c982.1=
632760428.git.gitgitgadget@gmail.com/
>
...
>   merge-recursive.c: call a new unpack_trees_options_init() function
>
> Details how merge-recursive.c calls unpack_trees() differently than
> every other caller when it comes to "struct unpack_trees_options"
> setup.

Saying:

"merge-recursive.c has a heap-allocated unpack_trees_options, and thus
can't naturally use UNPACK_TREES_OPTIONS_INIT"

would have been shorter, and also explained things in full detail.
Your version makes it sound like it's doing something really weird and
needs a much more expansive explanation.

>   unpack-trees.[ch]: embed "dir" in "struct unpack_trees_options"
>
> Elijah's series ends up with a "dir" still heap-allocated in "struct
> unpack_trees_options", just dynamically and "privately".

As noted above, this is not true.  I'm confused why you try to claim
otherwise.  (I mean, it's really not all that important, I'm just
confused why you find it important to call out, especially when the
stack-based point was highlighted multiple times before but you still
insist on referring to it as heap-allocated.)

...
>   unpack-trees: don't leak memory in verify_clean_subdirectory()
>   merge.c: avoid duplicate unpack_trees_options_release() code
>   built-ins: plug memory leaks with unpack_trees_options_release()
>
> A lot of memory leak fixes both in unpack-trees.c and its users, only
> a subset of this is in Elijah's series.

Not sure why you feel the need to include the final phrase there; it
almost feels like you're trying to portray my series as a leakfix,
which feels misleading.  My series wasn't even about fixing leaks.  In
my first round, I knew of leaks, and intentionally attempted to avoid
fixing them because it was orthogonal to the point of my series (I
figured I could come back in a follow-on series and deal with it).  In
a subsequent round, I fixed one leak incidentally, in part because you
called it out, but more so because otherwise when I attempted to
consolidate code into one place it would appear to reviewers that the
consolidated code didn't match some of the callers.  In particular,
some of the sites had a leak and others didn't.  Adding a preparatory
leakfix (again, patch #2, NOT patch #4) made clear that the later
consolidation (in patch #4) really was just that -- moving several
identical code chunks into a single place.


....anyway, all that said, you've got some good fixes in this series.
You've also got three very problematic bits that need to be ripped
out.  And you should rebase this series on top of v3 of
en/removing-untracked-fixes.

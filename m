Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96AAC433E9
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 16:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A22FE64F48
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 16:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbhCAQmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 11:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhCAQj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 11:39:59 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA2CC06178A
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 08:39:19 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id i21so16374659oii.2
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 08:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Ojz39XtyeceZ0NBGGsJqUsXELIlO80BFi8j+gbOlI8=;
        b=mtj3dP7tXOZQytCS2U1TiKoKVjDfK6aWmZ4ObpXG2gEkWI5v6cTnUKh3b+AF4PAwBm
         31m+WKHEy3YvZQy44l4XySRlQfTUgNrlzQTrqehC3IrWMSBBmN4c01TuHXdiApUnf/89
         geIse9KTvOsoI596Q8yEd74SxTYhfgWPHJ8FUbxWB30lRPaebRYG3gZQfV1os8ADHEud
         j69qsiIQXyJ/O7RahLawllTNabSzYXBitvq/LkEZDSI/buL07qi6VK4hnA4g+UpnoY+l
         ZIjFwDyE9zUas/ISuXA5BgTUEoxRH88akh5wf8VLFiShmiy6HPZyaltjQOBtgIYuJf4s
         k+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Ojz39XtyeceZ0NBGGsJqUsXELIlO80BFi8j+gbOlI8=;
        b=r7h/AtWqYE1DMK6BYgzXzHz9zTpTcq+km02ue3HWEIZT9Q+UZ2Z2UPzsord7BZtJE1
         fMjGdzUT8EXABpE4BEjPTG47c+Opl3Aqd027Fg7cMC3o5OA6leggl1eUVmGzuTo7Vfvh
         CAqQHqYdAWugpkzYNPbqbJ8zFzX1IWE8OTIBGASLeI8TenTG747vZJA+bg9iTwvm2YLk
         FAg7tpDPKHy443dq6KM8lTLT1qFknYEwRp2pVRj/4ZqrGqBZO6RX4jfGwTdv32aRIaIV
         msRczc+ynGuTGZ7P9uv7hs/XvEXwFlRQb11LBBvX7lhCK4VEwphZz2gKP+6W44YdG92F
         +QuQ==
X-Gm-Message-State: AOAM5321Iw6X2ET7gT8e15LKAqbNQMwRcGmpOXRVvZwPgH+APrn5KaG0
        MwEBj4pnBTv05a9WKCZqStssE1cQsd7uz6kqUbs=
X-Google-Smtp-Source: ABdhPJwpxRtSM+NELuZNSL9L9IILgCc9uJK9BQSmReipN8ObB+C5p45Iu8AhldcVwhE+aJYC+ZIEtftW4ojJ4eGB2W0=
X-Received: by 2002:aca:c48c:: with SMTP id u134mr12204637oif.31.1614616758402;
 Mon, 01 Mar 2021 08:39:18 -0800 (PST)
MIME-Version: 1.0
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.git.1614484707.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 Mar 2021 08:39:07 -0800
Message-ID: <CABPp-BEVvfMLGFthb5EQpYORSe9BifQRNb40+mgcg=bGCABc5Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] Optimization batch 9: avoid detecting irrelevant renames
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 27, 2021 at 7:58 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series depends textually on ort-perf-batch-8, but semantically it's
> almost completely unrelated and can be reviewed without any familiarity w=
ith
> any of the previous patch series.
>
> =3D=3D=3D Basic Optimization idea =3D=3D=3D
>
> This series determines paths which meet special cases where detection of
> renames is irrelevant, where the irrelevance is due to the fact that the
> merge machinery will arrive at the same result regardless of whether a
> rename is detected for any of those paths. This series represents
> "Optimization #2" from my Git Merge 2020 talk[1], though this series has
> some improvements on the optimization relative to what I had at that time=
.
>
> The basic idea here is that if side A of history:
>
>  * only modifies/adds/deletes a few files
>  * adds new files to few if any of the directories that side B deleted or
>    renamed
>
> then when we do rename detection on side B we can avoid even looking at m=
ost
> (and perhaps even all) paths that side B deleted. Since commits being
> rebased or cherry-picked tend to only modify a few files, this optimizati=
on
> tends to be particularly effective for rebases and cherry-picks.
>
> Basing rename detection on what the other side of history did to a file
> means that extra information needs to be fed from merge-ort to
> diffcore-rename in order to take advantage of such an optimization.
>
> =3D=3D=3D Comparison to previous series =3D=3D=3D
>
> This series differs from my two previous optimizations[2][3] (focusing on
> basename-guided rename detection) in two important aspects:
>
>  * there are no behavioral changes (there is no heuristic involved)
>
>  * this optimization is merge specific (it does not help the diff/status/=
log
>    family of commands, just merge/rebase/cherry-pick and such)
>
> =3D=3D=3D Results =3D=3D=3D
>
> For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
> performance work; instrument with trace2_region_* calls", 2020-10-28), th=
e
> changes in just this series improves the performance as follows:
>
>                      Before Series           After Series
> no-renames:       12.596 s =C2=B1  0.061 s     5.680 s =C2=B1  0.096 s
> mega-renames:    130.465 s =C2=B1  0.259 s    13.812 s =C2=B1  0.162 s
> just-one-mega:     3.958 s =C2=B1  0.010 s   506.0  ms =C2=B1  3.9  ms
>
>
> However, interestingly, if we had ignored the basename-guided rename
> detection optimizations[2][3], then this optimization series would have
> improved the performance as follows:
>
>                Before Basename Series   After Just This Series
> no-renames:      13.815 s =C2=B1  0.062 s      5.728 s =C2=B1  0.104 s
> mega-renames:  1799.937 s =C2=B1  0.493 s     18.213 s =C2=B1  0.139 s
> just-one-mega    51.289 s =C2=B1  0.019 s    891.9  ms =C2=B1  7.0  ms
>
>
> As a reminder, before any merge-ort/diffcore-rename performance work, the
> performance results we started with (as noted in the same commit message)
> were:
>
> no-renames-am:      6.940 s =C2=B1  0.485 s
> no-renames:        18.912 s =C2=B1  0.174 s
> mega-renames:    5964.031 s =C2=B1 10.459 s
> just-one-mega:    149.583 s =C2=B1  0.751 s
>
>
> =3D=3D=3D Competition between optimizations =3D=3D=3D
>
> We now have three major rename-related optimizations:
>
>  * exact rename detection
>  * basename-guided rename detection[2][3]
>  * skip-because-unnecessary (this series)
>
> It is possible for all three to potentially apply for specific paths (the=
y
> do for the majority of renamed paths in our testcases), but we cannot use
> more than one for any given path. It turns out that the priority we give
> each optimization is very important and can drastically affect performanc=
e.
> We get best results by prioritizing them as follows:
>
>  1. exact rename detection
>  2. skip-because-unnecessary
>  3. basename-guided rename detection
>
> The third-to-last patch of this series also discusses this ordering and
> another minor variant of the skip-because-unnecessary optimization that w=
as
> tried (and resulted in less effective performance gains than reported her=
e),
> as well as some of the preparatory work over the past few years that this
> series relies on in order to enable this optimization.

Oops.  When I restructured the series I carefully re-read the commit
messages to make sure I didn't forget to update one...but I apparently
forgot to update the cover letter.  The discussion was actually split
across a few patches by the refactoring, and what is now the
third-to-last patch doesn't contain any of that discussion.

> =3D=3D=3D Near optimal? =3D=3D=3D
>
> You may remember that there was a row labelled "everything else" from the
> commit message of 557ac0350d that represented the maximum possible speed-=
up
> from accelerating rename detection alone; as stated in that commit, those
> rows represented how fast the code could be if we had somehow infinitely
> parallelized the inexact rename detection. However, if you compare those
> "maximum speedup" numbers to what we have above, you'll note that the
> infinitely parallelized inexact rename detection would have been slightly
> slower than the results we have now achieved. (The reason this is possibl=
e,
> despite the fact that we still spend time in rename detection after our
> optimizations, is because we implemented two optimizations outside of
> diffcore_rename() along the way.) However, this good news does also come
> with a downside -- it means that our remaining optimization potential is
> somewhat limited, and subsequent optimization series will have to fight f=
or
> much smaller gains.
>
> [1]
> https://github.com/newren/presentations/blob/pdfs/merge-performance/merge=
-performance-slides.pdf
> [2]
> https://lore.kernel.org/git/pull.843.git.1612651937.gitgitgadget@gmail.co=
m/
> [3]
> https://lore.kernel.org/git/pull.844.git.1613289544.gitgitgadget@gmail.co=
m/
>
> Elijah Newren (8):
>   diffcore-rename: enable filtering possible rename sources
>   merge-ort: precompute subset of sources for which we need rename
>     detection
>   merge-ort: add data structures for an alternate tree traversal
>   merge-ort: introduce wrappers for alternate tree traversal
>   merge-ort: precompute whether directory rename detection is needed
>   merge-ort: use relevant_sources to filter possible rename sources
>   merge-ort: skip rename detection entirely if possible
>   diffcore-rename: avoid doing basename comparisons for irrelevant
>     sources
>
>  diffcore-rename.c |  63 ++++++++++---
>  diffcore.h        |   1 +
>  merge-ort.c       | 236 +++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 285 insertions(+), 15 deletions(-)
>
>
> base-commit: 4be565c472088d4144063b736308bf2a57331f45
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-845%2Fn=
ewren%2Fort-perf-batch-9-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-845/newren=
/ort-perf-batch-9-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/845
> --
> gitgitgadget

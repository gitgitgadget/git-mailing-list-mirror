Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE00EC4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 02:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiKOCsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 21:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiKOCsD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 21:48:03 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461D315807
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 18:48:02 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id be13so22415201lfb.4
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 18:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JF5FQMMnFykDZcRR6M5X4TJWipBdOmkfrxFbaM0uSrs=;
        b=QRjfPqHYtUnaKUVnAYYH3LnyvFtsnLT7ZZqKylYd/WMwrJw1KvJnbIkoq2o9/SszNB
         DNk+8m5nLuNphnVtIdtxMVpcqizr6UTSyAHIaZrP0uB8GYhQ5TX45tDzapnv2ReT0Unr
         0BfTyirduslRpgqc2h5tp2fpUl0sEdDKt/OQ5rNBaLurfQ+JfMxBeYD/+mjNIdY0Iks2
         BB3X8Sgw796IkV15HVfMxZFUrGTLu2fPVAPQVeszVw32CYi1dxXbCDbqtuNNR/Dw+nmZ
         mQt6223bGchj5dGMvyAE6tpqHlafmntvN6FE7jRua1rBuuh72t2ZAIg8oOS+pb5s9+jJ
         f2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JF5FQMMnFykDZcRR6M5X4TJWipBdOmkfrxFbaM0uSrs=;
        b=4yQ1fv4t/oe0IRGgv2PHwi6QJo0+4eeWLOPLc+yJBINtHOvfj1B+Cace6w465LPbWX
         vB9bC2HdLTsulKpo17EXjHosLTZq0C+LGHCnrB+uCclvKxuexSJ25aFR72szbKwk3ngq
         QxAug+Z8aW72dDYX1yld+PNBSdhwh8SVbWDVe854fTntGq2eVSuuLVg5qnEPARsbWp+J
         ISMUFElX2LVdNXgNdvBkJ2YjigY7ChndGW78YGznjygLFbIkJsREiRUmSBgJV42oXuWk
         3NKzWqxPjSUYEVsWzh8DoYxbZap3BWxn0B4M5ZB7WJEvcvZ8Uuy32nkOlnebENa1nJIR
         qZ7Q==
X-Gm-Message-State: ANoB5pnY6PnpKz1s5s55HLr4iHL49VqJ90eFnHI8Qh5s9Mik/Leivdzu
        +3XCcg6CgmZdG4vxruef60ZXdPncS+y+4YLZTiY43JW3
X-Google-Smtp-Source: AA0mqf7enXz7OZyJADqD9kbZZA2kraupuWoDX91oeUu8GXFmHrXASvn36vIEUrqcjTlAGQAQmcPEtW4g5oTx3MrQU/c=
X-Received: by 2002:a05:6512:6d5:b0:4a9:6659:40d5 with SMTP id
 u21-20020a05651206d500b004a9665940d5mr5599916lff.516.1668480480406; Mon, 14
 Nov 2022 18:48:00 -0800 (PST)
MIME-Version: 1.0
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
 <CABPp-BEZK2KJHY+=Ta3VUzNjJKY=evPiAtp5UQFTVLMD0qreVQ@mail.gmail.com> <0e156172-0670-2832-78cb-c7dfe2599192@github.com>
In-Reply-To: <0e156172-0670-2832-78cb-c7dfe2599192@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 14 Nov 2022 18:47:00 -0800
Message-ID: <CABPp-BFNvUQx7exLgqDvzhgn1s=xSFKbJWdr8qfxLTXEFDQQig@mail.gmail.com>
Subject: Re: [PATCH 00/30] [RFC] extensions.refFormat and packed-refs v2 file format
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 13, 2022 at 4:07 PM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 11/11/22 6:28 PM, Elijah Newren wrote:
> > On Mon, Nov 7, 2022 at 11:01 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> Introduction
> >> ============
> >>
> >> I became interested in our packed-ref format based on the asymmetry between
> >> ref updates and ref deletions: if we delete a packed ref, then the
> >> packed-refs file needs to be rewritten. Compared to writing a loose ref,
> >> this is an O(N) cost instead of O(1).
> >>
> >> In this way, I set out with some goals:
> >>
> >>  * (Primary) Make packed ref deletions be nearly as fast as loose ref
> >>    updates.
> >
> > Performance is always nice.  :-)
> >
> >>  * (Secondary) Allow using a packed ref format for all refs, dropping loose
> >>    refs and creating a clear way to snapshot all refs at a given point in
> >>    time.
> >
> > Is this secondary goal the actual goal you have, or just the
> > implementation by which you get the real underlying goal?
>
> To me, the primary goal takes precedence. It turns out that the best
> way to solve for that goal happens to also make it possible to store
> all refs in a packed form, because we can update the packed form
> much faster than our current setup. There are alternatives that I
> considered (and prototyped) that were more specific to the deletions
> case, but they were not actually as fast as the stacked method. Those
> alternatives also would never help reach the secondary goal, but I
> probably would have considered them anyway if they were faster, if
> only for their simplicity.

That's orthogonal to my question, though.  For your primary goal, you
stated it in a form where it was obvious what benefit it would provide
to end users.  Your secondary goal, as stated, didn't list any benefit
to end users that I could see (update: reading the rest of your
response it appears I just didn't understand it), so I was trying to
guess at why your secondary goal might be a goal, i.e. what the real
secondary goal was.

> > To me, it appears that such a capability would solve both (a) D/F
> > conflict problems (i.e. the ability to simultaneously have a
> > refs/heads/feature and refs/heads/feature/shiny ref), and (b) case
> > sensitivity issues in refnames (i.e. inability of some users to work
> > with both a refs/heads/feature and a refs/heads/FeAtUrE, due to
> > constraints of their filesystem and the loose storage mechanism).  Are
> > either of those the goal you are trying to achieve (I think both would
> > be really nice, more so than the performance goal you have), or is
> > there another?
>
> For a Git host provider, these D/F conflict and case-sensitivity
> situations probably would need to stay as restrictions on the
> server side for quite some time because we don't want users on
> older Git clients to be unable to fetch a repository just because
> we updated our ref storage to allow for such possibilities.

Okay, but even if not used on the server side, this capability could
still be used on the client side and provide a big benefit to end
users.

But I think there's a minor issue with what you stated; as far as I
can tell, there is no case-sensitivity restriction on the server side
for GitHub currently, and users do currently have problems cloning and
using repositories with branches that differ in case only.  See e.g.
https://github.com/newren/git-filter-repo/issues/48 and the multiple
duplicates which reference that issue.  We've also had issues at
$DAYJOB, though for GHE we added some hooks to deny creating branches
that differ only in case from another branch to avoid the problem.

Also, D/F restrictions on the server do not stop users from having D/F
problems when fetching.  If users forget to use `--prune`, then when a
refs/heads/foo has already been fetched is deleted and replaced by a
refs/heads/foo/bar, then the user gets errors.  This issue actually
caused a bit of a fire-drill for us just recently.

So both kinds of problems already exist, for users with any git client
version (although the former only for users with unfortunate file
systems).  And both problems cause pain.  Both issues are caused by
loose refs, so limiting git storage to packed refs would fix both
issues.

> The biggest benefit on the server side is actually for consistency
> checks. Using a stacked packed-refs (especially with a tip file
> that describes all of the layers) allows an atomic way to take a
> snapshot of the refs and run a checksum operation on their values.
> With loose refs, concurrent updates can modify the checksum during
> its computation. This is a super niche reason for this, but it's
> nice that the performance-only focus also ends up with a design
> that satisfies this goal.

Ah...so this is the reason for your secondary goal?  Re-reading it
looks like you did state this, I just missed it without the longer
explanation.

Anyway, it might be worth calling out in your cover letter that there
are (at least) three benefits to this secondary goal of yours -- the
one you list here, plus the two I list above.

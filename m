Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF9FC433EF
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 17:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiB0RgB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 12:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiB0RgA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 12:36:00 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7077928E39
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 09:35:23 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id r13so20509721ejd.5
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 09:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WoGHzs4myQC+efgHe7l96DXZC+oGv/KUvb6VCZ5fxYg=;
        b=kTx02VzTUvzg7A5jVJHoopiogBQJw1Hpr0lNwN02frsPxjOxOY9h8XeBsRecOparXp
         SgrMxalTv3efzeySgCuBHo7gYRL///QYnSVQ1HKmuwsl1E7JS38LE+4o3kuyPeC+2Blf
         H6B0NceFp6DI0Tpx4wmxnTscBz+NTPgRtCk3KwcIeEOvlnLYekZJSQHaSlnIcvZEAhwF
         BRhyuh/cVCMTpuMNRKwq1w7XEEKv8+/B0V3EuCaiAuZPqVsPxO3XXs+jLVzZsa71yJSG
         G5F/nWCbXgy94wM8V5VK2AylNJTRSDr9KNMh+k57Zcp1rL4nWGX+DHRlwCVsMOl+3wIJ
         dbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WoGHzs4myQC+efgHe7l96DXZC+oGv/KUvb6VCZ5fxYg=;
        b=8OoC3+C2HtHjiLc07hh7zxIqpsgDlFPeFi9UIy2Rud2TwsJP4INrpIB8NCal2Fg4ih
         fb78Pg6jqnnsJFtNTxOwB7r3lBNqA+jbgG4X2i1ZlphhrdRaYWBzIruq5Qe7W01yyu+h
         BgjUkrklW/ijFVTL3OnyZ3w4hgCCEaJyDczwUOMq0kDxKN6s717kw0ur6d1H7VpfgRVC
         rNAFJ7lHKhQzEh6hKCImnqYNyrpph3vblTgxDZjaBe6NWnotkHP+19uwiNu6uUGmoVHD
         8EoMBljykgmBOVNY3x55XL7QkjiN01X9mU5MiBvs9nz9P/X+k46LusKHtxwnR9kleTWV
         XJgw==
X-Gm-Message-State: AOAM533tRdKOE2Qp7s3KukQ5Gkke9YD1ojG2BKWoS1ueBBRFRYRi3Hlr
        ju6I+wgB1lMvIa8RJF/cWNY=
X-Google-Smtp-Source: ABdhPJzEBUHEtXhk3KUUm5ps0k0xuE2HB3jymJer3aCTSWBdFkbD6CNdNhSxBBMLw5sbczpSnYunAw==
X-Received: by 2002:a17:906:2daa:b0:6cf:3c6:dbb7 with SMTP id g10-20020a1709062daa00b006cf03c6dbb7mr12563442eji.688.1645983321766;
        Sun, 27 Feb 2022 09:35:21 -0800 (PST)
Received: from gmail.com (91.141.32.73.wireless.dyn.drei.com. [91.141.32.73])
        by smtp.gmail.com with ESMTPSA id s2-20020a056402014200b0041285556b7csm5006523edu.72.2022.02.27.09.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 09:35:21 -0800 (PST)
Date:   Sun, 27 Feb 2022 18:35:17 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 04/15] merge-tree: implement real merges
Message-ID: <20220227173517.qrosjw75y3bcbglt@gmail.com>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
 <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643787281.git.gitgitgadget@gmail.com>
 <xmqqy22tx8t1.fsf@gitster.g>
 <CABPp-BGpD6g5QH3=4X_dCuSX0Bs0utHn5hyuU4_UiwNhU0h8sg@mail.gmail.com>
 <xmqqh79hvsgn.fsf@gitster.g>
 <CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8+iGjxsYSA@mail.gmail.com>
 <xmqqee3wt5g3.fsf@gitster.g>
 <CABPp-BE+DaBkis0r7pqs-kaChCvFhCEsyDg=gs3=QjWOPERaXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BE+DaBkis0r7pqs-kaChCvFhCEsyDg=gs3=QjWOPERaXQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 22, 2022 at 08:26:41AM -0800, Elijah Newren wrote:
> On Mon, Feb 21, 2022 at 10:55 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Elijah Newren <newren@gmail.com> writes:
> >
> > > Adding such an ability to merge-tree would be trivial -- it basically
> > > involves just two things: (1) accepting one extra argument, and (2)
> > > calling merge_incore_nonrecursive() instead of
> > > merge_incore_recursive().
> > >
> > > However, I think forking a subprocess for every merge of a series of
> > > commits is a completely unreasonable overhead, so even if we provide
> > > such an option to merge-tree, I still want a separate plumbing-ish
> > > tool that does non-worktree/non-index replaying of commits which is
> > > not written as a driver of merge-tree.  That other tool should just
> > > call merge_incore_nonrecursive() directly.  And such a tool, since it
> > > should handle an arbitrary number of commits, should certainly be able
> > > to handle just one commit.  From that angle, it feels like adding
> > > another mode to merge-tree would just be a partial duplication of the
> > > other tool.

I don't think "to avoid duplication" is a good argument for making this
plumbing command less flexible, because that's just chasing a local minimum
w.r.t. redundancy. More general APIs will lead to a global minimum.

> >
> > The above does not make much sense to me.
> >
> > I am hearing that "multi-step cherry-picks and reverts need to be
> > fast and we need something like sequencer that is all written in C,
> 
> Yes, I agree with that part so far.  jj is kicking our butt on rebase
> speed; I'm not sure if we can catch it, but it'd be nice to see us not
> be more than a hundred times slower.
> 
> > and single-step cherry-pick is merely a special case that does not
> > deserve a plumbing".
> 
> Well, apparently I failed at communication if that's what you heard.
> Perhaps I can step back and provide my high-level goals, and then
> mention how this series fits in.  My high-level goals:
> 
>   * new sequencer-like replay tool, including multiple abilities
> today's rebase/cherry-pick tools don't have
>   * enable folks to use merging machinery for server side operations
> (merge, rebase, cherry-pick, revert)
>   * do not repeat or encourage the rebase-as-shell-script mistakes of yesteryear
>   * somehow split this up into reviewable chunks
> 
> Now, in particular, the "merge divergent branches" piece seemed like a
> really simple portion of the problem space for which I could get some
> early feedback without having to address the whole problem space all
> at once, and which doesn't seem to have any downside risk.
> 
> And even with my attempt to narrow it in scope, and even despite lots
> of early feedback from the Git Virtual Contributor Summit six months
> ago, it's been nearly two months of active discussions including all
> kinds of intrinsic and tangential points about the UI and design.  Why
> try to prematurely widen the scope?  Can we just focus on merging
> divergent branches for now, and cover the rest later?
> 
> > But that argument leads to "and the same something-like-sequencer
> > that is all written in C would need '--rebase-merges' that can pick
> > multi-step merge sequences, and single-step merge does not deserve a
> > plumbing", which is an argument against this topic that is utterly
> > absurd.
> >
> > So why isn't your objection not equally absurd against having a
> > single step cherry-pick or revert primitive as a plumbing?
> 
> The objection you are arguing against is not my position.  In fact,
> I'm not even objecting to having a single-step cherry-pick, I'm
> objecting to providing it _now_, which I thought would have been clear
> from the portion of my email you snipped ("...I'm happy to add [a
> single step cherry-pick primitive] along with the tool I submit
> later...").  Since that wasn't clear, and since that wasn't my only
> communication failure here, let me attempt to be clearer about my
> objection(s):
> 
> 1. I'm really trying to pick off a small piece of the problem space
> and get feedback on it without unnecessarily complicating things with
> unrelated issues.  Thus, this series is _only_ about merging branches
> that have diverged, and leaves commit replaying for later.
> 
> 2. Two folks have chimed in about the single step cherry-pick, and the
> ONLY reason given for wanting such a thing was to create a
> rebasing/cherry-picking script which was driven by repeatedly invoking
> this low-level primitive command.  That's also the only usecase I can
> currently think of for such a primitive.  To me, that means providing
> such a low-level command now would be likely to result in the
> rebase-as-a-script mistake of yesteryear.  I think we can avoid that
> pitfall by first providing a tool that avoids the
> repeatedly-fork-git-subprocesses model.  (Also, providing a low-level
> single-step cherry-pick command also has the added negative of further
> distracting from the focus on merging divergent branches.)

I agree that it's not a good idea to call merge-tree in a loop for
cherry-picking commit sequences.

At the same time, it is weird for such a low-level tool to not allow
specifying merge bases.
Accepting merge bases is the more logical API, that might allow curious
users to figure out how revert/cherry-pick are implemented.

I intuitively prefer the version that accepts merge bases but I don't have
a good use case, so I think it's okay to add that later if we ever find use
for it.

> 
> 3. The merge primitive in this series is useful completely independent
> of any rebasing script (it would not be used solely for rebasing
> merges, if it's used for that purpose at all, as evidenced by the fact
> that dscho is already trying to use it for doing new real merges).
> 
> 4. Once we have a git-replay tool that can replay a sequence of
> commits, there _might_ not be a need for a single commit replaying
> primitive.  If we provided one as you and Johannes Altimanninger were
> asking for, and it turned out to be deemed useless because the later
> tool I provide can do everything it can and more, haven't we just
> wasted time in providing it?  And perhaps also wasted future time as
> we then have work to do to deprecate and remove the new command or
> mode? (NOTE: I did *not* say there was "no need" for a single-commit
> replaying primitive -- I said there "might not" be a need.)

If we get a tool that can do multiple cherry-picks, I think there is no
technical reason against having an equivalent tool that can do multiple merges.
In that future, merge-tree might be mostly obsolete.

In general, this is a difficult discussion.  It's really hard to judge
this series without a bigger picture of how our future UI will look like.
(Thanks for sharing the replay code BTW, there are some nice features in
there.)  Though I agree that integrating this (minimal) series first makes
a ton of sense, because it already supports a valid use case.

I feel like the output format is a bit experimental because it doesn't give
much of the conflict information in a machine-parseable format.  Of course
it's good enough for many uses (so I don't think this should block this
topic) but I think we should have a plan on how to change the output format
in future without adding ugly compatibility hacks. Marking merge-tree as
"experimental" (like git-switch/git-restore) comes to mind.  That would work
although it's not the most user-friendly way.

(OK I just saw that you are still looking into the output format in
CABPp-BG++YqesTxp+JL3XzwrogfMag1NscoMpCOExmV9z6Py9A@mail.gmail.com )

I wanted to implement some (cherry-picking) scripts using merge-tree but I
don't have enough time or need, so I don't have much feedback on the output
format today. I can imagine that it would be nice to have a clear distinction
between content conflicts and non-content conflicts, but let's worry about
that later..

> 
> Also, since you bring up --rebase-merges, there's an additional point
> about it that might be relevant:
> 
> 5. While you could implement a naive --rebase-merges in terms of a
> primitive for merging divergent branches (or vice-versa, i.e.
> implement merging divergent branches from a naive --rebase-merges
> implementation), I think replaying merges more intelligently[*] is
> actually a distinct operation from doing a new merge of divergent
> branches and that you probably can't implement one in terms of the
> other.  (I'm not certain on this, and definitely don't want to argue
> the finer points on it while my implementation is still half-baked,
> but I really do think they are different things right now.)
> 
> [*] https://lore.kernel.org/git/CABPp-BHp+d62dCyAaJfh1cZ8xVpGyb97mZryd02aCOX=Qn=Ltw@mail.gmail.com/

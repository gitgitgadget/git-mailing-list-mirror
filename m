Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E990C2BB1D
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 22:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA3D20716
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 22:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYiKQWwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCLWlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:41:03 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34734 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgCLWlD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 18:41:03 -0400
Received: by mail-ot1-f66.google.com with SMTP id j16so8103133otl.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 15:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=us+Rfmutv6wNIn/I4PpFLg7Qrn9zNCroz6MikbJLF+I=;
        b=KYiKQWwAIXvNxiAh7xDcXiIEY78zS8vJR2YhLg26Legg8hT5ifL0pq9aoyFaux9WAF
         85CDFG2ZMJCYl+8fbuMFOCHgufMBtwO2HJhvzZ9P27LuKG06TJy+iX57WhdxU+FLFmNE
         A9+3doT3DGjdPkm8y7XhExJKLAUq0KTzgD4TCp9eqlQzTxkk40u7MRZsJPyTGblaGyw3
         Ca9SybEHOGQyhcz92NxMYDEy+GsY2qK8AE1H5dginMmYUCLmRy5a/BsarpXnJ9M/5K/n
         XdQNL1tR9TZm/Ec9CXj+G9tNARfVM6nPC7Zc9XdzylGkFD4nAmf8uIOwpfPrmv4ryhaW
         GchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=us+Rfmutv6wNIn/I4PpFLg7Qrn9zNCroz6MikbJLF+I=;
        b=lGnVM6eiaBgJudj1Ppt8OT0z5+ETRCb1JRd1Ujt3YrMlMaqRL2N1N3OpVd3r211Iv/
         NmnzzhArcXLQAsiFGbTMFnKJ5o6ma+umn/P+K8LhwpfjGHEduLoYPufCsdB+rQtspU52
         o6ycmSO7Q/DP7+Y/m9PEQajoEDEHTynW6oqOc8jxH2qj4O7f+hdD8mhwwPoyaoRAchRN
         zV1GliH5LRLAJbnSAny+RUtTUwALHypcg3V7g8d0CLPCdEIV+wbcXbFyFmRvsPKDRVTC
         7ohkyTKOCfc4FL6V3v5VNWWtTQbWjZLMezqdH4aCMRK9Rdn/4MT+fUzSvsEvpkt4FTwP
         0KrA==
X-Gm-Message-State: ANhLgQ3wawZUWm2y5ngbifgCi0vRc8y8kuuLKhsEdNoqcjEOEUpD9SfM
        Q3PxPr5Swtd6xuIxb7KfRN0daRFFUHWuL9H32yOG4utW
X-Google-Smtp-Source: ADFU+vvsuy7A4g+DZPKu2CLD0MGS7AED7YZ2SaLBLZFSlM2cpu0gpLEJhBmKuEAoaBAoji9ItwgmMVlEP4OlpfUI6Yo=
X-Received: by 2002:a9d:5cc8:: with SMTP id r8mr8593270oti.345.1584052862092;
 Thu, 12 Mar 2020 15:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200310225641.96556-1-jonathantanmy@google.com> <20200312180427.192096-1-jonathantanmy@google.com>
In-Reply-To: <20200312180427.192096-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 12 Mar 2020 15:40:50 -0700
Message-ID: <CABPp-BE83ZhezkgmwatxAhqh4rptMUggcjSwBeiSByyPTUi6Lw@mail.gmail.com>
Subject: Re: [PATCH] rebase --merge: optionally skip upstreamed commits
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 On Thu, Mar 12, 2020 at 11:04 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > > Does this suggest that the cherry-pick detection is suboptimal and
> > > needs to be improved?  When rebasing, it is typical that you are just
> > > rebasing a small number of patches compared to how many exist
> > > upstream.  As such, any upstream patch modifying files outside the set
> > > of files modified on the rebased side is known to not be PATCHSAME
> > > without looking at those new files.
> >
> > That's true - and this would drastically reduce the fetches necessary in
> > partial clone, perhaps enough that we no longer need this check.
> >
> > In the absence of partial clone, this also might improve performance
> > sufficiently, such that we no longer need my new option. (Or it might
> > not.)
>
> I took a further look at this. patch-ids.c and its caller
> (cherry_pick_list() in revision.c) implement duplicate checking by first
> generating full diff outputs for the commits in the shorter side,
> putting them in a hashmap keyed by the SHA-1 of the diff output (and
> values being the commit itself), and then generating full diff outputs
> for the commits in the longer side and checking them against the
> hashmap. When processing the shorter side, we could also generate
> filename-only diffs and put their hashes into a hashset; so when
> processing the longer side, we could generate the filename-only diff
> first (without reading any blobs) and checking them against our new
> hashset, and only if it appears in our new hashset, then do we generate
> the full diff (thus reading blobs).
>
> One issue with this is unpredictability to the user (since which blobs
> get read depend on which side is longer), but that seems resolvable by
> not doing any length checks but always reading the blobs on the right
> side (that is, the non-upstream side).
>
> So I would say that yes, the cherry-pick detection is suboptimal and
> could be improved.

Sweet, thanks for doing this investigative work!  Sounds promising.

> So the question is...what to do with my patch? An
> argument could be made that my patch should be dropped because an
> improvement in cherry-pick detection would eliminate the need for the
> option I'm introducing in my patch, but after some thought, I think that
> this option will still be useful even with cherry-pick detection.

The option may be totally justified here, but can I go on a possible
tangent and vent for a little bit?  We seem to introduce options an
awful lot.  While options can be valuable they also have a cost, and I
think we tend not to acknowledge that.  Some of the negatives:

- Developers add options when they run into bugs instead of fixing
bugs (usually they don't realize that the behavior in question is a
bug, but that's exacerbated by a willingness to add options and not
consider costs)
- Developers add options without considering combinations of options
and what they mean (though it's hard to fault them because considering
combinations becomes harder and harder with the more options we have;
it's a negative feedback cycle)
- Growth in number of options leads to code that is hard or impossible
to refactor based on a maze of competing options with myriad edge and
corner cases that are fundamentally broken
- Users get overloaded by the sheer number of options and minor distinctions

The fourth case is probably obvious, so let me just include some
examples of the first three cases above:
* Commits b00bf1c9a8 ("git-rebase: make --allow-empty-message the
default", 2018-06-27), 22a69fda19 ("git-rebase.txt: update description
of --allow-empty-message", 2020-01-16), and d48e5e21da ("rebase
(interactive-backend): make --keep-empty the default", 2020-02-15)
noted that options that previously existed were just workarounds to
buggy behavior and the flags should have been always on.
* Commit e86bbcf987 ("clean: disambiguate the definition of -d",
2019-09-17) showed a pretty hairy case where the combination of
options led to cases where I not only didn't know how to implement
correct behavior, I didn't even know how to state what the desired
behavior for end-users was.  Despite a few different reports over a
year and a half that I had a series that fixed some known issues for
users the series languished because I couldn't get an answer on what
was right.  See also
https://lore.kernel.org/git/20190905154735.29784-1-newren@gmail.com/
* See the huge "Behavioral differences" section of the git-rebase
manpage, and a combination of rants from me on dir.c:
  - https://lore.kernel.org/git/20190905154735.29784-1-newren@gmail.com/
  - https://lore.kernel.org/git/CABPp-BFG3FkTkC=L1v97LUksndkOmCN8ZhNJh5eoNdquE7v9DA@mail.gmail.com/
  - https://lore.kernel.org/git/pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com/
  - The commit message of
https://lore.kernel.org/git/d3136ef52f3306d465a5a6004cdc9ba5b1ae4148.1580495486.git.gitgitgadget@gmail.com/

>  If we
> move in a direction where not only blobs but also trees (or even
> commits) are omitted, we'll definitely want this new option.

Why would this new option be needed if we omitted trees?   If trees
are omitted based on something like sparse-checkouts, then they are
omitted based on path; shouldn't we be able to avoid walking trees
just by noting they modified some path outside a requested sparse
checkout?

I want grep, log, etc. to behave within the cone of a sparse checkout,
which means that I need trees of upstream branches within the relevant
paths anyway.  But theoretically I should certainly be able to avoid
walking trees outside those paths.

>  And even if
> a user is not using partial clone at all, I think it is still useful to
> suppress both the filtering of commits (e.g. when upstream has a commit
> then revert, it would be reasonable to cherry-pick the same commit on
> top) and reduce disk reads (although I don't know if this will be the
> case in practice).

That sounds like yet another argument that the behavior you're arguing
for should be the default, not a flag we make the users pick to
workaround bugs.  Yes, sometimes weird behaviors beget usecases (cue
link to xkcd's comic on emacs spacebar overheating) and we need to
provide transition plans, but I think this might be a case where
transitioning makes sense.  From a high level, here's my guess
(emphasis on guess) at the history:

* am checked for upstream patches, because apply would get confused
trying to apply an already applied patch
* legacy-interactive-rebase would check for upstream patches as a
performance optimization because having to shell out to a separate
cherry-pick process for each commit is slow (and may have also been
done partially to match am, even though am did it as a workaround)

And now we're in the state where:
* The check-for-upstream bits hurt performance, significantly enough
that we have three different reports of folks not liking it (you, me,
and Taylor)
* It actively does the wrong thing in cases such as revert + re-apply
sequences, which exist in practice (and exist a lot more than they
should, but they absolutely do exist)

We've made changes in other places (e.g. opening an editor for merge
or rebase, push.default, etc.); is there any reason a similar change
wouldn't be justified here?

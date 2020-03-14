Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACB8C0044D
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 03:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB2220724
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 03:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4ccYacL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgCODWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Mar 2020 23:22:07 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42082 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCODWG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Mar 2020 23:22:06 -0400
Received: by mail-qk1-f195.google.com with SMTP id e11so20111127qkg.9
        for <git@vger.kernel.org>; Sat, 14 Mar 2020 20:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8KoH8q0ZsY2J8ppjx9qjB70gMqCDOfDWPTUeLRctHWw=;
        b=U4ccYacLQ0EHLu95kLlK9TGU38ja/XDm4htvtmjRqQ1OMNnHshprTwHaTfPE/DsAtl
         xPLqRMeR+/I56a0HhSzDrbUYE9edInrPgAEeUW0qTyrAAptGq4Hwsy0pt6cFMsi9fpyt
         vZuPAhn4CqtjnPg8vtc0IeEJS+InGYXZc3es7uWSk288MTYJgAJJSToU6N5xnPAaQUuu
         TGWQB5BKcr7mseATi3ESO0wWRFpsMHULe0meNXZXGIKHdSHHIZ0XPtaBzdla+j27pmEB
         iNZlk0BQmlizNe/3XaGKUnZn5CTBN1ESvulr0FczwWYiGf2TRsHqBYuVrVzNMrmDQgHc
         NSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KoH8q0ZsY2J8ppjx9qjB70gMqCDOfDWPTUeLRctHWw=;
        b=jzw3vJOsGG6vwvh84lzjubgNCnTGP9dxxbzZnrWgcUbGegnYIj3wF0wrrTj31U/KFG
         YypNV0JPCH1lA8+PoDpsDk+uR5cmCV0CSqdSMeK7I1VexaM7c56aURgvFZW84e/9EU1d
         5ROC7wHU+/sl+yT6OkK2AvzD2Nimya3iEQDtecQlMTZ5KlgzGHtfS9SfGJ0RQ3M4GfM5
         WhrWNHpX1QP99/YQ+OnOkj56o/5mcNCNo4rXgW2scm4tCqUoEYLBdkzJ6nIkbNGEndPn
         eCVja0sxHUiHuxh84tedAL+KerOIQc/f3wueqA3LcB7P8FctGL70XraGPB9hftuCyKkN
         MIVA==
X-Gm-Message-State: ANhLgQ0jtif0GK2VUeSr8sT6NSEh1gIscZPkbk8JL355x5NYTqNHxs9P
        DfxT8JIXBN4e17S3Mzi/8UU59O91Pe83RXiB5hznok1V
X-Google-Smtp-Source: ADFU+vstahyNEJ7S6ooriKb3zLLueVg3rQM2N2FNQ4L5Pdksb6xXD+Q/1j7baRsozsEnIVhjpAWyRr/UQ/ZfPE32OhA=
X-Received: by 2002:a05:6830:1447:: with SMTP id w7mr14664127otp.267.1584173107608;
 Sat, 14 Mar 2020 01:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200310225641.96556-1-jonathantanmy@google.com>
 <20200312180427.192096-1-jonathantanmy@google.com> <CABPp-BE83ZhezkgmwatxAhqh4rptMUggcjSwBeiSByyPTUi6Lw@mail.gmail.com>
In-Reply-To: <CABPp-BE83ZhezkgmwatxAhqh4rptMUggcjSwBeiSByyPTUi6Lw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 14 Mar 2020 01:04:55 -0700
Message-ID: <CABPp-BGcQHT5PkqYw3YRWOv8kbiSumJ+YQ3owkd_7viKWs3q7A@mail.gmail.com>
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

On Thu, Mar 12, 2020 at 3:40 PM Elijah Newren <newren@gmail.com> wrote:
>
>  On Thu, Mar 12, 2020 at 11:04 AM Jonathan Tan <jonathantanmy@google.com> wrote:
> >
> > > > Does this suggest that the cherry-pick detection is suboptimal and
> > > > needs to be improved?  When rebasing, it is typical that you are just
> > > > rebasing a small number of patches compared to how many exist
> > > > upstream.  As such, any upstream patch modifying files outside the set
> > > > of files modified on the rebased side is known to not be PATCHSAME
> > > > without looking at those new files.
> > >
> > > That's true - and this would drastically reduce the fetches necessary in
> > > partial clone, perhaps enough that we no longer need this check.
> > >
> > > In the absence of partial clone, this also might improve performance
> > > sufficiently, such that we no longer need my new option. (Or it might
> > > not.)
> >
> > I took a further look at this. patch-ids.c and its caller
> > (cherry_pick_list() in revision.c) implement duplicate checking by first
> > generating full diff outputs for the commits in the shorter side,
> > putting them in a hashmap keyed by the SHA-1 of the diff output (and
> > values being the commit itself), and then generating full diff outputs
> > for the commits in the longer side and checking them against the
> > hashmap. When processing the shorter side, we could also generate
> > filename-only diffs and put their hashes into a hashset; so when
> > processing the longer side, we could generate the filename-only diff
> > first (without reading any blobs) and checking them against our new
> > hashset, and only if it appears in our new hashset, then do we generate
> > the full diff (thus reading blobs).
> >
> > One issue with this is unpredictability to the user (since which blobs
> > get read depend on which side is longer), but that seems resolvable by
> > not doing any length checks but always reading the blobs on the right
> > side (that is, the non-upstream side).
> >
> > So I would say that yes, the cherry-pick detection is suboptimal and
> > could be improved.
>
> Sweet, thanks for doing this investigative work!  Sounds promising.
>
> > So the question is...what to do with my patch? An
> > argument could be made that my patch should be dropped because an
> > improvement in cherry-pick detection would eliminate the need for the
> > option I'm introducing in my patch, but after some thought, I think that
> > this option will still be useful even with cherry-pick detection.
>
> The option may be totally justified here, but can I go on a possible
> tangent and vent for a little bit?  We seem to introduce options an
> awful lot.  While options can be valuable they also have a cost, and I
> think we tend not to acknowledge that.  Some of the negatives:
>
> - Developers add options when they run into bugs instead of fixing
> bugs (usually they don't realize that the behavior in question is a
> bug, but that's exacerbated by a willingness to add options and not
> consider costs)
> - Developers add options without considering combinations of options
> and what they mean (though it's hard to fault them because considering
> combinations becomes harder and harder with the more options we have;
> it's a negative feedback cycle)
> - Growth in number of options leads to code that is hard or impossible
> to refactor based on a maze of competing options with myriad edge and
> corner cases that are fundamentally broken
> - Users get overloaded by the sheer number of options and minor distinctions
>
> The fourth case is probably obvious, so let me just include some
> examples of the first three cases above:
> * Commits b00bf1c9a8 ("git-rebase: make --allow-empty-message the
> default", 2018-06-27), 22a69fda19 ("git-rebase.txt: update description
> of --allow-empty-message", 2020-01-16), and d48e5e21da ("rebase
> (interactive-backend): make --keep-empty the default", 2020-02-15)
> noted that options that previously existed were just workarounds to
> buggy behavior and the flags should have been always on.
> * Commit e86bbcf987 ("clean: disambiguate the definition of -d",
> 2019-09-17) showed a pretty hairy case where the combination of
> options led to cases where I not only didn't know how to implement
> correct behavior, I didn't even know how to state what the desired
> behavior for end-users was.  Despite a few different reports over a
> year and a half that I had a series that fixed some known issues for
> users the series languished because I couldn't get an answer on what
> was right.  See also
> https://lore.kernel.org/git/20190905154735.29784-1-newren@gmail.com/
> * See the huge "Behavioral differences" section of the git-rebase
> manpage, and a combination of rants from me on dir.c:
>   - https://lore.kernel.org/git/20190905154735.29784-1-newren@gmail.com/
>   - https://lore.kernel.org/git/CABPp-BFG3FkTkC=L1v97LUksndkOmCN8ZhNJh5eoNdquE7v9DA@mail.gmail.com/
>   - https://lore.kernel.org/git/pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com/
>   - The commit message of
> https://lore.kernel.org/git/d3136ef52f3306d465a5a6004cdc9ba5b1ae4148.1580495486.git.gitgitgadget@gmail.com/
>
> >  If we
> > move in a direction where not only blobs but also trees (or even
> > commits) are omitted, we'll definitely want this new option.
>
> Why would this new option be needed if we omitted trees?   If trees
> are omitted based on something like sparse-checkouts, then they are
> omitted based on path; shouldn't we be able to avoid walking trees
> just by noting they modified some path outside a requested sparse
> checkout?
>
> I want grep, log, etc. to behave within the cone of a sparse checkout,
> which means that I need trees of upstream branches within the relevant
> paths anyway.  But theoretically I should certainly be able to avoid
> walking trees outside those paths.
>
> >  And even if
> > a user is not using partial clone at all, I think it is still useful to
> > suppress both the filtering of commits (e.g. when upstream has a commit
> > then revert, it would be reasonable to cherry-pick the same commit on
> > top) and reduce disk reads (although I don't know if this will be the
> > case in practice).
>
> That sounds like yet another argument that the behavior you're arguing
> for should be the default, not a flag we make the users pick to
> workaround bugs.  Yes, sometimes weird behaviors beget usecases (cue
> link to xkcd's comic on emacs spacebar overheating) and we need to
> provide transition plans, but I think this might be a case where
> transitioning makes sense.  From a high level, here's my guess
> (emphasis on guess) at the history:
>
> * am checked for upstream patches, because apply would get confused
> trying to apply an already applied patch
> * legacy-interactive-rebase would check for upstream patches as a
> performance optimization because having to shell out to a separate
> cherry-pick process for each commit is slow (and may have also been
> done partially to match am, even though am did it as a workaround)

Or maybe that wasn't the reasoning?  I'm having a hard time parsing the
history to verify:

a6ec3c1599 ("git-rebase: Use --ignore-if-in-upstream option when
            executing git-format-patch.", 2006-10-03)
  '''This reduces the number of conflicts when rebasing after a series of
     patches to the same piece of code is committed upstream.'''

96ffe892e3 ("rebase -i: ignore patches that are already in the
            upstream", 2007-08-01)
  '''Non-interactive rebase had this from the beginning -- match it by
     using --cherry-pick option to rev-list.'''

and related: 1e0dacdbdb ("rebase: omit patch-identical commits with
    --fork-point", 2014-07-16)

> And now we're in the state where:
> * The check-for-upstream bits hurt performance, significantly enough
> that we have three different reports of folks not liking it (you, me,
> and Taylor)
> * It actively does the wrong thing in cases such as revert + re-apply
> sequences, which exist in practice (and exist a lot more than they
> should, but they absolutely do exist)

Though these are definitely still problems with
check-if-upstream-already behavior.

> We've made changes in other places (e.g. opening an editor for merge
> or rebase, push.default, etc.); is there any reason a similar change
> wouldn't be justified here?

After another day of thought, and my attempt to figure out the reason
above, perhaps my assumptions about the reason behind the original
behavior, any my assumptions about the sanity of switching the default
might not be as grounded as I thought.  Thus, my worries about yet
another flag may be overstated as well, at least in this case.

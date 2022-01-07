Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A73C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 03:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiAGDwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 22:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiAGDwB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 22:52:01 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294BFC061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 19:52:00 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j21so17116392edt.9
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 19:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ji7QFyi748ckmf+wdlpbwDKogIocEW0t1Ai7bCnGlic=;
        b=BFvL7ZTmpccXG2UbMfFR1owOQxBCZc70AuJrIKtc53r196UdCCtYcqxQ5HO8qBGURc
         PDC7tot8ro7t4nQWH/W3RTR8exGITc+HgCQH+jn1kjPTVxTR26VsEmPhcaBTYwIMTsEi
         ror3pUyklalHpUhoRh+fyMygdp1LpguA3rSXpeW1F9wQG7tTOzny5+tsameEdNFGUnPg
         ntmEYfrlNreOd2Vn/+LlHQIAGaERL5Yw2hlQ3vdz4GjP9MPLNI/CtrGB8VmL851mJLhD
         dnCWCbMrSVMcCsVxkBqRhEKHY6dt1OvO/VKl02dz+oQ4pLYuW8NMh+2AD0095SJSevzR
         qwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ji7QFyi748ckmf+wdlpbwDKogIocEW0t1Ai7bCnGlic=;
        b=mTrgDYJXZ5z3tLiIwm+EeVSLJh0wePSlOVT6lv0WMNYlvXC9Y9+E//O3MG60VGTErh
         aJHkErHEPfax02nGv9rjSWegiEHckryQrb3FRGOg0Rf4Dw4cJSCpKk9cBOlLm/Tg77QN
         aGDottDTSJdYL7a69R5qbRQc1JOpmRmiIv7EW5mP9NZx6tFIvqa87xPvH4zOnqdVvi2P
         uiX0ecK+gHWdjN7cs2QK1jSk/otGBSruNpLObqLCOr341jHLtTfKQLkjBAPBvjQ6Gjvq
         u32wBAHrZ3gJ+2WoMwn5X2uMyu/Jpcn0N/CWNeoTErdLs5M1uPkY632c4xNvlyLAgxMI
         j/QQ==
X-Gm-Message-State: AOAM531AzLSzR1Tq/0afyDgrHsAFMIyXzA7YhMpUMvuseIApSbjLHCoY
        ydgz+z5IIm+lz3nT+py//Fp+L4QkPX54Rle774PlA/frIrafVA==
X-Google-Smtp-Source: ABdhPJyvB8utlhqEjyobL7PeO/u/LBICmCd378HyV+yGbDJfHUG/nEVWN+yHGWcDJPfl3eEqwXc6BK0gvPxx5lLv3fM=
X-Received: by 2002:a17:906:2a09:: with SMTP id j9mr25991421eje.515.1641527518867;
 Thu, 06 Jan 2022 19:51:58 -0800 (PST)
MIME-Version: 1.0
References: <20220105232755.23523-1-jerry@skydio.com> <xmqqpmp4bjni.fsf@gitster.g>
In-Reply-To: <xmqqpmp4bjni.fsf@gitster.g>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Thu, 6 Jan 2022 19:51:48 -0800
Message-ID: <CAMKO5CsGJdDYvBsb8_-AkpAeeoVGY0Qhv4sX8TimJ4eqR=sLvA@mail.gmail.com>
Subject: Re: [PATCH V3] git-rev-list: add --first-parent-not flag
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 6, 2022 at 2:10 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jerry Zhang <jerry@skydio.com> writes:
>
> > Add the --path-first-parent-not flag, which
> > causes the traversal of any "not" commits
> > to visit only the first parent upon encountering
> > a merge commit.
> >
> >    -A-----E-F-G--main
> >      \   / /
> >       B-C-D--topic
> >
> > In this example, the goal is to return the
> > set {B, C, D} which represents a topic
> > branch that has been merged into main branch.
> > `git rev-list topic ^main` will end up returning
> > no commits since excluding main will end up
> > traversing the commits on topic as well.
> > `git rev-list --first-parent-not topic ^main`
> > however will return {B, C, D} as desired.
>
> It may be true for _this_ particular topology, but it is unclear
> what "the goal" is, and if the "ignore side branches that got
> merged" is the right way to achieve that goal.  Perhaps shuffling
> the order of explanation to state what you want to achieve first may
> help clarify.
>
> Is the goal "I have a commit that I know is at the tip of a topic
> branch, but the topic may or may not have been merged to the primary
> integration branch.  I want to know what commits were on the topic
> branch"?

Although this is a useful application of the flag, it's not something we use
it for right now (although we might in the future).

As an overview, we're building a code review tool where the
(simplified) workflow is:

1. start off on some local version of an integration branch, tracking the
remote version of that branch
2. make some local changes. valid local changes include
    - making a new commit(s)
    - merging in other branches (could be remote integration branches
or feature branches)
    - merging in the head of the tracking branch to get the latest changes
3. identify which local changes were made and upload them (in our case
to github).

So our goals are:

1. Automatically identify the appropriate integration branch that the user
is intending to target, without needing to add arguments to the command.
2. Automatically identify relevant commits that the user has made on top of
the integration branch, without needing to add arguments.

We accomplish these by defining the "fork point" of two branches, although
note that this is different from what is found by "merge-base --fork-point".
Fork point of branch "dev" and "main" is the first parent of the last element of
"git rev-list --first-parent --exclude-first-parent-only main ^dev"
or equivalently, the first parent of the last element of
"git rev-list --first-parent --exclude-first-parent-only ^main dev".

The proof that those two are equivalent: when both flags are specified, rev-list
can only ever traverse first parents. This makes it as though all non
first parent
edges don't exist, so the git graph becomes basically a directed tree. Since we
are only traversing from 2 leaves, only 2 paths are traversed, and since they
are assumed to share history, the traversal forms a "Y".
       B ---- main
      /
--- A
      \
      C ---- dev
So "git rev-list --first-parent --exclude-first-parent-only main ^dev
--reverse | head -n 1"
finds B and "git rev-list --first-parent --exclude-first-parent-only
^main dev --reverse | head -n 1"
finds C, but both their parents are A. Hopefully this was sufficiently rigorous.

To solve goal #1, we loop the set of possible integration branches and
find the number of
local changes that our algorithm would detect. The branch that our
branch has the smallest
number of local changes (as identified in goal #2) with respect to is
considered to be the target.

To solve goal #2 we find the fork-point of our branch and the
integration branch, then
the following set is our local commits: "git rev-list --first-parent
dev ^forkpoint".

Merges will all work well with our algorithm and the new flag because
they no longer "look like" merges in terms of finding the fork point.
Another way of saying this is that because the traversal that calculates
the fork point can't follow secondary parents, merges are indistinguishable
from normal commits. Our algorithm that finds the fork-point and the set
of local changes already assumes an arbitrary number of commits between
the fork point and heads of the two different branches. Thus its impossible
to affect the correctness of the fork-point or the local commit set by adding
a normal commit. Since merges are indistinguishable from normal commits
it must also be impossible to affect this correctness by adding a merge commit.
This should prove that the flag is sufficient for our goals.

Now here is an example to show that the flag is necessary. It's a bit
complicated
but it's all valid individual and organizational uses of git.
- main branch is an integration branch that people work on
- next is a forward looking integration branch with experimental
features. it needs
occasional merges from main, but can't be merged back into main until
experimental
features have stabilized.
- dev is a local development branch.

 -A--B---C--D---main
   \  \ /    \
    \  E------------F--dev
     \        \    /
      G--------H--I--J--next

1. commit E is made on dev, PR is opened against main.
2. overnight E merges into main at C, and main is merged into next at H.
3. the next day, user fetches and merges in next at F, intending to
merge it into main.

With our algorithm, we find fork-point of dev and main to be B, so
local commits against
main are [E, F]. Fork-point of dev and next is found as A, local
commits would be [B, E, F].
Since main has a smaller set of local commits, it is chosen as the
target branch.

Without the new flag, we don't have a good definition of fork-point since
"git rev-list --first-parent main ^dev --reverse | head -n 1"
does not equal "git rev-list --first-parent ^main dev --reverse | head -n 1".
Nevertheless we can try a few things to see if we can reach the same result.
By excluding the dev branch, we find the fork point of dev and main to be
B, with local set [E, F]. However, we find the fork point of dev and
next to be I,
with local set [E, F] as well, so it becomes ambiguous which branch is the
preferred target.
Switching to excluding the target branch, we find the fork point of dev and main
to be E and working set to be [F]. Fork point of dev and next to be E
and working
set to be [F]. So it is still ambiguous and there's not any way I'm aware of to
get our desired result.

>
> Even if we disregard a fast-forward merges from side branches, which
> will screw up any algorithm that takes advantage of the assumption
> that the first-parent chain is special, I am not quite convinced how
FF merges aren't an issue here because our tool only uploads what the
user wants. If the user wants a real merge instead of an FF, its on them
to make that commit. Another way to look at it is that our tool must be
robust to all sorts of merges in the git history. Fast forwards don't look
like merges, so it isn't an issue if they've happened.

> "propagate UNINTERESTING only along the first parent chain" is
> necessary and sufficient for the purpose of solving that problem.
> Care to elaborate on the correctness of the logic a bit more?
>
> Please do not talk back with "give me a topology that the algorithm
> would not work on, then".  The onus is on to whoever proposes a
> change to show how it produces correct result.
>
> > Add docs for the new flag, and clarify the
> > doc for --first-parent to indicate that it
> > applies to traversing the set of included
> > commits only. The semantics of existing flags
> > however have not changed.
>
> This is a tangent.  Even though 45 is certainly less than 80, can we
> use a bit wider lines?  What you used in the documentation patch
> (around 60-65?) may be more readable.
>
> >  --first-parent::
> > -     Follow only the first parent commit upon seeing a merge
> > -     commit.  This option can give a better overview when
> > -     viewing the evolution of a particular topic branch,
> > -     because merges into a topic branch tend to be only about
> > -     adjusting to updated upstream from time to time, and
> > -     this option allows you to ignore the individual commits
> > -     brought in to your history by such a merge.
> > +     When finding commits to include, follow only the first
> > +     parent commit upon seeing a merge commit.  This option
> > +     can give a better overview when viewing the evolution of
> > +     a particular topic branch, because merges into a topic
> > +     branch tend to be only about adjusting to updated upstream
> > +     from time to time, and this option allows you to ignore
> > +     the individual commits brought in to your history by such
> > +     a merge.
>
> The only change is to clarify that the first-parent traversal is
> done only on the positive side; what is implied but probably is lost
> to most readers is that propagation of UNINTERESTING bit is not
> affected by this option.  I made sure that "This option can ..."
> and everything after it are identical to save other reviewers' time,
> as the above hunk have unnecessary rewrapping of the text.
>
> > +--first-parent-not::
> > +     When finding commits to exclude, follow only the first
> > +     parent commit upon seeing a merge commit.  This causes
> > +     "not" commits to exclude only commits on that branch itself
> > +     and not those brought in by a merge.
>
> Are there places we use a term '"not" commit'?  What you are trying
> to refer to is a subset of "UNINTERESTING commits"; it is the
> initial set of UNINTERESTING commits the traversal starts with.  I
> know we use the word "negative" (or sometimes "bottom") in the
> context of discussing revision ranges on this list, but I do not
> think we used either in end-user facing documentation pages.
>
> Let's read the beginning of the description of "git log --help" to
> see if we can find a good phrase our readers should already be
> familiar with.  This is how we describe the command:
>
>     List commits that are reachable by following the `parent` links
>     from the given commit(s), but exclude commits that are reachable
>     from the one(s) given with a '{caret}' in front of them.  The
>     output is given in reverse chronological order by default.
>
> Assuming that propagating the UNINTERESTING bit only along the first
> parent chain is a way to achieve some meaningful result (which, as I
> said, I am not convinced about), I probably would call this option
> "--exclude-first-parent-only" and explain it perhaps like so
>
>         Follow only the first-parent chain from commits given with a
>         {caret} in front of them, to find commits to exclude.
>
>         This prevents commits merged from the side branches from
>         becoming uninteresting and instead be shown if they are
>         reachable from the positive end of the range.
>
> I am debating myself if the second paragraph is necessary, though.
> I suspect that the first two-line paragraph may be sufficient.
Sure, I'll update the patch and commit text with these changes.

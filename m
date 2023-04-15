Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8180FC77B70
	for <git@archiver.kernel.org>; Sat, 15 Apr 2023 17:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjDORTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 13:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjDORTB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 13:19:01 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C4A2102
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 10:18:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4ec8133c698so2276399e87.0
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681579135; x=1684171135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aYQSe6B6Pm7klHuvWe/x0f8S37uQcxWx0oN1+LEHNE=;
        b=odqGLoTpSeNq67lACfFHo9GLD4b+Q/taUXX169rGdSA/mLCOdL3PK8O6iTdbhuczQx
         YpcK4R5H+FXzcXxY6pLbzRC8TKWDWqMuUnwNOyZF8r6HlGbGeZ5C5pu3krH2dayIPrbT
         WssJLNDoTkwbYZcav8e5clFEVtNm4pkAzekARDKH0EsbT3UpGu2G0MzMCKX+DppKmqqJ
         Lc7KWjZvT52pafHMYlR4t86rtOgqU3gNWZiD6a5GRM7ajL5Vt3YtR+ELuznRQsb430tJ
         3tn1SFc3grwcbLZeqya3Vw0wC/sVObyBWep9Sg1QsdqWLpVYaDSxf87jR2xlRyVE38LS
         hkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681579135; x=1684171135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4aYQSe6B6Pm7klHuvWe/x0f8S37uQcxWx0oN1+LEHNE=;
        b=IxjpvEsSF2yMUYgwgzb3OFoDIZRsaXGY5l9De5V5Yx6nT+0nnxufq/exiyB3T4tPSs
         /4kUF/uvM8jw6ihLNuHX7+rJfo7FMmP9E8G96TimoTHJ/Y6Ynlqzb1ok7Blosksi28+A
         pcM+5iM3FHczrt8sy4KLpWHDAWPNwriCHACw0vz50svLoZQgF6IWoGcISeeu/OLY2O4b
         pT///GvWFaOGB7biwG/CmkXoopyqfpNPVwBP3v1dqIGBqymgNNJo0OG5cBfKV0ieZSJl
         1TMFCSusShBXEhokYQd7uoautokEm9sKn5xHR1sTA+onr+B75sCUFdgjuzI1oO35Hr4X
         rdJg==
X-Gm-Message-State: AAQBX9fXGVWQUhat95XstnIl0eJCbDgNa+EGw3sJ9Z5PUVig37O4Ov1P
        7vzok8tCu4/AOU2JtGFNphJj/LiVJZw58yIoK6s=
X-Google-Smtp-Source: AKy350YIC67lJgwucXM6V2T1xwf/jo5ifbxPrm7RdoKnw9CaYYCyTsy2YFSV3BAgAGGP0XtQ27jwTODgUI+GelHvpp4=
X-Received: by 2002:a05:6512:10c5:b0:4e8:4409:bb76 with SMTP id
 k5-20020a05651210c500b004e84409bb76mr1077917lfg.2.1681579135025; Sat, 15 Apr
 2023 10:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230407072415.1360068-1-christian.couder@gmail.com> <25f57067-e4fe-51d5-c42c-6f95940cba27@gmail.com>
In-Reply-To: <25f57067-e4fe-51d5-c42c-6f95940cba27@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 15 Apr 2023 10:18:42 -0700
Message-ID: <CABPp-BGQWYhLrRd19jbzj3_cT8FnogngLczYNgQgZBWoeYRjwg@mail.gmail.com>
Subject: Re: [PATCH 00/14] Introduce new `git replay` command
To:     phillip.wood@dunelm.org.uk
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, Apr 14, 2023 at 3:13=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Christian and Elijah
>
> On 07/04/2023 08:24, Christian Couder wrote:
> > # Intro
> >
> > `git replay` has initially been developed entirely by Elijah Newren
> > mostly between June and July 2022 at:
> >
> > https://github.com/newren/git/commits/replay
> >
> > I took over a few months ago to polish and upstream it as GitLab is
> > interested in replacing libgit2, and for that purpose needs a command
> > to do server side (so without using a worktree) rebases, cherry-picks
> > and reverts.
> >
> > I reduced the number of commits and features in this first patch
> > series, compared to what Elijah already developed. Especially I
> > stopped short of replaying merge commits and replaying
> > interactively. These and other features might be upstreamed in the
> > future after this patch series has graduated.
> >
> > Thanks to Elijah, Patrick Steinhardt and Dscho for early reviews and
> > discussions.
> >
> > Based on ae73b2c8f1 (The seventh batch, 2023-04-04)
>
> Thanks to both of you for working on this it looks very interesting.
> I've had a quick read over the patches and I ended up slightly confused
> as to exactly what the aim of this series is. My main confusion is
> whether "replay" is intended to be a plumbing command or a porcelain
> command. The use case above suggests plumbing and there are patches that
> take it in that direction by removing any diagnostic output and stopping
> it update any refs. But then it is marked as porcelain in
> command-list.txt and there are patches that do things like
> unconditionally updating the index and worktree when there are conflicts
> that stop it working in bare repositories. I've left some comments below

Yeah, that's fair.  It was totally unclear in my work-in-progress
patches, as I had ideas taking it in both directions.  Then Christian
and Dscho came along and said they wanted to use it for server-side
rebasing & cherry-picking.  Christian did some good cleanup of my
patches, but I think your comment here is just reflecting that there's
still a bit more to do.

I'd say for now that we should expunge the worktree & index updating,
any conflict handling beyond exit status, mark it as plumbing, and
focus strictly on server-side use for now.

> > # Quick Overview (from Elijah)
> >
> > `git replay`, at a basic level, can perhaps be thought of as a
> > "default-to-dry-run rebase" -- meaning no updates to the working tree,
> > or to the index, or to any references.  However, it differs from
> > rebase in that it:
> >
> >    * Works for branches that aren't checked out
> >    * Works in a bare repository
> >    * Can replay multiple branches simultaneously (with or without commo=
n
> >      history in the range being replayed)
> >    * Preserves relative topology by default (merges are replayed too)
> >    * Focuses on performance
> >    * Has several altered defaults as a result of the above
> >
> > I sometimes think of `git replay` as "fast-replay", a patch-based
> > analogue to the snapshot-based fast-export & fast-import tools.
> >
> > # Reasons for diverging from cherry-pick & rebase (from Elijah)
> >
> > There are multiple reasons to diverge from the defaults in cherry-pick =
and
> > rebase.
> >
> > * Server side needs
> >
> >    * Both cherry-pick and rebase, via the sequencer, are heavily tied
> >      to updating the working tree, index, some refs, and a lot of
> >      control files with every commit replayed, and invoke a mess of
> >      hooks[1] that might be hard to avoid for backward compatibility
> >      reasons (at least, that's been brought up a few times on the
> >      list).
> >
> >    * cherry-pick and rebase both fork various subprocesses
> >      unnecessarily, but somewhat intrinsically in part to ensure the
> >      same hooks are called that old scripted implementations would
> >      have called.
>
> To clarify, since 356ee4659bb (sequencer: try to commit without forking
> 'git commit', 2017-11-24) cherry-pick and rebase do not fork
> subprocesses other than hooks for the cases covered by this patch series
> (i.e. they do not fork "git commit" for simple picks).

Thanks for the clarification.

Let me also add a clarification about this text you're responding to:
the document that Christian copied into this portion of the cover
letter wasn't talking about this particular series he submitted, but
about the broader design goals I was working on.  I don't want a
run_git_commit() function within replay.c, even for commit message
editing, for picking merge commits, or for handling staged changes
after resuming from an interactive rebase.  I'd even say I don't want
it for failure handling, either, though that one is less important.

> >    * "Dry run" behavior, where there are no updates to worktree, index,
> >      or even refs might be important.
> >
> >    * Should not assume users only want to operate on HEAD (see next
> >      section)
> >
> > * Decapitate HEAD-centric assumptions
> >
> >    * cherry-pick forces commits to be played on top of HEAD; inflexible=
.
> >
> >    * rebase assumes the range of commits to be replayed is
> >      upstream..HEAD by default, though it allows one to replay
> >      upstream..otherbranch -- but it still forcibly and needlessly
> >      checks out otherbranch before starting to replay things.
>
> I agree it would be nice to be able to restrict the range of commits
> replayed, especially when replaying merges. The comment about checking
> out other branch is out of date since 767a9c417eb (rebase -i: stop
> checking out the tip of the branch to rebase, 2020-01-24)

Guess how many years I've been gathering my ideas for git-replay.  ;-)

One thing to note here, though, is the checkout handling still isn't
fully fixed, and it may be impossible to fix at this point.  In
particular, `git rebase --abort` doesn't return people to the original
branch when otherbranch is specified, which is problematic in
conjunction with other options (see e.g.
https://lore.kernel.org/git/xmqqft5icsd9.fsf@gitster.c.googlers.com/).

> >    * Assuming HEAD is involved severely limits replaying multiple
> >      (possibly divergent) branches.
>
> I'm not sure how true this is anymore, since 89fc0b53fdb (rebase: update
> refs from 'update-ref' commands, 2022-07-19) the sequencer can update
> multiple branches. The issue with divergent branch is with command line
> arguments and the todo list generation rather than the capabilities of
> the sequencer.

Yeah, this particular paragraph I suspect is from about 18 months ago.
(See also where I responded to the update-refs series about this
https://lore.kernel.org/git/CABPp-BEOV53oBoBp4YjiRfksZMmAADanZUUemhxwn7Wor=
=3Dm-nA@mail.gmail.com/).

However, I'd still say the statement is true, it just needs to be
focused on the divergent branches.  The use of HEAD (or more generally
exactly 3 commitish-es), as done in rebase, is going to make it really
awkward to introduce any kind of command line UI for handling rebasing
of multiple divergent branches.  I'm not sure it even makes sense.
git-replay has done it for over a year, and I think it makes sense
specifically because it got rid of the problematic assumptions
hard-wired into the command line UI.

> >    * Once you stop assuming HEAD has a certain meaning, there's not
> >      much reason to have two separate commands anymore (except for the
> >      funny extra not-necessarily-compatible options both have gained
> >      over time).
>
> I agree having a unified command at the plumbing level certainly makes
> sense.

:-)

> >    * (Micro issue: Assuming HEAD is involved also makes it harder for
> >      new users to learn what rebase means and does; it makes command
> >      lines hard to parse.
>
> That's an interesting point, I wonder if operating on branches that are
> not checked out is potentially confusing for new user though.

Yes, absolutely.  Especially since I'm very focused on having
operations be O(changes), not O(size-of-repo).  The amount of work
people go through to avoid backporting because checking out other
branches is too expensive is impressive.  But designing things for the
user that needs scaling to big repos isn't always the friendliest to
new users.  And I admittedly am focused on performance above other
aspects, and in some cases that might leave new users behind.

> >  Not sure I want to harp on this too much, as
> >      I have a suspicion I might be creating a tool for experts with
> >      complicated use cases, but it's a minor quibble.)

Oh, heh.  I guess I knew at the time I wrote this that people might
point out ways I was not being newbie friendly.  :-)

> > * Performance
> >
> >    * jj is slaughtering us on rebase speed[2].  I would like us to beco=
me
> >      competitive.  (I dropped a few comments in the link at [2] about w=
hy
> >      git is currently so bad.)
> >
> >    * From [3], there was a simple 4-patch series in linux.git that took
> >      53 seconds to rebase.  Switching to ort dropped it to 16 seconds.
> >      While that sounds great, only 11 *milliseconds* were needed to do
> >      the actual merges.  That means almost *all* the time (>99%) was
> >      overhead!  Big offenders:
> >
> >      * --reapply-cherry-picks should be the default
>
> I agree that can be a performance hit if there are a lot of upstream
> commits, but it is also a usability feature as it means we don't stop
> and ask the user what to do with the commits that have been upstreamed
> which wastes more of their time. I think maybe we want different
> defaults for the server use case than the user replaying commits or
> perhaps default to dropping commits that become empty.

Oh, sure, there are people who will like different options and
configurations.  Non-performant features can certainly be options, I
was mostly harping on the defaults for git-replay.  It should default
to fast, even if/when it moves beyond server-side only.

> >      * can_fast_forward() should be ripped out, and perhaps other extra=
neous
> >        revision walks
>
> We should look at doing that at least for the merge backend which has
> skip_unnecessary_picks(). I think it is useful to tell the user that the
> branch was not updated by the rebase though.

Which could be done as a very simple post-operation check: do pre- and
post- hashes match?  No need for a bunch of logic to check what's
going to happen that'll result in slow startup in large repositories.
Default should be fast and scale to large repos.

> >      * avoid updating working tree, index, refs, reflogs, and control
> >        structures except when needed (e.g. hitting a conflict, or opera=
tion
> >        finished)
>
> Not writing to disc unless we need to is sensible. Having said that for
> interactive rebases I do find having HEAD's reflog record all the picks
> useful to unpick what went wrong if mess something up.

Adding an option for writing HEAD's reflog at every step along the way
might be reasonable.  But I specifically was designing a new command
with speed as priority number 1.  Updating some external file with
every commit thus should not be the default for this new command.  I
know that's incompatible with how git-rebase works, but this isn't
rebase.

Actually, there's a second problem as well.  git-replay shouldn't
update _anything_ (other than adding new un-referenced
blobs/trees/commits), until it is entirely done.  In fact, even when
it's done, it doesn't update any refs by default; it simply prints out
some "update-ref" instructions for `git update-ref --stdin` (though I
was thinking of adding a flag that would make git-replay also do the
ref updates, as the very final thing the program did).

And there's a third problem.  HEAD isn't being updated in many cases,
so why should its reflog be?

> >    * Other performance ideas:
> >
> >      * single-file control structures instead of directory of files
>
> I like the idea as it should make it easier to keep the on disc state
> consistent, but I'm not sure how much of an issue that is in practice as
> we only read/write the files once each time git is run. The bigger slow
> down is writing the author script, commit message, list of rewritten
> commits, todo list and done files with each pick.

The author script, commit message, list of rewritten commits, todo
list and done files are all control structures that are part of that
directory of files I was complaining about.  As far as I can tell, you
said it's not an issue, but then immediately said the opposite.  What
did you take the "directory of files" control structures to mean?
...and is there some other way I could word this that would be better?

Also, if we speed up the other stuff enough, the writing of the
control files becomes much more important.  See the example elsewhere
where I mentioned that for a cherry-pick of a single commit that took
a minute under git-rebase, that actually creating the new toplevel
tree only required like 11 milliseconds.  If we can speed things up
dramatically enough, then all the stuff that used to just not matter,
suddenly starts mattering a lot.  (This happened a lot when I was
rewriting the merge machinery and optimizing it.)  And, I think that
writing one file is going to be faster than writing N files
(especially on spinny disks, and yes my laptop has a spinny disk).

Also, single file control structures are easier to make safe against
an ill-timed Ctrl-C, though I suspect that's so rarely a problem that
it may not be worth worrying much about.

> >      * avoid forking subprocesses unless explicitly requested (e.g.
> >        --exec, --strategy, --run-hooks).  For example, definitely do no=
t
> >        invoke `git commit` or `git merge`.
>
> Good, that matches what the sequencer does for non-merge commits when
> we're not editing the commit message.

...and when not committing staged changes after a stopped interactive
rebase, and when not trying to ensure identical error messages when an
issue is hit.  :-)

This is good; sequencer is always improving.  If it could just stop
calling git commit in these four extra cases, we'd be rid of the
git-commit forking for good.

> >      * Sanitize hooks:
> >
> >        * dispense with all per-commit hooks for sure (pre-commit,
> >          post-commit, post-checkout).
>
> I agree we should not be running those (we don't run the pre-commit hook
> anyway).

...unless picking a merge commit or editing the commit message or...  :-)

> However we had a bug report when cherry-pick stopped running
> the "prepare-commit-msg" hook (see
> https://lore.kernel.org/git/CAKdAkRQuj1hfKeckjuR2oP+8C1i+ZR36O-+aRYif4ufa=
S_zs+w@mail.gmail.com/).
> That shouldn't matter for the server but we should bear it in mind when
> it comes to other use cases.

git-fast-export and git-fast-import do not run hooks, in part for
speed.  I don't think git-fast-patch, i.e. git-replay should either,
at least not by default.  I'm well aware that it's impossible to make
that kind of change to git-rebase, but I'm not trying to design
another rebase.

Another thing that might horrify you that I don't think I wrote down
is that when interactivity is added, I don't want replay to pre-parse
and validate the script, much like fast-import doesn't pre-parse and
validate its input.  Not validating would be anathema to how rebase
operates (because rebase muddies things as it goes -- the worktree and
the index AND refs AND reflogs, and it's slow, so you don't want to
start down that path until you're confident that people didn't make
simple mistakes).  As such, this is a change that I'd never even
consider suggesting for rebase, but it's exactly the kind of thing I
want for replay.

> >        * pre-rebase also seems to assume exactly 1 ref is written, and
> >          invoking it repeatedly would be stupid.  Plus, it's specific
> >          to "rebase".  So...ignore?  (Stolee's --ref-update option for
> >          rebase probably broke the pre-rebase assumptions already...)
>
> If replay is a plumbing command then skipping the pre-rebase hook makes
> sense as scripts can call it themselves if they want to. For a porcelain
> command keeping a hook that can prevent it from rewriting commits  that
> are already upstream (which I think is one of the main uses of the
> pre-rebase hook) would be good.

pre-rebase has a broken design; it already doesn't work correctly with
Stolee's --ref-update option.  So, even if we wanted to support this
kind of functionality, it certainly wouldn't be that script.

Also, the name is pre-rebase, not pre-cherry-pick, and doesn't apply
to both commands.  That means there's a second reason the design is
broken.  So, even if we wanted to support this kind of functionality,
it'd have to be a differently named script with a different design.

But, perhaps more importantly than either of the above, is that replay
doesn't change any refs, so why do we need a hook to prevent it from
changing refs?

> >        * post-rewrite hook might make sense, but fast-import got
> >          exempted, and I think of replay like a patch-based analogue
> >          to the snapshot-based fast-import.
>
> If we don't call the hook it would be good to have a option that outputs
> that information so scripts can request it if they want.

Good point, although the fact that replay doesn't update refs probably
means I didn't even need to mention these hooks.

> Also we should
> think about if/when we want to update the notes associated with replayed
> commits.

_Very_ good point.  There should definitely be an option for that,
maybe even a config option.

> >      * When not running server side, resolve conflicts in a sparse-cone
> >        sparse-index worktree to reduce number of files written to a
> >        working tree.  (See below as well)
> >
> >      * [High risk of possible premature optimization] Avoid large
> >        numbers of newly created loose objects, when replaying large
> >        numbers of commits.  Two possibilities: (1) Consider using
> >        tmp-objdir and pack objects from the tmp-objdir at end of
> >        exercise, (2) Lift code from git-fast-import to immediately
> >        stuff new objects into a pack?
> >
> > * Multiple branches and non-checked out branches
> >
> >    * The ability to operate on non-checked out branches also implies
> >      that we should generally be able to replay when in a dirty working
> >      tree (exception being when we expect to update HEAD and any of the
> >      dirty files is one that needs to be updated by the replay).
> >
> >    * Also, if we are operating locally on a non-checked out branch and
> >      hit a conflict, we should have a way to resolve the conflict witho=
ut
> >      messing with the user's work on their current branch.

This stuff really shouldn't have been in the cover letter for this
series, but since it is...

> That sounds tricky to do in a user friendly way.

Yep, totally agreed.

But, I really, really want a command that operates in O(changes)
rather than O(repo size), and which can operate on non-checked-out
branches, and even if the user has a dirty working tree.

There are other choices too -- e.g. if replay is fast enough, just
fail if the user has a dirty working tree and tell them to re-issue
the command after first cleaning it up, allowing us to use their
working tree for conflict resolution.  However, the level of IDE
thrashing that happens when people check out other branches (and the
subsequent loss of productivity they experience after resolving the
simple conflict and switching back) means I'm not willing to have the
only option be resolving conflicts in the current working tree.  I
think something very different than how git-rebase and git-cherry-pick
behave currently are needed, at least as an option.

> >      * Idea: new worktree with sparse cone + sparse index checkout,
> >        containing only files in the root directory, and whatever is
> >        necessary to get the conflicts
>
> If the user has not asked for a sparse checkout then this could be
> surprising. Sometimes I find it helpful to be able to poke about in
> other source files when resolving a conflict. I also often build and
> test after resolving a conflict which requires more than just the
> conflict to be checked out.

Sure, some people may need an option to have conflicts be resolved in
the current working tree, or perhaps even in a separate full tree.
But both are such performance killers that an O(changes) option that
doesn't mess with the current working tree is very much needed for
some usecases.

But again, that's **way** outside the scope of this series.

> >      * Companion to above idea: control structures should be written to
> >        $GIT_COMMON_DIR/replay-${worktree}, so users can have multiple
> >        replay sessions, and so we know which worktrees are associated
> >        with which replay operations.
>
> We certainly want some way of making sure we only update a given ref in
> one replay session, and have checks to for whether the ref is checked
> out anywhere as we do now for rebase --update-refs. That seems to be
> lacking in the patches adding ref updating in this series.

Yeah, that was in patch 9.  It should be dropped or have patch 10
squashed into it.

At that point, this series won't contain any ref updating, but will
only have instructions that can be passed to `git update-ref --stdin`.
At that point, no such checks will be necessary for this series (as it
all belongs in `git update-ref --stdin` instead).

> > * The code die()s if there are any conflict. No resumability. No nice
> >    output. No interactivity.
>
> I can see that on a server you might not want any output, but if I run
> it locally it would be nice to have a message saying which paths have
> conflicts. Maybe we could add a --quiet flag for the server rather than
> removing the existing messages?

I think the choice of what to do for conflicts becomes really complex,
really quick.  Just look at git-merge-tree, which is a much simpler
case, and those kinds of questions blocked the series from progressing
for like half a year last year.

I don't think we're ready to answer these questions.  In fact, that's
precisely why I never submitted this series, even though I've had the
bits that Christian is pushing in a working state for about 9 months
now.

I think we should defer all conflict handling other than exit status
until later (or continue deferring this series until conflict handling
is ready, but that may be a long time).

> > * Signed commits are not properly handled. It's not clear what to do
> >    to such commits when replaying on the server side.
>
> Yes on the server where you don't have access to the signing key there
> is not much need for replay to have a signing option.

And on the client side, it's the one place where I'm almost certainly
going to be forced to accept forking a subprocess, though rest assured
that I'll grumble about it incessantly.  :-)

> > * exit status: a successful, non-conflicted replay exits with code
> >    0. When the replay has conflicts, the exit status is 1. If the
> >    replay is not able to complete (or start) due to some kind of error,
> >    the exit status is something other than 0 or 1. It has been
> >    suggested in an internal review that conflicts might want to get a
> >    more specific error code as an error code of 1 might be quite easy
> >    to return by accident. It doesn't seem to me from their docs (which
> >    might want to be improved, I didn't look at the code) that other
> >    commands like `git merge` and `git rebase` exit with a special error
> >    code in case of conflict.
>
> I don't think we've ever had a special "conflict" error code but it
> would be useful for scripts if replay had one. Does replay return a
> different exit code for "merge conflicts" and "cannot merge because it
> would overwrite an untracked file"? Does it have an exit code for "the
> commit becomes empty" or are those patches unconditionally dropped?

I'm not sure what Christian meant here, but as you say there's
certainly no different special codes in the merge machinery.

> > * --advance and --contained: these two advanced options might not
> >    belong to this first series and could perhaps be added in a followup
> >    series in separate commits. On the other hand the code for
> >    --contained seems involved with the code of --advance and it's nice
> >    to see soon that git replay can indeed do cherry-picking and rebase
> >    many refs at once, and this way fullfil these parts of its promise.
>
> Once I understood what these options did the names made sense, but I
> could not tell from the names what they were going to do. For me
> "--cherry-pick" and "--update-refs" would have been clearer. It might be
> worth splitting this patch so the individual options are added separately=
.

The output of `git replay`, with or without these options, is meant to
be passed as input to `git update-refs --stdin`.  As such, naming an
option --update-refs for this command just seems inherently confusing.

I also feel like --update-refs is a name coded more around
implementation details than end-user description of behavior (and as
far as implementation details are concerned, this options is not tied
to an interactive backend the way the --update-refs options in rebase
is).


In contrast, --cherry-pick might be reasonable.  But I worry it'll be
read backwards by people.  I want:

   git replay --OPTION branch upstream..commit

to make sense and I worry that OPTION=3D=3Dcherry-pick will cause users to
think `branch` is being cherry-picked rather than `upstream..commit`.
What this command does is advance `branch` by cherry-picking
`upstream..commit` onto it.

> > * only 2 patches: this patch series can be seen from a high level
> >    point of view as 1) introducing the new `git replay` command, and 2)
> >    using `git replay` to replace, and get rid of, the fast-rebase
> >    test-tool command. The fact that not much of the original
> >    fast-rebase code and interface is left would agree with that point
> >    of view. On the other hand, fast-rebase can also be seen as a first
> >    iteration towards `git replay`. So it can also make sense to see how
> >    `git replay` evolved from it.
>
> Starting with fast-rebase means one has to checkout the first patch to
> see what code we're adding to replay.c and to make sense of the later
> patches that remove code. It would be interesting to compare this series
> to one that started from scratch but I guess that would be quite a bit
> of work.

Yeah, I was probably wrong to suggest to Christian to use fast-rebase
as the starting point.  That is how I started my series, and multiple
people had reviewed it and it seemed like it'd be useful to leverage
that past review, but the reviews of these series so far suggest I may
have made the wrong recommendation to Christian.

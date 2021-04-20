Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B300C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 312DF61410
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhDTXDs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 19:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbhDTXDr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 19:03:47 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4125C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 16:03:15 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id h20so20532373plr.4
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 16:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0DCuyu8RvHZW/lENE2hjSuYC+FKNJDCtkcjP5VFRqG0=;
        b=LOW849wfU9jLINXwy4+N3/YLld4qQJlXB6khyTIC4+DIxZcseO2yCROBZDuGhOW+3F
         IgStdlktUTAfC0LrImRTwIopzA6yLhwKhRkX/DPCdarb0RTZAw6v4E6sM5zIxjjIbI3F
         8Kv2+vMilsMkBVvgrC1T2O7v96NbYyYeNwdf3It4QZwGRuJ1ZGeYOgfVQ41sPBzGfsRZ
         2pdJWFCTSqnO4irQ+1ByxA9oA2nT20U8wPH0AJxwNFR3uiXqDn8jB54xGORznrY5lXs+
         M+99Bml0AyR39vkT+1boHJDWUJjUw1tmYwfaIy+a4WDIKrY30mSRLkydK5gtOgzqYPM5
         b+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0DCuyu8RvHZW/lENE2hjSuYC+FKNJDCtkcjP5VFRqG0=;
        b=ngQIuUKJYJIT+8NLXV1HmTHYIQXF/Ta1dKp855DWFE2nGc5+pHsb36bGi9zgBhKDDT
         eTtb7s2E/j/F/C8mwbBdMKNfuJtxhh0n6FskJfl8toFcDXlI+fLPtULSojvHSnROS1Vy
         cRN043nXjw8vu57HeUXEGm61ZRA+3ryoCwK4BqCkPysiZJLf1LWF8ob18QRZEu8Q3AfK
         BZCqCf/uvAlSMR6fuEWvfosgyCHFPwZqtamSOBxyTzftU/1wkKhZU1D/nxWyuWPWG5TR
         zKdjATjCrm6ceA3bZAN/7YzHLx4xd/LMi+E2dgwnvwOWNhvmXWlRewmOjaxoZZyHwg8P
         P14Q==
X-Gm-Message-State: AOAM530F3UVGYyIAzGJjxp+Kg4I5KUwMly4zo2YuJHObPfL9PU689h2Z
        uFfE8ISO745MKZlcDUKh7gxUIg==
X-Google-Smtp-Source: ABdhPJx5I7WwdhkQKTK+Q0m5SZVPcLWCWk4+bAAzZmaeC9ZwW+/teFllwToS5kkB8Qdf10mFpx+FJA==
X-Received: by 2002:a17:903:2288:b029:eb:6ca4:6493 with SMTP id b8-20020a1709032288b02900eb6ca46493mr31028495plh.85.1618959794925;
        Tue, 20 Apr 2021 16:03:14 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:828e:a107:e159:3343])
        by smtp.gmail.com with ESMTPSA id mw12sm134208pjb.51.2021.04.20.16.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 16:03:13 -0700 (PDT)
Date:   Tue, 20 Apr 2021 16:03:09 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, jrnieder@gmail.com,
        albertcui@google.com, gitster@pobox.com, matheus.bernardino@usp.br
Subject: Re: RFC/Discussion - Submodule UX Improvements
Message-ID: <YH9drebF84mx2t5r@google.com>
References: <YHofmWcIAidkvJiD@google.com>
 <0fc5c0f7-52f7-fb36-f654-ff5223a8809b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fc5c0f7-52f7-fb36-f654-ff5223a8809b@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 18, 2021 at 11:20:06PM -0400, Philippe Blain wrote:
> > To download the code, they should be able to run simply git clone
> > https://example.com/superproject to download the project and all its submodules;
> 
> Playing the devil's advocate here, but some projects do not want / need all of
> their submodules in a "regular" checkout, so I guess that would have to be somehow
> configurable. I've always felt that since each project is different in that regard,
> it would be better if each project could declare if their submodules are non-optional
> and need to be also cloned when the superproject is cloned. Maybe an additional field
> in '.gitmodules', like a boolean 'submodule.<name>.optional', could be added,
> so that submodules that are optional are not cloned, but others are. If that setting
> is opt-in (meaning that it defaults to 'true', i.e., submodules are considered optional by default),
> then it would be easier to argue for 'git clone' to mean 'git clone --recurse-submodules':
> 'git clone' would clone the superproject and any non-optional submodule.
> Then eventually, when the usage of 'submodule.<name>.optional' becomes more widespread,
> we can switch the default and then projects would need to explicitely declare their submodule
> optional if they don't want them cloned by a simple 'git clone'.

This is actually a point we discussed internally and I cut out of the
doc before sharing, because it is very far down our roadmap (not
expecting to address until probably the second half of the year). As I
understand it, this can also be achieved today by setting
'submodule.path/to/module.active = false' in the superproject's
.git/config.

However, it seems to me like this would be a really cool application of
sparse-checkout, especially if you could distribute the sparse-checkout
config (for example, during clone* ;) ) before a user has the chance to
try and clone all necessary repos for the initial checkout.

* https://lore.kernel.org/git/pull.908.git.1616105016055.gitgitgadget@gmail.com
> > While the user is waiting for feedback on their review, to work on their next
> > task, they can 'git switch other-feature', which will checkout the branches
> > specified in the superproject commit at the tip of 'other-feature'; now the user
> > can continue working as before.
> 
> Here, I'm not sure what you mean by "the branches (plural) specified in the superproject
> commit at the tip of other-feature". Today, with 'submodule.recurse = true', 'git checkout some-feature'
> already checks out each submodule in detached HEAD at the commit recorded in the superproject commit
> at the tip of some-feature. It's unclear if you are proposing to instead record submodule branch
> names in the superproject commit.. is that what's going on here ? (or is it just a typo ?)

Yeah, I'm not sure that it makes sense to record branch name in the
commit itself - but I could see it being useful to do some inference on
the client side and put the user in some state besides detached-HEAD on
checkout. Hmmm.

> 
> > 
> > When it's time to update their local repo, the user can do so as with a
> > single-repo project. First they can 'git checkout main && git pull' (or 'git
> > pull -r'); Git will first checkout the branches associated with main in each
> > submodule, then fetch and merge/rebase in each submodule appropriately.
> 
> What if some submodule does not use the same branch name for their primary integration branch?
> Sometimes as a superproject using another project as a submodule, you do not
> control that...

Yeah, you're right that that's an important consideration - "how can I
teach my superproject to default to a different branch than the name of
the superproject's current branch?" I wonder whether the branch config
in .gitmodules (or an equivalent in superproject's .git/config) would
make sense to try and use here?

> > Note that this means options like '--branch' *don't* propagate directly to the
> > submodules. If superproject branch "foo" points its submodule to branch "main",
> 
> Here again, I'm not sure what you mean, because right now there is no concept of
> the superproject having a submodule "pointing to some branch", only to a specific
> commit. 'submodule.<name>.branch' is only ever used by the command 'git submodule update --remote'.
> Is there an implicit proposal to change that ?

There is no proposal to change the concept of superproject commits
referencing submodule commits. I do not think it is a good idea to try
to have superproject commits reference submodule branch names. No. :) I
think the answer here is the same as above - detached-HEAD is an
inconvenient state for the user unless they specifically ask for it, and
it would be better to check out some branch predictably if possible.

That means that it should be hard for users to end up in a state where
the submodule commit 123 referenced by the superproject commit abc
doesn't have some ref pointing to it in the submodule; I think this is
what I was trying to get at with the 'git status' improvements and 'git
checkout'/'git switch' warnings.

> 
> > then 'git clone --branch foo https://superproject.git' will clone
> > superproject/submodule to branch 'main' instead. (It *may* be OK to take
> > '--branch' to mean "the branch specified by the parent *and* the branch named in
> > --branch if applicable, but no other branches".)
> > 
> > What doesn't already work:
> > 
> >    * --recurse-submodules should turn on submodule.recurse=true
> 
> That's actually a good very idea, but maybe it should be explicitely mentioned, I think
> (in the output of the command I mean).
> 
> >    * superproject gets top-level config inherited by submodules
> >    * New --recurse-submodules --single-branch semantics
> >    * Progress bar for clone (see work estimates)
> >    * Recommended config from project owner
> > 
> > 
> > -- Partial clone
> > 
> > 1. git clone initializes the directory indicated by the user
> > 2. git clone applies the appropriate configs for the partial clone filter
> >     requested by the user
> >    a) These configs go to the config file shared by superproject and submodules.
> > 3. git clone fetches the superproject
> > 4. git clone checks out the superproject at server's HEAD
> > 5. git clone warns the user that a recommended hook/config setup exists and
> >     provides a tip on how to install it
> > 6. For each submodule encountered in step 4, git clone is invoked for the
> >     submodule, and steps 1-4 are repeated (but in directories indicated by the
> >     superproject commit, not by the user). The same filter supplied to the
> >     superproject applies to the submodules.
> > 
> > 
> > What doesn't already work:
> > 
> >    * --filter=blob:none with submodules (it's using global variables)
> >    * propagating --filter=blob:none to submodules (via submodules.config)
> >    * Recommended config from project owner
> > 
> > 
> > - git fetch
> > 
> > By default, git fetch looks for (1) the remote name(s) supplied at the command
> > line, (2) the remote which the currently checked out branch is tracking, or (3)
> > the remote named origin, in that order. For submodules, there is no guarantee
> > that (1) has anything to do with the state of the submodule referenced by the
> > superproject commit, so just start from (2).
> > 
> > This operation can be extremely long-running if the project contains many large
> > submodules, so progress indicators should be displayed.
> > 
> > Caveat: this will mean that we should be more careful about ensuring that
> > submodule branches have tracking info set up correctly; that may be an issue for
> > users who want to branch within their submodule. This may be OK because users
> > will probably still have 'origin' as their submodule's remote, and if they want
> > more complicated behavior, they will be able to configure it.
> > 
> > What doesn't already work:
> > 
> >    * Make sure not to propagate (1) to submodules while recursing
> >    * Fetching new submodules.
> >    * Not having 0.95 success probability ** 100 = low success probability (that
> >      is, we need more retries during submodule fetch)
> >    * Progress indicators
> 
> I would add the following:
> 
> - Fix 'git fetch upstream' when 'submodule.recurse' and 'fetch.recurseSubdmodules=on-demand'
> are both set  (the submodule is not fetched even if the superproject changed the submodule
> commit).

Interesting. Sounds like it's worth writing a test case to see what does
happen/what should happen and make it work :)

> 
> - Do not rely on 'origin' exising in the submodule (or being pushable to). Right now,
> renaming the 'origin' remote to 'upstream' in a submodule, and using 'origin' for one's own
> fork of a submodule, (as is often done in the superproject), breaks 'git fetch --recurse-submodules'
> (or 'git fetch' if 'submodule.recurse' is set), in the sense that the fetch does not recurse
> to the submodule, as it should. I do not have a simple reproducer handy but
> I've seen it happen and there are a couple hard-coded "origin" in the submodule code [1], [2].

This sounds to me like a specific example of a more generalized goal,
which may or may not have ended up in this doc(?) to appropriately
choose the right remote for fetching and pushing. So, definitely :)

> > 
> > 
> > - git switch / git checkout
> > 
> > Submodules should continue to perform these operations the same way that they
> > have before, that is, the way that single-repo Git works. But superprojects
> > should behave as follows:
> > 
> > 
> > -- Create mode (git switch -c / git checkout -b)
> > 
> > 1. The current worktree is checked for uncommitted changes to tracked files. The
> >     current worktree of each submodule is also checked.
> > 2. A new branch is created on the superproject; that branch's ref is pointed to
> >     the current HEAD.
> > 3. The new branch is checked out on the superproject.
> > 4. A new branch with the same name is created on each submodule.
> 
> That might not be wanted by all, so I think it should be configurable.
> 
> >    a. If there is a naming conflict, we could prompt the user to resolve it, or
> >       we could just check out the branch by that name and print a warning to the
> >       user with advice on how to solve it (cd submodule && git switch -c
> >       different-branch-name HEAD@{1}). Maybe we could skip the warning/advice if
> >       the tree is identical to the tree we would have used as the start point
> >       (that is, the user switched branches in the submodule, then said "oh crap"
> >       and went back and switched branches in the superproject).
> >    b. Tracking info is set appropriately on each new branch to the upstream of
> >       the branch referenced by the parent of the new superproject commit, OR to
> >       the default branch's upstream.
> 
> This last point is a little unclear: which "new superproject commit" ? (we are creating
> a branch, so there is no new commit yet?). And again, you talk about a (submodule?) branch being referenced
> by a superproject commit, which is not a concept that actually exists today.

Yeah, I can clean up the wording here, thanks for pointing it out.

> Also, usually tracking info is only set
> automatically when using the form 'git checkout -b new-branch upstream/master' or
> the like. Do you also propose that 'git checkout -b new-branch', by itself, should
> automatically set tracking info ?

Yes - that is an approach that we want to explore, to solve the general
push/fetch remote+branch problem.

> 
> 
> > 5. The new branch is checked out on each of the submodules.
> > 
> > What doesn't already work:
> > 
> >    * Safety check when leaving uncommitted submodule changes
> 
> Yes, that has been reported several times ([3], [4], [5]). I have fixes for this,
> not quite ready to send because I'm trying to write extensive tests (maybe too extensive)...
> 
> >    * Propagating branch names to submodules currently requires a custom hacky
> >      repolike patch
> >    * Error handling + graceful non-error handling if the branch already exists
> >    * "Knowing what branch to push to": copying over which-branch-is-upstream info
> >      ** Needs some UX help, push.default is a mess
> >    * Tracking info setups
> > 
> > -- Switching to an existing branch (git switch / git checkout)
> > 
> > 1. The current worktree is checked for uncommitted changes to tracked files. The
> >     current worktree of each submodule is also checked.
> > 2. The requested branch is checked out on the superproject.
> > 3. The submodule commit or branch referenced by the newly-checked-out
> >     superproject commit is checked out on each submodule.
> > 
> > What doesn't already work:
> > 
> >    * Same as in create mode
> 
> Here, I would add that 'git checkout --recurse-submodules', along with 'git clone --recurse-submodules',
> have trouble with correctly checkout-ing an older commit that records a submodule that
> was since removed from the project. The user experience around this use case is currently very very bad [6].
> This is partly due to 'git clone --recurse-submodules' only cloning submodules that are recorded in
> the tip commit of the default branch of the superproject, which could certainly be improved.

Yeah, we are aware of this pain internally too, thanks for pointing it
out.

> 
> > 
> > 
> > - git status
> > 
> > -- From superproject
> > The superproject is clean if:
> > 
> >    * No tracked files in the superproject have been modified and not committed
> >    * No tracked files in any submodules have been modified and not committed
> >    * No commits in any submodules differ from the commits referenced by the tip
> >      commit of the superproject
> > 
> > Advices should describe:
> > 
> >    * How to commit or drop changes to files in the superproject
> >    * How to commit or drop changes to files in the submodules
> >    * How to commit changes to submodule references
> >    * Which commit/branch to switch the submodule back to if the current work
> >      should be dropped: "Submodule "foo" no longer points to "main", 'git -C foo
> >      switch main' to discard changes"
> > 
> > What doesn't already work:
> > 
> >    * "git status" being super fast and actually possible to use.
> >      ** (That is, we've seen it move very slowly on projects with many
> >         submodules.)
> >    * Advice updates to use the appropriate submodule-y commands.
> 
> I would add that 'git status' should show the submodule as "rewind" if the
> currently checked out submodule commit is *behind* what's recorded in the current superproject
> commit. That is shown by 'git diff --submodule=<log | diff>' and 'git submodule summary'
> and is quite useful to prevent a following 'git commit -am' in the superproject to regress the submodule commit
> by mistake. It would be nice if 'git status' could also show this information (code in
> submodule.c::show_submodule_header).

Oh interesting, that's a good point. Thanks.

> 
> > 
> > -- From submodule
> > 
> > git status's behavior for submodules does not change compared to
> > single-repository Git, except that a red warning line will also display if the
> > superproject commit does not point to the HEAD of the submodule. (This could
> > look similar to the detached-HEAD warning and tracking branch lines in git
> > status today, e.g. "HEAD is ahead of parent project by 2 commits".)
> 
> That would be a nice addition :)
> 
> > 
> > What doesn't already work:
> > 
> >    * "git status" from a submodule being aware of the superproject.
> > 
> > 
> > - git push
> > 
> > -- From superproject
> > 
> > Ideally, a push of the superproject commit results in a push of each submodule
> > which changed, to the appropriate Gerrit upstream. Commits pushed this way
> > across submodules should somehow be associated in the Gerrit UI, similar to the
> > "submitted together" display. This will need some work to make happen.
> > 
> > What doesn't already work:
> > 
> >    * Automatically setting Gerrit topic (with a hook)
> >    * "push --recurse-submodules" knowing where to push to in submodules to
> >      initiate a Gerrit review
> >      ** From `branch` field in .gitmodules?
> >      ** Gerrit accepting 'git push -o review origin main' pushes?
> >      ** Review URL with a remote helper that rewrites refs/heads/main to
> >         refs/for/main?
> >      ** Need UX help
> 
> It would be nice if 'git push' would not force users to use the same
> remote names and branch names in the superproject and the submodule.
> Previous discussion around this that I had spotted are at [7] and [8].
> 
> > 
> > > From submodule
> > No change to client behavior is needed. With Gerrit submodule subscriptions, the
> > server knows how to generate superproject commits when merging submodule
> > commits.
> > 
> > - git pull / git rebase
> > 
> > Note: We're still thinking about this one :)
> > 
> > 1. Performs a fetch as described above
> > 2. For each superproject commit, replay the submodule commits against the newly
> >     updated submodule base; then, make a new superproject commit containing those
> >     changes
> > 
> > What doesn't already work:
> > 
> >    * Rewriting gitlinks in a superproject commit when 'rebase
> >      --recurse-submodules'-ing
> >    * Resuming after resolving a conflict during rebase
> 
> In general, rebase is not well aware of 'submodule.recurse'. Even if you do not
> need to rewrite superproject commits, there are a couple of use cases that are broken
> right now:
> 
> - 'git rebase upstream/master' when upstream updated the submodule, will correctly
> (recursively) checkout upstream/master before starting the rebase, but upon
> 'git rebase --abort', the submodule will stay checked out at the commit recorded in
> 'upstream/master', which is confusing. This only happens when 'submodule.recurse' is true (!).
> - 'git rebase -i' which stops at a commit 'A' where the submodule commit is changed,
> does not correctly check out the submodule tree. It's checked out at the commit recorded in A~1
> (and this also only happens if submodule.recurse is true)
> - In some cases, like 'rebase -i'-ing across the addition of new submodules, at the end
> of the rebase the submodules are empty, and 'git submodule update' must be run to
> re-populate them.

Interesting, thanks for pointing these out.

> 
> > 
> > - git merge
> > 
> > The story for merges is a little bit muddled... and for our goals we don't need
> > it for quite a while, so we haven't thought much about it :) Any suggestions
> > folks have about reasonable ways to 'git merge --recurse-submodules' are totally
> > welcome. For now, though, we'll probably just stick in some error message saying
> > that merges with submodules isn't currently supported (maybe we will even add
> > that downstream).
> 
> What is "downstream" here ?

"Downstream" meaning the version (fork? ehh) of Git that we build and
ship to developers at Google. We carry a handful of patches - mostly for
stuff that only makes sense internally, like certain transports or
authentication helpers - and occasionally experimental stuff (for
example, we ship config-based hooks to Googlers this way right now). If
we're expecting "No, you can't merge with submodules!" to be a temporary
error message, then it might not make sense to try and upstream that
error string at all.



Thanks for the thorough read and all the pointers, I really appreciate
it.

 - Emily

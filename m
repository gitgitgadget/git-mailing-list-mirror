Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621DDC433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 03:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 406D66100A
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 03:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbhDSDUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 23:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbhDSDUi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 23:20:38 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8592DC06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 20:20:09 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id i3so10725384qvj.7
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 20:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/XnFFO/wWl7lfCXvBc8p5XsEvzgdTw7D8z4jbVvU1nI=;
        b=e1gWcTe3/+HC7UOP+ddTziLFe6llMwshIqvOc6nCpynhkNABmxp71Jnf+7G66v878o
         m80fne4t28H4SxZdjpLQMyZ5HUjIq5y0ZorJyTgXEl2uMTItnnYumqImey8c2JTc7yvm
         +84YXr/ZYRz2xl6yjxbu95+QY+1YjBW0dtB9+O388cJABF9vQD0tkpa0qwl56RloUGbv
         +aP6pXCQ8AZlVZZVXPwf6xDP5FUNc/ca/YYN60oalBemf8J+2fqoUJDPiljcRnhxw398
         MwhiHvbPrxSFBdFephPPnDDRrFPp+JYQILzHW1omAOpC2YVHKJMcwY+VW7l2C00Fl6ZG
         sEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/XnFFO/wWl7lfCXvBc8p5XsEvzgdTw7D8z4jbVvU1nI=;
        b=abkWi/TipJyloQ6y4Ooy3fk83jGtJsOq2erqVe8pMmLcLvGpDMOnVgDuXVYIABZ9+f
         xgCACrNMsOamFJd9uz+0qXzO4ytjR8TXj83LDylsn7MoJ7kfM03kBbgaUZoQjX4dPUIH
         6Rc5ilCOE2nZZyqWOf1rQ8iW3HAPcqTTrrbBw9Jtx3Lk4RGTqBLajGx9kmKBEeG5s+D0
         hu0kNLVDdny+jZtMp9UPA+yWryogj7taGD4bu2xes5UHrH/JjirVXMeb8U53zX3r7wrp
         v+sL5Zm7WsRXcSgOsdeGzt9sVZkeIvDkhFfYhVoBgSCbxmNUK0a3MgnXqE+sRhu0oEWO
         bVtA==
X-Gm-Message-State: AOAM532vhUwOgpEHJ3kgSQdcODLdg7SizjvtF9ehOFL/yzfDo9PXyTsP
        FatMIwg0HzKm8ephWkuU0YQ=
X-Google-Smtp-Source: ABdhPJxa3eMUR/RzvUxy0z9V4ks44EOzksaGEkCGGheAm6BdvBJDvmzrjHgqpSGf/OKzQsX4HcyFHw==
X-Received: by 2002:a0c:a425:: with SMTP id w34mr19611126qvw.2.1618802408528;
        Sun, 18 Apr 2021 20:20:08 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id y26sm5626995qtf.66.2021.04.18.20.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Apr 2021 20:20:08 -0700 (PDT)
Subject: Re: RFC/Discussion - Submodule UX Improvements
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, jrnieder@gmail.com, albertcui@google.com,
        gitster@pobox.com, matheus.bernardino@usp.br
References: <YHofmWcIAidkvJiD@google.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <0fc5c0f7-52f7-fb36-f654-ff5223a8809b@gmail.com>
Date:   Sun, 18 Apr 2021 23:20:06 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YHofmWcIAidkvJiD@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

Le 2021-04-16 à 19:36, Emily Shaffer a écrit :
> Hi folks,
> 
> As hinted by a couple recent patches, I'm planning on some pretty big submodule
> work over the next 6 months or so - and Ævar pointed out to me in
> https://lore.kernel.org/git/87v98p17im.fsf@evledraar.gmail.com that I probably
> should share some of those plans ahead of time. :) So attached is a lightly
> modified version of the doc that we've been working on internally at Google,
> focusing on what we think would be an ideal submodule workflow.
> 
> I'm hoping that folks will get a chance to read some or all of it and let us
> know what sounds cool (or sounds extremely broken). The best spot to start is
> probably the "Overview" section, which describes what the "main path" would look
> like for a user working on a project with submodules. Most of the work that
> we're planning on doing is under the "What doesn't already work" headings.
> 
> Thanks in advance for any time you spend reading/discussing :)

Thanks a lot for sharing this roadmap. There a lot of good ideas there, that would really
improve the situation for projects using subdmodules. I've added some toughts on specific
items below.

> 
>   - Emily
> 
> Background
> ==========
> 
> It's worth mentioning that the main goal that's funding this work is to provide
> an alternative for users whose projects use repo
> (https://source.android.com/setup/develop#repo) today. That means that the main
> focus is to try and reach feature parity to repo for an easier transition for
> those who want to switch. As a result, some of the direction below is aimed
> towards learning from what has worked well with repo (but hopefully more
> flexible for users who want to do more, or differently).
> 
> There are also a few things mentioned that are specifically targeted to ease use
> with Gerrit, which is in wide use here at Google (and therefore also a
> consideration we need to make to keep getting paid ;) ).
> 
> Overview
> =======
> 
> When the work is completed, users should be able to have a clean, obvious
> workflow when using best practices:
> 
> To download the code, they should be able to run simply git clone
> https://example.com/superproject to download the project and all its submodules;

Playing the devil's advocate here, but some projects do not want / need all of
their submodules in a "regular" checkout, so I guess that would have to be somehow
configurable. I've always felt that since each project is different in that regard,
it would be better if each project could declare if their submodules are non-optional
and need to be also cloned when the superproject is cloned. Maybe an additional field
in '.gitmodules', like a boolean 'submodule.<name>.optional', could be added,
so that submodules that are optional are not cloned, but others are. If that setting
is opt-in (meaning that it defaults to 'true', i.e., submodules are considered optional by default),
then it would be easier to argue for 'git clone' to mean 'git clone --recurse-submodules':
'git clone' would clone the superproject and any non-optional submodule.
Then eventually, when the usage of 'submodule.<name>.optional' becomes more widespread,
we can switch the default and then projects would need to explicitely declare their submodule
optional if they don't want them cloned by a simple 'git clone'.


> if partial clone is configured, they should receive only the objects allowed by
> the filter in their superproject as well as in each submodule.
> 
> To begin working on a feature, from the superproject they can 'git switch -c
> feature', and since the new branch is being created, a new branch 'feature' will
> be created for each submodule, pointing to the submodule's current 'HEAD'. They
> can move to a submodule directory and begin to make changes, and when they
> commit these changes normally with 'git commit' from the submodule directory,
> running git status in the superproject will reflect that a submodule has
> changed. Next, they can switch to a second submodule, making and committing more
> changes.

Yes. Apart from recursive 'git checkout -b / git switch -c', the workflow you describe
already works well, from my experience.

> 
> When they are ready to send these changes which are ready for review but need to
> be linked together, they can switch back to the superproject, where 'git status'
> indicates that there are changes in both submodules. They can commit these
> changes to the superproject and use 'git push' to send a review; Git will
> recurse into affected submodules and push those submodule commits appropriately
> as well.
> 
> While the user is waiting for feedback on their review, to work on their next
> task, they can 'git switch other-feature', which will checkout the branches
> specified in the superproject commit at the tip of 'other-feature'; now the user
> can continue working as before.

Here, I'm not sure what you mean by "the branches (plural) specified in the superproject
commit at the tip of other-feature". Today, with 'submodule.recurse = true', 'git checkout some-feature'
already checks out each submodule in detached HEAD at the commit recorded in the superproject commit
at the tip of some-feature. It's unclear if you are proposing to instead record submodule branch
names in the superproject commit.. is that what's going on here ? (or is it just a typo ?)

> 
> When it's time to update their local repo, the user can do so as with a
> single-repo project. First they can 'git checkout main && git pull' (or 'git
> pull -r'); Git will first checkout the branches associated with main in each
> submodule, then fetch and merge/rebase in each submodule appropriately. 

What if some submodule does not use the same branch name for their primary integration branch?
Sometimes as a superproject using another project as a submodule, you do not
control that...

> Finally,
> they can 'git switch feature && git rebase', at which time Git will recursively
> checkout the branches associated with 'feature' in each submodule and rebase
> each submodule appropriately.
> 
> Detailed Design
> ===============
> 
> The Well-Tread Path: Basic Contribution Workflow
> ------------------------------------------------
> 
> - git clone
> 
> 1. git clone initializes the directory indicated by the user
> 2. git clone fetches the superproject
> 3. git clone checks out the superproject at server's HEAD (or at another commit
>     as specified by the user, e.g. with --branch)
> 4. git clone warns the user that a recommended hook/config setup exists and
>     provides a tip on how to install it
> 5. For each submodule encountered in step 3, git clone is invoked for the
>     submodule, and steps 1-4 are repeated (but in directories indicated by the
>     superproject commit, not by the user).
> 
> Note that this means options like '--branch' *don't* propagate directly to the
> submodules. If superproject branch "foo" points its submodule to branch "main",

Here again, I'm not sure what you mean, because right now there is no concept of
the superproject having a submodule "pointing to some branch", only to a specific
commit. 'submodule.<name>.branch' is only ever used by the command 'git submodule update --remote'.
Is there an implicit proposal to change that ?

> then 'git clone --branch foo https://superproject.git' will clone
> superproject/submodule to branch 'main' instead. (It *may* be OK to take
> '--branch' to mean "the branch specified by the parent *and* the branch named in
> --branch if applicable, but no other branches".)
> 
> What doesn't already work:
> 
>    * --recurse-submodules should turn on submodule.recurse=true

That's actually a good very idea, but maybe it should be explicitely mentioned, I think
(in the output of the command I mean).

>    * superproject gets top-level config inherited by submodules
>    * New --recurse-submodules --single-branch semantics
>    * Progress bar for clone (see work estimates)
>    * Recommended config from project owner
> 
> 
> -- Partial clone
> 
> 1. git clone initializes the directory indicated by the user
> 2. git clone applies the appropriate configs for the partial clone filter
>     requested by the user
>    a) These configs go to the config file shared by superproject and submodules.
> 3. git clone fetches the superproject
> 4. git clone checks out the superproject at server's HEAD
> 5. git clone warns the user that a recommended hook/config setup exists and
>     provides a tip on how to install it
> 6. For each submodule encountered in step 4, git clone is invoked for the
>     submodule, and steps 1-4 are repeated (but in directories indicated by the
>     superproject commit, not by the user). The same filter supplied to the
>     superproject applies to the submodules.
> 
> 
> What doesn't already work:
> 
>    * --filter=blob:none with submodules (it's using global variables)
>    * propagating --filter=blob:none to submodules (via submodules.config)
>    * Recommended config from project owner
> 
> 
> - git fetch
> 
> By default, git fetch looks for (1) the remote name(s) supplied at the command
> line, (2) the remote which the currently checked out branch is tracking, or (3)
> the remote named origin, in that order. For submodules, there is no guarantee
> that (1) has anything to do with the state of the submodule referenced by the
> superproject commit, so just start from (2).
> 
> This operation can be extremely long-running if the project contains many large
> submodules, so progress indicators should be displayed.
> 
> Caveat: this will mean that we should be more careful about ensuring that
> submodule branches have tracking info set up correctly; that may be an issue for
> users who want to branch within their submodule. This may be OK because users
> will probably still have 'origin' as their submodule's remote, and if they want
> more complicated behavior, they will be able to configure it.
> 
> What doesn't already work:
> 
>    * Make sure not to propagate (1) to submodules while recursing
>    * Fetching new submodules.
>    * Not having 0.95 success probability ** 100 = low success probability (that
>      is, we need more retries during submodule fetch)
>    * Progress indicators

I would add the following:

- Fix 'git fetch upstream' when 'submodule.recurse' and 'fetch.recurseSubdmodules=on-demand'
are both set  (the submodule is not fetched even if the superproject changed the submodule
commit).

- Do not rely on 'origin' exising in the submodule (or being pushable to). Right now,
renaming the 'origin' remote to 'upstream' in a submodule, and using 'origin' for one's own
fork of a submodule, (as is often done in the superproject), breaks 'git fetch --recurse-submodules'
(or 'git fetch' if 'submodule.recurse' is set), in the sense that the fetch does not recurse
to the submodule, as it should. I do not have a simple reproducer handy but
I've seen it happen and there are a couple hard-coded "origin" in the submodule code [1], [2].

> 
> 
> - git switch / git checkout
> 
> Submodules should continue to perform these operations the same way that they
> have before, that is, the way that single-repo Git works. But superprojects
> should behave as follows:
> 
> 
> -- Create mode (git switch -c / git checkout -b)
> 
> 1. The current worktree is checked for uncommitted changes to tracked files. The
>     current worktree of each submodule is also checked.
> 2. A new branch is created on the superproject; that branch's ref is pointed to
>     the current HEAD.
> 3. The new branch is checked out on the superproject.
> 4. A new branch with the same name is created on each submodule.

That might not be wanted by all, so I think it should be configurable.

>    a. If there is a naming conflict, we could prompt the user to resolve it, or
>       we could just check out the branch by that name and print a warning to the
>       user with advice on how to solve it (cd submodule && git switch -c
>       different-branch-name HEAD@{1}). Maybe we could skip the warning/advice if
>       the tree is identical to the tree we would have used as the start point
>       (that is, the user switched branches in the submodule, then said "oh crap"
>       and went back and switched branches in the superproject).
>    b. Tracking info is set appropriately on each new branch to the upstream of
>       the branch referenced by the parent of the new superproject commit, OR to
>       the default branch's upstream.

This last point is a little unclear: which "new superproject commit" ? (we are creating
a branch, so there is no new commit yet?). And again, you talk about a (submodule?) branch being referenced
by a superproject commit, which is not a concept that actually exists today.
Also, usually tracking info is only set
automatically when using the form 'git checkout -b new-branch upstream/master' or
the like. Do you also propose that 'git checkout -b new-branch', by itself, should
automatically set tracking info ?


> 5. The new branch is checked out on each of the submodules.
> 
> What doesn't already work:
> 
>    * Safety check when leaving uncommitted submodule changes

Yes, that has been reported several times ([3], [4], [5]). I have fixes for this,
not quite ready to send because I'm trying to write extensive tests (maybe too extensive)...

>    * Propagating branch names to submodules currently requires a custom hacky
>      repolike patch
>    * Error handling + graceful non-error handling if the branch already exists
>    * "Knowing what branch to push to": copying over which-branch-is-upstream info
>      ** Needs some UX help, push.default is a mess
>    * Tracking info setups
> 
> -- Switching to an existing branch (git switch / git checkout)
> 
> 1. The current worktree is checked for uncommitted changes to tracked files. The
>     current worktree of each submodule is also checked.
> 2. The requested branch is checked out on the superproject.
> 3. The submodule commit or branch referenced by the newly-checked-out
>     superproject commit is checked out on each submodule.
> 
> What doesn't already work:
> 
>    * Same as in create mode

Here, I would add that 'git checkout --recurse-submodules', along with 'git clone --recurse-submodules',
have trouble with correctly checkout-ing an older commit that records a submodule that
was since removed from the project. The user experience around this use case is currently very very bad [6].
This is partly due to 'git clone --recurse-submodules' only cloning submodules that are recorded in
the tip commit of the default branch of the superproject, which could certainly be improved.

> 
> 
> - git status
> 
> -- From superproject
> The superproject is clean if:
> 
>    * No tracked files in the superproject have been modified and not committed
>    * No tracked files in any submodules have been modified and not committed
>    * No commits in any submodules differ from the commits referenced by the tip
>      commit of the superproject
> 
> Advices should describe:
> 
>    * How to commit or drop changes to files in the superproject
>    * How to commit or drop changes to files in the submodules
>    * How to commit changes to submodule references
>    * Which commit/branch to switch the submodule back to if the current work
>      should be dropped: "Submodule "foo" no longer points to "main", 'git -C foo
>      switch main' to discard changes"
> 
> What doesn't already work:
> 
>    * "git status" being super fast and actually possible to use.
>      ** (That is, we've seen it move very slowly on projects with many
>         submodules.)
>    * Advice updates to use the appropriate submodule-y commands.

I would add that 'git status' should show the submodule as "rewind" if the
currently checked out submodule commit is *behind* what's recorded in the current superproject
commit. That is shown by 'git diff --submodule=<log | diff>' and 'git submodule summary'
and is quite useful to prevent a following 'git commit -am' in the superproject to regress the submodule commit
by mistake. It would be nice if 'git status' could also show this information (code in
submodule.c::show_submodule_header).

> 
> -- From submodule
> 
> git status's behavior for submodules does not change compared to
> single-repository Git, except that a red warning line will also display if the
> superproject commit does not point to the HEAD of the submodule. (This could
> look similar to the detached-HEAD warning and tracking branch lines in git
> status today, e.g. "HEAD is ahead of parent project by 2 commits".)

That would be a nice addition :)

> 
> What doesn't already work:
> 
>    * "git status" from a submodule being aware of the superproject.
> 
> 
> - git push
> 
> -- From superproject
> 
> Ideally, a push of the superproject commit results in a push of each submodule
> which changed, to the appropriate Gerrit upstream. Commits pushed this way
> across submodules should somehow be associated in the Gerrit UI, similar to the
> "submitted together" display. This will need some work to make happen.
> 
> What doesn't already work:
> 
>    * Automatically setting Gerrit topic (with a hook)
>    * "push --recurse-submodules" knowing where to push to in submodules to
>      initiate a Gerrit review
>      ** From `branch` field in .gitmodules?
>      ** Gerrit accepting 'git push -o review origin main' pushes?
>      ** Review URL with a remote helper that rewrites refs/heads/main to
>         refs/for/main?
>      ** Need UX help

It would be nice if 'git push' would not force users to use the same
remote names and branch names in the superproject and the submodule.
Previous discussion around this that I had spotted are at [7] and [8].

> 
>>From submodule
> No change to client behavior is needed. With Gerrit submodule subscriptions, the
> server knows how to generate superproject commits when merging submodule
> commits.
> 
> - git pull / git rebase
> 
> Note: We're still thinking about this one :)
> 
> 1. Performs a fetch as described above
> 2. For each superproject commit, replay the submodule commits against the newly
>     updated submodule base; then, make a new superproject commit containing those
>     changes
> 
> What doesn't already work:
> 
>    * Rewriting gitlinks in a superproject commit when 'rebase
>      --recurse-submodules'-ing
>    * Resuming after resolving a conflict during rebase

In general, rebase is not well aware of 'submodule.recurse'. Even if you do not
need to rewrite superproject commits, there are a couple of use cases that are broken
right now:

- 'git rebase upstream/master' when upstream updated the submodule, will correctly
(recursively) checkout upstream/master before starting the rebase, but upon
'git rebase --abort', the submodule will stay checked out at the commit recorded in
'upstream/master', which is confusing. This only happens when 'submodule.recurse' is true (!).
- 'git rebase -i' which stops at a commit 'A' where the submodule commit is changed,
does not correctly check out the submodule tree. It's checked out at the commit recorded in A~1
(and this also only happens if submodule.recurse is true)
- In some cases, like 'rebase -i'-ing across the addition of new submodules, at the end
of the rebase the submodules are empty, and 'git submodule update' must be run to
re-populate them.

> 
> - git merge
> 
> The story for merges is a little bit muddled... and for our goals we don't need
> it for quite a while, so we haven't thought much about it :) Any suggestions
> folks have about reasonable ways to 'git merge --recurse-submodules' are totally
> welcome. For now, though, we'll probably just stick in some error message saying
> that merges with submodules isn't currently supported (maybe we will even add
> that downstream).

What is "downstream" here ?

Also, there is quite a bit of a future plan in the commit message of
a6d7eb2c7a (pull: optionally rebase submodules (remote submodule changes only), 2017-06-23).
It would be nice to revisit this, I think (regarding both rebase and merge).

> 
> What doesn't already work:
> 
>    * Erroring out for "not supported"
> 
> 
> Aligning Teams
> --------------
> 
> [ ... ] 
> 
> 
> - Worktrees
> 
> When a user runs 'git worktree add' from the superproject, each submodule in the
> new worktree should also be created as a worktree of the corresponding submodule
> in the original project.
> 
> What doesn't already work:
> 
>    * worktrees and submodules getting along - submodules are now freshly cloned
>      when creating a superproject worktree

That would certainly be nice. I've been using worktrees with submodule-containing
projects and everything has been working fine (there were 2 bugs but I fixed them).
Once we are not wasting disk space
by re-cloning the submodules, we whould remove the 'not recommended' mention in the
docs aboout using worktrees with projects containing submodules.

> 
> - git clone --reference [--dissociate]
> 
> When cloning with an alternate directory, submodules should also try to use
> object stores associated with the referenced project instead of cloning from
> their remotes right away. It is unclear how much of this works today.
> 
> 
> What doesn't already work:
> 
>    * Writing some tests and making them pass
> 


Thanks again for providing these details,

Philippe.

[1] https://github.com/git/git/blob/b0c09ab8796fb736efa432b8e817334f3e5ee75a/builtin/submodule--helper.c#L43-L51
[2] https://github.com/git/git/blob/b0c09ab8796fb736efa432b8e817334f3e5ee75a/submodule.c#L1525
[3] https://lore.kernel.org/git/CAHsG2VT4YB_nf8PrEmrHwK-iY-AQo0VDcvXGVsf8cEYXws4nig@mail.gmail.com/
[4] https://lore.kernel.org/git/20200525094019.22padbzuk7ukr5uv@overdrive.tratt.net/T/#u
[5] https://lore.kernel.org/git/05afbdeb-6c72-f14c-cdf0-e14894de05a3@gmail.com/T/#t
[6] https://github.com/gitgitgadget/git/issues/752
[7]https://lore.kernel.org/git/20170405174719.1297-6-bmwill@google.com/t/#m224c2475b1bad333e1118f68c80465b638ed87ee
[8] https://public-inbox.org/git/20170627162307.GE161648@aiede.mtv.corp.google.com/

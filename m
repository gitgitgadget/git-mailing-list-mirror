Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38844C433B4
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 23:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E692D610F7
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 23:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbhDPXha (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 19:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhDPXh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 19:37:29 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA8AC061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 16:37:04 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n10so3637366plc.0
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 16:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=zsIr5mza6UB69mP9lxyftVUpMa8E/CkqrDiAcFLWIvk=;
        b=Aq7NJHGrBll6b+eAKTt20pjwqxvTEm9D8fip8cATk71DwEa/I4EVB/VkgZKYgipzZw
         LxzZJhVDFUsz5titkLzXlkd50/k6Wj7fbME4CBLdZJQTxxVsbTZakX9A10NlHn/sNG75
         kud3HlS1yQaYoLPbf5vkE8YZxemYYGW2sFo6TF+rxbJXSdwVhfwRgH16kVYm1QuYFsWD
         Oll0nE0n50gWi3p8X842Ea95B41zEgMdC1CKbUA3ZAARiBscNRKmEGptfVJ21W8LEn4o
         bAJIpPjuvok5ExzSkGOJTD6T3hTRRrAI/B/JmR9S8sqX0g0ZjBrOt3XXeeqJCncvbZOo
         AfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=zsIr5mza6UB69mP9lxyftVUpMa8E/CkqrDiAcFLWIvk=;
        b=rTSBPu1tzLtpqwFUzw1vHKpT4zI0/Ppw+sXbO/Y5UEwrcRjbEUV/zLegl7uCBxiJe4
         Z+LDFpBQR72wXfUZkhU7AdcKR7hQ+eaaIckIjp5z3GNvEzuyX8tfGQtkhJY4CJ6j8PN0
         tcWsu0nz/mEqKiyPmhAEV40AQ9QIsyS0nIg93p1778Y5hjTfc8avkF49P72bkatQ6Zb5
         jY89LYwpp4qzmXQGnNlVx6Rm3DdTIcQuprv0u2cGtzN4fiKctOjXd+1sXL0q/Pmve/pg
         Q9Q/VQilUDJf6o1nNFUpAXU5UdeA+bj9nP/CULgnSHDwKLy6PYSwJZltOAKa3UYMBxQv
         r96Q==
X-Gm-Message-State: AOAM533hEa1pbgopai1T5wjtkaP+VnYAb74GuYia7BFf8lEKYxxbTZff
        RFH6PlMWuUTESY+HHOoRaJRttW+Ir8lbvQ==
X-Google-Smtp-Source: ABdhPJz8SVbt/oqDvgsI1sFp8rmx3bjfp5KjoD9kFSPW1rqUYUFNnYWY63ZIk2BYSf7GPrIpHijSBw==
X-Received: by 2002:a17:902:c948:b029:e9:8f01:fa8e with SMTP id i8-20020a170902c948b02900e98f01fa8emr11920245pla.37.1618616223065;
        Fri, 16 Apr 2021 16:37:03 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:2115:c766:1142:8e82])
        by smtp.gmail.com with ESMTPSA id j3sm5219011pfc.49.2021.04.16.16.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 16:37:02 -0700 (PDT)
Date:   Fri, 16 Apr 2021 16:36:57 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, jrnieder@gmail.com, albertcui@google.com,
        gitster@pobox.com, matheus.bernardino@usp.br
Subject: RFC/Discussion - Submodule UX Improvements
Message-ID: <YHofmWcIAidkvJiD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

As hinted by a couple recent patches, I'm planning on some pretty big submodule
work over the next 6 months or so - and Ævar pointed out to me in
https://lore.kernel.org/git/87v98p17im.fsf@evledraar.gmail.com that I probably
should share some of those plans ahead of time. :) So attached is a lightly
modified version of the doc that we've been working on internally at Google,
focusing on what we think would be an ideal submodule workflow.

I'm hoping that folks will get a chance to read some or all of it and let us
know what sounds cool (or sounds extremely broken). The best spot to start is
probably the "Overview" section, which describes what the "main path" would look
like for a user working on a project with submodules. Most of the work that
we're planning on doing is under the "What doesn't already work" headings.

Thanks in advance for any time you spend reading/discussing :)

 - Emily

Background
==========

It's worth mentioning that the main goal that's funding this work is to provide
an alternative for users whose projects use repo
(https://source.android.com/setup/develop#repo) today. That means that the main
focus is to try and reach feature parity to repo for an easier transition for
those who want to switch. As a result, some of the direction below is aimed
towards learning from what has worked well with repo (but hopefully more
flexible for users who want to do more, or differently).

There are also a few things mentioned that are specifically targeted to ease use
with Gerrit, which is in wide use here at Google (and therefore also a
consideration we need to make to keep getting paid ;) ).

Overview
=======

When the work is completed, users should be able to have a clean, obvious
workflow when using best practices:

To download the code, they should be able to run simply git clone
https://example.com/superproject to download the project and all its submodules;
if partial clone is configured, they should receive only the objects allowed by
the filter in their superproject as well as in each submodule.

To begin working on a feature, from the superproject they can 'git switch -c
feature', and since the new branch is being created, a new branch 'feature' will
be created for each submodule, pointing to the submodule's current 'HEAD'. They
can move to a submodule directory and begin to make changes, and when they
commit these changes normally with 'git commit' from the submodule directory,
running git status in the superproject will reflect that a submodule has
changed. Next, they can switch to a second submodule, making and committing more
changes.

When they are ready to send these changes which are ready for review but need to
be linked together, they can switch back to the superproject, where 'git status'
indicates that there are changes in both submodules. They can commit these
changes to the superproject and use 'git push' to send a review; Git will
recurse into affected submodules and push those submodule commits appropriately
as well.

While the user is waiting for feedback on their review, to work on their next
task, they can 'git switch other-feature', which will checkout the branches
specified in the superproject commit at the tip of 'other-feature'; now the user
can continue working as before.

When it's time to update their local repo, the user can do so as with a
single-repo project. First they can 'git checkout main && git pull' (or 'git
pull -r'); Git will first checkout the branches associated with main in each
submodule, then fetch and merge/rebase in each submodule appropriately. Finally,
they can 'git switch feature && git rebase', at which time Git will recursively
checkout the branches associated with 'feature' in each submodule and rebase
each submodule appropriately.

Detailed Design
===============

The Well-Tread Path: Basic Contribution Workflow
------------------------------------------------

- git clone

1. git clone initializes the directory indicated by the user
2. git clone fetches the superproject
3. git clone checks out the superproject at server's HEAD (or at another commit
   as specified by the user, e.g. with --branch)
4. git clone warns the user that a recommended hook/config setup exists and
   provides a tip on how to install it
5. For each submodule encountered in step 3, git clone is invoked for the
   submodule, and steps 1-4 are repeated (but in directories indicated by the
   superproject commit, not by the user).

Note that this means options like '--branch' *don't* propagate directly to the
submodules. If superproject branch "foo" points its submodule to branch "main",
then 'git clone --branch foo https://superproject.git' will clone
superproject/submodule to branch 'main' instead. (It *may* be OK to take
'--branch' to mean "the branch specified by the parent *and* the branch named in
--branch if applicable, but no other branches".)

What doesn't already work:

  * --recurse-submodules should turn on submodule.recurse=true
  * superproject gets top-level config inherited by submodules
  * New --recurse-submodules --single-branch semantics
  * Progress bar for clone (see work estimates)
  * Recommended config from project owner


-- Partial clone

1. git clone initializes the directory indicated by the user
2. git clone applies the appropriate configs for the partial clone filter
   requested by the user
  a) These configs go to the config file shared by superproject and submodules.
3. git clone fetches the superproject
4. git clone checks out the superproject at server's HEAD
5. git clone warns the user that a recommended hook/config setup exists and
   provides a tip on how to install it
6. For each submodule encountered in step 4, git clone is invoked for the
   submodule, and steps 1-4 are repeated (but in directories indicated by the
   superproject commit, not by the user). The same filter supplied to the
   superproject applies to the submodules.


What doesn't already work:

  * --filter=blob:none with submodules (it's using global variables)
  * propagating --filter=blob:none to submodules (via submodules.config)
  * Recommended config from project owner


- git fetch

By default, git fetch looks for (1) the remote name(s) supplied at the command
line, (2) the remote which the currently checked out branch is tracking, or (3)
the remote named origin, in that order. For submodules, there is no guarantee
that (1) has anything to do with the state of the submodule referenced by the
superproject commit, so just start from (2).

This operation can be extremely long-running if the project contains many large
submodules, so progress indicators should be displayed.

Caveat: this will mean that we should be more careful about ensuring that
submodule branches have tracking info set up correctly; that may be an issue for
users who want to branch within their submodule. This may be OK because users
will probably still have 'origin' as their submodule's remote, and if they want
more complicated behavior, they will be able to configure it.

What doesn't already work:

  * Make sure not to propagate (1) to submodules while recursing
  * Fetching new submodules.
  * Not having 0.95 success probability ** 100 = low success probability (that
    is, we need more retries during submodule fetch)
  * Progress indicators


- git switch / git checkout

Submodules should continue to perform these operations the same way that they
have before, that is, the way that single-repo Git works. But superprojects
should behave as follows:


-- Create mode (git switch -c / git checkout -b)

1. The current worktree is checked for uncommitted changes to tracked files. The
   current worktree of each submodule is also checked.
2. A new branch is created on the superproject; that branch's ref is pointed to
   the current HEAD.
3. The new branch is checked out on the superproject.
4. A new branch with the same name is created on each submodule.
  a. If there is a naming conflict, we could prompt the user to resolve it, or
     we could just check out the branch by that name and print a warning to the
     user with advice on how to solve it (cd submodule && git switch -c
     different-branch-name HEAD@{1}). Maybe we could skip the warning/advice if
     the tree is identical to the tree we would have used as the start point
     (that is, the user switched branches in the submodule, then said "oh crap"
     and went back and switched branches in the superproject).
  b. Tracking info is set appropriately on each new branch to the upstream of
     the branch referenced by the parent of the new superproject commit, OR to
     the default branch's upstream.
5. The new branch is checked out on each of the submodules.

What doesn't already work:

  * Safety check when leaving uncommitted submodule changes
  * Propagating branch names to submodules currently requires a custom hacky
    repolike patch
  * Error handling + graceful non-error handling if the branch already exists
  * "Knowing what branch to push to": copying over which-branch-is-upstream info
    ** Needs some UX help, push.default is a mess
  * Tracking info setups


-- Switching to an existing branch (git switch / git checkout)

1. The current worktree is checked for uncommitted changes to tracked files. The
   current worktree of each submodule is also checked.
2. The requested branch is checked out on the superproject.
3. The submodule commit or branch referenced by the newly-checked-out
   superproject commit is checked out on each submodule.

What doesn't already work:

  * Same as in create mode


- git status

-- From superproject
The superproject is clean if:

  * No tracked files in the superproject have been modified and not committed
  * No tracked files in any submodules have been modified and not committed
  * No commits in any submodules differ from the commits referenced by the tip
    commit of the superproject

Advices should describe:

  * How to commit or drop changes to files in the superproject
  * How to commit or drop changes to files in the submodules
  * How to commit changes to submodule references 
  * Which commit/branch to switch the submodule back to if the current work
    should be dropped: "Submodule "foo" no longer points to "main", 'git -C foo
    switch main' to discard changes"

What doesn't already work:

  * "git status" being super fast and actually possible to use.
    ** (That is, we've seen it move very slowly on projects with many
       submodules.)
  * Advice updates to use the appropriate submodule-y commands.

-- From submodule

git status's behavior for submodules does not change compared to
single-repository Git, except that a red warning line will also display if the
superproject commit does not point to the HEAD of the submodule. (This could
look similar to the detached-HEAD warning and tracking branch lines in git
status today, e.g. "HEAD is ahead of parent project by 2 commits".)

What doesn't already work:

  * "git status" from a submodule being aware of the superproject.


- git push

-- From superproject

Ideally, a push of the superproject commit results in a push of each submodule
which changed, to the appropriate Gerrit upstream. Commits pushed this way
across submodules should somehow be associated in the Gerrit UI, similar to the
"submitted together" display. This will need some work to make happen.

What doesn't already work:

  * Automatically setting Gerrit topic (with a hook)
  * "push --recurse-submodules" knowing where to push to in submodules to
    initiate a Gerrit review
    ** From `branch` field in .gitmodules?
    ** Gerrit accepting 'git push -o review origin main' pushes?
    ** Review URL with a remote helper that rewrites refs/heads/main to
       refs/for/main?
    ** Need UX help

From submodule
No change to client behavior is needed. With Gerrit submodule subscriptions, the
server knows how to generate superproject commits when merging submodule
commits.

- git pull / git rebase

Note: We're still thinking about this one :)

1. Performs a fetch as described above
2. For each superproject commit, replay the submodule commits against the newly
   updated submodule base; then, make a new superproject commit containing those
   changes

What doesn't already work:

  * Rewriting gitlinks in a superproject commit when 'rebase
    --recurse-submodules'-ing
  * Resuming after resolving a conflict during rebase

- git merge

The story for merges is a little bit muddled... and for our goals we don't need
it for quite a while, so we haven't thought much about it :) Any suggestions
folks have about reasonable ways to 'git merge --recurse-submodules' are totally
welcome. For now, though, we'll probably just stick in some error message saying
that merges with submodules isn't currently supported (maybe we will even add
that downstream).

What doesn't already work:

  * Erroring out for "not supported"


Aligning Teams
--------------

There's two pieces of work that we are relying on a lot, and both have been
mentioned upstream by now, so I'll just link out:

1. Recommended Hook Configurations
(https://lore.kernel.org/git/pull.908.v2.git.1616723016659.gitgitgadget@gmail.com)

2. Shared Configuration Across Submodules
(https://lore.kernel.org/git/20210408233936.533342-1-emilyshaffer@google.com)

Edge Cases, Mess Recovery, & Power Users
-------------------------------

- Unstaged Changes in Submodules At Commit Time

-- Related Changes (Single Branch)

If a user has unstaged changes in multiple submodules and runs 'git commit
--all' from the superproject, they should be presented with an editor which
contains commit message drafts for each modified branch, including the
superproject, separated by scissors or some other delineator. After providing a
commit message, Git should perform each submodule commit, then finally perform
the superproject commit based on the submodules' new commit IDs and apply the
proposed superproject commit message.


What doesn't already work:

  * "git commit --recurse-submodules" that lets me write a commit message with
    scissors dividing things in each repository

-- Unrelated Changes (Separating Into Multiple Branches)

If a user has unstaged changes in multiple submodules and only wants to commit
some of them, and runs 'git add --patch' from the superproject, they should be
walked through 'git add --patch' for each submodule first. However, since this
could be a lengthy process, we need to think carefully about how the UX should
look compared to the existing `git add --patch` UX for single-repo projects.

What doesn't already work:

  * "git add --patch" that recurses through submodule hunks as well


- Recovering from Exploratory Changes with 'git restore' and 'git reset'

When a user has checked out some historical commit in at least one submodule for
the purpose of exploration/investigation, it should be easy to reset the entire
tree back to the state defined by the superproject commit. Running git restore
(or git reset) from the superproject should recurse by running git checkout on
each submodule - and when there are no untracked changes in the submodule, it
can do this without asking for user intervention or approval.

What doesn't already work:

  * Add some tests for good restore/reset behavior and make them pass


- Multiple Commits on a Superproject Branch

Generally, one superproject commit should represent one feature, where that one
feature may consist of multiple submodule commits. It could be thought of
similarly to a merge commit, which brings a stack of related changes into the
history and summarizes them a single commit, without squashing or losing
history. So a user who has two commits in one superproject branch is working on
two features, one of which depends on the other. Reordering those commits should
involve replaying the commits in each submodule associated with each
superproject commit:


  superproject  submodule                    superproject  submodule

       A ---------> a1                            B ----------> b1
       |            |                             |             |
       |            a2                            |             b2
       |            |                             |             |
       |            a3                            A ----------> a1
       |            |          rebase             |             |
       B ---------> b1         =====>             |             a2
       |            |                             |             |
       |            b2                            |             a3
       |            |                             |             |
       o            o                             o             o
       |            |                             |             |
       o            o                             o             o
       |            |                             |             |


- Branching in a Submodule

In addition to the 'git status' warning, users should also receive a warning
like detached-HEAD when switching branches in the submodule without a
superproject commit - "the branch you are leaving behind is not tracked by any
superproject commit". Users who are just working in and pushing from a single
submodule may find this warning annoying, so it should be clear how to disable
that warning per-submodule.


- Worktrees

When a user runs 'git worktree add' from the superproject, each submodule in the
new worktree should also be created as a worktree of the corresponding submodule
in the original project.

What doesn't already work:

  * worktrees and submodules getting along - submodules are now freshly cloned
    when creating a superproject worktree

- git clone --reference [--dissociate]

When cloning with an alternate directory, submodules should also try to use
object stores associated with the referenced project instead of cloning from
their remotes right away. It is unclear how much of this works today.


What doesn't already work:

  * Writing some tests and making them pass

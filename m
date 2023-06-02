Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871C0C7EE29
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 10:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbjFBK2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbjFBK14 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 06:27:56 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8B3E42
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 03:26:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f606a80d34so18044225e9.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 03:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685701551; x=1688293551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2H3pydQ9Lm8f2/wEEHxr6Q9x669sTJg3OK+ttMF3WxU=;
        b=ap/muEaGiozIkQE8a0qfanVvY73wt4ZfhhpJZOTkmTuF81B3YgvbCCqXNiNgZEmExM
         1OOp03nTQrxevHnA0/fshvAmRNxqLWRLRpLN3csqR8DpOzP+up3ouYwTm7Uj50MBNpV7
         qPHmM88+YFqGC1m6ElKC8LVn4dqcLZI6PU+2Yve3NLFwgE81luhrEciQvIOr146ECS4Y
         c1nIXvN3LkYU8zif/m3zv/ha9Q8zcFzdgSuyMP6zNNnqf5h868vcOIEyib5sTbJJzzKE
         xThbWzokUU6pYSltW4dcmh2HwSeuoIU01TcusnHxVjBEQ2Orpt+6o9jXAUCaxVNAd0OY
         17qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701551; x=1688293551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2H3pydQ9Lm8f2/wEEHxr6Q9x669sTJg3OK+ttMF3WxU=;
        b=YQGzf026iy9BDMLg9zuzm2wR6rGEYhJcLsG/T8dV8Cm2sfmY/V4X4pjwyciF/aF1Jj
         80K4rbJ+K1GVGHqWrUSoCXkktQfaxqJ5SzraLdHmemTj/dhYs4+QGzNS1LWyEU5q5Ohj
         GzByLJgio+kn3Pr41fL4qEY0gjDTLF2b3UTJWjq6UndeUKYzV1oVO7j0pFa27PLFIEk6
         1G36rPsKmhUYmvB6lfdGfzRrYStrZNf0vOFEE9vl9BQrdTMCwLZOvG1uoRKiNH89D8Lz
         R6HyhEa9lkJmC/+2E83c+EhARG1COSOAWMpT8fcqcyyIXxu6gOc85sO4utxhsG/irozu
         8MAQ==
X-Gm-Message-State: AC+VfDzGR3Ui5GfCwYTEz45Vk0PHc5c0qrM4h+ggQmqmdqGRhBpc3ciU
        7LEyByeRKhUJCa2031SAHa6UD2xTQAYDBQ==
X-Google-Smtp-Source: ACHHUZ64GmqKVoXeGyUc7NnmETXU4mNUJRi2lbh3ervoLGUiN5Fic0xsHBKv7lWNbjqopES3oRbgNw==
X-Received: by 2002:a7b:cc84:0:b0:3f6:be1:b8d9 with SMTP id p4-20020a7bcc84000000b003f60be1b8d9mr1550290wma.6.1685701550167;
        Fri, 02 Jun 2023 03:25:50 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1169:70dc:520b:5de9:c23d:7cde])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c029200b003f601a31ca2sm1468035wmk.33.2023.06.02.03.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:25:49 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 00/15] Introduce new `git replay` command
Date:   Fri,  2 Jun 2023 12:25:18 +0200
Message-ID: <20230602102533.876905-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.15.ga6d88fc8f0
In-Reply-To: <20230509175347.1714141-1-christian.couder@gmail.com>
References: <20230509175347.1714141-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# Intro

`git replay` has initially been developed entirely by Elijah Newren
mostly last year (2022) at:

https://github.com/newren/git/commits/replay

I took over this year to polish and upstream it as GitLab is
interested in replacing libgit2, and for that purpose needs a command
to do server side (so without using a worktree) rebases, cherry-picks
and reverts.

I reduced the number of commits and features in this first patch
series, compared to what Elijah already developed. Especially I
stopped short of replaying merge commits and replaying
interactively. These and other features might be upstreamed in the
future after this patch series has graduated.

The focus in this series is to make it a good plumbing command that
can already be used server side and that replaces the "fast-rebase"
test-tool command. So things to make it easier to use on the command
line, and more advanced features (like replaying merges) are left out.

# Content of this cover letter

The "Quick Overview" and "Reasons for diverging from cherry-pick &
rebase" sections just below are describing the purpose of the new
command in the big scheme of things. They are taken from Elijah's
design notes
(https://github.com/newren/git/blob/replay/replay-design-notes.txt)
and describe what we want this command to become and the reasons for
that, not what the command is after only this patch series. Also these
design notes were written at least one year ago, so parts of those 2
sections are not true anymore. I have added Phillip Wood's or Felipe
Contreras' notes (thanks to them) where that's the case, but some now
flawed parts may have missed.

After these two sections, starting with the "Important limitations"
section, you will find sections describing what is actually in this
patch series.

More interesting material is available in Elijah's design notes like
an "Intro via examples"
(https://github.com/newren/git/blob/replay/replay-design-notes.txt#L37-L132),
a discussion about "Preserving topology, replaying merges"
(https://github.com/newren/git/blob/replay/replay-design-notes.txt#L264-L341)
and a "Current status" section describing Elijah's work
(https://github.com/newren/git/blob/replay/replay-design-notes.txt#L344-L392)
before I started working on upstreaming it.

I have not included this material here though, as the documentation
added by this patch series for the `git replay` command already
includes an "EXAMPLES" section, and other sections of Elijah's design
notes might not be interesting for now. Also this cover letter is
already pretty long.  But reviewers can refer to the links above if
they think it can help.

# Quick Overview (from Elijah's design notes)

`git replay`, at a basic level, can perhaps be thought of as a
"default-to-dry-run rebase" -- meaning no updates to the working tree,
or to the index, or to any references.  However, it differs from
rebase in that it:

  * Works for branches that aren't checked out

  * Works in a bare repository

  * Can replay multiple branches simultaneously (with or without common
    history in the range being replayed)

  * Preserves relative topology by default (merges are replayed too in
    Elijah's original work, not in this series)

  * Focuses on performance

  * Has several altered defaults as a result of the above

I sometimes think of `git replay` as "fast-replay", a patch-based
analogue to the snapshot-based fast-export & fast-import tools.

# Reasons for diverging from cherry-pick & rebase (from Elijah's
  design notes)

There are multiple reasons to diverge from the defaults in cherry-pick and
rebase.

* Server side needs

  * Both cherry-pick and rebase, via the sequencer, are heavily tied
    to updating the working tree, index, some refs, and a lot of
    control files with every commit replayed, and invoke a mess of
    hooks[1] that might be hard to avoid for backward compatibility
    reasons (at least, that's been brought up a few times on the
    list).

  * cherry-pick and rebase both fork various subprocesses
    unnecessarily, but somewhat intrinsically in part to ensure the
    same hooks are called that old scripted implementations would have
    called.

    Note: since 356ee4659bb (sequencer: try to commit without forking
    'git commit', 2017-11-24) cherry-pick and rebase do not fork
    subprocesses other than hooks for the cases covered by this patch
    series (i.e. they do not fork "git commit" for simple picks).

  * "Dry run" behavior, where there are no updates to worktree, index,
    or even refs might be important.

  * Should not assume users only want to operate on HEAD (see next
    section)

* Decapitate HEAD-centric assumptions

  * cherry-pick forces commits to be played on top of HEAD;
    inflexible.

  * rebase assumes the range of commits to be replayed is
    upstream..HEAD by default, though it allows one to replay
    upstream..otherbranch -- but it still forcibly and needlessly
    checks out 'otherbranch' before starting to replay things.

    Note: since 767a9c417eb (rebase -i: stop checking out the tip of
    the branch to rebase, 2020-01-24) it's not true that rebase
    forcibly and needlessly checks out 'otherbranch'.

  * Assuming HEAD is involved severely limits replaying multiple
    (possibly divergent) branches.

    Note: since 89fc0b53fdb (rebase: update refs from 'update-ref'
    commands, 2022-07-19) the sequencer can update multiple
    branches. The issue with divergent branch is with command line
    arguments and the todo list generation rather than the
    capabilities of the sequencer.

  * Once you stop assuming HEAD has a certain meaning, there's not
    much reason to have two separate commands anymore (except for the
    funny extra not-necessarily-compatible options both have gained
    over time).

  * (Micro issue: Assuming HEAD is involved also makes it harder for
    new users to learn what rebase means and does; it makes command
    lines hard to parse.  Not sure I want to harp on this too much, as
    I have a suspicion I might be creating a tool for experts with
    complicated use cases, but it's a minor quibble.)

* Performance

  * jj is slaughtering us on rebase speed[2].  I would like us to become
    competitive.  (I dropped a few comments in the link at [2] about why
    git is currently so bad.)

  * From [3], there was a simple 4-patch series in linux.git that took
    53 seconds to rebase.  Switching to ort dropped it to 16 seconds.
    While that sounds great, only 11 *milliseconds* were needed to do
    the actual merges.  That means almost *all* the time (>99%) was
    overhead!  Big offenders:

    * --reapply-cherry-picks should be the default

    * can_fast_forward() should be ripped out, and perhaps other extraneous
      revision walks

      Note: d42c9ffa0f (rebase: factor out branch_base calculation,
      2022-10-17) might already deal with that (according to Felipe
      Contreras).

    * avoid updating working tree, index, refs, reflogs, and control
      structures except when needed (e.g. hitting a conflict, or operation
      finished)

  * Other performance ideas (mostly for future work, not in this
    series)

    * single-file control structures instead of directory of files
      (when doing interactive things which is in Elijah's original
      work, but not in this series)

    * avoid forking subprocesses unless explicitly requested (e.g.
      --exec, --strategy, --run-hooks).  For example, definitely do not
      invoke `git commit` or `git merge`.

    * Sanitize hooks:

      * dispense with all per-commit hooks for sure (pre-commit,
        post-commit, post-checkout).

      * pre-rebase also seems to assume exactly 1 ref is written, and
        invoking it repeatedly would be stupid.  Plus, it's specific
        to "rebase".  So...ignore?  (Stolee's --ref-update option for
        rebase probably broke the pre-rebase assumptions already...)

      * post-rewrite hook might make sense, but fast-import got
        exempted, and I think of replay like a patch-based analogue
        to the snapshot-based fast-import.

    * When not running server side, resolve conflicts in a sparse-cone
      sparse-index worktree to reduce number of files written to a
      working tree.  (See below as well.)

    * [High risk of possible premature optimization] Avoid large
      numbers of newly created loose objects, when replaying large
      numbers of commits.  Two possibilities: (1) Consider using
      tmp-objdir and pack objects from the tmp-objdir at end of
      exercise, (2) Lift code from git-fast-import to immediately
      stuff new objects into a pack?

* Multiple branches and non-checked out branches

  * The ability to operate on non-checked out branches also implies
    that we should generally be able to replay when in a dirty working
    tree (exception being when we expect to update HEAD and any of the
    dirty files is one that needs to be updated by the replay).

  * Also, if we are operating locally on a non-checked out branch and
    hit a conflict, we should have a way to resolve the conflict
    without messing with the user's work on their current
    branch. (This is not is this patch series though.)

    * Idea: new worktree with sparse cone + sparse index checkout,
      containing only files in the root directory, and whatever is
      necessary to get the conflicts

    * Companion to above idea: control structures should be written to
      $GIT_COMMON_DIR/replay-${worktree}, so users can have multiple
      replay sessions, and so we know which worktrees are associated
      with which replay operations.

  - [1] https://lore.kernel.org/git/pull.749.v3.git.git.1586044818132.gitgitgadget@gmail.com/
  - [2] https://github.com/martinvonz/jj/discussions/49
  - [3] https://lore.kernel.org/git/CABPp-BE48=97k_3tnNqXPjSEfA163F8hoE+HY0Zvz1SWB2B8EA@mail.gmail.com/

# Important limitations

* The code exits with code 1 if there are any conflict. No
  resumability. No nice output. No interactivity. No special exit code
  depending on the reason.

* When a commit becomes empty as it is replayed, it is still replayed
  as an empty commit, instead of being dropped.

* No replaying merges, nor root commits. Only regular commits.

* Signed commits are not properly handled. It's not clear what to do
  to such commits when replaying on the server side.

* Notes associated with replayed commits are not updated nor
  duplicated. (Thanks to Phillip Wood for noticing.)

# Commit overview

* 1/15 t6429: remove switching aspects of fast-rebase

    New preparatory commit to make it easier to later replace the
    fast-rebase test-tool by `git replay` without breaking existing
    tests.

* 2/15 replay: introduce new builtin

     This creates a minimal `git replay` command by moving the code
     from the `fast-rebase` test helper from `t/helper/` into
     `builtin/` and doing some renames and a few other needed changes.
     (In v3 some `#include ...` were changed to deal with upstream
     changes in this area as suggested by Junio.)

* - 3/15 replay: start using parse_options API
  - 4/15 replay: die() instead of failing assert()
  - 5/15 replay: introduce pick_regular_commit()
  - 6/15 replay: don't simplify history
  - 7/15 replay: add an important FIXME comment about gpg signing
  - 8/15 replay: remove progress and info output
  - 9/15 replay: remove HEAD related sanity check

     These slowly change the command to make it behave more like
     regular commands and to start cleaning up its output.

* 10/15 replay: make it a minimal server side command

     After the cleaning up in previous commits, it's now time to
     radically change the way it works by stopping it to do ref
     updates, to update the index and worktree, to consider HEAD as
     special. Instead just make it output commands that should be
     passed to `git update-ref --stdin`.

* 11/15 replay: use standard revision ranges

     Start addind new interesting features and also documentation and
     tests, as the interface of the command is cristalizing into its
     final form.

* 12/15 replay: disallow revision specific options and pathspecs

     For now disallow revision specific options and pathspecs that are
     allowed and eaten by setup_revisions(), as it's not clear if all
     of these extra features are really needed, and anyway they would
     require tests and doc. So we leave them for future improvements.
     (In v3 a typo was fixed in the commit message and a code comment
     has been improved as suggested by Elijah.)

* - 13/15 replay: add --advance or 'cherry-pick' mode
  - 14/15 replay: add --contained to rebase contained branches

    Add new option and features to the command. (In v3, in commit
    14/15, the synopsys of the command was improved and a sentence
    about git rebase in its doc was removed as suggested by Elijah.)

* 15/15 replay: stop assuming replayed branches do not diverge

      This adds another interesting feature, as well as related
      documentation and tests. (In v3 a typo in the commit message was
      fixed as suggested by Elijah.)

# Notes about `fast-rebase`, tests and documentation

The `fast-rebase` test-tool helper was developed by Elijah to
experiment with a rebasing tool that would be developed from scratch
based on his merge-ort work, could be used to test that merge-ort
work, and would not have the speed and interface limitations of `git
rebase` or `git cherry-pick`.

This `fast-rebase` helper was used before this series in:

t6429-merge-sequence-rename-caching.sh

So when `git replay` is created from `fast-rebase` in patch 2/15, the
t6429 test script is also converted to use `git replay`. This ensures
that `git replay` doesn't break too badly during the first 10 patches
in this patch series.

Tests and documentation are introduced specifically for `git replay`
only in 11/15 and later patches as it doesn't make much sense to
document and test behavior that we know is going to change soon. So
it's only when the command is crystalizing towards its final form that
we start documenting and testing it.

# Possibly controversial issues 

* bare or not bare: this series works towards a plumbing command with
  the end goal of it being usable and used first on bare repos,
  contrary to existing commands like `git rebase` and `git
  cherry-pick`. The tests check that the command works on both bare
  and non-bare repo though.

* exit status: a successful, non-conflicted replay exits with code
  0. When the replay has conflicts, the exit status is 1. If the
  replay is not able to complete (or start) due to some kind of error,
  the exit status is something other than 0 or 1. There are a few
  tests checking that. It has been suggested in an internal review
  that conflicts might want to get a more specific error code as an
  error code of 1 might be quite easy to return by accident. It
  doesn't seem to me from their docs (which might want to be improved,
  I didn't look at the code) that other commands like `git merge` and
  `git rebase` exit with a special error code in case of conflict.

* make worktree and index changes optional: commit 10/15 stops
  updating the index and worktree, but it might be better especially
  for cli users to make that optional. The issue is that this would
  make the command more complex while we are developing a number of
  important features so that the command can be used on bare repos. It
  seems that this should rather be done in an iterative improvement
  after the important features have landed.

* when and where to add tests and docs: although t6429 has tests that
  are changed to use the new command instead of the fast-rebase
  test-tool command as soon as the former is introduced, there is no
  specific test script and no doc for the new command until commit
  11/15 when standard revision ranges are used. This is done to avoid
  churn in tests and docs while the final form of the command hasn't
  crystalized enough. Adding tests and doc at this point makes this
  commit quite big and possibly more difficult to review than if they
  were in separate commits though. On the other hand when tests and
  docs are added in specific commits some reviewers say it would be
  better to introduce them when the related changes are made.

* --advance and --contained: these two advanced options might not
  belong to this first series and could perhaps be added in a followup
  series in separate commits. On the other hand the code for
  --contained seems involved with the code of --advance and it's nice
  to see soon that git replay can indeed do cherry-picking and rebase
  many refs at once, and this way fullfil these parts of its promise.

* replaying diverging branches: 15/15 the last patch in the series,
  which allow replaying diverging branches, can be seen as a
  fundamental fix or alternatively as adding an interesting
  feature. So it's debatable if it should be in its own patch along
  with its own tests as in this series, or if it should be merged into
  a previous patch and which one.

* only 2 patches: this patch series can be seen from a high level
  point of view as 1) introducing the new `git replay` command, and 2)
  using `git replay` to replace, and get rid of, the fast-rebase
  test-tool command. The fact that not much of the original
  fast-rebase code and interface is left would agree with that point
  of view. On the other hand, fast-rebase can also be seen as a first
  iteration towards `git replay`. So it can also make sense to see how
  `git replay` evolved from it.

# Changes between v2 and v3

Thanks to Elijah and Junio for their suggestions on the previous
version! The very few and minor changes compared to v2 are:

* The patch series was rebased onto master at v2.41.0.

* Patch 2/15 contains `#include ...` changes suggested by Junio to
  deal with upstream changes in this area that were merged while I was
  working on v2 and that conflicted with this series.

* Patch 12/15 has a typo fix in its commit message and an improved
  code comment both suggested by ELijah. The code comment is about
  rejecting pathspec. I removed the 'TODO' mention in it and worded it
  like we "might accept" pathspec in the future, instead of saying
  that "we should definitely accept them".

* In patch 14/15, as suggested by Elijah, the command synopsys now
  contains:

  ([--contained] --onto <newbase> | --advance <branch>)

  instead of:

  [--contained] (--onto <newbase> | --advance <branch>)

  Also in the doc about --contained the sentence talking about git
  rebase has been removed.

* Patch 15/15 has a typo fix in its commit message.

# Changes between v1 and v2

Thanks to all the reviewers on the mailing list or during a Review
Club! Especially, thanks to Elijah, Dscho, Phillip Wood, Derrick
Stolee, Patrick Steinhardt, Junio, Felipe Contreras, Calvin Wan and
all the Review Club participants.

The Review Club notes (see those on 2023-04-18) are available on:

https://docs.google.com/document/d/14L8BAumGTpsXpjDY8VzZ4rRtpAjuGrFSRqn3stCuS_w/

Now the changes between v1 and v2 are:

* The patch series has been rebased on top of current master, so that
  conflicts with master are resolved. This required replacing calls to
  functions like get_oid() with repo_get_oid(), as well as changing
  some `#include "*.h"` to use different header files. This
  unfortunately makes the range-diff between v1 and v2 a bit more
  difficult to read than we would like.

* Patch 1/15 is a new patch. It has been introduced to rework t6429,
  so that this test script doesn't break when conflict output is
  removed later in the series. This allowed us to remove the old 9/14
  patch ("replay: very coarse worktree updating").

* The old 9/14 patch ("replay: very coarse worktree updating") was
  removed. This is to make sure that the new command can be used on
  bare repos. This enables us to focus first on making sure the new
  command a good plumbing command that works well on bare repos.

* The old 12/14 patch ("replay: introduce guess_new_base()") was
  removed. This is also to focus first on making sure the new command
  is a good plumbing command.

* The old 13/14 patch ("replay: add different modes") has been split
  into 2 patches: patch 13/15 ("replay: add --advance or 'cherry-pick'
  mode") and patch 14/15 ("replay: add --contained to rebase contained
  branches").

* Patch 12/15 ("replay: disallow revision specific options and
  pathspecs") is a new patch that disallow using revision specific
  options that would be allowed and eaten by setup_revisions(). Even
  if it would be very nice to have some of these options in the
  future, not all these options make sense for the new command, and it
  might require improving the setup_revisions() mechanism (as well as
  adding tests and doc) to cleanly allow those we want, but that is
  outside the scope of this first patch series.

  While at it, this patch also disallow pathspecs too. It would be
  nice to have them in the future, but for now it is not necessary and
  would require work (at least for tests and doc) that can be done
  later.

* Patches 11/15 to 15/15 include a number of new tests to check that
  the command works well on bare repos, and in case of 11/15 to check
  that exit code in case of conflict is 1.

* Patch 11/15, in which the doc for the `git replay` command is
  introduced, now says that the new command is experimental.

* Note that a segfault that was found by Derrick Stolee in the v1 is
  fixed by 000c4ceca7 (merge-ort: fix calling merge_finalize() with no
  intermediate merge, 2023-04-22) merged to master by 3927312601
  (Merge branch 'en/ort-finalize-after-0-merges-fix', 2023-05-02).

# Range-diff between v2 and v3

 1:  e1bef69d8f =  1:  51fa1c7aea t6429: remove switching aspects of fast-rebase
 2:  73396c4fc9 !  2:  19f8cf1b2e replay: introduce new builtin
    @@ t/helper/test-fast-rebase.c => builtin/replay.c
      #include "cache-tree.h"
      #include "commit.h"
      #include "environment.h"
    +@@
    + #include "sequencer.h"
    + #include "setup.h"
    + #include "strvec.h"
    +-#include "tree.h"
    ++#include <oidset.h>
    ++#include <tree.h>
    + 
    + static const char *short_commit_name(struct commit *commit)
    + {
     @@ builtin/replay.c: static struct commit *create_commit(struct tree *tree,
        return (struct commit *)obj;
      }
 3:  1a1b214146 =  3:  295e876db6 replay: start using parse_options API
 4:  f63d6f0c9f =  4:  6ece7d3751 replay: die() instead of failing assert()
 5:  e7de455815 =  5:  9b4bc659fb replay: introduce pick_regular_commit()
 6:  103c18b3eb =  6:  9ab68d50ab replay: don't simplify history
 7:  5be7eec24f =  7:  37e93faafa replay: add an important FIXME comment about gpg signing
 8:  bb5d3a0564 =  8:  03036781ed replay: remove progress and info output
 9:  a75b02ddae =  9:  4ea289952e replay: remove HEAD related sanity check
10:  cff278a0b9 ! 10:  fba98eda07 replay: make it a minimal server side command
    @@ builtin/replay.c
     -#include "sequencer.h"
     -#include "setup.h"
      #include "strvec.h"
    --#include "tree.h"
    - 
    - static const char *short_commit_name(struct commit *commit)
    - {
    + #include <oidset.h>
    + #include <tree.h>
     @@ builtin/replay.c: static struct commit *pick_regular_commit(struct commit *pickme,
        pickme_tree = repo_get_commit_tree(the_repository, pickme);
        base_tree = repo_get_commit_tree(the_repository, base);
11:  926b332d44 ! 11:  03f9f20f6e replay: use standard revision ranges
    @@ builtin/replay.c
      #include "refs.h"
      #include "revision.h"
     -#include "strvec.h"
    + #include <oidset.h>
    + #include <tree.h>
      
    - static const char *short_commit_name(struct commit *commit)
    - {
     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix)
        struct commit *onto;
        const char *onto_name = NULL;
12:  f7eb2230a7 ! 12:  e651250ac7 replay: disallow revision specific options and pathspecs
    @@ Commit message
         replay: disallow revision specific options and pathspecs
     
         A previous commit changed `git replay` to make it accept standard
    -    revision ranges using the setup_revisions() function. While this is good
    -    thing to make this command more standard and more flexible, it has the
    -    downside of enabling many revision related options accepted and eaten by
    -    setup_revisions().
    +    revision ranges using the setup_revisions() function. While this is a
    +    good thing to make this command more standard and more flexible, it has
    +    the downside of enabling many revision related options accepted and eaten
    +    by setup_revisions().
     
         Some of these options might make sense, but others, like those
         generating non-contiguous history, might not. Anyway those we might want
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
        }
      
     +  /*
    -+   * TODO: For now, we reject any pathspec. (They are allowed
    -+   * and eaten by setup_revisions() above.) In the future we
    -+   * should definitely accept them and add related tests and doc
    -+   * though.
    ++   * Reject any pathspec. (They are allowed and eaten by
    ++   * setup_revisions() above.) In the future we might accept
    ++   * them, after adding related tests and doc though.
     +   */
     +  if (revs.prune_data.nr) {
     +          error(_("invalid pathspec: %s"), revs.prune_data.items[0].match);
13:  bc301cf93a ! 13:  56e5416dad replay: add --advance or 'cherry-pick' mode
    @@ builtin/replay.c
      #include "refs.h"
      #include "revision.h"
     +#include "strmap.h"
    + #include <oidset.h>
    + #include <tree.h>
      
    - static const char *short_commit_name(struct commit *commit)
    - {
     @@ builtin/replay.c: static struct commit *create_commit(struct tree *tree,
        return (struct commit *)obj;
      }
14:  3eb582b509 ! 14:  2cc17dfdc7 replay: add --contained to rebase contained branches
    @@ Documentation/git-replay.txt: git-replay - Replay commits on a different base, w
      --------
      [verse]
     -'git replay' (--onto <newbase> | --advance <branch>) <revision-range>...
    -+'git replay' [--contained] (--onto <newbase> | --advance <branch>) <revision-range>...
    ++'git replay' ([--contained] --onto <newbase> | --advance <branch>) <revision-range>...
      
      DESCRIPTION
      -----------
    @@ Documentation/git-replay.txt: top of the exact same new base, they only differ i
     +update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
     +update refs/heads/tipbranch ${NEW_tipbranch_HASH} ${OLD_tipbranch_HASH}
     +------------
    -+
    -+In contrast, trying to do this with rebase would require 3 separate
    -+rebases, eacho of which involves a different <ONTO> and <UPSTREAM> and
    -+forces you to first check out each branch in turn.
     +
      When calling `git replay`, one does not need to specify a range of
      commits to replay using the syntax `A..B`; any range expression will
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
      
        const char * const replay_usage[] = {
     -          N_("git replay (--onto <newbase> | --advance <branch>) <revision-range>..."),
    -+          N_("git replay [--contained] (--onto <newbase> | --advance <branch>) <revision-range>..."),
    ++          N_("git replay ([--contained] --onto <newbase> | --advance <branch>) <revision-range>..."),
                NULL
        };
        struct option replay_options[] = {
15:  bdd8a3b3e1 ! 15:  a6d88fc8f0 replay: stop assuming replayed branches do not diverge
    @@ Commit message
         replayed onto already replayed commits.
     
         For this purpose, let's store the replayed commit and its original
    -    commit in a key value store, so that we can easily find and reused a
    +    commit in a key value store, so that we can easily find and reuse a
         replayed commit instead of the original one.
     
         Co-authored-by: Christian Couder <chriscool@tuxfamily.org>


Christian Couder (1):
  replay: disallow revision specific options and pathspecs

Elijah Newren (14):
  t6429: remove switching aspects of fast-rebase
  replay: introduce new builtin
  replay: start using parse_options API
  replay: die() instead of failing assert()
  replay: introduce pick_regular_commit()
  replay: don't simplify history
  replay: add an important FIXME comment about gpg signing
  replay: remove progress and info output
  replay: remove HEAD related sanity check
  replay: make it a minimal server side command
  replay: use standard revision ranges
  replay: add --advance or 'cherry-pick' mode
  replay: add --contained to rebase contained branches
  replay: stop assuming replayed branches do not diverge

 .gitignore                               |   1 +
 Documentation/git-replay.txt             | 121 +++++++
 Makefile                                 |   2 +-
 builtin.h                                |   1 +
 builtin/replay.c                         | 432 +++++++++++++++++++++++
 command-list.txt                         |   1 +
 git.c                                    |   1 +
 t/helper/test-fast-rebase.c              | 240 -------------
 t/helper/test-tool.c                     |   1 -
 t/helper/test-tool.h                     |   1 -
 t/t3650-replay-basics.sh                 | 206 +++++++++++
 t/t6429-merge-sequence-rename-caching.sh |  45 +--
 12 files changed, 789 insertions(+), 263 deletions(-)
 create mode 100644 Documentation/git-replay.txt
 create mode 100644 builtin/replay.c
 delete mode 100644 t/helper/test-fast-rebase.c
 create mode 100755 t/t3650-replay-basics.sh

-- 
2.41.0.15.ga6d88fc8f0


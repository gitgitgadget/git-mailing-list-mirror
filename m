Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B69CD80C0
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 12:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjJJMjM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjJJMjK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 08:39:10 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06FFA4
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:05 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50305abe5f0so7521900e87.2
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696941543; x=1697546343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0wdzPI6bHsdYe32+2gobDxCmxDZBub25NqBeIVKOIc=;
        b=BDZjA0Qz80dyzj2bY83PzUASL3TRUyqWXfsKqn0VDnsjzQuHtcEOsoGkNiAE97mIw7
         KdWFz3pj6w7o+yNMXEag84kggZXAB3HQuUnkhE9r/3kOVwxjWSQtYFE2H4p+Nw0+3DNU
         Lb2GOBb7mOc8hx8j3AgRWkPU32hZyRyn0zn4yMvX87H07E3jaRQM1A+/0bRbSZBxushg
         PfD2wAyP5uK0SORJT+f0GpuK0FfxwqQ9/WbNX1faPrXYKyXvbk19+ThD+30IlDI4vAnF
         AZ9e8vT/jPmrQYJVc2tjtmNIo91HHA9BFZizBC4DE+fUNEzgarX4GCDVtmRxL/vVOBjw
         8l5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696941543; x=1697546343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0wdzPI6bHsdYe32+2gobDxCmxDZBub25NqBeIVKOIc=;
        b=mt4t11yIdWeOcEV71hKWyCW61FBFbiuIC1QhagrvZFhqajkC1TOf9pvzU8oGTADct6
         W+GsISYv+XI+pO0/mehBIdeSgwBwTjiI4mS7O+TwyQB2rxWaXChmMrUZjWMzdsg+5C/o
         lVxbeb83WPlTaHwo0mjJ2pBFyJnenu5//K0dN8XAaJAsUBVPxKDb42Kt8VCNwpK4nX+z
         UFIrmi7ds1XrWuhcmBkq3ZgSIlqFlw8hCDyCiTIoPh+zBzOEMuLbNkIfuD/P/DaKatJh
         spDmykas0gUNQnt30K+AwN/91mXlfHRySMqiDVoh/EC117sSIHb86rQ4t3jJ5OLpk3Ha
         kgBQ==
X-Gm-Message-State: AOJu0YwokaXTBDYGRLpQpEpJshN4Nxwru0MJlhVwmbLoW5hM4CKuRRzr
        534M2ODVGksOCjq+F6eSn3Olc6OiayOS7g==
X-Google-Smtp-Source: AGHT+IH/jRuMBM3x9jU714HIhte5Ke6a+a18MJNPfD2Yz0+myxCuVKXNFReAh43fGe/9UvqB6Et5YQ==
X-Received: by 2002:a19:f70c:0:b0:500:cb2b:8678 with SMTP id z12-20020a19f70c000000b00500cb2b8678mr13574435lfe.40.1696941542879;
        Tue, 10 Oct 2023 05:39:02 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:516d:299b:cbff:be05])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcc8f000000b003fee6e170f9sm14071689wma.45.2023.10.10.05.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:39:01 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Dragan Simic <dsimic@manjaro.org>,
        Linus Arver <linusa@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 00/14] Introduce new `git replay` command
Date:   Tue, 10 Oct 2023 14:38:33 +0200
Message-ID: <20231010123847.2777056-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.339.g663cbc8ab1
In-Reply-To: <20230907092521.733746-1-christian.couder@gmail.com>
References: <20230907092521.733746-1-christian.couder@gmail.com>
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

It looks like GitHub has actually already been using version 3 of this
patch series in production with good results. See:

https://github.blog/2023-07-27-scaling-merge-ort-across-github/
https://lore.kernel.org/git/304f2a49-5e05-7655-9f87-2011606df5db@gmx.de/

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

* 1/14 t6429: remove switching aspects of fast-rebase

    Preparatory commit to make it easier to later replace the
    fast-rebase test-tool by `git replay` without breaking existing
    tests.

* 2/14 replay: introduce new builtin

    This creates a minimal `git replay` command by moving the code
    from the `fast-rebase` test helper from `t/helper/` into
    `builtin/` and doing some renames and a few other needed changes.

* - 3/14 replay: start using parse_options API
  - 4/14 replay: die() instead of failing assert()
  - 5/14 replay: introduce pick_regular_commit()
  - 6/14 replay: change rev walking options
  - 7/14 replay: add an important FIXME comment about gpg signing
  - 8/14 replay: remove progress and info output
  - 9/14 replay: remove HEAD related sanity check

    These slowly change the command to make it behave more like
    regular commands and to start cleaning up its output.

* 10/14 replay: make it a minimal server side command

    After the cleaning up in previous commits, it's now time to
    radically change the way it works by stopping it to do ref
    updates, to update the index and worktree, to consider HEAD as
    special. Instead just make it output commands that should be
    passed to `git update-ref --stdin`.

* 11/14 replay: use standard revision ranges

    Start addind new interesting features and also documentation and
    tests, as the interface of the command is cristalizing into its
    final form.

* - 12/14 replay: add --advance or 'cherry-pick' mode
  - 13/14 replay: add --contained to rebase contained branches

    Add new options and features to the command.

* 14/14 replay: stop assuming replayed branches do not diverge

    This adds another interesting feature, as well as related
    documentation and tests.

# Notes about `fast-rebase`, tests and documentation

The `fast-rebase` test-tool helper was developed by Elijah to
experiment with a rebasing tool that would be developed from scratch
based on his merge-ort work, could be used to test that merge-ort
work, and would not have the speed and interface limitations of `git
rebase` or `git cherry-pick`.

This `fast-rebase` helper was used before this series in:

t6429-merge-sequence-rename-caching.sh

So when `git replay` is created from `fast-rebase` in patch 2/14, the
t6429 test script is also converted to use `git replay`. This ensures
that `git replay` doesn't break too badly during the first 10 patches
in this patch series.

Tests and documentation are introduced specifically for `git replay`
only in 11/14 and later patches as it doesn't make much sense to
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

* make worktree and index changes optional: commit 10/14 stops
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
  11/14 when standard revision ranges are used. This is done to avoid
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

* replaying diverging branches: 14/14 the last patch in the series,
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

# Changes between v4 and v5

Thanks to Dscho, Linus Arver and Dragan Simic for their suggestions on
the previous version! The few changes compared to v4 are:

* The patch series was rebased onto master at 3a06386e31 (The
  fifteenth batch, 2023-10-04). This is to fix possible conflicts
  especially related to header changes.

* Patch 12/15 (replay: disallow revision specific options and
  pathspecs) in version 4 has been removed, so there are now only 14
  patches instead of 15 in the series. This follows a suggestion by
  Dscho, and goes in the direction Elijah initially wanted before
  Derrick Stolee argued for disallowing revision specific options and
  pathspecs.

* In patch 2/14 (replay: introduce new builtin) the command is now in
  the "plumbingmanipulators" category instead of the "mainporcelain"
  category. This is more in line with the goal of introducing it as a
  plumbing command for now. Thanks to a suggestion from Dscho.

* In patch 6/14 (replay: change rev walking options) the commit
  message has been improved, including its subject, to better match
  and explain what the patch does. Also instead of forcing reverse
  order we use the reverse order by default but allow it to be changed
  using `--reverse`. Thanks to Dscho.

* In patch 11/14 (replay: use standard revision ranges) the commit
  message has been improved to discuss a bit the new options that are
  now accepted and eaten by setup_revisions().

* In patch 11/14 too, the documentation has been improved thanks to
  suggestions by Linus Arver and Dragan Simic. It also now includes
  `rev-list-options.txt` to document the new rev walking options
  accepted by setup_revisions().

All CI tests seem to pass according to:

https://github.com/chriscool/git/actions/runs/6468200080

# Range-diff between v4 and v5

 1:  1eaca9b788 =  1:  72c34a0eba t6429: remove switching aspects of fast-rebase
 2:  5ac4beb1ae !  2:  f85e6c823c replay: introduce new builtin
    @@ Commit message
         Subsequent commits will flesh out its capabilities and make it a more
         standard regular builtin.
     
    +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    @@ command-list.txt: git-reflog                              ancillarymanipulators
      git-remote                              ancillarymanipulators           complete
      git-repack                              ancillarymanipulators           complete
      git-replace                             ancillarymanipulators           complete
    -+git-replay                              mainporcelain           history
    ++git-replay                              plumbingmanipulators
      git-request-pull                        foreignscminterface             complete
      git-rerere                              ancillaryinterrogators
      git-reset                               mainporcelain           history
 3:  299381aa9b =  3:  11abb9d120 replay: start using parse_options API
 4:  3b825c9be0 =  4:  9e568eae84 replay: die() instead of failing assert()
 5:  b1e890745d =  5:  e7ebf3c5ef replay: introduce pick_regular_commit()
 6:  ec51351889 !  6:  37d545d5d6 replay: don't simplify history
    @@ Metadata
     Author: Elijah Newren <newren@gmail.com>
     
      ## Commit message ##
    -    replay: don't simplify history
    +    replay: change rev walking options
     
         Let's set the rev walking options we need after calling
    -    setup_revisions() instead of before. This makes it clearer which options
    -    we need.
    +    setup_revisions() instead of before. This enforces options we always
    +    want.
    +
    +    We want the command to work from older commits to newer ones by default,
    +    but we are Ok with letting users reverse that, using --reverse, if that's
    +    what they really want.
     
         Also we don't want history simplification, as we want to deal with all
         the commits in the affected range.
     
    +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
        }
      
     +  /* requirements/overrides for revs */
    -+  revs.reverse = 1;
    ++  revs.reverse = !revs.reverse;
     +  revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
     +  revs.topo_order = 1;
     +  revs.simplify_history = 0;
 7:  cd4ed07d2d =  7:  2943f08926 replay: add an important FIXME comment about gpg signing
 8:  e45a55917c =  8:  f81962ba41 replay: remove progress and info output
 9:  0587a76cbb =  9:  236747497e replay: remove HEAD related sanity check
10:  d10368e87a = 10:  3374d5be23 replay: make it a minimal server side command
11:  4e09572c43 ! 11:  197d076a93 replay: use standard revision ranges
    @@ Commit message
         way as many other Git commands. This makes its interface more
         standard and more flexible.
     
    +    This also enables many revision related options accepted and
    +    eaten by setup_revisions(). If the replay command was a high level
    +    one or had a high level mode, it would make sense to restrict some
    +    of the possible options, like those generating non-contiguous
    +    history, as they could be confusing for most users.
    +
         Also as the interface of the command is now mostly finalized,
         we can add some documentation as well as testcases to make sure
         the command will continue to work as designed in the future.
     
    +    We only document the rev-list related options among all the
    +    revision related options that are now accepted, as the rev-list
    +    related ones are probably the most useful for now.
    +
    +    Helped-by: Dragan Simic <dsimic@manjaro.org>
    +    Helped-by: Linus Arver <linusa@google.com>
         Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    @@ Documentation/git-replay.txt (new)
     +
     +NAME
     +----
    -+git-replay - Replay commits on a different base, without touching working tree
    ++git-replay - Replay commits on a new base, works on bare repos too
     +
     +
     +SYNOPSIS
    @@ Documentation/git-replay.txt (new)
     +DESCRIPTION
     +-----------
     +
    -+Takes a range of commits, and replays them onto a new location.  Does
    -+not touch the working tree or index, and does not update any
    -+references.  However, the output of this command is meant to be used
    -+as input to `git update-ref --stdin`, which would update the relevant
    -+branches.
    ++Takes a range of commits and replays them onto a new location. Leaves
    ++the working tree and the index untouched, and updates no
    ++references. The output of this command is meant to be used as input to
    ++`git update-ref --stdin`, which would update the relevant branches
    ++(see the OUTPUT section below).
     +
     +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
     +
    @@ Documentation/git-replay.txt (new)
     +
     +<revision-range>::
     +  Range of commits to replay; see "Specifying Ranges" in
    -+  linkgit:git-rev-parse.
    ++  linkgit:git-rev-parse and the "Commit Limiting" options below.
    ++
    ++include::rev-list-options.txt[]
     +
     +OUTPUT
     +------
     +
     +When there are no conflicts, the output of this command is usable as
    -+input to `git update-ref --stdin`.  It is basically of the form:
    ++input to `git update-ref --stdin`.  It is of the form:
     +
     +  update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
     +  update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
    @@ Documentation/git-replay.txt (new)
     +EXAMPLES
     +--------
     +
    -+To simply rebase mybranch onto target:
    ++To simply rebase `mybranch` onto `target`:
     +
     +------------
     +$ git replay --onto target origin/main..mybranch
    @@ Documentation/git-replay.txt (new)
     +update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
     +------------
     +
    -+This will simultaneously rebase branch1, branch2, and branch3 -- all
    -+commits they have since base, playing them on top of origin/main.
    -+These three branches may have commits on top of base that they have in
    -+common, but that does not need to be the case.
    ++This will simultaneously rebase `branch1`, `branch2`, and `branch3`,
    ++all commits they have since `base`, playing them on top of
    ++`origin/main`. These three branches may have commits on top of `base`
    ++that they have in common, but that does not need to be the case.
     +
     +GIT
     +---
12:  64b803f1cf <  -:  ---------- replay: disallow revision specific options and pathspecs
13:  04f27d81ab ! 12:  e52d8b961c replay: add --advance or 'cherry-pick' mode
    @@ Commit message
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## Documentation/git-replay.txt ##
    -@@ Documentation/git-replay.txt: git-replay - Replay commits on a different base, without touching working tree
    +@@ Documentation/git-replay.txt: git-replay - Replay commits on a new base, works on bare repos too
      SYNOPSIS
      --------
      [verse]
    @@ Documentation/git-replay.txt: OPTIONS
      
      <revision-range>::
     -  Range of commits to replay; see "Specifying Ranges" in
    --  linkgit:git-rev-parse.
    +-  linkgit:git-rev-parse and the "Commit Limiting" options below.
     +  Range of commits to replay. More than one <revision-range> can
     +  be passed, but in `--advance <branch>` mode, they should have
     +  a single tip, so that it's clear where <branch> should point
    -+  to. See "Specifying Ranges" in linkgit:git-rev-parse.
    ++  to. See "Specifying Ranges" in linkgit:git-rev-parse and the
    ++  "Commit Limiting" options below.
      
    - OUTPUT
    - ------
    -@@ Documentation/git-replay.txt: input to `git update-ref --stdin`.  It is basically of the form:
    + include::rev-list-options.txt[]
    + 
    +@@ Documentation/git-replay.txt: input to `git update-ref --stdin`.  It is of the form:
        update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
      
      where the number of refs updated depends on the arguments passed and
    @@ builtin/replay.c: static struct commit *pick_regular_commit(struct commit *pickm
        struct merge_options merge_opt;
        struct merge_result result;
     +  struct strset *update_refs = NULL;
    -   int ret = 0, i;
    +   int ret = 0;
      
        const char * const replay_usage[] = {
     -          N_("git replay --onto <newbase> <revision-range>..."),
    @@ builtin/replay.c: static struct commit *pick_regular_commit(struct commit *pickm
                           N_("revision"),
                           N_("replay onto given commit")),
     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix)
    -                   usage_with_options(replay_usage, replay_options);
    -           }
    +   argc = parse_options(argc, argv, prefix, replay_options, replay_usage,
    +                        PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
      
     -  if (!onto_name) {
     -          error(_("option --onto is mandatory"));
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
        /* Return */
     
      ## t/t3650-replay-basics.sh ##
    -@@ t/t3650-replay-basics.sh: test_expect_success 'using replay on bare repo with disallowed pathspec' '
    -   test_must_fail git -C bare replay --onto main topic1..topic2 -- A.t
    +@@ t/t3650-replay-basics.sh: test_expect_success 'using replay on bare repo to rebase with a conflict' '
    +   test_expect_code 1 git -C bare replay --onto topic1 B..conflict
      '
      
     +test_expect_success 'using replay to perform basic cherry-pick' '
14:  9ed0919ad5 ! 13:  fc79a930b5 replay: add --contained to rebase contained branches
    @@ Commit message
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## Documentation/git-replay.txt ##
    -@@ Documentation/git-replay.txt: git-replay - Replay commits on a different base, without touching working tree
    +@@ Documentation/git-replay.txt: git-replay - Replay commits on a new base, works on bare repos too
      SYNOPSIS
      --------
      [verse]
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
        struct rev_info revs;
        struct commit *last_commit = NULL;
     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix)
    -   int ret = 0, i;
    +   int ret = 0;
      
        const char * const replay_usage[] = {
     -          N_("git replay (--onto <newbase> | --advance <branch>) <revision-range>..."),
15:  cf8c984877 ! 14:  1160ff54e6 replay: stop assuming replayed branches do not diverge
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
        struct merge_result result;
        struct strset *update_refs = NULL;
     +  kh_oid_map_t *replayed_commits;
    -   int ret = 0, i;
    +   int ret = 0;
      
        const char * const replay_usage[] = {
     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix)


Elijah Newren (14):
  t6429: remove switching aspects of fast-rebase
  replay: introduce new builtin
  replay: start using parse_options API
  replay: die() instead of failing assert()
  replay: introduce pick_regular_commit()
  replay: change rev walking options
  replay: add an important FIXME comment about gpg signing
  replay: remove progress and info output
  replay: remove HEAD related sanity check
  replay: make it a minimal server side command
  replay: use standard revision ranges
  replay: add --advance or 'cherry-pick' mode
  replay: add --contained to rebase contained branches
  replay: stop assuming replayed branches do not diverge

 .gitignore                               |   1 +
 Documentation/git-replay.txt             | 127 +++++++
 Makefile                                 |   2 +-
 builtin.h                                |   1 +
 builtin/replay.c                         | 407 +++++++++++++++++++++++
 command-list.txt                         |   1 +
 git.c                                    |   1 +
 t/helper/test-fast-rebase.c              | 241 --------------
 t/helper/test-tool.c                     |   1 -
 t/helper/test-tool.h                     |   1 -
 t/t3650-replay-basics.sh                 | 198 +++++++++++
 t/t6429-merge-sequence-rename-caching.sh |  45 +--
 12 files changed, 762 insertions(+), 264 deletions(-)
 create mode 100644 Documentation/git-replay.txt
 create mode 100644 builtin/replay.c
 delete mode 100644 t/helper/test-fast-rebase.c
 create mode 100755 t/t3650-replay-basics.sh

-- 
2.42.0.339.g663cbc8ab1


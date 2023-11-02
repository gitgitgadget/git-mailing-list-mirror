Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64CA18E38
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCUghw7u"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3371683
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 06:52:11 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50939d39d0fso1182108e87.1
        for <git@vger.kernel.org>; Thu, 02 Nov 2023 06:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698933128; x=1699537928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBS8RUa13iA0Vbe6zobS5wUt6EMLEpZCA6mvufEu8x0=;
        b=aCUghw7udCFzED5T/BT89bRCf5dwsX5lxnHhq+hyjzvfkYOBT0SaaMzRnzCevtfp3/
         bEnNg8a1RVsARgz3QNrSR4qRLaqaJMMXcoZoygdN8TwAv1ayvAJckXK3h46cM9OW12Sy
         PNOtwB7hHV7LhTCNCGctZ5M95McA4mJwT5QfztMntA112GeZ/8iIvOg4rdP5gZ9aVQpD
         Pc63qR6+WXtZ70Doxi9KICiaG9G9VfRReq7CEJ8Hxh534RiDXo70zNt4VpsAZg6LeYw1
         ZDb0Btc1F9JSc6Lc7Hj4XbixzbjrjQHrvc8za6PeabNo6vYXjyhK0Udl+mPWiY7UJTYO
         n/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698933128; x=1699537928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBS8RUa13iA0Vbe6zobS5wUt6EMLEpZCA6mvufEu8x0=;
        b=FMSKYodxI9q0zKASRXv+v8EhwrCfCYWq+yyvOIezqSXT4r+vzZRCPZx02Ls+OeeN4K
         o5Vearah4+faO9y7iymtvBvTHMLM5cv2JyVoCCDB29FT7y+o+AxWR6UFgOWIbXhkDjS+
         GjV9ZCfzhgLfyVj3dp8YmINjRxQoYfgjqIW5x02c/pgD+KRy9BI42Ug2+I8I/CX6UX18
         nrS6iCgCQ6tOci/XrlgLD52Ylyi01iHwx5qsp5cDn57JlFlbZ5MFdtFZi4kO/+gClpJ/
         mpj08tfS6q8Ydckyq8nV/x8Y4DZIfnhnwkT22y1isSt93107fv6+DKUQ2F6vlU9FLvQw
         DT5Q==
X-Gm-Message-State: AOJu0YwYWCp/cQsqN832Frhs3GDQ4k6j3Pv39gu+suRNo/nr08aQM2kL
	cCUYX1ZuGsyI3M1T7gRcUP20ankLa78=
X-Google-Smtp-Source: AGHT+IF9idXtAQFf4d2G0f4TMg/aY/xqyFhUHshcxBw6Lt2k7aNNk95gIxjLIrNSIeMoHVYlfthJKg==
X-Received: by 2002:a05:6512:2825:b0:503:35bb:1e74 with SMTP id cf37-20020a056512282500b0050335bb1e74mr19645205lfb.61.1698933127361;
        Thu, 02 Nov 2023 06:52:07 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:116d:4e46:313c:1f52:4963:91b6])
        by smtp.gmail.com with ESMTPSA id e6-20020adffc46000000b0030647449730sm2514996wrs.74.2023.11.02.06.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 06:52:06 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Toon Claes <toon@iotcl.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Linus Arver <linusa@google.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 00/14] Introduce new `git replay` command
Date: Thu,  2 Nov 2023 14:51:37 +0100
Message-ID: <20231102135151.843758-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.496.g529a7fda40
In-Reply-To: <20231010123847.2777056-1-christian.couder@gmail.com>
References: <20231010123847.2777056-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

# Intro

`git replay` has initially been developed entirely by Elijah Newren
mostly last year (2022) at:

https://github.com/newren/git/commits/replay

I took over this year to polish and upstream it as GitLab is
interested in replacing libgit2, and for that purpose needs a command
to do server side (so without using a worktree) rebases, cherry-picks
and reverts.

I reduced the number of commits and features in this patch series,
compared to what Elijah already developed. Especially I stopped short
of replaying merge commits and replaying interactively. These and
other features might be upstreamed in the future after this patch
series has graduated.

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
    Since v5, this also introduces stub documentation and tests for
    the new command as suggested by Dscho. Also in the doc,
    "EXPERIMENTAL" has been added both to the name line and the
    synopsis line of the command, which was also suggested by
    Dscho. This required to also change the "usage" message of the
    command.

* - 3/14 replay: start using parse_options API
  - 4/14 replay: die() instead of failing assert()
  - 5/14 replay: introduce pick_regular_commit()
  - 6/14 replay: change rev walking options
  - 7/14 replay: add an important FIXME comment about gpg signing
  - 8/14 replay: remove progress and info output
  - 9/14 replay: remove HEAD related sanity check

    These slowly change the command to make it behave more like
    regular commands and to start cleaning up its output. In patch
    6/14 (replay: change rev walking options) there are some changes
    compared to v5 as suggested by Elijah and Dscho. First we are now
    warning() in case a command line option would change some rev
    options that we are going to override. Second we don't let the
    `--reverse` option change the way the command works.

* 10/14 replay: make it a minimal server side command

    After the cleaning up in previous commits, it's now time to
    radically change the way it works by stopping it to do ref
    updates, to update the index and worktree, to consider HEAD as
    special. Instead just make it output commands that should be
    passed to `git update-ref --stdin`. A few test changes are new in
    this commit since v5.

* 11/14 replay: use standard revision ranges

    Start addind new interesting features and also documentation and
    tests, as the interface of the command is cristalizing into its
    final form. Since v5 this patch is not introducing the
    documentation and the tests of the new command anymore (as they
    are introduced in patch 2/14).

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
as soon as patch 2/14, but they are not much improved since around
11/14 as it doesn't make much sense to document and test behavior that
we know is going to change soon.

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

# Changes between v5 and v6

Thanks to Dscho, Linus Arver and Dragan Simic for their suggestions on
the previous version! The few changes compared to v5 are:

* The patch series was rebased onto master at 2e8e77cbac (The
  twenty-first batch, 2023-10-23). This is to fix small conflicts
  with recently merged series, especially
  cc/repack-sift-filtered-objects-to-separate-pack.

* In patch 2/14 (replay: introduce new builtin), stub documentation
  and tests have been introduced as suggested by Dscho. They were
  introduced later (in patch 11/14) in v5.

* Also in patch 2/14, "EXPERIMENTAL" has been added both to the name
  line and the synopsis line of the command in the doc as suggested by
  Dscho.

* In patch 6/14 (replay: change rev walking options) we are now
  warning() in case a command line option would change some rev
  options that we are going to override. This follows discussions
  between Dscho and Elijah where they agreed that properly taking care
  of handling these command line options should be dealt with later in
  future patch series.

* Also in patch 6/14, we don't let the `--reverse` option change the
  way the command works. This also follows discussions between Dscho
  and Elijah about command line options related to rev walking.

* In patch 9/14 (replay: remove HEAD related sanity check) we can
  simplify a test a bit.

* In patch 10/14 (replay: make it a minimal server side command) we
  can further add tests.

* In patch 11/14 (replay: use standard revision ranges), as
  documentation and tests are not introduced by this commit anymore,
  but earlier by patch 2/14, fewer doc and test changes are made in
  this patch.

CI tests seem to pass according to:

https://github.com/chriscool/git/actions/runs/6732523160/

(A "Run ci/install-dependencies.sh" test on osx-clang initially
failed, but it worked when I just re-ran it. Hopefully this will alow
tests that couldn't be run to proceed and succeed, but I don't want to
wait for that right now.)

# Range-diff between v5 and v6

(Sorry it's very long mostly due to doc and test changes over a number
of patches.)

 1:  72c34a0eba =  1:  fac0a9dff4 t6429: remove switching aspects of fast-rebase
 2:  f85e6c823c !  2:  8a605ddef8 replay: introduce new builtin
    @@ Commit message
         For now, this is just a rename from `t/helper/test-fast-rebase.c` into
         `builtin/replay.c` with minimal changes to make it build appropriately.
     
    +    There is a stub documentation and a stub test script though.
    +
         Subsequent commits will flesh out its capabilities and make it a more
         standard regular builtin.
     
    @@ .gitignore
      /git-rerere
      /git-reset
     
    + ## Documentation/git-replay.txt (new) ##
    +@@
    ++git-replay(1)
    ++=============
    ++
    ++NAME
    ++----
    ++git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos too
    ++
    ++
    ++SYNOPSIS
    ++--------
    ++[verse]
    ++'git replay' --onto <newbase> <revision-range>... # EXPERIMENTAL
    ++
    ++DESCRIPTION
    ++-----------
    ++
    ++Takes a range of commits and replays them onto a new location.
    ++
    ++THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
    ++
    ++OPTIONS
    ++-------
    ++
    ++--onto <newbase>::
    ++  Starting point at which to create the new commits.  May be any
    ++  valid commit, and not just an existing branch name.
    ++
    ++EXIT STATUS
    ++-----------
    ++
    ++For a successful, non-conflicted replay, the exit status is 0.  When
    ++the replay has conflicts, the exit status is 1.  If the replay is not
    ++able to complete (or start) due to some kind of error, the exit status
    ++is something other than 0 or 1.
    ++
    ++GIT
    ++---
    ++Part of the linkgit:git[1] suite
    +
      ## Makefile ##
     @@ Makefile: TEST_BUILTINS_OBJS += test-dump-split-index.o
      TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
      TEST_BUILTINS_OBJS += test-env-helper.o
      TEST_BUILTINS_OBJS += test-example-decorate.o
     -TEST_BUILTINS_OBJS += test-fast-rebase.o
    + TEST_BUILTINS_OBJS += test-find-pack.o
      TEST_BUILTINS_OBJS += test-fsmonitor-client.o
      TEST_BUILTINS_OBJS += test-genrandom.o
    - TEST_BUILTINS_OBJS += test-genzeros.o
     @@ Makefile: BUILTIN_OBJS += builtin/remote-fd.o
      BUILTIN_OBJS += builtin/remote.o
      BUILTIN_OBJS += builtin/repack.o
    @@ t/helper/test-tool.c: static struct test_cmd cmds[] = {
        { "env-helper", cmd__env_helper },
        { "example-decorate", cmd__example_decorate },
     -  { "fast-rebase", cmd__fast_rebase },
    +   { "find-pack", cmd__find_pack },
        { "fsmonitor-client", cmd__fsmonitor_client },
        { "genrandom", cmd__genrandom },
    -   { "genzeros", cmd__genzeros },
     
      ## t/helper/test-tool.h ##
     @@ t/helper/test-tool.h: int cmd__dump_untracked_cache(int argc, const char **argv);
    @@ t/helper/test-tool.h: int cmd__dump_untracked_cache(int argc, const char **argv)
      int cmd__env_helper(int argc, const char **argv);
      int cmd__example_decorate(int argc, const char **argv);
     -int cmd__fast_rebase(int argc, const char **argv);
    + int cmd__find_pack(int argc, const char **argv);
      int cmd__fsmonitor_client(int argc, const char **argv);
      int cmd__genrandom(int argc, const char **argv);
    - int cmd__genzeros(int argc, const char **argv);
    +
    + ## t/t3650-replay-basics.sh (new) ##
    +@@
    ++#!/bin/sh
    ++
    ++test_description='basic git replay tests'
    ++
    ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    ++export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    ++
    ++. ./test-lib.sh
    ++
    ++GIT_AUTHOR_NAME=author@name
    ++GIT_AUTHOR_EMAIL=bogus@email@address
    ++export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
    ++
    ++test_expect_success 'setup' '
    ++  test_commit A &&
    ++  test_commit B &&
    ++
    ++  git switch -c topic1 &&
    ++  test_commit C &&
    ++  git switch -c topic2 &&
    ++  test_commit D &&
    ++  test_commit E &&
    ++  git switch topic1 &&
    ++  test_commit F &&
    ++  git switch -c topic3 &&
    ++  test_commit G &&
    ++  test_commit H &&
    ++  git switch -c topic4 main &&
    ++  test_commit I &&
    ++  test_commit J &&
    ++
    ++  git switch -c next main &&
    ++  test_commit K &&
    ++  git merge -m "Merge topic1" topic1 &&
    ++  git merge -m "Merge topic2" topic2 &&
    ++  git merge -m "Merge topic3" topic3 &&
    ++  >evil &&
    ++  git add evil &&
    ++  git commit --amend &&
    ++  git merge -m "Merge topic4" topic4 &&
    ++
    ++  git switch main &&
    ++  test_commit L &&
    ++  test_commit M &&
    ++
    ++  git switch -c conflict B &&
    ++  test_commit C.conflict C.t conflict
    ++'
    ++
    ++test_expect_success 'using replay to rebase two branches, one on top of other' '
    ++  git switch main &&
    ++
    ++  git replay --onto main topic1 topic2 >result &&
    ++
    ++  git log --format=%s $(cut -f 3 -d " " result) >actual &&
    ++  test_write_lines E D M L B A >expect &&
    ++  test_cmp expect actual
    ++'
    ++
    ++test_done
     
      ## t/t6429-merge-sequence-rename-caching.sh ##
     @@ t/t6429-merge-sequence-rename-caching.sh: test_expect_success 'caching renames does not preclude finding new ones' '
 3:  11abb9d120 =  3:  a7886952b7 replay: start using parse_options API
 4:  9e568eae84 =  4:  bab0286f0a replay: die() instead of failing assert()
 5:  e7ebf3c5ef =  5:  469e95e5bf replay: introduce pick_regular_commit()
 6:  37d545d5d6 !  6:  edafe4846f replay: change rev walking options
    @@ Commit message
     
         Let's set the rev walking options we need after calling
         setup_revisions() instead of before. This enforces options we always
    -    want.
    -
    -    We want the command to work from older commits to newer ones by default,
    -    but we are Ok with letting users reverse that, using --reverse, if that's
    -    what they really want.
    +    want for now.
     
    +    We want the command to work from older commits to newer ones by default.
         Also we don't want history simplification, as we want to deal with all
         the commits in the affected range.
     
    +    When we see an option that we are going to override, we emit a warning
    +    to avoid confusion as much as possible though.
    +
         Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    @@ Commit message
     
      ## builtin/replay.c ##
     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix)
    +   struct merge_result result;
    +   struct strbuf reflog_msg = STRBUF_INIT;
    +   struct strbuf branch_name = STRBUF_INIT;
    +-  int ret = 0;
    ++  int i, ret = 0;
    + 
    +   const char * const replay_usage[] = {
    +           N_("git replay --onto <newbase> <oldbase> <branch>"),
    +@@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix)
      
        repo_init_revisions(the_repository, &revs, prefix);
      
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
     -
        strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
      
    ++  /*
    ++   * TODO: For now, let's warn when we see an option that we are
    ++   * going to override after setup_revisions() below. In the
    ++   * future we might want to either die() or allow them if we
    ++   * think they could be useful though.
    ++   */
    ++  for (i = 0; i < argc; i++) {
    ++          if (!strcmp(argv[i], "--reverse") || !strcmp(argv[i], "--date-order") ||
    ++              !strcmp(argv[i], "--topo-order") || !strcmp(argv[i], "--author-date-order") ||
    ++              !strcmp(argv[i], "--full-history"))
    ++                  warning(_("option '%s' will be overridden"), argv[i]);
    ++  }
    ++
        if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1) {
    -@@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix)
    +           ret = error(_("unhandled options"));
                goto cleanup;
        }
      
     +  /* requirements/overrides for revs */
    -+  revs.reverse = !revs.reverse;
    ++  revs.reverse = 1;
     +  revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
     +  revs.topo_order = 1;
     +  revs.simplify_history = 0;
 7:  2943f08926 =  7:  b81574744a replay: add an important FIXME comment about gpg signing
 8:  f81962ba41 =  8:  b08ad2b2f1 replay: remove progress and info output
 9:  236747497e !  9:  5099c94d2e replay: remove HEAD related sanity check
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
                               REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
                        error(_("could not update %s"), argv[2]);
                        die("Failed to update %s", argv[2]);
    +
    + ## t/t3650-replay-basics.sh ##
    +@@ t/t3650-replay-basics.sh: test_expect_success 'setup' '
    + '
    + 
    + test_expect_success 'using replay to rebase two branches, one on top of other' '
    +-  git switch main &&
    +-
    +   git replay --onto main topic1 topic2 >result &&
    + 
    +   git log --format=%s $(cut -f 3 -d " " result) >actual &&
10:  3374d5be23 ! 10:  b4a5d1edd4 replay: make it a minimal server side command
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
        struct merge_result result;
     -  struct strbuf reflog_msg = STRBUF_INIT;
        struct strbuf branch_name = STRBUF_INIT;
    -   int ret = 0;
    +   int i, ret = 0;
      
     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix)
        onto = peel_committish(onto_name);
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
     +  return ret ? 0 : 1;
      }
     
    + ## t/t3650-replay-basics.sh ##
    +@@ t/t3650-replay-basics.sh: test_expect_success 'setup' '
    +   test_commit C.conflict C.t conflict
    + '
    + 
    ++test_expect_success 'setup bare' '
    ++  git clone --bare . bare
    ++'
    ++
    + test_expect_success 'using replay to rebase two branches, one on top of other' '
    +   git replay --onto main topic1 topic2 >result &&
    + 
    ++  test_line_count = 1 result &&
    ++
    +   git log --format=%s $(cut -f 3 -d " " result) >actual &&
    +   test_write_lines E D M L B A >expect &&
    +-  test_cmp expect actual
    ++  test_cmp expect actual &&
    ++
    ++  printf "update refs/heads/topic2 " >expect &&
    ++  printf "%s " $(cut -f 3 -d " " result) >>expect &&
    ++  git rev-parse topic2 >>expect &&
    ++
    ++  test_cmp expect result
    ++'
    ++
    ++test_expect_success 'using replay on bare repo to rebase two branches, one on top of other' '
    ++  git -C bare replay --onto main topic1 topic2 >result-bare &&
    ++  test_cmp expect result-bare
    + '
    + 
    + test_done
    +
      ## t/t6429-merge-sequence-rename-caching.sh ##
     @@ t/t6429-merge-sequence-rename-caching.sh: test_expect_success 'caching renames does not preclude finding new ones' '
      
11:  197d076a93 ! 11:  1d8a6ef432 replay: use standard revision ranges
    @@ Commit message
         history, as they could be confusing for most users.
     
         Also as the interface of the command is now mostly finalized,
    -    we can add some documentation as well as testcases to make sure
    +    we can add more documentation and more testcases to make sure
         the command will continue to work as designed in the future.
     
         We only document the rev-list related options among all the
    @@ Commit message
         Signed-off-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    - ## Documentation/git-replay.txt (new) ##
    -@@
    -+git-replay(1)
    -+=============
    -+
    -+NAME
    -+----
    -+git-replay - Replay commits on a new base, works on bare repos too
    -+
    -+
    -+SYNOPSIS
    -+--------
    -+[verse]
    -+'git replay' --onto <newbase> <revision-range>...
    -+
    -+DESCRIPTION
    -+-----------
    -+
    + ## Documentation/git-replay.txt ##
    +@@ Documentation/git-replay.txt: SYNOPSIS
    + DESCRIPTION
    + -----------
    + 
    +-Takes a range of commits and replays them onto a new location.
     +Takes a range of commits and replays them onto a new location. Leaves
     +the working tree and the index untouched, and updates no
     +references. The output of this command is meant to be used as input to
     +`git update-ref --stdin`, which would update the relevant branches
     +(see the OUTPUT section below).
    -+
    -+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
    -+
    -+OPTIONS
    -+-------
    -+
    -+--onto <newbase>::
    -+  Starting point at which to create the new commits.  May be any
    -+  valid commit, and not just an existing branch name.
    + 
    + THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
    + 
    +@@ Documentation/git-replay.txt: OPTIONS
    + --onto <newbase>::
    +   Starting point at which to create the new commits.  May be any
    +   valid commit, and not just an existing branch name.
     ++
     +The update-ref command(s) in the output will update the branch(es) in
     +the revision range to point at the new commits, similar to the way how
    @@ Documentation/git-replay.txt (new)
     +
     +where the number of refs updated depends on the arguments passed and
     +the shape of the history being replayed.
    -+
    -+EXIT STATUS
    -+-----------
    -+
    -+For a successful, non-conflicted replay, the exit status is 0.  When
    -+the replay has conflicts, the exit status is 1.  If the replay is not
    -+able to complete (or start) due to some kind of error, the exit status
    -+is something other than 0 or 1.
    -+
    + 
    + EXIT STATUS
    + -----------
    +@@ Documentation/git-replay.txt: the replay has conflicts, the exit status is 1.  If the replay is not
    + able to complete (or start) due to some kind of error, the exit status
    + is something other than 0 or 1.
    + 
     +EXAMPLES
     +--------
     +
    @@ Documentation/git-replay.txt (new)
     +`origin/main`. These three branches may have commits on top of `base`
     +that they have in common, but that does not need to be the case.
     +
    -+GIT
    -+---
    -+Part of the linkgit:git[1] suite
    + GIT
    + ---
    + Part of the linkgit:git[1] suite
     
      ## builtin/replay.c ##
     @@
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
        struct merge_options merge_opt;
        struct merge_result result;
     -  struct strbuf branch_name = STRBUF_INIT;
    -   int ret = 0;
    +   int i, ret = 0;
      
        const char * const replay_usage[] = {
     -          N_("git replay --onto <newbase> <oldbase> <branch>"),
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
      
     -  strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
     -
    +   /*
    +    * TODO: For now, let's warn when we see an option that we are
    +    * going to override after setup_revisions() below. In the
    +@@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix)
    +                   warning(_("option '%s' will be overridden"), argv[i]);
    +   }
    + 
     -  if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1) {
     -          ret = error(_("unhandled options"));
     +  argc = setup_revisions(argc, argv, &revs, NULL);
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
      
        /* Return */
     
    - ## t/t3650-replay-basics.sh (new) ##
    -@@
    -+#!/bin/sh
    -+
    -+test_description='basic git replay tests'
    -+
    -+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    -+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    -+
    -+. ./test-lib.sh
    -+
    -+GIT_AUTHOR_NAME=author@name
    -+GIT_AUTHOR_EMAIL=bogus@email@address
    -+export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
    -+
    -+test_expect_success 'setup' '
    -+  test_commit A &&
    -+  test_commit B &&
    -+
    -+  git switch -c topic1 &&
    -+  test_commit C &&
    -+  git switch -c topic2 &&
    -+  test_commit D &&
    -+  test_commit E &&
    -+  git switch topic1 &&
    -+  test_commit F &&
    -+  git switch -c topic3 &&
    -+  test_commit G &&
    -+  test_commit H &&
    -+  git switch -c topic4 main &&
    -+  test_commit I &&
    -+  test_commit J &&
    -+
    -+  git switch -c next main &&
    -+  test_commit K &&
    -+  git merge -m "Merge topic1" topic1 &&
    -+  git merge -m "Merge topic2" topic2 &&
    -+  git merge -m "Merge topic3" topic3 &&
    -+  >evil &&
    -+  git add evil &&
    -+  git commit --amend &&
    -+  git merge -m "Merge topic4" topic4 &&
    -+
    -+  git switch main &&
    -+  test_commit L &&
    -+  test_commit M &&
    -+
    -+  git switch -c conflict B &&
    -+  test_commit C.conflict C.t conflict
    -+'
    -+
    -+test_expect_success 'setup bare' '
    -+  git clone --bare . bare
    -+'
    -+
    -+test_expect_success 'using replay to rebase two branches, one on top of other' '
    + ## t/t3650-replay-basics.sh ##
    +@@ t/t3650-replay-basics.sh: test_expect_success 'setup bare' '
    + '
    + 
    + test_expect_success 'using replay to rebase two branches, one on top of other' '
    +-  git replay --onto main topic1 topic2 >result &&
     +  git replay --onto main topic1..topic2 >result &&
    -+
    -+  test_line_count = 1 result &&
    -+
    -+  git log --format=%s $(cut -f 3 -d " " result) >actual &&
    -+  test_write_lines E D M L B A >expect &&
    -+  test_cmp expect actual &&
    -+
    -+  printf "update refs/heads/topic2 " >expect &&
    -+  printf "%s " $(cut -f 3 -d " " result) >>expect &&
    -+  git rev-parse topic2 >>expect &&
    -+
    -+  test_cmp expect result
    -+'
    -+
    -+test_expect_success 'using replay on bare repo to rebase two branches, one on top of other' '
    + 
    +   test_line_count = 1 result &&
    + 
    +@@ t/t3650-replay-basics.sh: test_expect_success 'using replay to rebase two branches, one on top of other' '
    + '
    + 
    + test_expect_success 'using replay on bare repo to rebase two branches, one on top of other' '
    +-  git -C bare replay --onto main topic1 topic2 >result-bare &&
     +  git -C bare replay --onto main topic1..topic2 >result-bare &&
    -+  test_cmp expect result-bare
    -+'
    -+
    +   test_cmp expect result-bare
    + '
    + 
     +test_expect_success 'using replay to rebase with a conflict' '
     +  test_expect_code 1 git replay --onto topic1 B..conflict
     +'
    @@ t/t3650-replay-basics.sh (new)
     +  test_expect_code 1 git -C bare replay --onto topic1 B..conflict
     +'
     +
    -+test_done
    + test_done
     
      ## t/t6429-merge-sequence-rename-caching.sh ##
     @@ t/t6429-merge-sequence-rename-caching.sh: test_expect_success 'caching renames does not preclude finding new ones' '
12:  e52d8b961c ! 12:  3a207e5d7f replay: add --advance or 'cherry-pick' mode
    @@ Commit message
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## Documentation/git-replay.txt ##
    -@@ Documentation/git-replay.txt: git-replay - Replay commits on a new base, works on bare repos too
    +@@ Documentation/git-replay.txt: git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
      SYNOPSIS
      --------
      [verse]
    --'git replay' --onto <newbase> <revision-range>...
    -+'git replay' (--onto <newbase> | --advance <branch>) <revision-range>...
    +-'git replay' --onto <newbase> <revision-range>... # EXPERIMENTAL
    ++'git replay' (--onto <newbase> | --advance <branch>) <revision-range>... # EXPERIMENTAL
      
      DESCRIPTION
      -----------
    @@ builtin/replay.c: static struct commit *pick_regular_commit(struct commit *pickm
        struct merge_options merge_opt;
        struct merge_result result;
     +  struct strset *update_refs = NULL;
    -   int ret = 0;
    +   int i, ret = 0;
      
        const char * const replay_usage[] = {
     -          N_("git replay --onto <newbase> <revision-range>..."),
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
     -
        repo_init_revisions(the_repository, &revs, prefix);
      
    -   argc = setup_revisions(argc, argv, &revs, NULL);
    +   /*
     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix)
        revs.topo_order = 1;
        revs.simplify_history = 0;
13:  fc79a930b5 ! 13:  23a164196b replay: add --contained to rebase contained branches
    @@ Commit message
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## Documentation/git-replay.txt ##
    -@@ Documentation/git-replay.txt: git-replay - Replay commits on a new base, works on bare repos too
    +@@ Documentation/git-replay.txt: git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
      SYNOPSIS
      --------
      [verse]
    --'git replay' (--onto <newbase> | --advance <branch>) <revision-range>...
    -+'git replay' ([--contained] --onto <newbase> | --advance <branch>) <revision-range>...
    +-'git replay' (--onto <newbase> | --advance <branch>) <revision-range>... # EXPERIMENTAL
    ++'git replay' ([--contained] --onto <newbase> | --advance <branch>) <revision-range>... # EXPERIMENTAL
      
      DESCRIPTION
      -----------
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
        struct rev_info revs;
        struct commit *last_commit = NULL;
     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix)
    -   int ret = 0;
    +   int i, ret = 0;
      
        const char * const replay_usage[] = {
     -          N_("git replay (--onto <newbase> | --advance <branch>) <revision-range>..."),
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
     +
        repo_init_revisions(the_repository, &revs, prefix);
      
    -   argc = setup_revisions(argc, argv, &revs, NULL);
    +   /*
     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix)
                        continue;
                while (decoration) {
14:  1160ff54e6 ! 14:  5c4b15cccd replay: stop assuming replayed branches do not diverge
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
        struct merge_result result;
        struct strset *update_refs = NULL;
     +  kh_oid_map_t *replayed_commits;
    -   int ret = 0;
    +   int i, ret = 0;
      
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
 builtin/replay.c                         | 421 +++++++++++++++++++++++
 command-list.txt                         |   1 +
 git.c                                    |   1 +
 t/helper/test-fast-rebase.c              | 241 -------------
 t/helper/test-tool.c                     |   1 -
 t/helper/test-tool.h                     |   1 -
 t/t3650-replay-basics.sh                 | 198 +++++++++++
 t/t6429-merge-sequence-rename-caching.sh |  45 +--
 12 files changed, 776 insertions(+), 264 deletions(-)
 create mode 100644 Documentation/git-replay.txt
 create mode 100644 builtin/replay.c
 delete mode 100644 t/helper/test-fast-rebase.c
 create mode 100755 t/t3650-replay-basics.sh


base-commit: 2e8e77cbac8ac17f94eee2087187fa1718e38b14
-- 
2.42.0.496.g529a7fda40


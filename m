Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3PveVME"
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947E6D71
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:03 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507b9408c61so2476021e87.0
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700824261; x=1701429061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r69lJwO7KG64T3jn2OkMZHl/SGuvUMbKj7l+uiY6/Nk=;
        b=h3PveVME83KEuulFT5kTtVMNIH/0MU/mo7vjANLOsGjfxUNDNFmGsVsaWYAX5RsTdU
         xplc7kQQcMFnFiRD86mKWgf0ZIneUzkUq3cFBSesBWy8hDBXauVGOpnMj7/w6GqvA/xV
         aSss8EU55WeRohrZ45BkuXN9BRRaEItu/o280D6SU7mnqVDJlfGnZ8mA87Cx6y8qz+2y
         IyOhK+WWUaTyqd4juEoR9e+OW4nzCTunxoJ04p5WmFWCUlKRS8f5PZQyeAuakktnC8Yk
         M/rqv0Qh9FQjd8yHAd2TObT1s2BtImdNYbmkyxx7P7YFnbWnir0PKj0KdI0/34mFUb3m
         Vqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700824261; x=1701429061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r69lJwO7KG64T3jn2OkMZHl/SGuvUMbKj7l+uiY6/Nk=;
        b=JSUpfqMpFz0YDG980wRhqfFRWyLGvYPX+b+5EojqkbgtfRab2pRplMno1KiVDPB3o7
         9VClCNwBW7NcIt16A25m88JKqoUltieIC0Oi6klB1kwpQm8vyh2lpVGT67RXbditIJeY
         w7y2b5u0ZvmzbvIq+qRbQnuQIcMQRolcpuOyOlv1mSapG23SbmWYSzeiu/wH4pUaTUcV
         r8DR+IHq5vO7U5VjHsdhqHa/594RObl4I0AqnZx4NWdVE/Hmq4d7T3L/88ZLnwoZwfJv
         76DfYGx0i9X2h48KH2UkrDEbHv+IEEXjLc5Fw+bF3MlL36LSY8xCkDJ9czYUN00F4CKv
         jwWQ==
X-Gm-Message-State: AOJu0Yw766SlOFO7qNOwrVfpkj6wfD59SOUHBaxQzNQGjzSGoYHDvkzc
	9Xg32xcDyx8K8tS4svAp0bbL4Z9PvZM=
X-Google-Smtp-Source: AGHT+IHWCi2kI332K4+Rsij2czO1il9EuMTahwSfh3RboOrPYat5nl+i/Gx6szuW9gaofs6LeukrpA==
X-Received: by 2002:a05:6512:31cb:b0:50b:a690:953f with SMTP id j11-20020a05651231cb00b0050ba690953fmr92533lfe.18.1700824260816;
        Fri, 24 Nov 2023 03:11:00 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:c06d:3245:2b4d:9ec5])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c458400b0040648217f4fsm5390295wmo.39.2023.11.24.03.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:11:00 -0800 (PST)
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
Subject: [PATCH v8 00/14] Introduce new `git replay` command
Date: Fri, 24 Nov 2023 12:10:29 +0100
Message-ID: <20231124111044.3426007-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.14.g93e034faee
In-Reply-To: <20231115143327.2441397-1-christian.couder@gmail.com>
References: <20231115143327.2441397-1-christian.couder@gmail.com>
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
    Since v7, there is only a synopsys change in the doc, and the
    corresponding usage message change, as suggested by Dscho.

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

    Start adding new interesting features and also documentation and
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

# Changes between v7 and v8

Thanks to Dscho, Linus Arver, Dragan Simic, Elijah, Junio, Derrick
Stolee, Phillip Wood, Calvin Wan and Toon Claes for their suggestions
on the previous versions! The only few changes compared to v7 are:

* The patch series was rebased onto master at 564d0252ca (Git 2.43,
  2023-11-20). This is to make it stand on a stable base.

* In patch 2/14 (replay: introduce new builtin), there is a synopsys
  change in the doc, and the corresponding usage message change as
  suggested by Dscho. This is just about replacing " # EXPERIMENTAL"
  at the end of both the synopsys and usage message with
  "(EXPERIMENTAL!) " at the beginning of them.

CI tests seem to pass according to:

https://github.com/chriscool/git/actions/runs/6979770154

(Sorry I am not waiting more than 20 minutes for the 3 last ones to
finish.)

# Range-diff between v7 and v8

(A single change was made in patch 2/14, but unfortunately as the
lines changed in that patch are also changed by other patches later,
it looks like there are more changes in subsequent patches.)


 1:  cddcd967b2 =  1:  18fd9b0d5d t6429: remove switching aspects of fast-rebase
 2:  c8476fb093 !  2:  fc6bdf4de4 replay: introduce new builtin
    @@ Documentation/git-replay.txt (new)
     +SYNOPSIS
     +--------
     +[verse]
    -+'git replay' --onto <newbase> <oldbase> <branch> # EXPERIMENTAL
    ++(EXPERIMENTAL!) 'git replay' --onto <newbase> <oldbase> <branch>
     +
     +DESCRIPTION
     +-----------
    @@ builtin/replay.c: int cmd__fast_rebase(int argc, const char **argv)
     -
        if (argc == 2 && !strcmp(argv[1], "-h")) {
     -          printf("Sorry, I am not a psychiatrist; I can not give you the help you need.  Oh, you meant usage...\n");
    -+          printf("git replay --onto <newbase> <oldbase> <branch> # EXPERIMENTAL\n");
    ++          printf("usage: (EXPERIMENTAL!) git replay --onto <newbase> <oldbase> <branch>\n");
                exit(129);
        }
      
 3:  43322abd1e !  3:  e96a66c352 replay: start using parse_options API
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
        int ret = 0;
      
     -  if (argc == 2 && !strcmp(argv[1], "-h")) {
    --          printf("git replay --onto <newbase> <oldbase> <branch> # EXPERIMENTAL\n");
    +-          printf("usage: (EXPERIMENTAL!) git replay --onto <newbase> <oldbase> <branch>\n");
     -          exit(129);
     +  const char * const replay_usage[] = {
    -+          N_("git replay --onto <newbase> <oldbase> <branch> # EXPERIMENTAL"),
    ++          N_("(EXPERIMENTAL!) git replay --onto <newbase> <oldbase> <branch>"),
     +          NULL
     +  };
     +  struct option replay_options[] = {
 4:  6524c7f045 =  4:  f819d283d9 replay: die() instead of failing assert()
 5:  05d0efa3cb =  5:  68bbcf9492 replay: introduce pick_regular_commit()
 6:  c7a5aad3d6 =  6:  72221c647e replay: change rev walking options
 7:  01f35f924b =  7:  f54d8fce22 replay: add an important FIXME comment about gpg signing
 8:  1498b24bad =  8:  e50cc22522 replay: remove progress and info output
 9:  6786fc147b =  9:  0c5ea3d18e replay: remove HEAD related sanity check
10:  9a24dbb530 = 10:  9fc636fc3d replay: make it a minimal server side command
11:  ad6ca2fbef ! 11:  2096bcad79 replay: use standard revision ranges
    @@ Documentation/git-replay.txt: git-replay - EXPERIMENTAL: Replay commits on a new
      SYNOPSIS
      --------
      [verse]
    --'git replay' --onto <newbase> <oldbase> <branch> # EXPERIMENTAL
    -+'git replay' --onto <newbase> <revision-range>... # EXPERIMENTAL
    +-(EXPERIMENTAL!) 'git replay' --onto <newbase> <oldbase> <branch>
    ++(EXPERIMENTAL!) 'git replay' --onto <newbase> <revision-range>...
      
      DESCRIPTION
      -----------
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
        int ret = 0;
      
        const char * const replay_usage[] = {
    --          N_("git replay --onto <newbase> <oldbase> <branch> # EXPERIMENTAL"),
    -+          N_("git replay --onto <newbase> <revision-range>... # EXPERIMENTAL"),
    +-          N_("(EXPERIMENTAL!) git replay --onto <newbase> <oldbase> <branch>"),
    ++          N_("(EXPERIMENTAL!) git replay --onto <newbase> <revision-range>..."),
                NULL
        };
        struct option replay_options[] = {
12:  081864ed5f ! 12:  d5414806ef replay: add --advance or 'cherry-pick' mode
    @@ Documentation/git-replay.txt: git-replay - EXPERIMENTAL: Replay commits on a new
      SYNOPSIS
      --------
      [verse]
    --'git replay' --onto <newbase> <revision-range>... # EXPERIMENTAL
    -+'git replay' (--onto <newbase> | --advance <branch>) <revision-range>... # EXPERIMENTAL
    +-(EXPERIMENTAL!) 'git replay' --onto <newbase> <revision-range>...
    ++(EXPERIMENTAL!) 'git replay' (--onto <newbase> | --advance <branch>) <revision-range>...
      
      DESCRIPTION
      -----------
    @@ builtin/replay.c: static struct commit *pick_regular_commit(struct commit *pickm
        int ret = 0;
      
        const char * const replay_usage[] = {
    --          N_("git replay --onto <newbase> <revision-range>... # EXPERIMENTAL"),
    -+          N_("git replay (--onto <newbase> | --advance <branch>) <revision-range>... # EXPERIMENTAL"),
    +-          N_("(EXPERIMENTAL!) git replay --onto <newbase> <revision-range>..."),
    ++          N_("(EXPERIMENTAL!) git replay (--onto <newbase> | --advance <branch>) <revision-range>..."),
                NULL
        };
        struct option replay_options[] = {
13:  19c4016c7c ! 13:  2a3e521c13 replay: add --contained to rebase contained branches
    @@ Documentation/git-replay.txt: git-replay - EXPERIMENTAL: Replay commits on a new
      SYNOPSIS
      --------
      [verse]
    --'git replay' (--onto <newbase> | --advance <branch>) <revision-range>... # EXPERIMENTAL
    -+'git replay' ([--contained] --onto <newbase> | --advance <branch>) <revision-range>... # EXPERIMENTAL
    +-(EXPERIMENTAL!) 'git replay' (--onto <newbase> | --advance <branch>) <revision-range>...
    ++(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) <revision-range>...
      
      DESCRIPTION
      -----------
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
        int ret = 0;
      
        const char * const replay_usage[] = {
    --          N_("git replay (--onto <newbase> | --advance <branch>) <revision-range>... # EXPERIMENTAL"),
    -+          N_("git replay ([--contained] --onto <newbase> | --advance <branch>) "
    -+             "<revision-range>... # EXPERIMENTAL"),
    +-          N_("(EXPERIMENTAL!) git replay (--onto <newbase> | --advance <branch>) <revision-range>..."),
    ++          N_("(EXPERIMENTAL!) git replay "
    ++             "([--contained] --onto <newbase> | --advance <branch>) "
    ++             "<revision-range>..."),
                NULL
        };
        struct option replay_options[] = {
14:  29556bcc86 = 14:  93e034faee replay: stop assuming replayed branches do not diverge


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
 builtin/replay.c                         | 446 +++++++++++++++++++++++
 command-list.txt                         |   1 +
 git.c                                    |   1 +
 t/helper/test-fast-rebase.c              | 241 ------------
 t/helper/test-tool.c                     |   1 -
 t/helper/test-tool.h                     |   1 -
 t/t3650-replay-basics.sh                 | 198 ++++++++++
 t/t6429-merge-sequence-rename-caching.sh |  45 ++-
 12 files changed, 801 insertions(+), 264 deletions(-)
 create mode 100644 Documentation/git-replay.txt
 create mode 100644 builtin/replay.c
 delete mode 100644 t/helper/test-fast-rebase.c
 create mode 100755 t/t3650-replay-basics.sh


base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
-- 
2.43.0.14.g93e034faee


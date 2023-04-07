Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2047C6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 07:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjDGHZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 03:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjDGHZE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 03:25:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16065AD05
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 00:24:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m2so41609669wrh.6
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 00:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680852282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b3/wuSKEjo0HW1vbiLw79QhWLVep1oOrOgYUOKjSdlc=;
        b=pS0KZo4e9LRd9PK1uI+/HQfdTcgizb61QrPum/f0BS6GV9knIvF2NK/AxJ/ok1USP8
         hudAVAXh+Aq1729v81hPiQaBizBD2WzZqsegb1aJOJjrW9H2VkncaRFdRjj0rYxRKwsO
         lyLEU0KMLsSUrFqLfvOpoQUXFluGqZq4sFqDboBsmBT8PoM25Lp7pa4w/ZstBpAWEyN5
         MgDH603EkECUwegaZ7w42TPRhWwVuNI+Qbg9yXw1SPz8esU6PEwqG5rMhMl70t26DfPg
         MLGw4fszavw4KYF1fR5AzO0ugoGJIgpKxs/OWmnRjFjNjtoSSnzqJpp/VQAtdzlNfG56
         ZJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680852282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3/wuSKEjo0HW1vbiLw79QhWLVep1oOrOgYUOKjSdlc=;
        b=5Gp24TtVSk7c7897N7mzh99hFNdBB1TN4dGY+jTZLE62I3e4qdOAOl37Ido5SkDPo4
         n4hDCZZfc9GxJdmdM72gbTG432E3keeKExTnDYe9OGCCGdjxJiU12CRjPD1YMRHMa9YX
         qlbDG+ZyeHb6GGbOQCORMAuMlpzEZiUPpgR6xlmoTSKIaU73Uq72yMQbSesQsEGUwSbl
         P+JbDFeJZDBxhMo58zQj16fYTZNTjUHZCBAtq1lFQEFcFbizqH83W4uc5g6tOGmz41Z0
         ueBjNHmwK13zU/lMAYsBmpVtc7dr8WVCb8thQxm4Jelf86oEb1tTqQespD6YUsU8tQUX
         eVcw==
X-Gm-Message-State: AAQBX9cum/60xQZVOIAKMvie/+xQy0GJ/M8EfQDE38bflsBdGNwPpM2O
        79Oz++32dMp1nuqzu0e1eCkE9vk01fxBQA==
X-Google-Smtp-Source: AKy350YkPtU5pnkNBNKd520gsB2sK8ooJKi0EE/K+C7kVqZ1EFZTRRN5k0zd3bnDrQkgI5XNAuG3rQ==
X-Received: by 2002:a5d:540c:0:b0:2ee:d53b:d9f1 with SMTP id g12-20020a5d540c000000b002eed53bd9f1mr700731wrv.9.1680852281842;
        Fri, 07 Apr 2023 00:24:41 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:90e:3fb7:fec2:981])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002da1261aa44sm3782761wrw.48.2023.04.07.00.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 00:24:41 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 00/14] Introduce new `git replay` command 
Date:   Fri,  7 Apr 2023 09:24:01 +0200
Message-Id: <20230407072415.1360068-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.0.228.gb2eb5bb98e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# Intro

`git replay` has initially been developed entirely by Elijah Newren
mostly between June and July 2022 at:

https://github.com/newren/git/commits/replay

I took over a few months ago to polish and upstream it as GitLab is
interested in replacing libgit2, and for that purpose needs a command
to do server side (so without using a worktree) rebases, cherry-picks
and reverts.

I reduced the number of commits and features in this first patch
series, compared to what Elijah already developed. Especially I
stopped short of replaying merge commits and replaying
interactively. These and other features might be upstreamed in the
future after this patch series has graduated.

Thanks to Elijah, Patrick Steinhardt and Dscho for early reviews and
discussions.

Based on ae73b2c8f1 (The seventh batch, 2023-04-04)

# Quick Overview (from Elijah)

`git replay`, at a basic level, can perhaps be thought of as a
"default-to-dry-run rebase" -- meaning no updates to the working tree,
or to the index, or to any references.  However, it differs from
rebase in that it:

  * Works for branches that aren't checked out
  * Works in a bare repository
  * Can replay multiple branches simultaneously (with or without common
    history in the range being replayed)
  * Preserves relative topology by default (merges are replayed too)
  * Focuses on performance
  * Has several altered defaults as a result of the above

I sometimes think of `git replay` as "fast-replay", a patch-based
analogue to the snapshot-based fast-export & fast-import tools.

# Reasons for diverging from cherry-pick & rebase (from Elijah)

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
    same hooks are called that old scripted implementations would
    have called.

  * "Dry run" behavior, where there are no updates to worktree, index,
    or even refs might be important.

  * Should not assume users only want to operate on HEAD (see next
    section)

* Decapitate HEAD-centric assumptions

  * cherry-pick forces commits to be played on top of HEAD; inflexible.

  * rebase assumes the range of commits to be replayed is
    upstream..HEAD by default, though it allows one to replay
    upstream..otherbranch -- but it still forcibly and needlessly
    checks out otherbranch before starting to replay things.

  * Assuming HEAD is involved severely limits replaying multiple
    (possibly divergent) branches.

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

    * avoid updating working tree, index, refs, reflogs, and control
      structures except when needed (e.g. hitting a conflict, or operation
      finished)

  * Other performance ideas:

    * single-file control structures instead of directory of files

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
      working tree.  (See below as well)

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
    hit a conflict, we should have a way to resolve the conflict without
    messing with the user's work on their current branch.

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

* The code die()s if there are any conflict. No resumability. No nice
  output. No interactivity.

* No replaying merges, nor root commits. Only regular commits.

* Signed commits are not properly handled. It's not clear what to do
  to such commits when replaying on the server side.

# Commit overview

* 1/14 replay: introduce new builtin

     This creates a minimal `git replay` command by moving the code
     from the `fast-rebase` test helper from `t/helper/` into
     `builtin/` and doing some renames and a few other needed changes.

* - 2/14 replay: start using parse_options API
  - 3/14 replay: die() instead of failing assert()
  - 4/14 replay: introduce pick_regular_commit()
  - 5/14 replay: don't simplify history
  - 6/14 replay: add an important FIXME comment about gpg signing
  - 7/14 replay: remove progress and info output
  - 8/14 replay: remove HEAD related sanity check

     These slowly change the command to make it behave more like a
     regular commands and to start cleaning up its output. 

* 9/14 replay: very coarse worktree updating

     Make it handle conflicts in a very coarse way. This might not
     work on bare repos, but it allows existing tests to pass and it's
     nice to help cli users a bit when they get conflicts.

* 10/14 replay: make it a minimal server side command

     After the cleaning up in previous ommits, it's now time to
     radically change the way it works by stopping it to do ref
     updates, to update the index and worktree, to consider HEAD as
     special. Instead just make it output commands that should be
     passed to `git update-ref --stdin`.

* - 11/14 replay: use standard revision ranges
  - 12/14 replay: introduce guess_new_base()
  - 13/14 replay: add different modes
  - 14/14 replay: stop assuming replayed branches do not diverge

      These finish the clean up and add new interesting features at
      the same time, as well as related documentation and tests.

# Note about tests and documentation

Note that the `fast-rebase` test helper was used before this series in

t6429-merge-sequence-rename-caching.sh

So when `git replay` is created from `fast-rebase` in patch 1/14, this
test script is also converted to use `git replay`. This ensures that
`git replay` doesn't break too badly during the first 10 patches in
this patch series.

Tests and documentation are introduced specifically for `git replay`
only in 11/14 and later patches as it doesn't make much sense to
document and test behavior that we know is going to change soon. So
it's only when the command is crystalizing towards its final form that
we start documenting and testing it.

# Possibly controversial issues 

* bare or not bare: this series works towards a command with the end
  goal of it being usable and used on bare repos, contrary to existing
  commands like `git rebase` and `git cherry-pick`, but the tests
  currently don't check that, and in case of conflicts it won't
  currently work on bare repos. One reason for that is that existing
  tests in t6429 should continue to work, and one of these tests
  requires some output in case of conflict. And it's nice for users to
  get some help in case of conflict. It's also nice for users if
  commands that should work on both bare and non bare repos work well
  on non bare repos first as they are less likely to use them on bare
  repos. So let's have a command that works well on non-bare repos
  first, even if its end goal is to work fine on bare repos too. We
  plan to improve things for bare repos soon after this first patch
  series graduates.

* exit status: a successful, non-conflicted replay exits with code
  0. When the replay has conflicts, the exit status is 1. If the
  replay is not able to complete (or start) due to some kind of error,
  the exit status is something other than 0 or 1. It has been
  suggested in an internal review that conflicts might want to get a
  more specific error code as an error code of 1 might be quite easy
  to return by accident. It doesn't seem to me from their docs (which
  might want to be improved, I didn't look at the code) that other
  commands like `git merge` and `git rebase` exit with a special error
  code in case of conflict.

* to guess or not to guess: commit 12/14 introduces the
  guess_new_base() function which tries to find a base to rebase onto
  when the --onto option is not provided, making this option actually
  optional instead of mandatory. Given that it's an heuristic and the
  command end goal is to be used on server side, we might want to
  introduce this as an iterative improvement later. I still think it's
  interesting to have it in for now though, as it shows that --onto
  and --advance (which is introduced in the following commit) should
  indeed be options. If --onto was always mandatory in the series,
  people could argue that it shouldn't be an option and its argument
  should always be the first (unconditional) argument of the command.

* make worktree and index changes optional: commit 10/14 stops
  updating the index and worktree, but it might be better especially
  for cli users to make that optional. The issue is that this would
  make the command more complex while we are developing a number of
  important features. It seems to me that this should rather be done
  in an iterative improvement after the important features have
  landed.

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


Elijah Newren (14):
  replay: introduce new builtin
  replay: start using parse_options API
  replay: die() instead of failing assert()
  replay: introduce pick_regular_commit()
  replay: don't simplify history
  replay: add an important FIXME comment about gpg signing
  replay: remove progress and info output
  replay: remove HEAD related sanity check
  replay: very coarse worktree updating
  replay: make it a minimal server side command
  replay: use standard revision ranges
  replay: introduce guess_new_base()
  replay: add different modes
  replay: stop assuming replayed branches do not diverge

 .gitignore                               |   1 +
 Documentation/git-replay.txt             | 130 +++++++
 Makefile                                 |   2 +-
 builtin.h                                |   1 +
 builtin/replay.c                         | 419 +++++++++++++++++++++++
 command-list.txt                         |   1 +
 git.c                                    |   1 +
 t/helper/test-fast-rebase.c              | 233 -------------
 t/helper/test-tool.c                     |   1 -
 t/helper/test-tool.h                     |   1 -
 t/t3650-replay-basics.sh                 | 160 +++++++++
 t/t6429-merge-sequence-rename-caching.sh |  43 ++-
 12 files changed, 739 insertions(+), 254 deletions(-)
 create mode 100644 Documentation/git-replay.txt
 create mode 100644 builtin/replay.c
 delete mode 100644 t/helper/test-fast-rebase.c
 create mode 100755 t/t3650-replay-basics.sh

-- 
2.40.0.228.gb2eb5bb98e


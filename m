Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BD4EC8742
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 17:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbjIGREJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 13:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbjIGREI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 13:04:08 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F2F1FEC
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 10:03:42 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52a5c0d949eso1589469a12.0
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 10:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694106161; x=1694710961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICJ8S0nqzuq0ri2SqTFrYfcIdbT9Uj2Ix2u68Fpvajs=;
        b=pM/VosVKO7omJJ6vCPxJ8f3Lj5ID01vclW1pQBILcMmrx3Ux3NHWyvJmyM2PoBkTc5
         9e1iVb3qVdMCk/Jvg1AkBcPrrf1RYNe/MVvW2uKjUugoR38kKo6iT5GqzTOesw6xcBDt
         Ln2LgrHMLPpREO9biENHYT6Doe/P1KVc7u22t/nb1ahAHEL0s3a7z+i1l34EPTrimB+R
         uSl+coAncDTzgKU4dSiK0CuVVFQvmxBtCitykvnDh7C2cLHJzDbClcuLc4aH05Pc6dgK
         k8O/TGZXBwf6PRcG8YonfRNZZF6D6iqmE9O3RsDAU2n/+YxbB0sBsPxdGL2aANF9Shk2
         kHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694106161; x=1694710961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICJ8S0nqzuq0ri2SqTFrYfcIdbT9Uj2Ix2u68Fpvajs=;
        b=KSP8nbBUx5TWEP0gLv+iAr98Dt7OVzaXnrSxQ5Lu8DHBXDi4srbMh21jDQuKwiryd7
         me8VvaQHm10kRaFs/EbE7PNtwkBlQB1abf5hNiou7UYlJc8aFnYsW8F2DBmJKUHLlmqp
         0JtzkUu2UCv2BVWfHb2SunSoIRKkqi8qX1L7CYliGj3gv/Ymu1m7xSTZo/uMnyFagaNQ
         bqYH9D1xatSLRRimbJ3EBdljV4p0oiJEVTH309T/9n2WDkXEhM9s4p9Qi1idvIokPrS+
         mUlEVXBwoXMnXR6FkAZb+/aaZUVa5WGoq5rN4cpjgEGdSYh8Ljmb/QChBTWMnfMB/raY
         9hTQ==
X-Gm-Message-State: AOJu0YxmagT7xfaR3UgNlO2Gg/rzw+9l1+IYqtOzAYjh8ayoV/AZfgyZ
        yVcktzhQbuRtGihLPlCtFzfNOnlLcU4=
X-Google-Smtp-Source: AGHT+IFl3FTshLLpe39pj6Cn5Cdy09GC1cUtGlBU6m/COwzNsEBJ6RhOaOM0nabJtmp4IxadGJsAQA==
X-Received: by 2002:a5d:4d8f:0:b0:319:755c:3c1e with SMTP id b15-20020a5d4d8f000000b00319755c3c1emr3833332wru.11.1694078756317;
        Thu, 07 Sep 2023 02:25:56 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:3385:ce2d:69dd:303e])
        by smtp.gmail.com with ESMTPSA id y8-20020adff148000000b00317c742ca9asm22491522wro.43.2023.09.07.02.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:25:55 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 00/15] Introduce new `git replay` command
Date:   Thu,  7 Sep 2023 11:25:06 +0200
Message-ID: <20230907092521.733746-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.126.gcf8c984877
In-Reply-To: <20230602102533.876905-1-christian.couder@gmail.com>
References: <20230602102533.876905-1-christian.couder@gmail.com>
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

# Changes between v3 and v4

Thanks to Toon, Junio and Dscho for their suggestions on the previous
version! The very few and minor changes compared to v3 are:

* The patch series was rebased onto master at d814540bb7 (The fifth
  batch, 2023-09-01). This is to fix a few header related conflicts as
  can be seen in the range-diff.

* In patch 10/15 (replay: make it a minimal server side command) a /*
  Cleanup */ code comment has been removed as suggested by Toon.

* In patch 11/15 (replay: use standard revision ranges) the git-replay
  documentation related to --onto has been improved to better explain
  which branches will be updated by the update-ref command(s) in the
  output as suggested by Junio.

* In patch 12/15 (replay: disallow revision specific options and
  pathspecs) an error message has been improved as suggested by Junio.

* In patch 13/15 (replay: add --advance or 'cherry-pick' mode) the
  commit message and the git-replay documentation have been improved
  to better explain that --advance only works when the revision range
  passed has a single tip as suggested by Junio.

* Also in patch 13/15 (replay: add --advance or 'cherry-pick' mode) an
  error message has been improved, and a few tests have been added to
  check that `git replay` fails when it's passed both --advance and
  --onto and when it's passed none of these options, as suggested by
  Toon.

# Range-diff between v3 and v4

 1:  51fa1c7aea =  1:  1eaca9b788 t6429: remove switching aspects of fast-rebase
 2:  19f8cf1b2e !  2:  5ac4beb1ae replay: introduce new builtin
    @@ t/helper/test-fast-rebase.c => builtin/replay.c
      
      #define USE_THE_INDEX_VARIABLE
     -#include "test-tool.h"
    --#include "cache.h"
     +#include "git-compat-util.h"
     +
     +#include "builtin.h"
 3:  295e876db6 !  3:  299381aa9b replay: start using parse_options API
    @@ builtin/replay.c
      #include "lockfile.h"
      #include "merge-ort.h"
      #include "object-name.h"
    +-#include "read-cache-ll.h"
     +#include "parse-options.h"
      #include "refs.h"
      #include "revision.h"
 4:  6ece7d3751 =  4:  3b825c9be0 replay: die() instead of failing assert()
 5:  9b4bc659fb =  5:  b1e890745d replay: introduce pick_regular_commit()
 6:  9ab68d50ab =  6:  ec51351889 replay: don't simplify history
 7:  37e93faafa =  7:  cd4ed07d2d replay: add an important FIXME comment about gpg signing
 8:  03036781ed =  8:  e45a55917c replay: remove progress and info output
 9:  4ea289952e =  9:  0587a76cbb replay: remove HEAD related sanity check
10:  fba98eda07 ! 10:  d10368e87a replay: make it a minimal server side command
    @@ builtin/replay.c
     -#include "commit.h"
      #include "environment.h"
     -#include "gettext.h"
    +-#include "hash.h"
      #include "hex.h"
      #include "lockfile.h"
      #include "merge-ort.h"
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
     +          }
        }
      
    -+  /* Cleanup */
        merge_finalize(&merge_opt, &result);
     +  ret = result.clean;
      
11:  03f9f20f6e ! 11:  4e09572c43 replay: use standard revision ranges
    @@ Documentation/git-replay.txt (new)
     +  Starting point at which to create the new commits.  May be any
     +  valid commit, and not just an existing branch name.
     ++
    -+The update-ref commands in the output will update the branch(es)
    -+in the revision range to point at the new commits (in other
    -+words, this mimics a rebase operation).
    ++The update-ref command(s) in the output will update the branch(es) in
    ++the revision range to point at the new commits, similar to the way how
    ++`git rebase --update-refs` updates multiple branches in the affected
    ++range.
     +
     +<revision-range>::
     +  Range of commits to replay; see "Specifying Ranges" in
    @@ Documentation/git-replay.txt (new)
     +  update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
     +  update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
     +
    -+where the number of refs updated depend on the arguments passed.
    ++where the number of refs updated depends on the arguments passed and
    ++the shape of the history being replayed.
     +
     +EXIT STATUS
     +-----------
12:  e651250ac7 ! 12:  64b803f1cf replay: disallow revision specific options and pathspecs
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
     +   * them, after adding related tests and doc though.
     +   */
     +  if (revs.prune_data.nr) {
    -+          error(_("invalid pathspec: %s"), revs.prune_data.items[0].match);
    ++          error(_("no pathspec is allowed: '%s'"), revs.prune_data.items[0].match);
     +          usage_with_options(replay_usage, replay_options);
     +  }
     +
13:  56e5416dad ! 13:  04f27d81ab replay: add --advance or 'cherry-pick' mode
    @@ Commit message
         'cherry-pick' mode with `--advance`. This new mode will make the target
         branch advance as we replay commits onto it.
     
    +    The replayed commits should have a single tip, so that it's clear where
    +    the target branch should be advanced. If they have more than one tip,
    +    this new mode will error out.
    +
         Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    @@ Documentation/git-replay.txt: OPTIONS
        Starting point at which to create the new commits.  May be any
        valid commit, and not just an existing branch name.
      +
    --The update-ref commands in the output will update the branch(es)
    --in the revision range to point at the new commits (in other
    --words, this mimics a rebase operation).
    +-The update-ref command(s) in the output will update the branch(es) in
    +-the revision range to point at the new commits, similar to the way how
    +-`git rebase --update-refs` updates multiple branches in the affected
    +-range.
     +When `--onto` is specified, the update-ref command(s) in the output will
     +update the branch(es) in the revision range to point at the new
    -+commits (in other words, this mimics a rebase operation).
    ++commits, similar to the way how `git rebase --update-refs` updates
    ++multiple branches in the affected range.
     +
     +--advance <branch>::
     +  Starting point at which to create the new commits; must be a
    @@ Documentation/git-replay.txt: OPTIONS
     +the new commits (in other words, this mimics a cherry-pick operation).
      
      <revision-range>::
    -   Range of commits to replay; see "Specifying Ranges" in
    +-  Range of commits to replay; see "Specifying Ranges" in
    +-  linkgit:git-rev-parse.
    ++  Range of commits to replay. More than one <revision-range> can
    ++  be passed, but in `--advance <branch>` mode, they should have
    ++  a single tip, so that it's clear where <branch> should point
    ++  to. See "Specifying Ranges" in linkgit:git-rev-parse.
    + 
    + OUTPUT
    + ------
     @@ Documentation/git-replay.txt: input to `git update-ref --stdin`.  It is basically of the form:
    -   update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
        update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
      
    --where the number of refs updated depend on the arguments passed.
    -+where the number of refs updated depend on the arguments passed.  When
    -+using `--advance`, the number of refs updated is always one, but for
    -+`--onto`, it can be one or more (rebasing multiple branches
    -+simultaneously is supported).
    + where the number of refs updated depends on the arguments passed and
    +-the shape of the history being replayed.
    ++the shape of the history being replayed.  When using `--advance`, the
    ++number of refs updated is always one, but for `--onto`, it can be one
    ++or more (rebasing multiple branches simultaneously is supported).
      
      EXIT STATUS
      -----------
    @@ builtin/replay.c: static struct commit *create_commit(struct tree *tree,
     +                  die(_("argument to --advance must be a reference"));
     +          }
     +          if (rinfo.positive_refexprs > 1)
    -+                  die(_("cannot advance target with multiple source branches because ordering would be ill-defined"));
    ++                  die(_("cannot advance target with multiple sources because ordering would be ill-defined"));
     +  } else {
     +          int positive_refs_complete = (
     +                  rinfo.positive_refexprs ==
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
     +                 oid_to_hex(&onto->object.oid));
     +  }
     +
    -   /* Cleanup */
        merge_finalize(&merge_opt, &result);
        ret = result.clean;
      
    @@ t/t3650-replay-basics.sh: test_expect_success 'using replay on bare repo with di
     +  git -C bare replay --advance main topic1..topic2 >result-bare &&
     +  test_cmp expect result-bare
     +'
    ++
    ++test_expect_success 'replay on bare repo fails with both --advance and --onto' '
    ++  test_must_fail git -C bare replay --advance main --onto main topic1..topic2 >result-bare
    ++'
    ++
    ++test_expect_success 'replay fails when both --advance and --onto are omitted' '
    ++  test_must_fail git replay topic1..topic2 >result
    ++'
     +
      test_done
14:  2cc17dfdc7 ! 14:  9ed0919ad5 replay: add --contained to rebase contained branches
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
                                       oid_to_hex(&last_commit->object.oid),
     
      ## t/t3650-replay-basics.sh ##
    -@@ t/t3650-replay-basics.sh: test_expect_success 'using replay on bare repo to perform basic cherry-pick' '
    -   test_cmp expect result-bare
    +@@ t/t3650-replay-basics.sh: test_expect_success 'replay fails when both --advance and --onto are omitted' '
    +   test_must_fail git replay topic1..topic2 >result
      '
      
     +test_expect_success 'using replay to also rebase a contained branch' '
15:  a6d88fc8f0 ! 15:  cf8c984877 replay: stop assuming replayed branches do not diverge
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
                if (advance_name)
                        continue;
     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix)
    +   }
      
    -   /* Cleanup */
        merge_finalize(&merge_opt, &result);
     -  ret = result.clean;
     -


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
 Documentation/git-replay.txt             | 124 +++++++
 Makefile                                 |   2 +-
 builtin.h                                |   1 +
 builtin/replay.c                         | 431 +++++++++++++++++++++++
 command-list.txt                         |   1 +
 git.c                                    |   1 +
 t/helper/test-fast-rebase.c              | 241 -------------
 t/helper/test-tool.c                     |   1 -
 t/helper/test-tool.h                     |   1 -
 t/t3650-replay-basics.sh                 | 214 +++++++++++
 t/t6429-merge-sequence-rename-caching.sh |  45 +--
 12 files changed, 799 insertions(+), 264 deletions(-)
 create mode 100644 Documentation/git-replay.txt
 create mode 100644 builtin/replay.c
 delete mode 100644 t/helper/test-fast-rebase.c
 create mode 100755 t/t3650-replay-basics.sh

-- 
2.42.0.126.gcf8c984877


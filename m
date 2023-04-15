Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90C5C77B71
	for <git@archiver.kernel.org>; Sat, 15 Apr 2023 06:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDOGvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 02:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDOGvA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 02:51:00 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C177230C1
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 23:50:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id x34so7710554ljq.1
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 23:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681541456; x=1684133456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMDxm1crpe6FeQylAo9IKLdmL/wT9UAdjKXvy9VHmVA=;
        b=d7G2RUulDbdDEmM4SYbTHHYPJI2z0dFJxqPfbkLVMuvCRzo9g3z0oOHK5aWAiKjp6q
         qYque/GHAOeshK0es+pMHMxCcE57gQ0d8r4ln0/ubYISADsu6HzkZ909opAnM84rM1bA
         aWac0F7wWV3mRXRA6aKRBCdgLEmxWw33GG6SaVj7KV4pvlMqg7MEVuUq/4c168WygLF+
         hCWpQdx9O3luxv2koi6jmptBZtX3SWnRwMQe9yJOCwUb5CMafhSXKQ/K+dBJyn3H74ex
         tCswHh0HkuUugjRjh5gQJYWHGgoGXgesLq10Sakn/eYziHeKmG6bkctjlqkGI+tyyH7V
         +KfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681541456; x=1684133456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMDxm1crpe6FeQylAo9IKLdmL/wT9UAdjKXvy9VHmVA=;
        b=NhPKLxeCo8Rn6k68LHmpwCczZr73QFBSCmwqJBIKjPBFYHGtGpJVYMiFEYK8QR4OPi
         GDC7/XnxqDtj3v+ia1BUFNOD/7VemBiotG1H2BzGZcLwpdHhHMOg5ukcqNcvAbjFVvns
         2lV7MWapE+aoX+VNbz/K+ULH6xx65o7F+CBLtIleQs2ytiHGziQqTP2FivEyNqGaNQ+2
         nExburzIGn8k9FC4ATa1LquMS5OlKQQz+ZSogvk2wcRj+E8HCZklNF4r46tFdQVQd3MW
         fzZyNJeSZ6OtOHi2LDZb2b1m7nKsuOCVxYEfVOyNxRb86Iuhok2CuDHmgMcWxxKa/Sbi
         6A+g==
X-Gm-Message-State: AAQBX9fuOnMFNbwaPsboqoNA8XDnDuQuoAQhTgHW86kuYfnAbZ3NqsnT
        1YPB0fP31YpxDnb/Nb55rl0Ys2S7xWkhRqvEq0k=
X-Google-Smtp-Source: AKy350aE0s2M3Isj47rrkEorIV9Y2xIM2MbCpn7AtjmpFdO7Ep7CMw/glujhI/zCeaSD4NYX/bZTBMpSajc8g+0AJu8=
X-Received: by 2002:a2e:9811:0:b0:2a7:73d8:d675 with SMTP id
 a17-20020a2e9811000000b002a773d8d675mr2647669ljj.1.1681541455654; Fri, 14 Apr
 2023 23:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230407072415.1360068-1-christian.couder@gmail.com>
In-Reply-To: <20230407072415.1360068-1-christian.couder@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 14 Apr 2023 23:44:51 -0700
Message-ID: <CABPp-BE7yD_FJuGx4KtzO5YF-LXYHFrTWSf71ttNTcyMDpZgeg@mail.gmail.com>
Subject: Re: [PATCH 00/14] Introduce new `git replay` command
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 7, 2023 at 12:24=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> # Intro
>
> `git replay` has initially been developed entirely by Elijah Newren
> mostly between June and July 2022 at:

(Sidenote: actually, there was a good chunk in Jan & Feb 2022 as well,
and various design and idea work preceding that over a long time, some
in the form of the fast-rebase test-tool...)

> https://github.com/newren/git/commits/replay
>
> I took over a few months ago to polish and upstream it as GitLab is
> interested in replacing libgit2, and for that purpose needs a command
> to do server side (so without using a worktree) rebases, cherry-picks
> and reverts.
>
> I reduced the number of commits and features in this first patch
> series, compared to what Elijah already developed. Especially I
> stopped short of replaying merge commits and replaying
> interactively. These and other features might be upstreamed in the
> future after this patch series has graduated.

...and also cleaned up my commits which were in a WIP state.  Thanks!  :-)

> Thanks to Elijah, Patrick Steinhardt and Dscho for early reviews and
> discussions.
>
> Based on ae73b2c8f1 (The seventh batch, 2023-04-04)
>
> # Quick Overview (from Elijah)

In particular, this comes from the replay-design-notes.txt file on the
replay branch, up until the footnote links.

<snip>

My replay branch involved a whole bunch of aspirational ideas, work in
progress, and some things that worked.  As noted above, you've taken
this portion of the cover letter from my replay-design-notes.txt file
on that branch, but that file involved my in-progress thought
processes on all these ideas.  For this series, we should probably
just focus on the server-side usecases since other aspects just
weren't complete enough for use.  (I also thought the server-side
aspects of git-replay weren't good enough for use either because I
thought we'd need some conflict-related handling similar to what
git-merge-tree does, but both you and Dscho have said you aren't
worried about that, and are fine with just a simple non-zero exit
status.)

Anyway, deleting the forward-looking stuff and concentrating on the
server-side replaying of commits would mean that we can at least
delete the portion of this cover letter starting from here...

>   * Other performance ideas:
>
>     * single-file control structures instead of directory of files
>
>     * avoid forking subprocesses unless explicitly requested (e.g.
>       --exec, --strategy, --run-hooks).  For example, definitely do not
>       invoke `git commit` or `git merge`.
>
>     * Sanitize hooks:
>
>       * dispense with all per-commit hooks for sure (pre-commit,
>         post-commit, post-checkout).
>
>       * pre-rebase also seems to assume exactly 1 ref is written, and
>         invoking it repeatedly would be stupid.  Plus, it's specific
>         to "rebase".  So...ignore?  (Stolee's --ref-update option for
>         rebase probably broke the pre-rebase assumptions already...)
>
>       * post-rewrite hook might make sense, but fast-import got
>         exempted, and I think of replay like a patch-based analogue
>         to the snapshot-based fast-import.
>
>     * When not running server side, resolve conflicts in a sparse-cone
>       sparse-index worktree to reduce number of files written to a
>       working tree.  (See below as well)
>
>     * [High risk of possible premature optimization] Avoid large
>       numbers of newly created loose objects, when replaying large
>       numbers of commits.  Two possibilities: (1) Consider using
>       tmp-objdir and pack objects from the tmp-objdir at end of
>       exercise, (2) Lift code from git-fast-import to immediately
>       stuff new objects into a pack?
>
> * Multiple branches and non-checked out branches
>
>   * The ability to operate on non-checked out branches also implies
>     that we should generally be able to replay when in a dirty working
>     tree (exception being when we expect to update HEAD and any of the
>     dirty files is one that needs to be updated by the replay).
>
>   * Also, if we are operating locally on a non-checked out branch and
>     hit a conflict, we should have a way to resolve the conflict without
>     messing with the user's work on their current branch.
>
>     * Idea: new worktree with sparse cone + sparse index checkout,
>       containing only files in the root directory, and whatever is
>       necessary to get the conflicts
>
>     * Companion to above idea: control structures should be written to
>       $GIT_COMMON_DIR/replay-${worktree}, so users can have multiple
>       replay sessions, and so we know which worktrees are associated
>       with which replay operations.

...up to here.  Some of the other stuff could perhaps be trimmed as
well, though I suspect at least some of it is useful from the
perspective of letting others know of additional usecases we'd like to
support (so that design suggestions don't curtail those additional
future usecases).


>   - [1] https://lore.kernel.org/git/pull.749.v3.git.git.1586044818132.git=
gitgadget@gmail.com/
>   - [2] https://github.com/martinvonz/jj/discussions/49
>   - [3] https://lore.kernel.org/git/CABPp-BE48=3D97k_3tnNqXPjSEfA163F8hoE=
+HY0Zvz1SWB2B8EA@mail.gmail.com/

This appears to be the end of the part you copied from replay-design-notes.=
txt

<snip>

> * 9/14 replay: very coarse worktree updating
>
>      Make it handle conflicts in a very coarse way. This might not
>      work on bare repos, but it allows existing tests to pass and it's
>      nice to help cli users a bit when they get conflicts.

I had the coarse working updating in git-replay mostly because it came
from fast-rebase.  I did also use it to poke and prod early ideas,
even though I knew that its current implementation might well be
incompatible with some of the other ideas I had.

I don't think this helps the server-side use though, and since it
potentially conflicts with some of the other goals, I'd be inclined to
say we should just drop this patch (and/or squash the next patch into
this one.)

> * 10/14 replay: make it a minimal server side command
>
>      After the cleaning up in previous ommits, it's now time to
>      radically change the way it works by stopping it to do ref
>      updates, to update the index and worktree, to consider HEAD as
>      special. Instead just make it output commands that should be
>      passed to `git update-ref --stdin`.

A squashed 9 & 10 would thus be similar to patch 8 in the sense that
its purpose was to get rid of something that made sense for
fast-rebase but which doesn't align with the current goals of this
command.

<snip>

> # Possibly controversial issues
>
> * bare or not bare: this series works towards a command with the end
>   goal of it being usable and used on bare repos, contrary to existing
>   commands like `git rebase` and `git cherry-pick`, but the tests
>   currently don't check that, and in case of conflicts it won't
>   currently work on bare repos. One reason for that is that existing
>   tests in t6429 should continue to work, and one of these tests
>   requires some output in case of conflict. And it's nice for users to
>   get some help in case of conflict. It's also nice for users if
>   commands that should work on both bare and non bare repos work well
>   on non bare repos first as they are less likely to use them on bare
>   repos. So let's have a command that works well on non-bare repos
>   first, even if its end goal is to work fine on bare repos too. We
>   plan to improve things for bare repos soon after this first patch
>   series graduates.

I think there's a lot of work to do for conflict handling, and if we
want to submit this for inclusion then we should just exclude conflict
handling entirely and adjust the tests accordingly.

> * exit status: a successful, non-conflicted replay exits with code
>   0. When the replay has conflicts, the exit status is 1. If the
>   replay is not able to complete (or start) due to some kind of error,
>   the exit status is something other than 0 or 1. It has been
>   suggested in an internal review that conflicts might want to get a
>   more specific error code as an error code of 1 might be quite easy
>   to return by accident. It doesn't seem to me from their docs (which
>   might want to be improved, I didn't look at the code) that other
>   commands like `git merge` and `git rebase` exit with a special error
>   code in case of conflict.

The merge backend does not provide any granularity finer than "had
conflicts" for its return code.  This is somewhat cemented by the
git-merge API as well, where it mandates that the return code of merge
backends be 1 for conflicts:

    /*
     * The backend exits with 1 when conflicts are
     * left to be resolved, with 2 when it does not
     * handle the given merge at all.
     */

Because of this, all of git-merge-resolve, git-merge-octopus,
git-merge-recursive, and git-merge-ort return 1 for conflicts.

Of course, we do not have to use the return code of the merge backend
as the exit status for `git replay`.  We could inspect the conflicts,
somewhat like git-merge-tree does, except that instead of printing
information about those conflicts, we could also let it guide us to
choose a new exit status.  I'm not sure we'd want to do that, but we
could.

Since an exit status of 1 is pretty thoroughly baked in elsewhere for
everything merge related, including `git-merge-tree`, I'd be inclined
to leave this series as-is and have an exit status of 1 for conflicts.

> * to guess or not to guess: commit 12/14 introduces the
>   guess_new_base() function which tries to find a base to rebase onto
>   when the --onto option is not provided, making this option actually
>   optional instead of mandatory. Given that it's an heuristic and the
>   command end goal is to be used on server side, we might want to
>   introduce this as an iterative improvement later. I still think it's
>   interesting to have it in for now though, as it shows that --onto
>   and --advance (which is introduced in the following commit) should
>   indeed be options. If --onto was always mandatory in the series,
>   people could argue that it shouldn't be an option and its argument
>   should always be the first (unconditional) argument of the command.

I do not want a positional argument for <onto>; rebase's use of
positional arguments is an example to avoid, IMO.

I also don't want people thinking this is just rebase.  Rebase is
perhaps used more than cherry-pick and as such a lot of the
documentation and design goals talk about it more, but I designed this
command very deliberately to be about handling both cherry-pick and
rebase functionality in the same command.

All that said, I remember spending a fair amount of time on the
heuristic, but don't remember if I felt I had gotten it good enough or
not.  If folks want to leave it out for a future series, that'd be
fine, so long as it doesn't lead people to suggestions that'd conflict
with the above points.

> * make worktree and index changes optional: commit 10/14 stops
>   updating the index and worktree, but it might be better especially
>   for cli users to make that optional. The issue is that this would
>   make the command more complex while we are developing a number of
>   important features. It seems to me that this should rather be done
>   in an iterative improvement after the important features have
>   landed.

I don't think worktree and index changes should be included in this
series, even as an option.  The related code as currently written is
incompatible with some other ideas expressed in the cover letter.
Granted, those ideas might change, even dramatically, but I don't want
us limiting the design space and I don't think the worktree or index
updates in this series are ready for users to use yet.  (And there
aren't any patches available, to my knowledge, that make them ready.
Those still need to be written.)

> * when and where to add tests and docs: although t6429 has tests that
>   are changed to use the new command instead of the fast-rebase
>   test-tool command as soon as the former is introduced, there is no
>   specific test script and no doc for the new command until commit
>   11/14 when standard revision ranges are used. This is done to avoid
>   churn in tests and docs while the final form of the command hasn't
>   crystalized enough. Adding tests and doc at this point makes this
>   commit quite big and possibly more difficult to review than if they
>   were in separate commits though. On the other hand when tests and
>   docs are added in specific commits some reviewers say it would be
>   better to introduce them when the related changes are made.

I don't have opinions on this one.  Maybe I will after reading through
this cleaned up series more carefully.

> * --advance and --contained: these two advanced options might not
>   belong to this first series and could perhaps be added in a followup
>   series in separate commits. On the other hand the code for
>   --contained seems involved with the code of --advance and it's nice
>   to see soon that git replay can indeed do cherry-picking and rebase
>   many refs at once, and this way fullfil these parts of its promise.

--advance is the one option I thought I had a chance of getting my
company to use server-side in the near term...

Also, without --advance, I worry reviewers will make rebase-centric
assumptions that preclude handling cherry-picks, so I'm really leery
of deferring it based on that.

I understand that --contained isn't as likely to be useful
server-side, but it was the one piece that I really enjoyed using
cli-side (especially since it pre-dated rebase --update-refs).  But
yeah, it's utility is somewhat limited until there's some kind of
conflict resolution mechanism provided.

> * replaying diverging branches: 14/14 the last patch in the series,
>   which allow replaying diverging branches, can be seen as a
>   fundamental fix or alternatively as adding an interesting
>   feature. So it's debatable if it should be in its own patch along
>   with its own tests as in this series, or if it should be merged into
>   a previous patch and which one.

I don't have opinions on this either.  Maybe I will after reading
through the series?

> * only 2 patches: this patch series can be seen from a high level
>   point of view as 1) introducing the new `git replay` command, and 2)
>   using `git replay` to replace, and get rid of, the fast-rebase
>   test-tool command. The fact that not much of the original
>   fast-rebase code and interface is left would agree with that point
>   of view. On the other hand, fast-rebase can also be seen as a first
>   iteration towards `git replay`. So it can also make sense to see how
>   `git replay` evolved from it.

I preferred the angle of starting from fast-rebase, but I don't feel
too strongly about it.  Mostly I just thought it'd make it easier for
me, and for the few other people who already reviewed fast-rebase (and
yes, I got review comments on it from a few different people back when
it was proposed).  If dividing up the patches some other way makes it
easier for others to reason about, and you want to switch it around,
go for it.

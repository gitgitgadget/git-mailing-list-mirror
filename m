Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10717C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 17:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348548AbiAGR0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 12:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiAGR0p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 12:26:45 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC55C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 09:26:44 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id j6so24622937edw.12
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 09:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEg2h6GOe/C7ZwbEhQozmsptZGVebj9P+1DspWz0S/M=;
        b=NeZtlukd4vAhVJK3VX/WQRmJbdFiZzhmCw5/cmBYqO01ZYtA9itHKCEULHUxIQxj23
         MysME8CFU1Q88/M5YwqFllpOTVlKU0Zp8/lwrX4yNJPjaPxcOn05HkXUgc4+3/3hNHDc
         P7O61R/9oEvt9ggm3wC4Rl6bmrjDNtZAFdy0t34YKT0DgrwAcg4tr1U8bk46dgX8uIDc
         TUNfWOk/TQyR+YMNyC2Cu9CbfOttvfeNpAd+x+tgpHolRGvWtC3ls+aGoacP/8p1IWSC
         YeQORm2qytIcOEE0N1DwrnG4ikFCWrcowqgwHTD8G1pmm1QyESX5AyYUwLtMSQgpZVDY
         LYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEg2h6GOe/C7ZwbEhQozmsptZGVebj9P+1DspWz0S/M=;
        b=erWB5PzLWRWkFrIpYFJ1HdURBM1PtxPSYVK37Xdnv7w7ObmiDCAf1jeYJWh/no+XCe
         y1vE5PXcDjwlzaFWeaNEk4uxH5dbkL/u42je6KBJOpwGyGLakOD30YCs/StuHLKuwG3K
         Iz9PG0mRU0RTrkp8F8DwqpClz+dTEJaBfrXaN5fFvYp8jD0vfvr9MK70SrNDbFfvx1rt
         jPOmM0fBG4vvchJyHP9PyO2lURhx6aE6LAivejaa0iYNxiehI/gr6nVa7eT7Z/kHnZ3m
         SJIq+s6cWQ+GPvbd1HViDsmkAQEIJMsUpmvNwV8+RulOJhhxKLKm93J+Ts/RNa8uouTB
         aMHQ==
X-Gm-Message-State: AOAM532LXMifzRQVCVWbUpMzCw/SAncunu07a1c5hyZ5wEDpHCa/vX1u
        hP6lKwVTpFZ36DHomtmiyGDlUuKFn68Dndepx8Q=
X-Google-Smtp-Source: ABdhPJw+R9vk8a+GMVPzECGFOgjOYWYY1+6j3Nr7O5QOOCxGYVSeXMzCzwfKYgSFTn75sAGf8dBxvOi9oZl5bW2Uoxc=
X-Received: by 2002:a17:907:160e:: with SMTP id hb14mr51576868ejc.328.1641576403386;
 Fri, 07 Jan 2022 09:26:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com> <1710ba4a9e432e2a854579c4c929e7f2cfc92211.1641403655.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201071602110.339@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2201071602110.339@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 7 Jan 2022 09:26:31 -0800
Message-ID: <CABPp-BFUJ6pU_CKM7ccnFvi0nkeeGfd2GETdksKLaz=B_=BZAQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] merge-tree: implement real merges
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 7, 2022 at 7:30 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Wed, 5 Jan 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > This adds the ability to perform real merges rather than just trivial
> > merges (meaning handling three way content merges, recursive ancestor
> > consolidation, renames, proper directory/file conflict handling, and so
> > forth).  However, unlike `git merge`, the working tree and index are
> > left alone and no branch is updated.
> >
> > The only output is:
> >   - the toplevel resulting tree printed on stdout
> >   - exit status of 0 (clean) or 1 (conflicts present)
> >
> > This output is mean to be used by some higher level script, perhaps in a
>                  ^^^^
>
> My apologies for pointing out a grammar issue: This probably intended to
> say "meant", as the word "mean" changes the sense of the sentence.

Oops.  Yeah, I'll correct that; thanks for pointing it out.

> In my defense, I have more substantial suggestions below.
>
> > sequence of steps like this:
> >
> >    NEWTREE=$(git merge-tree --real $BRANCH1 $BRANCH2)
> >    test $? -eq 0 || die "There were conflicts..."
> >    NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
> >    git update-ref $BRANCH1 $NEWCOMMIT
> >
> > Note that higher level scripts may also want to access the
> > conflict/warning messages normally output during a merge, or have quick
> > access to a list of files with conflicts.  That is not available in this
> > preliminary implementation, but subsequent commits will add that
> > ability.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  Documentation/git-merge-tree.txt | 28 +++++++----
> >  builtin/merge-tree.c             | 55 +++++++++++++++++++++-
> >  t/t4301-merge-tree-real.sh       | 81 ++++++++++++++++++++++++++++++++
> >  3 files changed, 153 insertions(+), 11 deletions(-)
> >  create mode 100755 t/t4301-merge-tree-real.sh
> >
> > diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
> > index 58731c19422..5823938937f 100644
> > --- a/Documentation/git-merge-tree.txt
> > +++ b/Documentation/git-merge-tree.txt
> > @@ -3,26 +3,34 @@ git-merge-tree(1)
> >
> >  NAME
> >  ----
> > -git-merge-tree - Show three-way merge without touching index
> > +git-merge-tree - Perform merge without touching index or working tree
> >
> >
> >  SYNOPSIS
> >  --------
> >  [verse]
> > +'git merge-tree' --real <branch1> <branch2>
> >  'git merge-tree' <base-tree> <branch1> <branch2>
>
> Here is an idea: How about aiming for this synopsis instead, exploiting
> the fact that the "real" mode takes a different amount of arguments?

My turn on the grammar thing: s/amount/number/.   :-)

>
>    'git merge-tree' [--write-tree] <branch1> <branch2>
>    'git merge-tree' [--demo-trivial-merge] <base-tree> <branch1> <branch2>
>
> That way, the old mode can still function, and can even at some stage be
> deprecated and eventually removed.

Ooh, interesting.

> >
> >  DESCRIPTION
> >  -----------
> > -Reads three tree-ish, and output trivial merge results and
> > -conflicting stages to the standard output.  This is similar to
> > -what three-way 'git read-tree -m' does, but instead of storing the
> > -results in the index, the command outputs the entries to the
> > -standard output.
> > +Performs a merge, but does not make any new commits and does not read
> > +from or write to either the working tree or index.
> >
> > -This is meant to be used by higher level scripts to compute
> > -merge results outside of the index, and stuff the results back into the
> > -index.  For this reason, the output from the command omits
> > -entries that match the <branch1> tree.
> > +The first form will merge the two branches, doing a full recursive
> > +merge with rename detection.  If the merge is clean, the exit status
> > +will be `0`, and if the merge has conflicts, the exit status will be
> > +`1`.  The output will consist solely of the resulting toplevel tree
> > +(which may have files including conflict markers).
> > +
> > +The second form is meant for backward compatibility and will only do a
> > +trival merge.  It reads three tree-ish, and outputs trivial merge
> > +results and conflicting stages to the standard output in a semi-diff
> > +format.  Since this was designed for higher level scripts to consume
> > +and merge the results back into the index, it omits entries that match
> > +<branch1>.  The result of this second form is is similar to what
> > +three-way 'git read-tree -m' does, but instead of storing the results
> > +in the index, the command outputs the entries to the standard output.
> >
> >  GIT
> >  ---
> > diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> > index e1d2832c809..ac50f3d108b 100644
> > --- a/builtin/merge-tree.c
> > +++ b/builtin/merge-tree.c
> > @@ -2,6 +2,9 @@
> >  #include "builtin.h"
> >  #include "tree-walk.h"
> >  #include "xdiff-interface.h"
> > +#include "help.h"
> > +#include "commit-reach.h"
> > +#include "merge-ort.h"
> >  #include "object-store.h"
> >  #include "parse-options.h"
> >  #include "repository.h"
> > @@ -392,7 +395,57 @@ struct merge_tree_options {
> >  static int real_merge(struct merge_tree_options *o,
> >                     const char *branch1, const char *branch2)
> >  {
> > -     die(_("real merges are not yet implemented"));
> > +     struct commit *parent1, *parent2;
> > +     struct commit_list *common;
> > +     struct commit_list *merge_bases = NULL;
> > +     struct commit_list *j;
> > +     struct merge_options opt;
> > +     struct merge_result result = { 0 };
> > +
> > +     parent1 = get_merge_parent(branch1);
> > +     if (!parent1)
> > +             help_unknown_ref(branch1, "merge",
> > +                              _("not something we can merge"));
> > +
> > +     parent2 = get_merge_parent(branch2);
> > +     if (!parent2)
> > +             help_unknown_ref(branch2, "merge",
> > +                              _("not something we can merge"));
> > +
> > +     init_merge_options(&opt, the_repository);
> > +     /*
> > +      * TODO: Support subtree and other -X options?
> > +     if (use_strategies_nr == 1 &&
> > +         !strcmp(use_strategies[0]->name, "subtree"))
> > +             opt.subtree_shift = "";
> > +     for (x = 0; x < xopts_nr; x++)
> > +             if (parse_merge_opt(&opt, xopts[x]))
> > +                     die(_("Unknown strategy option: -X%s"), xopts[x]);
> > +     */
> > +
> > +     opt.show_rename_progress = 0;
> > +
> > +     opt.branch1 = merge_remote_util(parent1)->name; /* or just branch1? */
> > +     opt.branch2 = merge_remote_util(parent2)->name; /* or just branch2? */
> > +
> > +     /*
> > +      * Get the merge bases, in reverse order; see comment above
> > +      * merge_incore_recursive in merge-ort.h
> > +      */
> > +     common = get_merge_bases(parent1, parent2);
> > +     for (j = common; j; j = j->next)
> > +             commit_list_insert(j->item, &merge_bases);
> > +
> > +     /*
> > +      * TODO: notify if merging unrelated histories?
>
> I guess that it would make most sense to add a flag whether this is
> allowed or not, and I would suggest the default to be `off`.

Sounds fair.  Thanks for commenting on one of the TODOs that I was unsure about.

> > +     if (!common)
> > +             fprintf(stderr, _("merging unrelated histories"));
> > +      */
> > +
> > +     merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
> > +     printf("%s\n", oid_to_hex(&result.tree->object.oid));
> > +     merge_switch_to_result(&opt, NULL, &result, 0, 0);
>
> This looks to be idempotent to `merge_finalize(&opt, &result)`, so maybe
> use that instead?

Yeah, and add a TODO about the display messages (that'll be addressed
in a later patch, unlike the above TODOs).

>
> > +     return result.clean ? 0 : 1;
> >  }
> >
> >  int cmd_merge_tree(int argc, const char **argv, const char *prefix)
> > diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
> > new file mode 100755
> > index 00000000000..f7aa310f8c1
> > --- /dev/null
> > +++ b/t/t4301-merge-tree-real.sh
> > @@ -0,0 +1,81 @@
> > +#!/bin/sh
> > +
> > +test_description='git merge-tree --real'
> > +
> > +. ./test-lib.sh
> > +
> > +# This test is ort-specific
> > +GIT_TEST_MERGE_ALGORITHM=ort
> > +export GIT_TEST_MERGE_ALGORITHM
>
> It might make sense to skip the entire test if the user asked for
> `recursive` to be tested:
>
>         test "${GIT_TEST_MERGE_ALGORITHM:-ort}" = ort ||
>                 skip_all="GIT_TEST_MERGE_ALGORITHM != ort"
>                 test_done
>         }

The idea makes sense, but it took me a bit to understand this code
block.  I think you're just missing an opening left curly brace right
after the '||'?

> > +
> > +test_expect_success setup '
> > +     test_write_lines 1 2 3 4 5 >numbers &&
> > +     echo hello >greeting &&
> > +     echo foo >whatever &&
> > +     git add numbers greeting whatever &&
> > +     git commit -m initial &&
>
> I would really like to encourage the use of `test_tick`. It makes the
> commit consistent, just in case you run into an issue that depends on some
> hash order.

I've used test_tick before, but I already know this test can't depend
on hash order.  Further, the hashes in the output are also replaced
before comparing in order to make the tests also work as-is under
sha256.  So the tests are explicitly ignoring precise hashes.  As
such, I'm not sure I see the value of test_tick here.

> > +
> > +     git branch side1 &&
> > +     git branch side2 &&
> > +
> > +     git checkout side1 &&
>
> Please use `git switch -c side1` or `git checkout -b side1`: it is more
> compact than `git branch ... && git checkout ...`.

Yes, but less forgiving to later modification where I go and add
additional commits on one of the sides, because...

>
> > +     test_write_lines 1 2 3 4 5 6 >numbers &&
> > +     echo hi >greeting &&
> > +     echo bar >whatever &&
> > +     git add numbers greeting whatever &&
> > +     git commit -m modify-stuff &&
> > +
> > +     git checkout side2 &&
>
> This could be written as `git checkout -b side2 HEAD^`, to make the setup
> more succinct.

...the presumption of HEAD^ is hardcoded and has to be parsed by
readers to understand the test.  It felt like more cognitive overhead
to me, in addition to being less malleable.

> > +     test_write_lines 0 1 2 3 4 5 >numbers &&
> > +     echo yo >greeting &&
> > +     git rm whatever &&
> > +     mkdir whatever &&
> > +     >whatever/empty &&
> > +     git add numbers greeting whatever/empty &&
> > +     git commit -m other-modifications
> > +'
> > +
> > +test_expect_success 'Content merge and a few conflicts' '
> > +     git checkout side1^0 &&
> > +     test_must_fail git merge side2 &&
> > +     cp .git/AUTO_MERGE EXPECT &&
> > +     E_TREE=$(cat EXPECT) &&
>
> The file `EXPECT` is not used below. And can we use a more obvious name?
> SOmething like:
>
>         expected_tree=$(cat .git/AUTO_MERGE)

There go my beautiful <80 character lines below.  :-(

But on a more serious note, yeah this is probably better.  I'll change it.  :-)

>
> > +     git reset --hard &&
>
> For an extra bonus, we could delay this via `test_when_finished`, to prove
> that `git merge-tree --real` works even in a dirty worktree _with
> conflicts_.

Ooh, good thought.  I like that.

>
> > +     test_must_fail git merge-tree --real side1 side2 >RESULT &&
> > +     R_TREE=$(cat RESULT) &&
>
> How about `actual_tree` instead?

But my 80-characters rev-parse lines....waaah.  Just kidding, yeah
this would be better.

> > +
> > +     # Due to differences of e.g. "HEAD" vs "side1", the results will not
> > +     # exactly match.  Dig into individual files.
> > +
> > +     # Numbers should have three-way merged cleanly
> > +     test_write_lines 0 1 2 3 4 5 6 >expect &&
> > +     git show ${R_TREE}:numbers >actual &&
> > +     test_cmp expect actual &&
> > +
> > +     # whatever and whatever~<branch> should have same HASHES
> > +     git rev-parse ${E_TREE}:whatever ${E_TREE}:whatever~HEAD >expect &&
> > +     git rev-parse ${R_TREE}:whatever ${R_TREE}:whatever~side1 >actual &&
> > +     test_cmp expect actual &&
> > +
> > +     # greeting should have a merge conflict
> > +     git show ${E_TREE}:greeting >tmp &&
> > +     cat tmp | sed -e s/HEAD/side1/ >expect &&
> > +     git show ${R_TREE}:greeting >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'Barf on misspelled option' '
> > +     # Mis-spell with single "s" instead of double "s"
> > +     test_expect_code 129 git merge-tree --real --mesages FOOBAR side1 side2 2>expect &&
> > +
> > +     grep "error: unknown option.*mesages" expect
> > +'
>
> I do not think that this test case adds much, and we already test the
> `parse_options()` machinery elsewhere.

It's more about verifying that exit codes of 0 & 1 are reserved for
"completed with no conflicts" and "completed with conflicts".  The 129
bit in this test is the important bit (and perhaps is well-known to
lots of other folks, but I thought it was worth highlighting).  That
said, I did a bad job mentioning that in the test description; I'll
fix it up.

> > +
> > +test_expect_success 'Barf on too many arguments' '
> > +     test_expect_code 129 git merge-tree --real side1 side2 side3 2>expect &&
> > +
> > +     grep "^usage: git merge-tree" expect
> > +'
> > +
> > +test_done
>
> The rest looks awesome. Thank you for working on it! I will definitely
> come back to review the rest (have to take a break now), and then probably
> add quite a bit of food for thought based on my experience _actually_
> using `merge-ort` on the server-side. Stay tuned.

Ooh, I'm intrigued.  And thanks for reviewing!

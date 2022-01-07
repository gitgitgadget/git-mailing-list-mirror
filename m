Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C473C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 15:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348093AbiAGPaP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 10:30:15 -0500
Received: from mout.gmx.net ([212.227.17.22]:35499 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239726AbiAGPaP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 10:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641569411;
        bh=xc8Nki5AkP1JJShPrjpS3W2mbsyo0qQb6KgzKFLcv5o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AAH9uhWo0itNkeVXMDVBY1oPO1NZw6ASOV4MlyU6M8o1EVh/rNJNI2dbiSU8u2/Bt
         vr3edKxoocWRvCuVeosgnnOxYBMgmikjFvaOJE99uuQz53hkRo9u9dL7EY93iHYBev
         tqCe2eGo6Mr+A8KpDQEXBgo0GBuOz1nVJ0022WfQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.133.218] ([89.1.215.56]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MulmF-1mFxOS0VDX-00rtUc; Fri, 07
 Jan 2022 16:30:11 +0100
Date:   Fri, 7 Jan 2022 16:30:07 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 4/8] merge-tree: implement real merges
In-Reply-To: <1710ba4a9e432e2a854579c4c929e7f2cfc92211.1641403655.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201071602110.339@tvgsbejvaqbjf.bet>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>        <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com> <1710ba4a9e432e2a854579c4c929e7f2cfc92211.1641403655.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:F3cD2lrBDSSkQFCexcFffV95clYCcJp3h/rviegrmmxa0eCrY5p
 HMu4LPJGuUUi8uLHWQl2HlWK/HTTMvLtAXeh0Y3wUl7TEug+BexsFe7gzCCoyUC+QymVyA9
 NvWvEHtq4IKBs7aEsF+/SPeQ7EcRrvFKN0MW8KiylzyYF7wSaRU2q8N5CfjAfMcdqmfu3jA
 Q5CjI3U5KwWcb4TrZ/CKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fq5CL2Y++uM=:nJRL5XnAcSLYJ1KbWQrYbT
 QTmsbgDgp6bcHZ2DKamfMK6mcSL2KGhwGBuZRiJnkG5QKoXXj0EG0PAB5NiJUQJFwy/ZbeCZf
 IuLidfBk6kgtOUMsiGRcKnBwvWDfsbztGn6NXlf5XO1kWZRd4ViJJSPHoipuZWWAD0NMUSqzL
 NKU1R4jBeUjRI5zzrWgIIhOGpCnf3ibAT9DGluFoArC/32VV/uXbiYnxJFnWJwzwRe87bBFuz
 oID68G0iWq/7SWvuGmBeHqvf/kMFj/P342+QbGoXYsdQ4ZnHz8TFNtEYG2FTXIV9P3ZgLMm4O
 TEAzqKzgM/IDIIUu4KU6sH1fNRoYeX2KJJ8cThgy693wI4mKktAcdMFeuhnblWbwdZc7y19DT
 tfcxU5UYFGaeS2lSaiZRzn/MLW8bMFx4grjga8KOtca9tc68oEtxFP2N/BKqwGkdFMgALJ4mf
 5n4N/myztWEtGK/jV28PDiGQaGFSGQjK73muqf5fg/I9Zdeu9G/gADZdoqPygFO1Dklvv4AtK
 gTdVkl8yfjo3sWjWjP/imF2KEiOGeE2NmGpm8rAyPHKU4yKdLhWjGqZCOH0kpaCgzZiZwVaSE
 XCXlzGllXoHS1vQhavqUL1FkBWvRSJ32/eEresM6dJ/EKjlsyR9RlWI0QnjEevM7Y1WYpdY78
 s4Mn4c5P6FWyjiXKScQbNtFkqSJrtpn1UcXaKXXlUBC+RRyOQu3X24Wad3nL1xUSKFoqCQrc9
 /J1KHvLUL+/lhj1MTG5KW/yONmuZfQ9VfQ1ex7Z4AV47BA6ZCI7kgMjIVlFd95GS0T1TScZ+Z
 /z7OdFgxqSPy35bs+V1pj/jtlyPDLYUGMn5QLMxCF99jaZZyzt3MMwIZbTBCdXlDn5J+22+AM
 /3OHcTPEhfuX06S8yWENH3ELW4GvZnPQ4jiIInpxAqOViWGlrwBvnzj3bsYzzjR54tK1LJwH2
 /1rD46HC/e5AGiLm5NMUKtYKxpsTMyRP69QrEQYG91HlPdULj3f+2AlXe401kuslA4jhNycsm
 Fq0zFan2zwKvR8W7joyCaBRcDvQ+DSjzXU23xn2y16li8KtNsYpLnt4vZopfFUzxiHnhv6k38
 XcZmFeowLWrRyY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 5 Jan 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> This adds the ability to perform real merges rather than just trivial
> merges (meaning handling three way content merges, recursive ancestor
> consolidation, renames, proper directory/file conflict handling, and so
> forth).  However, unlike `git merge`, the working tree and index are
> left alone and no branch is updated.
>
> The only output is:
>   - the toplevel resulting tree printed on stdout
>   - exit status of 0 (clean) or 1 (conflicts present)
>
> This output is mean to be used by some higher level script, perhaps in a
                 ^^^^

My apologies for pointing out a grammar issue: This probably intended to
say "meant", as the word "mean" changes the sense of the sentence.

In my defense, I have more substantial suggestions below.

> sequence of steps like this:
>
>    NEWTREE=3D$(git merge-tree --real $BRANCH1 $BRANCH2)
>    test $? -eq 0 || die "There were conflicts..."
>    NEWCOMMIT=3D$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
>    git update-ref $BRANCH1 $NEWCOMMIT
>
> Note that higher level scripts may also want to access the
> conflict/warning messages normally output during a merge, or have quick
> access to a list of files with conflicts.  That is not available in this
> preliminary implementation, but subsequent commits will add that
> ability.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-merge-tree.txt | 28 +++++++----
>  builtin/merge-tree.c             | 55 +++++++++++++++++++++-
>  t/t4301-merge-tree-real.sh       | 81 ++++++++++++++++++++++++++++++++
>  3 files changed, 153 insertions(+), 11 deletions(-)
>  create mode 100755 t/t4301-merge-tree-real.sh
>
> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-=
tree.txt
> index 58731c19422..5823938937f 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -3,26 +3,34 @@ git-merge-tree(1)
>
>  NAME
>  ----
> -git-merge-tree - Show three-way merge without touching index
> +git-merge-tree - Perform merge without touching index or working tree
>
>
>  SYNOPSIS
>  --------
>  [verse]
> +'git merge-tree' --real <branch1> <branch2>
>  'git merge-tree' <base-tree> <branch1> <branch2>

Here is an idea: How about aiming for this synopsis instead, exploiting
the fact that the "real" mode takes a different amount of arguments?

   'git merge-tree' [--write-tree] <branch1> <branch2>
   'git merge-tree' [--demo-trivial-merge] <base-tree> <branch1> <branch2>

That way, the old mode can still function, and can even at some stage be
deprecated and eventually removed.

>
>  DESCRIPTION
>  -----------
> -Reads three tree-ish, and output trivial merge results and
> -conflicting stages to the standard output.  This is similar to
> -what three-way 'git read-tree -m' does, but instead of storing the
> -results in the index, the command outputs the entries to the
> -standard output.
> +Performs a merge, but does not make any new commits and does not read
> +from or write to either the working tree or index.
>
> -This is meant to be used by higher level scripts to compute
> -merge results outside of the index, and stuff the results back into the
> -index.  For this reason, the output from the command omits
> -entries that match the <branch1> tree.
> +The first form will merge the two branches, doing a full recursive
> +merge with rename detection.  If the merge is clean, the exit status
> +will be `0`, and if the merge has conflicts, the exit status will be
> +`1`.  The output will consist solely of the resulting toplevel tree
> +(which may have files including conflict markers).
> +
> +The second form is meant for backward compatibility and will only do a
> +trival merge.  It reads three tree-ish, and outputs trivial merge
> +results and conflicting stages to the standard output in a semi-diff
> +format.  Since this was designed for higher level scripts to consume
> +and merge the results back into the index, it omits entries that match
> +<branch1>.  The result of this second form is is similar to what
> +three-way 'git read-tree -m' does, but instead of storing the results
> +in the index, the command outputs the entries to the standard output.
>
>  GIT
>  ---
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index e1d2832c809..ac50f3d108b 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -2,6 +2,9 @@
>  #include "builtin.h"
>  #include "tree-walk.h"
>  #include "xdiff-interface.h"
> +#include "help.h"
> +#include "commit-reach.h"
> +#include "merge-ort.h"
>  #include "object-store.h"
>  #include "parse-options.h"
>  #include "repository.h"
> @@ -392,7 +395,57 @@ struct merge_tree_options {
>  static int real_merge(struct merge_tree_options *o,
>  		      const char *branch1, const char *branch2)
>  {
> -	die(_("real merges are not yet implemented"));
> +	struct commit *parent1, *parent2;
> +	struct commit_list *common;
> +	struct commit_list *merge_bases =3D NULL;
> +	struct commit_list *j;
> +	struct merge_options opt;
> +	struct merge_result result =3D { 0 };
> +
> +	parent1 =3D get_merge_parent(branch1);
> +	if (!parent1)
> +		help_unknown_ref(branch1, "merge",
> +				 _("not something we can merge"));
> +
> +	parent2 =3D get_merge_parent(branch2);
> +	if (!parent2)
> +		help_unknown_ref(branch2, "merge",
> +				 _("not something we can merge"));
> +
> +	init_merge_options(&opt, the_repository);
> +	/*
> +	 * TODO: Support subtree and other -X options?
> +	if (use_strategies_nr =3D=3D 1 &&
> +	    !strcmp(use_strategies[0]->name, "subtree"))
> +		opt.subtree_shift =3D "";
> +	for (x =3D 0; x < xopts_nr; x++)
> +		if (parse_merge_opt(&opt, xopts[x]))
> +			die(_("Unknown strategy option: -X%s"), xopts[x]);
> +	*/
> +
> +	opt.show_rename_progress =3D 0;
> +
> +	opt.branch1 =3D merge_remote_util(parent1)->name; /* or just branch1? =
*/
> +	opt.branch2 =3D merge_remote_util(parent2)->name; /* or just branch2? =
*/
> +
> +	/*
> +	 * Get the merge bases, in reverse order; see comment above
> +	 * merge_incore_recursive in merge-ort.h
> +	 */
> +	common =3D get_merge_bases(parent1, parent2);
> +	for (j =3D common; j; j =3D j->next)
> +		commit_list_insert(j->item, &merge_bases);
> +
> +	/*
> +	 * TODO: notify if merging unrelated histories?

I guess that it would make most sense to add a flag whether this is
allowed or not, and I would suggest the default to be `off`.

> +	if (!common)
> +		fprintf(stderr, _("merging unrelated histories"));
> +	 */
> +
> +	merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
> +	printf("%s\n", oid_to_hex(&result.tree->object.oid));
> +	merge_switch_to_result(&opt, NULL, &result, 0, 0);

This looks to be idempotent to `merge_finalize(&opt, &result)`, so maybe
use that instead?

> +	return result.clean ? 0 : 1;
>  }
>
>  int cmd_merge_tree(int argc, const char **argv, const char *prefix)
> diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
> new file mode 100755
> index 00000000000..f7aa310f8c1
> --- /dev/null
> +++ b/t/t4301-merge-tree-real.sh
> @@ -0,0 +1,81 @@
> +#!/bin/sh
> +
> +test_description=3D'git merge-tree --real'
> +
> +. ./test-lib.sh
> +
> +# This test is ort-specific
> +GIT_TEST_MERGE_ALGORITHM=3Dort
> +export GIT_TEST_MERGE_ALGORITHM

It might make sense to skip the entire test if the user asked for
`recursive` to be tested:

	test "${GIT_TEST_MERGE_ALGORITHM:-ort}" =3D ort ||
		skip_all=3D"GIT_TEST_MERGE_ALGORITHM !=3D ort"
		test_done
	}

> +
> +test_expect_success setup '
> +	test_write_lines 1 2 3 4 5 >numbers &&
> +	echo hello >greeting &&
> +	echo foo >whatever &&
> +	git add numbers greeting whatever &&
> +	git commit -m initial &&

I would really like to encourage the use of `test_tick`. It makes the
commit consistent, just in case you run into an issue that depends on some
hash order.

> +
> +	git branch side1 &&
> +	git branch side2 &&
> +
> +	git checkout side1 &&

Please use `git switch -c side1` or `git checkout -b side1`: it is more
compact than `git branch ... && git checkout ...`.

> +	test_write_lines 1 2 3 4 5 6 >numbers &&
> +	echo hi >greeting &&
> +	echo bar >whatever &&
> +	git add numbers greeting whatever &&
> +	git commit -m modify-stuff &&
> +
> +	git checkout side2 &&

This could be written as `git checkout -b side2 HEAD^`, to make the setup
more succinct.

> +	test_write_lines 0 1 2 3 4 5 >numbers &&
> +	echo yo >greeting &&
> +	git rm whatever &&
> +	mkdir whatever &&
> +	>whatever/empty &&
> +	git add numbers greeting whatever/empty &&
> +	git commit -m other-modifications
> +'
> +
> +test_expect_success 'Content merge and a few conflicts' '
> +	git checkout side1^0 &&
> +	test_must_fail git merge side2 &&
> +	cp .git/AUTO_MERGE EXPECT &&
> +	E_TREE=3D$(cat EXPECT) &&

The file `EXPECT` is not used below. And can we use a more obvious name?
SOmething like:

	expected_tree=3D$(cat .git/AUTO_MERGE)

> +	git reset --hard &&

For an extra bonus, we could delay this via `test_when_finished`, to prove
that `git merge-tree --real` works even in a dirty worktree _with
conflicts_.

> +	test_must_fail git merge-tree --real side1 side2 >RESULT &&
> +	R_TREE=3D$(cat RESULT) &&

How about `actual_tree` instead?

> +
> +	# Due to differences of e.g. "HEAD" vs "side1", the results will not
> +	# exactly match.  Dig into individual files.
> +
> +	# Numbers should have three-way merged cleanly
> +	test_write_lines 0 1 2 3 4 5 6 >expect &&
> +	git show ${R_TREE}:numbers >actual &&
> +	test_cmp expect actual &&
> +
> +	# whatever and whatever~<branch> should have same HASHES
> +	git rev-parse ${E_TREE}:whatever ${E_TREE}:whatever~HEAD >expect &&
> +	git rev-parse ${R_TREE}:whatever ${R_TREE}:whatever~side1 >actual &&
> +	test_cmp expect actual &&
> +
> +	# greeting should have a merge conflict
> +	git show ${E_TREE}:greeting >tmp &&
> +	cat tmp | sed -e s/HEAD/side1/ >expect &&
> +	git show ${R_TREE}:greeting >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'Barf on misspelled option' '
> +	# Mis-spell with single "s" instead of double "s"
> +	test_expect_code 129 git merge-tree --real --mesages FOOBAR side1 side=
2 2>expect &&
> +
> +	grep "error: unknown option.*mesages" expect
> +'

I do not think that this test case adds much, and we already test the
`parse_options()` machinery elsewhere.

> +
> +test_expect_success 'Barf on too many arguments' '
> +	test_expect_code 129 git merge-tree --real side1 side2 side3 2>expect =
&&
> +
> +	grep "^usage: git merge-tree" expect
> +'
> +
> +test_done

The rest looks awesome. Thank you for working on it! I will definitely
come back to review the rest (have to take a break now), and then probably
add quite a bit of food for thought based on my experience _actually_
using `merge-ort` on the server-side. Stay tuned.

Thank you,
Dscho

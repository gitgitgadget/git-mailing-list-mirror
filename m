Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4521EEB56E
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 22:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344185AbjIHWzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 18:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245651AbjIHWzr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 18:55:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927491FEA
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 15:55:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7c676651c7so7023040276.1
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 15:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694213742; x=1694818542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BLzMzKTnzHRqjHFzN3MFvAogyJuSsYDc7Sb4Wjjmnok=;
        b=Vl/O0nmkzlg6TOHo3FRRYKkVVYjP3rffMukxM2VVYwHLwd2erKyCq+qK1t7rFlsoFU
         X2vn+XiImjDXgMF0MKu6TrkmNZ23z70usf0xAjBp3H/5v8ujG6rWXw2LHmVW06ig3FFW
         V/MK43bMjtwsRv8Uy0yCVU0YdRd7ehdTcZiZ10xkbjqybN8xj4lZCe3laA/15iWdjTph
         UdLIJPrM0dLEcbSA3L2FhEA0HwDyMS27wejTuHYjVxhIzrF6artYwAUlGXG2+LwqQCtS
         q+DGlHpUKReomy/KagKoK/a6ZCGZYo7LPcZfQ1cmMfMNbbZOW8zZGtOMo/tLhI44jda/
         hkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694213742; x=1694818542;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BLzMzKTnzHRqjHFzN3MFvAogyJuSsYDc7Sb4Wjjmnok=;
        b=f26I0QYDMEDa23egakSFxd/PHRqTN14z/r0vTZ9izTxqwGdXw9Cw3ZuTE4KtOtJoZO
         brCOA7oSxU7rJT/w5HFaSIT5xKoD3uIEc5NFR+LbQgnz29mP870fIyYBfba9WAqgxqZq
         KFtNtvnH3Cc2K/pvbchczrnk72Ofx/EYIIshE49z8r33sWs8iKtaGSes45uXrzTEg6aq
         yOSpRDirS7WHd1QhK9ciaapupkSaUapbkDm13iFfEsSIIqXR1TevG0N+EXGW7oSP1a1D
         SJhudFnFwdxOMxMQ/WSWeLa4Xtjtad1m9RYuCDqv1m52YtmRULszvyQXCfq7kzpFBeTr
         7qiA==
X-Gm-Message-State: AOJu0YxVqg+dXYWuC/zH4Fcy59b/68eoo8g5mbemYHwBMW0TzBM3l8wC
        EDhsifFxbypc3KAlZ6ixYct8SSU9iqI=
X-Google-Smtp-Source: AGHT+IH100lC5gsR0B+vrCrHe/o31Ihzr5dCVW9ytbJ9K2WKikYAvakN+jIzy4bkN/54T6HVwm6DodISn58=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1024:b0:d7e:c4af:22d2 with SMTP id
 x4-20020a056902102400b00d7ec4af22d2mr227744ybt.4.1694213741830; Fri, 08 Sep
 2023 15:55:41 -0700 (PDT)
Date:   Fri, 08 Sep 2023 15:55:40 -0700
In-Reply-To: <20230907092521.733746-12-christian.couder@gmail.com>
Mime-Version: 1.0
References: <20230602102533.876905-1-christian.couder@gmail.com>
 <20230907092521.733746-1-christian.couder@gmail.com> <20230907092521.733746-12-christian.couder@gmail.com>
Message-ID: <owlyo7icl1g3.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 11/15] replay: use standard revision ranges
From:   Linus Arver <linusa@google.com>
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

I am only reviewing the docs. To assume the mindset of a Git user
unfamiliar with this command, I purposely did not read the cover letter
until after this review was done.

Christian Couder <christian.couder@gmail.com> writes:

> [...]
>
> diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
> new file mode 100644
> index 0000000000..9a2087b01a
> --- /dev/null
> +++ b/Documentation/git-replay.txt
> @@ -0,0 +1,90 @@
> +git-replay(1)
> +=============
> +
> +NAME
> +----
> +git-replay - Replay commits on a different base, without touching working tree

How about using the same language ("new location") as in the DESCRIPTION
heading? Also, the "without touching working tree" part is incomplete
because as explained later on, the index and refs are also left alone.
How about just "safely"?

    git-replay - Replay commits onto a new location, safely

> +SYNOPSIS
> +--------
> +[verse]
> +'git replay' --onto <newbase> <revision-range>...
> +
> +DESCRIPTION
> +-----------
> +
> +Takes a range of commits, and replays them onto a new location.

OK.

> Does
> +not touch the working tree or index, and does not update any
> +references.

How about this version?

    The new commits are created without modifying the working tree,
    index, or any references.

Also, by "references" we mean the refs in ".git/refs/*". In the
gitrevisions man page we use the term "refnames" to refer to these bits,
so maybe "refnames" is better than "references"? The simpler "branches"
is another option.

> However, the output of this command is meant to be used
> +as input to `git update-ref --stdin`, which would update the relevant
> +branches.

Before we get to this sentence, it would be great to explain why this
command is useful (what problem does it solve)?

Also, it would help to add "(see OUTPUT section below)" as a
navigational aid in case some readers are wondering what the output
looks like (and have not yet gotten to that section).

I've noticed that you're using the phrase "starting point" in the
OPTIONS section. I think this is better than "location" or "base" (FWIW
we started using "starting point" in 0a02ca2383 (SubmittingPatches:
simplify guidance for choosing a starting point, 2023-07-14)).

The following is a version of this section that attempts to address my
comments above (I've included the other bits already reviewed earlier to
make it easier to read):

    Takes a range of commits, and replays them onto a new starting
    point. The new commits are created without modifying the working
    tree, index, or any branches. If there are branches that point to
    the commits in <revision-range>, list them in the output with both
    the original commit hash and the corresponding (replayed) commit
    hash (see OUTPUT section below) .

    This command is like linkgit:git-rebase[1], but notably does not
    require a working tree or index. This means you can run this command
    in a bare repo (useful for server-side environments). And because
    nothing is modified (only new commits are created), it's like a "dry
    run" rebase.

    By combining this command with `git update-ref --stdin`, the
    relevant branches can be updated. That is, the branches that were
    pointing originally to the commits given in the <revision-range>
    will be updated to point to the replayed commits. This is similar to
    the way how `git rebase --update-refs` updates multiple branches in
    the affected range.

> +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> +
> +OPTIONS
> +-------
> +
> +--onto <newbase>::

How about 'starting-point' instead of 'newbase'?

> +	Starting point at which to create the new commits.  May be any
> +	valid commit, and not just an existing branch name.

Add "See linkgit:gitrevisions[7]." at the end?

> +The update-ref command(s) in the output will update the branch(es) in
> +the revision range to point at the new commits, similar to the way how
> +`git rebase --update-refs` updates multiple branches in the affected
> +range.

Ah, good example. I've moved this to my larger example above, so I don't
think this paragraph is needed here any more (it probably didn't belong
in OPTIONS anyway).

> +<revision-range>::
> +	Range of commits to replay; see "Specifying Ranges" in
> +	linkgit:git-rev-parse.

OK.

> +OUTPUT
> +------
> +
> +When there are no conflicts, the output of this command is usable as
> +input to `git update-ref --stdin`.

What happens if there are conflicts? Probably good to mention in the
DISCUSSION section. Some questions you may want to answer for the
reader:

(1) Is git-replay an all-or-nothing operation? That is, if there are any
conflicts, is the output always empty (or do we still output those
branches that *can* be updated without conflicts)?

(2) What is meant by "conflict" for git-replay? Is it the same meaning
as the case for git-rebase?

For (1), in your cover letter under "# Important limitations" you say
"No resumability" but I am not sure if this means git-replay will output
*something* before exiting with an error, or simply nothing at all.

Speaking of the limitations section, perhaps it's worth pointing those
out under DISCUSSION as well?

> It is basically of the form:

Why "basically"? Are there cases where the output can be different than
the example given below? If not, then perhaps drop the word "basically"?

> +	update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
> +	update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
> +	update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
> +
> +where the number of refs updated depends on the arguments passed and
> +the shape of the history being replayed.

Let's use "number of branches" instead of "number of refs" here to be
consistent with the language elsewhere.

> +EXIT STATUS
> +-----------
> +
> +For a successful, non-conflicted replay, the exit status is 0.  When
> +the replay has conflicts, the exit status is 1.

OK.

> If the replay is not
> +able to complete (or start) due to some kind of error, the exit status
> +is something other than 0 or 1.

Not sure how useful "due to some kind of error" is here --- presumably
the inability to replay is always due to some kind of error.

Would it be worth including a brief explanation about why git-replay
might be unable to complete or start (is this behavior in practice a
common-enough thing to document here)?

> +EXAMPLES
> +--------
> +
> +To simply rebase mybranch onto target:

Looking at the CLI arguments, I think this phrase should be:

    Replay the commits in `origin/main..mybranch` onto `target`:

> +------------
> +$ git replay --onto target origin/main..mybranch
> +update refs/heads/mybranch ${NEW_mybranch_HASH} ${OLD_mybranch_HASH}
> +------------
> +
> +When calling `git replay`, one does not need to specify a range of
> +commits to replay using the syntax `A..B`; any range expression will
> +do:
> +
> +------------
> +$ git replay --onto origin/main ^base branch1 branch2 branch3

Instead of `base`, how about `olderbranch`?

> +update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
> +update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
> +update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
> +------------
> +
> +This will simultaneously rebase branch1, branch2, and branch3 -- all
> +commits they have since base, playing them on top of origin/main.

How about

    This will rebase the commits in `branch1`, `branch2`, and `branch3`
    (excluding those in `base`), preplaying them on top of `origin/main`.

> +These three branches may have commits on top of base that they have in
> +common, but that does not need to be the case.

s/base/`base`

> +GIT
> +---
> +Part of the linkgit:git[1] suite

One question I do have is what happens if you run git-replay twice
(successfully)? Does the second invocation create another set of (new)
successfully replayed commits? I ask because I'm interested in informing
the readers of our docs about any potential pitfalls from abusing this
command by mistake.

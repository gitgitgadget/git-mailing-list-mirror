Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF4EE92FC6
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 21:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjJEVYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 17:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJEVYK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 17:24:10 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AE395
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 14:24:09 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEED51AE02B;
        Thu,  5 Oct 2023 17:24:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=rpUVdQw59UAwtN2DTjUzxpsY1duPWqIV9qGonk
        7XQAA=; b=gFn2Q09gtXlXAGNdPI8Upz1BjJqSlbfqbLOJvHtSrJCCGQSbEHbh9+
        5RK2puke9EMFZ0Vl33xdQW0BRnwKgh01rMjqGOtJ8ExK56+vXmMwlruGLaMW7c8p
        zuhfsTAm20qwnodg8NDQRzG/t/M0aeqyyz+8ho9JGRY6r+Nso/N2o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C66B71AE02A;
        Thu,  5 Oct 2023 17:24:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 314FA1AE029;
        Thu,  5 Oct 2023 17:24:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] diff-merges: improve --diff-merges documentation
In-Reply-To: <20231004214558.210339-2-sorganov@gmail.com> (Sergey Organov's
        message of "Thu, 5 Oct 2023 00:45:56 +0300")
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20231004214558.210339-1-sorganov@gmail.com>
        <20231004214558.210339-2-sorganov@gmail.com>
Date:   Thu, 05 Oct 2023 14:24:06 -0700
Message-ID: <xmqq34yog3ux.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84C34B4E-63C5-11EE-B099-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> ---diff-merges=(off|none|on|first-parent|1|separate|m|combined|c|dense-combined|cc|remerge|r)::
> +-m::
> +	Show diffs for merge commits in the default format. This is
> +	similar to '--diff-merges=on' (which see) except `-m` will
> +	produce no output unless `-p` is given as well.

I think the sentence reads better without the translated (q.v.) that
confused Eric.

> +-c::
> +	Produce combined diff output for merge commits.
> +	Shortcut for '--diff-merges=combined -p'.
> +
> +--cc::
> +	Produce dense combined diff output for merge commits.
> +	Shortcut for '--diff-merges=dense-combined -p'.

Good.

> +--remerge-diff::
> +	Produce diff against re-merge.
> +	Shortcut for '--diff-merges=remerge -p'.

I suspect that many people do not get what "re-merge" in "against
re-merge" really is.  As "combined diff" and "dense combined diff"
are not explained in the previous two entries either, and expect the
readers to read the real description (which more or less matches
what the original description for "-c" and "--cc" had, which is
good), it would be better to say "Produce remerge-diff output for
merge commits."  here, too.  It makes it consistent, and "for merge
commits" makes it clear the "magic" does not apply to regular
commits (which the above entries for "-c" and "--cc" do, which is
very good).

>  --no-diff-merges::
> +	Synonym for '--diff-merges=off'.
> +
> +--diff-merges=<format>::
>  	Specify diff format to be used for merge commits. Default is
> -	{diff-merges-default} unless `--first-parent` is in use, in which case
> -	`first-parent` is the default.
> +	{diff-merges-default} unless `--first-parent` is in use, in
> +	which case `first-parent` is the default.

This reads well.

In the longer term, "--diff-merge=first-parent" that is used without
first-parent traversal should be discouraged and be deprecated, I
think, but that is a separate story [*].

> ---diff-merges=(off|none):::
> ---no-diff-merges:::
> +The following formats are supported:
> ++
> +--
> +off, none::
>  	Disable output of diffs for merge commits. Useful to override
>  	implied value.
>  +
> ---diff-merges=on:::
> ---diff-merges=m:::
> --m:::
> -	This option makes diff output for merge commits to be shown in
> -	the default format. `-m` will produce the output only if `-p`
> -	is given as well. The default format could be changed using
> +on, m::
> +	Make diff output for merge commits to be shown in the default
> +	format. The default format could be changed using
>  	`log.diffMerges` configuration parameter, which default value
>  	is `separate`.

The original is already wrong so these are not problems this patch
introduces, but

 - "configuration variable" is how we refer to these entities.
 - "which default value" -> "whose default value".

> ---diff-merges=first-parent:::
> ---diff-merges=1:::
> -	This option makes merge commits show the full diff with
> -	respect to the first parent only.
> +first-parent, 1::
> +	Show full diff with respect to first parent. This is the same
> +	format as `--patch` produces for non-merge commits.
>  +

Yes, this is the same output as `-p`, as if parents other than the
first parent of the merge commit did not exist.

This was inherited from the original elsewhere, but it makes it
unnecessary confusing to say "full diff" here and in the next one.

    Show `--patch` output with respoect to the first parent for a
    merge commit, as if the other parents did not exist.

perhaps?

> +separate::
> +	Show full diff with respect to each of parents.
> +	Separate log entry and diff is generated for each parent.

In the early days of Git before -c/--cc were invented, we explained
this mode as "pairwise comparison", and the phrase "pairwise" still
may be the best one to describe the behaviour here.  In fact, we see
in the updated description of combined below the exact phrase is used
to refer to this oldest output format.

    Show the `--patch` output pairwise, together with the commit
    header, repeated for each parent for a merge commit.

or something, perhaps.  I added "repeated" here to make the contrast
with "simultaneously" stand out.

> +combined, c::
> +	Show differences from each of the parents to the merge
> +	result simultaneously instead of showing pairwise diff between
> +	a parent and the result one at a time. Furthermore, it lists
> +	only files which were modified from all parents.
> ++
> +dense-combined, cc::
> +	Further compress output produced by `--diff-merges=combined`
> +	by omitting uninteresting hunks whose contents in the parents
> +	have only two variants and the merge result picks one of them
> +	without modification.
> ++
> +remerge, r::
> +	Remerge two-parent merge commits to create a temporary tree
> +	object--potentially containing files with conflict markers
> +	and such.  A diff is then shown between that temporary tree
> +	and the actual merge commit.

The original says "two-parent merge comimts are remerged" so it is
not a failure of this patch, but the first verb "Remerge" sounds
unnecessarily unfriendly to the readers.

	For a two-parent merge commit, a merge of these two commits
	is retried to create a temporary tree object, potentially
	containing files with conflict markers.  A `--patch` output
	then is shown between ...

would be easier to follow and more faithful to the original
description added by db757e8b (show, log: provide a --remerge-diff
capability, 2022-02-02).

Either way, it makes readers wonder what happens to merges with more
than 2 parents (octopus merges).  It is not a new problem and this
topic should not attempt to fix it.

Looks very good otherwise.  Let me read on.

Thanks.


[Footnote]

* When a project allows fast-forward merges, something like this can
  happen (and Git was _designed_ to allow and even encourage it)

  - Linus pulls from Sergey and sees merge conflicts that are very
    messy.  Sergey is asked to resolve the conflict, as Linus knows
    Sergey understands the changes he is asking Linus to pull much
    better than Linus does.

  - Sergey does "git pull origin" that would give the same set of
    conflicts Linus saw, perhaps ours/theirs sides swapped, resolves
    the conflicts, and comits the merge result.  He may even add a
    few other improvements on top (or may not).  He tells Linus that
    his tree is ready to be pulled again.

  - Linus pulls from Sergey again.  This time it is fast-forward,
    without an extra merge commit that records the Linus's previous
    tip as the first parent and Sergey's work as the second parent.

  - Linus continues working from here.

  In such a workflow, merges are nothing more than "combining
  multiple histories together" and the first parenthood is NOT
  inherently special among parents at all.  The original "-m -p"
  (aka "pairwise diff") output reflects this world view and ensures
  that all parents are shown more or less as equals (yes, the first
  parent diff is shown first before the other parents, but you
  cannot avoid it when outputting to a single dimension medium).

  This world view was the only world view Git supported, until I
  added the "--first-parent" traversal in 0053e902 (git-log
  --first-parent: show only the first parent log, 2007-03-13).

  With the "--first-parent", with "--no-ff" option to "git merge", a
  different world view becomes possible.  A merge is not merely
  combining multiple histories, which are equals.  It is bringing
  work done on a side branch into the trunk.  To see the overview of
  the history, "git log --first-parent" would give the outline,
  which would be full of merges from side branches, each of which
  can be seen as summarizing the work done on the side branch that
  was merged, and it may occasionally have single-parent commits
  that are hotfixes or trivial clean-ups or project administrivia
  commits.  With "-p", "git log" would show the changes the work
  done on a side branch as a single unit for a merge, and individual
  commits if they are single-parent.  The life is good.

  It all breaks down if the "diff against the first parent" is done
  on a merge that is not bringing the work on a side branch in to
  the trunk.  The merge done in the second step Sergey did for Linus
  in the above example will have his work on the history leading to
  its first parent, and from the overall project's point of view,
  the second parent is the tip of the history of the trunk.  Showing
  first-parent diff for a merge that was *not* discovered via the
  first-parent traversal would show such a meaningless patch.  This
  is an illustration of the fallout from mixing two incompatible
  world views together, "--diff-merges=first-parent" wants to work
  in a world where the first-parent is special among parents, but
  traversal without "--first-parent" wants to treat all the branches
  equally.

  All the other <format>s accepted by the "--diff-merges=<format>"
  option are symmetrical and they work equally well when in a
  history of a project that considers the first-parenthood special
  (i.e. work on a side branch is brought into the trunk history) or
  in a history with merges whose parent order should not matter, so
  unlike "--diff-merges=first-parent", it makes sense to apply them
  with or without first-parent traversal.  It however is not true
  for the "--diff-merges=first-parent" variant, which is asymmetric.

  And that is why I think use of "--diff-merges=first-parent"
  without "--first-parent" traversal is a bad thing to teach users
  to use.

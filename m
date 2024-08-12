Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC77A1917D0
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723494656; cv=none; b=rCtUchKsBoyIBOKUIEJpkDQlBGxiNK5eVraLBFHWZeFAkhzkeZTkjs9aBq52XSJVySSQaWchI03gyTloDT6aQ24wQuiZ9/WkFo935ujQdZXFcu/HDNI45xG04frDY0GaDG18E0rLCyQFGn/sTY3030f28FTaQJc1XIOBVOFtu6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723494656; c=relaxed/simple;
	bh=ZHiIh98ZztYjSS6gmm/w/mb094IQBdnrZXoFQiNhgM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YHN40FwoDu2W5P4JnTm9pSF65awywCUIH0/YximW6XLWVLYnlssJAVEcX8JUhvxM1zSgYHIn1neeoFwIa33DPmPvnEYFOKumkLJYj80pj7B1rcFL/NJqYWgnhrOs4sQF4bqYex+GSSspVklEv0zB8fcWF1XaMercdYUF/NctulM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=palnOgUK; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="palnOgUK"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 698C82D1E7;
	Mon, 12 Aug 2024 16:30:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZHiIh98ZztYjSS6gmm/w/mb094IQBdnrZXoFQi
	NhgM8=; b=palnOgUK0MwKXzoV4MI3hr5UWpc2Xdvd+s3k78VumyG8RPAOJH3CS+
	Ebp9SN7uhiWbWtRq+zOeQsWX0jGOBmLESiPCookIgcQ0XOla5IEecw2o6WyhYEWz
	BQSbTedpliIybE7d4mqkVev3JcURtZvosCHGJDTT9q67DQb9Ygxnc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 617BB2D1E6;
	Mon, 12 Aug 2024 16:30:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB0212D1E5;
	Mon, 12 Aug 2024 16:30:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  vdye@github.com,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 1/3] commit-reach: add get_branch_base_for_tip
In-Reply-To: <580026f910daaae6dba599fcd2408721b4f86c59.1723397687.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Sun, 11 Aug 2024
	17:34:45 +0000")
References: <pull.1768.git.1722550226.gitgitgadget@gmail.com>
	<pull.1768.v2.git.1723397687.gitgitgadget@gmail.com>
	<580026f910daaae6dba599fcd2408721b4f86c59.1723397687.git.gitgitgadget@gmail.com>
Date: Mon, 12 Aug 2024 13:30:45 -0700
Message-ID: <xmqqv8051o22.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C171CDBC-58E9-11EF-9C73-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> Add a new reachability algorithm that intends to discover (from a heuristic)
> which branch was used as the starting point for a given commit. Add focused
> tests using the 'test-tool reach' command.
>
> Repositories that use pull requests (or merge requests) to advance one or
> more "protected" branches, the history of that reference can be recovered by
> following the first-parent history in most cases.

I cannot quite parse it, but perhaps "Repositories that" -> "In
repositories that"?

> Most are completed using
> no-fast-forward merges, though squash merges are quite common. Less common
> is rebase-and-merge, which still validates this assumption. Finally, the
> case that breaks this assumption is the fast-forward update (with potential
> rebasing).  Even in this case, the previous commit commonly appears in the
> first-parent history of the branch.

> Given current command-line interface options, this optimization criteria is
> not easy to detect directly. Even using the command
>
>   git rev-list --count --first-parent <base>..<source>
>
> does not measure this count, as it uses full reachability from <base> to
> determine which commits to remove from the range '<base>..<source>'.

Makes me wonder if "--ancestry-path" would help.

> The trickiest part of the integer slab is what happens when reaching a
> collision among the histories of the bases and the history of the source.
> This is noticed when viewing the first parent and seeing that it has a slab
> value that differs in sign (negative or positive). In this case, the
> collision commit is stored in the method variable 'branch_point' and its
> slab value is set to -1. The index of the best base (so far) is stored in
> the method variable 'best_index'. It is possible that there are multiple
> commits that have the branch_point as its first parent, leading to multiple
> updates of best_index.  The result is determined when 'branch_point' is
> visited in the commit walk, giving the guarantee that all commits that could
> reach 'branch_point' were visited.

OK.

> +/*
> + * This slab initializes integers to zero, so use "-1" for "tip is best" and
> + * "i + 1" for "bases[i] is best".
> + */
> +define_commit_slab(best_branch_base, int);
> +static struct best_branch_base best_branch_base;
> +#define get_best(c) (*best_branch_base_at(&best_branch_base, c))
> +#define set_best(c,v) (*best_branch_base_at(&best_branch_base, c) = v)

Micronit.  Prepare for macro arguments to be expressions, even if
current callers don't use anything more complex, i.e., something
like

	(*best_branch_base_at(&best_branch_base, (c)))
	(*best_branch_base_at(&best_branch_base, (c)) = (v))

> +	if (found_missing_gen) {
> +		struct commit **commits;
> +		size_t commits_nr = bases_nr + 1;
> +
> +		CALLOC_ARRAY(commits, commits_nr);
> +		COPY_ARRAY(commits, bases, bases_nr);
> +		commits[bases_nr] = tip;
> +		ensure_generations_valid(r, commits, commits_nr);
> +		free(commits);
> +	}

It would have been very unfortunate if this copying were done only
because commits and tip are not in the same array, but the called
function mutates the given array of commits so we cannot avoid
passing a copy anyway.  Given these constraints, this is the
cleanest implementation, probably.

> +
> +	/* Initialize queue and slab now that generations are guaranteed. */
> +	init_best_branch_base(&best_branch_base);
> +	set_best(tip, -1);
> +	prio_queue_put(&queue, tip);
> +
> +	for (size_t i = 0; i < bases_nr; i++) {
> +		struct commit *c = bases[i];
> +
> +		/* Has this already been marked as best by another commit? */
> +		if (get_best(c))
> +			continue;

Oh, so this defines the tie-breaking behaviour, but simply removing
it is a wrong solution if we wanted our tie-breaking to work as
"last one wins", as we still do not want to put it in the queue, so
this "if best is already found, skip the rest" is serving dual
purposes.  Good.

> +		set_best(c, i + 1);
> +		prio_queue_put(&queue, c);
> +	}
> +
> +	while (queue.nr) {
> +		struct commit *c = prio_queue_get(&queue);
> +		int best_for_c = get_best(c);
> +		int best_for_p, positive;
> +		struct commit *parent;
> +
> +		/* Have we reached a known branch point? It's optimal. */
> +		if (c == branch_point)
> +			break;
> +
> +		repo_parse_commit(r, c);
> +		if (!c->parents)
> +			continue;
> +
> +		parent = c->parents->item;
> +		repo_parse_commit(r, parent);
> +		best_for_p = get_best(parent);
> +
> +		if (!best_for_p) {
> +			/* 'parent' is new, so pass along best_for_c. */
> +			set_best(parent, best_for_c);
> +			prio_queue_put(&queue, parent);
> +			continue;
> +		}
> +
> +		if (best_for_p > 0 && best_for_c > 0) {
> +			/* Collision among bases. Minimize. */
> +			if (best_for_c < best_for_p)
> +				set_best(parent, best_for_c);
> +			continue;
> +		}
> +
> +		/*
> +		 * At this point, we have reached a commit that is reachable
> +		 * from the tip, either from 'c' or from an earlier commit to
> +		 * have 'parent' as its first parent.
> +		 *
> +		 * Update 'best_index' to match the minimum of all base indices
> +		 * to reach 'parent'.
> +		 */
> +
> +		/* Exactly one is positive due to initial conditions. */
> +		positive = (best_for_c < 0) ? best_for_p : best_for_c;
> +
> +		if (best_index < 0 || positive < best_index)
> +			best_index = positive;
> +
> +		/* No matter what, track that the parent is reachable from tip. */
> +		set_best(parent, -1);
> +		branch_point = parent;
> +	}
> +
> +	clear_best_branch_base(&best_branch_base);
> +	clear_prio_queue(&queue);

OK.  We get rid of the slab and prio-queue once we are done.
Nice.

Thanks.



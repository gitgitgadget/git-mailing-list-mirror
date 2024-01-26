Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EAE1D541
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706284911; cv=none; b=uPxwgCms7QqcwhQLoCncbEATGEUtX0l/JmCJcrlyEIWQnLwHWq9eiIgc1xxNTAaWEJ+qtNzyRuNuEl/wAIMng1PUM2Sjx6o2bW7/GSwloAwZYfrSzicj6Aa0mouGxShcUVXGUdhMt3x9pocJ+ZPSrE56cMYePMYFkuX65YCviAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706284911; c=relaxed/simple;
	bh=F3E6yoAWEmV/Y3inbgkSM/VCzWM71l0GUS+FEwrQ/Mw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s7ZZbn06OV+KS/6w0EC46e01VMZpajOF/U+dE08tcaKHtPZ08iJwh7r6okwStg+QgKRG8hDA4Vo046NMLNkpLvrRk1xL8GqNJWH+g33UzClHBKcQ+nbm8WYPkIyadyPkMbZxKwZM29x2C6I0GbESYM+K9REo0gHN4pTCYgG93o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RdhY7vDa; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RdhY7vDa"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id ACFAB3452B;
	Fri, 26 Jan 2024 11:01:43 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=F3E6yoAWEmV/Y3inbgkSM/VCzWM71l0GUS+FEw
	rQ/Mw=; b=RdhY7vDaZOKdEOZYAL5jDPYPy+jQHiPKvi9RjZqP8Ta99Eqz09gMpT
	RK0JL65vweH6uCImzikcOw02CwkSoBrF6T08pcBYznBQ98gyCewT4+4MfIV902fl
	Tg0Quw3qplndE2aMdXFlpAUDXTYmOIg727bIhwDmZ6BawRJuTb1ls=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A51D63452A;
	Fri, 26 Jan 2024 11:01:43 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4C07534525;
	Fri, 26 Jan 2024 11:01:40 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] merge-tree: accept 3 trees as arguments
In-Reply-To: <pull.1647.git.1706277694231.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Fri, 26 Jan 2024 14:01:34
	+0000")
References: <pull.1647.git.1706277694231.gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 08:01:38 -0800
Message-ID: <xmqqplxoozh9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 31333EEC-BC64-11EE-9753-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When specifying a merge base explicitly, there is actually no good
> reason why the inputs need to be commits: that's only needed if the
> merge base has to be deduced from the commit graph.

yes, Yes, YES, YEAHHHHH!

>     I was asked to implement this at $dayjob and it seems like a feature
>     that might be useful to other users, too.

Yup, I think it is an obvious building block for machinery to
perform any mergy operation to grow history.  Many of the time you
may have a commit, but requiring them to be commits when you know
you will not do a virtual ancestor synthesis smells fundamentally
wrong.  Thanks for fixing it.

> ---merge-base=<commit>::
> +--merge-base=<tree-ish>::
>  	Instead of finding the merge-bases for <branch1> and <branch2>,
>  	specify a merge-base for the merge, and specifying multiple bases is
>  	currently not supported. This option is incompatible with `--stdin`.
> ++
> +As the merge-base is provided directly, <branch1> and <branch2> do not need
> +o specify commits; it is sufficient if they specify trees.

"... do not need to specify commits; trees are enough"?

> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 3bdec53fbe5..cbd8e15af6d 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -429,35 +429,43 @@ static int real_merge(struct merge_tree_options *o,
>  	struct merge_options opt;
>  
>  	copy_merge_options(&opt, &o->merge_options);
> -	parent1 = get_merge_parent(branch1);
> -	if (!parent1)
> -		help_unknown_ref(branch1, "merge-tree",
> -				 _("not something we can merge"));
> -
> -	parent2 = get_merge_parent(branch2);
> -	if (!parent2)
> -		help_unknown_ref(branch2, "merge-tree",
> -				 _("not something we can merge"));
> -
>  	opt.show_rename_progress = 0;
>  
>  	opt.branch1 = branch1;
>  	opt.branch2 = branch2;
>  
>  	if (merge_base) {
> -		struct commit *base_commit;
>  		struct tree *base_tree, *parent1_tree, *parent2_tree;
>  
> -		base_commit = lookup_commit_reference_by_name(merge_base);
> -		if (!base_commit)
> -			die(_("could not lookup commit '%s'"), merge_base);
> +		/*
> +		 * We actually only need the trees because we already
> +		 * have a merge base.
> +		 */
> +		struct object_id base_oid, head_oid, merge_oid;
> +
> +		if (repo_get_oid_treeish(the_repository, merge_base, &base_oid))
> +			die(_("could not parse as tree '%s'"), merge_base);
> +		base_tree = parse_tree_indirect(&base_oid);
> +		if (repo_get_oid_treeish(the_repository, branch1, &head_oid))
> +			die(_("could not parse as tree '%s'"), branch1);
> +		parent1_tree = parse_tree_indirect(&head_oid);
> +		if (repo_get_oid_treeish(the_repository, branch2, &merge_oid))
> +			die(_("could not parse as tree '%s'"), branch2);
> +		parent2_tree = parse_tree_indirect(&merge_oid);
>  
>  		opt.ancestor = merge_base;
> -		base_tree = repo_get_commit_tree(the_repository, base_commit);
> -		parent1_tree = repo_get_commit_tree(the_repository, parent1);
> -		parent2_tree = repo_get_commit_tree(the_repository, parent2);
>  		merge_incore_nonrecursive(&opt, base_tree, parent1_tree, parent2_tree, &result);
>  	} else {
> +		parent1 = get_merge_parent(branch1);
> +		if (!parent1)
> +			help_unknown_ref(branch1, "merge-tree",
> +					 _("not something we can merge"));
> +
> +		parent2 = get_merge_parent(branch2);
> +		if (!parent2)
> +			help_unknown_ref(branch2, "merge-tree",
> +					 _("not something we can merge"));
> +
>  		/*
>  		 * Get the merge bases, in reverse order; see comment above
>  		 * merge_incore_recursive in merge-ort.h

OK.  The changes here look quite straight-forward.

> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
> index 12ac4368736..71f21bb834f 100755
> --- a/t/t4301-merge-tree-write-tree.sh
> +++ b/t/t4301-merge-tree-write-tree.sh
> @@ -945,4 +945,12 @@ test_expect_success 'check the input format when --stdin is passed' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '--merge-base with tree OIDs' '
> +	git merge-tree --merge-base=side1^ side1 side3 >tree &&
> +	tree=$(cat tree) &&
> +	git merge-tree --merge-base=side1^^{tree} side1^{tree} side3^{tree} >tree2 &&
> +	tree2=$(cat tree2) &&
> +	test $tree = $tree2
> +'

You do not need $tree and $tree2 variables that would make it harder
to diagnose a failure case when we break merge-tree.  You have tree
and tree2 as files, and I think it is sufficient to do

	git merge-tree ... >result-from-commits &&
	git merge-tree ... >result-from-trees &&
	test_cmp result-from-commits result-from-trees

(no, I am not suggesting to rename these tree and tree2 files; I
just needed them to be descriptive in my illustration to show what
is going on to myself).

Thanks.

Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17763DB9A
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624717; cv=none; b=FcfXH+nvTasJZfUfcFY95vUtJy293Lqp3H9UljGJmlRrZprNh+h/I3VBG3W9vD+vhG6R1mc2w9F031d4wM6WKMGI05BN+xidbyCR/aFMBPXFhpXk9TkWARZ8k8i/dQXlpJwMuuUqqmtRHN7q+7R3gZDUMRii20QA1rllu7i6G2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624717; c=relaxed/simple;
	bh=zGKbcE5N0eFdolXA8sJzP8w5xGPi26AcLksgHY+jR8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TxpBZBLU39M3WiqtNdvzMF8wIL+wrX4P5L1HWU3IRUNiJZOVnu57GeaCtldLecNXp0fTqueXSptzchOKwbC7BNG39EQ1dHo4fMDO2dbKNsXtZPnzat/TGpzXMPt0/A1wUsf8xnalIi8j3kMbQHL3cLec0SMT02E53iz1y87GUWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QtIn932n; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QtIn932n"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EEAF1D64C2;
	Thu, 22 Feb 2024 12:58:34 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zGKbcE5N0eFdolXA8sJzP8w5xGPi26AcLksgHY
	+jR8g=; b=QtIn932n0kD+Aa/JUUVk5+TJAr3Nk7DgiTXSUMY5sz8TpECRoYf15l
	HMLk7A+zFGob8wKiFTSte6rRds/gefVBKqpcvHIMWEFF2W2B4MeGW5TZLa55/n9i
	ALhx/DOh8K7mV7ou1V/Fau34/hOsLgG/FtFNcbm1O189NSEGZ5l1o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 954F61D64C1;
	Thu, 22 Feb 2024 12:58:34 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 090B71D64C0;
	Thu, 22 Feb 2024 12:58:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 4/5] Always check `parse_tree*()`'s return value
In-Reply-To: <9e4dc94ef036882c3ce27208ca9fa545d018f199.1708612605.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 22 Feb 2024
	14:36:44 +0000")
References: <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
	<pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
	<9e4dc94ef036882c3ce27208ca9fa545d018f199.1708612605.git.gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 09:58:32 -0800
Message-ID: <xmqqplwoe5yv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FEDD1168-D1AB-11EE-B0FB-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> @@ -707,7 +707,8 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
>  	init_checkout_metadata(&opts.meta, info->refname,
>  			       info->commit ? &info->commit->object.oid : null_oid(),
>  			       NULL);
> -	parse_tree(tree);
> +	if (parse_tree(tree) < 0)
> +		return 128;

The other error returned from this function is when unpack_trees()
fails well before the writeout phase and the value we return is also
128, so the caller is prepared to act on it.  OK.

> @@ -786,9 +787,15 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  		if (new_branch_info->commit)
>  			BUG("'switch --orphan' should never accept a commit as starting point");
>  		new_tree = parse_tree_indirect(the_hash_algo->empty_tree);
> -	} else
> +		if (!new_tree)
> +			BUG("unable to read empty tree");

parse_tree() of the_hash_algo->empty_tree should result in a tree
object without having to even consult the object store, so BUG(),
not die(), is very much appropriate here.  OK.

> +	} else {
>  		new_tree = repo_get_commit_tree(the_repository,
>  						new_branch_info->commit);
> +		if (!new_tree)
> +			return error(_("unable to read tree %s"),
> +				     oid_to_hex(&new_branch_info->commit->object.oid));

We can help translators by enclosing %s inside a pair of parentheses.

    $ git grep -h 'msgid .*unable to read tree' po | sort | uniq -c
     18 msgid "unable to read tree (%s)"

FYI, the message with "(%s)" is shared by four places; there is one
instance of the message without parentheses added very recently that
forced .po files to have both entries.  We probably should unify them
to use the one with more existing users.

> @@ -823,7 +830,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  				oid_to_hex(old_commit_oid));
>  
>  		init_tree_desc(&trees[0], tree->buffer, tree->size);
> -		parse_tree(new_tree);
> +		if (parse_tree(new_tree) < 0)
> +			exit(128);

There is another exit() in the same else clause this code is in, and
upon failing to unpack_trees(), that call exits with 128.  This
parse_tree() is about preparing the input for that call, so it makes
sense to exit with the same code.  Excellent.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index c6357af9498..4410b55be98 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -736,7 +736,8 @@ static int checkout(int submodule_progress, int filter_submodules)
>  	tree = parse_tree_indirect(&oid);
>  	if (!tree)
>  		die(_("unable to parse commit %s"), oid_to_hex(&oid));
> -	parse_tree(tree);
> +	if (parse_tree(tree) < 0)
> +		exit(128);
>  	init_tree_desc(&t, tree->buffer, tree->size);
>  	if (unpack_trees(1, &t, &opts) < 0)
>  		die(_("unable to checkout working tree"));

Exactly the same reasoning applies, as die() exits with 128.

We may want to "#define EXIT_DIE 128" and use it in appropriate
places to make such a reasoning/review easier (possibly an entry for
#leftoverbits)?

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 781af2e206c..0723f06de7a 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -339,7 +339,8 @@ static void create_base_index(const struct commit *current_head)
>  	tree = parse_tree_indirect(&current_head->object.oid);
>  	if (!tree)
>  		die(_("failed to unpack HEAD tree object"));
> -	parse_tree(tree);
> +	if (parse_tree(tree) < 0)
> +		exit(128);
>  	init_tree_desc(&t, tree->buffer, tree->size);
>  	if (unpack_trees(1, &t, &opts))
>  		exit(128); /* We've already reported the error, finish dying */

Ditto.

> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> index 8196ca9dd85..5923ed36893 100644
> --- a/builtin/read-tree.c
> +++ b/builtin/read-tree.c
> @@ -263,7 +263,8 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
>  	cache_tree_free(&the_index.cache_tree);
>  	for (i = 0; i < nr_trees; i++) {
>  		struct tree *tree = trees[i];
> -		parse_tree(tree);
> +		if (parse_tree(tree) < 0)
> +			return 128;
>  		init_tree_desc(t+i, tree->buffer, tree->size);
>  	}
>  	if (unpack_trees(nr_trees, t, &opts))

Ditto.  After the post-context we also return 128.

> diff --git a/builtin/reset.c b/builtin/reset.c
> index 4b018d20e3b..f030f57f4e9 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -119,6 +119,10 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
>  
>  	if (reset_type == MIXED || reset_type == HARD) {
>  		tree = parse_tree_indirect(oid);
> +		if (!tree) {
> +			error(_("unable to read tree %s"), oid_to_hex(oid));
> +			goto out;
> +		}
>  		prime_cache_tree(the_repository, the_repository->index, tree);
>  	}

Good.

> diff --git a/cache-tree.c b/cache-tree.c
> index 641427ed410..c6508b64a5c 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -779,8 +779,8 @@ static void prime_cache_tree_rec(struct repository *r,
>  			struct cache_tree_sub *sub;
>  			struct tree *subtree = lookup_tree(r, &entry.oid);
>  
> -			if (!subtree->object.parsed)
> -				parse_tree(subtree);
> +			if (!subtree->object.parsed && parse_tree(subtree) < 0)
> +				exit(128);
>  			sub = cache_tree_sub(it, entry.path);
>  			sub->cache_tree = cache_tree();

The cache_tree() used to be just an optimization mechanism, but
there is no other way than fully populating it to write a tree
object out of the index, so dying here is the only sensible thing to
do upon unparseable subtree.  Otherwise we would end up silently
writing a bogus result.  Good.

> diff --git a/merge-recursive.c b/merge-recursive.c
> index e3beb0801b1..10d41bfd487 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -410,7 +410,8 @@ static inline int merge_detect_rename(struct merge_options *opt)
>  
>  static void init_tree_desc_from_tree(struct tree_desc *desc, struct tree *tree)
>  {
> -	parse_tree(tree);
> +	if (parse_tree(tree) < 0)
> +		exit(128);
>  	init_tree_desc(desc, tree->buffer, tree->size);
>  }

OK.

> diff --git a/merge.c b/merge.c
> index b60925459c2..14a7325859d 100644
> --- a/merge.c
> +++ b/merge.c
> @@ -80,7 +80,10 @@ int checkout_fast_forward(struct repository *r,
>  		return -1;
>  	}
>  	for (i = 0; i < nr_trees; i++) {
> -		parse_tree(trees[i]);
> +		if (parse_tree(trees[i]) < 0) {
> +			rollback_lock_file(&lock_file);
> +			return -1;
> +		}
>  		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
>  	}

This handles the error in the same way as the other case earlier
where any of the tree-ish failed to load.  OK.

> diff --git a/reset.c b/reset.c
> index 48da0adf851..a93fdbc12e3 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -158,6 +158,11 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
>  	}
>  
>  	tree = parse_tree_indirect(oid);
> +	if (!tree) {
> +		ret = error(_("unable to read tree %s"), oid_to_hex(oid));
> +		goto leave_reset_head;
> +	}

OK, but the _("unable to read tree (%s)") comment applies here, too.

> diff --git a/sequencer.c b/sequencer.c
> index d584cac8ed9..407473bab28 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -715,6 +715,8 @@ static int do_recursive_merge(struct repository *r,
>  	o.show_rename_progress = 1;
>  
>  	head_tree = parse_tree_indirect(head);
> +	if (!head_tree)
> +		return error(_("unable to read tree %s"), oid_to_hex(head));
>  	next_tree = next ? repo_get_commit_tree(r, next) : empty_tree(r);
>  	base_tree = base ? repo_get_commit_tree(r, base) : empty_tree(r);

Ditto.

> @@ -3887,6 +3889,8 @@ static int do_reset(struct repository *r,
>  	}
>  
>  	tree = parse_tree_indirect(&oid);
> +	if (!tree)
> +		return error(_("unable to read tree %s"), oid_to_hex(&oid));

Ditto.

>  	prime_cache_tree(r, r->index, tree);
>  
>  	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0)

Looking good, modulo the additional translator burden.

Thanks.

Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486B482ED
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921130; cv=none; b=ro9b9LrC9TxqKIYltY8XjfaGQuL0ldxxjDryZNKEbvOLDoAAhDB+Mza4blOCNivbG34skKi2tsAr4S0Zd/DDLSPp3F1p26M/7NEEdCGS+KA8teJ57nYVztnLAT4NgBLtJ9A+NswmPHiLzp6cTpYsIcDrLpgDkztCaZYihmUUiEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921130; c=relaxed/simple;
	bh=PNTZaonXGDJ4KKWXMLHwLLt87z37QmH4DmIkX5rh2wA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fMBAhqUMXPCuBTQr6SpflxmxYSG1qbggv4mkByROw5vSeKcAeoTtCaRxI2gC+4q7gVGXibi3qeJKoZsYqPSXa1X/0taOcY5x90jCRmo2SzSr4VfKjvupVrVUhWtSQ6hRl0vzoQ+TsPAy0yBn80Tjj9QKy5rySzF+cHSlJma9MnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yRTUmjEZ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yRTUmjEZ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B95C71A544;
	Thu, 20 Jun 2024 18:05:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PNTZaonXGDJ4KKWXMLHwLLt87z37QmH4DmIkX5
	rh2wA=; b=yRTUmjEZ+OxvUPMn57kngUNtbnmAgPg13XTiJE/T3R+5IfE1TtTosY
	4W/bpcqlZ9Ulc3tAtlIgmC4ttHi4N7gsFGHGMeoJEkWx2I55flquBTnJzIQ/ZlRM
	ZJRWOpdb1Jao1FJTkx8HFLJcsJYOa7KZw+oJsgV4cymsRJAzMHGOc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AF7DB1A543;
	Thu, 20 Jun 2024 18:05:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 246B01A541;
	Thu, 20 Jun 2024 18:05:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Patrick
 Steinhardt <ps@pks.im>,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 11/17] mktree: overwrite duplicate entries
In-Reply-To: <fb555658057f834d94f232f1d8b380a6304a3671.1718834285.git.gitgitgadget@gmail.com>
	(Victoria Dye via GitGitGadget's message of "Wed, 19 Jun 2024 21:57:59
	+0000")
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
	<fb555658057f834d94f232f1d8b380a6304a3671.1718834285.git.gitgitgadget@gmail.com>
Date: Thu, 20 Jun 2024 15:05:25 -0700
Message-ID: <xmqqh6dns21m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3352336C-2F51-11EF-99F8-965B910A682E-77302942!pb-smtp2.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> If multiple tree entries with the same name are provided as input to
> 'mktree', only write the last one to the tree. Entries are considered
> duplicates if they have identical names (*not* considering mode); if a blob
> and a tree with the same name are provided, only the last one will be
> written to the tree. A tree with duplicate entries is invalid (per 'git
> fsck'), so that condition should be avoided wherever possible.

The "should be avoided" in the last sentence can be satisified
either by the callers being extra careful, or the callee ignoring
earlier entries with the same path.  I do not have a strong
objection against allowing looser callers, but if that is what is
going on, perhaps

	By teaching "mktree" to ignore the earlier entries for the
        same path in the input, the callers can be more casual about
        sending duplicate entries in order to avoid creating an
        invalid tree objects.

is a more honest justification for this setp?

> diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
> index 5f3a6dfe38e..cf1fd82f754 100644
> --- a/Documentation/git-mktree.txt
> +++ b/Documentation/git-mktree.txt
> @@ -54,7 +54,8 @@ cannot be represented in a tree object. The command will fail without
>  writing the tree if a higher order stage is specified for any entry.
>  
>  The order of the tree entries is normalized by `mktree` so pre-sorting the
> -input by path is not required.
> +input by path is not required. Multiple entries provided with the same path
> +are deduplicated, with only the last one specified added to the tree.

OK.

>  struct tree_entry {
> +	/* Internal */
> +	size_t order;
> +
>  	unsigned mode;
>  	struct object_id oid;
>  	int len;
> @@ -74,15 +77,49 @@ static void append_to_tree(unsigned mode, struct object_id *oid, const char *pat
>  	ent->len = len;
>  	oidcpy(&ent->oid, oid);
>  
> +	ent->order = arr->nr;
>  	tree_entry_array_push(arr, ent);
>  }
>  
> -static int ent_compare(const void *a_, const void *b_)
> +static int ent_compare(const void *a_, const void *b_, void *ctx)
>  {
> +	int cmp;
>  	struct tree_entry *a = *(struct tree_entry **)a_;
>  	struct tree_entry *b = *(struct tree_entry **)b_;
> -	return base_name_compare(a->name, a->len, a->mode,
> -				 b->name, b->len, b->mode);
> +	int ignore_mode = *((int *)ctx);
> +
> +	if (ignore_mode)
> +		cmp = name_compare(a->name, a->len, b->name, b->len);
> +	else
> +		cmp = base_name_compare(a->name, a->len, a->mode,
> +					b->name, b->len, b->mode);
> +	return cmp ? cmp : b->order - a->order;
> +}

Having two similar functions that could go out of sync has bothered
me somewhat.  We could instead do

	int a_mode = ignore_mode ? 0 : a->mode;
	int b_mode = ignore_mode ? 0 : b->mode;
	cmp = base_name_compare(a->name, a->len, a_mode,
				b->name, b->len, b_mode);

but that should be done by rewriting name_compare() in terms of
base_name_compare(), which will help more callers, not just this
one.

> +static void sort_and_dedup_tree_entry_array(struct tree_entry_array *arr)
> +{
> +	size_t count = arr->nr;
> +	struct tree_entry *prev = NULL;
> +
> +	int ignore_mode = 1;
> +	QSORT_S(arr->entries, arr->nr, ent_compare, &ignore_mode);

Swap the decl for ignore_mode and the blank line above it?

If the callback context only needs a single bit, ent_compare() could
just use the NULL-ness of ctx as "do we want to ignore mode?" bit.

> +	arr->nr = 0;
> +	for (size_t i = 0; i < count; i++) {
> +		struct tree_entry *curr = arr->entries[i];
> +		if (prev &&
> +		    !name_compare(prev->name, prev->len,
> +				  curr->name, curr->len)) {
> +			FREE_AND_NULL(curr);
> +		} else {
> +			arr->entries[arr->nr++] = curr;
> +			prev = curr;
> +		}
> +	}

As long as this is done for a single tree (i.e. the paths do not
have any slashes in them), this "sort them all and keep the last
one" is a good strategy.

> +	/* Sort again to order the entries for tree insertion */
> +	ignore_mode = 0;
> +	QSORT_S(arr->entries, arr->nr, ent_compare, &ignore_mode);

OK.  We from time to time find need to do this, and I always regret
that we didn't design the sort order of paths in a tree (and in the
index) like so [*].  But that is almost 20 years too late ;-).

Looking good.


[Footnote]

 * A directory entry $T should have sorted after a non-directory
   entry $T but before any non-directory entry whose path has $T
   as its prefix (e.g. even a blob whose path is $T + "\001" should
   sort after a tree $T).  That way we didn't have to worry about a
   blob at ($T + '-') sorting before a tree at $T but a blob at ($T
   + '0') sorting after that tree.


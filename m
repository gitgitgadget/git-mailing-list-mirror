Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765D419AA56
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719516595; cv=none; b=EKlGO4+8ZyHtREq8fxnVgSqz0zGOVZ4YW3mdrDMMXecnxzawkrkPbsjgbo11WktdZ8BGina3DGiz6CbvM8ouo2+eB2FWsPEBrnSdJvzZztd4OqK1DyMHhxKJB0AGyxqca+rJaYG80sLmEL4ppahctx598uM1UxAvrbmkveShR4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719516595; c=relaxed/simple;
	bh=PVcYPwIZ/rWx91TsBGif7Bhgpaz59T+H7cTCI+1pNjI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BH++qSbXsNd+CMFXvSZQySQ5JGtHDMwaIpRiLn1mhE3XU9P3GTfpF1QJ3uWDXRMxM7rtlDn3V1ScJ2BmkO9sQ/gF+6pm2G3PZ/3zeo+o1xCJSQS5+ChTyNGELHmEh/9FRLpx9e0GL4neZWeKXQW55otGlc9pXzAmk1KPrElfz6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QITFLqtr; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QITFLqtr"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 878B62A6EE;
	Thu, 27 Jun 2024 15:29:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PVcYPwIZ/rWx91TsBGif7Bhgpaz59T+H7cTCI+
	1pNjI=; b=QITFLqtrLyr4BbKRlmFCcN1BNJKVXTtF7y1kY+iKkIZk8HM2XHQmmi
	7GouSIjxD35+C0NeZ9A99ZTjQiGeuL8eyaVsJlq62Bpx+pA7Uo2QR+TgBogcu450
	FSopMiG/60DaKd3LWVtYhA7Zqbzj5ZL7KpGl0Q6ZhyokFoM+BpeOY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 78A952A6ED;
	Thu, 27 Jun 2024 15:29:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 14A9B2A6EC;
	Thu, 27 Jun 2024 15:29:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Patrick
 Steinhardt <ps@pks.im>,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 16/17] mktree: allow deeper paths in input
In-Reply-To: <46756c4e3140d34838ad4cd5e7a070d1f9f46b53.1718834285.git.gitgitgadget@gmail.com>
	(Victoria Dye via GitGitGadget's message of "Wed, 19 Jun 2024 21:58:04
	+0000")
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
	<46756c4e3140d34838ad4cd5e7a070d1f9f46b53.1718834285.git.gitgitgadget@gmail.com>
Date: Thu, 27 Jun 2024 12:29:42 -0700
Message-ID: <xmqqed8itc9l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9B5042DC-34BB-11EF-A3BC-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Update 'git mktree' to handle entries nested inside of directories (e.g.
> 'path/to/a/file.txt'). This functionality requires a series of changes:
>
> * In 'sort_and_dedup_tree_entry_array()', remove entries inside of
>   directories that come after them in input order.

So if you feed "folder/file.txt" and then "folder/", then
"folder/file.txt" gets removed?  It is unclear offhand why that is
the right thing to do.

> * Also in 'sort_and_dedup_tree_entry_array()', mark directories that contain
>   entries that come after them in input order (e.g., 'folder/' followed by
>   'folder/file.txt') as "need to expand".

Makes me wonder what happens to the object name recorded in the
input for "folder/" when something like this happens.  Ideally,
adding (or replacing) "folder/file.txt" to the set of files we
collected out of the base tree and the input stream for "folder/"
and writing that "folder/" out as a tree would result in a tree
whose object name exactly matches it (and we will error out if it
does not)?  Or is "need to expand" a signal that we should ignore
the object name in the input and we need to recompute it ourselves?
Again, it is unclear offhand what we want the "need to expand" is
used for.

> * In 'add_tree_entry_to_index()', if a tree entry is marked as "need to
>   expand", recurse into it with 'read_tree_at()' & 'build_index_from_tree'.
> * In 'build_index_from_tree()', if a user-specified tree entry is contained
>   within the current iterated entry, return 'READ_TREE_RECURSIVE' to recurse
>   into the iterated tree.

Surely, no matter what we choose to do to the object name given with
"folder/" when the input stream also talks about "folder/file.txt",
we'd need to recurse into the subtree.  But I think we need a higher
level description of what exactly we want to do to the multi-level
pathnames (i.e., "we want to handle them this way") before going into
the implementation details of how we do so (i.e., "hence we deal with
a multi-level pathname this way at these places in the code") in
these bullet points.

Especially, I do not quite understand what semantics the first
bullet point is trying to achieve.

> +Entries may use full pathnames containing directory separators to specify
> +entries nested within one or more directories. These entries are inserted
> +into the appropriate tree in the base tree-ish if one exists. Otherwise,
> +empty parent trees are created to contain the entries.

This still does not answer "how overlapping entries are handled?",
which is more complex than "for two exactly the same paths, the last
one wins", which is mentioned in the next paragraph.

>  The order of the tree entries is normalized by `mktree` so pre-sorting the
>  input by path is not required. Multiple entries provided with the same path
>  are deduplicated, with only the last one specified added to the tree.
> diff --git a/builtin/mktree.c b/builtin/mktree.c
> index 96f06547a2a..74cec92a517 100644
> --- a/builtin/mktree.c
> +++ b/builtin/mktree.c
> ...
> +static struct tree_entry *tree_entry_array_pop(struct tree_entry_array *arr)
> +{
> +	if (!arr->nr)
> +		return NULL;
> +	return arr->entries[--arr->nr];
> +}
> +
>  static void tree_entry_array_clear(struct tree_entry_array *arr, int free_entries)
>  {
>  	if (free_entries) {
> @@ -109,8 +118,10 @@ static void append_to_tree(unsigned mode, struct object_id *oid, const char *pat
>  
>  		if (!verify_path(ent->name, mode))
>  			die(_("invalid path '%s'"), path);
> -		if (strchr(ent->name, '/'))
> -			die("path %s contains slash", path);
> +
> +		/* mark has_nested_entries if needed */
> +		if (!arr->has_nested_entries && strchr(ent->name, '/'))
> +			arr->has_nested_entries = 1;

OK.

> @@ -168,6 +179,46 @@ static void sort_and_dedup_tree_entry_array(struct tree_entry_array *arr)
>  	ignore_mode = 0;
>  	QSORT_S(arr->entries, arr->nr, ent_compare, &ignore_mode);

We have already sorted the array twice (once before simple deduping,
once after).  So we now have a sorted array of "last one won" paths
and their object names.

> +	if (arr->has_nested_entries) {

We need to deal with overlapping entries if "has-nested-entries" is
true.  Even though our input here is sorted, we'd still pay
attention to the original input "order", which may be different from
the order in which we find these entries in arr->entries[].

OK.

> +		struct tree_entry_array parent_dir_ents = { 0 };
> +
> +		count = arr->nr;
> +		arr->nr = 0;
> +
> +		/* Remove any entries where one of its parent dirs has a higher 'order' */

Is "has a higher order" equivalent to "appears later in the input"?

More importantly, can the reason why they need to be removed be
clarified?  For simple deduping, we can say "we will make the last
one of multiple entries talking about the same path be used", and
that would be a sufficient explanation why we discard the one that
we have seen earlier and replace it with the newly seen one for the
same path.  Can a similar and simple explanation be given for the
behaviour this loop tries to achieve?  Is it "children, which appear
earlier in the input, of a directory, which appears later than these
children, are discarded, because the entry for the directory has a
concrete object name, and there is no point talking about individual
paths inside the directory.  We know what the tree object that would
contain these child paths hashes to in the end.  This is a natural
extension of 'last one wins' rule---a directory that comes later
trumps paths contained within that come earlier"?

> +		for (size_t i = 0; i < count; i++) {
> +			const char *skipped_prefix;
> +			struct tree_entry *parent;
> +			struct tree_entry *curr = arr->entries[i];
> +			int skip_entry = 0;
> +
> +			while ((parent = tree_entry_array_pop(&parent_dir_ents))) {
> +				if (!skip_prefix(curr->name, parent->name, &skipped_prefix))
> +					continue;
> +
> +				/* entry in dir, so we push the parent back onto the stack */
> +				tree_entry_array_push(&parent_dir_ents, parent);
> +
> +				if (parent->order > curr->order)
> +					skip_entry = 1;
> +				else
> +					parent->expand_dir = 1;
> +
> +				break;
> +			}
> +
> +			if (!skip_entry) {
> +				arr->entries[arr->nr++] = curr;
> +				if (S_ISDIR(curr->mode))
> +					tree_entry_array_push(&parent_dir_ents, curr);
> +			} else {
> +				FREE_AND_NULL(curr);
> +			}
> +		}
> +
> +		tree_entry_array_release(&parent_dir_ents, 0);
> +	}
> +
>  	/* Finally, initialize the directory-file conflict hash map */
>  	for (size_t i = 0; i < count; i++) {
>  		struct tree_entry *curr = arr->entries[i];

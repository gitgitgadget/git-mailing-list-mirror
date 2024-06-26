Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE6516A928
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719437025; cv=none; b=JL+91Vf9u3BjGkj8DNJgpPY/6whRqwNiqH35ABP0ZDGN0xVPUDh3Oe3UB9VhmWD6g7vmUL44d2XGjPcoHKB2n33Fgu5LLgvRrlHGvl0GJ+QQNlDz+baWig/rPgZ62cVFacFiQqUldM2KLJrftD/2O8WyT0u5l3nExUJf1gS3gsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719437025; c=relaxed/simple;
	bh=N0hvWYEqLXN21cEqJgVe781XSGDyJOsbPZSYh/R6Jvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rquMIGtRlflMfDMz5kDNmNjxDJgC1zzQUn6JKW0Jlb4ouDnE9tbhld0w1AfwChIcTdctzZPK0TJfh+yFU67NljoAI46yg6xii/COiZAPPMjHL0A6GKbm0eBXQBnI8BwTTdTW1jjGPIO7MlYNKkstdl2CTxQ4w8qG6025VO6Yr1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=utVOfeYT; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="utVOfeYT"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 42E5324B50;
	Wed, 26 Jun 2024 17:23:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=N0hvWYEqLXN21cEqJgVe781XSGDyJOsbPZSYh/
	R6Jvk=; b=utVOfeYTzlYEN7MR5+pBr4GslmY4MOWql+Sb9YlJ7RQ3pNuTw3EazI
	rkhUgX47+ozjnad74KY3AIx7gaFSpL9T5gOuRc1JGVl0AHrVAXksz3KYgzLBvbPa
	v+IcNo1vbIkYCwGGjcVmLVopGK9BJednHN/kgV7GWafkVbnA+XzvU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B52324B4F;
	Wed, 26 Jun 2024 17:23:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A1B2524B4E;
	Wed, 26 Jun 2024 17:23:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Patrick
 Steinhardt <ps@pks.im>,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 15/17] mktree: optionally add to an existing tree
In-Reply-To: <4b88f84b933b1598d12e3620f0c9fb85c559e8fb.1718834285.git.gitgitgadget@gmail.com>
	(Victoria Dye via GitGitGadget's message of "Wed, 19 Jun 2024 21:58:03
	+0000")
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
	<4b88f84b933b1598d12e3620f0c9fb85c559e8fb.1718834285.git.gitgitgadget@gmail.com>
Date: Wed, 26 Jun 2024 14:23:40 -0700
Message-ID: <xmqqo77nwg83.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5C69BCB0-3402-11EF-8580-965B910A682E-77302942!pb-smtp2.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Allow users to specify a single "tree-ish" value as a positional argument.
> If provided, the contents of the given tree serve as the basis for the new
> tree (or trees, in --batch mode) created by 'mktree', on top of which all of
> the stdin-provided tree entries are applied.
>
> At a high level, the entries are "applied" to a base tree by iterating
> through the base tree using 'read_tree' in parallel with iterating through
> the sorted & deduplicated stdin entries via their iterator. That is, for
> each call to the 'build_index_from_tree callback of 'read_tree':
>
> * If the iterator entry precedes the base tree entry, add it to the in-core
>   index, increment the iterator, and repeat.

"add it" -> "add the base tree entry"?  The next bullet point
explicitly says it adds "the iterator entry", which makes it crystal
clear what is going on.

> * If the iterator entry has the same name as the base tree entry, add the
>   iterator entry to the index, increment the iterator, and return from the
>   callback to continue the 'read_tree' iteration.
> * If the iterator entry follows the base tree entry, first check
>   'df_name_hash' to ensure we won't be adding an entry with the same name
>   later (with a different mode). If there's no directory/file conflict, add
>   the base tree entry to the index. In either case, return from the callback
>   to continue the 'read_tree' iteration.

IOW, we take advantage of the fact that iteration over the base tree
and iteration over the sorted-and-deduped entries from the standard
input are already sorted, and do a simple bog-standard "merge" of
two lists?

We'd probably have many common pitfalls to avoid with the read-tree
walking the index and tree(s) in parallel (I still remember the pain
of maintaining the cache_bottom for the side that walks the index).
Makes me wonder if this opens a way to a future where somehow
read-tree also shares code with this new code in mktree (or vice
versa).

> Finally, once 'read_tree' is complete, add the remaining entries in the
> iterator to the index and write out the index as a tree.

Or vice versa?  We may finish iterating over the entries read from
the standard input but there still are entries from the base tree
side remaining, which would need to be added to complete the index,
right?

> +<tree-ish>::
> +	If provided, the tree entries provided in stdin are added to this
> +	tree rather than a new empty one, replacing existing entries with
> +	identical names. Not compatible with `--literally`.

"replacing" might need a bit more clarification when we start
reading paths with multiple pathname components concatenated with
slashes.  In the base tree, we may have

    100644 blob 536e55524db72bd2acf175208aef4f3dfc148d42    D

and it can (indirectly) replaced by the standard input stream
feeding entries like these

    100644 blob b0517166ae2ad92f3b17638cbdee0f04b8170d99    D/a
    100644 blob 495a54bc1397e2fd3177c2733baf4899b48d30bd    D/b


which also leads us to compute a tree entry

    040000 tree eccdce44520aa3ef4ac5ba090df53eadb01229ef    D/

in the top-level tree?

The code looks good to me.  Thanks.


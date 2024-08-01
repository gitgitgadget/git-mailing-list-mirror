Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC7F1B8EBB
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530474; cv=none; b=Hwh6RkQnQb5f5M+RpBby047g7oXluE+dtD17e46XOFy1pYIKnXIYX/G3H8Lx5fScyTOHtS1u1GHqpZFgYY8S0kyX2Ws+rgmNdOMrtMeMD3gMlppQAic9kwpVUr9rwazhlWTD9d1/Im4jN1PTNlGEun/eHVbYYg7cUMdKRHykIA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530474; c=relaxed/simple;
	bh=vnb/4vaWDvmjhPE5O5Xisd/jXN7b9z14kQFL8P3VJx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YJ+R5ITpMT1gUcZO6nTe77Ll5T83wUtnxuS6Da9Amr0iH7IyuURnoo3BsRoih8GyKnlwDqZuF1KBSo72m9qHvciEYbyCAbh4LQ2l3fLcoc7m5qR0ClvhqCU1wN54/OGaEqILfCle+aJucreggTrHoJdhn3IrG01CU1XucIi7f5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=i3Ux80Dv; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i3Ux80Dv"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 36A702A9AB;
	Thu,  1 Aug 2024 12:41:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vnb/4vaWDvmjhPE5O5Xisd/jXN7b9z14kQFL8P
	3VJx8=; b=i3Ux80Dv1pbIwOZE6bUE22ZcTVpoqKIP+wGpkufeVUsnsrFljW2nxw
	MKZh8z03BLin+J3+ycsRX3cq+TrHKb5yCoNMiQk+effllneQG5fPUuTZfq29WSbV
	wtR/1O/MRuFlv8kyknwW6fk1j6HS6earf366adW2O7AV0VCyzGg+M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1437A2A9A9;
	Thu,  1 Aug 2024 12:41:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 27A3E2A9A7;
	Thu,  1 Aug 2024 12:41:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff King <peff@peff.net>,
  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <avila.jn@gmail.com>,
  Linus Arver <linusarver@gmail.com>,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/3] refs: keep track of unresolved reference value
 in iterators
In-Reply-To: <ac0957c9e6abdc2597900573703461833e9c9d69.1722524334.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Thu, 01 Aug 2024 14:58:52
	+0000")
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
	<pull.1712.v2.git.git.1722524334.gitgitgadget@gmail.com>
	<ac0957c9e6abdc2597900573703461833e9c9d69.1722524334.git.gitgitgadget@gmail.com>
Date: Thu, 01 Aug 2024 09:41:03 -0700
Message-ID: <xmqqa5hww600.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D86D4834-5024-11EF-AB34-34EEED2EC81B-77302942!pb-smtp1.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -245,9 +245,11 @@ static void loose_fill_ref_dir_regular_file(struct files_ref_store *refs,
>  {
>  	struct object_id oid;
>  	int flag;
> -
> -	if (!refs_resolve_ref_unsafe(&refs->base, refname, RESOLVE_REF_READING,
> -				     &oid, &flag)) {
> +	const char* referent = refs_resolve_ref_unsafe(&refs->base,

Style.  The asterisk sticks to the pointer variable, not the base type.

> +						       refname,
> +						       RESOLVE_REF_READING,
> +						       &oid, &flag);
> +	if (!referent) {
>  		oidclr(&oid, the_repository->hash_algo);
>  		flag |= REF_ISBROKEN;
>  	} else if (is_null_oid(&oid)) {
> @@ -268,7 +270,8 @@ static void loose_fill_ref_dir_regular_file(struct files_ref_store *refs,
>  		oidclr(&oid, the_repository->hash_algo);
>  		flag |= REF_BAD_NAME | REF_ISBROKEN;
>  	}
> -	add_entry_to_dir(dir, create_ref_entry(refname, &oid, flag));
> +
> +	add_entry_to_dir(dir, create_ref_entry(refname, referent, &oid, flag));
>  }

This is a very straight-forward change, given the matching change to
the ref-entry, which now has a referent member.

> @@ -886,6 +889,9 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  		iter->base.refname = iter->iter0->refname;
>  		iter->base.oid = iter->iter0->oid;
>  		iter->base.flags = iter->iter0->flags;
> +		if (iter->iter0->flags & REF_ISSYMREF)
> +			iter->base.referent = iter->iter0->referent;

Presumably base.referent is initialized to NULL so this "if"
statement does not need an else clause?  

I am primarily wondering why this needs to be conditional.  We are
making verbatim copy of the flags word from *iter->iter0 to
iter->base; if iter0 is symref we want to mark base also as symref,
If iter0 is not a symref, then we want to mark base also not a
symref, presumably.  So wouldn't it make sense to just say

		iter->base.referent = iter->iter0->referent;

here, regardless of what iter->iter0->flags say about symref-ness of
the thing?  Because ...

> diff --git a/refs/iterator.c b/refs/iterator.c
> index d355ebf0d59..26acb6bd640 100644
> --- a/refs/iterator.c
> +++ b/refs/iterator.c
> @@ -7,6 +7,7 @@
>  #include "refs.h"
>  #include "refs/refs-internal.h"
>  #include "iterator.h"
> +#include "strbuf.h"
>  
>  int ref_iterator_advance(struct ref_iterator *ref_iterator)
>  {
> @@ -29,6 +30,7 @@ void base_ref_iterator_init(struct ref_iterator *iter,
>  {
>  	iter->vtable = vtable;
>  	iter->refname = NULL;
> +	iter->referent = NULL;
>  	iter->oid = NULL;
>  	iter->flags = 0;
>  }
> @@ -199,6 +201,7 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  		}
>  
>  		if (selection & ITER_YIELD_CURRENT) {
> +			iter->base.referent = (*iter->current)->referent;
>  			iter->base.refname = (*iter->current)->refname;
>  			iter->base.oid = (*iter->current)->oid;
>  			iter->base.flags = (*iter->current)->flags;

... other parts of the API seem to follow that philosophy.

In other words, the invariant of this code is that .referent is
non-NULL if and only if the ref is a symref, and that invariant is
trusted without checking with .flags member.  But the earlier hunk
that copied iter0 to base did not seem to be using that invariant,
which made it look inconsistent.

>  struct ref_entry *create_ref_entry(const char *refname,
> +				   const char *referent,
>  				   const struct object_id *oid, int flag)
>  {
>  	struct ref_entry *ref;
> @@ -41,6 +43,10 @@ struct ref_entry *create_ref_entry(const char *refname,
>  	FLEX_ALLOC_STR(ref, name, refname);
>  	oidcpy(&ref->u.value.oid, oid);
>  	ref->flag = flag;
> +
> +	if (flag & REF_ISSYMREF)
> +		ref->u.value.referent = xstrdup_or_null(referent);

OK.  ref_value now has referent next to the existing oid, but that
member only makes sense when flag says it is a symref.

Curiously, that information is missing from ref_value struct, so by
looking at a ref_value alone, we cannot tell if we should trust the
value in the .referent member?

Makes me wonder if we should follow the same "ignore what the flag
says when filling the .referent member; if the ref is not a symref,
the referent variable is NULL, and if it is, referent is never NULL"
pattern?  Then ref->u.value.referent is _always_ defined---the
current code says "the u.value.referent member is undefined for ref
that is not a symref", but with the suggested change, it will be
"the u.value.referent member is NULL for ref that is not a symref,
and for a symref, it is the value of the symref".

>  	return ref;
>  }
>  
> @@ -66,6 +72,7 @@ static void free_ref_entry(struct ref_entry *entry)
>  		 */
>  		clear_ref_dir(&entry->u.subdir);
>  	}
> +	free(entry->u.value.referent);

And that would match what is done here.  We do not say "entry->flag
says it is not a symref, so do not bother freeing u.value.referent".

> @@ -431,6 +438,7 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  			level->index = -1;
>  		} else {
>  			iter->base.refname = entry->name;
> +			iter->base.referent = entry->u.value.referent;
>  			iter->base.oid = &entry->u.value.oid;
>  			iter->base.flags = entry->flag;
>  			return ITER_OK;
> diff --git a/refs/ref-cache.h b/refs/ref-cache.h
> index 31ebe24f6cf..5f04e518c37 100644
> --- a/refs/ref-cache.h
> +++ b/refs/ref-cache.h
> @@ -42,6 +42,7 @@ struct ref_value {
>  	 * referred to by the last reference in the symlink chain.
>  	 */
>  	struct object_id oid;
> +	char *referent;
>  };
>  
>  /*
> @@ -173,6 +174,7 @@ struct ref_entry *create_dir_entry(struct ref_cache *cache,
>  				   const char *dirname, size_t len);
>  
>  struct ref_entry *create_ref_entry(const char *refname,
> +				   const char *referent,
>  				   const struct object_id *oid, int flag);
>  
>  /*
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index fa975d69aaa..117ec233848 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -299,6 +299,7 @@ enum do_for_each_ref_flags {
>  struct ref_iterator {
>  	struct ref_iterator_vtable *vtable;
>  	const char *refname;
> +	const char *referent;
>  	const struct object_id *oid;
>  	unsigned int flags;
>  };
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index fbe74c239d3..9f724c3d632 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -494,8 +494,12 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  				the_repository->hash_algo);
>  			break;
>  		case REFTABLE_REF_SYMREF:
> -			if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->ref.refname,
> -						     RESOLVE_REF_READING, &iter->oid, &flags))
> +			iter->base.referent = refs_resolve_ref_unsafe(&iter->refs->base,
> +								      iter->ref.refname,
> +								      RESOLVE_REF_READING,
> +								      &iter->oid,
> +								      &flags);
> +			if (!iter->base.referent)
>  				oidclr(&iter->oid, the_repository->hash_algo);
>  			break;
>  		default:

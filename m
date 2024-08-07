Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0701487C5
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 21:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066820; cv=none; b=m6EFjc5ni2bmdGw0vstAlJT3n6DvayFjmZ8+F+MIhm59o1A4rbHPofVBqojBtJ8wDgiQ7/ERo4bGruZnxEOCq2UZQkE7r5gGasx6cPj20MpNWT4jNDsrbEnZcr/vD6TSwcKpTXDwqzwavug3/r8qZXZ5/widT3TKn33O0uGN9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066820; c=relaxed/simple;
	bh=74+AH/jMGFPzw2gtZxjRSF++CrsTmbCVjwrsAD0VNn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dfO9FvwSAGhnjwCbu5S05T6gQJZTtim8SXxjCXtxtwwIkY1LuRwRQ2LEfQ1Mz45SW/NePXdUqrQJ75tGevX8CJuCgUQjEiKK+0DQGxW515KBzVnmi4Vw99GIWlyTCb5eNRkIr1Xzxbp/yzHD6gIMRbik3PEDQCEnxkarn9ECkfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EqOKa4Fo; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EqOKa4Fo"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1529527565;
	Wed,  7 Aug 2024 17:40:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=74+AH/jMGFPzw2gtZxjRSF++CrsTmbCVjwrsAD
	0VNn4=; b=EqOKa4FoInl5+eWijnmHUp0Dtusf9oVRfs20lPtU8Amm7wYBn+vQCr
	yoYS9m+InMJVa2OqwHbeCWwPe6EyffSApJmshlO53R69r67f4TJSbFVXuAAXmYX2
	i8BfF2+FEzmIetJm9mMZOArUH4Fff4MDhzHGRNt+SHor/Od42hxo4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BBD627563;
	Wed,  7 Aug 2024 17:40:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7AE8427562;
	Wed,  7 Aug 2024 17:40:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff King <peff@peff.net>,
  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <avila.jn@gmail.com>,
  Linus Arver <linusarver@gmail.com>,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 1/3] refs: keep track of unresolved reference value
 in iterators
In-Reply-To: <fc3defd9c47e32bb23ba0fcb5c885274f3706b23.1723059769.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Wed, 07 Aug 2024 19:42:46
	+0000")
References: <pull.1712.v2.git.git.1722524334.gitgitgadget@gmail.com>
	<pull.1712.v3.git.git.1723059768.gitgitgadget@gmail.com>
	<fc3defd9c47e32bb23ba0fcb5c885274f3706b23.1723059769.git.gitgitgadget@gmail.com>
Date: Wed, 07 Aug 2024 14:40:10 -0700
Message-ID: <xmqqbk24nhad.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9FC15E86-5505-11EF-8E24-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index aa52d9be7c7..5ed69c23f74 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -245,9 +245,11 @@ static void loose_fill_ref_dir_regular_file(struct files_ref_store *refs,
>  {
>  	struct object_id oid;
>  	int flag;
> -
> -	if (!refs_resolve_ref_unsafe(&refs->base, refname, RESOLVE_REF_READING,

Here, we had a nice blank line that separated the decls and the
first statement.

> -				     &oid, &flag)) {
> +	const char *referent = refs_resolve_ref_unsafe(&refs->base,
> +						       refname,
> +						       RESOLVE_REF_READING,
> +						       &oid, &flag);
> +	if (!referent) {

We lost it here, though.

>  		oidclr(&oid, the_repository->hash_algo);
>  		flag |= REF_ISBROKEN;
>  	} else if (is_null_oid(&oid)) {
> @@ -268,7 +270,11 @@ static void loose_fill_ref_dir_regular_file(struct files_ref_store *refs,
>  		oidclr(&oid, the_repository->hash_algo);
>  		flag |= REF_BAD_NAME | REF_ISBROKEN;
>  	}
> -	add_entry_to_dir(dir, create_ref_entry(refname, &oid, flag));
> +
> +	if (!(flag & REF_ISSYMREF))
> +		referent = NULL;

OK, this is new in this round.  The idea is that everybody else can
rely on the invariant that the referent being NULL is equivalent to
REF_ISSYMREF bit in flag word being off from here on.

> +	add_entry_to_dir(dir, create_ref_entry(refname, referent, &oid, flag));
>  }
>  
>  /*
> @@ -886,6 +892,11 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  		iter->base.refname = iter->iter0->refname;
>  		iter->base.oid = iter->iter0->oid;
>  		iter->base.flags = iter->iter0->flags;
> +		if (iter->iter0->flags & REF_ISSYMREF)
> +			iter->base.referent = iter->iter0->referent;
> +		else
> +			iter->base.referent = NULL;
>  		return ITER_OK;
>  	}

Hmph, why not an unconditional

		iter->base.referent = iter->iter0->referent;

instead?  This code is making sure (iter->base.flags & REF_ISSYMREF)
is directly linked to non-NULL-ness or iter->base.referent, and we
want to make everybody take it as invariant.  Shouldn't this code
also rely on the same invariant?  If iter-iter0->referent is NULL,
iter->iter0->flag has REF_ISSYMREF bit off, and vice versa.

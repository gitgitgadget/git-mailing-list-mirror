Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA8F1A5A2
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712617354; cv=none; b=qhMBoI/yZ55lcw7HqYrYQEpBIThnTILGA006vinapk1hWOmiflLTru50ipYazGQIUqhi1vU98BTqmL2Jf4qdVG62faAQqG8RZ6SaA3PdOcZg6TSb4Only4R9L7Y88efOfT8eyp/TSn/V5/FX0BFyiPKi0/y8H0hkmwI/pkJu2hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712617354; c=relaxed/simple;
	bh=CbCtkmVoUa5T7NbJoznHEmytOA+tg53gkfNLApehBTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KOn2xwbf0yVTKtl6gvOI7EWwXdXp7ZdmBb5QaJsyBHcS43qFMBa3fb0L84d646VG2NYm+mDXImdlrK2JXjuJjXyRjAfw7pbpJN9z4DYkFeJVLOiZR/BOfGnacWWrFy8j5zYizk9aZ5hm3tmzpBvnPAjtq1aWKUDJLi1dEVIfv+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SIUqIVGs; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SIUqIVGs"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AAB1620652;
	Mon,  8 Apr 2024 19:02:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CbCtkmVoUa5T7NbJoznHEmytOA+tg53gkfNLAp
	ehBTc=; b=SIUqIVGsTk7V6T+QMO+q6SoG+r/pnAqFAOUjqtHyZZpreqegJoA+F5
	wWbnA0QZS0kPP3JgakPhhiDeSsf/p097G/A5eMwtxW1XUMUb20fjQyOHW8i6CaB5
	jE+vYLjn3qrd+88PUCoVdSQqzjvtIXu1MUpl9Jeqf4482INYt9bTI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A22CC20651;
	Mon,  8 Apr 2024 19:02:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 26CF12064F;
	Mon,  8 Apr 2024 19:02:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff King <peff@peff.net>,
  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <avila.jn@gmail.com>,
  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/3] refs: keep track of unresolved reference value
 in iterator
In-Reply-To: <6adc9dd26da4459d246591ce148c960b33bde336.1712597893.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Mon, 08 Apr 2024 17:38:11
	+0000")
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
	<pull.1684.v2.git.git.1712597893.gitgitgadget@gmail.com>
	<6adc9dd26da4459d246591ce148c960b33bde336.1712597893.git.gitgitgadget@gmail.com>
Date: Mon, 08 Apr 2024 16:02:25 -0700
Message-ID: <xmqq34rv791a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 11A7A9F6-F5FC-11EE-989C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

> diff --git a/refs.h b/refs.h
> index 298caf6c618..2e740c692ac 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -71,9 +71,10 @@ struct pack_refs_opts {
>  	struct ref_exclusions *exclusions;
>  	struct string_list *includes;
>  };
> -
>  const char *refs_resolve_ref_unsafe(struct ref_store *refs,
> +
>  				    const char *refname,
> +				    char **referent,
>  				    int resolve_flags,
>  				    struct object_id *oid,
>  				    int *flags);

If referent is meant to be an out-parameter, it should sit next to
oid that is also an out-parameter.  And as a late-comer sibling, it
should sit after its elder brother.

Also, I do not see the reason for the shuffling of blank lines.
Shouldn't it be the other way around, even?  After an unrelated
definition of "struct pack_refs_opts", there is (and should be)
a blank line, then the first line of the declaration of function.

Perhaps some fat-fingering.

> @@ -1928,6 +1928,7 @@ int refs_read_symbolic_ref(struct ref_store *ref_store, const char *refname,
>  
>  const char *refs_resolve_ref_unsafe(struct ref_store *refs,
>  				    const char *refname,
> +				    char **referent,
>  				    int resolve_flags,
>  				    struct object_id *oid,
>  				    int *flags)
> @@ -1989,6 +1990,8 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
>  		}
>  
>  		*flags |= read_flags;
> +		if (referent && read_flags & REF_ISSYMREF && sb_refname.len > 0)
> +			*referent = sb_refname.buf;

Is this safe?  After this assignment, which "return" in this loop
are you expecting to return from this function?  If you fail to
return from the function during this iteration, you'll clobber the
same strbuf with the next refs_read_raw_ref(), but I do not see how
you are ensuring that you'll return from the function without such
corruption happening.

This assignment happens only when read_flags has REF_ISSYMREF set,
so the next "if it is not, then return refname" would not even
trigger.  If RESOLVE_REF_NO_RECURSE bit is on in resolve_flags,
then we'd return without further dereferencing, but if that is the
only safe exit from the function, shouldn't you be guarding the
function with something like

	if (referent && !(resolve_flags & RESOLVE_REF_NO_RECURSE))
		BUG("recursive dereference can will clobber *referent");

to protect its callers from their own mistakes?

Another return before we start the next iteration of the loop and
clobber sb_refname with another call to refs_read_raw_ref() is the
error return codepath at the end of the loop, but that is a totally
uninteresting case.

Or am I totally confused?

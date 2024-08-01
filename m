Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0A51EB4BF
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722531119; cv=none; b=SiKEqEIV51XmhkEX5Zi5aDlFvN5wugJv+XqH4+bq5JB8fQK4sKVbru4/zF/quBRnfaRpzZ3GmlRzLDyqA+savgep9kC/Z+UZzz/eGXfoGWB/gLKvrSzro9r2NAzg5CPQOSHKDVrJAJvQMFYiV2ydJ9V9Qb6lXwvg7yADeLqTH7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722531119; c=relaxed/simple;
	bh=X+H51bzxAQFUs01Tj4TcgITSNc2gmgJCNIU/3n6QXpo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=deGMLGUkzcwomXn2jAqOKy4oH3M7AtJSRojtkd8JW/z7DnWHx6dn0at34X41u/l7GEnnUviiCWYR+dv/1hjaSVY/NIjNmS84wmq2sBzE02TSCC6gkIikDhX0p0oVY4DkmjsiYZxWM5c3aeLflXE5OR+FkEU5AHBbdwmE7JDh0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aE8BQ/+x; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aE8BQ/+x"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CD222AAA9;
	Thu,  1 Aug 2024 12:51:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=X+H51bzxAQFUs01Tj4TcgITSNc2gmgJCNIU/3n
	6QXpo=; b=aE8BQ/+xQZgiUBWtVMJYpvnGIl5u3XVselxFMTTji9lBUQLC0+12Sj
	0JwJmlrtj8NC+UH7NNbRRRDhzXlfrNcLJv9qvzXvcMBA4xapsW2jA8TWXumN+IqU
	hbmxIDrqhN2Hy4QnIMjRRWB8OpF69f2GMZJNlfAHLun+B1S6YrrE0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6325C2AAA8;
	Thu,  1 Aug 2024 12:51:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C57F72AAA7;
	Thu,  1 Aug 2024 12:51:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff King <peff@peff.net>,
  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <avila.jn@gmail.com>,
  Linus Arver <linusarver@gmail.com>,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 3/3] ref-filter: populate symref from iterator
In-Reply-To: <3e147e7d850773f44b48d1b86e89aef1415a0ccd.1722524334.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Thu, 01 Aug 2024 14:58:54
	+0000")
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
	<pull.1712.v2.git.git.1722524334.gitgitgadget@gmail.com>
	<3e147e7d850773f44b48d1b86e89aef1415a0ccd.1722524334.git.gitgitgadget@gmail.com>
Date: Thu, 01 Aug 2024 09:51:53 -0700
Message-ID: <xmqqwml0uqxi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5C3E45C2-5026-11EF-AD47-34EEED2EC81B-77302942!pb-smtp1.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> With a previous commit, the reference the symbolic ref points to is saved
> in the ref iterator records. Instead of making a separate call to
> resolve_refdup() each time, we can just populate the ref_array_item with
> the value from the iterator.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  ref-filter.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 39997890feb..08997e59662 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2783,7 +2783,7 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
>  	return ref_kind_from_refname(refname);
>  }
>  
> -static struct ref_array_item *apply_ref_filter(const char *refname, const struct object_id *oid,
> +static struct ref_array_item *apply_ref_filter(const char *refname, const char *referent, const struct object_id *oid,
>  			    int flag, struct ref_filter *filter)
>  {
>  	struct ref_array_item *ref;
> @@ -2852,6 +2852,8 @@ static struct ref_array_item *apply_ref_filter(const char *refname, const struct
>  	ref->commit = commit;
>  	ref->flag = flag;
>  	ref->kind = kind;
> +	if (flag & REF_ISSYMREF)
> +		ref->symref = xstrdup_or_null(referent);
>  
>  	return ref;
>  }

What is curious is that we do not lose any code from
populate_value() with this change.

Is that because of this piece of code near the beginning of it?

	CALLOC_ARRAY(ref->value, used_atom_cnt);

	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
		ref->symref = refs_resolve_refdup(get_main_ref_store(the_repository),
						  ref->refname,
						  RESOLVE_REF_READING,
						  NULL, NULL);
		if (!ref->symref)
			ref->symref = xstrdup("");
	}

That is, if we somehow know the value of ref->symref for a ref that
is known to be a symbolic ref (and when we know we need symref
information in the output), we do not bother calling refs_resolve
here to obtain the value.

Thanks.

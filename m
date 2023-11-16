Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="REEfETQU"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E539B
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 21:48:54 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E575D1F2CE;
	Thu, 16 Nov 2023 00:48:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vogFh2rZ8Sx6dMbLKz0d18PYWyb/elUgWmTrIu
	FF+JY=; b=REEfETQUBL3WZaMqTBd/boLl5uZ7UFUqHoojw8bm5BZyOVDqHEf5T8
	E7vvTG4DSLQkquM1bxi65mmG9R9FY/LPJI/8bCCdk4f1+cHltU1OCDsiWX3NmB3Z
	jym892p5rOcT6gtlj6aun9L1xDFoEzdNohD3hLIA4MtirFIamZoE0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DE1D41F2CD;
	Thu, 16 Nov 2023 00:48:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 87C041F2CC;
	Thu, 16 Nov 2023 00:48:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,
  =?utf-8?Q?=C3=98ystein?= Walle
 <oystwa@gmail.com>,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 09/10] ref-filter.c: use peeled tag for '*' format
 fields
In-Reply-To: <48254d8e161de7f0e165510c06801195f9b0a8fd.1699991638.git.gitgitgadget@gmail.com>
	(Victoria Dye via GitGitGadget's message of "Tue, 14 Nov 2023 19:53:57
	+0000")
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
	<pull.1609.v2.git.1699991638.gitgitgadget@gmail.com>
	<48254d8e161de7f0e165510c06801195f9b0a8fd.1699991638.git.gitgitgadget@gmail.com>
Date: Thu, 16 Nov 2023 14:48:49 +0900
Message-ID: <xmqq4jhms0xq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D163C91C-8443-11EE-BFE8-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> In most builtins ('rev-parse <revision>^{}', 'show-ref --dereference'),
> "dereferencing" a tag refers to a recursive peel of the tag object. Unlike
> these cases, the dereferencing prefix ('*') in 'for-each-ref' format
> specifiers triggers only a single, non-recursive dereference of a given tag
> object. For most annotated tags, a single dereference is all that is needed
> to access the tag's associated commit or tree; "recursive" and
> "non-recursive" dereferencing are functionally equivalent in these cases.
> However, nested tags (annotated tags whose target is another annotated tag)
> dereferenced once return another tag, where a recursive dereference would
> return the commit or tree.

This may be the only potentially controversial step in the series.

> -	/*
> -	 * NEEDSWORK: This derefs tag only once, which
> -	 * is good to deal with chains of trust, but
> -	 * is not consistent with what deref_tag() does
> -	 * which peels the onion to the core.
> -	 */
>  	return get_object(ref, 1, &obj, &oi_deref, err);
>  }

Very nice to see an ancient comment I added at 9f613ddd (Add
git-for-each-ref: helper for language bindings, 2006-09-15) finally
go.

Thanks.

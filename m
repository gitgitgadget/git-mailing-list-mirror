Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B739158A09
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721839944; cv=none; b=l7f+EiLJbPIWQlpDwx6nl4JtzUWlPBcuu65caPRnUloWt2UIDPytUu7kI4o8iEHCl8gx5pvcBdAFb5pN4MjSGDLcsC5F6EItTTEb6PoXA12ifpC5HjH+dQqAnz4YmEUMPtoTXmxBJ7hmIj5OVDXzSwFDV9yaYDmNUZcIVrHqvWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721839944; c=relaxed/simple;
	bh=scK3iZQL63BwRRMC+X92m5ZSEee9+aI5CDef0VzX8R0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mzaB91rcacLvtInABhobPy4BRztYVOnZ92v6Rh/CGRDRsAhC8rOSWnICcmn7yhrZ5oxHVSfXkSY/GVldnyTF5pFmehEM2H7aj3L44kyTO3H/aXSf07HFuvgjE7vyUTGR238Cdfw3Myt9lUszblqly8TvKhROY4J8pXGhf9MdCoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xc741AJd; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xc741AJd"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F20F2977D;
	Wed, 24 Jul 2024 12:52:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=scK3iZQL63BwRRMC+X92m5ZSEee9+aI5CDef0V
	zX8R0=; b=xc741AJdZm9REq4/NlkMeYdlDEdo7hwtZRMGkjN0tbU7b5wrG9GRPq
	F4/COV2Yvmp6zA3OXl1SDiyslswSJ9B6MsluRPb8fw+NQo7lc2qdJPwH4/zhradI
	yN7tNrTXRW4exRjVn/drO1qwq7cUTsHpR9ba1cOYnnoS0xzrrYhCM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 673E92977C;
	Wed, 24 Jul 2024 12:52:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C96AF2977B;
	Wed, 24 Jul 2024 12:52:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 3/3] Documentation: document difference between release
 and free
In-Reply-To: <5e1de3c3159968e897a83c05dae5e8504d37a16c.1721818488.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 24 Jul 2024 13:05:22 +0200")
References: <cover.1721818488.git.ps@pks.im>
	<5e1de3c3159968e897a83c05dae5e8504d37a16c.1721818488.git.ps@pks.im>
Date: Wed, 24 Jul 2024 09:52:20 -0700
Message-ID: <xmqqed7iwx4r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 18713CFE-49DD-11EF-BCFA-BAC1940A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> We semi-regularly have discussions around whether a function shall be
> named `release()` or `free()`. For most of the part we use these two
> terminologies quite consistently though:
>
>   - `release()` only frees internal state of a structure, whereas the
>     structure itself is not free'd.
>
>   - `free()` frees both internal state and the structure itself.
>
> Carve out a space where we can add idiomatic names for common functions
> in our coding guidelines. This space can get extended in the future when
> we feel the need to document more idiomatic names.

We have _clear() in some subsystem/API.  Are we sure the listed two
are sufficient and _clear() can be replaced with one of them
(perhaps _release())?

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/CodingGuidelines | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 34fcbcb5a4..ace4c4ad0c 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -560,6 +560,18 @@ For C programs:
>  
>  	void reset_strbuf(struct strbuf *buf);
>  
> + - There are several common idiomatic names for functions performing
> +   specific tasks on structures:
> +
> +    - `<struct>_init()` initializes a structure without allocating the
> +      structure itself.
> +
> +    - `<struct>_release()` releases a structure's contents without
> +      freeing the structure.
> +
> +    - `<struct>_free()` releases a structure's contents and frees the
> +      structure.
> +
>  For Perl programs:
>  
>   - Most of the C guidelines above apply.

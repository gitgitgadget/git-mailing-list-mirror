Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44B1161306
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989207; cv=none; b=c7vRkIzGolIDzIVPrKuE+xgBeZAr9AG4A7qi1hh/w6Ss7zU3RFl586ENZXZxytgQ1Yrp5EqBXuWT2JB8Ka9zLTk+uGfv8eWhPR5v45aBaNrAaEboP5HU3d4UrPFoh54SCfRGWdBB7FFZuRFGVNqb5uIMlHCSNBttf+w4OmBxsCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989207; c=relaxed/simple;
	bh=7FebUEdPTejPDUMSexAcDkU6+UevCZj/iqfIaqpCRS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=st7IvpQMDXgY/C3ScLgx4z06ho8lPFGr3s+SbaU65NEcna2XGpps6UkHEgfx0JUJM/mNKV+6Q2Xry9lJ0Qdwc5exNdS9hlyH0wqQot1RFIlSAHJkLt9e9FKyZC807LgkfBlkD2EGVyBi7ThQsp8tWL4jleCXapYxt0sT1DwTm/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ozvxWSSz; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ozvxWSSz"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 057B8214FD;
	Fri, 21 Jun 2024 13:00:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7FebUEdPTejP
	DUMSexAcDkU6+UevCZj/iqfIaqpCRS8=; b=ozvxWSSzTPOZDrmCaT9iaGRHodab
	cMVbxRP1nnWNahSUYwawTaOwh4Z2b4GYbIQGIN3amo96phexVfy+aMp7LmeQF4w6
	eH8uMhZoln+9dPywNxo46g55BxDPo1TNl9sddml/D1/RJMPogxyftAE+5cUbeqh1
	4x0p3ak8ERMbXJc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CCFB2214F7;
	Fri, 21 Jun 2024 13:00:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 15D3B214EA;
	Fri, 21 Jun 2024 13:00:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org
Subject: Re: [PATCH] bundle-uri.c: Fix double increment in depth
In-Reply-To: <CAP8UFD3jGVaO2JdKE0H22mf4E8YBxrEwuGqJuyeRGBVh==23NQ@mail.gmail.com>
	(Christian Couder's message of "Fri, 21 Jun 2024 17:24:35 +0200")
References: <20240621092258.1557258-1-toon@iotcl.com>
	<CAP8UFD3jGVaO2JdKE0H22mf4E8YBxrEwuGqJuyeRGBVh==23NQ@mail.gmail.com>
Date: Fri, 21 Jun 2024 09:59:59 -0700
Message-ID: <xmqqfrt6nsds.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 B28D5F96-2FEF-11EF-8287-965B910A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Jun 21, 2024 at 11:23=E2=80=AFAM Toon Claes <toon@iotcl.com> wr=
ote:
>>
>> A bundle URI can serve a gitformat-bundle(5) or a bundle list. This
>> plain text file is in the Git config format containing other bundle
>> URIs. To avoid these bundle lists to nest too deep, we've set a limit
>> with `max_bundle_uri_depth`.
>
> Yeah, max_bundle_uri_depth seems to be hardcoded to 4.
>
>> Although, when walk through the tree of
>
> s/walk/walking/

While you are typofixing ...

> Subject: Re: [PATCH] bundle-uri.c: Fix double increment in depth

... also "Fix" -> "fix".


>> bundles, the current depth is incremented in download_bundle_list() an=
d
>> then calls download_bundle_to_file(), which also increments the depth.
>
> s/and then calls/which then calls/
>
>> Remove the increment in download_bundle_to_file().
>
> The increment is removed by replacing:
>
>     fetch_bundle_uri_internal( ..., ctx->depth + 1, ...)
>
> with:
>
>     fetch_bundle_uri_internal( ..., ctx->depth, ...)
>
> in download_bundle_to_file(). Ok.
>
> It looks like there is another similar call to that function like this:
>
> fetch_bundle_uri_internal( ... , ctx.depth + 1, ... )
>
> in fetch_bundles_by_token() though.

I have to wonder if the code should pass the whole ctx around,
instead of passing depth separately, and increment it at the single
place that matters, in order to reduce the chance of similar problem
happening.  The place that matters the recursion depth can be the
download_bundle_list() function---that is the one that controls the
recursion, and it is incrementing the depth for the calls it makes
(via the for_all_* callback mechanism).  Alternatively, it can be
the fetch_bundle_uri_internal() function where actual copying, for
which we do want to enforce the depth limit, happens.  The function
even has the code for depth limit, so having an increment next to it
may make it more readable and understandable.

So instead of taking ctx->r, ctx->depth+1, and ctx->list separately,
shouldn't fetch_bundle_uri_internal() take the whole ctx and use
ctx->depth (not +1---incrementing it is not its business) and the
whole (current and future) problem like this goes away, no?


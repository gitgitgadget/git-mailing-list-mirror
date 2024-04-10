Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDAC16EC1C
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762778; cv=none; b=rIFh7x2ubxmvyhrXIVKrJPwBsPWDNJR+XYmp300z9fI+PQ5utzScXYjlApv5MOdLAy3wjOibqj8Srwh38MzuRyAkwN3AevBUZIHMsdVaUtsCfUOHfxIOw8jF3F2iQDJi84SaSGjBFIaH4jNAt7tUVYzUCkXdyGza7KZB9LCm9m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762778; c=relaxed/simple;
	bh=ZBq+GsvS7VZaFEOWP4mKRDfeCyHA+NVykSOM1pbbCMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UmwpP94VrRxRVG5udpb15Xn4Uli+S/bPiKqwSwcLY53uSfkgpHwyf+j7Zfm0UvH/XNWDYaNW8RHqVJakonUdrGE+rcG1bXUQZdJca0h5MbiRNO7TS0MIdj7ggBMYSYxwCxnQpLkBfk7K9i6WC7BIir3DzBuBwim1GkiwfrTV0MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=E+8xLFiH; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E+8xLFiH"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CE5291ED316;
	Wed, 10 Apr 2024 11:26:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZBq+GsvS7VZaFEOWP4mKRDfeCyHA+NVykSOM1p
	bbCMc=; b=E+8xLFiHBvlRtvjjKp5L90b9qrr3Y/sLFzuKqoboPCUDLfYkowB6mV
	DSHz14U6rsfTOhGRcPaNC5233hzSldWKb5LYNmcp8U9p2t2MHgJiNmZkSMngMt3c
	B1oWlpAA2g6ka/CtmxtopMInZOK/njfLXJQp5SmfMXvENGTDM863E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C64371ED315;
	Wed, 10 Apr 2024 11:26:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 35A111ED314;
	Wed, 10 Apr 2024 11:26:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff King <peff@peff.net>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,  John Cai
 <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/3] refs: keep track of unresolved reference value
 in iterator
In-Reply-To: <ZhY3SUdrX2WifyZf@tanuki> (Patrick Steinhardt's message of "Wed,
	10 Apr 2024 08:52:57 +0200")
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
	<pull.1684.v2.git.git.1712597893.gitgitgadget@gmail.com>
	<6adc9dd26da4459d246591ce148c960b33bde336.1712597893.git.gitgitgadget@gmail.com>
	<ZhY3SUdrX2WifyZf@tanuki>
Date: Wed, 10 Apr 2024 08:26:13 -0700
Message-ID: <xmqqwmp5xmqy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AB8892C6-F74E-11EE-BFC6-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>>  const char *refs_resolve_ref_unsafe(struct ref_store *refs,
>>  				    const char *refname,
>> +				    char **referent,
>>  				    int resolve_flags,
>>  				    struct object_id *oid,
>>  				    int *flags)
>
> I wonder whether this really should be a `char **`. You don't seem to be
> free'ing returned pointers anywhere, so this should probably at least be
> `const char **` to indicate that memory is owned by the ref store. But
> that would require the ref store to inevitably release it, which may
> easily lead to bugs when the caller expects a different lifetime.
>
> So how about we instead make this a `struct strbuf *referent`? This
> makes it quite clear who owns the memory. Furthermore, if the caller
> wants to resolve multiple refs, it would allow them to reuse the buffer
> for better-optimized allocation patterns.

Or return an allocated piece of memory via "char **".  I think an
interface that _requires_ the caller to use strbuf is not nice, if
the caller is not expected to further _edit_ the returned contents
using the strbuf API.  If it is likely that the caller would want to
perform further post-processing on the result, an interface based on
strbuf is nice, but I do not think it applies to this case.

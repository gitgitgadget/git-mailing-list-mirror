Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBF3139D00
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608285; cv=none; b=gvL2n0LwNZI7KCjRH6JLhJE5733uKNhkQTaWJFcplKQXHSRceJfdJIN2DkXeBe4GP5bpIKd9i2o8Gly/zLMkEs15DmHzQpmoJyXBMBgMuOk2sWwwrk0SKmme9SDsWFeqFKtnhzGQt0+mtmg9JQCzE2zc+C2RXEfFhB1G3hZAAd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608285; c=relaxed/simple;
	bh=KrLNzf5d6H/myIF4wsmXOvgSORdAt2PnX0s3kRPEreE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VChhsuGOuToP8OaB2l1dv48hDOgH971RNoTv9Pr6G9xrxUq4zwgiO9QOZAppF7VBInWJXAKGZc1VWf0MbANo+eltoPPfV3WPic1ccSc5Q3o4Gakybh3hhkPzj2pArdMc47OdltH1dWi0sTqH09buCARqRHrUReA/Hk2ePPBvZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=U4E6mJ7F; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U4E6mJ7F"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B06951B5FC;
	Wed,  5 Jun 2024 13:24:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KrLNzf5d6H/myIF4wsmXOvgSORdAt2PnX0s3kR
	PEreE=; b=U4E6mJ7FoB7o+6iF+jgAVnsOEyiHP6DCiAc6s/hSN1FBsUn1C3hhy1
	IiEoWCO9BLuriWtpIpjxi2igydL/iTLstea8LaaIT8BLXB33F42y/j7RXdkXcUl3
	V16NVOr3YpcYavy0kKQpSRPgbc3PwOni+ehRVBSOE5UmL4bxJJmWc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A8DB71B5FB;
	Wed,  5 Jun 2024 13:24:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C11CB1B5FA;
	Wed,  5 Jun 2024 13:24:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,  Dragan
 Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <20240605090935.GF2345232@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 5 Jun 2024 05:09:35 -0400")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
	<b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
	<20240604101700.GA1781455@coredump.intra.peff.net>
	<xmqqikyo207f.fsf@gitster.g>
	<20240605090935.GF2345232@coredump.intra.peff.net>
Date: Wed, 05 Jun 2024 10:24:39 -0700
Message-ID: <xmqq5xunti94.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7DE9494E-2360-11EF-8ECC-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> Just to note some prior art, mutt's "<pipe-message>" faces a similar
> problem. You might want the raw message (if you're going to poke at
> headers, MIME parts, etc yourself) or you may want a decoded one (if you
> just care about body text and don't want to deal with base64, qp, etc,
> yourself). They provide a stateful config knob, but then you end up with
> horrible macros that toggle the knob, like:
>
>   :set pipe_decode=yes<enter><pipe-message>my-script<enter>:set pipe_decode=no<enter>
>
> I think having two separate commands for the two modes would be less
> confusing.

Yup, I have been suffering from its equivalent in Gnus/Emacs every
day, where decoded version of multipart/signed messages look
different enough from valid RFC2822 messages and break application
with "git am", and there of course is "feed the undecoded original
to pipe" option.

But the need for both is pretty much known, and the real issue is
that what the default should be.  The default destination of the
pipe being a pager, making the colored output the default is
consistent with that, I would think.

Thanks.

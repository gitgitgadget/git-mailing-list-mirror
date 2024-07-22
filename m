Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1311A16F903
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 19:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676476; cv=none; b=rZtxQcceNYdwHT8TTbtIfv4NO7UC2kLOhRaYywnKrRu63q8G3CKtKZqDuYurK2+X4sueF/FI16P8NN8CSItnbh+oAbeDHV0YwKR8Ri4mGZpDkHmDJTMgcc/c2TwZHAZf+p5ZvbmjAtPvKaZ0DJIdyj7tsd2rn4xKMvVQD76TV3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676476; c=relaxed/simple;
	bh=komvcwixj0wpXQrFh2b8V6lnKnpY7S0WQPwDqH/PiUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iK6k+yNyA3HYnn3CI8ag5/ZLsdJShY95zD4rtdX60lg1c6Wm/O8O72pLWCmJYx0aawzMmdbdv6Qr08aPZ3/2k9PGRL/H7MK3nlPite/Y9bDbVLKGeAQEIYGkR0GqUH2ODU+ihfPLuMOrKpB1LnYg+eQAlQQ/2D8+jiZp2JEStr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BBw1e4HW; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BBw1e4HW"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7187A3C1A3;
	Mon, 22 Jul 2024 15:27:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=komvcwixj0wp
	XQrFh2b8V6lnKnpY7S0WQPwDqH/PiUE=; b=BBw1e4HW7Tj39sKHK9UAhMnZO9Z8
	gOMI3dWR6geEN8N28hfDU7VY/mfjxjAbRDnn7zCTdxvsFBia8unAzAytUYekkTij
	4rtpbIbJb44tDNSHhjLY9kLvM6lHNNp7Kq+b8ODuXLje7Ds1wA0s07Ri+PVWZsP5
	KJtIYID5LyE0vGc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6A0183C1A2;
	Mon, 22 Jul 2024 15:27:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E65F03C19D;
	Mon, 22 Jul 2024 15:27:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Git List <git@vger.kernel.org>,  Dragan
 Simic <dsimic@manjaro.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
In-Reply-To: <079901fe-7889-4e1f-bb91-610e1eae25d3@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Mon, 22 Jul 2024 21:06:02 +0200")
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
	<ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
	<efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
	<1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com>
	<xmqqttgqyzwa.fsf@gitster.g>
	<2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
	<88f9256e-04ba-4799-8048-406863054106@gmail.com>
	<a2ea00e2-08e4-4e6b-b81c-ef3ba02b4b1f@gmail.com>
	<xmqqv80xcpe5.fsf@gitster.g>
	<079901fe-7889-4e1f-bb91-610e1eae25d3@gmail.com>
Date: Mon, 22 Jul 2024 12:27:49 -0700
Message-ID: <xmqqa5i9b51m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7C33A660-4860-11EF-8E5B-92D9AF168FA5-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>> It's a very convincing theory but it does not seem to match my
>> observation.  Is there a difference in shells used, or something?
>
> Have you tried your tweak in the "linux-gcc (ubuntu-20.04)" test
> environment where the problem was detected?  In that environment, the
> value of GIT_PAGER is not passed to Git in that test.=20

So, we may have a shell that does not behave like others ;-)  Do you
know what shell is being used?

Thanks.

Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2401A01C4
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561868; cv=none; b=JEnmCzupAmGn+rVvyqUYiboTniG2J2UiUinLukKyjzSrbZE+RhVxf3lYkKbQo/GvOPKn1gsfwEPZtkvWyZh8L2ISgYCuwNETGU1fgDE2RJUypnFR/qnXg3h0pzBcJBiiP+VMxZetHvtkayr5hn4P2g24rADjkkE+nnpQzLR+pkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561868; c=relaxed/simple;
	bh=8VtNOhrHrp6BR03Thziryta3tG9BOY2BE1KnK4l7eMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c87XHClXQuVeZ6PeUhOp2GMOQCnZolhJUfy7kIc2AGsXYQHvexfXRGa8Qw6feGyEkztRaQ8ZbXeLZDxAUgucwxEWzOsuoT7cktkNNRGmkWIgo5JdYMOQ1vvFp13LF5TxlSs2AOERcxvofz+4+Vnu/5yRAWdhZtsDjyFWViPDNXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pCfgykRB; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pCfgykRB"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9798C35475;
	Tue, 13 Aug 2024 11:11:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8VtNOhrHrp6BR03Thziryta3tG9BOY2BE1KnK4
	l7eMI=; b=pCfgykRBeXbo9J16wFxJ51bNrfZVEeghTzxo7No7z1Fz5wE99EedQc
	Dp7o+cdu4GfJOitTm7ib+8HvcFiyHLqANdYsBHK1X7pQnXOXvLYObrG1Bgjk2pEK
	0v++KO930uYMbPiMFfGk9QWnRdZWmp0KX70+aiDumGmvGI9JsH0sM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D9C135474;
	Tue, 13 Aug 2024 11:11:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8303135472;
	Tue, 13 Aug 2024 11:11:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  ArcticLampyrid
 <ArcticLampyrid@outlook.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] bundle: default to SHA1 when reading bundle headers
In-Reply-To: <20240813112434.GA968816@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 13 Aug 2024 07:24:34 -0400")
References: <TYWP301MB0563973ECA440E7DAF0F7E89C4852@TYWP301MB0563.JPNP301.PROD.OUTLOOK.COM>
	<cover.1723540604.git.ps@pks.im>
	<7e15c3daf95283f62030fe7b5dd0bbf8e467881a.1723540604.git.ps@pks.im>
	<20240813112434.GA968816@coredump.intra.peff.net>
Date: Tue, 13 Aug 2024 08:11:00 -0700
Message-ID: <xmqq8qx0a263.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4092012E-5986-11EF-9A08-9B0F950A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> Yeah, this fix turned out to be delightfully simple as a result.
>
> Both this patch and the first one look good to me. Thanks for jumping on
> this.

They look good to me too.  Thanks, all.

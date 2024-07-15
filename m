Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508D04D8A3
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064443; cv=none; b=LmER2PK6BI320P3+7nP6/XztPqzqZjIobFfzPeePLNuoIRU9tXj+4n0U70duhx8kWGdDvLIcw8ACpazX4K+fiRLSrdARZxyEp4og/TUAufnWFDtXM8cAcBEjlXpO9hsI3TOBczBlPWaB83zYQhvlNKwcJveNgVBpxJ3yWoKh3dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064443; c=relaxed/simple;
	bh=3eVnBjQtMz3VTggoDTJsHq+QLYarAvT7eIIax3ZeG0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B2Orh1C0fdraxSuTej19ywtl0NY3DtntggDGMxrJu/yV/Wtjza5Qe/MxYFqOab5xneSlOjJlT817P9J898KVI4Hw5uA/tuojHEGFQSdRcG6FUHe4j9HMesq8ghWVJVIzmg0D4x6eBx1MSu0/yCCh7J14cHP+p00+Y7aHaf6TVFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vktT7CKB; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vktT7CKB"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A77B122A62;
	Mon, 15 Jul 2024 13:27:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3eVnBjQtMz3V
	TggoDTJsHq+QLYarAvT7eIIax3ZeG0I=; b=vktT7CKBLeyBPPWoWxR5C0n4K/sf
	a3tQ7el8wwTojFIvOoRbYoofRqFJTf6RA/NdTO3UN6EK4tESwMZjaN/rm3q45cds
	T7kCpSZPoC1wfaCWBexPXrf7e5KGfYtIxFmLaScKA460+Y6Z2qsdUH6Zo4qQSXrT
	EzgfM1hbMnhR8R4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A012E22A61;
	Mon, 15 Jul 2024 13:27:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 298FE22A60;
	Mon, 15 Jul 2024 13:27:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/1] t-strvec: tighten .alloc check in check_strvec
In-Reply-To: <bf7fd471-18fb-41df-a306-2413c9d441bd@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Mon, 15 Jul 2024 18:47:49 +0200")
References: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
	<983be396-f47c-4573-8c33-af8367f8ddbe@web.de>
	<075b3d08-4270-4064-8103-1fece055e197@web.de>
	<xmqqjzhm90mb.fsf@gitster.g>
	<bf7fd471-18fb-41df-a306-2413c9d441bd@web.de>
Date: Mon, 15 Jul 2024 10:27:16 -0700
Message-ID: <xmqq4j8q4lcb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7C3DD824-42CF-11EF-8A13-DFF1FEA446E2-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>>>  		    check_uint((vec)->nr, =3D=3D, ARRAY_SIZE(expect) - 1) && \
>>> -		    check_uint((vec)->nr, <=3D, (vec)->alloc)) { \
>>> +		    ((vec)->v =3D=3D empty_strvec ? \
>>> +		     check_uint((vec)->nr, =3D=3D, (vec)->alloc) : \
>>> +		     check_uint((vec)->nr, <, (vec)->alloc))) { \
>>
>> Not a huge deal but with empty_strvec, don't we want to barf if
>> nr=3D=3Dalloc=3D=3D1?
>
> Yes, and that's handled by the comparison with ARRAY_SIZE(expect) - 1
> above.

Ah, OK, thanks.


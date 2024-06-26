Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69078825
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408814; cv=none; b=jzfR79tu2Qaa9+nv2fA0NIba6SzNYmvMyg5oWc/R4IEoHWC/wdSoK8mwxfTvMcW9QiVfJ2LEJClsNdjDwgBugoskuj2kH5MoW4DOKyMW2rd1y/KHevmG+J3xJVVi1DoQL9iDWWyY6lu9CrMLp2F5+P5NorU9DrTuw6c2c7mRFwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408814; c=relaxed/simple;
	bh=JxrnyPAw1leBvlFXr4wlrw+Re9OM42iDVCe5nGPhPbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E3Qz3x21nWLtvKwzXXDwqJwFHIHbPWzBEwfFTOjiE2d21b69m9vPGaybDckf2TwkR8oGcFBxTsMOwLlMAemYPBUfamKJECuXEbyP2kpqdSbHE+Zs13xuQmg+dGtzp37THsy11sX+gE5mfs1cwLsftmz0XhRgPChX8BAlMU33fxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hZS3qBUX; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hZS3qBUX"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 62F4E31763;
	Wed, 26 Jun 2024 09:33:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JxrnyPAw1leB
	vlFXr4wlrw+Re9OM42iDVCe5nGPhPbs=; b=hZS3qBUXDopuBURnzseif1+uFV6p
	9jiB578wjhqdDlAU/2vI5KGCBxQXA8mD74s0LIPOlwZI/i1O7NvQUm7A2Gzt5ZgZ
	JWgxDk2XVNVwinHlcyMxIg60uoW8npkRPpwEsXuSao0tCoJd7noJlDPDrgUs5k6K
	HaKA5MTw+3yCMtM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B0EF31762;
	Wed, 26 Jun 2024 09:33:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 32CF931761;
	Wed, 26 Jun 2024 09:33:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH resend] git-send-email: Use sanitized address when
 reading mbox body
In-Reply-To: <202fc42e-c5be-4a4b-a135-302d8fbf6b2a@prolan.hu>
 (=?utf-8?B?IkNzw7Nrw6Fz?=
	Bence"'s message of "Wed, 26 Jun 2024 10:58:03 +0200")
References: <20240621092721.2980939-2-csokas.bence@prolan.hu>
	<xmqqr0cqmck5.fsf@gitster.g>
	<a55cc932-98b0-43cd-9dfa-ea21a4340bf6@prolan.hu>
	<xmqqy16ue3vl.fsf@gitster.g>
	<202fc42e-c5be-4a4b-a135-302d8fbf6b2a@prolan.hu>
Date: Wed, 26 Jun 2024 06:33:24 -0700
Message-ID: <xmqqzfr77rrv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 AAB0BF46-33C0-11EF-AC97-C38742FD603B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Cs=C3=B3k=C3=A1s Bence <csokas.bence@prolan.hu> writes:

>> In any case, if we were to move forward with this topic (whether
>> "send to corrected $sc instead" or "$c is suspicious, do not add it
>> to $cc" is picked as the direction), the motivation behind the
>> design decision to treat the address taken from a trailer line
>> differently needs to be explained better, I think. [...]
>> Your proposed commit log message is the place to help them.
>
> Okay. So in short, I should add justification for trusting mbox
> headers and not the message body, correct?

We want these to be explained for future readers:

 (1) we stuff the sanitized address to @cc in this particular place,
     but we still let all other places copy the original taken from
     the message to @to or @cc (as in the original code).

 (2) the reason behind the above difference is because we trust less
     about the "address looking" strings that appear on the trailer
     lines.

So, not just (2), but in order for the readers to understand why
they should care about (2), they need to be told (1) as well.

Thanks.

Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C57D15E5B9
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712090278; cv=none; b=qpSBS7ELN7Jx4OebBD+Q2V7g/JT+fyF0gyTDC8FYC3en41WCOhfENzuHiMffvw689r5gDhIepa2uGiGumoi6wAymV0F81iC/ztf1YhxDcasguJVW4OqMdmQyRrxZpPaueNd7hKcHmB+Hya1VRRJbFGhYCrQH4j26IYm0RPI66vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712090278; c=relaxed/simple;
	bh=J3xr2G9rZP6/IeLc09fYfPaUKZK0ik7CanFsrsZyUHg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=msFdiDayQFscuxLhiOwKckJPBX7aFWPsi1o4E3cXIJeElX+D7ttwm2BsFe0SuMiTmrru1r3mzUQvSyV+Daa7YX8HgNVzmFTUGUuvt04EdVmXqC3To8k1XM+SQRBj3IU9Q1irP12ZVj/R+bjPegb8Ol2NKqPxgHm8THMUTjn2p6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kQ6+m15J; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kQ6+m15J"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 567B01E3966;
	Tue,  2 Apr 2024 16:37:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=J3xr2G9rZP6/
	IeLc09fYfPaUKZK0ik7CanFsrsZyUHg=; b=kQ6+m15JliIcZIXky0pK6fXY1/8h
	N9b0nDwoR4As2NFLr8CD38MMr9L7sqbKTdo+TE+cZUabeQisfgrpPidRsCvSFH57
	Jkn6b7sRnT1bOYMYkDJ9da3YGZElx49lhbGrLG6yqKIYYzfGVQBUlwVAQFZWoYmh
	FmlEdaTqgKPmbBg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EA1D1E3965;
	Tue,  2 Apr 2024 16:37:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B299F1E3964;
	Tue,  2 Apr 2024 16:37:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [BUG] "git range-diff" does not know X^! is a valid range
In-Reply-To: <9b184d3e-412c-4357-83f6-5aad51a8e3d2@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Tue, 2 Apr 2024 22:24:23 +0200")
References: <xmqq7chf64l1.fsf@gitster.g>
	<9b184d3e-412c-4357-83f6-5aad51a8e3d2@web.de>
Date: Tue, 02 Apr 2024 13:37:52 -0700
Message-ID: <xmqq34s34i1r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 E167B2C4-F130-11EE-A83B-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Seems to work fine in this example:
>
>    $ git range-diff refs/remotes/origin/maint^! HEAD^!
>    -:  ---------- > 1:  c2cbfbd2e2 The thirteenth batch
>
> Are your refs valid?  Does "git rev-parse" resolve them properly?

Ah, HEAD^! was typoed without SHIFT key.  Sorry for the noise.

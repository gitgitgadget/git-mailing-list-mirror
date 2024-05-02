Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E73715FA72
	for <git@vger.kernel.org>; Thu,  2 May 2024 21:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714684867; cv=none; b=MN7RCSkG6dT3ci8Zr/mPBrPPNWxnboEUtQoh7EncwbYMZ5CLUkS+fTm3w8CAnAwP87JPD2F+To0ymGHeAv79r3cT2ibUHm/V1qb1tyW/d0F528wWskQ6b6V6T+JgFKzZGm0WJXpKiWRGs+bvUxBtSQDL1bdljvmX4zEWpc22H38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714684867; c=relaxed/simple;
	bh=mOIpqT9V0zKwU9BcGJutE2FGrhaXHFSe2IlOJAyT2To=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=peE+ayzgJMkMIAt2aR0xhHbDmVN1QhEGqBUERnM0L4rTk8aI5iIos1lksEZh04WWqS0w0mKtrIw4MFVJH2tJBm97NzGzbDdfRRSe9+EZYCMBTjzdnFwlg8vlblaHsCXNcTaJVb0t4aTheWlFkt+vbdG5IuFufwJdDfg6KFg6ynE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pAks3hsO; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pAks3hsO"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1578233B04;
	Thu,  2 May 2024 17:21:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mOIpqT9V0zKw
	U9BcGJutE2FGrhaXHFSe2IlOJAyT2To=; b=pAks3hsODNPmjx1gadS8qY0ID+7d
	3j3wzmLBeMZpCE0uk5sOh4JKb5snwfSrsakupPFakEeJb3XWEV60L3BZWQt0pUtM
	GHUpyHdGR0ObKyiP22cp3yM+957KJmDtscQcIb8pV/1C2It7Nv2syCWmJS4cBrw5
	A+sojBdT77VykOQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E6FE33B03;
	Thu,  2 May 2024 17:21:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7DD5A33B00;
	Thu,  2 May 2024 17:20:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
  git@vger.kernel.org
Subject: Re: t4216-log-bloom.sh broken ?
In-Reply-To: <20240502205121.GB11895@tb-raspi4> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Thu, 2 May 2024 22:51:21 +0200")
References: <xmqq8r0ww0sj.fsf@gitster.g> <20240502055621.GA29945@tb-raspi4>
	<xmqqsez0fbam.fsf@gitster.g> <20240502185903.GA11895@tb-raspi4>
	<20240502192622.GA1841@szeder.dev> <xmqq7cgcdm4f.fsf@gitster.g>
	<xmqqsez0c6ma.fsf@gitster.g> <20240502205121.GB11895@tb-raspi4>
Date: Thu, 02 May 2024 14:20:54 -0700
Message-ID: <xmqq4jbfdi6h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 DD423588-08C9-11EF-9A09-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Thanks folks for digging - the patch makes both test cases pass.
> Some official information:
>
> $ man mv
>
> on the both machines says
> [snip]
> If the destination path does not have a mode which permits writing,
> mv prompts the user for confirmation as specified for the -i option.
>
> To summarize what I have at hand right now:
> MacOs 11.7.10 fails t4216 and t5318, both pass under MacOs 13.6.6
>
> But why doesn't `mv` not hang then ?

It is a sensible choice for the command to assume a "safer" no and
continuing rather than hanging, so that part is understandable.

So presumably 13.6.6 has a working "mv" but their "man mv" is not
updated to how the command actually works?

In any case, let me declare victory and queue the patch I sent
earlier.

Thanks.

Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C162B1990BE
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500950; cv=none; b=sL9HnqgUO0g99MWyy2UMJlUjxZeAjZRm7xqcVxir0ugZ8fJT525pmfHmDfhlzjU68ql6t8fRYv6qcdDbGv1WxuPegToZSE0lgx6o+v7Aa3D/MuerKfUKXAnZ1DHN/wmyvQZSv8s5Ol2BDGGJ09SNbewvBenosh09/LXEJHNRm8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500950; c=relaxed/simple;
	bh=hJH8SCER1TRyTQW4hJTKOuizDq3LV9WJLuZuTKdUKvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qZNFVIoDYVTvO3BN+v/FoYL51lPh5sLo3HlNL2NmHHn5YX/sOfoMTg4z+/bY0dlAkxxvq9JJA1kZofaO2D1039vDZYOSsVrdSPjWjXAGVOHFQRGn/TzeR4kDyYapnn0pM6s6fgwo3nkVPiuW3vocaMYuQm15Cxgu/xo9THWQtwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xHp/z7KD; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xHp/z7KD"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 59701289FC;
	Thu, 27 Jun 2024 11:09:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hJH8SCER1TRy
	TQW4hJTKOuizDq3LV9WJLuZuTKdUKvI=; b=xHp/z7KD0elR8KavXX+T6jcHIUMn
	S1/E4Twu1oglrFcRFATwjtYqQVbeCovXdn049Cnbp97yEuKgUlqqMbETqmxUjmlk
	dkLn8ItCK1wndh5OtDKaR4y9WbkN7k1+i11sMOQrr17Uyp/+gy2BfHN27Dp5MCRR
	fq5RZPR6SgEyIFA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 51C5A289FB;
	Thu, 27 Jun 2024 11:09:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EAA25289FA;
	Thu, 27 Jun 2024 11:09:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v2] git-send-email: Use sanitized address when reading
 mbox body
In-Reply-To: <f245c5e8-b986-49f1-91fe-7e24593e8e85@prolan.hu>
 (=?utf-8?B?IkNzw7Nrw6Fz?=
	Bence"'s message of "Thu, 27 Jun 2024 10:37:06 +0200")
References: <20240626132440.3762363-2-csokas.bence@prolan.hu>
	<xmqqy16r1ulu.fsf@gitster.g>
	<f245c5e8-b986-49f1-91fe-7e24593e8e85@prolan.hu>
Date: Thu, 27 Jun 2024 08:09:02 -0700
Message-ID: <xmqq34oywhgx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 31127666-3497-11EF-9B21-DFF1FEA446E2-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Cs=C3=B3k=C3=A1s Bence <csokas.bence@prolan.hu> writes:

> Valid addresses are already tested by former tests. I don't
> immediately see any tests that would cover non-Cc, non-*-by and
> non-email-address tags, so I might add them; should they be a separate
> testcase or part of this one? Or maybe even a separate patch?

The tests you added has only malformed addresses on trailers, and
adding a few trailers with valid addresses *and* string that does
not look like an address at all, would be a minimal fix that makes
the test complete.

It makes it clear that the point of the new test is about strings
found on trailers (that are dealt differently from addresses taken
from other places) are handled appropriately, checked how they are
shown to the MTA (with the comparison !address!  output from
fake.sendmail script) and how their additions are logged in the
verbose output (with the pattern match with "^(body) Adding cc:
...").  Checking that totally irrelevant ones (e.g. bugId) are not
even used as addresses, strings meant as addresses but malformed are
used after correction, and well-formed addresses are used as-is,
would form a complete set of observable behaviour from this feature.

Thanks.


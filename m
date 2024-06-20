Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B1C36126
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718922950; cv=none; b=KQOG0ZIB62+SMddT5QvQxRLcholkT7jNwWdA/5tfBLwYdPY+k/ZZDSYtSFwpGliuDX8m967OK5cL3KRap3ucENXINaWnjhuBWRynanZebsn8qHv6S2BOzVzJJit2IJ5vbBJwrxTeVM+LNZS2qrH6fn81mJVtevVHVURxJkAM9Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718922950; c=relaxed/simple;
	bh=xckEAxktlULJphcpUDMoRTrhNCnaP4L+mJGzhQS6vq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lQXOdvgGA6lLgbdp7O+NloRykvT5fSRNtX81OpV0XoXUA63Faa28Wyjgsm7u6K6J/kQnQiLBMYJA7KcrohEZxDInoq339e5pmMdJdlpbSesI3varo0fiponAQxzy81cdY7bdJTglkK6nZC+jZs2mw3pOFfAauJBXaFbDCxk0qGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ecfkQuWj; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ecfkQuWj"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D666E1F164;
	Thu, 20 Jun 2024 18:35:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xckEAxktlULJ
	phcpUDMoRTrhNCnaP4L+mJGzhQS6vq0=; b=ecfkQuWjm3IM0eqvHpPOLGO8GmJ1
	LzZCqXfOSYK8AC6nHvcmgvNkjt5JjFbO2H9RguYPOPk6BNSMEhysAGPF9H9Jrb8w
	BGAUo6ITAMhP7sZlEswLQ7YPUwWEk1f0W2xtxiJ/naWzrqCM2rjcjI16wgehJCMT
	awEJ8EKX3NPyJa4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CC3B11F163;
	Thu, 20 Jun 2024 18:35:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 39FB31F162;
	Thu, 20 Jun 2024 18:35:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,  Jeff
 King <peff@peff.net>
Subject: Re: [PATCH] pager: die when paging to non-existing command
In-Reply-To: <ba5965c2-9f1c-4dd2-a2c5-e1bde832766c@kdbg.org> (Johannes Sixt's
	message of "Fri, 21 Jun 2024 00:17:22 +0200")
References: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com>
	<xmqqsex7tp0c.fsf@gitster.g>
	<ba5965c2-9f1c-4dd2-a2c5-e1bde832766c@kdbg.org>
Date: Thu, 20 Jun 2024 15:35:46 -0700
Message-ID: <xmqqplsbqm2l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 702D8B20-2F55-11EF-8E65-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Johannes Sixt <j6t@kdbg.org> writes:

> Am 20.06.24 um 21:04 schrieb Junio C Hamano:
>> Just in case there is a reason why we should instead silently return
>> on MinGW, I'll Cc the author of bfdd9ffd, though.
>
> I don't think there is a reason. IIRC, originally on Windows, failing t=
o
> start a pager would still let Git operate normally, just without paged
> output. I might have regarded this as better than to fail the operation=
.

The "better keep going than to fail" is what Rub=C3=A9n finds worse, so
both sides are quite understandable.

It is unlikely that real-world users are taking advantage of the
fact.  If they do not want their invocation of Git command paged,
"GIT_PAGER=3Dcat git foo" is just as easy as "GIT_PAGER=3Dno git foo",
and if it was done by mistake to configure a non-working pager
(e.g., configure core.pager to the program xyzzy and then
uninstalling xyzzy without realizing you still have users), fixing
it would be a one-time operation either way (you update core.pager
or you reinstall xyzzy), so I would say that it is better to make
the failure more stand out.

Thanks for a quick response.

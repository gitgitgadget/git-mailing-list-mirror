Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6488F1836CD
	for <git@vger.kernel.org>; Wed, 29 May 2024 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716999460; cv=none; b=pGdBfWtSddT8jy4j00pTni/a56lgTtoQ57WK/CHrFGQ2vUUwtltGN5trcUQ2R0xQM0LiiQaUduk2l+JmujzoyGCzomI/dP3ISmD4WhNAEMyqMwgN3tfwFurp8TMCG1AwVGSvhoUVpjV+26rVIqGn/52MOn7ZxVS0l9YCXnKCJT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716999460; c=relaxed/simple;
	bh=ridSCcqdBgTJbOHsmacMT5m6uHFgxC/uBofyFN/QmbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SKE/nFR3/mf562qNOXl1LSJk76430jLY+ZJUj8OlhZivJY965khhykzGNoLIbMQFpviYk503GCFaTj4rsX2MFqKi1j/8J1uI4QOgPFLQRjUwexOSWr7NgV+Ps+4xsS2rMnEkaFyr3Tf5sz4y3YDGpsEegBkW5jLRpo9gD5zDM1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QYL3F1ZZ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QYL3F1ZZ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 34DFE231AA;
	Wed, 29 May 2024 12:17:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ridSCcqdBgTJbOHsmacMT5m6uHFgxC/uBofyFN
	/QmbY=; b=QYL3F1ZZJVR2YHqQg6GNctCvXw3238pb9Y5+Z/Ig3f5PyEieomPgcs
	sb/sg5R0bdtc9LMeysVbQzgY3/d5fdVpV4iSKo5uqAH3EFPYfZEeZBz+8vI7CO2D
	UlxLkW9Jil3GjJ3E0pIsh4Gj9FjVtOFoRiDNor4ov5y2BjZ6FfMX0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 28F24231A9;
	Wed, 29 May 2024 12:17:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 71D57231A3;
	Wed, 29 May 2024 12:17:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Jeff King <peff@peff.net>,  Joey Hess <id@joeyh.name>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH 0/2] Revert defense-in-depth patches breaking Git LFS
In-Reply-To: <1cbdeb41-2ad3-05e4-ab27-1f84086b7f43@gmx.de> (Johannes
	Schindelin's message of "Wed, 29 May 2024 14:17:41 +0200 (CEST)")
References: <20240514181641.150112-1-sandals@crustytoothpaste.net>
	<0f7597aa-6697-9a70-0405-3dcbb9649d68@gmx.de>
	<ZkO-b6Nswrn9H7Ed@tapette.crustytoothpaste.net>
	<Zk2_mJpE7tJgqxSp@kitenet.net>
	<fbb89826-0d83-d4f9-bab4-9fba69e0e22d@gmx.de>
	<ZlU94wcstaAHv_HZ@kitenet.net>
	<20240529085401.GA1098944@coredump.intra.peff.net>
	<1cbdeb41-2ad3-05e4-ab27-1f84086b7f43@gmx.de>
Date: Wed, 29 May 2024 09:17:28 -0700
Message-ID: <xmqq4jagzj6v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F2C33188-1DD6-11EF-BCC1-25B3960A682E-77302942!pb-smtp2.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 29 May 2024, Jeff King wrote:
>
>> [...] But of course most sites just use the defaults, so all warnings
>> are effectively errors.
>
> I wish that had been pointed out on the git-security mailing list when I
> offered this patch up for review.

I sympathize with the sentiment, but there are things that becomes
much clearer once you know what to look for by getting specific
complaints, and I am sure that you would have come to "ah, there is
this strict thing in addition to the msg_type" yourself, without
anybody pointing it out to you, once you looked, if we had Joey's
report while working on the patch.  I would have noticed it with a
breakage example back when the patch was first floated on the
security list, but of course I didn't, because the patch was only on
the security list without wider testers.

The take home lesson from this episode should not be "people should
speak up more in the security list".  It instead is "let's try to
limit the work under embargo to absolute minimum, and work in the
open for anything on top".

"We saw an issue that we followed a symlink when we shouldn't, which
we are going to fix here, but it became high severity because of
where that symlink pointed at" may be a valid sentiment to have, but
we should stop at "fixing" it under embargo, and addressing the "but
... because" issue on top is better done in the open.  Even if we
propose "let's not allow symlink at all---that way even if we wrote
through symlinks by mistake, we won't damage anything", there will
be more people to correct us when we worked in the open.

In any case, let's clean up the mess we created in 2.45.1 and
friends quickly to prepare a solid foundation to allow us do
additional work on top.  The reverts are in 'next' and I plan to
merge it down to 'master', which hopefully allows us to do the
follow up releases soonish.

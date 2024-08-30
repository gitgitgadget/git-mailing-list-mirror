Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438251B3B10
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036547; cv=none; b=jPsut8suedBs4q+MVnQqs7UKSDTbB7XGvzt/DKqn7wmqdk81X8gFOSz07KmTOBpXmJfNFp+NKI3WgHAsQTxwnJhbgeO+z9daU5NcMyOO0bEvXQKIeQKlWvDBmAVgIXrlb1NJUQoE+4uQI6vi/Ib5yYI07Y/H3nhvuH2qmx81cFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036547; c=relaxed/simple;
	bh=n2AopIf7pFJjY92OxCH5a/7PPeS7F4zS0GCWEWmsOt0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j4kWzO7EyMawVc2NOFWt7d8uGIlO4PMP1RDhn3BFUB2q7x/YfQxdR4kzdIJ4crXmXFfJnkErDCkOAMVULlvfhMJ8PZA4VVq4bq4KddU7HdrwlEKX7inAmuyaZjWe8uht4tpKEM+ElREBC0SZ724dwifIAUVVId7QL/Vm43c/a8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hsJiHtvu; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hsJiHtvu"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DF1A2FC4D;
	Fri, 30 Aug 2024 12:49:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=n2AopIf7pFJjY92OxCH5a/7PPeS7F4zS0GCWEW
	msOt0=; b=hsJiHtvuSqxPnOhaftJ1axR7s2nshUtxJ3UPJ5giXMs87339d/JCmP
	SaVwlA1E/RVbvU8QMUYk3T6MAoRYmn15v2ITqUn5ZUIl0aPyEsgFbc28K6YkDutm
	dm1keo/4xjrXtYFGpiokp3HgMYaoTc7Ke7Ph3lDApLkdmx4ArZFLs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 209DF2FC4C;
	Fri, 30 Aug 2024 12:49:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3BF812FC4B;
	Fri, 30 Aug 2024 12:49:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Jeff King <peff@peff.net>,  Pavel Rappo <pavel.rappo@gmail.com>,  Git
 mailing list <git@vger.kernel.org>
Subject: Re: How to turn off rename detection for cherry-pick?
In-Reply-To: <CABPp-BG-Nx6SCxxkGXn_Fwd2wseifMFND8eddvWxiZVZk0zRaA@mail.gmail.com>
	(Elijah Newren's message of "Fri, 30 Aug 2024 07:33:51 -0700")
References: <CAChcVumj41NCAcjzLyDGAyb+-QuL0Ha1AANe67jKVBT8xDRYdg@mail.gmail.com>
	<CAChcVunYDO_KAmEOoWEL2q63_Gzua-Kt3BmE5Snb8==K9Cww1w@mail.gmail.com>
	<20240829214336.GA440013@coredump.intra.peff.net>
	<CAChcVukzk=-1JNAoffWQEEv4Ne1FozGEwzGuaUWuiwhoHkcUng@mail.gmail.com>
	<20240830003147.GA450797@coredump.intra.peff.net>
	<CABPp-BG-Nx6SCxxkGXn_Fwd2wseifMFND8eddvWxiZVZk0zRaA@mail.gmail.com>
Date: Fri, 30 Aug 2024 09:49:02 -0700
Message-ID: <xmqqmskurm69.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C3FA19CC-66EF-11EF-9485-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Elijah Newren <newren@gmail.com> writes:

> Anyway, I'll add support for no-renames to my list of things needed
> before we can delete merge-recursive.[ch] and make requests for
> "recursive" just map to "ort".

Sounds sensible.  Thanks.

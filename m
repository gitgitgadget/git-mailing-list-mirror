Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7D01AF4ED
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725038239; cv=none; b=RxKJLDZal5vwTqyq/h56ePU4YjdQpCEBayF6kBgoV4Vkcf0+o3L4dKX6Tv3eJOv0oaxwYzCYmH72EqmmduoSULiPMUzVLix94xeH7yUbSoSxM5vMk9j18Mbhs5YS6eStKyiaMrDxsM/Ftxiw3eylz2wFRqcNXLdBd7SOgKDFRsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725038239; c=relaxed/simple;
	bh=kRj8GSkeQXajxTNd7MiXy3lCFnxx2nWQzfPSz2gpQuA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SNcrhL77W7srj2n3zy7EEy9o5iRow69PE/muacRDTOD6D5FiG20mr2L5frBuOYy80FpYugmyAAV7tYvS/aQ4j0YKSwq9BhLRqVawjdfR7HSUjFyCGpj/9CDTPDEio8dgTATxPI1vtulK725y9SBl+Vu8aPNRLsgcyD47IZ/jZfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=R8blXR9Z; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R8blXR9Z"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0513F3005E;
	Fri, 30 Aug 2024 13:17:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kRj8GSkeQXajxTNd7MiXy3lCFnxx2nWQzfPSz2
	gpQuA=; b=R8blXR9ZEHsrekNhVRB9b9a8FwraGTGZ5gOmtjafKe0+d4HWlStb/M
	NJPmoKc3ZOUDv1QZAnP8JHBiT8TIBSk/sJb9zLkrrklyJgq1JHI8e+oc0KgLJhWp
	LBuQmeL+NURNC5lr1M3I9WomYMuSvDosYaY2ARvXsPU+223WEEUJ4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F14EE3005D;
	Fri, 30 Aug 2024 13:17:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65E3C3005B;
	Fri, 30 Aug 2024 13:17:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Pavel Rappo <pavel.rappo@gmail.com>,  Elijah Newren <newren@gmail.com>,
  Git mailing list <git@vger.kernel.org>
Subject: Re: How to turn off rename detection for cherry-pick?
In-Reply-To: <xmqq8qwet2c8.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	30 Aug 2024 09:14:31 -0700")
References: <CAChcVumj41NCAcjzLyDGAyb+-QuL0Ha1AANe67jKVBT8xDRYdg@mail.gmail.com>
	<CAChcVunYDO_KAmEOoWEL2q63_Gzua-Kt3BmE5Snb8==K9Cww1w@mail.gmail.com>
	<20240829214336.GA440013@coredump.intra.peff.net>
	<CAChcVukzk=-1JNAoffWQEEv4Ne1FozGEwzGuaUWuiwhoHkcUng@mail.gmail.com>
	<20240830003147.GA450797@coredump.intra.peff.net>
	<xmqq8qwet2c8.fsf@gitster.g>
Date: Fri, 30 Aug 2024 10:17:15 -0700
Message-ID: <xmqqikvirkv8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B4927822-66F3-11EF-BC03-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> though I'm not sure how DIFF_DETECT_COPIES should be handled
>> ("recursive" silently downgrades it to DIFF_DETECT_RENAME).
>
> I somehow suspect that we would want to go there to avoid
> overloading ourselves (and end-users) with conceptual complexity.

Of course, we would *NOT* want to go there X-<.

Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4B918635
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523434; cv=none; b=R1F6jpGIqPeri3h7hM9iWH2LtZLX/KHlgcUoJOLiTEwCqyUSm6we7lpHGR5U9Ba0CTgYtApNmgkqFFt5nMFzPTC987zlEXUkb74cSi47CKtB64ym+EexjXBK4cW28znYnhiJkqvLQQtWbXiRaSMo5RhFMaPyu8CMMmU7OMmHl7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523434; c=relaxed/simple;
	bh=UnpIxeD+pNSSA+gCMpBXi9FnB9GFbNya5xCcefY+YHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J3PrkhkDsLYoZXceeu4ddfe9N/sCNydsRQbq/EembSP2E6uuAuXcMzoIZZRfhQYxB/wRUGnUXpcN7mK0tY0cSieosjUBj54ECJhHRQZT1+SkAyuQdqlGbPS+qkUXBp4euiSHk0DFdV2ZDyt7Ug+BD+GL7hgmdvw4tl5MOXLl7FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=M96al98W; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M96al98W"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 313E21D11D;
	Tue,  4 Jun 2024 13:50:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UnpIxeD+pNSSA+gCMpBXi9FnB9GFbNya5xCcef
	Y+YHU=; b=M96al98W4DWFcDzoKvqDe+d/XJfBDdaG3PfGW6icSldyXwgFgWbYqO
	lu6KhH8n3DLu7bKpd9zQWhgcDF8ZQUmI0OsF5QSYNZaAvpEnpvn9cjQmn2aaGqGw
	qnUEgC8VwW2+EDuHPBX6tFnpxeICW0oqd+AzJ3QRZnxjHXr5xeuME=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 27E6B1D11A;
	Tue,  4 Jun 2024 13:50:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E8441D119;
	Tue,  4 Jun 2024 13:50:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: rsbecker@nexbridge.com,  'Curley Joe' <m48cv7wg9w@liamekaens.com>,
  git@vger.kernel.org
Subject: Re: git fetch --prune fails with "fatal: bad object"
In-Reply-To: <20240604104437.GD1781455@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 4 Jun 2024 06:44:37 -0400")
References: <16919-1717194882-875013@sneakemail.com>
	<xmqqplt1d0k0.fsf@gitster.g>
	<000501dab3b3$51779400$f466bc00$@nexbridge.com>
	<xmqqo78kbqwo.fsf@gitster.g>
	<20240604104437.GD1781455@coredump.intra.peff.net>
Date: Tue, 04 Jun 2024 10:50:30 -0700
Message-ID: <xmqqcyowwqah.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EFB0BE8E-229A-11EF-89D2-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> These are good examples. I was going to suggest fsck, as well, just
> because I knew it would keep going after seeing bogus results. But more
> interesting is that it is finding things in your example that other
> programs would _not_ find, because it's being more thorough than just
> reading the refs.

True.

I wish for-each-ref and friends had an optional mode that lets them
keep going, but since so many features in them access objects
pointed at by the refs (e.g., "--format='%(objectname:short)'" and
"--no-merged HEAD"), it would be very cumbersome to retrofit such a
mode to the underlying machinery, I suspect.

Thanks.

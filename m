Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616F7249EB
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058299; cv=none; b=Smz2h0hInasdYMXgofhTWL6XZMgWR5eUv19JX5aCi2Z4aLH96v4gRVxwfOqFDuncX5AS0P6+XPxcjFPjmxVkMi1UmOe++UYh+6/++5k4Jr2uU7XgHGxotbbc5mIb3r/185vcdKE1nmqHemP7NgVk0tHezdsLysvio+QNe1Hom6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058299; c=relaxed/simple;
	bh=Y07zL2aciJt7R5NAC43GgIdFSHWraX3S1V7x9uRo2n8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nnr4pROMC1Lp4NXWyWlJMXQ5AG31k9dW4jdG03pK6wCPtL/i+UKRWPwm8iDljT6cxrQqidVq1GA1j+g0XXjGEHheVLU+/o3zsBMteSRq2NqSpZrH/9jEbPvVAp/ac2RGJ6dpd3Ml+XIBqLO4R0ZbxUYFPBVUDuENWamnXyCnsJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=I57bLJe/; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I57bLJe/"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DA2481D1882;
	Tue, 27 Feb 2024 13:24:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Y07zL2aciJt7R5NAC43GgIdFSHWraX3S1V7x9u
	Ro2n8=; b=I57bLJe/KdEFfSjy/6XGX/vESkZEJwHRK7EL2hDFDDQXilagU7uVFJ
	aRpqoYeI9u6hJkM2D527bkKaE6jKpVjDFfnBIJRjBv2GONhfay39wkjVF9QSugwK
	sNlSyI6jhcxcdPcTLKnP04nx4ld2+ALm3rohraj3/ibtByyQUuqOw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CEE081D1881;
	Tue, 27 Feb 2024 13:24:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 338031D1880;
	Tue, 27 Feb 2024 13:24:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Dirk Gouders <dirk@gouders.net>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v3 05/11] commit-reach: start reporting errors in
 `paint_down_to_common()`
In-Reply-To: <fa8ebbfd-e01f-fbde-c851-54c162b610ff@gmx.de> (Johannes
	Schindelin's message of "Tue, 27 Feb 2024 16:08:16 +0100 (CET)")
References: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
	<pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
	<85332b58c37717b5b8b6c826a2a3388dce3b0daa.1709040499.git.gitgitgadget@gmail.com>
	<gh34tenefb.fsf@gouders.net>
	<fa8ebbfd-e01f-fbde-c851-54c162b610ff@gmx.de>
Date: Tue, 27 Feb 2024 10:24:48 -0800
Message-ID: <xmqqwmqpsr2n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7DCE12E8-D59D-11EE-BEDB-25B3960A682E-77302942!pb-smtp2.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Is it lazy to omit the `< 0` here? Not actually, the reason why I omitted
> it here was to stay under 80 columns per line.
>
> Good eyes, though. If `paint_down_to_common()` _did_ return values other
> than -1 and 0, in particular positive ones that would not indicate a fatal
> error, the hunk under discussion would have introduced a problematic bug.

The same patch does compare the returned value with '< 0' in another
function (that is far from this place), which probably made the hunk
stand out during a review, I suspect.

After having fixed a bug elsewhere about a codepath that mixed the
"non-zero is an error" and "negative is an error" conventions during
the last cycle, I would have to say that being consistent would be
nice.  I think we at the end decided to make the callee be more
strict (returning negative to signal an error) while allowing the
caller to be more lenient (taking non-zero as an error) in that
case.

Thanks.


Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0854160860
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723238057; cv=none; b=N7ypybz7BXaKSsnDEHv0TKainnhG4zuQeZt7ybu4qesu+7RhvwMdD8qo4BWAxDi/71QQjmQNpEnGmZoldqXLkpTnVUsAaTnQtgQ1cFGimv2cxsvzCkzILpvQjoiirRipIRnLpw6VxFVOYAA5nWt95oM42+11AN2BAKHmCfPqEgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723238057; c=relaxed/simple;
	bh=IKbaLtQkpww+nO9uKdBd21gXehIvG0U8/6HQ23NiCqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pgA5H1eIVClj3yGehI6u/cvlGyPSU6DPznGnr7pld0j7YIRIhqi5X03RCXZkW/MpyoB3w3J+0yha24lZfbo7J3SrjLA/9psfnIALgrtzbsnTcbOHccnrrC2+lgRp/OlaFBwSFD4Dh37KfUZfLG/I3s8eUZcGeJkuiTI31aDwwlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=U6WHIujB; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U6WHIujB"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76E991DD02;
	Fri,  9 Aug 2024 17:14:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IKbaLtQkpww+nO9uKdBd21gXehIvG0U8/6HQ23
	NiCqo=; b=U6WHIujB9L9evkIDxY+8+nuZ8Q+2oyP867T42lojMK2SDTxAdd1/wG
	mss0BfkfFG8ojkl+zBTNqwEAp4MDeI7/UG4puTrsk8gwzG/iL/b/lTVpbPw6m/TS
	eBrBYzCifKI1XtSESKJjWxt9Rv9T2CZfjaFBni6maG19zd2ow3wfo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6ED7D1DD01;
	Fri,  9 Aug 2024 17:14:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C8A8A1DD00;
	Fri,  9 Aug 2024 17:14:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 14/20] config: pass repo to
 `git_config_get_expiry_in_days()`
In-Reply-To: <qo26pmkrctepcob4vjfimvxlgoic7gqjxasnz2hqmv4hpgc37t@jh5wo2fjqyoo>
	(Justin Tobler's message of "Fri, 9 Aug 2024 15:21:18 -0500")
References: <cover.1723013714.git.ps@pks.im>
	<cf7942479f75d95dcd8606b0947a8897ae60da60.1723013714.git.ps@pks.im>
	<qo26pmkrctepcob4vjfimvxlgoic7gqjxasnz2hqmv4hpgc37t@jh5wo2fjqyoo>
Date: Fri, 09 Aug 2024 14:14:12 -0700
Message-ID: <xmqqh6btbdqz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5420E7E0-5694-11EF-AD4F-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Justin Tobler <jltobler@gmail.com> writes:

> On 24/08/07 08:57AM, Patrick Steinhardt wrote:
>> Refactor `git_config_get_expiry_in_days()` to accept a `struct
>> repository` such that we can get rid of the implicit dependency on
>> `the_repository`. Rename the function accordingly.
>> 
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
> [snip]
>> -	git_config_get_expiry_in_days("gc.rerereresolved", &cutoff_resolve, now);
>> -	git_config_get_expiry_in_days("gc.rerereunresolved", &cutoff_noresolve, now);
>> +	repo_config_get_expiry_in_days(the_repository, "gc.rerereresolved", &cutoff_resolve, now);
>> +	repo_config_get_expiry_in_days(the_repository, "gc.rerereunresolved", &cutoff_noresolve, now);
>
> non-blocking: Do we want to fold these lines?

Yes, if we are going to see another iteration for other reasons.


Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1298333086
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722975708; cv=none; b=okTDd5NQTw4KciLTYnrKMPSBWLIWInyN2RTV+egD6dbm+jbVoNMpXZWo1qk/O123vagSM6sZBWx6Dy3PcpaiaTq94kVa7Gi7oY4CfT1pk4xXlTEfN+72e8aROOaZ4okMArZ5oIDMQvssrpaESp1X7trQtmIq+gmk7CT5pYyPOvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722975708; c=relaxed/simple;
	bh=4YppW2muRsqZiCCmFxzy1WsuptDGVi0ZZ4u1SifYS3E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OwaM9qtFC4JwH1RWrW/MBnlaYbs9gMwmkq3qBz0KMySgvo+cVV8AdiBjAr8plldo2XEvEnPQliA7Vi6/r+2nEbHs1Rq5zmC3qn8+l6vCySFktrnF2Vhnl5ruOpPyqxgcxkJYNRdIIfuI1+0f0gm1byPK2rxuoSZrb0VYpjQiFRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FyNFg96N; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FyNFg96N"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CFC4930979;
	Tue,  6 Aug 2024 16:21:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4YppW2muRsqZiCCmFxzy1WsuptDGVi0ZZ4u1Si
	fYS3E=; b=FyNFg96NU5gvJvm2u9UjunNc//NnTSfBHLCeR+Q+Xph41kiVP7rzwC
	NNzK6k8PGWpdpmh/hZ70s1S1e2a+xNg47pLnKiPHZTQHo7r9pnjskxcu6V2HrYOx
	OznpybKRvxD1ju/Xb6WMTJzqvE8gmZbo7FQPOQcHWFAGZ/rZnZwek=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C803E30978;
	Tue,  6 Aug 2024 16:21:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 371A830977;
	Tue,  6 Aug 2024 16:21:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [RFC] usage_msg_opt() and _optf() must die
In-Reply-To: <CAPig+cSobEaKf3G4OQ7wHYMXTB23mHdwk2sJi5t9+X3ZX_xcLA@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 6 Aug 2024 13:38:06 -0400")
References: <20240806003539.3292562-1-gitster@pobox.com>
	<20240806003539.3292562-2-gitster@pobox.com> <ZrG_A3UQk56aYJ_m@tanuki>
	<xmqqed71vbps.fsf@gitster.g> <xmqqmslptw3u.fsf_-_@gitster.g>
	<CAPig+cSobEaKf3G4OQ7wHYMXTB23mHdwk2sJi5t9+X3ZX_xcLA@mail.gmail.com>
Date: Tue, 06 Aug 2024 13:21:44 -0700
Message-ID: <xmqqikwds8pz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 802E3898-5431-11EF-A8AD-9B0F950A682E-77302942!pb-smtp2.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>> I am very much tempted to suggest us do this.
>>
>>  void NORETURN usage_msg_opt(const char *msg,
>> -                  const char * const *usagestr,
>> -                  const struct option *options)
>> +                  const char * const *usagestr UNUSED,
>> +                  const struct option *options UNUSED)
>>  {
>> -       die_message("%s\n", msg); /* The extra \n is intentional */
>> -       usage_with_options(usagestr, options);
>> +       die("%s", msg);
>>  }
>
> As a minimal "fix" to eliminate the user-hostile behavior, I would be
> very much in favor of this change.
>
> (Retiring `usage_msg_opt` altogether would be even better, but is much
> more invasive.)

The above is following the usual "we make changes but be nice to in
flight topics by keeping the API function still available, but the
function now behaves better" pattern.  In other words, elimination
of the API function is a breaking change and can go slower.  What
needs more urgent to get to that goal would be to adjust the tests
and documentation pages to the fallout from the above single liner.

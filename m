Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C891E49F
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405419; cv=none; b=SkG41ntEtMDGPD14gv+rkEcmyu4/OuQSy7B2ruq4g/bSayprV3FsyceIEySYWpMAPnSnhMjP+dlC7SS8KbKOJmBZ+LsWBxf3K7RMS97MsWXSMVd4wxPJP60Mxvm0DCmo91EQaeFC/Sfce8gdVaDVSCgrWHlSFxdGdXSLcUrf7+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405419; c=relaxed/simple;
	bh=aW+d6I4LhyjJG7/h2tEvNYp/rxbB9veq4TPNOng+nHc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aCp4Fp+QChrDV9hPfvhWsncM9790pQapfpj3XCRy76GTGZZxO1/GZvAIbDZV1OSE17Af7fX9RUwKn5umKIz4ZMza8gN+oWhPvDVTJD+7t5rhypvECGk4bK+0iwSg4NlIzazCN1jVID/grhf3Z6Bx7oPv3AwLZ7FNPU6Pys0/W6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xMKKqL25; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xMKKqL25"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EDBF226809;
	Mon,  3 Jun 2024 05:03:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=aW+d6I4LhyjJG7/h2tEvNYp/rxbB9veq4TPNOn
	g+nHc=; b=xMKKqL25PzZF/Msi+BhbSyHh9HIUHV0xacmWQhKcayJ06KcArjhAUM
	+qtdaDJRNoO4x7TQT0F653w7qgk6TefM8oLUUyaTwLHF0OgsWRCQbrAvWlDIhFTX
	d229An+Dzo/vmRFjEDHCcygKegQd99OSj6esR08d32RG6ApAGeQCI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E575E26808;
	Mon,  3 Jun 2024 05:03:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0787E26805;
	Mon,  3 Jun 2024 05:03:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,  Jeff
 King <peff@peff.net>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <ec2ca25486b84615e30dbeb83ec47310@manjaro.org> (Dragan Simic's
	message of "Sun, 02 Jun 2024 19:46:53 +0200")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
	<b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
	<xmqqwmn79u98.fsf@gitster.g>
	<ec2ca25486b84615e30dbeb83ec47310@manjaro.org>
Date: Mon, 03 Jun 2024 02:03:27 -0700
Message-ID: <xmqq34pu8kkg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 24EBE7C2-2188-11EF-AE7A-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Hello Junio,
>
> On 2024-06-02 18:36, Junio C Hamano wrote:
>> A possibility is to phrase it like so:
>>     | - pipe the current hunk to the program (or "%s" by default)
>> and fill %s with the program you'd use if not given, i.e. initially
>> the value of the GIT_PAGER but updated to the last used program
>> after the user uses "|<program>" form to specify one.
>
> The value of GIT_PAGER (or the <program>) can be a rather long string,
> so it would have to be stripped down to the base command, but it would
> be rather error-prone and the printed information would become much less
> informative that way.

I'd probably just say $GIT_PAGER instead of its expansion if we were
go that route.

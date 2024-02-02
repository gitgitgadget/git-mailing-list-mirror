Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C215182CC
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862973; cv=none; b=Pl18zWbkWaz4KaszsLkGZ0aRdF+tNUqm0ighRGduH1beC88v8t7rOn5XSfZs9gYG/hRfCcqHWeSP12ucCUJ31zTnGpsPRRqO/LeP/lOk19yvtwXr4OEshBLhs3HbersHTTXVPuuMfWTvn+I4/kSR15pqTlTpzbwje2opO/maCUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862973; c=relaxed/simple;
	bh=4BdX5DWY9SQeEViIMQpk/HMrO5fKmSDZUDUvgKNTdLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HvC1stxf7xc93Mcone+IyA3yGu0GnNn+GoqOjakqAQBuR47dnZKIhlG/vHQwntwFZPvnPeWknbY0aUYM7XvtVN/zMDxQTRz31bFSG8bceYIgFz/TnbANBnjYBge9cbTrjrYdMlHso2OIN1RvXdswVY9bbb8r2j3GoqGwJGS13Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MwOFhkbd; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MwOFhkbd"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EBE8018BEC;
	Fri,  2 Feb 2024 03:36:04 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4BdX5DWY9SQeEViIMQpk/HMrO5fKmSDZUDUvgK
	NTdLA=; b=MwOFhkbdEyFMwo+xnh/wUo6KJ5ElmAX83w0pHPa9iWnSFswMFA70i1
	Qmcmg1qSUiI3QvICdceGx72etVFCPqUAH/wbg4ChTLU0uSAUZ27Z4ve4YLFNvej+
	TKzKJ0qsfIX5cEifLyWG/lqwAbuNVvdMWVYzdznR+D6LTdMoK0VwM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E3F5818BEB;
	Fri,  2 Feb 2024 03:36:04 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2213418BE9;
	Fri,  2 Feb 2024 03:36:01 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacek Lipiec <jacek.lipiec.bc@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Multiple indices / staging areas
In-Reply-To: <CAPGWkwcqbkanFP4h1P0umJAFzmiQYTvSm1KeD0=yY0n2K=KS7g@mail.gmail.com>
	(Jacek Lipiec's message of "Tue, 30 Jan 2024 04:47:27 +0100")
References: <CAPGWkwcqbkanFP4h1P0umJAFzmiQYTvSm1KeD0=yY0n2K=KS7g@mail.gmail.com>
Date: Fri, 02 Feb 2024 00:35:59 -0800
Message-ID: <xmqqr0hvuuts.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 184DE430-C1A6-11EE-B69E-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jacek Lipiec <jacek.lipiec.bc@gmail.com> writes:

> I am open for the feedback/questions, or early go/nogo.

Given that even having one index between the committed history and
the working tree files seems to add cognitive load to new users, I
am not very enthused to hear that we may be able to add an arbitrary
number of them, and more importantly, I don't quite see what real
world problems the additional complexities (most of them are probably
not accounted for in the sketch we saw and yet to be discovered) are
solving.

But I'll wait before sending this response for a few days and keep
it in my outbox.

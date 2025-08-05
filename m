Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CF027707
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 18:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419640; cv=none; b=lD39fMSvMPQRtxKQSxpBFy72RKnOsLRJwoxawp34CKBaiUSb4MWh2l0X91bS7/lpOIxSIMxK7RqJb6nlZGzYNqQXVsGveQuxZaJ1LbKKAfeOwUbu6sedqR5O0koR+68DJ4x1zmyN46omMYIu1CsXIE66lsEvjlV/1BlNmAjjzcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419640; c=relaxed/simple;
	bh=Lz7/Pj12w3xjUS3RldRiDm7liBUQHqpkGNIoI+nr74o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfuyfG59Mgao3dqDlr1HoUnUnIi7shJZo1uCrFP/GK3akweVeMbvO1vKD/u6VYVeIGDBMstRw879o9rpszFR3eM6XWqKPeqe06B1xwxIhBQatLo6GGRFfDZlzMAXTrY5sMhowHWu5uhiaJo3ZmtVuqpc+DKJHNTYQ4vS/TvtEsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aTOChEug; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aTOChEug"
Received: (qmail 15979 invoked by uid 109); 5 Aug 2025 18:47:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Lz7/Pj12w3xjUS3RldRiDm7liBUQHqpkGNIoI+nr74o=; b=aTOChEuga1pJs8aAMcjagOQfFyjeElvxVqesTpVhtxwPC6IhvbdOCYzAIDXN8oOcd6zy0W0Vk4Gb93cBD6v4GAx6mqNq4XbbOyQemnnVHo5kyIuXboVVCU0VFb6lu7AREXHpjCmO/5/EaGC3WMPaDkSeCcIekOW049pai7VlVkelZFHIAOOd9j5WcmxhhX9MiusOAO1896ZCCYi8gQBmeeLJAYp4JxsQdsU3vuxDNsD36XnRvehmLX2fDJ27E0FZn850gFwsG1Lf0JJX0N5qKgxLQ5fI+g6uSnfhYKGH+uL4hQLksyEewHWJHhpRbx6DtMUaAsW83xyGl+XQ/RrY0g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Aug 2025 18:47:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10986 invoked by uid 111); 5 Aug 2025 18:47:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Aug 2025 14:47:14 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 5 Aug 2025 14:47:12 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v5 0/9] refs: fix migration of reflog entries
Message-ID: <20250805184712.GA1345110@coredump.intra.peff.net>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
 <20250805-pks-reflog-append-v5-0-050997db09d5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250805-pks-reflog-append-v5-0-050997db09d5@pks.im>

On Tue, Aug 05, 2025 at 05:11:30PM +0200, Patrick Steinhardt wrote:

> Changes in v5:
>   - Revert back to the logic that aborts the transaction if we see a
>     racy HEAD update. It's the pragmatic thing to do for an edge case
>     that is very unlikely to ever happen.
>   - Link to v4: https://lore.kernel.org/r/20250804-pks-reflog-append-v4-0-13213fef7200@pks.im

Thanks, this makes sense to me. I hadn't reviewed the whole series very
thoroughly, but I think others did. And certainly this version addresses
all of the discussion I did participate in.

-Peff

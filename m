Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151C018B489
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132466; cv=none; b=YmmqPV6PdxDfEcAIuKYcXCeI6kK/4MbuyrGn6hzOngMELQv4SeRBVhJCUPgldwT4W9CJmkDID+cjnjlUmiKXftm8C0p5l6qeHD/kwGJYJkfMT6JrgH/XEbTc+O9V/lGHgerE/wYYViqvgDpJIOSixqloSdTy/XF1Bt18zfU2ZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132466; c=relaxed/simple;
	bh=K+YEGYQzPWU2FGMfbqYhI1gpUR4dt5bv/+CxACxNX5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rr2AnBtn5kN6lWLzOvesElSu1wCWGUR95kI54XDpOCB7IYyMkvyCPcbmLE8Iq+EfeoG6tCV67dCLRGSO75MvJ+00zXU+X9CojliIJ/UXHsNYLd2SXgdcSuIFIfOo+qky2/GZknjVBlq82nOL2ZuEJ+XhvEO9m+3pXiR8HK5WWDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bJ+m7kix; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bJ+m7kix"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 01DA12261D;
	Thu,  8 Aug 2024 11:54:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=K+YEGYQzPWU2FGMfbqYhI1gpUR4dt5bv/+CxAC
	xNX5w=; b=bJ+m7kixqMCMe8J7V1GP069/Nbo1MHw4wHrtAGKosZs9SPLsYaqyfi
	5s+ERr6GVMG461FPmyDzpdlqVPwvBlbGAGx00bMco3hJ/HTcLuHVOWi4UEFFYuNi
	Pg/lBXb/3C+iDboDkKadSs4MiEeBAcwSRNpIoiloJ03Pwsy30z4+4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EDC5B2261C;
	Thu,  8 Aug 2024 11:54:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5D3A02261B;
	Thu,  8 Aug 2024 11:54:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: James Liu <james@jamesliu.io>,  git@vger.kernel.org
Subject: Re: [PATCH 08/22] config: fix leaking comment character config
In-Reply-To: <ZrRR9mwyQQrw4Dg5@tanuki> (Patrick Steinhardt's message of "Thu,
	8 Aug 2024 07:04:54 +0200")
References: <cover.1722933642.git.ps@pks.im>
	<a34c90a5527cb45ec89a0ad44dbca1d61705a0ea.1722933642.git.ps@pks.im>
	<D39HQCFQ2DCW.1KFGPLVU1EVQD@jamesliu.io> <ZrRR9mwyQQrw4Dg5@tanuki>
Date: Thu, 08 Aug 2024 08:54:21 -0700
Message-ID: <xmqq1q2zko2a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7ABA9514-559E-11EF-8849-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Now that I revisit this commit I'm not quite happy with it anymore. We
> still need to have the cast, which is somewhat awkward. I think the
> better solution is to instead have a `comment_line_str_allocated`
> variable that is non-constant. I'll adapt the code accordingly.
>
> An even better solution would be to have `struct strbuf` provide an
> initializer that populates it with a string constant. But that feels
> like a larger undertaking, so I'll leave that for the future.

FWIW, I found the "now we have a variable to refer to the address of
the string constant, we can compare to detect if we allocated and
need to free" in this round is a good place to stop.

I view the approach to use an auxiliary variable *_allocated is a
regression compared to what we see here.  The approach makes it easy
to forget to futz it when an allocated piece of memory is assigned
to the main variable.

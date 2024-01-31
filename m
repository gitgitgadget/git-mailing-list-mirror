Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA4E3A1AA
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741930; cv=none; b=YxCFkLO+04g0jYLF6iFgvcSVvrsStqXjEpV+7BQLlT0/f9vAEaYsFlC1fFtY5Gtom2KFlWKMuI5cc0k0c1AJEHr1ylfbdgeADn9OJIT3Scxi/p46wxEXewOkbfbYdBqcdOy1EmyvJRi8LtoKnWKBo2wh5gS4R44a7qlkZVPrf+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741930; c=relaxed/simple;
	bh=etxaC5Dmg6iQDSAVmfViMTtlWmAupBZZ8XWo96Gq9KE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WiF632uuE+0tnH67PeijN8RWufx1Rq6rrMDRz+d49NZZ92n7BhRmOc6Dr6BVCDyvYgaq9vDDLL4Vvg/X1472isJZpvP53cXJ/Q6Xff156fuZAA1pmaIkxjzk6Qc8qMWhTqcAMf4iv8EnHs9EaJAk4GF4JQPquBRcYVPKYK8mRBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sKlv6Yw2; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sKlv6Yw2"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 123701D9542;
	Wed, 31 Jan 2024 17:58:47 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=etxaC5Dmg6iQDSAVmfViMTtlWmAupBZZ8XWo96
	Gq9KE=; b=sKlv6Yw2BxXxXtMGg7vLYtqqH8wiwLq2d1fpN6kjp6knzv+Z0ROyrh
	Rh7tFeB8geYdOXCBVHefr5YOSJVPv/0y+357peubXfbeECjxKDo/LhQj4hCT4dEa
	VoyGSjfPpUCw0PkFa31u6U6p2tnC/aTFVTP+Ibo9iB+PG2VONM/2k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 08CBC1D9540;
	Wed, 31 Jan 2024 17:58:47 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 692EF1D953C;
	Wed, 31 Jan 2024 17:58:46 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,  SZEDER
 =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  Adam Dinwoodie
 <adam@dinwoodie.org>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 3/3] t/Makefile: get UNIT_TESTS list from C sources
In-Reply-To: <20240130054037.GC166699@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 30 Jan 2024 00:40:37 -0500")
References: <20240130053714.GA165967@coredump.intra.peff.net>
	<20240130054037.GC166699@coredump.intra.peff.net>
Date: Wed, 31 Jan 2024 14:58:45 -0800
Message-ID: <xmqqv8792jq2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 49FF64A6-C08C-11EE-BE3A-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

>   1. It will notice if we failed to build one or more unit-tests for
>      some reason (wheras the current code just runs whatever made it to
>      the bin/ directory).

"whereas"

> would be true even if we had acess to the top-level's UNIT_TEST_PROGRAMS

"access"

I've typofixed them while queuing; no need to resend the patch only
to fix it.

Thanks.

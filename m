Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2885BAD7
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095865; cv=none; b=o9nuku8NJHcw7ygbyuyvPsxZGApLH57TpCAVVGtEb44QmDiiSWDDCk3wkbM2DBdmOXKtcWdrW0w/qEADVt8oGim+5YFh+Y6MStFHFnAnZhszwVYiWnzXTBShfAwenbohG7z3/HnoAcZJ6frS2TInUi4X1cQLA7n5JVpaQdWzna0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095865; c=relaxed/simple;
	bh=ogbNrQbk+QZts3RRtcFWLK7PcFTlRMiSKj27GBTeKWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Un6mHi1cIu4Ww/MfCDuuSLGe8rXQp8x9RlPYGEYDcF5z10xtm+MrzMjWNYKRZOkcbL//8UchKc3spXZNMsTWFvcZSDhtG9QGW4NsgKFvhe7cFM2j94GWPUykkng452CaHLDvvYMiL0s/W75HoHduGgTfQpAPhRP+5kLxbiDfmW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GblsSZc9; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GblsSZc9"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 396782C13B;
	Tue,  2 Apr 2024 18:11:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ogbNrQbk+QZts3RRtcFWLK7PcFTlRMiSKj27GB
	TeKWY=; b=GblsSZc9mV1UG9yFXfsd3kWUYurWIu2dEgJy8G//BfbCygljYLYs5G
	n7iOu6rMkmC49jbGj7zOA929jMHvQ062bz+iRvLq3V+lqjImscpE8Jd/aT9JuJAP
	GRIuHSFR3UaGcUjnp7/MZAApudQMSeWkO2F1yhXPGwQrhcfCAOiCg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 30D2E2C13A;
	Tue,  2 Apr 2024 18:11:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 817F62C138;
	Tue,  2 Apr 2024 18:10:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: [PATCH] t/t7700-repack.sh: fix test breakages with
 `GIT_TEST_MULTI_PACK_INDEX=1`
In-Reply-To: <20240402202405.GC875182@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 2 Apr 2024 16:24:05 -0400")
References: <7e8d435d58eea19d2aae0be366720f5956d29a5d.1712075189.git.me@ttaylorr.com>
	<xmqqr0fn4nmx.fsf@gitster.g> <ZgxSSKGdAicfVhGA@nand.local>
	<20240402202405.GC875182@coredump.intra.peff.net>
Date: Tue, 02 Apr 2024 15:10:57 -0700
Message-ID: <xmqqcyr72z66.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E234A98E-F13D-11EE-BFA6-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> So I dunno. Maybe this is a can of worms that is not worth falling into.
> After all, these are not "real" environment variables that we expect
> users to use. I just wonder if the ci runs with them are buying us
> anything for all of the tests outside of t7700.

Yeah, I agree with the general direction of reducing the role
GIT_TEST_* environment variables take.

Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B66415D5A4
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 19:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087747; cv=none; b=BjOyAfLdqoLSHSo6ZzzKwQKjPRYIyiBnHHXO+fT/PKQC92NzET/s13KOVwWSuG2hln1owCmf0QRsY4R7kPY6Y6JlyFYcwIYuir1jjPRTo46b/arGzISr0MiEucBuKlSMxgAdxsp669HZ48C0Jt8wgnsmjxQy6R3yvr7LDcxB288=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087747; c=relaxed/simple;
	bh=klsMKkiyuEVxKR0j4s2GG14niNPbTKks1Zl5dSPlo3w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ctLCNuNzMJ4ZmHdch2oXFP0D+fWj/7GA3StbIuiT1SpOo5cAAY1In7r9mv0g7Q14eqXCt+/MIvSzfMWc9w6W0Mj6bSBbcVatImDSXbdOKLN+bIkITXlZubIighCCLPi7PVwRkQa5+WOkyAfaIxiHCRwXzpSMOX0ml4nnZN594cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ehz4k4G9; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ehz4k4G9"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 18E492B317;
	Tue,  2 Apr 2024 15:55:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=klsMKkiyuEVxKR0j4s2GG14niNPbTKks1Zl5dS
	Plo3w=; b=ehz4k4G9R6OiQsU+JaWkhF4Hgr/3LzgLKFlaciTaqWwSz4cQDlTWy+
	Z77FwIjKu5n1yTy4lVrP0V9l12/Rspv9aS7pPcTaRUSapJQhM26YkbqMQZtrbpV+
	WcaXcHwzAGWycUQve2nk8BlE0dsEQfcoHKYrMkVVEsRro8C7rja+4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1153E2B316;
	Tue,  2 Apr 2024 15:55:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 900082B315;
	Tue,  2 Apr 2024 15:55:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/t7700-repack.sh: fix test breakages with
 `GIT_TEST_MULTI_PACK_INDEX=1`
In-Reply-To: <ZgxSSKGdAicfVhGA@nand.local> (Taylor Blau's message of "Tue, 2
	Apr 2024 14:45:28 -0400")
References: <7e8d435d58eea19d2aae0be366720f5956d29a5d.1712075189.git.me@ttaylorr.com>
	<xmqqr0fn4nmx.fsf@gitster.g> <ZgxSSKGdAicfVhGA@nand.local>
Date: Tue, 02 Apr 2024 12:55:39 -0700
Message-ID: <xmqqh6gj4k04.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FB88CA5E-F12A-11EE-B7C4-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> I would argue that GIT_TEST_MULTI_PACK_INDEX should be on the list of
> GIT_TEST_-variables to get rid of as it has served its purpose.
>
> Like I said, I'd like to get rid of this (and many other)
> GIT_TEST-related variables, but that is a larger effort than this single
> patch.
Yup, that sounds like a good longer-term goals.  While it does not
smell like it is consistent with that goal to add more instances of
use of it to the test, it may inevitably be a "few steps backward in
preparation to jump big forward", perhaps.

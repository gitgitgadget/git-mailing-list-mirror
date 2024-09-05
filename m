Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27541AD5D7
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571672; cv=none; b=BQBNQ1LSRh6z9iq7neEAMkcsrszm3+mBqIhABaxCgAKKu5Akae4kAwY3Y0xu8jK8CicI7BVM/cgU3AI/an07M3/T+Ox3wIv1nEbv5DRLrBrX4G2rL4vfc9KYLgwOdCZZs27y1NH23o5fdLtX2ye4e2lJCFbgcgHBRXC+TNgHzAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571672; c=relaxed/simple;
	bh=1mu4OuivHcNlqtwu3XkdgYVCh3XBBUsAw//cdlparqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sTtSrb7Vw2+QBWDur8jADO0vl2/sg+74GTbuEeLTJXWaa5N5l0h7cnPXfpVce5KH83RTPxjWCvOCVWJMraxghUoWgowdhIXFGZapCxVJC5a8yv8qBDKHLel1ZcFpmi0vSKp/i8SKeUxUPG96ApqFhIRlHNVIa75wmw8mdE1D7jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pSQYrJAr; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pSQYrJAr"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B12942FD8E;
	Thu,  5 Sep 2024 17:27:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1mu4OuivHcNlqtwu3XkdgYVCh3XBBUsAw//cdl
	parqk=; b=pSQYrJArJncx5x+VCs/wAQeFDFHS4LlJIIf4XymFqZ9RN7tw1p7YdG
	SjqSBx/1iYo2/KwQHzpC8+sAHlwW3mDYOO7TeoXQqTKnuQuIfPojhZrga5ilVo32
	w9L9bo29hKdTLbOpxSxqoFSwPDJadWufVgR5ZtDt3H+VYKce/5O+M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A7E882FD8D;
	Thu,  5 Sep 2024 17:27:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 12F4E2FD8C;
	Thu,  5 Sep 2024 17:27:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/4] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
In-Reply-To: <20240905202707.GA2602440@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 5 Sep 2024 16:27:07 -0400")
References: <cover.1725206584.git.me@ttaylorr.com>
	<ZtXG2cEbxr8pNg7j@tapette.crustytoothpaste.net>
	<Ztdn25zfi8WHO+GS@nand.local>
	<20240905103736.GC2556395@coredump.intra.peff.net>
	<xmqq34me5crn.fsf@gitster.g> <ZtnbFXL7W5DvW8UN@nand.local>
	<xmqq34me3uyz.fsf@gitster.g> <ZtnkovOqrJNxUtez@nand.local>
	<20240905202707.GA2602440@coredump.intra.peff.net>
Date: Thu, 05 Sep 2024 14:27:47 -0700
Message-ID: <xmqqbk11zt7w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B3369DA8-6BCD-11EF-A691-9B0F950A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> But I'm not sure how comfortable I am leaving us in that state, even if
> it is by itself OK. It feels fragile, and we're a small step away from
> somebody accidentally using the "fast" variant to do reading.

Yup, avoiding to rename over an existing files makes the gives us a
lot more defensive posture.

>   Side note: I do really like the xxHash direction in general, but I
>   think we may be underestimating the difficulty. Obviously it needs a
>   protocol extension for sending packfiles, but what about other
>   cross-repo access? E.g., dumb http blindly downloads the packfiles.
>   How does it learn which hash is in use?

We need to make the file contents a bit more self describing
regardless.  A dumb http clone should look more or less like

 - download "packfiles"
 - download "info/refs"

 - run verify-pack on the packfiles
 - create an empty repository
 - move the pack we downloaded to .git/objects/pack/
 - populate refs from downloaded info/refs

 - make sure the tips of refs are all connected.

but as we recently discussed how verify-pack and index-pack assumes
the hash algorithm in the receiving repository, we need to give a
bit more clue in packfiles themselves what hash algorithms they use,
etc.


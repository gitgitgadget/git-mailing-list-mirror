Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C397A1B47B0
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906810; cv=none; b=SbXe7mM85eQMPDbwMMSz7coB2n4NmBNqNT2rGR9rQW0ko6iz8j7lRJKtmMvsMvVhoh0QymLs5+2pxfYEy43duocMnb/OQQJt9D7s75tEXaegJhc7kJajPdHnMx0ViBp5eYi3HIUMRIp2f3HL9PIqMmInG+7xWhx+bGCNQnnmBFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906810; c=relaxed/simple;
	bh=VyOfoJ54F6r7unGMDlKIGpzKuDJ7DYWxc2v4P3xk0FI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KGxQeXFxUCxcwRE31DHOb9eCFP+mC0WQto76QlT8M3v85yt+Uz7tEIj4UTIav+6diXweIwmnw5Wb/OuOAL+SfEjR1BiACv/GQzMRDfMkglHDU0lmrgLmQenQnO+zAKHubYC7cB5BSyDa19xch3L76XakSeOgkhZDb49qFFai5w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vHJUNNYi; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vHJUNNYi"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 741832EE16;
	Thu, 20 Jun 2024 14:06:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VyOfoJ54F6r7unGMDlKIGpzKuDJ7DYWxc2v4P3
	xk0FI=; b=vHJUNNYiUcWuRzaoolT8O24N6FU7f7+pnPOw7/sLdQ53iXt9RN6HOL
	BAkskYf1RTD7LXgidG5EBgr5gg+2DuN76qB51f+wE1Gt9WddmnORAcubyvppPadW
	QjmjxbtxR8qI4Zr/9HhKtIRBB1A3G0MZC0B0eKdXxOg9zMieR6jeY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D5032EE15;
	Thu, 20 Jun 2024 14:06:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0E5072EE14;
	Thu, 20 Jun 2024 14:06:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH] t5500: fix mistaken $SERVER reference in helper function
In-Reply-To: <ZnM3I11IRporu4sj@google.com> (Jonathan Nieder's message of "Thu,
	20 Jun 2024 11:27:58 +0200")
References: <20240619125255.GA346466@coredump.intra.peff.net>
	<ZnM3I11IRporu4sj@google.com>
Date: Thu, 20 Jun 2024 11:06:43 -0700
Message-ID: <xmqqv823v68c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DAB07744-2F2F-11EF-9361-C38742FD603B-77302942!pb-smtp20.pobox.com

Jonathan Nieder <jrnieder@gmail.com> writes:

> Alas, in a copy-and-paste gone wrong, 07ef3c6604 gets the name of the
> blob (but not the commit) from "server" instead of $SERVER.  And this
> happens to work because the first time we call this helper, $SERVER is
> "server".  The only reason this happens to work at all is that we're
> looking at a blob id; if we looked at the commit id, then the
> timestamps wouldn't have matched.
>
> Thanks, the fix is obviously correct.
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Particularly telling that the author of 07ef3c6604 introduced this
> typo while trying to make the tests _more_ robust.

;-)

Thanks both.

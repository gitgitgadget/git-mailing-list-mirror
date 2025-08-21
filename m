Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2372E8B8E
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761230; cv=none; b=eF3fHcVVU5UMc4ocBvvcIurTbQa8+4QCk2V8mEKwb7YJhkKcZBPsZ8IxeaAe7X+5mB4lSDDB88KhBTE7ahFLXVFAws3TXZwZADUtB6VtiM/kG+ijo0yeJ3E4A78k1nPctnb1wvuAfcSJcjA0/Kv3E2L3hWY1+VbTSsgMUyuLUSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761230; c=relaxed/simple;
	bh=Y/1vM18qt38mr01aulZiaX0ORd9xsF2R+2kBIqkViIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEV2cH/bHXQKX+njvcZkIAZ0gFQAzvjvtBdV7UagYRenCo8COAvntokxZRsbTh4bILNYULr6z+swi7OuyYnvwr7qmTynnfNCHVD5dTTFnsBVxTaoKSp599FKbk7Uc1YYdrug/+bhLIVqodHa8UkUUj7kb8pI397hAoPw6/INEbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FppuItcW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FppuItcW"
Received: (qmail 42150 invoked by uid 109); 21 Aug 2025 07:27:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Y/1vM18qt38mr01aulZiaX0ORd9xsF2R+2kBIqkViIk=; b=FppuItcWwsPtr9DktWZiVyXQKhfDjnk9ZUBbkAAu4GgbjBkxTx3+rDyR9uzul/IgcCTuYPunJHDJAUn/ym6knq5msFNzx8p16Q9o/bTNFxvydiKUCa1i+vfY4FUlBjWI5iM5g2IIdCKyMddRGdxAzqJzaubvJBvPY4elluPTG2/3+HbcALYCuhTggQUAh4YUJfWdl5BKG5fPlmjgrrK8Uz5yC4MCzE7i8niFg0D6iieKhswRKiPADrTEK1dgFT+0ri5khkNMEx/mAJapptVcTcrzdq12Qvy06BWM+CXnIZ8tvAjZPCx5BwqaGgu+LkuA4LCWnXIQtgBG8AMmdDEMEQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Aug 2025 07:27:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 72462 invoked by uid 111); 21 Aug 2025 07:27:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Aug 2025 03:27:07 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Aug 2025 03:27:06 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Joe Drew <joe.drew@indexexchange.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: "lock file exists" when fetching in bare clone of repository
Message-ID: <20250821072706.GA2390046@coredump.intra.peff.net>
References: <YQXPR01MB3046197EF39296549EE6DD669A33A@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM>
 <20250820213323.GA1667633@coredump.intra.peff.net>
 <aKbHozlmDIqfgkg4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aKbHozlmDIqfgkg4@pks.im>

On Thu, Aug 21, 2025 at 09:15:47AM +0200, Patrick Steinhardt wrote:

> > > This error _does not_ happen in the Apple-supplied version of git:
> > > `git version 2.39.5 (Apple Git-154)`, but does in 2.51.0, which I
> > > installed with homebrew. (If this is a packaging error, I'll happily
> > > report to homebrew.)
> > 
> > That is definitely weird, and not something I'd expect if it's just a
> > case collision. Is it possible for you to build Git from source? If so,
> > and the problem happens with your build of 2.51.0 but not v2.39.5, it
> > would be very enlightening to see the results of "git bisect". We can
> > provide more guidance if you need with that process.
> 
> Curious indeed. Another relevant part could be the new batched mode that
> we have recently introduced in git-fetch(1). Previously we would've
> updated refs one by one, and potentially that led to us writing the same
> ref multiple times due to case-insensitivity? The result would be quite
> broken in that case, but at least the fetch would've finished. Does make
> me wonder though what subsequent fetches did, and whether we always tend
> to flip-flop the value of such a ref.

Ah, good catch. That would explain the behavior change perfectly. My money is
on a case collision, then. :)

> But with batched transactions that's not possible anymore, as we would
> indeed try to lock the same ref twice. Assuming that this really is the
> case, I wonder whether we should detect this case, tell the user that
> it's impossible to store all refs on their system, and then continue
> regardless while ejecting that specific ref from the transaction.

Maybe it is too optimistic to think that they will just start using
reftable in Git 3.0, and we can avoid extra code to detect this?

-Peff

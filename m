Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142D922A4DA
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752015018; cv=none; b=ZvAlH55aZlfv4LQyiP7WpioDvf+DKRRHzVqclMksJLFOAogC5oZT0k9FZ+0kcfSrBT67GNyqo2rQzEAbhr5okPGAltoxgg7ZBaYwZKRvO4c3/6Mcts3FFJS8UV322X1Sv2kmzvovAj976e2ylM6jjwIoyzsdrRfK34jY8qhZvH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752015018; c=relaxed/simple;
	bh=SfU98DpzF8ByaVNY4DGREpsb5QGXuuE3/syLGgj+3NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0U7i9/NI5ypTQZH4LBEj9ns/VxCZwy8bsDnf4m16t+zSNov2cclQk3mTM3rZRdjobHJq2KnYxGK4tN/P9ptnuNlKw8X1Q55KrpP7idjKmFQTipmLzosJsHPG6LLlak2ioFwlMscw1C/pRtz837My0txiihKNqd1OFnfPSbbpmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=I1PlRu1j; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="I1PlRu1j"
Received: (qmail 17151 invoked by uid 109); 8 Jul 2025 22:50:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=SfU98DpzF8ByaVNY4DGREpsb5QGXuuE3/syLGgj+3NQ=; b=I1PlRu1jXhCJeKBFSP9r5uC0HkTPJuLWD9M7Jb7I+yXshzW/AHSn+0uIAiYmoP0OqahW+ekJ1Rp4HpfiCrzKF1jvng3fZvS4DhH+KqJtuQKPBSTeyGeOa+yPZrUVWVsH8DFV26L+6vGFomfv6aCQzMig2FeyVZEm/LXBLFv0rq2KiffzfRCsmbDaWii14oLolmSk1toU/7lkPjHUoyX6rukBEqwp7Zv6jpV7hb35J0ehwl2yj6ScfOz47cV0165Xu8Oouj7w/BysXd7K1F9kGL5zIUWg9v4CbVQYNr6+JAvCxWhFPP3L4srCQUmGQ+mQOgyToLWEmCRHUfpZ1NsuHw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Jul 2025 22:50:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30485 invoked by uid 111); 8 Jul 2025 22:50:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Jul 2025 18:50:10 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 8 Jul 2025 18:50:07 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?Sm9zw6k=?= Miguel Armijo Fidalgo <jm.armijo.f@gmail.com>,
	git@vger.kernel.org
Subject: Re: Bug: "git stash create" ignores "message" argument
Message-ID: <20250708225007.GA1180568@coredump.intra.peff.net>
References: <CAKMuBmSeFh63212_GhBHfOTbW5VaqvQjo7jz4aowm8bntCXkVw@mail.gmail.com>
 <20250706032512.GB3041790@coredump.intra.peff.net>
 <xmqqv7o2vc64.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqv7o2vc64.fsf@gitster.g>

On Tue, Jul 08, 2025 at 10:13:07AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   2. Possibly "stash store" could pull the default message from the
> >      commit, rather than using the generic one.
> 
> This might be a good compromise.  Even we discourage the use of
> "store" and "create" combo to interactive users, we do care about
> ergonomics for script writers.
> 
> Those who use "create" to write a detailed log message (which may
> later be reused for a real commit that is created out of the stashed
> changes) would end up with a huge and unpleasant stash entries if
> they use "store" without any message, which may be a negative
> experinece for them, though.

I'd feel a bit better about tweaking the ergonomics of "stash store" if
I thought it was generally useful to script writers. But it appears to
have been created solely as an implementation detail of
rebase.autostash, and I do not recall ever hearing of anybody using it
in the 12 years since.

I.e., without understanding why somebody would want to use it in the
first place, I don't know what potential we have to disrupt them by
switching the behavior (and nor am I all that excited to spend time
working on it. ;) ).

Maybe José can tell us a bit more about his use case.

-Peff

Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3891A3D5239
	for <git@vger.kernel.org>; Fri, 15 May 2026 04:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778819770; cv=none; b=RXS7Fxz8Lj/YYPfJc964F3PpIAFDwgWUT/D6Yo6KzqjuY2P6jwDEDawcEAzhuxL7vQ6JK2l2tFHU2s4VFR4BKPklYyJS96rh+zlmBQGeP54c61t5H6ZIN1+1CQ3e4Z7aAmuUjhYtPQOd1jl6jLvqmmiBBG0EkqmaRUyQSUzlDpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778819770; c=relaxed/simple;
	bh=lVjke/ejnZFe3s+Ryye3sLe+0/6xbd2TnRGHjhEHDBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIvjWbOBXCcmtvP5JjdVYGOHhs4/rY+wBRK8iWoLbXm6VzPgi+bEeAmqix+TrZox8I2cUKQXlS+mtzUxh0Ka4DgfnXUepfV3oLyFa9uvUPVU2m8CqMf54Zye6hobG6fsKityB8QZlysZp84sjn08kFVp43aCu3m2RzADSsnY1Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aDEF+bIT; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aDEF+bIT"
Received: (qmail 52815 invoked by uid 106); 15 May 2026 04:36:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=lVjke/ejnZFe3s+Ryye3sLe+0/6xbd2TnRGHjhEHDBo=; b=aDEF+bITE6LW0BLatlIjHNHp5WQUE3ZlLEpdfCtR6fnHFFZvQHxOLa7R+O4YY/Bh071Vp+IOzOwdg3Mku54RUX4tTWxwcsvfPRqYvWUTtxatOdVdHhvLA9cCYXWA5Jg3hv1iArKy+GS36wpY9oJWFIoEG9V4spsFQPoBaQ82IXaPLN5m2ycM/LULmtvaila/TN1NfNw44p4rCjfM6teau61NaLji9w/L/ZvIRzxUe7ktBMkhCdnsZo/hYrvBeOs1/lXmiAHUAvdiHI9l85OPP+hPHuY6280xe244yQnLgah4vbteByrGuVzXg3BFFZziQTHeww/BRQHvbriaFP7UuQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 May 2026 04:36:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 96769 invoked by uid 111); 15 May 2026 04:36:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2026 00:36:06 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 15 May 2026 00:36:06 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] strbuf: use st_add3() in strbuf_grow()
Message-ID: <20260515043606.GA83595@coredump.intra.peff.net>
References: <c6e9b337-c4fc-4cbd-ac32-e8d3814749b0@web.de>
 <xmqqo6ihg690.fsf@gitster.g>
 <0c3b4e94-b56c-4c92-a4d8-0e4364f1257b@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c3b4e94-b56c-4c92-a4d8-0e4364f1257b@web.de>

On Thu, May 14, 2026 at 10:13:19PM +0200, René Scharfe wrote:

> Hmm, alloc_nr() doesn't do any overflow checking.  It should, though,
> shouldn't it?

Yes, probably. It's a known blind spot in the overflow checking, but
I think is OK in practice because:

  1. We are growing an existing buffer by ~3/2. So even with ordering
     the multiplication first, an overflow implies that you have a
     single buffer consuming ~1/3 of your address space.

     On 64-bit systems that's impractically large, and on 32-bit systems I
     think you generally run into fragmentation and address-space issues
     first.

  2. If alloc_nr(alloc) is less than the desired nr, we just use that nr
     directly. So even if we did overflow, I think the result is
     too-slow allocation, and not a buffer overflow.

But it would be nice to be less hand-wavy. One of the reasons I hadn't
dug into it further is that I wanted to start making use of intrinsics
to avoid slowdowns. But since you're already doing that (and finding
that the compiler was doing the fast thing anyway!) it might be a good
time to make the jump.

That's all assuming that no overflow happens before ALLOC_GROW() gets
the values. We also tend to do unchecked computions for the "nr" field
there, but it's usually just "nr_foo + 1", so the same logic applies:
you'd have to have an existing array consuming the entire address space
minus one byte to trigger an overflow.

-Peff

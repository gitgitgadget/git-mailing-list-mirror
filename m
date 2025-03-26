Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E821F4E49
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012523; cv=none; b=R4jJeUWfixveFn/7IyL6Z3ZFXWgq6APcVvKr67blk1t+i5wzojIlLmTUmMPrG21kcIOc5DAkpeZhs8MV0zaNbbnBaFe7wILHxiWF3NYMwDisWEWXMj8AMeq5XAw6w5DQtOPUyfNQX2fF8DvwBUxhmflj3U8H6t3E2hWJxKUCAu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012523; c=relaxed/simple;
	bh=wzC0OTPUCGl8CxGUyIEASB9NY/NbaTugFagtRSxkjy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9etFhlJ8Bo/Z2TQmYVyfuAzz45eO9DgHqSVy5EG1stgZAL3Mt/E95rzmwF82SCAF3uC8zLKmiyn1cYKRzdNXAJOTpxd9yEa2XNsmJFlQgJJcQbexi6nraI0xX66BDDkWs5TA6SVE/guT223IyQ0nhiRdcFmgPr+c1LJKjviePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ft+ZH6VL; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ft+ZH6VL"
Received: (qmail 13894 invoked by uid 109); 26 Mar 2025 18:08:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=wzC0OTPUCGl8CxGUyIEASB9NY/NbaTugFagtRSxkjy4=; b=Ft+ZH6VLlzUYRA8C97a5/qvS2Q7nalKioTVP1npqIH9mkKm7MIQpR6Hk/Eggq9K+86nnlK3+f13ir2tHyXcmic7oVA6+aXVAgHTl1ExsLOCrF7zZ78/VE7P+JSCpbDtYl1wDwLusCO+cLk4qQ2BLGmxi4mNKDZCDaEtW+HGAYk0TrSWhL3q576XuEh4zfnEKglpTNlyZkDcEJt54sB9ymerAQbSb7FppUBqmPAXGZ9h5kJ5Ev/I2NJYqux7CAkG6wBt0R8BL36fOtJMFQkqKxonmPVcvTwwiyCTP429DpGx9eGPJk+Vs0zS5vrFzvhVHu/S20Javods67bRP4vuovw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Mar 2025 18:08:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18208 invoked by uid 111); 26 Mar 2025 18:08:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Mar 2025 14:08:39 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Mar 2025 14:08:39 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 02/13] pack-revindex: prepare for incremental MIDX
 bitmaps
Message-ID: <20250326180839.GD2508080@coredump.intra.peff.net>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <f2a232e556a066c1a5083f02584ddc3637ecfc48.1741983492.git.me@ttaylorr.com>
 <20250318012726.GB1471939@coredump.intra.peff.net>
 <Z9oJoZdfyA4eAbeD@nand.local>
 <Z9oK2XBF9plTBbnl@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9oK2XBF9plTBbnl@nand.local>

On Tue, Mar 18, 2025 at 08:07:53PM -0400, Taylor Blau wrote:

> > Right; some callers care about the number of objects in *their* layer,
> > like computing the size of some bitmap extensions, bounds-checking
> > pseudo-merge commit lookups, or generating positions for objects in the
> > extended index.
> >
> > I'm happy to include that discussion somewhere in the commit message or
> > as a comment nearby bitmap_non_extended_bits(), but I'm not sure which
> > is better. If you have thoughts, LMK.
> 
> I renamed this function to bitmap_num_objects_total(), which I think
> more clearly distinguishes it from bitmap_num_objects(). If you have
> other thoughts or things you think I should do in addition to that, LMK.

Yeah, that name is much more clear to me.

-Peff

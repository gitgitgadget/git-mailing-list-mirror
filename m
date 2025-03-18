Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B2528EC
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 00:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257581; cv=none; b=eZPzq6R8ypebAJ0xQgcNp1PqAKETs8a1UWkjVpQ/shnCAkeja58P39N3kx5hZJFA/LtXiQZWax+uuhz54MsmSNy5znyStFKF5O0dhgwFDhB3mJEjJMEN5X4Zmna90RddBa91H76qRztfDQnOK5eUBqzI8HsmaFym1bydzoB5PyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257581; c=relaxed/simple;
	bh=mPqUY/HDYsPOtGj/YyXbAyqxP4zPJV2IkcvHqB970Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYRpr+GPwVc9TpcsTZXsapipNR+3IUZKLyyHruTn0uet138qFqRgUmfZ7GksP+oSbIC3c8dqkmYeMWmt5Qu+Iyk0Wq5E5/8ZrpvQ+MnTStCnOmb7pLPLQeQ4bfUXZjsixJoLDCRSpdDyio+V+RYwPBhtI6fhcyDWAeM23kWMpZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FDgn1yd3; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FDgn1yd3"
Received: (qmail 25855 invoked by uid 109); 18 Mar 2025 00:26:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mPqUY/HDYsPOtGj/YyXbAyqxP4zPJV2IkcvHqB970Ck=; b=FDgn1yd3S5Yl6tlHGlu0HvUahSeYVGe3X96Q5lAUlgkrOlIgzPrWkenfGOfRivfAEG+GO2HJwGW+0md4qHREUMEPE0yh/g6+RXX5ADfkyXGExgU2R21XZ8lVoj9YigiDIQg8csk7nvBRzrrrwo+9wDKpjChQg0IHQi3hi6/4GHLYFicu/wsjzEduEYxgH2sbaoihRMbvq93CY+SMaR0EbhAx7bKCbN9C1aZAFMAN23tJE0WiPprKI4HtP0iC+2FQO10L2MPyrZf+b11ehm34Ddj80wa+IB0BEDZikJv0zwmxWtoE7ulqz3/0c3hajz84wSVO8Kja93A/t4r2i/y8fQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Mar 2025 00:26:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2225 invoked by uid 111); 18 Mar 2025 00:26:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Mar 2025 20:26:17 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Mar 2025 20:26:16 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 1/4] refspec: treat 'fetch' as a Boolean value
Message-ID: <20250318002616.GA1470685@coredump.intra.peff.net>
References: <xmqq5xkdrrhs.fsf@gitster.g>
 <cover.1742250259.git.me@ttaylorr.com>
 <7e662acb5ac50b778917cbf2f9f791d35e95e31d.1742250259.git.me@ttaylorr.com>
 <20250318002436.GC1470172@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318002436.GC1470172@coredump.intra.peff.net>

On Mon, Mar 17, 2025 at 08:24:36PM -0400, Jeff King wrote:

> > -	refspec_item_init_or_die(&spec, refspec, REFSPEC_FETCH);
> > +	refspec_item_init_or_die(&spec, refspec, 1);
> 
> The third argument here (and elsewhere) becomes much more mysterious to
> the reader.  Maybe not a big deal, though.

Oh, I should have read the other patches. :)

The end result resolves my complaint nicely.

-Peff

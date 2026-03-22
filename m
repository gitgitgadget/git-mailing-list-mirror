Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199871F30AD
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774143626; cv=none; b=DKNQTU9ERQaMAdqzSkXxwu2qyzqL/YUbpa0nTXyt9atRrS4tnIAQQhVwC28Kd+Ye66nIpjISueqCJjn2pQ1+ydXtjsJyJISc7Dsa03NYM5VqOeLcpGuCdNeI8bmzpBMKY4OiwRtU+RQSfblizUsJGmqMk4MF22+UpKfsCTKaT7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774143626; c=relaxed/simple;
	bh=PtbZv5XNk2qLg/VbTlUOOHOWD7lf3qINszPBnQvc8tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCilh3Yirr6zTi0pAlVt9/UlOTu2XOIAvlFTuJSIj6b3JteYGjK2yTTlq6udDvkMIv8zKqEWiKdj4RlB4desSiOwEUFU9QcZ3waExQYRxsnGWQN/3aHj8SiESoLvnU02hYxVx2klHOxnq53c/8O8HfpvnS6TeJ1XeJOcF02h8KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=B+EcWt2Z; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="B+EcWt2Z"
Received: (qmail 92100 invoked by uid 106); 22 Mar 2026 01:40:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=PtbZv5XNk2qLg/VbTlUOOHOWD7lf3qINszPBnQvc8tw=; b=B+EcWt2Zh2z0bx2WVT4cWTCMxHcbgq36ZhPQ9QsITjHc9cJ/6OBYIh46TO2AGHkLCopw4W/7YArok8VNnLqXDs4cU3ZUcUaka4vTc8LGCcd1vdBPb4T6NEGl5r0YMMrq0O0oJppIm6F2TrTuhdSpzGTuxbWcnIeOsDpYggPFBuvtuZQ0EPp3+IxaLfbgF8IUnaDGjaGB26dMXKlPvcrB6u0ze5XZFMYUB2lrF/rdrAkh8AUDBM2AXQyZg3kw2PEFb7W80b6zKJ6GCFdXb01zE8se9OtlEWNUZ0o1WuyvcfS9QcOuI+GM87NCI4IjZKNGHVgdsb4MHESQn3D1kaC8IQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 22 Mar 2026 01:40:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 126986 invoked by uid 111); 22 Mar 2026 01:40:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 21 Mar 2026 21:40:23 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 21 Mar 2026 21:40:23 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [RFC] cocci: .buf in a strbuf object can never be NULL
Message-ID: <20260322014023.GA816875@coredump.intra.peff.net>
References: <xmqq341wnvbk.fsf@gitster.g>
 <xmqqcy0zii0s.fsf@gitster.g>
 <20260319233546.GA3632561@coredump.intra.peff.net>
 <3e387439-c066-4e45-b28b-43f77c8824d6@web.de>
 <20260321211828.GB736981@coredump.intra.peff.net>
 <xmqq5x6oac9t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5x6oac9t.fsf@gitster.g>

On Sat, Mar 21, 2026 at 06:22:38PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Could the function be rewritten differently, or maybe even made a little
> > simpler? Perhaps, but who cares? The function has been largely untouched
> > for a decade and the behavior is fine. And there are a bunch of pitfalls
> > that a rewrite risks falling into.
> 
> Well, my only interest in this codepath was to get rid of "if
> (!sb->buf)" so that I can lift the special case in the Coccinelle
> rule.  Nothing else.

Yeah. IMHO it is better just to keep the special case.

-Peff

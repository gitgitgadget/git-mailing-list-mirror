Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD35130E4D
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206342; cv=none; b=p2WN5Y+Yi5Ic0uK1/OkZ2NAL2YIeVe0XX2DbEscUSjazFhg5ervnX7EykdTB1kjXY5s8DWYLQoWhEW9s2hWzOg8INYvjZFFec0sTGxVzzr505dJosYPgFut2o/ShEWWMYxHa5tTLlOUl2MOV+GfDoFDQxJdu/PLkawHqctTGVJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206342; c=relaxed/simple;
	bh=9swHHZ2QcWKawk7WgiXt4bQ4zD7e5qMuhHvpVj2JED4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2mIJAuAZd9AC8ReKeA79eaGnJtJt84Fgm2CHQaSIlwB9PgTeExMsgUm5xnhF2UdAZS2NPKOp0kJi9C31H+0Q/Vuk87uhOOcuJGUtDDmo4ch0FtkUE6fIK7R195Ywm+pbRJ2uDyZskcPsseWO7E3iNc6G60XFjQIqnPG98isL5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17178 invoked by uid 109); 25 Jan 2024 18:12:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 25 Jan 2024 18:12:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9236 invoked by uid 111); 25 Jan 2024 18:12:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 25 Jan 2024 13:12:19 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 25 Jan 2024 13:12:18 -0500
From: Jeff King <peff@peff.net>
To: Peter da Silva <resuna@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Slightly embarassing bug in error message when RSA key doesn't
 match.
Message-ID: <20240125181218.GB54488@coredump.intra.peff.net>
References: <CAMbH6s90tNo1Kz3xuv741LoUkN=Y3Bcw2=7yGQhEe=xrgBgQcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMbH6s90tNo1Kz3xuv741LoUkN=Y3Bcw2=7yGQhEe=xrgBgQcw@mail.gmail.com>

On Thu, Jan 25, 2024 at 10:37:15AM -0600, Peter da Silva wrote:

> Warning: the ECDSA host key for 'github.com' differs from the key for
> the IP address '140.82.113.3'
> Offending key for IP in /[...]/.ssh/known_hosts:8
> Matching host key in /[...]/.ssh/known_hosts:18
> 
> Of course it was the RSA key that had changed, and known_hosts:8 was
> an RSA key, but the error said the ECDSA key was wrong. After removing
> the bogus RSA key from the file it worked fine with the matching ECDSA
> key. This error should probably report the correct type for the key
> that is wrong rather than the key it’s trying to use. :)

This comes from your ssh client, not Git itself (of course Git is
calling the ssh client under the hood, but we can't fix their messages).

-Peff

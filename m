Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23400286D5D
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768357261; cv=none; b=WAAOfR5NcJFFWeP1I1/LDrZPnD3rtU0IoOmcjdPVjj5lnOcu8Qnkoh+JHpmQrx2VJD1jXCeL3zOlMYJoH6hgj1krK3Y8kDWQ4CwMyLIYv+rCXPCTXkADDtCAgsSzV40lg2t+63cE36yRCy7MWpV7tR5+wJSErZaz4jGU3rFsGmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768357261; c=relaxed/simple;
	bh=cGBNGPuikCWgVSyECk2dKfVKbkiDBIaaf+lyqnkoOS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRLpWJA8AFlYV6zEoggJgYWXZ6RZfky/U4OFJ6Dgnl3mSNimRc3MZU2MNsJHn0iLwqEuP5s/Ab225hmBH5+HgD0dkkX4mt1M2qtnWs+sveH9kR8TDiuSdzCD6BjyYBGJ0enbS4ri6mRcAA4a2s4BLGlRtlOB7nx1Dp+49eq5Iio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SORnt+mu; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SORnt+mu"
Received: (qmail 35144 invoked by uid 109); 14 Jan 2026 02:20:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cGBNGPuikCWgVSyECk2dKfVKbkiDBIaaf+lyqnkoOS4=; b=SORnt+munVx9XIRlA8tPqbNg6Cs0m/k1fX3Q+MKFi5ONN/DgGn3J3VOgt1vxXCyHc/FblWNxJkHIjyewTLwDrNl+9cJlnhDo3zWwyjmWS9f5G5Ok77A0lnr8Xih+3Qx8KxBIQbLoglggoH734nrvhy2zC5FGd6z5KxeRHqokKU5B+hFIYnfdOE+0CJN8xFcf8qt4lvQ+Qm4lby9wrF86ZapjFZJpYS4TV0cIZ8KcdoPduzcPdR6EDueHhJs1O1pn1Ck3pC2Y+j66v9BfhW+A8B55oMyxSxkfTAxT8AA7SufyHaHUeVX7Ey3n/MtHP8+h3VgwuqHSx4D9xlubOeCfiQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jan 2026 02:20:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 57172 invoked by uid 111); 14 Jan 2026 02:21:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Jan 2026 21:21:01 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 13 Jan 2026 21:20:57 -0500
From: Jeff King <peff@peff.net>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Lucas De Marchi <demarchi@kernel.org>
Subject: Re: [PATCH v2] remote-curl: Use auth for probe_rpc() requests too
Message-ID: <20260114022057.GA858110@coredump.intra.peff.net>
References: <20260113031929.3746753-1-aplattner@nvidia.com>
 <xmqqfr89lkve.fsf@gitster.g>
 <a919f4cf-8355-43dd-a552-df99325e4cc6@nvidia.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a919f4cf-8355-43dd-a552-df99325e4cc6@nvidia.com>

On Tue, Jan 13, 2026 at 05:06:20PM -0800, Aaron Plattner wrote:

> > Hopefully, $(test_seq 2000) would not bust $(sysconf ARG_MAX), which
> > could be as low as 4KB, on any system we care about.  If not, of
> > course we could
> > 
> > 	test_seq 2000 |
> > 	xargs printf "create ...\n" |
> > 	git update-ref --stdin
> > 
> > which probably is not all that more expensive than what you wrote above.
> 
> That's a good call. I tried this
> 
> 	test_seq 2000 |
> 	xargs printf "create refs/heads/branch-%d @\n" |
> 	git update-ref --stdin
> 
> and verified it produces the same results, as does the same plus passing "-n
> 10" to xargs.

test_seq can take a format parameter these days, so just:

  test_seq -f "create refs/heads/branch-%d @" |
  git update-ref --stdin

is enough, and saves some processes.

-Peff

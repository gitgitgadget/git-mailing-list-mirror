Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D3A127B66
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714470468; cv=none; b=FV+1J4A/r/BaVOuhCOI/kgHPU9m/kosV8RktwOH6G2kCUYI4OEibdgIWg2efgq3APzXh5Zi9va2O96cm8pgGD+3u/m0J20P2G6OzeliaQZx19UBWwvk2B4kZettB8QLREbxAfhDCJ+cvZ5gtjIrr+R4LQrNhTp1pzFOATVJO8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714470468; c=relaxed/simple;
	bh=mKJ0PT43IDsEIy9DF7aZl8nWE50p1bmbo7AL5nBGdsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIi44gUHwD+43CEgLhtbqdLFRicXM5wEXnQx9te4yw2OES7g1gaJo0Rq9gHxWF7f3hV4dM2mrgI+Q5ZpC4raT1+shOFM1gvu4HBwTUphcnIbxvi33zg0G0P8xj78x4Hbt69lNJzg2UrLJSHEQQLV/liHUsQPX7yi93a2JWS1Ta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 2620 invoked by uid 109); 30 Apr 2024 09:47:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Apr 2024 09:47:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5255 invoked by uid 111); 30 Apr 2024 09:47:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Apr 2024 05:47:44 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Apr 2024 05:47:38 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 6/8] check_refname_format(): add FULLY_QUALIFIED flag
Message-ID: <20240430094738.GA1279403@coredump.intra.peff.net>
References: <20240429083325.GE233423@coredump.intra.peff.net>
 <CAOLa=ZR+nunNg8_LMTzwoHzbBU2EboMSsZRodswLP9bMLhtCpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZR+nunNg8_LMTzwoHzbBU2EboMSsZRodswLP9bMLhtCpg@mail.gmail.com>

On Mon, Apr 29, 2024 at 09:01:52AM -0700, Karthik Nayak wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Before operating on a refname we get from a user, we usually check that
> > it's syntactically valid. As a general rule, refs should be in the
> > "refs/" namespace, the exception being HEAD and pseudorefs like
> > FETCH_HEAD, etc. Those pseudorefs should consist only of all-caps and
> > dash. But the syntactic rules are not enforced by check_refname_format().
> 
> Nit: s/dash/underscore

Oops, yes. Will fix (and the same mistake in patch 8). Thanks.

> Also FETCH_HEAD is a special_ref, this confusion should however be
> resolved with Patrick's patches [1].

Hmph, I guess I was not paying attention and missed that the distinction
even existed. But yeah, I think for the purposes here it is not at all
important. This is purely about the syntax rules, which are the same for
HEAD, pseudorefs, and special refs.

-Peff

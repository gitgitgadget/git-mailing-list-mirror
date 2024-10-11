Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB901EBE
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637254; cv=none; b=dlD/w89tIFj4yLo+EQzG1NEwsBa6WNMscFf9fJtcYAbE705zlCViTquWE+kbcyn0xbedEuBQFUPuttM+3mCgOMCwBcQxj3rDhTVOJBsgmp0lHzYQJtaUSJJNMYg/PHUV30gDY+DxGJAQLCR7DukgJKid0zrS4wjKO5pWMJ5fl3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637254; c=relaxed/simple;
	bh=/HdzZXmQbU94n71EmafbGJ17KdATsuVz90sqB+suftY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3/L1hVWUmOHiOdHeQM7WZNc1hVjpkXre1mWFR+7YDsm/83fUDatnALfmHdAmtOzmCeeIXSfmIM+FX7/kjvNDlk4rEh7adXMow07DmLzpxs0kai5EML7n+FGGvcBDWfLYAZBvQjoxkocBcHnG7W4JqMY0tw7xjerjPG1VdKgrEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gvDf5Wc7; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gvDf5Wc7"
Received: (qmail 6113 invoked by uid 109); 11 Oct 2024 09:00:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/HdzZXmQbU94n71EmafbGJ17KdATsuVz90sqB+suftY=; b=gvDf5Wc7ZKPgtchq+JYOPP3v/nbtyvUtFgnTNNKIzWcF/mzVk91IZZYSSC6Kne/nfJ4Bl3A1cK0BUYqZUKPhLtlsXDowgWGnk1nXJctkvTl8S4WmaomQh8XF3fZdQWC4cnPCLPBbI3bkwAuTO42c6FYsjW28/jaAXdtUznJdg2HqN8rlCx/S5xgAmdw2yKg2PUZq+lEMgmGA4nNkV0KK8W7V2AvFn2Z1ucA1urEmx81R2jWKcw3R7LQelyftG3BKrg+UatGbw6h5C+fgd1gfwANhH3Uh3JjugS+6TUoMOrWObz0nJU1lnpCjRkBITvhdJ2khOcveee9fxpuo4fXnSQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Oct 2024 09:00:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18054 invoked by uid 111); 11 Oct 2024 09:00:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2024 05:00:51 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 11 Oct 2024 05:00:51 -0400
From: Jeff King <peff@peff.net>
To: Koji Nakamaru <koji.nakamaru@gree.net>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/2] alternate approach to fixing fsmonitor hangs
Message-ID: <20241011090051.GA563709@coredump.intra.peff.net>
References: <pull.1804.git.1727862424713.gitgitgadget@gmail.com>
 <20241007055821.GA34037@coredump.intra.peff.net>
 <20241007060813.GA34827@coredump.intra.peff.net>
 <CAOTNsDwwikiX3u6DG=+4hn+mcgfXzzDoqR3ZFVEdGi=mPGQbpg@mail.gmail.com>
 <20241008083121.GA676391@coredump.intra.peff.net>
 <CAOTNsDyxmRZ155vV-Jh=1obMnR+F4ExY9B136fiGk0Vd23-zrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOTNsDyxmRZ155vV-Jh=1obMnR+F4ExY9B136fiGk0Vd23-zrw@mail.gmail.com>

On Wed, Oct 09, 2024 at 01:03:14AM +0900, Koji Nakamaru wrote:

> > But I've cleaned it up for presentation here, so at least we can look at
> > the final form of both and see which we prefer.
> 
> Thank you for the new patch. It prevents to start accepting requests
> until starting fs event listening and simplifies the code flow. It also
> has sufficient comments, so later everyone can easily understand how it
> works. I also tested it both on mac and windows and it works correctly.
> 
> I think this one should be adopted :)

Thanks for reviewing, and for all your work identifying the problem in
the first place! Looks like Junio has picked up my patch and it's
already in 'next', so hopefully these 6-hour CI timeouts will soon be a
thing of the past. :)

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8C117583
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730741246; cv=none; b=FHu8GxeAtIAQXUAJC2rKc8ygmY++XJGzP4ABM0+3WokRkgkyp2G4J7HQXoMlFxwPncEK2dAbxgUixeEXaKuBa+cKWLDDrA0A5ZaFxOpSrFr1gIVKNSKcHV2hLPy2u/XL1JQ6XMHGLepEPRsRXFs3c43698bWFcJMMpinrycG6x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730741246; c=relaxed/simple;
	bh=Ifw/FMdglzY14OJ4vVxg1w4HXS8G6ZfWUfWMyPFzSXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiOaC9FvCaw+iVERJYXTvY3PDVxR1BCNeJ9q7pZFbECMr02lfC1n0vFIewdiTxfR5NQs7P7BEQOpRhA0LV+eYzPgTEp7zR3r1PoTz1x6U2NyyRVlXrjXgPJ6UScph6KDqzKWq3Pq1cVKgFky2m949YlrLrozeIktrccyew3pVvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RFGjiGGR; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RFGjiGGR"
Received: (qmail 12551 invoked by uid 109); 4 Nov 2024 17:27:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Ifw/FMdglzY14OJ4vVxg1w4HXS8G6ZfWUfWMyPFzSXo=; b=RFGjiGGRk9A+zjJ8Cg4yRjFjDszB+ZPuMnfHpT6WZfyGXofG5Rs8BiPYUDEdwRLd1GnsfG5+c16zwhyqxWxg/Evendl+BO8apYYoUK4sTbzXAxnKOg6kyJGXCnvw9sgN6UwHGVpmcIsRxAfxDefnpS66J0RTXsmx5rNQN6efwKOhE1W3ce6K97LKNbZeN4W2lkU2180qhtAIlIFWujXNh0fapsBf/a82zKeAVkGyAERgUFsc1oLN2A/TgtyWI5uctle/xLV25d17K/wodgXUgHTTI0p9WjC9YwF3Pe2TQUTyvMLuhkRBMneREUNMGVrBUQwrA7SyBBHqimIixIamsw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Nov 2024 17:27:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14494 invoked by uid 111); 4 Nov 2024 17:27:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Nov 2024 12:27:22 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 4 Nov 2024 12:27:22 -0500
From: Jeff King <peff@peff.net>
To: karthik nayak <karthik.188@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 0/9] packfile: avoid using the 'the_repository' global
 variable
Message-ID: <20241104172722.GA2989472@coredump.intra.peff.net>
References: <cover.1729504640.git.karthik.188@gmail.com>
 <cover.1730366765.git.karthik.188@gmail.com>
 <ZyPjJKYZzeFGLxin@nand.local>
 <ZyTnhrBLuvesK1yB@nand.local>
 <CAOLa=ZTp=QqD0P2zhGunrOfmAebwvLJ20bQq9Tog3eLaO9pwoA@mail.gmail.com>
 <20241101172939.GA2337295@coredump.intra.peff.net>
 <CAOLa=ZT8dvpvJ75Oe_PV4_osi7rw3EJnH2SSzUVame-eQvOruA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZT8dvpvJ75Oe_PV4_osi7rw3EJnH2SSzUVame-eQvOruA@mail.gmail.com>

On Mon, Nov 04, 2024 at 01:39:31AM -0800, karthik nayak wrote:

> >   2. I can imagine you might have used "unsigned long" because they are
> >      parsed with git_config_ulong(). That is OK on Linux, where size_t
> >      and "unsigned long" are the same size (either 32- or 64-bits). But
> >      on Windows I think it means that you cannot configure a window
> >      larger than 4GB on a 64-bit system. Or ironically you cannot set a
> >      total limit larger than 4GB, even though the default is 32TB. ;)
> 
> Yup that's the reason I changed them. TIL about size_t and how it works.
> Thanks, I'll change the types accordingly and push a new version soon.

Thanks. I think I got so busy talking about the issue that I forgot to
mention why I think this is potential #leftoverbits: we probably ought
to be parsing that config with git_config_ssize_t() or similar. But that
is outside the scope of your series.

-Peff

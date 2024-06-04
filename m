Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003704A07
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496223; cv=none; b=Mjl+VIGqjm6oDIki9a6WhGpDckWueiKy14GL9w2mdLyN+CMUCXjo2UK0Gl0NsEMcjpFNUGljCDst83y5kHx5akwdNgm7YBFy2XK/W9T8XY9M1x3zj0XCnWeVhvqPz2Bnupw6DsNPtqem4TIYbLvrXu4x+YjKM39T3BKSjLlfQ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496223; c=relaxed/simple;
	bh=JWHdmusI+CGK56euA1a8uvQc8DyI8EEd+isl5h8rWlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L04XSkjbehBaXVVQr1r81SXlul9IDgyrkYwNOJJIaW4aFvDCTTf5audORkyJutcEHZPIOIpmt/W4i+JmAeuilibDa0lrTRHt8B3GhczRWIqTAX/jNer6TeNfxc4DcHC3DECpnr5DkBckkUDOHKemk2PD29B5biFEIXiMdlL8290=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21639 invoked by uid 109); 4 Jun 2024 10:17:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Jun 2024 10:17:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18583 invoked by uid 111); 4 Jun 2024 10:16:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Jun 2024 06:16:58 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Jun 2024 06:17:00 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
Message-ID: <20240604101700.GA1781455@coredump.intra.peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>

On Sun, Jun 02, 2024 at 05:38:42PM +0200, Rubén Justo wrote:

> However, the current functionality meets my current needs, so I'm happy
> with it.
> 
> This, a new 'interactive.pipeCommand' setting, or a new switch: 'add -P',
> are left for discussing in, hopefully, a future series.

Earlier I suggested that I'd set such a config variable to something
like:

  diff-highlight | less -FX

But after playing with your patch, I realized that:

  - there's no need to pipe through diff-highlight; it already happened
    as part of interactive.diffFilter!

  - since it's triggered manually now, there's no need to add in -FX

So I am perfectly happy for you to stop where you did. Possibly
interactive.pipeCommand could be useful in a more general sense, but we
can wait until somebody encounters that itch.

-Peff

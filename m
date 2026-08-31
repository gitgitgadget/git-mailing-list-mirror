Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6113A3B0AF0
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 23:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788217815; cv=none; b=k+VrjKign7Q9NzOXjSa8bLoiqMpin42EoUQuYs+dLVqw2XjiXGWwSUENyZD7bpK7dxRBLE9gvul05MyllU8+ry3y5OqPjOUkDKAeCFAJlb7ZSYW/OI9tsQEwtF1GE/wnX+Uy4SVfgoT7syz9lP3KFS1DB6MMOrdlN8gOpfd4Cik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788217815; c=relaxed/simple;
	bh=mfdumCDzHZOApVU0bjy++zBS+ctjA83eFThtlpWrekY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KP0rrtY9xJQfdDPLzmz4Y3y/gy5JrXY5X8u8HRon+bq9vzxJMPShaoKXnFuizTqJ+o2/fH46RgbpiQRK29wy2VGrwMvWp17lB/qw1fVD45sbCHZeeGZEY+UT1edBL2dhCP517FB1j3vL7S07d+OwZ2pfyA+doItclxMOmnbqstU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WJODUwzY; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WJODUwzY"
Received: (qmail 6321 invoked by uid 106); 31 Aug 2026 23:10:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mfdumCDzHZOApVU0bjy++zBS+ctjA83eFThtlpWrekY=; b=WJODUwzYnhyMjbq8+4dvjtjUYrvFgJbYWZawpaiSqZw4d7lhONTk8uIbelq9eQeJP9qmJjMfBbq+JCBqinAEOQ1jou5OWe6wCkjBGLC8yGSw46LN/FCHKtK2883C2D4ft4DIdg4kszwlVZAU/rvOKSeqOoi0CvhXs/7yyQhjvaKZItYOknSPWLNGoAYfEpTo2lU5rSs2jJccMV8ASHNn9LEah2Y+OeojTF63x43UWKmU9jYlySYOT6J06w4UrsnvM9jWdRAYyKBHJ8BEdD6NvOoaqC4Svm8ZIYIN75v3308gcsZcgHHKLF7HlqfhP2o9OF5VL66sGhtfcd8WooqF7w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 31 Aug 2026 23:10:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30158 invoked by uid 111); 31 Aug 2026 23:10:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 31 Aug 2026 19:10:05 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 31 Aug 2026 19:10:05 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 4/4] packfile: recover when a multi-pack-index names a
 removed pack
Message-ID: <20260831231005.GA973618@coredump.intra.peff.net>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <pull.2207.v3.git.1787986831.gitgitgadget@gmail.com>
 <9b0966df9a060df215d8aec7816875d42651d5bb.1787986831.git.gitgitgadget@gmail.com>
 <20260829120721.GF40814@coredump.intra.peff.net>
 <xmqqjyp71g9s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjyp71g9s.fsf@gitster.g>

On Sun, Aug 30, 2026 at 01:53:51PM -0700, Junio C Hamano wrote:

> Thanks for a very informative and well reasoned write-up in support
> of the series.
> 
> Shall we mark it for 'next' then?

Yeah, that sounds good to me.

-Peff

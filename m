Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5564C292915
	for <git@vger.kernel.org>; Mon, 12 May 2025 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054719; cv=none; b=Xr3RPVqoH0BYzcj4LB6MF+i1XNwNohquUtuHYcBmHPbcQ02lsWNSlDfg9sJfaHGE638++VyA7ba66oh8nIc+pPRdQffw3qTLsG9ZgKKLB+1KHMtWwsxvqK26RdELssMbOaJ214EYxTnC8YU9vLkiadxy8LNyx0O3GAe6K6eOtng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054719; c=relaxed/simple;
	bh=9TDFJKnSIlwt1pRbVBG7DEC4hnQMbe2jGJKp2TBrHNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5UApA4dJr9/ER36dyWGJIBR9NXlbWUMCj1EwBxRhBnOVQ7L4mmqmmfqX3UOtx7bxDN6Uf/sQO5bWIkjlUljIH2XSFeqNmWoccehMRAWInsB5l9QFBjYi6qU1QxrNkLryzhQIjsK2MfZZ6R6qAUYoCDvagbxKYLHu+s/NprK3iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CWdTdWFT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CWdTdWFT"
Received: (qmail 1479 invoked by uid 109); 12 May 2025 12:58:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=9TDFJKnSIlwt1pRbVBG7DEC4hnQMbe2jGJKp2TBrHNU=; b=CWdTdWFTiU9M96EcB9pxnrR1hS/4XnAE/2vyfq7wFnuIEdq/t1fUKBtWkRDA5amLNNBdvkS/fMGWwUkjr+wlarwQLDxEa7lJGPutW1hwPHPNtXg2jQfr4cFStvlYe7j6Xg96AxzKiTcTNvgNSZ+5tBO9ewqOGnKoqu1C6sWtFX2nP+J4FRf5LFg+Q46gLx07MDFtKph998lbazPwKILIQQn4ChrtFMMlXg+Wl/k0i9CEKsAcZYx61gY9HRK1JMYtkR7rNpvB6UYdOMsYXEZG1qhC9h7nsDe7oqfUhxtT3YB3DqtZftbkOu53skYNx2fzF9y1FIWyXtDlSgdYjA7hKQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 May 2025 12:58:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6051 invoked by uid 111); 12 May 2025 12:58:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 May 2025 08:58:26 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 12 May 2025 08:58:25 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 4/4] builtin/stash: provide a way to import stashes
 from a ref
Message-ID: <20250512125825.GA1191360@coredump.intra.peff.net>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250508234458.3665894-5-sandals@crustytoothpaste.net>
 <20250510172107.GA601540@coredump.intra.peff.net>
 <xmqq5xi6xaov.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5xi6xaov.fsf@gitster.g>

On Mon, May 12, 2025 at 05:42:08AM -0700, Junio C Hamano wrote:

> > I noticed because I have a patch series from last summer tightening
> > these rules (it got derailed by some conflicting work, and I've been
> > meaning to pick it back up). I can certainly adjust these tests as part
> > of that series, but if you're re-rolling anyway, it might be nice to do
> > it now.
> 
> True, and exported one is a sort-of-normal-looking isolated history,
> so it does not have any strong reason to be at the top level.  But I
> am curious what your plans are to deal with .git/refs/stash itself?

My series is only about the absolute top-level, outside of refs/. So
"refs/stash" is OK, but "stash" is not.

-Peff

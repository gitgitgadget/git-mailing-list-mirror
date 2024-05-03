Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EE1524BE
	for <git@vger.kernel.org>; Fri,  3 May 2024 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759362; cv=none; b=BnlJxWk+kb/43Ku4sZnQgv+lmuoL5xU7bMtxblLSJV+7TpWTh9Q05P6pYMPdf/s2XO0C0IYPW6hZxXQMC7vwx1pui6FrXuq19Iq6nBTSx/vG2XixZcgiIiEaGJxDoaQ8Cg0d31kbwziAq0VctB2l5slbbOb7prL52tTUZOvmpCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759362; c=relaxed/simple;
	bh=QiN/m5B1esxM7jNL/e6tnv+2mpXg+T1dJsoUMiepwOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9Gcl/pQP9GhPWroWReOuuvzt6zoSe8oN4Zv3VK+5w8mjrEj4Ha2RFOv9BsZsq5wBHr3nNZDh0Xr0I8+1TUTtBQqCuZEcBgGHw4GPZsXmheC0kZHFiCmTxigGjNT3z8CHxBeZiocqW4GdoAICRCFLefInphNVpZKaN8MXyf9IBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11891 invoked by uid 109); 3 May 2024 18:02:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 May 2024 18:02:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17741 invoked by uid 111); 3 May 2024 18:02:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 May 2024 14:02:41 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 3 May 2024 14:02:39 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 6/7] t/Makefile: run unit tests alongside shell tests
Message-ID: <20240503180239.GA3634479@coredump.intra.peff.net>
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1713985716.git.steadmon@google.com>
 <0e32de1afe9cbab02c5d3476a0fc2a1ba0151dcf.1713985716.git.steadmon@google.com>
 <xmqqo79yxxk7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo79yxxk7.fsf@gitster.g>

On Wed, Apr 24, 2024 at 02:25:44PM -0700, Junio C Hamano wrote:

> Josh Steadmon <steadmon@google.com> writes:
> 
> > +case "$1" in
> > +*.sh)
> > +	if test -z "${TEST_SHELL_PATH+set}" ; then
> > +		echo "ERROR: TEST_SHELL_PATH is not set" >&2
> 
> Style.
> 
> As an empty string is not a reasonable value for this variable (and
> you do not quote ${TEST_SHELL_PATH} when you use it in "exec" below),
> 
> 	if test -z "${TEST_SHELL_PATH:+set}"
> 	then
> 		echo >&2 "ERROR: TEST_SHELL_PATH is not set or empty"
> 
> may be what we want here.

If we are using ":+" to handle the empty string, I think just:

  if test -z "$TEST_SHELL_PATH"

is sufficient, no?

(not that the other is incorrect, but whenever I see something like
":+set" I wonder if something more clever is going on, and of course I
get nightmare flashbacks to looking at generated autoconf code).

-Peff

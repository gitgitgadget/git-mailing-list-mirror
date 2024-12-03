Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640041CFA9
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733261085; cv=none; b=dWYO0b81IUXMB727hngQgFst4/Yb47x9WIrOgMjMgrM1rVSdyrtm9BcwqrJ79fOqEzP18VYCcGByxRYh+mlWffmVI4NDS11S9z+LwS7nYva57fetu5rS9WO1iqmrIjT3dClXgTfhcdQMzVC2bZttFY9MFUBOpwwisUwoaETPwaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733261085; c=relaxed/simple;
	bh=4juU5ZoNi85MQnl0rexY8eNgsRiE029PMsR+83N/Q2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0JsTl1rCBw/JECdNCMlp7G4iDO5RBGSQ6WQmUt0H5zt6IGD/CEqzlh2bNnaJyxeSxKnPXvwmYehED1W1zLfO+xMYj273XAb/pMvmXE+gWztk1sbl5CqUTtPcbc8NcB7JxZ7s9Gf7A93+uXDpRxML4k/2eJxwG00Vq/6NYSaWuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FJQT92lX; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FJQT92lX"
Received: (qmail 30702 invoked by uid 109); 3 Dec 2024 21:24:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4juU5ZoNi85MQnl0rexY8eNgsRiE029PMsR+83N/Q2o=; b=FJQT92lXxLXlM5IbRUjSwlHewCzedWQM5YNWzuf0tTJs6dXuOlegq9daN5S3XB37GU8rNpt3JnigCl6z6+WEm0V/1dKaXMVyUYmDqQFpe2n9VDnhekpJiLvrJdrbZFFHYhg+VVwDOhI7hTV+Ozgwc9r6juNgUtHRoL3vfI8OJF4+VO3o8Z7UnrRMyTrczhZKkUlHtNDHkOxu3b694kvMJHg0dmtsVnsBKHlVon/RtGBL8pHwlXmd7InvUYXBvfHKReypmzIIul+HiS0cWB77mt6drbyM+ndoP7t7GVyJK7yMa/04pIleqN5yxRp/9ucH5kk9lvwsivNltFodi5n4kg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Dec 2024 21:24:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10376 invoked by uid 111); 3 Dec 2024 21:24:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Dec 2024 16:24:41 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 3 Dec 2024 16:24:41 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Philip Yung <y5c4l3@proton.me>, Taylor Blau <me@ttaylorr.com>,
	Y5 via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] diff: setup pager only before diff contents truly ready
Message-ID: <20241203212441.GA1424493@coredump.intra.peff.net>
References: <pull.1817.git.git.1729370390416.gitgitgadget@gmail.com>
 <20241019211938.GA589728@coredump.intra.peff.net>
 <UZMh2lyzbLOgsf0PXfMnq6HnWVnCK3y36jY3IMKUykPi74ztNucf8bgywoeO0DdeApq31JDDGMZiEya99zAcI3l8y_zcVqiN8FpEnT1DRZU=@proton.me>
 <20241021190045.GB1219228@coredump.intra.peff.net>
 <ZxatqdBiB+NoMP+j@nand.local>
 <xmqq34jpl5sl.fsf@gitster.g>
 <20241125113105.GA1070162@coredump.intra.peff.net>
 <xmqqo71tcovl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo71tcovl.fsf@gitster.g>

On Tue, Dec 03, 2024 at 02:33:02PM +0900, Junio C Hamano wrote:

> >> It seems that this topic is waiting for a reroll?
> >
> > I think we could go either way. I outlined a few further possible steps,
> > but there is no need to hold up this first step. The only question is
> > whether or not to add a single test to show off and protect the
> > improvement.
> 
> Hmph, a few messages upthread
> <UZMh2lyzbLOgsf0PXfMnq6HnWVnCK3y36jY3IMKUykPi74ztNucf8bgywoeO0DdeApq31JDDGMZiEya99zAcI3l8y_zcVqiN8FpEnT1DRZU=@proton.me>
> (Ugh, why do some MUAs or mail providers use such an overly long
> message ID, Yuck) was where I got the impression that we were
> waiting for a reroll.

Yeah, I think Philip was offering to add some tests. Since he has been
quiet since, I do not have a strong opinion on whether we should just
take it as-is or let it go unless he comes back.

> I am not all that convinced that sprinkling setup_diff_pager() call
> all over the place is a good idea from longer-term maintainability's
> sake to begin with, by the way.  What problem are we really solving?
> Folks who run "git diff --no-such-option" see "behaviour inconsistency"?
> All I see is "error: invalid option: --invalid" followed by a help message,
> which is quite expected.

I think it is just about not starting the pager when there is no useful
output produced. Depending on your pager config, it is a little nicer if
we avoid it for a one-liner error. E.g., I do not use "-F", so "git diff
foo bar" drops me into the pager with a single error line.

-Peff

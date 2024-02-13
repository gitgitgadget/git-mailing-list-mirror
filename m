Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533A17980
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707810091; cv=none; b=Od1zR+eYUGBhvDwovpbVQECD7+A1h6O/ygU53oP+5UpiL8Y/z0714C1Tq6wsi3FTHAO2O596uXd4MHy9m0iznrdHykrHPoSzANVGxSKv9E03p6mA6FNzUJSjSfkH7OzTNXOXASjbYD4fjisKlqrfIlQDBovrH2FiEqryKOfaJuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707810091; c=relaxed/simple;
	bh=sBNxytf/AOroPP1gyW7lisP91t4N7Wvk6h/aVKyk/n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQhLfigHaIuFwhFANSYBgr4xrRsVxiZlEzXhG06zMO1QVbgz86yDkn5skJfE4YbeoChxX+crNxUK8/ntJD4t7YP9RHJcM5alQt9BG8j92hE4VqjN1GJBsw+sNVT2GRIZdWd7xFMA1/UQHz1/0JH3rbMigUwb5rmDvdQpxcFXV8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14696 invoked by uid 109); 13 Feb 2024 07:41:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Feb 2024 07:41:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25036 invoked by uid 111); 13 Feb 2024 07:41:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Feb 2024 02:41:20 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 13 Feb 2024 02:41:18 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 1/6] t0080: turn t-basic unit test into a helper
Message-ID: <20240213074118.GA2225494@coredump.intra.peff.net>
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1706921262.git.steadmon@google.com>
 <da756b4bfb9d1ce0d1213d585e72acfbf667e2a2.1706921262.git.steadmon@google.com>
 <20240207225802.GA538110@coredump.intra.peff.net>
 <ZcqFOVuR0sxFDDUv@google.com>
 <xmqq34tx5q6o.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34tx5q6o.fsf@gitster.g>

On Mon, Feb 12, 2024 at 01:27:11PM -0800, Junio C Hamano wrote:

> Josh Steadmon <steadmon@google.com> writes:
> 
> > I see this line in the docs [1]: "As with wildcard expansion in rules,
> > the results of the wildcard function are sorted". GNU Make has restored
> > the sorted behavior of $(wildcard) since 2018 [2]. I'll leave the sort
> > off for now, but if folks feel like we need to support older versions of
> > `make`, I'll add it back.
> >
> > [1] https://www.gnu.org/software/make/manual/html_node/Wildcard-Function.html
> > [2] https://savannah.gnu.org/bugs/index.php?52076
> 
> Thanks for digging.  I thought I was certain that woldcard is sorted
> and stable and was quite perplexed when I could not find the mention
> in a version of doc I had handy ("""This is Edition 0.75, last
> updated 19 January 2020, of 'The GNU Make Manual', for GNU 'make'
> version 4.3.""").

Likewise (mine is the latest version in Debian unstable). The change to
sort comes from their[1] eedea52a, which was in GNU make 4.2.90. But the
matching documentation change didn't happen until 5b993ae, which was
4.3.90 in late 2021. So that explains the mystery.

Those dates imply to me that we should keep the $(sort), though. Six
years is not so long in distro timescales, especially given that Debian
unstable is on a 4-year-old version. (And if we did want to get rid of
it, certainly we should do so consistently across the Makefile in a
separate patch).

-Peff

[1] commit ids are from https://git.savannah.gnu.org/git/make.git

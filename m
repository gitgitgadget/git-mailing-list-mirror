Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866AC43F4B5
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785246942; cv=none; b=p+QjOmvOXWTlnHM4fiVUh97sKep0La3ngDYK3Jk1J83wOqk7ook6RPYFHYaXKuJh2XNKY1veDwwDc+tmChuVO9jXYA2hye5VhVYJyjrqPGpVAdcSCNmfWgZ47JHy3gyS3YZ5wu1zvm5aS4WhJTpAFHwu6GYo1lIVm/g9cGyr+w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785246942; c=relaxed/simple;
	bh=l8HPeiBt/QyeF/GAW/kL+ywl/qGQ+8Pk4EhWopXuhzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX1dITZ1GHz3DWyQPaocL9R9hE0Az2rekNzINvsykBvdEleZdFjc2Nb4c5Arc5nVosxTPdp6hAJfUi0KUEYjuvukmX5lnEUocRiG+E+7kNsuT1rj0esGhDm6I/uT/59+RDzZhCtrQ8O39kTX21uD16gsPfsMB0ZxW/k6NCFXR70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Z5v2szHr; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Z5v2szHr"
Received: (qmail 80511 invoked by uid 106); 28 Jul 2026 13:55:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=l8HPeiBt/QyeF/GAW/kL+ywl/qGQ+8Pk4EhWopXuhzM=; b=Z5v2szHrKevduUbIepLl+OzccgPN29ISPsKb1Neqhq/0QxIrcnh5aWPLX6jEq99kGr/ToIljV/uqsVIAhKfMilvGyCpAdsKTNaY0WOyJqNnAzPTshOWIvIwB2iDC3fCyiqO8hQsnpW5TPHlejmhF4L3welD4ELGuT6CAx6uUjvdVju4JpAU47/yYMHGbCE4vPHrECV7T18gFywnMDE2NPfoRr66vLAl6woB553fUpGtuOtAp1/mJRR2V7A7T0t6n2luIH/Pe6iU0cTD3Jc6Y4hx77agODwS6bxJoYo+RJGq6sTb8VM1Zav2ISulTxbHc4PQ3Un/kuynWRmcGIjvj0w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2026 13:55:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 99255 invoked by uid 111); 28 Jul 2026 13:55:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2026 09:55:33 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 28 Jul 2026 09:55:32 -0400
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: Failing tests with WITH_BREAKING_CHANGES
Message-ID: <20260728135532.GA11894@coredump.intra.peff.net>
References: <amf76F4wxlboLz_A@fruit.crustytoothpaste.net>
 <758dbec3-7657-4342-8b74-7e59cdf88b5e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <758dbec3-7657-4342-8b74-7e59cdf88b5e@gmail.com>

On Tue, Jul 28, 2026 at 02:31:03PM +0100, Phillip Wood wrote:

> I find t1517 fails quite often for me due to cruft from a previous build
> when a different branch was checked out. I wonder if there is a command that
> is no-longer built by WITH_BREAKING_CHANGES whose executable still exists in
> the build directory from a previous build. Its not clear to me why the alias
> tests might be failing though.

It's the same reason. We test looping through deprecated aliases using
whatchanged and pack-redundant. When those are builtin but deprecated
(like now) we allow aliases. After the breaking-changes split, those
names are not special at all, and they are subject to the usual alias
rules. If there is crufty git-whatchanged in your build directory, then
that is an "external command" unknown to Git and you are not allowed to
alias over it.

The test in t0014 that covers this should be removed after the breaking
changes actually land (those commands won't handled specially, so it's
not different than the normal alias loop detection).

But we are in a funny limbo now for WITH_BREAKING_CHANGES. Possibly we
could pull the value out of GIT-BUILD-OPTIONS (which I guess happens
already via the environment) and use a prereq to skip the test.

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391FE320C
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546351; cv=none; b=NqXLpAMgrIjbVCMIYlSyZRgK9xoDc+EU4GcX7r6oAvxk/z6KQhbvA9tKf3sb8f5Nn5jmVlInWzPFMNuGEvraUIar/iqWct2MLJpFINZUqn78D9+Oz/wSz4WBm6W+gWLLgfJUcqPWVVhLA6m/p5MLcsGz/KD90ghKZAy3VX7SljM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546351; c=relaxed/simple;
	bh=D1vTDDizvs23Fq/BO7VuEhipuEmhkeCCpyfcIuFkeOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJNMkQk3wV29Tbs5fBI6xG1gRWHJVfgwF2fi8P++vyFP09UVaL24MGbocNmTIYO83p6OOHleIG8Pu/xjAaN6zyIk25L3t92wyHGgVe67mqxAuMfqYPyrrrQ18ugW+1IMFvXNGZgidHdb8kdUaxKcKzUA1tBYV/s2gRbZ7EkZJ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 29728 invoked by uid 109); 4 Mar 2024 09:59:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Mar 2024 09:59:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11653 invoked by uid 111); 4 Mar 2024 09:59:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Mar 2024 04:59:12 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 4 Mar 2024 04:59:07 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Benjamin Flesch <benjaminflesch@icloud.com>
Subject: Re: [PATCH 6/9] upload-pack: disallow object-info capability by
 default
Message-ID: <20240304095907.GB3723539@coredump.intra.peff.net>
References: <20240228223700.GA1157826@coredump.intra.peff.net>
 <20240228223858.GF1158131@coredump.intra.peff.net>
 <ZeWHlknuWMvRiFtC@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZeWHlknuWMvRiFtC@tanuki>

On Mon, Mar 04, 2024 at 09:34:30AM +0100, Patrick Steinhardt wrote:

> > +test_expect_success 'object-info missing from capabilities when disabled' '
> > +	test_config transfer.advertiseObjectInfo false &&
> > +
> > +	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
> > +		--advertise-capabilities >out &&
> > +	test-tool pkt-line unpack <out >actual &&
> > +
> > +	! grep object.info actual
> > +'
> 
> Is it intentional that you grep for "object.info" instead of
> "object-info"?

I didn't even notice this. It should be equivalent because of the regex,
but I don't think there's a particular reason to be more loose (and
unlike single-quote, which we sometimes match with "." for shell
readability, it should be fine to say "object-info" here).

+cc Taylor, who wrote the original.

-Peff

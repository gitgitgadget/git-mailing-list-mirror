Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE43F3FB8D
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 21:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882675; cv=none; b=MYWqjEi03a/FlkzL1skeIEd2XXeKT4nSJSUg8JJRGJ5h1RiXU/A+IhFrceplVB7rT3MTkCeW8EhXZoKFDUhLsaJeln0TjPy54MEx7wgBzvRjqvP1XAVaj1sPtuUOoPNDprLX0BoFYQbMvTSNckq2No8/hQ14hc6IWjNIGCdgFjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882675; c=relaxed/simple;
	bh=U7/zAwVyQajs5n8dYg+3mqQP3fdlGSrY/j5Dgvd5i/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndOVja9YOwft4q1TCfxYsDhkq+MOQ9fEDPqE/75AQZawpw5yC704DGsY2240CZRiK18u82wW5Uavj+KlRcprJqI2L8vaKhYreDRO9m4PyJL5Rx8b1t++VPhyMuPefFmfqOi543trvrMz8fjW+YQXaUgIP+PpGbGirOCydkJbZvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3495 invoked by uid 109); 19 Mar 2024 21:11:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Mar 2024 21:11:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11654 invoked by uid 111); 19 Mar 2024 21:11:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Mar 2024 17:11:14 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Mar 2024 17:11:12 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ignacio Encinas <ignacio@iencinas.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] t: add a test helper for getting hostname
Message-ID: <20240319211112.GD1159535@coredump.intra.peff.net>
References: <20240309181828.45496-1-ignacio@iencinas.com>
 <20240319183722.211300-1-ignacio@iencinas.com>
 <20240319183722.211300-2-ignacio@iencinas.com>
 <xmqq8r2eneut.fsf@gitster.g>
 <20240319205753.GB1159535@coredump.intra.peff.net>
 <xmqqo7balyx9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7balyx9.fsf@gitster.g>

On Tue, Mar 19, 2024 at 02:00:34PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think you need to lose the exit status. Or alternatively do:
> >
> >   hostname=$(test-tool xgethostname || echo unknown)
> >
> > See my other reply.
> 
> As "test-tool xgethostname" runs exactly the same codepath as
> "includeIf hostname:blah" feature, I would actually prefer for a
> failing "test-tool gethostname" to _break_ this test so that people
> can take notice.

But we are not testing "includeIf" in this patch; we are testing git-gc,
which falls back to the string "unknown". The includeIf tests in patch 2
will naturally fail if either xgethostname() fails (because then we will
refuse to do any host matching) or if it works but somehow test-tool is
broken (because then it won't match what the config code sees
internally).

-Peff

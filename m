Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C90B28F3
	for <git@vger.kernel.org>; Thu, 22 May 2025 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747894177; cv=none; b=SjsdT71sQI/ZK8ZoUqDMrWvxQwt9ioZfLafhVh3m8ou/8d1Eq8FThb+XCwTHlO3tTklvPyjMnPPmAI2f8pXVAlJAHPqElEifTDIWPs+jYGCM6e2uWcYqLN2vYayZ8x4u9kCmXyuXO6+y76AatAHQTxwBIWsqOL9E8Fp7kwo+kpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747894177; c=relaxed/simple;
	bh=RiINSQwB//XS9LqE/3x53FqjyOEUOuvw14SYRw9QCRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BatxKrwKMirIWHGLjWq/UYVJBZ+dFjyxhyLPdXbSu5XsD7t1Y0KeWdOFsgLchjsZoel6/Z29fRIG94r6hDtgiYcpzysjBSTdvbaAZIs8XniAbBKs5qP3Scklm9WYvgEloYEiaq7GGlYYxCEGCDSvMVHWknA0imrvtNixJNODEpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cCCwBurC; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cCCwBurC"
Received: (qmail 31466 invoked by uid 109); 22 May 2025 06:09:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=RiINSQwB//XS9LqE/3x53FqjyOEUOuvw14SYRw9QCRg=; b=cCCwBurC0tPppLCXMB656+D35Onh1ix7lgVaQixfp3KZNTenk/Ry4h32mdziDKw49JGRdD0d6c0ialc8GCLl7dKMAeORcBAGTLUqK0E3kjidqquOZpuoVBle7KktURkaErwI5dZSBY//pmSt3clDpkMYfYzeS8+ZoqcW42feD8d3Np+Ad20nXN2nwxEr+lUzPVFFRTTRX1xjBcFiXFn0yhSIhrW5Mds94yMHJPd8IDPyDsZFepHmP06337dBryJcmvJt8BqjBa04CSbXPdGYoVcyZQiUWkjvSyXPyA/jEVj8szJLVD1zaWondkdno1FVKjSN+2YXT0FjC6OODOmJdw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 May 2025 06:09:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12717 invoked by uid 111); 22 May 2025 06:09:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 May 2025 02:09:37 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 22 May 2025 02:09:33 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH] t: remove unexpected SANITIZE_LEAK variables
Message-ID: <20250522060933.GA1135565@coredump.intra.peff.net>
References: <20250520-kn-remove-unexpected-exported-v1-1-bb60cec57e84@gmail.com>
 <20250522060626.GB1137854@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250522060626.GB1137854@coredump.intra.peff.net>

On Thu, May 22, 2025 at 02:06:26AM -0400, Jeff King wrote:

> As a side note, we do still use the SANITIZE_LEAK prereq in a few
> places, and I believe that it does actually work. It might be nice to
> clean up any leaks in those few spots, though we probably want to keep
> the prereq around forever (e.g., if you introduce a test which shows off
> a leak and then fixes it later). All orthogonal to your patch, though,
> which looks good to me.

Ah, nevermind. These are all due to 8415595203 (t5601: work around leak
sanitizer issue, 2024-11-20). They are leak-free (and the tests pass on
my system), but apparently some upstream bug can cause issues.

-Peff

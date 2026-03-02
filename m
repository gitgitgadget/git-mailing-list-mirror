Received: from newcloud.peff.net (unknown [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECF2334C2B
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772475846; cv=none; b=hUoC05eZE37/7dvt1yZBgBeHvX8x/8konIry9M1qKOLv9OiF6K6GzInSvFJbX8VcDbf1tMTHFs+0CsDVoFDFH4qIUu8fHdy4z+KIVGKAzyfKZl5MS7tdDAPfeyHO8SP7seleAOCLMFNSM5OmcBTIERAxwJMnSbESPXSyWfv9PM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772475846; c=relaxed/simple;
	bh=3mxvBc18N5GNZMU/FjCKcRLkhl9CsJ94j20s/xdrUPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRPFNM4M29akPfEMyGiZH1MzrvjMyDBgR3Mfpp4hFGtPRzgqSlRB86yZG9kkkd1CXEQgUhAJK3TQxNzvfq8TpvZ0Cn3yTVTGFI4y6THtdaF5VTdhHKHz3t1kdyxKPO9OHL/PuklWkyQGBsVhtULWuzv47FDe/gbtPtbphYHQ2EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HQVlMJhT; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HQVlMJhT"
Received: (qmail 29825 invoked by uid 106); 2 Mar 2026 18:24:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=3mxvBc18N5GNZMU/FjCKcRLkhl9CsJ94j20s/xdrUPw=; b=HQVlMJhTkFHK7hCGCUzNj3dIfzCKua2OXtt5z2TmipbenqsDHpofeIgoQFpW2ukmzedhCKh7TH2Obu4GtLpuSbDSViSykrVP3nqInVY6ECRVebHZGg3EjqZro14tEUQJNqdC3oXL7hluA6h6/Uz2rN6kptnOF8TQoNtFD25YM1GmVIP1xmUCrg/SD3Pc65NMnGTKjxmjdGUnVjuviFFOfKjKqF/aZWuygMUVxf6S//gGbGj1L6YnCQuxyttrPfKkMf4UsshdKB2IvOMPRFPjMLJGrv8jrvzMovu5JFmVzVierSIeN1OW73mZvXg00GhOkd7ET98QNc0HgevDAzrbUQ==
Received: from Unknown (HELO peff.net) (10.0.2.2)
 by newcloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 02 Mar 2026 18:24:03 +0000
Authentication-Results: newcloud.peff.net; auth=none
Received: (qmail 334231 invoked by uid 111); 2 Mar 2026 18:24:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Mar 2026 13:24:03 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 2 Mar 2026 13:24:02 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] parseopt: check for duplicate long names and
 numerical options
Message-ID: <20260302182402.GH28275@coredump.intra.peff.net>
References: <xmqq5x7jujqb.fsf@gitster.g>
 <7693799a-91a2-480a-ae3e-29f8eed5b55a@web.de>
 <6b674316-9a6e-4f57-b32c-f1824869ba7e@web.de>
 <20260228105849.GA3626520@coredump.intra.peff.net>
 <7c221132-c2ac-4c6f-9d89-72677a74beb5@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c221132-c2ac-4c6f-9d89-72677a74beb5@web.de>

On Sat, Feb 28, 2026 at 12:28:39PM +0100, René Scharfe wrote:

> > Your other email made me wonder how the sorted-array solution might
> > perform (patch below). It shaves off 2ms of those 10. Probably not worth
> > caring about for "-h" output (which is already spending another 5-10ms
> > to generate the output, versus a normal parse).
> Curious; sorting performs worse on my machine (Apple M1, 1 is 2cc719175,
> 2 is patch 2 v2, 3 is your patch on top):

Interesting. Different architectures, I guess (mine's an i9). It makes
me feel better about not trying to micro-optimize the last couple
nanoseconds, though. ;)

> Benchmark 1: ./git_main rev-parse --parseopt -- -h <input
>   Time (mean ± σ):      77.5 ms ±   0.4 ms    [User: 73.1 ms, System: 3.5 ms]
>   Range (min … max):    76.8 ms …  78.5 ms    37 runs
> 
>   Warning: Ignoring non-zero exit code.
> 
> Benchmark 2: ./git_strset rev-parse --parseopt -- -h <input
>   Time (mean ± σ):      82.6 ms ±   0.3 ms    [User: 77.7 ms, System: 3.9 ms]
>   Range (min … max):    82.1 ms …  83.7 ms    34 runs
> 
>   Warning: Ignoring non-zero exit code.

Interesting that your absolute times are much higher than mine (by a
factor of 4), but the absolute cost of the strset addition is smaller.
I'm not sure if that's another architecture difference, or maybe just
the other unrelated parts of the process startup are more expensive on
macOS (syscalls, filesystem access, etc).

Anyway, now that it is only used for "-h" I don't think we need to care
that much.

-Peff

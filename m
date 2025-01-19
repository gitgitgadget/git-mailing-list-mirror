Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4235419B59C
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737290816; cv=none; b=qHHNV9cOLIcIH3ChiTunpM+pQ+s4dV+D07TkrcwFq+6EBKokW9Mu6IRpPSXCulzNINraRZsJ50hpDaS5z3+ZCAh/QaiM1P/fhLE3k/5N/5tEdupLsoNrKGCbAndPnyPZ7uliINVn+LllTBrMZEFc1rRSprZ2vJeKj7jJh2fE9BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737290816; c=relaxed/simple;
	bh=tsTivyULetAvLiQmVnkpkDpu9YOeiB0NW6zeM8mK5Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWh8d+hvpGvuWqREobTE/r3UXKzH78JBNruB/J+4fkUQcTM64E4BejElco0pRZM3ks+bBjJkk8kY8d1pFPALnzQOYZWFpNHM1D1090b4DWhByXE0kPKzdMFOjPzk3gvF+PA1q7YNuwniy5DzziVtFsU00Wt6HTtXOTMvceamoXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EDYYWUYU; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EDYYWUYU"
Received: (qmail 7480 invoked by uid 109); 19 Jan 2025 12:40:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=tsTivyULetAvLiQmVnkpkDpu9YOeiB0NW6zeM8mK5Y0=; b=EDYYWUYUxlHXMZ0uoN2jp56h9/Y5CkPsYofNBVtIv5x2GDjGZK3nixj2zuC4Wo5wBEty6akxQj2RKpK3g2+BCVoa6Sh4go1fNhnkU97brLYxyaIseoAmUMOupN6wkXwpSlLKvF1vXj7GTHDCu/qul8/ealOdd0DO2vOZCV9WbbQXSOkp3FcOfWLlrbviixCVIt03ai4k3l6kKvM+j1M98Ya77xokzzQycEjhrW/wWee3FdFZ2TMyrCvX5g6qRc6JSLQg2H1e6YausjyJX9Nm8NWXuOYnDfsGv4RLpzjdV8wfEvqBpMFUpVqJlCHVdKSUwfsUOHfVLVURceOHKM4D2w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 19 Jan 2025 12:40:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32323 invoked by uid 111); 19 Jan 2025 12:40:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 19 Jan 2025 07:40:10 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 19 Jan 2025 07:40:10 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Ross Goldberg <ross.goldberg@gmail.com>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ref-filter: share bases and is_base_tips between
 formatting and sorting
Message-ID: <20250119124010.GA1538605@coredump.intra.peff.net>
References: <CAAEcvMovcZucuq4H70ouQzKS=_wHnBi1DqJ-4MMFVXX9XLEciw@mail.gmail.com>
 <6b824f05-6f16-4cd9-85b7-3b8b236158b4@web.de>
 <20250113051700.GA767856@coredump.intra.peff.net>
 <57066d48-ce68-42ec-8e94-4ef6c1eba920@web.de>
 <20250116095128.GA144555@coredump.intra.peff.net>
 <20250116100637.GB144555@coredump.intra.peff.net>
 <20250116102154.GA724126@coredump.intra.peff.net>
 <2fbe47c2-22c0-49ff-a211-057bd96ddbc9@web.de>
 <cb3d6e8c-6c39-423c-935c-db0e8619c504@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb3d6e8c-6c39-423c-935c-db0e8619c504@web.de>

On Sun, Jan 19, 2025 at 10:26:26AM +0100, René Scharfe wrote:

> Am 18.01.25 um 18:11 schrieb René Scharfe:
> > I think moving to the right place in one step requires less churn.
> 
> On the other hand attribution would be more correct if we stacked your
> patches on my v1.  Just don't forget to free u.base.name. ;)

:) Yes, I actually had prepared them on top of yours yesterday before I
saw your email. And I also double checked that you found the leak in my
original. (I don't usually leak check explicitly, but wait for CI to do
it, and I only run that when I do my daily integration).

I hadn't gotten around to writing commit messages, though. So I think we
should go with what the v2 you posted, as it is already done. For
attribution, I am happy enough with a Helped-by trailer. :)

I also like how you pulled the final cleanup into patch 3. It's probably
reasonable to do, as the code is not doing anything useful. The only
thing we lose is that the original had found all of the spots that
needed to call _clear(), so if we later need it again we'd have to
do so again. But maybe that hypothetical author would find the commit in
the history.

  Actually, ls-remote does not appear to have called it. I didn't check
  but presumably "ls-remote --format=%(is-base:foo)" leaked.

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1697E573
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662739; cv=none; b=BTFTIjPVdRm9aUPiQcP3ZovniY1m/bJeyQXbty4dnaKiwSef01pYgV/KLgNgxVOMDKeynA/7LSZUcnOviXtHdsdDU2l6h/NrGzjaNzscS9OEWbfevZ4iqYZOUdqxK9soW0CevxalQK0XxpF6M1UOlv51BpJx/noFTLg31JTkvBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662739; c=relaxed/simple;
	bh=PZPfyEOXZ/ySO6TLcAiwlQesAqcBiX/FrZH1qjCkKvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZJdLwry1F/QuAoR+E3ZaQMhrGgsPnVRj55+I2L+w6ME0SFa0zmsit7RPSkOqwfgzcAaTcBiMZn0qAawl1cPOBtpuWsVR6LXpHGEAuDeP1YFqkI6J6QNdF4/Ixurz0kCA7jDpQcHq0H2R4TlyiCva3zCgUZx6zTXSLKJIK5jkkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11277 invoked by uid 109); 6 Jun 2024 08:32:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Jun 2024 08:32:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6777 invoked by uid 111); 6 Jun 2024 08:32:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Jun 2024 04:32:14 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 6 Jun 2024 04:32:16 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, John Cai <johncai86@gmail.com>,
	Dhruva Krishnamurthy <dhruvakm@gmail.com>
Subject: Re: [PATCH] attr.tree: HEAD:.gitattributes is no longer the default
 in a bare repo
Message-ID: <20240606083216.GE658959@coredump.intra.peff.net>
References: <20240501220030.GA1442509@coredump.intra.peff.net>
 <ZjLfcCxjLq4o7hpw@nand.local>
 <ZjPOd83r+tkmsv3o@nand.local>
 <xmqqfrv0ds7f.fsf@gitster.g>
 <ZjPTlrMdpI+jXxyW@nand.local>
 <CAOLa=ZRe6eWJ_ZyH+HRq=6Lh0-xZ=1X2Z2f3HW4+EVXNquaDTQ@mail.gmail.com>
 <xmqqbk5ndiqk.fsf@gitster.g>
 <CAKOHPA==xgRBLXmyURkdZ9X4LqQoBHYy=XD0Q_KTQHbK54DOFg@mail.gmail.com>
 <xmqqzft6aozg.fsf_-_@gitster.g>
 <xmqqa5jzqd5k.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5jzqd5k.fsf_-_@gitster.g>

On Wed, Jun 05, 2024 at 02:43:03PM -0700, Junio C Hamano wrote:

> 51441e64 (stop using HEAD for attributes in bare repository by
> default, 2024-05-03) has addressed a recent performance regression
> by partially reverting a topic that was merged at 26dd307c (Merge
> branch 'jc/attr-tree-config', 2023-10-30).  But it forgot to update
> the documentation to remove the mention of a special case in bare
> repositories.
> 
> Let's update the document before the update hits the next release.

Good catch, and the patch looks good.

I think 51441e64 is essentially a revert of 2386535511 (attr: read
attributes from HEAD when bare repo, 2023-10-13). I don't know how you
prepared it, but I'd probably have started with "cherry-pick -n". But
that wouldn't help, because the documentation didn't come until after
that in 9f9c40cf34 (attr: add attr.tree for setting the treeish to read
attributes from, 2023-10-13).

Not that it really matters much now, but always just curious about how
we can avoid missing stuff like this next time.

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554381CA8D
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737642858; cv=none; b=cNc/KOIG62+e87P4a+dDBu8qsdGoSjOv1uIWSOVNik3+d7G16k6HYby60ABzD8nsDvRluZYuYGa2xB9TP1/kFGaBtPMxv2/Fa6VUB2EGX4lx7yPk6Wo5RWErUosCpTkWeNjaAVB4N9Jy/2lZSOJpDQfCEEZjNA6+fkSmfOVFAEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737642858; c=relaxed/simple;
	bh=Vhegg9QyQiIzqGSAzaqBouzjgDv25ioPvnrMkn9UFu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Whd3l3Jukiygj3RmmXBpiWmKHIjDoXQ3mMXi/4OSx/cogFlMFeloEYLlCiiz/NNUlIs+546YXUegddBicJnLmmtt1yVtoio6gDBsPCOjeP6b+NtVHPh7rpxvhsmn+DL8vc3M0ssf1CL/OKxX2aeXLIm2O3XJO3VFuIfHOsgNGCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=F2qBjBD2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="F2qBjBD2"
Received: (qmail 28978 invoked by uid 109); 23 Jan 2025 14:34:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Vhegg9QyQiIzqGSAzaqBouzjgDv25ioPvnrMkn9UFu8=; b=F2qBjBD2MeRNujNE2VEVVTcr+MVWUFde5UFJsLo+KRyQVGI5azPLAU0MlBYiNbkLaAiyDTmvLm01zhB+H3mPJQQGkrbr++Aj2VJdGOtn20qDweTrf7E305EOnAhMu3qDwv5IwPAcOE40egE17sATYHlFLVXNy6CTs80QSOFnXLTnNoF42zE9w+S4CAAy9NGIfHoyLy3cIUZxko0Rads/7nr0g9ltSw8Ko8PAs036wPE0UsdYqyw4a6cJBNKhOYF3hcHvVP/wIFcRsoum7tcwGl9qRZjYrA2+Nntuoe/7obFuysqLMQ0ii+5IsoAQoSYfE8GzvQOY7WCX82W9xRpHhw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Jan 2025 14:34:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26853 invoked by uid 111); 23 Jan 2025 14:34:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Jan 2025 09:34:13 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 23 Jan 2025 09:34:12 -0500
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, nika@thelayzells.com, gitster@pobox.com, ps@pks.im
Subject: Re: [PATCH] refs: fix creation of corrupted reflogs for symrefs
Message-ID: <20250123143412.GA3916082@coredump.intra.peff.net>
References: <20250121215235.GA2753621@coredump.intra.peff.net>
 <20250122100319.2280647-1-karthik.188@gmail.com>
 <20250122150222.GA3348514@coredump.intra.peff.net>
 <CAOLa=ZQMhhznFj=QdTgq=ydiPVzFO7YsEzk4VZ7fwn-ZZ=W=bQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQMhhznFj=QdTgq=ydiPVzFO7YsEzk4VZ7fwn-ZZ=W=bQ@mail.gmail.com>

On Thu, Jan 23, 2025 at 03:08:30AM -0800, Karthik Nayak wrote:

> Thanks Peff! I'll add it in! It's now completely your patch :)

:) IMHO the hard part was understanding the implications of the removed
code block and writing the commit message. Any fool can delete a few
lines. ;)

-Peff

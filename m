Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C25173
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754159960; cv=none; b=Shw6dbsCw1xdC8y7lBG74fIt/wHqVCfhMkAUzcuhMIlLCcbHuA5L4XHg8r1r5aK4hKr4eDiNbVkJ2vrBF7yC+ldKMEoiWDP0U6magl03QQyOJgpg4np2rntaA09Oux3LAVmPs9Io147dkbJM9c2z9T8yeYomCihUsNahZAsiPHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754159960; c=relaxed/simple;
	bh=J3q/IQIiuoec9NDMoWZTZMOUq7uaCXXNTVUssehavAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsvovYZeKrfsw+J/1Yo3bMOk5Mch4xYV6xK7wIet6N1anGNI3CPgK6LrBSHvWVTOTfxQI+9LNmgG/jLpMn/lHD6tvWhR1B6xevMZOxSVahNAa6k1B57IK4DfQHIq+l3Ilqi5CbFYDzwtbyH+Or5PGRlune4uTkElvpH81Nf4SuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=B5eABLGa; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="B5eABLGa"
Received: (qmail 13691 invoked by uid 109); 2 Aug 2025 18:39:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=J3q/IQIiuoec9NDMoWZTZMOUq7uaCXXNTVUssehavAE=; b=B5eABLGan1y59OVHP7JAVSIQE4qT3DzRXxZPIR7I7EQ5njBSULwSd9+jg6sB2OPJxlqPlnioLUk/1qkgji+wVGwkphpQDIh3S8EZ7HWcFQIhaEO47FsicfswVQrRddo1p2H4x8ZUo6JRmg6CvhX2zJ4lk2Ef4pf+/Pqwd/ilrvXGsZjei4jBkmgSvK7mMwoUOpFGYZyETHelYwJ2QVm00UcQwXMYWaNBBDD3/Nq5bJn+YgsG8xUW9Xil9zAaERVJXGxYrxAftQADjLMbb0YOSD96huqy+4iRJqCYPAthLm1wdx1+PG8sUDRCiyAHj3f5gms3ZUScBl4lEHfDCCLMAg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 02 Aug 2025 18:39:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19195 invoked by uid 111); 2 Aug 2025 18:39:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 02 Aug 2025 14:39:18 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 2 Aug 2025 14:39:16 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 4/7] string-list: optionally trim string pieces split
 by string_list_split*()
Message-ID: <20250802183916.GB1773585@coredump.intra.peff.net>
References: <20250731224607.3942417-1-gitster@pobox.com>
 <20250801220423.1230969-1-gitster@pobox.com>
 <20250801220423.1230969-5-gitster@pobox.com>
 <20250802082659.GB3711639@coredump.intra.peff.net>
 <xmqqzfchispv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzfchispv.fsf@gitster.g>

On Sat, Aug 02, 2025 at 09:38:52AM -0700, Junio C Hamano wrote:

> > It might be worth defining here what "trim" means. I can think of two
> > obvious definitions:
> >
> >   1. trim whitespace from each split piece
> >
> >   2. trim excess delimiters from each split piece (which in turn depends
> >      on how we handle multiple delimiters; do we make empty pieces, or
> >      do we collapse them? I think the former, which would make this type
> >      of trimming impossible?).
> >
> > It looks like the patch does (1).
> 
> True.  "nm git | grep trim" tells us that we most of the time use
> the word to mean removing whitespaces, but there are exceptions.
> 
> It certainly is a good idea to rewrite "trim()" in that comment to
> "trim whitespaces around" or something like that.

Yep, ordinarily I'd assume it means whitespace. But since the function
takes a different delimiter, a hint of doubt crept into my mind. The
text you suggest would have made that go away.

-Peff

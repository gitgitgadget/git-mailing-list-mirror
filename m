Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C493171E45
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338900; cv=none; b=KHynyl3Pz6RQMkbv11YfKqAT+9Y1uElszZ4acMGX+C9ICZRpiWqSXIbfT7sFOQYBQRhlMI/5F8e661mWsinkbYdc7VUrj9CnVq/QWR5rhAiV3CF2RPltoPn5LK+H3gGP5MPDzPyUpimCUJ3GV4JK/nvnMY3dZHsPUcwHs5/fJbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338900; c=relaxed/simple;
	bh=QcCpXcc3sl73z7SYBfV+LGIVRLz5NgVYY+HS45S8csQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhjYdcMg8D8ZaumORGIoL+ix9szqxEnagktOm92cnYM06IwgjL6phnXhNmbc9Llpi+V6UnXBXaeWO2bV5vGlPC1PbBNrfUNOGp+zcyDWmm6sNrUw36nEyKDhUXpmx56qBpnXFIcYI9cejIL5/TRbOe1TgiN2Bvn0QUJQA8t/7rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18158 invoked by uid 109); 5 Apr 2024 17:41:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Apr 2024 17:41:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30876 invoked by uid 111); 5 Apr 2024 17:41:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Apr 2024 13:41:37 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Apr 2024 13:41:36 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: free and errno, was Re: [PATCH] apply: replace mksnpath() with a
 mkpathdup() call
Message-ID: <20240405174136.GC2529133@coredump.intra.peff.net>
References: <df774306-f29b-4a75-a282-59db89812b9a@web.de>
 <20240404225313.GA2512966@coredump.intra.peff.net>
 <14c99998-cc4a-4581-aab3-607d7fac7edb@web.de>
 <20240405173517.GA2529133@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240405173517.GA2529133@coredump.intra.peff.net>

On Fri, Apr 05, 2024 at 01:35:17PM -0400, Jeff King wrote:

> With the patch below you can see both in action:
> 
>   - hyperfine seems to show the git_free() version as ~1% slower to run
>     "git log" (which I picked as something that probably does a
>     reasonable number of mallocs). Frankly, I'm still suspicious that it
>     could have such an impact. Maybe inlining git_free() would help?

This may have been noise. Weirdly it seemed consistent from run to run
using hyperfine. But switching my CPU governor from "powersave" to
"performance", I got a run where the new code is fast.

-Peff

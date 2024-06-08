Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA3E29414
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717836206; cv=none; b=hC7g9a2DfQrd21688vtTu7kf4/xocgX/xeOW70L+rqBhIBYkXVFbttrTfAMumbfs1m/ZOoxhQ6hfeDMWGkcJfwUc8jBwdt+RvUdRtgko4wt2NZ6eUm1GFHpZLALTs7FvHCsUgBb8YjAmvtH7kOWbpTubz/bUou7t45XeiiNHB8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717836206; c=relaxed/simple;
	bh=Xq0uObJqvE4Sf/zC7Hnw24+sw8X1CqtnjV6BK01e4/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENDlvUqdLac5vd+ElpZ7XM5rhxI7CQHLZt6RW8JKYn6ik3szB3tEz7ZvCxKw9J15lrFRph1J4wSLqUUp3NEOOAfvnTsy8oLg+vstUjwmTrjQR5eIIwuxymOekY8pjqXeKEdI5RbGORsBCFJWqGBSOUlwsSVc8pLR9GpxHJMGptA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7387 invoked by uid 109); 8 Jun 2024 08:43:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 08 Jun 2024 08:43:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28675 invoked by uid 111); 8 Jun 2024 08:43:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Jun 2024 04:43:21 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Jun 2024 04:43:23 -0400
From: Jeff King <peff@peff.net>
To: ellie <el@horse64.org>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
Message-ID: <20240608084323.GB2390433@coredump.intra.peff.net>
References: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org>
 <0be201dab933$17c02530$47406f90$@nexbridge.com>
 <fdb869ef-4ce9-4859-9e36-445fd9200776@horse64.org>
 <0beb01dab93b$c01dfa10$4059ee30$@nexbridge.com>
 <200c3bd2-6aa9-4bb2-8eda-881bb62cd064@horse64.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200c3bd2-6aa9-4bb2-8eda-881bb62cd064@horse64.org>

On Sat, Jun 08, 2024 at 02:46:38AM +0200, ellie wrote:

> The deepening worked perfectly, thank you so much! I hope a resume will
> still be considered however, if even just to help out newcomers.

Because the packfile to send the user is created on the fly, making a
clone fully resumable is tricky (a second clone may get an equivalent
but slightly different pack due to new objects entering the repo, or
even raciness between threads).

One strategy people have worked on is for servers to point clients at
static packfiles (which _do_ remain byte-for-byte identical, and can be
resumed) to get some of the objects. But it requires some scheme on the
server side to decide when and how to create those packfiles. So while
there is support inside Git itself for this idea (both on the server and
client side), I don't know of any servers where it is in active use.

-Peff

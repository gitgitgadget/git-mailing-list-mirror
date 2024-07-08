Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1F18C06
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720481633; cv=none; b=d9I2Nl6lKJjmC1evesZXZ4HAaSHY437XdROt2Gz7MbkBmGdQobkk0E56X0GrWU3Sfy2aXdG0Yrq7uT8tTHn6N56g0zAl56Gm9ioaHCp3qWZsJTMy6xfsn9gNTKLO64bfzKc4tN1FJwESsSJO5ENdV0UhnFCuJnZUT86YxTJQDQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720481633; c=relaxed/simple;
	bh=/tsFALIF0y+LlABQO35BAaAAGzKJnPCk93SI+tK5KBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkDxagfXDuKL0sjDtxAQ01rLc4q6FEm+++hdHXgM9QhjOXLdvzBpsqrJkqLb1gExEaz6fK0ZvS2/KQRP+bvrmNoMa5lTC4noG5vcFUX4jx125nyObW5I6V8bjmy7J1yBPbQmCtpbuzSG/Xq2++XPXQk2BnYJVu109pZN+8pVhy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19961 invoked by uid 109); 8 Jul 2024 23:33:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Jul 2024 23:33:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28073 invoked by uid 111); 8 Jul 2024 23:33:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Jul 2024 19:33:49 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Jul 2024 19:33:50 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] builtin/push: call set_refspecs after validating remote
Message-ID: <20240708233350.GA948906@coredump.intra.peff.net>
References: <20240708140350.622986-1-karthik.188@gmail.com>
 <xmqqsewjelrh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsewjelrh.fsf@gitster.g>

On Mon, Jul 08, 2024 at 12:17:38PM -0700, Junio C Hamano wrote:

> > This worked earlier since we would get a remote, albeit with an
> > empty URL. With the new changes, we get a NULL remote and this crashes.
> 
> You'd really really need to clarify what you mean by "a NULL remote"
> if you want the proposed log message and the change to be
> understood.  The change made by 9badf97c (remote: allow resetting
> url list, 2024-06-14), as far as I can tell, can make the strvecs
> that hold URL and pushURL in a remote structure empty, but it does
> not otherwise destroy the remote structure, or nullify a pointer
> that points at the remote structure.  So I am completely lost here.

I was somewhat confused how it could happen, too. ;) I left more
comments elsewhere in the thread, but the gist of it is that an empty
remote name confuses the "when there are no urls, fall back to the
remote name as a url" code.

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63521E008B
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 23:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752015742; cv=none; b=Dbq5T3ezMhhapf/7uMqVeETw3s5a6MCXOJsK+VkE1Yo8EApE3b8hCPEcEMH1Xw1/riF4jfUWrUwCkgVNN2LngNRr1n/6t/ianhEIefNCKHXlsGWfNgr2Od4H1zQMQiBS8zhOX+Wv0QP2S0wWzsANEY+NSmQuYomKffAismAPjNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752015742; c=relaxed/simple;
	bh=0KFdHXuIvQtKzWESwwATEZ8smqH5QmAQkpDFtcnmVKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujQWIcO/b3gMy1mIveizXh3yMkQS4KkdOvB17jilL0eu1PMqKGrNPvOnvNxpDeeENkCjUskPUAgsiuD/LpHlVT2D8HgBr36na/850bURy9FD72l+Rqyb+HFB6w539YSLU7JQZ1TYNE1IdSymq5aPXPYBBV8iF4rJb5F00Dxi9eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SkePL0kE; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SkePL0kE"
Received: (qmail 17215 invoked by uid 109); 8 Jul 2025 23:02:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0KFdHXuIvQtKzWESwwATEZ8smqH5QmAQkpDFtcnmVKA=; b=SkePL0kEYC5IZKQYIIHBiNZjNrprNnKpd0R9teSBTCc6Hr6nmyg7AouH3rQlLAx5H2ejlLBYHjzxKr4hVjvV3kvRF4KmzxVwkmh5i+uULn97o5reYb5+mZgsqIAW/24FTsmdZ8YeXQ3JbRTJQjwwpv6aXwdVWss4eEyUp/OcK/uvOkHnXQoGOp0BHOHyPDsOx2r8/IAC8eW+joQTGJpb8SeNtDyPWyD0QhMDkezmK8In8RufJPzDlbrPM38cH+DZv+Ld0qyATu8ZgzDCl9gBXrqMlLzO95vQiuPEiTfctDovD+RPBvO3JkBmZka/dIJrm6IR+9alUZTmsSd/knYgfw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Jul 2025 23:02:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30658 invoked by uid 111); 8 Jul 2025 23:02:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Jul 2025 19:02:21 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 8 Jul 2025 19:02:17 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Per Cederqvist <ceder@lysator.liu.se>,
	git@vger.kernel.org
Subject: Re: [PATCH] remote: detect collisions in remote names
Message-ID: <20250708230217.GA1185024@coredump.intra.peff.net>
References: <CAHx6-Um1dq0xJ-RkW+qXe=sEa6JGViSJxjzNw56u55DHLYoT2Q@mail.gmail.com>
 <20250705165750.GA1951664@coredump.intra.peff.net>
 <20250705185842.GA2496172@coredump.intra.peff.net>
 <aGuP3Q5xykmRNp0m@pks.im>
 <20250707202801.GA3115893@coredump.intra.peff.net>
 <xmqqtt3n3e7g.fsf@gitster.g>
 <20250708225946.GC1180568@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250708225946.GC1180568@coredump.intra.peff.net>

On Tue, Jul 08, 2025 at 06:59:47PM -0400, Jeff King wrote:

> Although I think we're all a bit lukewarm on the concept, I feel like it
> won't hurt anything, isn't too much code, and disables a potential (if
> somewhat rare) footgun. So probably worth doing?

> -- >8 --
> Subject: [PATCH] remote: detect collisions in remote names
> [...]
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Subject: [PATCH] remote: detect collisions in remote names

Sorry, I am apparently bad at using my editor.

I _think_ this will just apply correctly for you, since the duplicated
commit message is all after the "---".

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2F41E32D9
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128789; cv=none; b=dHaF24onhV7xhCwiIgq0iUDkZRbQ7tS/Dc+pFuc5wRRLptPxR49VEC2JHxhKdw9zV30dWpgZ5bPt+q/cASUJTnvBJ5eg35mTzGbbomqBRhUDps3vm+JbY3b+cXaGfspMasl05972SLQrymTr5aXRM5TS5mFnGvz/uPMc8J6jR8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128789; c=relaxed/simple;
	bh=sFy1HaxgH1WxeGOLAZXY4hXGplqj8AxWC8R1zcYUf0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dgy2coxosqyAUvyDtV5RXNVvmzFrTNBLLCj1fKCVbiwfroLLthv0dStyH8Dq63ZHQwp40vf+rWmtOfz37M7Lw0RK/CIw2MEFWkU+ySvXlH/OQRj9Ca5Mb24GOrBacs07No8lXPiS89CcFneDTtGehinnZvqC3GOT6B5kfGmtZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SMk50ByD; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SMk50ByD"
Received: (qmail 4189 invoked by uid 109); 21 Feb 2025 09:06:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=sFy1HaxgH1WxeGOLAZXY4hXGplqj8AxWC8R1zcYUf0I=; b=SMk50ByDxfVrzvJSFiwKFdYAvii1abqpWXIkDkZ6OPFhE0BhVnPyo1tf6jhKc+rev50eQ7+qDcsFm19xq9/U3cYg7ViHSkysfODFicmM0pDkh6iqB2brQ+UsxBjtse14oyQXEW7pMiZgEekDC+SUuvYa6DT/eMqRW3GOX1/lkXPUEJTD5O4tIgKHwqB60Szct8bD4zIaeECQZu6L5hzRkHl9T3co0YqOKQNIQpooVOLdi4yjv07xhn6rJBwj/Q/xiX5QT5xEyjepu47su+4pPlJn1hq4YR7thfoBdYiu7ywgOzj7sg7ECV9o4adKN6s9GSehBtLWZ4lLJgh8+D26Rw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Feb 2025 09:06:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31965 invoked by uid 111); 21 Feb 2025 09:06:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Feb 2025 04:06:25 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 21 Feb 2025 04:06:25 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 02/16] object-name: allow skipping ambiguity checks in
 `get_oid()` family
Message-ID: <20250221090625.GA2518234@coredump.intra.peff.net>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
 <20250219-pks-update-ref-optimization-v2-2-e696e7220b22@pks.im>
 <20250221080003.GD1988395@coredump.intra.peff.net>
 <Z7g69C7Y-CXIUrRn@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z7g69C7Y-CXIUrRn@pks.im>

On Fri, Feb 21, 2025 at 09:36:04AM +0100, Patrick Steinhardt wrote:

> Spoiler alert: I do have a patch series locally that gets rid of the
> global variable completely, and that series builds on top of the new
> flag I'm introducing here. So I'd prefer to keep it so that we can
> eventually have less callsites that rely on global state.

OK. I do agree that getting rid of the global would be nice. I just
wasn't sure how ugly it would be to pass the flags through the stack
into handle_revision().

-Peff

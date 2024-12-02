Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FDD1DA31F
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733171867; cv=none; b=r1AA4tCMUYDFlCRtt0NpDfLNzjlQ+56v89lOCDYkOFo+dxF3fHwQS2QWVygYkFlhZAbB3M6YYVlOG6cofjKdq0iwfSCsY1je+t2RZzfHdSyH1DKz9JWRrKzHLs3JhAGH3o9GPh3HFpJnCvkDkQngCRV8rC9Ez+NEpNgkOIxmkqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733171867; c=relaxed/simple;
	bh=qjkDF+fLc6xtbR8bEQyqV/3TSGzVRbSXPEOhwQQJ+bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eg6LUk9ujk4PpEmq+Ldec4GsiU/INq0r7C5RqIFDKSWkFtED8C5RAnkqX+owlnJR8EgUldgDw6blo+wzWbM3ecO2waotgxHbDU1wONnGJANox2c28nwOPv/BsKYLj5iwCrpWDzE9BO+EV2Phtut884tXhKPA4uQ46kpjPlapHqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ADnPjfHb; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ADnPjfHb"
Received: (qmail 16612 invoked by uid 109); 2 Dec 2024 20:37:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=qjkDF+fLc6xtbR8bEQyqV/3TSGzVRbSXPEOhwQQJ+bA=; b=ADnPjfHbxSVYe0fVqHh7Ca4gqnf18CE7Hxd5vQs0Oh543wiFbkBjY/+8am7iVGM7R9Y6O6M9k/cJn2hKHEu/jxaPfsEYe3/PpNHdwMgxqUusQ4pf95zs0Cnx6w9YB67oNewNMuj7is+3a1RUr1coACcINwFKdZ2UGBwAkq1Drv9LR7se3xC2eZzKMNupCn3Fc26NJ5J80NxNETW4n7fAj9+Tf7/dCsWBHLD9Id6ONpvFfgI7VCnoxhj/smdeeddEdnmD7sSJdxx8+eylanF1lTYDHVWByJTXsoxrhWwraMsbxHC+1TT+5YkIkzMluxknGLncP4nEEZ4pxMP9nvCfAQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 02 Dec 2024 20:37:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26175 invoked by uid 111); 2 Dec 2024 20:37:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Dec 2024 15:37:43 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 2 Dec 2024 15:37:43 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, git@jowil.de
Subject: Re: [PATCH 1/4] refs: move ref name helpers around
Message-ID: <20241202203743.GB776185@coredump.intra.peff.net>
References: <20241202070714.3028549-1-gitster@pobox.com>
 <20241202070714.3028549-2-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241202070714.3028549-2-gitster@pobox.com>

On Mon, Dec 02, 2024 at 04:07:11PM +0900, Junio C Hamano wrote:

> strbuf_branchname(), strbuf_check_{branch,tag}_ref() are helper
> functions to deal with branch and tag names, and the fact that they
> happen to use strbuf to hold the name of a branch or a tag is not
> essential.  These functions fit better in the refs API than strbuf
> API, the latter of which is about string manipulations.

Wow, they are declared in strbuf.h but not even implemented there. So it
was doubly confusing. This looks like a nice cleanup.

-Peff

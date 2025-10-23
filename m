Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4542264C4
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226489; cv=none; b=JKJohOuWznzKJDJJ69NUhIlV7XSKwhB2w+fhAMQuz8k7nmwXtBj1xdk5s7sd+Jw30H+dRIePuM66/whfoxgdOAJIfEwibY64WuQBvbhPs7BwgFQWxG+/XnhPOVx0CWy6NaEYZ/ymlMlK0b8OQtlNkK+eoF3RDqLOhPIWSdX15IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226489; c=relaxed/simple;
	bh=j4lVK67sxLdYsbOVdkGePgIWB3GLS+gF/tQ0hHeUl8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWHzRnBFJPkvamLdlnfaSYizj/yyS6/JB39YKGH3wQJLxjMgX2QDwi7CVOYHNPD6sM/wI0yW0TZzAJRXRr6UDG3eAQedqWuHAtkXlHUoC5BAfa7MUHKlVsCtUOjWYI07Yaj0vKkk5N3yiv3oXx9HOwwxHV8F8kYaj8OMw0Eh3D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bsAI6Bl2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bsAI6Bl2"
Received: (qmail 316039 invoked by uid 109); 23 Oct 2025 13:34:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=j4lVK67sxLdYsbOVdkGePgIWB3GLS+gF/tQ0hHeUl8Y=; b=bsAI6Bl2ye22Wugn6Wl8mqPII6TL+AbWfYSw23cgeTwsnM65wQPD2Yn1/63VWaHkCXuuxCPNxbektOajGwUkMr2QfU2hZ1Mn39apXegFHVf4hY4GMy/XXm7RpOYw31BoCxIN8CST5DjzKqhieIm/+GWemRL7eor4NaxQ63rsLgEZ/28cvezi8CawLW5egsWOUa9O0rk95bYdRE7VriCa8LxghoM3ZuafJtIcDjDirrAm9ZkuA2FtC9cWFrpEg+crhbHvzZMALkB7pkiQx4g2Vn83HME7tHUKBHv8R3yRmltLbrPc7g3mhDQdM3ax3XCV6afmD8XIlRaXOENpfetxRQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Oct 2025 13:34:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 491663 invoked by uid 111); 23 Oct 2025 13:34:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Oct 2025 09:34:46 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 Oct 2025 09:34:45 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Lauri Tirkkonen <lauri@hacktheplanet.fi>
Subject: Re: [PATCH] t7528: work around ETOOMANY in OpenSSH 10.1 and newer
Message-ID: <20251023133445.GA1171431@coredump.intra.peff.net>
References: <20251023-b4-pks-t7528-ssh-agent-socket-name-too-long-v1-1-f15eeec199f3@pks.im>
 <20251023124320.GA1163932@coredump.intra.peff.net>
 <aPoslANELg4V286u@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aPoslANELg4V286u@pks.im>

On Thu, Oct 23, 2025 at 03:24:36PM +0200, Patrick Steinhardt wrote:

> In any case, I'd say for now we should just fix the issue in the easiest
> way possible, and we can then follow up and make this more robust in a
> subsequent patch series. WDYT?

Yeah, I'm OK with your patch as-is.

-Peff

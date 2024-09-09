Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFC718CC0D
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 23:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725923015; cv=none; b=KgqGGsljD6HzTthJDjcjHL5x8+FSegcoj6OO1ULxgHiW+uPgUQgy2BJQ1NIxOGGnZgOuiuZXOt7Lm9MNJwWDI4DWLUYsDjL+i258aIJc4Zs6MPuImDfKBlOZ7dOpvcGs81hjaX1WHew6PeTidSwezgqBCNSVvBlrOFGgN1UvXwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725923015; c=relaxed/simple;
	bh=K7T4nCFBeLmeTl+dyPb0kQhp9n3uQvRSOHRHzffg7pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHiiXZNlRE+gwD74nYTmTiE9mg2hOojt/IreuCXbTpcu4imtFBgEzab5JpsUfFI9QOjWjR7S+VnNuE0X+6yQdkXwRPRvY2G1/HmWLqTWiXwBjOnrUgCyrdqUco/NY9ZokFQCVi3W+fqKx4E12RyIkdUrTxa2I1sMDNBPoWzDQcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 32163 invoked by uid 109); 9 Sep 2024 23:03:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Sep 2024 23:03:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24794 invoked by uid 111); 9 Sep 2024 23:03:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2024 19:03:31 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Sep 2024 19:03:31 -0400
From: Jeff King <peff@peff.net>
To: Brooke Kuhlmann <brooke@alchemists.io>
Cc: git@vger.kernel.org
Subject: Re: Fix issue with formatting multiple trailer keys
Message-ID: <20240909230331.GA921644@coredump.intra.peff.net>
References: <EF5AE27D-B7CE-4337-B928-6073837218CA@alchemists.io>
 <20240906223402.GA1221600@coredump.intra.peff.net>
 <5A3FD50B-46F1-4000-8AAD-895A4CB4F33F@alchemists.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5A3FD50B-46F1-4000-8AAD-895A4CB4F33F@alchemists.io>

On Fri, Sep 06, 2024 at 05:09:08PM -0600, Brooke Kuhlmann wrote:

> Use of a custom separator is a nifty trick. Thanks. A little
> unintuitive but works. Definitely would be neat if you patch this to
> work without the custom separator, though.

The separator will always be required (even if you use multiple
%(trailer) blocks), because it overrides the default of terminating with
a newline. And we can't switch that default without breaking
compatibility for existing users.

So I think after my series you'll have:

  %(trailers:key=Files,separator=) %(trailers:key=Duration,separator=)

or similar.

-Peff

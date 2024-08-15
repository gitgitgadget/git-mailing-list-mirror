Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B066215C3
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 00:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723682579; cv=none; b=YiKP0JNcNaLS/SPunkB8+Lpbw7OA7OXhO+696qUB0i9v1DW253y7iW/RYxf/tJPftp8IUB+zoBZy8krwgadbJZz470UuLdoeYd1XIy6fwJdG/fgBCFiy0NVXK4l7Dr5/lqyuahvlg4rZ3ZsWhVDXBWoB7HAX6+TFbTu5yu6Tu3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723682579; c=relaxed/simple;
	bh=dStVIXjsLetWpu/zEIi5zkxObaKyjtQItULwiYc5Srs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ro/IQjHnU2MQuGofJBjoUfGmPHE8aePlMvpKPQ2oceLDk2tK/jTfEB5MxTSTDzsc4glKLFzST+MEi/SHTj9OkRkEPz8n2RqLhsPnOwl80oEeShkq//3OKZQFYN8UL4we8WkTLetOA5qNn7VtFjPCTx3tENEr/yL0MhJxVlEbkK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20056 invoked by uid 109); 15 Aug 2024 00:42:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Aug 2024 00:42:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21287 invoked by uid 111); 15 Aug 2024 00:42:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Aug 2024 20:42:52 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Aug 2024 20:42:48 -0400
From: Jeff King <peff@peff.net>
To: Geoffrey Thomas <geofft@ldpreload.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] git jump: support show
Message-ID: <20240815004248.GA2629889@coredump.intra.peff.net>
References: <20240814200709.53450-1-geofft@ldpreload.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240814200709.53450-1-geofft@ldpreload.com>

On Wed, Aug 14, 2024 at 04:07:09PM -0400, Geoffrey Thomas wrote:

> This makes it easy to go to the changes in the latest commit, or a
> previous named commit, to fix a bug and commit a fixup, to respond to
> code review feedback, etc.

One trouble with this approach is that you're analyzing a diff whose
endpoint is something other than the current working tree. So the line
numbers in the diff do not necessarily correspond to what you're going
to open in the editor.

For something like the changes in the latest commit, I'd usually do "git
jump diff HEAD^", which I think is strictly better than a "show" on the
latest commit.

For looking at older commits that doesn't work, though. And if they're
not _too_ old, then you've got a reasonable chance of ending up
somewhere useful. So I'm not opposed to this patch. As Eric mentioned,
we'd probably want an update to the README. And I think it should
mention the caveat that the post-image of the diff you're viewing won't
necessarily match the working tree.

-Peff

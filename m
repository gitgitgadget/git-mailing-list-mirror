Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172D5B665
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722117535; cv=none; b=kBTRGLxuhLA8HR3k6+cvCfw8BQCvTJ20sk1C6n6N3vTB8cA9ngGXVDNgVBSk1yj674PqQpQvORQaI6gLKN7wurdnB2Id9iER4rtrzoohDTSkaGBKYr4PbQIiAKyRsX8NRxWUBgktZE8/l0MfhnkyidfFsZSYoZ1YmKW3/Y5Luqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722117535; c=relaxed/simple;
	bh=9sTclyesW2Bss4frn93WKN4wjfD7y4cZ++cVJMcs9cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZADfuziNWqzniB/Sn8HKqClm2b8dOW7M8FdKsWvf3HFhX5Gkp5cR7GTXoDqRh4hnf6bNgFk4tY55jNW0lu0Uvt/ICiHasHzRDTRLrqLMFLGfczrTNyr4lNBB6iMwkwZsJkNuUHgZOHqRE/OJVVMpxwxAOJ1Fr1FMrkoGyB58o44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3917 invoked by uid 109); 27 Jul 2024 21:58:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 27 Jul 2024 21:58:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17989 invoked by uid 111); 27 Jul 2024 21:58:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 27 Jul 2024 17:58:48 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 27 Jul 2024 17:58:45 -0400
From: Jeff King <peff@peff.net>
To: "W. Michael Petullo" <mike@flyn.org>
Cc: git@vger.kernel.org
Subject: Re: Git clone reads safe.directory differently?
Message-ID: <20240727215845.GA1263246@coredump.intra.peff.net>
References: <ZqUc8DJ1uKcHYlcy@imp.flyn.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqUc8DJ1uKcHYlcy@imp.flyn.org>

On Sat, Jul 27, 2024 at 11:14:40AM -0500, W. Michael Petullo wrote:

> Glen Choo's commit 6061601d modified Git so that safe.directory could
> be set on the command line using "-c". It seems most sub-commands work
> this way, but not "clone". Here is an example:

This is because upload-pack, the server half of a fetch/clone, is run as
a separate process which does not accept the client-side "-c" options.
See this email for more details and a workaround:

  https://lore.kernel.org/git/20240529102307.GF1098944@coredump.intra.peff.net/

-Peff

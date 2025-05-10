Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBF921B1AB
	for <git@vger.kernel.org>; Sat, 10 May 2025 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746897678; cv=none; b=BV3suhLZE4AZlrK1z/5Eg2V3sP+TGIa9qz+U9IPPTi89lybwYNZr54xumgSW5hbd423AR0vq1tdaQXHBMis+tep40mpeXzEfa2VtR9RxPZ7WZIgD5pVAIrGXA6azD52kMknWOp5cdiSFVvbaPafS1kEtobqEgOJPB8RjfNR3QnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746897678; c=relaxed/simple;
	bh=/NR3SEAhqcohhv9qQb92CgKdcOvlb9c2kDZ5eKnc798=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMVdo4StRDEylbUUKQ0OFZlAIZAh/6qi0kgkrP4gntWAOAG9/WKeW5Stswq8aDTplsafKVn2X/I0d82sDCiWUSAj9jZHtAI5AKKaGHlBbxusb9nyrwKaoz4yjQbqsFxXtZlf0AeBoVNjVMceDVtj5YIiW+eZG2Ai1MHiZwwcRds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=V0VgCML8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="V0VgCML8"
Received: (qmail 15106 invoked by uid 109); 10 May 2025 17:21:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/NR3SEAhqcohhv9qQb92CgKdcOvlb9c2kDZ5eKnc798=; b=V0VgCML8ePoYBsdSBMxWn+NlOI4hr5uXMWHRYAfqHJGmFL153J8SKT09ZPcpwTlQu9uogdH0KfXT+IQYDO1bepefYz/2VHBscflgFyeKrwXV0g7hrzMb1IBne7iFCim7bfM8tXiJ8qtJMxsKKJdRacW1EElM1roDHPb64WTYfJWYuSQy81Zc3SBKPkEdxRpP/4ngoWIVbelCKe6iqBMlE5Fx45gr5mMTuOMpQ0eVVI6QTaCHUYzwgicdASCkzIpmoRSuQ5b1GPF1BvzSvWKk1NznbQllv0C685CxlwEz8Li8FGuGQyum9424M7CgwmRqDTRYz3+Nta5bBskbuW5e4A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 10 May 2025 17:21:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14174 invoked by uid 111); 10 May 2025 17:21:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 10 May 2025 13:21:08 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 10 May 2025 13:21:07 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 4/4] builtin/stash: provide a way to import stashes
 from a ref
Message-ID: <20250510172107.GA601540@coredump.intra.peff.net>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250508234458.3665894-5-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250508234458.3665894-5-sandals@crustytoothpaste.net>

On Thu, May 08, 2025 at 11:44:57PM +0000, brian m. carlson wrote:

> +test_expect_success 'stash export and import round-trip stashes' '
> [...]
> +	git stash export --to-ref refs/heads/foo &&

Here we export to a name in the refs/heads/ namespace...

> +test_expect_success 'stash export can accept specified stashes' '
> [...]
> +	git stash export --to-ref bar stash@{1} stash@{0} &&

...but here we are writing to the top-level .git/bar. We do currently
allow that, but there's been discussion of locking this down a bit
further (requiring BAR or even BAR_HEAD at the top-level). Should this
be refs/heads/bar?

> +test_expect_success 'stash can import and export zero stashes' '
> [...]
> +	git stash export --to-ref baz &&

Ditto here.

I noticed because I have a patch series from last summer tightening
these rules (it got derailed by some conflicting work, and I've been
meaning to pick it back up). I can certainly adjust these tests as part
of that series, but if you're re-rolling anyway, it might be nice to do
it now.

-Peff

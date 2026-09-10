Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635B7466B57
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056184; cv=none; b=jF4OPmW9dQKbyDCG/U4+ZzpdS7E5bqjhHXSHPwhzk2cJSW5oTn58crHdZlsO/c4a/rFMtw3X7vePuZNqvJmNkM2iKChkImo4nimD3thZQs59QSJyLT7O6YR6GySga9AF56kGNCldkI2XwgVa8C8bOErPlkri1HGvJrA+k1DM+HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056184; c=relaxed/simple;
	bh=Y1LrsuYr4h6Jp9ZdUF7HWH2xxCfqRnbuCa9c0FpfsUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIrrIW0Y9KPYJrWqep1+/9WdEGoHxLkY5tQHy6OlhqttCEavyH07x+vorXSoRrtAAScyDQUytAzwKOYMe0plG8K2C/pSEmJNj4BxquFsJ8Pj6tGh50qIHTtRLZSx7w0vTamEGnoqku7ytOr6E/bd3eCQUWeQlHIJ0M9OsBqlxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SsRDBBFU; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SsRDBBFU"
Received: (qmail 31160 invoked by uid 106); 10 Sep 2026 16:02:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Y1LrsuYr4h6Jp9ZdUF7HWH2xxCfqRnbuCa9c0FpfsUM=; b=SsRDBBFUbTBjH8dmpWmHpeikJyOx5HO9fWcxwHK++h8X2rEHsTDyPH+lAT79snC9XhoJm3o9msWE5UMBaYQYz8zDbrXL8jFFmHHb1ElGFSdc6N5Z/FiRVvxlfYW9m68CwOZxAZpzCHNPcH7Kjropz0F4d0LX/TerP0o0GBcvA3ofOA4EEHcgxKiXSS9Q5X/P/CUAWSVT7pN0JYejm70SsF259fUz8r5fdJTxXtzc15p30t5HvyDaIsBo++ww40gyjodUn00Nhus1dgfIT0RhXIqJy5hRtGxc3YVINn6m7isqoR+0wTtlXuwn0IaaABQvy20RrF75Tsq51D1EPM9dow==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Sep 2026 16:02:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 157237 invoked by uid 111); 10 Sep 2026 16:02:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Sep 2026 12:02:54 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 10 Sep 2026 12:02:54 -0400
From: Jeff King <peff@peff.net>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Patrick Steinhardt <ps@pks.im>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3] builtin/history: unuse the commit buffer after use
Message-ID: <20260910160254.GB251185@coredump.intra.peff.net>
References: <xmqq4ifxgree.fsf@gitster.g>
 <20260910150021.348548-1-kaartic.sivaraam@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260910150021.348548-1-kaartic.sivaraam@gmail.com>

On Thu, Sep 10, 2026 at 08:30:15PM +0530, Kaartic Sivaraam wrote:

> Changes since v2:
> 
> - Tried to improve the commit message to make it more readable (hopefully).

Thanks, the patch looks good and I think the commit message is accurate.

I probably would have written something much shorter, like:

  Every call to repo_logmsg_reencode() must be paired with a call to
  repo_unuse_commit_buffer(), or we may leak an allocated buffer. We
  have such a leak in "git history", which we can fix by adding an unuse
  call.

  The leak-checking tests don't detect this because we only allocate a
  fresh buffer sometimes: when the message is reencoded, or when we had
  to load it fresh from the odb (e.g., because the commit was parsed
  from the commit graph rather than the object contents). But you can
  see it by running:

    make SANITIZE=leak
    cd t
    GIT_TEST_COMMIT_GRAPH=1 ./t3451-history-reword.sh

I'm not suggesting a v3 with this wording, as I think there are
diminishing returns to polishing commit messages forever. Mostly just
food for thought for future patches. :)

-Peff

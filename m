Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA0B282F1
	for <git@vger.kernel.org>; Thu, 15 May 2025 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339990; cv=none; b=nXMMp0LIfw8Iw6FOTJfMdBDfJQHBI1PbSEYAUZowUS4TLVN5rSKukgezL9Y5Jj1lDW9DUleYZc6vL6H4jMVrK7w2bnmq3S2V0lr7r70fK/2qyZgB4CG3I2iqxHRMoLYeK1XUbGbc/8ye7eUwG6RVAiMewc26mdt/a2G6u0wqxTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339990; c=relaxed/simple;
	bh=fKpE1relsS0pwN3FaH3k+JDIH5+OKYBnLzTOqBwcWYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2iFVPtjIYg4INAZLH3vIbOoSVQBn6gHvANl8+iyMD5jszd8C3O1GEU0nkqtn7rXvlWLH5ctH8Td9HKDSKIp0oA02C+kJTtExMB8rhb5K3R+1MmDqWx42srLcbV1n8ars+fL5vTJPo0PMPFYBDl3ZXyRFR6ElFu5ZbKdnWdiuSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=V0BfLRzh; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="V0BfLRzh"
Received: (qmail 787 invoked by uid 109); 15 May 2025 20:13:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fKpE1relsS0pwN3FaH3k+JDIH5+OKYBnLzTOqBwcWYw=; b=V0BfLRzhMsASA7rRHyWd/CcKZ3xq/GrTq2SkNSFpeO/B+H7qUH0pPpPfzS3eEzNBScsrhtgiQS7VYeKFWfD6u3DBQlfeldyaKIpVk1mGWV3/Jf8nMTwogxj75D8PDq+6G/tE3qcikHB+k2JLe5xR08cdBMxsIyVHwWMXlhPxHY/UEB1zWjHXciYngx6ykOdJsg3RsartheymqoRQ9Bcy3LYoZ2Lyy0sZfCayviL6GAyEKbE8CZ6yMMo4KcB9p3F8yWw6ZSfVZ/r6ngVgGM7gTjL4WQjQyw5kSl26l+JG3KmGvXLyWTJS1wm16xi1NztOnwTMqqWaaaCyTl9u0PtlgA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 May 2025 20:13:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30697 invoked by uid 111); 15 May 2025 20:13:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 May 2025 16:13:09 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 May 2025 16:13:07 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 07/11] Avoid redundant conditions
Message-ID: <20250515201307.GH3320240@coredump.intra.peff.net>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
 <7d92e08b0c06a546ffd937c333b97d2fb6cd9817.1747314709.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d92e08b0c06a546ffd937c333b97d2fb6cd9817.1747314709.git.gitgitgadget@gmail.com>

On Thu, May 15, 2025 at 01:11:45PM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> While `if (i <= 0) ... else if (i > 0) ...` is technically equivalent to
> `if (i <= 0) ... else ...`, the latter is vastly easier to read because
> it avoids writing out a condition that is unnecessary. Let's drop such
> unnecessary conditions.
> 
> Pointed out by CodeQL.

Yeah, I'd agree that it is easier (otherwise, you are left wondering if
there is an "else" case you are missing).

>  help.c             | 2 +-
>  transport-helper.c | 2 +-

Both spots look good to me.

-Peff

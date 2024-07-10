Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60EA1392
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 01:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720573929; cv=none; b=Q6BntyC79e7MNWSU4Jyh7u2uidu+lVLMKqxWgUpasixTxmMfiJzQP9EXp6NRVJG2XJ7mXgwoKqRA9WkUPghdNAgYpqUfS6CtNG2S57WYtsrq5xog+LQr2XroD86VBNH93ODNMgmqppScsJnnYteiHM/BPdpRvPC8ItFJslXoBlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720573929; c=relaxed/simple;
	bh=0fcRRLL+nXMfWC8U/SVcjNbxdz6wvwSNyZlr9wc719I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJZhbrUZS+Y7Q0z2bwG2nNVR9YiLw9t3gmtR3PLwLH+zEn/zW7V6XenM93oi3IPZDrzzpUZJgIGJjM1G+Wbkee1XEc3Zeet5klQsuMb5H4sfgcj87vHRNvx9jy+Gd1sZzhBxCsnqU9/5XZjlFDP92Co/LlUjbyNQQL5eT3Gr3uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31263 invoked by uid 109); 10 Jul 2024 01:12:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jul 2024 01:12:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6930 invoked by uid 111); 10 Jul 2024 01:12:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Jul 2024 21:12:04 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 9 Jul 2024 21:12:06 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] test-lib: GIT_TEST_SANITIZE_LEAK_LOG enabled by default
Message-ID: <20240710011206.GC1526498@coredump.intra.peff.net>
References: <598149bf-6541-4c9e-8c94-a108e3ee7fd7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <598149bf-6541-4c9e-8c94-a108e3ee7fd7@gmail.com>

On Wed, Jul 10, 2024 at 02:51:58AM +0200, Rubén Justo wrote:

> As we describe in t/README, it can happen that:
> 
>     Some tests run "git" (or "test-tool" etc.) without properly checking
>     the exit code, or git will invoke itself and fail to ferry the
>     abort() exit code to the original caller.
> 
> Therefore, GIT_TEST_SANITIZE_LEAK_LOG must be set to true to capture all
> memory leaks triggered by the tests when SANITIZE=leak.
> 
> Set it to true by default, and stop worrying about someone checking for
> leaks who isn't aware of this option and might be missing some leaks.

I'm obviously in favor of this direction, but...why stop here? Do we
expect somebody to set it to false? If not, then can't we just get rid
of it entirely?

-Peff

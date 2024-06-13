Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915A613D8A6
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270501; cv=none; b=uaz6F3ACbVvGJvdKDYop6AJLxyvnqYtJLpdBB7MT8FYPvHK+jspDDwmbAsxkqNvopc05iH0QQKuc79dEUZjL6ozg3t2yHRGL3oo/8K4l4TuuAS1V6XoTsi5WciqtxnlRWSjzBmCLQocS6ZQKZlMcK+6KzsCnLJBYufhA9DOLbOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270501; c=relaxed/simple;
	bh=gQv/DBFfIaGGtfOerLkJVBfgnDg1sqEHLIj3AVTb0S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Veyl4N4GbwGBWxk6JCfPWb7gPWfC3/fQFDHI5eb7TSZmhT9flMF8Fk5VRdHhRnIb39gjEpOpQ94GeErHtLtyoUxNlroD4VdvuVdSCQkCRvLA7vRs6WbQY/2kfWf+MZzWNjO44pPTdZpdDsX4xmHXtwugauzUs0qVwSQ3h8/AEXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24502 invoked by uid 109); 13 Jun 2024 09:21:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Jun 2024 09:21:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15385 invoked by uid 111); 13 Jun 2024 09:21:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Jun 2024 05:21:35 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Jun 2024 05:21:37 -0400
From: Jeff King <peff@peff.net>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] t5541: add test for rejecting a push due to packfile
 size
Message-ID: <20240613092137.GC796372@coredump.intra.peff.net>
References: <20240612115028.1169183-1-cmn@dwim.me>
 <20240612115028.1169183-4-cmn@dwim.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612115028.1169183-4-cmn@dwim.me>

On Wed, Jun 12, 2024 at 01:50:27PM +0200, Carlos Martín Nieto wrote:

> diff --git a/t/t5546-receive-limits.sh b/t/t5546-receive-limits.sh
> index 9fc9ba552f1..ccbdf3945ab 100755
> --- a/t/t5546-receive-limits.sh
> +++ b/t/t5546-receive-limits.sh
> @@ -5,6 +5,11 @@ test_description='check receive input limits'
>  TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  
> +
> +ROOT_PATH="$PWD"

I don't think this ROOT_PATH is doing anything?

> +. "$TEST_DIRECTORY"/lib-httpd.sh
> +start_serve_git

Since you're adding to an existing script, these should go near the
bottom (or possibly even in their own script). If we don't have apache
or curl support, then loading lib-httpd.sh at all will cause us to bail
from the test script immediately. So we'll never run these existing
tests at all on such platforms, even though we could (and do now).

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FF16FAD
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 00:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709686261; cv=none; b=fm5FqPsaDNkQ7YA4WzG6H/4j/iMMHz7UM7Y+ZZWEvRoZuQilZ/pnEgcpShHq27UsvoPoxvFb0Vg4yzpl2Fxu9aDYX3gUjvfqvXTXvAzQ2o/Qf9Ma4Lmv6RENBp0vp4dXBIqZ3d2a5Cv1KRZmsX6LNEgffzDIHWLhh6VZkxxcdcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709686261; c=relaxed/simple;
	bh=/ipYmJuJR00ZMBgamAKas6jSIQpVRi2i+def8czA5xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isr8Q0H91m8qNqYOWPIXkEnEx8RjXSM8ef+BrlYZRiiK7vHINqshlf7OJRzalzYiaPxZAVng22AOA7ypfkAT4OYMEsS39aunymtEkrW4cpC7KgitPs7dZ5VReJ33eLj1SI/NCBARVH/VQbWgmYy1Ejcw1BZOg6WwVsb310vtBbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22618 invoked by uid 109); 6 Mar 2024 00:50:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Mar 2024 00:50:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30292 invoked by uid 111); 6 Mar 2024 00:51:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Mar 2024 19:51:00 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 5 Mar 2024 19:50:57 -0500
From: Jeff King <peff@peff.net>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] ci: also define CXX environment variable
Message-ID: <20240306005057.GC3797463@coredump.intra.peff.net>
References: <cover.1709673020.git.steadmon@google.com>
 <75f98cbf98005b0a069977096ec5501f2f7830fe.1709673020.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75f98cbf98005b0a069977096ec5501f2f7830fe.1709673020.git.steadmon@google.com>

On Tue, Mar 05, 2024 at 01:11:59PM -0800, Josh Steadmon wrote:

> In a future commit, we will build the fuzzer executables as part of the
> default 'make all' target, which requires a C++ compiler. If we do not
> explicitly set CXX, it defaults to g++ on GitHub CI. However, this can
> lead to incorrect feature detection when CC=clang, since the
> 'detect-compiler' script only looks at CC. Fix the issue by always
> setting CXX to match CC in our CI config.
> 
> We only plan on building fuzzers on Linux, so none of the other CI
> configs need a similar adjustment.

Does this mean that after your patch 2, running:

  make CC=clang

may have problems on Linux, because it will now try to link fuzzers
using g++, even though everything else is built with clang (and ditto
the detect-compiler used it)?

-Peff

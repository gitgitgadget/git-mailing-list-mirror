Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81665C96
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661847; cv=none; b=UXNIBlgNXq6kz9TEH+84q1rnHQxy4JytAyeTUPFN/4mJza3dPqKQ+1SwYjeb3+FgpBvWAWfyEOedLAM5MVDIAu4YkMryWgqJEC6GV1H5xabxPMBtPS2L0umuic+4yMjzIjW4kzkq7ldhsKEC+fxeV8CC2hqmb6ygUKXXYkbmiME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661847; c=relaxed/simple;
	bh=0SrKEtzp0StKGadvVxfvlSLF4dcU50inr7sP11ccr8M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qYZQcjAECjwaBehMQKIXZy0Ya6NiCs0BY6Oqw1YtbdPP0ZgJGKpmXvAzREvuFrM89wuHRhH/1nHMqN3QrtQNvwJTJ7Fbe/bCw3KPa+nTmqvP8v+A8EKalAmY+6ntZgJs42ehWOQMEVz3xemjiXU/aIQUq2gUWBJKWU8pR1D5PNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11189 invoked by uid 109); 6 Jun 2024 08:17:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Jun 2024 08:17:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6616 invoked by uid 111); 6 Jun 2024 08:17:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Jun 2024 04:17:22 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 6 Jun 2024 04:17:24 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH 0/2] dropping stdin support from test-terminal
Message-ID: <20240606081724.GA1166769@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

This is an alternative to Rubén's patch here:

  https://lore.kernel.org/git/d95180fc-8f8a-4e1d-987d-3aa0811be7de@gmail.com/

and instead just rips out the stdin feature of test-terminal completely.
There are two tests in t4153 that rely on it (and for which it was
originally added), but I think the fact that we need to use
test_terminal there indicates missing functionality in git-am.

So patch 1 fixes that, and then patch 2 simplifies test-terminal.

  [1/2]: am: add explicit "--retry" option
  [2/2]: test-terminal: drop stdin handling

 Documentation/git-am.txt           |  8 +++++++-
 builtin/am.c                       |  3 +++
 t/t4153-am-resume-override-opts.sh | 14 +++++++++-----
 t/test-terminal.perl               | 29 +++--------------------------
 4 files changed, 22 insertions(+), 32 deletions(-)

-Peff

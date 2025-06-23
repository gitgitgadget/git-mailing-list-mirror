Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB41A2390
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 10:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750676123; cv=none; b=qMnm7HtL2GLhInXex81ecEAUDHolHJXeEUqERCczUEouhnFnSP8qcllA4Cy7FLUxa5iGD50Xr2SwpgHTptX40QYyZmy5T+Gn4eY1zOrw7RGOmY8w6Zh2gwktU/kQi58fWa3IO0tFPDMKB/87P+Df5MZPKesEa+/lXUELe5XjbTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750676123; c=relaxed/simple;
	bh=Pr1oWw5YA5qOOYTJP4Wlh1csGljfdi6TBIOHfkG0R6Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aOVcazY4Vo7aCaPH9hf7kba5JNeoiBF1HLWiHEuzdPlO3t6x8b14SPDxm9+5RowdKFfDsPo7bl9p6f2QhkgxrI9kWqQwLDcfZUP+gAF2KDULd52Ec1afEo4rv+xp6291UHmp/zeuNr/iQ0O6mjqrWqeVxR5z53FpW8E7qAGSpUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XMnmhZLQ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XMnmhZLQ"
Received: (qmail 10117 invoked by uid 109); 23 Jun 2025 10:55:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:mime-version:content-type; s=20240930; bh=Pr1oWw5YA5qOOYTJP4Wlh1csGljfdi6TBIOHfkG0R6Y=; b=XMnmhZLQjoqZC6L1f1+LfBzC+Nc/TCf9A3bBdFDA8FcROse0li3b6J67oZt2yrtJvoC+c2zwBV/7y+xUv+33v9fiUFVzxN2Wbp/0DEL2AUaNTpidbdYqX0pgWpDAB1q6xRuvIMz60Z8uiqm0/BFB1TUCwYePT2gBuXWGoXtq9vKeNQVO/9uNp7vckl7x6KgsTg82QnDJoaokmNlrj6j657S25FPE5fiC+p1RXE++OxJnLSjXSqJyaZGzS6ifqao+ujyBfNKl+9ZjF1Kjq+SxThHz4rbPAyK1xbTwBdGEijM9w3H2hT1FOStc6f/QuCxM6ddi67qXGxSeOa60aAGPww==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Jun 2025 10:55:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16005 invoked by uid 111); 23 Jun 2025 10:55:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Jun 2025 06:55:16 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Jun 2025 06:55:16 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 0/2] test_seq format option
Message-ID: <20250623105516.GA654296@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This is a small quality of life improvement for our test suite, stemming
from this discussion:

  https://lore.kernel.org/git/20240408172638.GB1629595@coredump.intra.peff.net/

But somehow it took me over a year to get back to it. :-/

The first patch is a small cleanup in nearby code; the second one is the
interesting part.

  [1/2]: t7422: replace confusing printf with echo
  [2/2]: test-lib: teach test_seq the -f option

 t/t0021-conversion.sh                  |  4 ++--
 t/t0610-reftable-basics.sh             |  6 +-----
 t/t0612-reftable-jgit-compatibility.sh | 13 +++++--------
 t/t0613-reftable-write-options.sh      | 24 ++++--------------------
 t/t1400-update-ref.sh                  | 10 ++--------
 t/t5004-archive-corner-cases.sh        |  5 +----
 t/t6422-merge-rename-corner-cases.sh   | 10 ++--------
 t/t7422-submodule-output.sh            |  9 +++------
 t/test-lib-functions.sh                |  9 ++++++++-
 9 files changed, 28 insertions(+), 62 deletions(-)

-Peff

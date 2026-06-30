Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555973E7BB1
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 06:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782801594; cv=none; b=kuehFqvHaHPyevzaJRl/NJ0cUeKxBlv7EqhPiRVzZmN1DAWH02QcQKCjsgy39xrP4sdNsbOB2THOij0zSdp5HrfVd4ErtTimj4grLEr8jXE3NkTAxLJJ7qQ5KG+2W33JO6q/JwnpJ4JQDljxN7p02OSZmzatVvDPrS6UU+SmtIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782801594; c=relaxed/simple;
	bh=/aztX2UOL7cNMVWWmymHHkiREy96WYhUrhMV3n8gnf8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f7RMqjCggRYV4mde1jXcd62Iv8QRSzr4dD4fDrD7EGM6v4LEIEfEZkwa2hvey7lfdZ5gI6ED39TvofvfqjbD2IGd5NPxomn0gemJNWo1UEGasvxQiE1w9ic3WHOYOgWVz21X4HR1RGe1FJNqUzYXQm2ain+lU6g0bTWofdjFdjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OXRYmmGJ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OXRYmmGJ"
Received: (qmail 69902 invoked by uid 106); 30 Jun 2026 06:39:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=/aztX2UOL7cNMVWWmymHHkiREy96WYhUrhMV3n8gnf8=; b=OXRYmmGJX3TH7PHPGKanBrkDvxy6N54fXU1Bu1sS0J1GGEmxZvxYhMZjU/6Z3SrxyGQD3FrHG49Z9C/1vyCTRAkKhxzD7GCbtQQahHIalxphwqdxtCK3I36/MuQCAWAL98AauslTk1LNrVk4KxBEN362MWGWNH1FDiRc77CZ8a2927TDbX6OIBfwW+k0TwQL3qQ7tWAN2I4rD+18PbFwX4OovhPgg6clIoWy7/5I9OfcmQpNvruOGnNxWK/I1JhyD8InFijVcq4YrSWlN2LEUtYvVZVclNHBlvMBahcbuN/Gpl403mERUAE3W3PunRcKo5DXaKJxWkuT3kIfkxKWXg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jun 2026 06:39:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 141352 invoked by uid 111); 30 Jun 2026 06:39:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jun 2026 02:39:45 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jun 2026 02:39:44 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] small leak fix in format-patch
Message-ID: <20260630063944.GA3733670@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This fixes a leak I found while discussing an unrelated leak in another
thread[1]. As a bonus, this fixes some minor recent breakage of
leak-reporting when running the test suite under prove. The patches can
be split into separate topics if we want.

  [1/2]: t: move LSan errors from stdout to stderr
  [2/2]: format-patch: fix leak of rev_info in prepare_bases()

 builtin/log.c | 1 +
 t/test-lib.sh | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

-Peff

[1] https://lore.kernel.org/git/20260630055026.GE2495216@coredump.intra.peff.net/

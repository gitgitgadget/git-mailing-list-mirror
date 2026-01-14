Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF8030E828
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412701; cv=none; b=f7L7B2POWeSqPKKBKIn2sUh9l8BeMuE1mxgJtomWZ1UT7dQ5gDYZ7KACD+zyKUhrEmEuKODf5fNV7acOw+rQMh9aXNP0h2Djf9Rtz5Gmd6W82GqRikDE20mMgOWWQGEmlMy2YM6RbroY0Jsh4DQF/ti+jhO4rQqSIgab3Ue3xtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412701; c=relaxed/simple;
	bh=NfhWYd3A5BNDXyElGf326QDmuYgFt357hqDKC6cR4XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaZAC+6vnfxP4S27otdq1jV9yCe7c8tUS8k375DOfumNSA7pYo/BZSERTzLSE10iTRzT4ZenvsFbdm9IqrpLO8GyGTDWqYUcBDm3vYKakgH775pLHovenFhvpETXL6tqB29HXLfgquPb7hvtmwFfBZB/wb9k6dujzYQHMly6IcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=J4CQokQ/; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="J4CQokQ/"
Received: (qmail 40739 invoked by uid 109); 14 Jan 2026 17:44:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NfhWYd3A5BNDXyElGf326QDmuYgFt357hqDKC6cR4XY=; b=J4CQokQ/I9zTLZbSEwlDZG3bO4pER+S5AATR74DDbyHfkN2s7vzb4z80g6tCvtVZ6yhEjrWWohmJrYr3xPj7OWMWXSUcFxoIESADGRnRZAd01RTkzrF/y3s2TxkWhCCS0sP1suWIm1TnxN4Jp/ihbV1WirbAPV3vmWjRGJPzWkrGu86PUBSal4/o9v3626SKMbQt5mIcAwZ5IhIWtcxkiwScnx/P6sWqHwYQaFDwHwQRR1J2ucWKx2thct/cNxDuaV179O7GpgbKXDS9gRIpVwliDEEUdXFtsVtTs6Ox3ci+LFAyntpctK4IgUn1eHH6jM01dQmO0EdJUAzJA6VBRw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jan 2026 17:44:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 67314 invoked by uid 111); 14 Jan 2026 17:45:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jan 2026 12:45:00 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Jan 2026 12:44:58 -0500
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, newren@gmail.com
Subject: Re: [PATCH 3/6] refs: add rejection detail to the callback function
Message-ID: <20260114174458.GF885771@coredump.intra.peff.net>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
 <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-3-f5f8b173c501@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-3-f5f8b173c501@gmail.com>

On Wed, Jan 14, 2026 at 04:40:44PM +0100, Karthik Nayak wrote:

> The previous commit started storing the rejection details alongside the
> error code for rejected updates. Pass this along to the callback
> function `ref_transaction_for_each_rejected_update()`. Currently the
> field is unused, but will be integrated in the upcoming commits.

Splitting it out like this seems reasonable.

> Co-authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

In case it matters, you can add my:

  Signed-off-by: Jeff King <peff@peff.net>

to this and any other patches which were derived from my earlier
attempt.

-Peff

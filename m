Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E20920D4E1
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738607551; cv=none; b=QYN9nmQ7HpL9f1RoeeA0up2HMveH5T5T3nv0ImERxCsogkAzE/8GLOSiSf3q+R/9o+4cYBuxVczSUVbzTVRqMr8GICCfddrnWHlrLkHBB+TJyk/NV8o5wS1AW96KIgB4oTn+xDmT97BpWxkl6n53Xw/JQTpKwouByFAQ1v89I6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738607551; c=relaxed/simple;
	bh=YfTRxoxJvbnjTcYLQ7mLxVoDYXbxR9p4BwtVmJvozC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhARvGBBElMqjjfZTPMQYHy9HhQmxksR/NAAO7z/7MDhZ39r5fFODozNRQJV7kkJOlC1OR9pIxydj9AyEAWm7YPlD8wk508cgiKxCHwGkMb7LEB5pR9DEQiJkufeUrZPLtBQk12FWjdGq/t2VuiJn0JIUtrx1B8q9qWsia8y1QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Dt3bdjA3; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Dt3bdjA3"
Received: (qmail 19289 invoked by uid 109); 3 Feb 2025 18:32:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YfTRxoxJvbnjTcYLQ7mLxVoDYXbxR9p4BwtVmJvozC8=; b=Dt3bdjA3NMzSlEVUbrvB/z34+JXndK+CjpajTaHy5YPrnCsB2UAsnQ4O3qkhYPgkDPQjuu60rjTENh/9qdMyme4taPd+WkLXnynIUQqmucaJ2DAZde0rqFECKroX1DESFMspyoisPQCyxgwcyx4ew6WhamGHUtVNs3Q8zftjDrG5Do1WiamxZ4tq5z0EOkrsWfuuAsU+u0W3LuCze9q+qd2Uw7P4bGnnK3534QO7uu+6GOzvyC/p0lVeqsCkRxY5Nu8YERuzezsFrSlkZgsX6ZxLh2Aj49yPwf/yw++cuqFEKMN/W5LuYWZdyhTwewTzJjg2CB3fxfuCOnzsWE43BQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Feb 2025 18:32:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23988 invoked by uid 111); 3 Feb 2025 18:32:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Feb 2025 13:32:26 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 3 Feb 2025 13:32:24 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] t7700: add tests for `--keep-unreachable`
Message-ID: <20250203183224.GA4183065@coredump.intra.peff.net>
References: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-0-7c4d69c5072c@pks.im>
 <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-1-7c4d69c5072c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-1-7c4d69c5072c@pks.im>

On Mon, Feb 03, 2025 at 02:06:54PM +0100, Patrick Steinhardt wrote:

> We don't have any tests for `git repack --keep-unreachable`. Add three
> tests that exercise its behaviour with different packed states for the
> unreachable object.

There are a few in t7701. It's spelled "-k" there, so a grep for
"--keep-unreachable" would not find them.

> +test_expect_success '--keep-unreachable appends unreachable packed objects to new pack' '
> [...]
> +test_expect_success '--keep-unreachable packs unreachable loose object with existing packs' '

I think these match the two that are in t7701.

-Peff

Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ABD372B45
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013468; cv=none; b=CrZGWuik3EGa6j3dwpSjaC3QlCvCLHnHcJfzGHcoY/6+ZtsfyQy4UF98Fun0GqItJ6UNfhUHu1sqLJFqcowZ+65ShFgRHFbyy5VMeG5RI5Wa1+loWnItgeuLABvLJ9wekiHCipZNkgkOE95v5FD2N1cS9JmZVz2tjScHmcPlGMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013468; c=relaxed/simple;
	bh=LBC4HFbu5J+tbml2HO6UkTiUDzg2Z2hVcc7nldRbmNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bq9IdDeMKKJ+dPqRIa70Xs5BMLWQuXsFElSSlvvuPj1T2pW09k3Sn4CCaxOBjT+uj1spzKuCtTNFuu7Zo0gg8QVlkjrH9ZWtRbDiQOSB9lpfTrmXHfS7M3EGXli2Pl8uDIeNdqlfN5mD34Czr9bUNNheINvUVSVroRnTO6VdZ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IHCC/4pl; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IHCC/4pl"
Received: (qmail 21790 invoked by uid 106); 14 Jul 2026 07:17:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LBC4HFbu5J+tbml2HO6UkTiUDzg2Z2hVcc7nldRbmNA=; b=IHCC/4plLjSf/pcVeUcCzTBsNQ+pyM3eIIK3/Ylf/TguO3IeyK90Wa1yP4gjdJqUZkSuyLXxDjcRIk1p0KAh3gyvCVx+gP6GGMXdR7+c5GZ4NYk54BnJz6HFnMR3QpKnaF9Xd6LJ63UOffHQBO6puH8neAgAxV14eLt4H1P/8sG9iMDVgQOaAfwoQeL9ltYTwCBVm17eNLXJoPX23nx+S2FzqM7tclXGYH3ih83hHcxLLk/jyNk6af7539dV3rHQ6auqGWlLZYDX8fTSWp6ZqxXx9RX+T2G16kWHtWkRq2rmpsag4uF97bkD3jNhF0r9jdpxFKdkEnzTqYFb0/vfkw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Jul 2026 07:17:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 42842 invoked by uid 111); 14 Jul 2026 07:17:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jul 2026 03:17:50 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Jul 2026 03:17:45 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <ttaylorr@openai.com>
Subject: Re: [PATCH v3 0/9] odb: introduce object filters to
 `odb_for_each_object()`
Message-ID: <20260714071745.GB4058320@coredump.intra.peff.net>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
 <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>

On Mon, Jul 13, 2026 at 04:41:24PM +0200, Patrick Steinhardt wrote:

> Changes in v3:
>   - Weave Peff's patch into the patch series.
>   - Link to v2: https://patch.msgid.link/20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im

Yay, thank you. :)

-Peff

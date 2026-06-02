Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5742E7F39
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381491; cv=none; b=X5XXl94cDVgvPgT5F14F6mxSBJAqIwRMUWck3JkOZbdW/nPgKmUdK5gj3P/CBCsZEA+JwzOOtdE5vxKKua8L3gjJiK7j6+8WC1XwB5148goGx1kcHflKqBv+rCK031zpRN0Oqb5PdKxQT5lH7nwcAz+3NF6z+GCN4/DwDVndLW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381491; c=relaxed/simple;
	bh=4ljJ+/A5S7tS8qmP/q3ayze022ELu2WFcuNYHzG9+HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCatl2nna6GQ77FmaFDzd2FgDip9FCuCAGhVz8e2vxpfYWuWMZkv0w3Roei5wSWNZz1QlpkhnjgtErjKOramcWeFComJu/kS4ho9yFRVUnirlZPnVmP8I/tcWGaq/phHf5FwYrPQghdr4ODBx2atqYgM4MGcEYvUggp8y0bi4XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RgAbp1kB; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RgAbp1kB"
Received: (qmail 30541 invoked by uid 106); 2 Jun 2026 06:24:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4ljJ+/A5S7tS8qmP/q3ayze022ELu2WFcuNYHzG9+HY=; b=RgAbp1kBEazQlr6W2cVC1ZOPpkVFsZ9q8v1/59Qau8MqZXmRsI1Mo3Z7AjaQvEbUTALRFdvEpsjxL8HCRzmx/SfcRCs4CRlKU4V4Z02kPbEZmwdWv94PxK/YjRRhgLTLR3evLoqZArpAt+zPrp8WMiZ84HMpQtJ5n4gfpVwAFGT575ZeWP7Xw72ZmYD6RoBlQQPm4MLnqxBA0EQX2sUdnT7aKOioT/DjYCFu/00hogQ5FK/Q+w3nETaBW6qmSTvYueP9/9jm3hbWDLwAdX6lqyDMa8Q/wRhgy3UMMxA7dxPGy865XOG3X1VIiOTT7wLdJvvWRd6lttnQBB/hgX8wiw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Jun 2026 06:24:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 75816 invoked by uid 111); 2 Jun 2026 06:24:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Jun 2026 02:24:53 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Jun 2026 02:24:48 -0400
From: Jeff King <peff@peff.net>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	fox <fox.gbr@townlong-yak.com>
Subject: Re: [PATCH v3 0/2] http: fix memory leak in
 fetch_and_setup_pack_index()
Message-ID: <20260602062448.GC695568@coredump.intra.peff.net>
References: <ahjUmMCKxREamQE-@lorenzo-VM>
 <cover.1780321770.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1780321770.git.lorenzo.pegorari2002@gmail.com>

On Mon, Jun 01, 2026 at 03:51:43PM +0200, LorenzoPegorari wrote:

> Patch series that does some cleanup and fixes a memory leak present
> inside the function `fetch_and_setup_pack_index()`.

Thanks, this version looks great to me.

-Peff

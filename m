Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5443735979
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 01:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753232573; cv=none; b=GxIJBE9H7j8FIhT9V8wGp1vj19iNOArksTSl4wIkPfrnbpzM8oPa8ZNV7ZWWgRdajFdZlRdkHoxhRrl/nsgtnFvpVxrEm/XdwzVHQ+J2MSc7U8rSntwrjTrtrqTynXepBeSr7InDiGcMUKvthOg1d2C08dIdon+OlC5wWE0iWH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753232573; c=relaxed/simple;
	bh=2E4AmtCve9MuHNyS+OfllKP478CclyuE2HeD1flYWfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaVLZrpRv1gkfLRrRa9sOhkyJ20qXpY1Z3pg9Jsb6AAbnShBfp5ljq514vUj3YvBJuHmv7tC9STfdIxh+IxwspbLF+iuoAygrm9GRme1O1ABZnMqNNA95RpMcGyCc1QDZGOk7O2CSnEzR7ZQLPAl+On4yvCzAAj7GcxsoC7/2yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GjKXTevX; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GjKXTevX"
Received: (qmail 933 invoked by uid 109); 23 Jul 2025 01:02:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=2E4AmtCve9MuHNyS+OfllKP478CclyuE2HeD1flYWfE=; b=GjKXTevX5USwfv47Baf/PKkudt+1yAnLk5kX8Bqv+RR8FTwW/hzrZWgoRr03QYfz3E2IcLUqOq9gCQK/Hj5O2MD6afONYwCNP1PzI9mcW1NpcTCYqetlRO9AXoAX7qyUYoEsnbyqeoL0xxdgr/Wxt0MYHgHtYeQeHJ/gMKI0fCbG7xfcDXIBBYqa8SRasTKbS4ZTCx9HrKGYd00YPiJ/KYmSAY/gPUQuqoCLohfcILCFw+8djeShXFau+ShG5341tbt0jxODq+c4FX8GmJk+EgmDCXi9RubuvRx7va9SRZjTZ46XgIx7XDTCOWjSJ7NprVPo35pr3TnhlOGBFfK9xw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Jul 2025 01:02:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7792 invoked by uid 111); 23 Jul 2025 01:02:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jul 2025 21:02:53 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 22 Jul 2025 21:02:49 -0400
From: Jeff King <peff@peff.net>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4] reflog: close leak of reflog expire entry
Message-ID: <20250723010249.GA4938@coredump.intra.peff.net>
References: <20250722-jk-fix-leak-reflog-expire-config-v4-1-b65a83551020@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722-jk-fix-leak-reflog-expire-config-v4-1-b65a83551020@gmail.com>

On Tue, Jul 22, 2025 at 04:18:26PM -0700, Jacob Keller wrote:

> Changes in v4:
> - Pass correct struct in reflog_expire_condition
> - Add a unit test (thanks Jeff!)
> - Link to v3: https://lore.kernel.org/r/20250721-jk-fix-leak-reflog-expire-config-v3-1-c488b0586e80@gmail.com

Fourth time's the charm. :) This one looks good to me.

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78519201270
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738597105; cv=none; b=bPAhLg+tLgwzGvHqanWC8MeepP3yxykd2+THXX3j4b3rEM2FZb4xHX61cl3zW/I4MbGHhbYVFylmxEa37nl84ke7At+K8CRqoSdMZJFAKvroqPMTN36T5Ns3s8RUgMBTEY6GCCqgBNJ2FyDg9Kigh1Q/Mcwx1Iq9h1KPTHHgZUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738597105; c=relaxed/simple;
	bh=cImd8fNn7Lfqh836XFOK17d5jW5LQY+s/jOaCPL8qE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUmK1T3Fh6wY0L2vSEuHDeQ2vhSnsuUwsWQD7Zav9j+5ZFaD4d2CfE2dT2AA7dcn+cpzjKeinbxwapIEQ4pVaPkis2934KO1hhsdjNja2gfrHhP0ABtgiOhtHljMQ59rKXT0VFXfEkgLUNST2HOl6KGi6yzyUrMOIeWrhLcH//4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Siep7tAH; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Siep7tAH"
Received: (qmail 18395 invoked by uid 109); 3 Feb 2025 15:38:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cImd8fNn7Lfqh836XFOK17d5jW5LQY+s/jOaCPL8qE8=; b=Siep7tAH27oTfR45axR8yXp29EqGMksrF7/1Xg6gtHVR7SasfVPCBfGt6CAeIsQ8NOc8ltNpPWH2CyC2+CUkqbt+B/W+62uaQnsPpKwJgsBSSxvPkJszyjC0aycP5h3HrgHcd1YA+7wPaISqT+XTWDgp5V49Ry3B5MZDAKDATu+tLW1OmFqjVITOZk0QKP/QqczvLeTsl4JYRH0SDjTkgQqTFyY6/r34c+UPs7VjMZHkVRpuvn7QPgIWzsrr87UJ9iP2wCdygAYPtT+vwETYBxm1YJR9pIK+d5mqbb4G2Zq5wtKCTyqJn3ROQRYMjApLi5TbuUFHd5+LrwMF3MXEAA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Feb 2025 15:38:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21320 invoked by uid 111); 3 Feb 2025 15:38:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Feb 2025 10:38:22 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 3 Feb 2025 10:38:21 -0500
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: undefined behavior in unit tests, was Re: [PATCH v3 3/3]
 reftable: prevent 'update_index' changes after adding records
Message-ID: <20250203153821.GC4165842@coredump.intra.peff.net>
References: <20250122-461-corrupted-reftable-followup-v3-0-ae5f88bf04fa@gmail.com>
 <20250122-461-corrupted-reftable-followup-v3-3-ae5f88bf04fa@gmail.com>
 <20250201022409.GA4082344@coredump.intra.peff.net>
 <CAOLa=ZRCb4KHKNkW=kuGhiR7B-aV73KV32DqjX4RM0fDP1gMww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRCb4KHKNkW=kuGhiR7B-aV73KV32DqjX4RM0fDP1gMww@mail.gmail.com>

On Mon, Feb 03, 2025 at 07:20:16AM -0800, Karthik Nayak wrote:

> Like Phillip and Patrick mentioned, this should go away since we're
> moving to using the clar test framework. I think it makes sense to keep
> this as is to stay consistent with the rest of code in this file for
> now. It is ugly, but seems like that would be simpler while migrating.

Yeah, definitely not worth addressing this single case. I was more
interested in the overall trend, but it sounds like there are plans
there already.

-Peff

Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6E13BBD5
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 21:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710884234; cv=none; b=A/jVE/51C00yOr0N9Jr0+6SrN9wMFkx+9E2bwH7ZDSywkrRiyN031D1xRWEImVJ20gC+QUNorZLZqcntpTrYPTS00rj7PrIXwsfMJRiSqWSTiN3cstiqe/stiKTPrarRUWblRERsT4S2BBUv2tzkIJi+g8qAB7BrdenMfqKJCfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710884234; c=relaxed/simple;
	bh=jFhdm0EUKtp9d+UgG/zkixokg5ebUs3ETozaJWdTOao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DMFeJU5/jJYVrFbJogaIi1b9pnvb7cvtRST7BnsfEfJYd7/VOcrGpJl3wYGbRvZ29x61jmrHLX3P17mXolY8Sw776Lh5wfDp1rbdFqJzFaIsifUNWiSDMTsSF9ORM41a7nyDhN+vp3DsxCXMh8BSSBTH9enSzSSRun22RgIVwAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=LBkcKUGD; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="LBkcKUGD"
Received: from localhost (ip-109-42-178-84.web.vodafone.de [109.42.178.84])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42JLak9e005458
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 19 Mar 2024 22:36:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1710884208; bh=jFhdm0EUKtp9d+UgG/zkixokg5ebUs3ETozaJWdTOao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=LBkcKUGDYOg71tlPsOdCPfkrzmljvlD1007X2jphNEB9PAvGNL5AFNHZCZ+2GbJJ3
	 3On4zx6TkVUrrn4tmpGpxlK3eZKkcS7csP9Y94cUJxZ6DKHvAb8DBt/0TfvRjxpUuA
	 xxhi1kCkAwVEAdKJaTzyl/7LJPWGtRmN0LF9xrOI=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
        Ignacio Encinas
 <ignacio@iencinas.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        rsbecker@nexbridge.com
Subject: Re: [PATCH v3 0/2] Add hostname condition to includeIf
In-Reply-To: <xmqqa5mulycz.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	19 Mar 2024 14:12:44 -0700")
References: <20240309181828.45496-1-ignacio@iencinas.com>
	<20240319183722.211300-1-ignacio@iencinas.com>
	<CAPig+cT4fpX7Kczu0+H5TZnmpVqqq0h8nBafj4UqDs7Xv2Nf4A@mail.gmail.com>
	<xmqqa5mulycz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 19 Mar 2024 22:36:41 +0100
Message-ID: <ghv85hj446.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> Peff felt that adding `git config --show-hostname-for-includes` was
>> probably overkill, but I'd argue that it is necessary to enable users
>> to deterministically figure out the value to use in their
>> configuration rather than having to grope around in the dark via
>> guesswork and trial-and-error to figure out exactly what works.
>>
>> And the option name doesn't necessarily have to be so verbose; a
>> shorter name, such as `git config --show-hostname` may be good enough.
>> Implementing this option would also obviate the need to implement
>> `test-tool xgethostname` (though, I agree with Junio that `test-tool
>> gethostname` would have been a better, less implementation-revealing
>> name).
>
> Yeah, I like that show-hostname thing (which I do not know if "config"
> is a good home for, though).

A thought when I was reading this: wouldn't it be enough to document
that `uname -n` can be used to get the hostname that should be used?

As far as I know this should be POSIX-compliant and uses gethostname(2).

Dirk

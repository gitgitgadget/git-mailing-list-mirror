Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F0D4F606
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710887247; cv=none; b=UdkA6vTEHPA25agyHvTx9G7yvVIco0wKsj+SMStjt9LgtdruqTUno0vGgU/IISQayErxB6tO8kogPHCMHyGt5dL2U3mDXIM6yQOXzXX+3J/P027+k0TL8S3c+sx/mh7D3J5OrHieBYJhhKNmi+DTdZcBI31JI9HS299rGuN1ujw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710887247; c=relaxed/simple;
	bh=N3z3zAg+W+bTSiGDoRxM1lbeBKaSe/zIYMY/sbHQ2hs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AJ6iFl2luQS1e7gEZf+w+DN+pPoZmUQeFdpQxbWdFNF6tAkjpMH9O2nmULU4RmQzZsGUAoEx5xbDH9fjCqMjq4uNCpdE4KxQN3Utma6lXvzziSbriUToQlDwXAQN2X+UKa3Vjp1EAi/qNkd6nMNcFj7B8Ho4UgxfeWCdwMmvwXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=DBr/sUQt; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="DBr/sUQt"
Received: from localhost (ip-109-42-178-84.web.vodafone.de [109.42.178.84])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42JMR4w4007451
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 19 Mar 2024 23:27:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1710887225; bh=N3z3zAg+W+bTSiGDoRxM1lbeBKaSe/zIYMY/sbHQ2hs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=DBr/sUQtqiej9IaaC0drkvwbET6XVm1nA/61xNiiTwoyZWsnu8t+JYtq/rU7exWMG
	 fr385pcBeJi7Zd7O2rrMWdWoYvVcYAXNVuP1gjsRGaThD1g/O2jNhDDStxXCNtonbQ
	 FdlI7nQI+p1lMDOToUWwpAEtyLwDu0NI6uckqyGs=
From: Dirk Gouders <dirk@gouders.net>
To: <rsbecker@nexbridge.com>
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Eric Sunshine'"
 <sunshine@sunshineco.com>,
        "'Ignacio Encinas'" <ignacio@iencinas.com>, <git@vger.kernel.org>,
        "'Jeff King'" <peff@peff.net>, "'Taylor Blau'"
 <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/2] Add hostname condition to includeIf
In-Reply-To: <02d601da7a49$3bbf1230$b33d3690$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Tue, 19 Mar 2024 18:03:05
	-0400")
References: <20240309181828.45496-1-ignacio@iencinas.com>
	<20240319183722.211300-1-ignacio@iencinas.com>
	<CAPig+cT4fpX7Kczu0+H5TZnmpVqqq0h8nBafj4UqDs7Xv2Nf4A@mail.gmail.com>
	<xmqqa5mulycz.fsf@gitster.g> <ghv85hj446.fsf@gouders.net>
	<02d601da7a49$3bbf1230$b33d3690$@nexbridge.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 19 Mar 2024 23:26:59 +0100
Message-ID: <ghr0g5j1sc.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> On Tuesday, March 19, 2024 5:37 PM, Dirk Gouders wrote:
>>Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>>
>>>> Peff felt that adding `git config --show-hostname-for-includes` was
>>>> probably overkill, but I'd argue that it is necessary to enable users
>>>> to deterministically figure out the value to use in their
>>>> configuration rather than having to grope around in the dark via
>>>> guesswork and trial-and-error to figure out exactly what works.
>>>>
>>>> And the option name doesn't necessarily have to be so verbose; a
>>>> shorter name, such as `git config --show-hostname` may be good enough.
>>>> Implementing this option would also obviate the need to implement
>>>> `test-tool xgethostname` (though, I agree with Junio that `test-tool
>>>> gethostname` would have been a better, less implementation-revealing
>>>> name).
>>>
>>> Yeah, I like that show-hostname thing (which I do not know if "config"
>>> is a good home for, though).
>>
>>A thought when I was reading this: wouldn't it be enough to document that
> `uname -n` can be used to get the hostname that should
>>be used?
>>
>>As far as I know this should be POSIX-compliant and uses gethostname(2).
>
> As previously pointed out, uname -n and gethostname(2) are not equivalent.
> uname -n does not (depending on implementation) go to DNS while
> gethostname(2) goes to DNS first (although apparently glibc may not). This
> is particularly important in a multi-home situation where more than one IP
> adapter has a different IP address on the same host, and where DNS does not
> consider the different addresses to be equivalent (which otherwise could
> cause problems for reverse lookups).

Thanks for the explanation, I did not notice this has already been
discussed.

Interestingly, I strace(1)'ed uname -n here on Linux and noticed it uses
uname(2) (what else?) and not gethostname(2), so it seems I was
completely wrong.

Sorry for disturbing the discussion.

Dirk

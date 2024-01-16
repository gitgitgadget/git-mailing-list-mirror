Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556B05232
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 23:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705447483; cv=none; b=MMBgpNXda+N+nBhrxjDYUYwN7o4h4Bqr4IIYO+vqm+DlKdBsUH1jbDPXZcXJG686IUsaxLpmyd/atDgFvNRM0t7tB8dY+dMd7hCkZZcMTXVsOtiaCLcZGEMouxm0m+Ww8X6KxGeqAsUh2Hip3x9BitiAbN3rojLjVbHpNraaJMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705447483; c=relaxed/simple;
	bh=G/TOVWQ5jCXv7qSNUqwXJkEjFWm3IYkAlBPF6vlVGMk=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=J9m+IGryxyoHwnM8T3q7FBGh0E+Ut0U9h1YC4NL3et6PULJxDL3hlJKUUhp1NqkBDK4xo9Bg+UlFzSb53vwVk9mHXZQhvHsZJHM59R8gDm54RaxVOab4aAW3+tasHUArnkzGs7Jsny7FACTsOa9XQbLi/7s2706h8TKz+4S57Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IkD43Z7p; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IkD43Z7p"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 97B9C28046;
	Tue, 16 Jan 2024 18:24:41 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=G/TOVWQ5jCXv7qSNUqwXJkEjFWm3IYkAlBPF6v
	lVGMk=; b=IkD43Z7pbKDLlmdNF8lKAmnyV6upo63wKjOMPP1SDKYpQtfaQqoWTW
	VyW1RzTheY4EiMDnEJsIeTcVSZm7/jDJIGcISOqis2RqYFCXCT4bmq6BpE3W/ilb
	fS7T9RtpKt9+IqmZyfUiUaWiQ8M2M6lbaMF2NJOGCnbnwc68PBKIA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8FF6D28045;
	Tue, 16 Jan 2024 18:24:41 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A74D928044;
	Tue, 16 Jan 2024 18:24:37 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 0/4] test-tool: add unit test suite runner
In-Reply-To: <cover.1705443632.git.steadmon@google.com> (Josh Steadmon's
	message of "Tue, 16 Jan 2024 14:22:57 -0800")
References: <cover.1705443632.git.steadmon@google.com>
Date: Tue, 16 Jan 2024 15:24:36 -0800
Message-ID: <xmqqo7dkx3nv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6A6B53DE-B4C6-11EE-AA74-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> For various reasons (see discussion at [1]) we would like an alternative
> to `prove` for running test suites (including the unit tests) on
> Windows.
>
> This series extends the existing `test-tool run-command testsuite` to
> support running unit tests. In addition, it includes some small
> cleanups: we move t-basic out of the unit-tests directory, and add a
> test wrapper script to allow unit tests and the shell test suite to run
> in a single `prove` process.
>
> Some known remaining bits of work:
> * We need to filter out cmake *.pdb files when running with `test-tool`.

;-)

I should have read this before I commented on that "--require
is misnamed---what you really want is a custom filter" thing.

> * We should investigate switching the Windows CI to use `test-tool`
>   instead of prove.

OK.

> * We should determine whether it is confusing or otherwise harmful to
>   people's workflow to have the unit tests run in parallel with shell
>   tests when using prove as the default test target.

It is probably confusing especially given that the testsuite() thing
does its own parallel spawning of tests while prove does its own.
Is there a reason to choose unit-tests-test-tool Makefile target on
prove-capable platforms (other than for testing the test-tool)?

Thanks for an entertaining read.

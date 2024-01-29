Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B560153BC1
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706565068; cv=none; b=Mk7zd7O6AUhBHzGVGCTKk/pTF6BrG8mJwf3SrbnlVFdYcb6w3AYqBmwlO3pD98+Peicf4I4HTDBKScSjFrqzHnMGFh+cgW2xhOgRwgAh22O90yJU1jR5tUUnmmVLhel/HiDkqCjULBgh/mC4FtoUqv4bqRLf6UkI5KJD7x633zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706565068; c=relaxed/simple;
	bh=HRR25mSGqhj5+zK+OYJlhBzLiQPfAzOJaYfQgbVdxn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CGXMSq99AzF2NM3N8eQZtYD7yo+VxNFseNmHuv6tnJlUajwmHOAX78W+Rnc1qDYSvQmApIX1qbYysYdm82UvLbnhYdSqLyysvUfHWf5Apd7fj77kKugQQoVthGFwOXm6jt22U3JMZE1hwnJ9nN5gDkV1sAL3OEGVF7BwMlsq750=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=K5mYZKcn; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="K5mYZKcn"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0701A1D8FEE;
	Mon, 29 Jan 2024 16:51:04 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HRR25mSGqhj5+zK+OYJlhBzLiQPfAzOJaYfQgb
	Vdxn0=; b=K5mYZKcno2wlL/Ki6neF30vj1MtYfW0x2RFMCOq8zM/84fqDv4DHbk
	DRoD1Z5S/vo74xQlRo8Me+TBAsLP+qJV6LPhaPx6TEo/dR/Y4gCCOihy1RdXBrH0
	Uu780W4UZ86sdVa3gGQmBRgBWmoNC9XlVgSXBaDKy+gn2uteE6PzI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D7EEF1D8FED;
	Mon, 29 Jan 2024 16:51:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB2DB1D8FEC;
	Mon, 29 Jan 2024 16:51:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] t/Makefile: get UNIT_TESTS list from C sources
In-Reply-To: <20240129031933.GB2433899@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 28 Jan 2024 22:19:33 -0500")
References: <20240129031540.GA2433764@coredump.intra.peff.net>
	<20240129031933.GB2433899@coredump.intra.peff.net>
Date: Mon, 29 Jan 2024 13:51:01 -0800
Message-ID: <xmqqplxjhkqi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7F1396F0-BEF0-11EE-8309-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> Our new wildcard does make an assumption that unit tests are build from

"build" -> "built", probably.

> C sources. It would be a bit cleaner if we consulted UNIT_TEST_PROGRAMS
> from the top-level Makefile. But doing so is tricky unless we reorganize
> that Makefile to split the source file lists into include-able subfiles.
> That might be worth doing in general, but in the meantime, the
> assumptions made by the wildcard here seems reasonable.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I of course hit this when moving between "next" and "master" for an
> up-and-coming unit-test file which sometimes failed.

Thanks.  globbing the build products is indeed sloppy for all the
reasons you mentioned.  Will queue.

>  t/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/t/Makefile b/t/Makefile
> index b7a6fefe28..c5c6e2ef6b 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -42,7 +42,9 @@ TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
>  TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
>  CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
>  CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
> -UNIT_TESTS = $(sort $(filter-out %.pdb unit-tests/bin/t-basic%,$(wildcard unit-tests/bin/t-*)))
> +UNIT_TEST_SOURCES = $(wildcard unit-tests/t-*.c)
> +UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%,$(UNIT_TEST_SOURCES))
> +UNIT_TESTS = $(sort $(filter-out unit-tests/bin/t-basic%,$(UNIT_TEST_PROGRAMS)))
>  
>  # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
>  # checks all tests in all scripts via a single invocation, so tell individual

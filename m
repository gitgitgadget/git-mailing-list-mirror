Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9395D73E
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706986372; cv=none; b=f5NGYhVs9NZ1w1EYTdzXh5rQPsMmH85E7hHsB4uVS2Me/+0W0OApX3TLzgAhkitUHLDg1IZJYV/H5bPXM0ByjMTQreB9yEI/C/w9+1KME4wX4vQYReFMZAfpnfbEGq8/DbbeDN+32pyTGcMWM+zGdTmblnhgyD5OTeTXdZCdFUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706986372; c=relaxed/simple;
	bh=rY0MI9H9USX+v8DkFAyJnelJGEIEhdNORNfdnLgtjWs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cdHfx5WIgHmFAaxs6UloNrWm4pGRzoXpqjgSLclzuo4+GsDM0aGlmV7a2IbaZS4x/b/8o2iJHnS2Xg/hBKN+tCLGgtaZ+BcA1O0uWewy/88aXCI3JtLLUfx1btU0czZTOHiyPIFEUnps7LhG+bFnPD6N8Hd4XN9uP9/f81ituDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eKQNPTaT; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eKQNPTaT"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2F2962C712;
	Sat,  3 Feb 2024 13:52:44 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rY0MI9H9USX+v8DkFAyJnelJGEIEhdNORNfdnL
	gtjWs=; b=eKQNPTaT3OZeXCQkWzl/nV/I5RFFAGV4vZyQHZEAQexcJT+u5OCuGa
	WCJl1sXGGHe2XXr6zDR2IVXHEK3ZQiofEWHIdDrztoAi3oAiegxjSG3qfwW1o1yu
	5h/wq3P9RQH2EqqPNxMN322hOhNJWcueQFHEhsbjpQhOL0wrfdbFs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C3EE2C711;
	Sat,  3 Feb 2024 13:52:44 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B3CCA2C710;
	Sat,  3 Feb 2024 13:52:40 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 0/6] test-tool: add unit test suite runner
In-Reply-To: <cover.1706921262.git.steadmon@google.com> (Josh Steadmon's
	message of "Fri, 2 Feb 2024 16:50:25 -0800")
References: <cover.1705443632.git.steadmon@google.com>
	<cover.1706921262.git.steadmon@google.com>
Date: Sat, 03 Feb 2024 10:52:39 -0800
Message-ID: <xmqqjznlqt1k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 68322766-C2C5-11EE-82EE-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> Please note: this series has been rebased onto jk/unit-tests-buildfix.
>
> For various reasons (see discussion at [1]) we would like an alternative
> to `prove` for running test suites (including the unit tests) on
> Windows.
>
> This series extends the existing `test-tool run-command testsuite` to
> support running unit tests. In addition, it includes some small
> cleanups:
> * move t-basic out of the unit-tests directory
> * don't hardcode the shell for running tests in `test-tool ... testsuite`
> * don't hardcode a test name filter in `test-tool ... testsuite`
> * add a test wrapper script to allow unit tests and the shell test suite
>   to run in a single `prove` process
>
> Some known remaining bits of work:
> * We should investigate switching the Windows CI to use `test-tool`
>   instead of prove. However, Windows CI seems broken on
>   jk/unit-tests-buildfix, and I haven't had time to determine why.

Thanks to Dscho who figured this out, the jk/unit-tests-buildfix
topic in my tree has been updated to pass "win test (n)" jobs.

> * We should determine whether it is confusing or otherwise harmful to
>   people's workflow to have the unit tests run in parallel with shell
>   tests when using prove as the default test target.

I do not know much about "confusing" thing, but if the user
allocates, say, 16 jobs to run tests in parallel, and one of them
drives the "unit test suite runner" that wants to do its own
parallelism, we'd easily end up busting the resource limit the
end-user desires.  It does not necessarily mean that we should limit
the parallelism of "unit test suite runner" to 1 under prove, though.

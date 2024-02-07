Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C78823B8
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339314; cv=none; b=Q7ZtuPXcjvLYE5ue8VVWdEPH9bwm9s4BaA/l9PTPmPMZGOva9oary5z1HD6MZpHD/VRRKE+UI2BPhvDL7INYH520v5Z+zgg59sqzY2mQwzehursIjfpVKmrFGwDJLjdN5hEqTzQpDu8IehaV5h2SN2qNIUdT0dd2j/K9D7r8Ujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339314; c=relaxed/simple;
	bh=1WFCVMoFSXSBDvhRLiRoj1sJE2CVG0fXWWtCguNAC9c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mv2fqdHsKTFFgjkj+lez1RYatEpc2rXXLj9r4WYanhHrnMYIKn54GXeah9AP/Cz8UVViyarCWWjjiDWTvQi1zRb+DPzRV6YkNGTW2SfkXCZPTb9QtUVvii3SW6yHjOK48frvURL8eqDDxZ2qCzsBHWNGH5q6qvRUyWVjGwjfS+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TtmWkqNq; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TtmWkqNq"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 57CB81D943A;
	Wed,  7 Feb 2024 15:55:11 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1WFCVMoFSXSBDvhRLiRoj1sJE2CVG0fXWWtCgu
	NAC9c=; b=TtmWkqNq/rk9O9vw4YtGD4/wN+t64K40q3mxF8Dq//Py1cEE5m1khA
	L+vORJ2j78ALMRXB+Gd81f8TFbnP0776udBWYaTo4w6b3oVjIGWnU4vX1U2//3I5
	JLxdsekPeKXB71p7BODD0oISwcEIBbHx25tqm9jdUBUVaw8ES3bgM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C4B21D9438;
	Wed,  7 Feb 2024 15:55:11 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8302B1D9436;
	Wed,  7 Feb 2024 15:55:10 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 6/6] t/Makefile: run unit tests alongside shell
 tests
In-Reply-To: <cd7467a7bd51fbc01c999ee1bd7688770b1d11e5.1706921262.git.steadmon@google.com>
	(Josh Steadmon's message of "Fri, 2 Feb 2024 16:50:31 -0800")
References: <cover.1705443632.git.steadmon@google.com>
	<cover.1706921262.git.steadmon@google.com>
	<cd7467a7bd51fbc01c999ee1bd7688770b1d11e5.1706921262.git.steadmon@google.com>
Date: Wed, 07 Feb 2024 12:55:09 -0800
Message-ID: <xmqqzfwc6lle.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2EAC3B7E-C5FB-11EE-8755-25B3960A682E-77302942!pb-smtp2.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> From: Jeff King <peff@peff.net>
>
> Add a wrapper script to allow `prove` to run both shell tests and unit
> tests from a single invocation. This avoids issues around running prove
> twice in CI, as discussed in [1].
>
> Additionally, this moves the unit tests into the main dev workflow, so
> that errors can be spotted more quickly.
>
> NEEDS WORK: as discussed in previous commits in this series, there's a
> desire to avoid `prove` specifically and (IIUC) unnecessary
> fork()/exec()ing in general on Windows. This change adds an extra exec()
> for each shell and unit test execution, will that be a problem for
> Windows?
>
> [1] https://lore.kernel.org/git/pull.1613.git.1699894837844.gitgitgadget@gmail.com/
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  t/Makefile    |  2 +-
>  t/run-test.sh | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>  create mode 100755 t/run-test.sh
>
> diff --git a/t/Makefile b/t/Makefile
> index 6e6316c29b..6a67fc22d7 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -64,7 +64,7 @@ failed:
>  	test -z "$$failed" || $(MAKE) $$failed
>  
>  prove: pre-clean check-chainlint $(TEST_LINT)
> -	@echo "*** prove ***"; $(CHAINLINTSUPPRESS) $(PROVE) --exec '$(TEST_SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
> +	@echo "*** prove (shell & unit tests) ***"; $(CHAINLINTSUPPRESS) $(PROVE) --exec ./run-test.sh $(GIT_PROVE_OPTS) $(T) $(UNIT_TESTS) :: $(GIT_TEST_OPTS)
>  	$(MAKE) clean-except-prove-cache
>  
>  $(T):
> diff --git a/t/run-test.sh b/t/run-test.sh
> new file mode 100755
> index 0000000000..c29fef48dc
> --- /dev/null
> +++ b/t/run-test.sh
> @@ -0,0 +1,13 @@
> +#!/bin/sh
> +
> +# A simple wrapper to run shell tests via TEST_SHELL_PATH,
> +# or exec unit tests directly.
> +
> +case "$1" in
> +*.sh)
> +	exec ${TEST_SHELL_PATH:-/bin/sh} "$@"
> +	;;
> +*)
> +	exec "$@"
> +	;;
> +esac

Hmph.  This penalizes the non-unit tests by doing an extra "exec",
once per program?

Of course we cannot run two $(PROVE) invocations serially, one for
doing $(T) and the other for doing $(UNIT_TESTS)?



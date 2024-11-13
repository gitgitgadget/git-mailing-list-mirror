Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2278F1FBC81
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493176; cv=none; b=WBYQsldbOBaK9gNuQ27FIB3o462WUFj2LyjiX4PQieH8sy7Eg6R8JQ4gU5g8rOSedFkVbv1wwvUKqf5dAaMOotnIoWpRAspe8jFTNhRgrINGsPK4XSuwLpdqEWDt4FwSC6g55sD4Rl0lj++Ct2sXv2lwh5pcYmaxo6yNMIZXppg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493176; c=relaxed/simple;
	bh=4ZEQb6QxKuIM0/Ztd42QafS/xq0orflPI91AM9gqkAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jCUX4w7qqIEv5t7/Cd+9q4KjQBGXS/o8p6Lftj3aGyfrVAO1GfNU3GYSjuifxoPHtCsgtxmXlQo6ypZqlX3ByEsoR697LbZF+ba0nZ203mBBDEcsFK1pa63lq+2oBJzc0Wc7x85J4PPyrzwjuSXFfinIMo17p2sJK9XS5xoDWNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=TDaRuzk1; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="TDaRuzk1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1731493168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+pEX5ySkJxA1qfJO7xBOXCU1xuns1K8G1TdKYauOc9E=;
	b=TDaRuzk1IJv9KCFYI2NDjbirmAFgbcprdxmSKL25jjDOSH1QDJuFaP368pKdzfmw1TU9BU
	WNka+YaeXZRCX3CAsdWxaimM9bpOSiyX32WUGE5xUYPzM2i5wk7y6rBtCdt2nllgZ8gkDG
	NQZgutii8u+EA8i+gx3yHPAhzY1Bmds=
From: Toon Claes <toon@iotcl.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: Todd Zullinger <tmz@pobox.com>, Elia Pinto <gitter.spiros@gmail.com>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>, Andreas Schwab
 <schwab@linux-m68k.org>, Christian Couder <christian.couder@gmail.com>,
 git@vger.kernel.org
Subject: Re: [PATCH] test-lib: check malloc debug LD_PRELOAD before using
In-Reply-To: <20241111070134.GA675125@coredump.intra.peff.net>
References: <CAPSxiM9GZLKNbyCmgpz6b7Z-MLe8TfMaatR8FPNwvsHA411dtA@mail.gmail.com>
 <CAP8UFD1-HsYsPRQwWMo8ipf-VdqF+9=HUTTr4BhEArR=V3ucxA@mail.gmail.com>
 <CAPSxiM9UGLVrOh6XR5fn38ginCVKMOc7yQMcm+qsaF3bi+anSw@mail.gmail.com>
 <CAP8UFD2=imvtamewLN+VvKDK83aL7NhGAb=MjvHQ2OwaK-n5UQ@mail.gmail.com>
 <87msi85vc9.fsf@igel.home>
 <CAPSxiM_h2yEZcUPP33q8HHdn6kqq7SbvzNq8eEFda81ZgY6R2w@mail.gmail.com>
 <Zy-IYwjb_RO5NW-s@teonanacatl.net>
 <20241109190012.GA588841@coredump.intra.peff.net>
 <xmqq7c9aihvx.fsf@gitster.g>
 <20241111070134.GA675125@coredump.intra.peff.net>
Date: Wed, 13 Nov 2024 11:19:13 +0100
Message-ID: <87zfm3iggu.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] test-lib: check malloc debug LD_PRELOAD before using
>
> This fixes test failures across the suite on glibc platforms that don't
> have libc_malloc_debug.so.0.

As I ran into this issue not so long as well, I'm really supportive of
adding a fix for this.

> We added support for glibc's malloc checking routines long ago in
> a731fa916e (Add MALLOC_CHECK_ and MALLOC_PERTURB_ libc env to the test
> suite for detecting heap corruption, 2012-09-14). Back then we didn't
> need to do any checks to see if the platform supported it. We were just
> setting some environment variables which would either enable it or not.
>
> That changed in 131b94a10a (test-lib.sh: Use GLIBC_TUNABLES instead of
> MALLOC_CHECK_ on glibc >= 2.34, 2022-03-04). Now that glibc split this
> out into libc_malloc_debug.so, we have to add it to LD_PRELOAD. We only
> do that when we detect glibc, but it's possible to have glibc but not
> the malloc debug library. In that case LD_PRELOAD will complain to
> stderr, and tests which check for an empty stderr will fail.
>
> You can work around this by setting TEST_NO_MALLOC_CHECK, which disables
> the feature entirely. But it's not obvious to know you need to do that.
> Instead, since this malloc checking is best-effort anyway, let's just
> automatically disable it when the LD_PRELOAD appears not to work. We can
> check it by running something simple that should work (and produce
> nothing on stderr) like "git version".
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/test-lib.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index a278181a05..4fe757fe9a 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -593,9 +593,12 @@ then
>  	}
>  else
>  	_USE_GLIBC_TUNABLES=
> +	_USE_GLIBC_PRELOAD=
>  	if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
>  	   _GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
> -	   expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null
> +	   expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null &&
> +	   stderr=$(LD_PRELOAD=$_USE_GLIBC_PRELOAD git version 2>&1 >/dev/null) &&

Can we assume some version of git is in the $PATH here? I see $PATH and
$GIT_EXEC_PATH are only determined at line 1440 and further.

> +	   test -z "$stderr"
>  	then
>  		_USE_GLIBC_TUNABLES=YesPlease

Shall we include a warning in a else clause to inform the user the tests
were started with malloc check, but libc_malloc_debug.so.0 was not found
and they should either install it or run with TEST_NO_MALLOC_CHECK?

>  	fi
> @@ -607,7 +610,7 @@ else
>  		if test -n "$_USE_GLIBC_TUNABLES"
>  		then
>  			g=
> -			LD_PRELOAD="libc_malloc_debug.so.0"
> +			LD_PRELOAD=$_USE_GLIBC_PRELOAD
>  			for t in \
>  				glibc.malloc.check=1 \
>  				glibc.malloc.perturb=165
> -- 
> 2.47.0.495.g1253739cc1

I've tested this patch with and without having glibc-utils installed, in
combination of having TEST_NO_MALLOC_CHECK set/unset and seems to work
like a charm.


--
Toon

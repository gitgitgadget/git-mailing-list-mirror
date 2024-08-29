Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216721922E8
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940974; cv=none; b=Vh0OLU7VFNO0QP+SbKdx3xIu7vRs8HEN4u4z/1O+Es9kRaFrGecmy+H+9tQJggKavwKtgDGhpATBQ+iulsVwo/1LCJrBmbPB6L91CJbqvS5JE1PrFjGLcXZrTcc2xkO9giUjC81fCUEzAhSXJrOgezZZhpHn11zhZ/K+jei8EOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940974; c=relaxed/simple;
	bh=l2+V80q3dkhT0TJdBCgvAFMZGr5EdcqD6LEhfku9Z3I=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K9clLwhf3lo2NCaQoCh1zgXa0H4/CRkE6bLM75y8Qgwa7kcyIEtwqCeKHUwhL/GlRRKbQZtiyecyQm/bwcLJC0zK4en9+RQG+T2TcliJQqZKB9wA60AdVMR6OhJhmjizhJJuykhOecvITJZt1G/42C/0Sfn9PypMa74ErMSjM/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=46DAuhUY; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="46DAuhUY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1724940965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l2+V80q3dkhT0TJdBCgvAFMZGr5EdcqD6LEhfku9Z3I=;
	b=46DAuhUYIOYEVp9ieKvMme2wRBeXi5Si5r6ZVFZ5ilGn/RG0ax2J8/ZSHDpF3rBy+/j2ZY
	WPvmB7UpkwzPWDgYVKd+pOodWX30ti148kO2QDwxJylcEXSn6YIhSdPJolHtOGNnSpiveW
	CctcjL6AZxG8iUezHIB0C0ZX8m47Xjk=
From: Toon claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 01/22] t/test-lib: allow skipping leak checks for
 passing tests
In-Reply-To: <7c158acadf40b44edb3cf186860a3f60818f76f0.1724656120.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
 <7c158acadf40b44edb3cf186860a3f60818f76f0.1724656120.git.ps@pks.im>
Date: Thu, 29 Aug 2024 16:15:58 +0200
Message-ID: <87frqnjty9.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> With `GIT_TEST_PASSING_SANITIZE_LEAK=check`, one can double check
> whether a memory leak fix caused some test suites to become leak free.
> It is somewhat slow to execute though because it runs all of our test
> suites with the leak sanitizer enabled. It is also pointless in most
> cases, because the only test suites that need to be checked are those
> which _aren't_ yet marked with `TEST_PASSES_SANITIZE_LEAK=true`.

What I understand from `t/README` the "check" value is used to test
whether the presence or absence of `TEST_PASSES_SANITIZE_LEAK=true`
matches the expectations. I think it's better to express that in the
first sentence, because it sounds a bit misleading at the moment if you
don't know that.

> Introduce a new value "check-failing". If set, we will only check those
> tests which are not yet marked as leak free.

I would also mention this still has the effect that tests which *are*
leak-free but do not have `TEST_PASSES_SANITIZE_LEAK=true` fail due to
the use of "--invert-exit-code".

Also, can you add a short paragraph about this value in "t/README"?

--
Toon

Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F18470838
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 06:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744612160; cv=none; b=Avc7Bgmiy94iSNNtuTSjeactAOJ+BQZO8h12QhHMwpBFTv5/mnto0WP1aaE7EfNTGonW3uDTCGZJuhMpmwk1dZJvEq7aFOJBWuw7QsrsP9RyGD94hgNGTMnD3dx6fJ2eHHWVlEcA9wx1ICzCvKQmlEJnu32fPNAI3PBIyM/LDiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744612160; c=relaxed/simple;
	bh=nbdMz38uEcLIKv8FiHALQuM74zZ7JuPusmH6XL2hut8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s4WazDmplBCHrIveVuvf2y5cg/lMv89iDXDmMUZfdVCCI7TjGXy1LzbkSRmbw6g0QF1aDuYEo+e6UTJtp2MmV0NCh2FoDQ3S7yfuGTsJFw8cOQvBTsHh9KBCafcsLq5O2g/LZjCqn9tWDZYeJoridZ78+5nAzqaOdmhkISYqE44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=oTyNAQva; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="oTyNAQva"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1744612148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oqfHtrecljlvCBXPjCsCUEywueja3rlXyssmw/8Qb2Q=;
	b=oTyNAQvaJrokH/Xg4DF88Q05reck1KRdNmCUSInBj17YD6OEJYCq60FgQNFH0MmtU8/D9G
	zoVpRw7+Omo88Fs/ZnGNtnIXtxwP1DBTqw+SWq9O9pJWM3JBC4nGM73UsOk7CJGqxvMAeo
	iZfhTTPXbot60ZsuHBqpfizbJueytDk=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] t/perf: fix benchmarks with out-of-tree builds
In-Reply-To: <87v7rcdzck.fsf@iotcl.com>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
 <20250331-pks-meson-benchmarks-v1-3-b2ace85616a3@pks.im>
 <87v7rcdzck.fsf@iotcl.com>
Date: Mon, 14 Apr 2025 08:28:53 +0200
Message-ID: <87r01v5k9m.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Toon Claes <toon@iotcl.com> writes:

> I'm not sure if it's related to this commit, but this patch series has
> broken something:
>
>     $ make && cd t/perf && ./run . master p0005-status.sh
>
>     === Running 1 tests in this tree ===
>     ok 1 - setup repo
>     perf 2 - read-tree status br_ballast (4629): 1 ok
>     # passed all 2 test(s)
>     1..2
>     === Unpacking 485f5f863615e670fd97ae40af744e14072cfe18 in build/485f5f863615e670fd97ae40af744e14072cfe18 ===
>     === Building 485f5f863615e670fd97ae40af744e14072cfe18 (master) ===
>     GIT_VERSION=2.49.GIT
>         * new build flags
>         CC daemon.o
>         * new link flags
>         CC common-main.o
>         CC abspath.o
>         CC add-interactive.o
>         CC add-patch.o
>         [snip]
>         CC t/unit-tests/unit-test.o
>         CC t/unit-tests/lib-oid.o
>         LINK t/unit-tests/bin/unit-tests
>         GEN gitweb/gitweb.cgi
>         GEN gitweb/static/gitweb.js
>     === Running 1 tests in /home/toon/devel/git/t/perf/build/485f5f863615e670fd97ae40af744e14072cfe18/bin-wrappers ===
>     ok 1 - setup repo
>     perf 2 - read-tree status br_ballast (4629): 1 ok
>     # passed all 2 test(s)
>     1..2
>     cannot open test-results/p0005-status.subtests: No such file or directory at ./aggregate.perl line 159.
>
> --
> Toon

Euhm, it seems I no longer can reproduce this issue. So you can ignore
this message. Sorry for the noice.

--
Toon

Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2832E30597E
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773758; cv=none; b=JiZKsiPWn6hJtXhtiyH3q8EErDKxFGSjOww/BOPjN26YqvLxYNI6nZmBwzc/WMSz6X9xqxMiaR1gLUfnDbPdOdHejeVHgtoBXR1z6T2hCYT2vafICUeEbhTVzrKRYsCNCMLLl18Phy0K+Ld0Hbo0oONrZIcX8kYUQorFyntEQB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773758; c=relaxed/simple;
	bh=SGJMPZw9LvLHw7oGT/P3pnAjD34XPy8CeFdmr0H5Atk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D+Ot6rKIdW2bfornIu5171xfGXIvJE1yslvFbRYm3NEBWmF0n2LMUNTaiDgOJP9bseLEiW6MabHFhxMbGz6uXk1GINlBdsRpGBoySncXvqyeuAdKHLRdNW2AmqvkIOlgBLebcYEkuiBejk0AKm0mZA4Zyx4C6nTYevLR5cxEZM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=5OynIec/; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="5OynIec/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1764773752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hch9xBsmvtGmTwk5a86zhR2nzvBl5zhcBEkcAxfbMXw=;
	b=5OynIec/A8OqGjqznQfijwJTLTRy59C3Hc4d5YwR1FuUKxZQcaBk1LOPSUxe+xrSx8ZUGA
	qZRSs1PC/cDKAMQ8qAN2maGTqmv2vd4HybfdW5/yBu2lKzjwUNQMz65kPm7kyc/PhGX2p5
	T83zcqxdh0W6ubCctGtSsOe9aMLlP14=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] meson: only detect ICONV_OMITS_BOM if possible
In-Reply-To: <aS9LvvjW7mZStceJ@pks.im>
References: <20251202-toon-cross-compile-v1-0-cabc8bce529f@iotcl.com>
 <20251202-toon-cross-compile-v1-2-cabc8bce529f@iotcl.com>
 <aS9LvvjW7mZStceJ@pks.im>
Date: Wed, 03 Dec 2025 15:55:34 +0100
Message-ID: <87ms3zwr6h.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> We have `not meson.is_cross_build()` in a different location to guard a
> call to `compiler.run()`. But `can_run_host_binaries()` is the better
> way to test for this condition, as it allows the host to plug in a
> wrapper (e.g. QEMU or WINE) that _would_ allow it to execute binaries of
> the target host.
>
> `can_run_host_binaries()` is available since Meson 0.55, and we target
> a version >=0.61.0. So should we maybe convert that other callsite to
> use `can_run_host_binaries()` in a separate commit?

I've sent "PATH 3/2" on top of this series. I've found two occurrences
of `not meson.is_cross_compile()` but only replaced one, because the
other is used to guard `fs.exists()` which (as far as I can tell) always
runs on the build machine.

-- 
Cheers,
Toon

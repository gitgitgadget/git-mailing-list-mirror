Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DF17F9
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199577; cv=none; b=t2hnajL+QVjVUIUPT5U/FfSXPrkOYir5Chf6PF5B+Xxzw6sChwvrAozJ5ovPbIT9NJIq/wlYeq/VhATdhgwHNicAiFQfNid++jUocpTA+LMMNXDYfOM4T1O8z8OwXdMYdKdGsbu/6rgVBEOD2ahYXRB5+C+s794yqxkUZK6UGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199577; c=relaxed/simple;
	bh=e18xKanPWysyQaNgAtQvtX9EGxpdOBEzFbCouLjafxc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WHKiGjB1vfrKmEHVNZVElmYGwaPZCyzOXkw/LXr0hkVGW9VdrgZ3+7KzEHUkAPPUJVPnaScT/aq5bcc3HyaEi1CZN+WH0+h2mSH6SqzgCnfcRS+Flfw7RlrX+vYudj3uvTp2FOQeFBsEsJg5Dg/V8Wry49NQxRlLpTmlVps+vvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Ht39xEBw; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Ht39xEBw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1753199572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jRFNeC1VImNOjsnNvLeCuT3BfsFebd8PZDlRHBrVHgI=;
	b=Ht39xEBwWOixdTLzrt/P+iS01/f72jxaHvSS4OlJt21gO4dXiOUGjPzgfqc/Dgg0RrTaxV
	b4d4MSoeYAoQkQimtxm/qArkm3nndH+gWSI84KuMjy1NJeeFFJJzVXgp8g3ROvIpZhnyOS
	EzMfgBFOidiMbnswZdYJQzWoYrwVzsc=
From: Toon Claes <toon@iotcl.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Derrick Stolee <stolee@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/6] t/perf: add last-modified perf script
In-Reply-To: <aHmQiJxfmlbDI+Hq@nand.local>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
 <20250716133518.1788126-2-toon@iotcl.com> <aHmQiJxfmlbDI+Hq@nand.local>
Date: Tue, 22 Jul 2025 17:52:43 +0200
Message-ID: <874iv4kyt0.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Jul 16, 2025 at 03:35:14PM +0200, Toon Claes wrote:
>> diff --git a/t/perf/p8020-last-modified.sh b/t/perf/p8020-last-modified.sh
>> new file mode 100755
>> index 0000000000..a02ec907d4
>> --- /dev/null
>> +++ b/t/perf/p8020-last-modified.sh
>> @@ -0,0 +1,21 @@
>> +#!/bin/sh
>> +
>> +test_description='last-modified perf tests'
>> +. ./perf-lib.sh
>> +
>> +test_perf_default_repo
>> +
>> +test_perf 'top-level last-modified' '
>> +	git last-modified HEAD
>> +'
>> +
>> +test_perf 'top-level recursive last-modified' '
>> +	git last-modified -r HEAD
>> +'
>
> The only notable difference from GitHub's version here is that we do not
> have a recursive option, so our test is just "git blame-tree
> --max-depth=0", which is obviously not applicable here.
>
> What you wrote (testing "last-modified" both with and without the "-r"
> option) makes sense to me.
>
>> +test_perf 'subdir last-modified' '
>> +	path=$(git ls-tree HEAD | grep ^040000 | head -n 1 | cut -f2)
>
> Hmm. This line comes directly from the patches that I originally shared,
> but seeing "git" on the left-hand side of a pipe makes me a little
> uneasy.
>
> We could also use the "-d" flag here, which will only show us trees,
> thus eliminating the need for the "grep ^040000" portion above.
>
> I'd probably write this as:
>
>     git ls-tree -d HEAD >subtrees &&
>     path="$(head -n 1 subtrees | cut -f2)" &&
>     git last-modified -- "$path"

Makes sense, I shall pick this up when I reroll.

-- 
Cheers,
Toon

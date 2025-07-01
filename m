Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAAC2750FA
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378947; cv=none; b=A4JcDy3uzKkVoLhjTPIi/0gsN5NuwsHjCLTXrfAufE9VqmHdaXSKDX4frm+iGpugQMUExuQki440XNkj3bijN+6iDm9M3S/8CsxuKFJaeazTFzDoVFIoLZ5/Tgou5ZKUh5umRlBAik2s8korNht0lJ5MQG5BtAiTAG669DZpWVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378947; c=relaxed/simple;
	bh=zoQ++mWezVC+xyAzTLunirPZXAiGfx/1nga1FBirzHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ih/HDQIx7w+uFewzwWW4JDsfYzcg09KS2p1E9FaAjBSpcSsFhECVEhzmFK0ydUOpQac4uJhQZn5lRMELApOhNaTWstbpohsoI3hVVdA6Io8sk2CfHTnucVsCE45jqnA1C6rE3ZWdBLJWckhgWi4hXxr3yubx7uBlcjnQJrRrLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=vfvuJPub; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="vfvuJPub"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1751378941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KjRPWhgFiWZr393aM5sf+iNiCxpjHKXbB42GSphzlPA=;
	b=vfvuJPub5io/VdwW18yNXLot5l0T7RbKaUhoiYO12H+Pf4dX9oqXztyNhDEPKPirLxNnut
	o65cIcOQjIURagfQPN4runRJLmlAw35bT1JEVyuY6/FMc8mgph0LbiEo/OM4kA5dLslN/1
	YU0oDVXWK3yYjswrsiVdE2t0ra3Icao=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, "brian m. carlson"
 <sandals@crustytoothpaste.net>
Cc: Collin Funk <collin.funk1@gmail.com>, git@vger.kernel.org, Karthik
 Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>
Subject: Re: .clang-format: how useful, how often used, and how well
 maintained?
In-Reply-To: <xmqqbjqi5tk3.fsf@gitster.g>
References: <xmqqmsa3adpw.fsf@gitster.g>
 <aFR-Yf0PMj30ex2O@fruit.crustytoothpaste.net> <87msa3quzs.fsf@gmail.com>
 <aFSVhpnNnj6p3r7n@fruit.crustytoothpaste.net> <xmqqbjqi5tk3.fsf@gitster.g>
Date: Tue, 01 Jul 2025 16:08:52 +0200
Message-ID: <875xgcq9zf.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> Yeah, then in that case, we probably want to ship some sort of container
>> and script that can do that.  Our default Rust target is Debian stable,
>> so that seems like a decent target if we need to pick a distro.  It's
>> also a very common distro used in containers, so it's widely available
>> to contributors using container-based development environments.

That sounds like the ideal solution.

>> I still think that if we're going to have this functionality and expect
>> it to be used, we need to make it the default, build appropriate
>> tooling, and check it in CI.  If it's not fire-and-forget, people won't
>> use it.
>
> There probably needs some balancing act, as I already pointed out,
> what clang-format gives often do not make sense, and the point is
> that they are not about styles (where we can safely say "no style is
> liked by everybody") but about how readable the result is (which
> sometimes is subjective but more often it is not).  Until the tool
> and its configuration is polished enough, blindly applying the
> result with fire-and-forget mentality will degrade the quality of
> our codebase.

Allow me to share an unpopular opinion. I think you either fully commit
to a formatter, or you don't care about formatting at all. I realize
that's probably overly strict for most people, but I've been working
mostly in Golang for several years, and having a tool that formats code
and it's output is unarguably the standard is a bliss.

I think the only way we can stop bikeshedding about formatting, is by
adopting clang-format and make it's output the golden standard. We might
not like it's output (similar to many people do not like `gofmt`s
output), but it's a standard. If we have to wait for clang-format to
support all the configuration options we prefer, we will be having this
conversation over and over again over time. I don't think that's worth
it.

Code formatting should be the job of an automated tool, not a person.
It's annoying to have this back-and-forth in reviews because it's not
following the standard _the Git project_ has set, while it would be a
lot less friction to follow a standard that's set by _the formatting
tool_.

-- 
Cheers,
Toon

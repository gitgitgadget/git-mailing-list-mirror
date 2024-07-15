Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADC113792B
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721068423; cv=none; b=ctzqBVtANtGrwoALVsMrEoWrdSvVvfuUBaurys7mYPagvgT8mL0+KiBcSTW9vpfJiBSgH86PRW9GTewcZHH4TdqpjSWZSwVquoaQv1U3JcY4vf9J6kubbwWWbdMndlVDCWXMvJShmMDzx53+efesus3Bg6xHgrEewfsSVvbQTZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721068423; c=relaxed/simple;
	bh=7JVFtOj8UoDsbSdCgsY629ZoN21SvMHcvZJuYHdMbjg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rdb9+WNJuRDqP7AkvvEZQYqF+pVFMcxRuM9RD3BCRjh/zs9XsEyX6OkjN7JHveOhyJT3o5BE2WJz5CVaqV35qLosOSYZ+Kzm+jCD9DqcsTzNDp08THdAHUS/OIi6IC7gPPSHGefb07Czt6NIw3jM6wHhl1xhJCWJewX+YVaLMG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OcT5TYP2; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OcT5TYP2"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 651E72C5E6;
	Mon, 15 Jul 2024 14:33:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7JVFtOj8UoDsbSdCgsY629ZoN21SvMHcvZJuYH
	dMbjg=; b=OcT5TYP21qsptrjEAaskBAZemtX03DMUKYuS2R5Gd7gESKGCBie8/X
	FMk7QfdXKp0YIQO4R34+rYquNnnpvPwTM+zO63spnfu+BdRvD1dI37VMHac2Jg/w
	DP+QPOcEmN1CNIa5BnStwrsMYT+6cKciOj24eYQL35nIb3mmtSa+A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D3F42C5E5;
	Mon, 15 Jul 2024 14:33:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 811B62C5E4;
	Mon, 15 Jul 2024 14:33:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'brian m. carlson'" <sandals@crustytoothpaste.net>,  <git@vger.kernel.org>
Subject: Re: [Test Breakage 2.46.0-rc0] Test t0021.35 fails on NonStop
In-Reply-To: <00c001dad6dd$f336c3e0$d9a44ba0$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Mon, 15 Jul 2024 13:39:25
	-0400")
References: <024101dad543$221b4ab0$6651e010$@nexbridge.com>
	<xmqq8qy4adl4.fsf@gitster.g>
	<001f01dad5f1$e518e6e0$af4ab4a0$@nexbridge.com>
	<xmqqttgr9aeb.fsf@gitster.g>
	<ZpQVwyVQT8Wf5AeX@tapette.crustytoothpaste.net>
	<004501dad61b$b35b7f30$1a127d90$@nexbridge.com>
	<ZpRKu8Xsz70xNHFp@tapette.crustytoothpaste.net>
	<xmqqv8167kd8.fsf@gitster.g>
	<00af01dad6cc$41f10d40$c5d327c0$@nexbridge.com>
	<xmqqh6cq4ngc.fsf@gitster.g>
	<00c001dad6dd$f336c3e0$d9a44ba0$@nexbridge.com>
Date: Mon, 15 Jul 2024 11:33:35 -0700
Message-ID: <xmqqsewa33pc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C01F96D2-42D8-11EF-9E7B-C38742FD603B-77302942!pb-smtp20.pobox.com

<rsbecker@nexbridge.com> writes:

>>As I speculated earlier in an earlier message, the breakage you reported
> may have to
>>do with interaction between "local" and use of a subshell, and perhaps we
> can also
>>check that pattern in the test.
>
> That is that I am also suggesting but did not say it as precisely. Thanks.

Oh, I see.  Are you volunteering to come up with a minimum addition
to t0000.1 then?

Thanks.

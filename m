Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77215232
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705448410; cv=none; b=ex3SAnU/YM+0LK0yzWPUk1o701NSKep7tNDcDnNCAfywDueEDig0y7dPAxjnxjty3+h+BN/trZ9jRZCp5OaTQ7F8SVGjEpz+D3DRKFA2Gs2vf0i4zu3Tbf1uNokglGu4RvF3ylZhgEEPZcD69KOeBky2DAE9IH/rfhl5ROZZRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705448410; c=relaxed/simple;
	bh=CRnsjdnZnHxjpxo5B0xhklAsscr0u/qDKxuz/1onTok=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=UOR1dTnQYA3V5OIEogoKhelfYJZC9DfPtgocw3K0meehLfGdLqdtsOLdVKtb1zqJd3L+L0C0AjDq+SlURzqB/VFOcnCc8GeqkcykFe94CrXZ6JiOU8c8st9J9bcCPIvzE2PZO4hjgbya0d52R86E8y9O2VQpVkHr2Xgr5rTath8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mVky/UAc; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mVky/UAc"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2566C1B8868;
	Tue, 16 Jan 2024 18:40:06 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CRnsjdnZnHxjpxo5B0xhklAsscr0u/qDKxuz/1
	onTok=; b=mVky/UAcV+Ql3GB6uNX4GiiHXX0DjhikKV0phyYG98GZHo822HxhHu
	o4PnaQf30WJ/RS2jaodoSULxVHLR+NdJ47dUUI/QZhkzZwUTMDf6P//50HAHEyqz
	lOpsQq6a6QWH0K7dqJv2lmjwZyoN4q5iQLvzU1bO76Ug4dXctmD00=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 99C1C1B8866;
	Tue, 16 Jan 2024 18:40:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 95DA61B8865;
	Tue, 16 Jan 2024 18:40:04 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 2/4] test-tool run-command testsuite: support unit
 tests
In-Reply-To: <xmqqv87sx3y2.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	16 Jan 2024 15:18:29 -0800")
References: <cover.1705443632.git.steadmon@google.com>
	<5ecbc976e6216b941e760e096e166ab432ee7784.1705443632.git.steadmon@google.com>
	<xmqqv87sx3y2.fsf@gitster.g>
Date: Tue, 16 Jan 2024 15:40:01 -0800
Message-ID: <xmqqil3sx2y6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 92EA2126-B4C8-11EE-941D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Josh Steadmon <steadmon@google.com> writes:
>
>> Teach the testsuite runner in `test-tool run-command testsuite` how to
>> run unit tests, by adding two new flags:
>>
>> First, "--(no-)run-in-shell" allows the test-tool to exec the unit-test
>> binaries directly, rather than trying to interpret them as shell
>> scripts.
>
> Makes perfect sense.

This may be a stupid question, but do we even need the current "push
'sh' to the strvec"?  If our executable shell scripts run just fine
without, then this may not have to be conditional.

Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2835E18C333
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141426; cv=none; b=kbl6jGyzU3b6VpXQ0816LKXrjUX4M0wQD6WtdrBGaMUxwrCI30/e6EFp3C225Bkl/FX7PV/OXONxIItIU/u7JPWFoiyjW8Y0a+9kpEGkXEuET9YZcI6IYYE+PMiWiC4zk842x3RpqHRTAd1p0ofiAEL69EgBeVga1FfY0lFIbzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141426; c=relaxed/simple;
	bh=7shfIita+UwARSnEW4LINgxbLc6qxk0hUgN3zQ0ej1U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGL07iEq9kjvD+K7jwC0FXAjwnOOHfn53OUdEn1S9d3AeCo2AZMJbnhW9hjmb0PFUASg895Fe6pGpyyn4vKMKj37ScVcRtU2Ize5B5ChabqWIE2kc5JDhdapUxwMcnOjMfXp8erntMB+XM6pcxd8WQk7sA1OsumomdncfEUYCiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=CZtcjAV2; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="CZtcjAV2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730141417; x=1730400617;
	bh=7shfIita+UwARSnEW4LINgxbLc6qxk0hUgN3zQ0ej1U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CZtcjAV2MycscnRdwO0vE+oHiWUQJ1DoF/zhJdq20PLrEeZ6o7LTozpFJc87VDbiL
	 vrb05ghAJWhqKe0lHxXuey4weBQ1ORg8huuvh4E51O8Rgjdx0D1K0Jgc8fYo7rqES6
	 3WosGPyneuqocumnvDHb6NqzZEnb3EF9UsvuNAVS0Q7cmxfJ0/CWEy8BbrJNiKz7FE
	 8KXWHLdxgQ840ISW/th9SG08l7fX57La0MQmdgclaRTNS2Ifq9PZiIZCb51rZHNy0q
	 slTa9YyR9E2ueVMGYCWclXu5lgPFzZOgDqU4/6tlYkf6OixgNZd9+jF3O0wKWl/Ble
	 rl0M86We5k6cg==
Date: Mon, 28 Oct 2024 18:50:12 +0000
To: Taylor Blau <me@ttaylorr.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>, shejialuo <shejialuo@gmail.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 1/2] worktree: add CLI/config options for relative path linking
Message-ID: <D57NXXVF7BEW.2JASTW8099JUI@pm.me>
In-Reply-To: <Zx/B3caIgAeAv6Kz@nand.local>
References: <20241025-wt_relative_options-v1-0-c3005df76bf9@pm.me> <20241025-wt_relative_options-v1-1-c3005df76bf9@pm.me> <Zx7YFPE5tjr/bn2s@nand.local> <Zx7cKN9X56GrHrU/@nand.local> <D57L2P544W08.2MHA3Q38UBPEO@pm.me> <Zx/B3caIgAeAv6Kz@nand.local>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: b960047f0a7909d38b021a743a12cc386ac2d640
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Oct 28, 2024 at 11:54 AM CDT, Taylor Blau wrote:
> On Mon, Oct 28, 2024 at 04:35:22PM +0000, Caleb White wrote:
>> Thanks for catching this, the issue is that there's a bug in the
>> `initialize_repository_version()` function when reinitializing a
>> repository---the function doesn't check if there are other extensions
>> in use before downgrading the repository version to 0.
>>
>> This is a rare edge case, but I'll work on a fix.
>
> I am confused... are you saying t0001.46 is flaky? I don't think that
> it is, as it fails consistently for me with your patches applied when
> ran in a loop.

No, the test is not flaky. Adding the extension just revealed a bug in
the code that was not caught by the test suite. I've fixed the bug and
will push v2 here shortly.

> I am definitely guilty of having sent broken patches to the list before
> that fail CI, usually when I have amended something I thought was
> trivial after already running the test suite on all patches, only to
> realize that it wasn't trivial after all and instead broken something.
>
> But please do be careful to thoroughly vet your patches before sending
> them to the list, as this sort of breakage can be disruptive.

The test suite was passing, I must've just forgotten to execute this
again test after I added the extension. I'll be more careful in the
future.

Best,
Caleb


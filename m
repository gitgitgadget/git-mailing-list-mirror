Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED30D1DFF0
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721232909; cv=none; b=n79RATH/Xoh74VY0ELHMd4dPrUkQsBpS0AeCxAssLR+AItqCOjO/r9kVlc8vSIBRdlVb/rIIUsutU5NBZx8T3nN1dddonuDYvA6KXiHqbb7fSdib6+PXJ3onMJsxmzp/kRHn2bWO221KweTzbYI8Hq1R3q6yT20cakefd+gb8ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721232909; c=relaxed/simple;
	bh=eZPTqSFAX+z+USk9xjW5TYQ3UP7DdlpZRRlZwfWGJL4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I01qeSR7XRIlNyL4lEIwQmqYDXut+gr5NQw62swcKtTu8DI1ZmU+AvWM5MymQvJXbujINy6dZPPl1CgmRYvWwL5sexN69LJ6UNDa6VGSwLhB4EIbr2ZB/CDPzRPt98enoBPxrq1dyFkIHqHkJz71mP/PwlwvebLRB5ElOYr3xxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zcj0O8j+; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zcj0O8j+"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 316D220707;
	Wed, 17 Jul 2024 12:15:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eZPTqSFAX+z+USk9xjW5TYQ3UP7DdlpZRRlZwf
	WGJL4=; b=Zcj0O8j+Hu8aDePsHahJrcRh+RKthP8LGCUcep4znXrDN9l6qZT4Bo
	cx7eMu8U/P80t541QwdlNudLswtm5QLQj2GiSDu0BuPH1DMGjVmQ4P/2ODR8Y/ru
	PaBzR/ubUGMLoKn+Z+zXV8XUiMxIs4L2iPwkfwrr5z+NZjKhO4i/c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F7AC20706;
	Wed, 17 Jul 2024 12:15:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2B51C20705;
	Wed, 17 Jul 2024 12:15:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] checkout: special case error messages during noop
 switching
In-Reply-To: <CANiSa6hs1AEp1e+o0hT55DvCwPe2EUyU1EXg1E4BKCkeuEOPvw@mail.gmail.com>
	(Martin von Zweigbergk's message of "Wed, 17 Jul 2024 18:05:13 +0200")
References: <xmqqikxnqzz4.fsf@gitster.g>
	<CANiSa6hs1AEp1e+o0hT55DvCwPe2EUyU1EXg1E4BKCkeuEOPvw@mail.gmail.com>
Date: Wed, 17 Jul 2024 09:15:03 -0700
Message-ID: <xmqqttgo3shk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BA67B05A-4457-11EF-97D3-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Martin von Zweigbergk <martinvonz@gmail.com> writes:

>>  * Yes, the end-users are irrational.  When they did not give
>>    "--ours", they take it granted that "git checkout" gives a short
>>    status, e.g..
>
> I actually did not even know that it does that :) I'm a bit surprised
> that it does, especially since `git checkout <non-HEAD>` doesn't seem
> to do that. But that's off topic.

It does but you wouldn't know unless you have modified paths.

Also checkout and switch would only allow checking out another
branch when these modified paths are the same between the original
HEAD and the other branch.

        $ git reset --hard
        $ echo >>GIT-VERSION-GEN
        $ git checkout
	M       GIT-VERSION-GEN

With a modified file, no-op checkout, report only.

	$ git checkout next
	M       GIT-VERSION-GEN
	Switched to branch 'next'

With a modified file, checkout another branch, with report.

	$ git checkout maint
	error: Your local changes to the following files would be overwritten...
		GIT-VERSION-GEN
	Please commit your changes or stash them...

With a modified file, that is different between next and maint, fail
to checkout the other branch.

Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B72E188017
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725569883; cv=none; b=tnUF6HSgubkLxgTwENd4dpcDu7RafV8++sU4nzssem6eiuQYOBprc4UTUoYBIB4fXWOib6tZfN3oBqAoeHyvVWDdkGD40KJLplmkWhQhuGKrCyp03JKLRgagMqSg2fB9u9JKF9ajnDRBplVF/rr9FPnmgSxhCqPK9Nx8tHLaJpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725569883; c=relaxed/simple;
	bh=PsfUuEsCMYlGa6nlVJrlQQE1b/hmm9mPNeD7Hm1VoAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ga0GN3WkdptAqPXnIPPgeF2sTEji59TUmxQgnkfR6NIpWunYMP5sXVzKfDkcramgQOPYkU+vouajnYTT/0YX/CK9wfEvV53K3NqzABH5GiHRp7XALblIn91Ik+lV2bHT34/zJ1JgrS9VkLIQkQ2eYX+fQLkEt8g6qpWsLvQnkPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hqiAbVqB; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hqiAbVqB"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E7B728F39;
	Thu,  5 Sep 2024 16:58:00 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PsfUuEsCMYlGa6nlVJrlQQE1b/hmm9mPNeD7Hm
	1VoAs=; b=hqiAbVqBZAhIQ+mdkLhisGW3y98kVH9YA5fh57kyA5MlIg29Hye9hm
	ogoj1xr9lBzTJIVaa7tmUoiE2l6IS1TwR83baxm7tHmFpK4edXu+Ix0tdzcUdpTi
	CEzdsw5THwTD3oxxjVYTVBVsc9di5Lp4R1FMMsKu5gioprDpdgNxQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 571E828F38;
	Thu,  5 Sep 2024 16:58:00 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A97F528F37;
	Thu,  5 Sep 2024 16:57:59 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "Patrick Steinhardt [ ]" <ps@pks.im>,  Derrick
 Stolee <stolee@gmail.com>,  Shubham Kanodia <shubham.kanodia10@gmail.com>
Subject: Re: [PATCH v4] remote: prefetch config
In-Reply-To: <pull.1779.v4.git.1725565398681.gitgitgadget@gmail.com> (Shubham
	Kanodia via GitGitGadget's message of "Thu, 05 Sep 2024 19:43:18
	+0000")
References: <pull.1779.v3.git.1725554758463.gitgitgadget@gmail.com>
	<pull.1779.v4.git.1725565398681.gitgitgadget@gmail.com>
X-Gnus-Delayed: Thu, 05 Sep 2024 17:59:52 -0700
Date: Thu, 05 Sep 2024 13:57:58 -0700
Message-ID: <xmqqwmjpzull.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 88A8904A-6BC9-11EF-914C-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Shubham Kanodia <shubham.kanodia10@gmail.com>
> ...
> In a future change, we could also allow restricting the refs that are
> prefetched per remote using the `prefetchref` config option per remote.
>
> Both of these options in unison would allow users to optimize their
> prefetch operations, reducing network traffic and disk usage.
>
> Signed-off-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
> ---

Looking good.  Thanks.

Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9CB1E884
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 21:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263344; cv=none; b=KRsiHZFVpB+kkv2sRdUGX6eigW2S0MMuQwKyId7+tYbtWibBbEzOJV6X2uy//45tCYuvrxQN+H7l0fLE2uSyrGxWy60VC6RUPR7h8T2EwmTZsjnWHgdenIhNRGH917KedoYIcbU19RWXDcFDQZ3xDGPU16ZoKaqDE+0UfVK84IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263344; c=relaxed/simple;
	bh=6f1SUiNTs9K1IX8LhxuAJPYNX0Q2iAVJHLqyhU7q71U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qv3b2Aqtqo6Pe37zvQb7GPNhx58W029y4TqGp/kI5dhAH8IeaDR0oIohia8ypikIqvPtLNrDPyM9cdhtHe5hiIIGkIA1yinq4ANOu7+Sg85FMtcQkvVhHrZq6mso16W/9EytUYTg4E5zcpRZZgFn+Z7q8ph5+INXsP/wa/ob/9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SC/8BP4M; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SC/8BP4M"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1930C2AC34;
	Fri, 13 Sep 2024 17:35:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6f1SUiNTs9K1IX8LhxuAJPYNX0Q2iAVJHLqyhU
	7q71U=; b=SC/8BP4M+BYptXFhEsLdgGMcoFXLRAXgLZpNraJiyrsDXl74roj7uA
	eWKKfvX6alEsAihaXKg7tvZhmt0vXO3dVIF4eqwZUbRFsjg98ZVPt5LuqaBw7Vqv
	FO4+lBX6c4Wu1VOzgM+jHnnei5S+izyivYC/SYWpMUpAPsk0x8LAA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F44E2AC33;
	Fri, 13 Sep 2024 17:35:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 720822AC32;
	Fri, 13 Sep 2024 17:35:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 4/4] add: pass in repo variable instead of global
 the_repository
In-Reply-To: <d32f8ade1e0b11f802f831da00058dbdb4bd2aa5.1726262178.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Fri, 13 Sep 2024 21:16:17
	+0000")
References: <pull.1778.v2.git.git.1726001960.gitgitgadget@gmail.com>
	<pull.1778.v3.git.git.1726262177.gitgitgadget@gmail.com>
	<d32f8ade1e0b11f802f831da00058dbdb4bd2aa5.1726262178.git.gitgitgadget@gmail.com>
Date: Fri, 13 Sep 2024 14:35:39 -0700
Message-ID: <xmqq8qvvw82c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1F7D5B8C-7218-11EF-B21F-9B0F950A682E-77302942!pb-smtp2.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> With the repository variable available in the builtin function as an
> argument, pass this down into helper functions instead of using the
> global the_repository.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  builtin/add.c    | 116 +++++++++++++++++++++++++----------------------
>  builtin/commit.c |   2 +-
>  commit.h         |   5 +-
>  3 files changed, 68 insertions(+), 55 deletions(-)

Looking good.

Let me mark the series for 'next'.

Thanks.

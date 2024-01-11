Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC9336A
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fkZ9CPHM"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BA968194C3;
	Wed, 10 Jan 2024 19:36:16 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pvMOExF2hQMxjNBeCNPFa8XzWJdX9bIgqd4VcR
	1gsQQ=; b=fkZ9CPHMRCgyDxM10MShKt65wROHNCAG2kKV9EY/PfG7Ux2MjCyl2Z
	cBSllVfC20qGTYlPxf2g/RBVIOcoUC7hK7x4TuyjXcFJmf6IZ2vS5VbHjbcy2L8L
	HsQp/ZF0vErr946OahAt7T5RlURvdFcqRSI+6Utrv5S3FljzO+GWE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B2D91194C2;
	Wed, 10 Jan 2024 19:36:16 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 86C41194C1;
	Wed, 10 Jan 2024 19:36:12 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 0/2] Generalize reference locking in tests
In-Reply-To: <pull.1634.git.1704912750.gitgitgadget@gmail.com> (Justin Tobler
	via GitGitGadget's message of "Wed, 10 Jan 2024 18:52:28 +0000")
References: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
Date: Wed, 10 Jan 2024 16:36:10 -0800
Message-ID: <xmqqv8807ll1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6BE192D4-B019-11EE-BD61-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This approach is more verbose and may warrant consideration of implementing
> an abstraction to further simplify this operation. There appears to be one
> other existing test in t1400 that also follows this pattern. Being that
> there is only a handful of affected tests the implemented approach may be
> sufficient as is.

The use of two fifos and avoiding deadlocking parent and child is
tricky enough that it does feel that it warrants a helper function
to do the common part of what these two patches add.

I think I read t1401 patch carefully enough to understand what is
going on, but I cannot yet claim the same for the other one.

Thanks.

> Justin Tobler (2):
>   t1401: generalize reference locking
>   t5541: generalize reference locking
>
>  t/t1401-symbolic-ref.sh    | 28 ++++++++++++++++++++++++----
>  t/t5541-http-push-smart.sh | 25 +++++++++++++++++++++++--
>  2 files changed, 47 insertions(+), 6 deletions(-)
>
>
> base-commit: 624eb90fa8f65a79396615f3c2842ac5a3743350
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1634%2Fjltobler%2Fjt%2Fbackend-generic-ref-lock-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1634/jltobler/jt/backend-generic-ref-lock-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1634

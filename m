Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6124F5CDC8
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571733; cv=none; b=YJYrXHfV4yU6f32O9QI+q6C6P5lKlHWqHmlkfopvKvDqlPVmlIBcEt5jPmFHIVzNd03jAQCQGQKxg4x4o+DRvUcsff9FOie6Jur/3hEiQmJtcDNrx8mp0kUc7fnwiCLiYeNuLPYN0rHHkR6AUTUD+4I2y8a/BeZjCqyMrlEmMPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571733; c=relaxed/simple;
	bh=7jeR2adCj1Doa1jHqMIETlChG3Dmvkj6OotYRocOeRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MGvqxj6k44eAlRdkIAnCn0pnwqJy2RFVC3/YKf0zmFPZbwuSLussGvmBhak1OefAxi9vuFMuRhwbCDd54F2oOl0wP6YSK7UI7K8SpOOk/mjXHrZCvKt8RocgoBkwM/ebqBdt0jWLDRDpRpal7NiwSZJRoED2piWr2knaVV2OcMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xnNKyiEr; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xnNKyiEr"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 67A771CE35E;
	Mon,  4 Mar 2024 12:02:06 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7jeR2adCj1Doa1jHqMIETlChG3Dmvkj6OotYRo
	cOeRY=; b=xnNKyiEr72+K+wHMaYXIOew0eLdDKKe8kvqoF3AvNVZUJKnpvLWMWB
	KTM4Q+BE5uCLWfg5HNUJ0on2w1ZQe6O6rl20JzJcUYLNLWkdY63b2X3UYLflKRQ9
	KoJeiqH3mjzzwUSC+u2Rhxcr3ogIFdWFjMGHIIbE+Kf9Vxr5njROE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EE2E1CE35C;
	Mon,  4 Mar 2024 12:02:06 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66AA51CE35A;
	Mon,  4 Mar 2024 12:02:05 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH] SoC 2024: clarify `test_path_is_*` conversion microproject
In-Reply-To: <84995a068640c72c8f17406ffa0441c7fdba4bdc.1709543804.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 4 Mar 2024 10:16:55 +0100")
References: <xmqqzfvjf5tq.fsf@gitster.g>
	<84995a068640c72c8f17406ffa0441c7fdba4bdc.1709543804.git.ps@pks.im>
Date: Mon, 04 Mar 2024 09:02:03 -0800
Message-ID: <xmqqo7buq6b8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EDA7A5D4-DA48-11EE-9739-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> One of our proposed microprojects is to convert instances of `test -e`
> and related functions to instead use `test_path_exists` or similar. This
> conversion is only feasible when `test -e` is not used as part of a
> control statement, as the replacement is used to _assert_ a condition
> instead of merely testing for it.
>
> Clarify the microproject's description accordingly.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  SoC-2024-Microprojects.md | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/SoC-2024-Microprojects.md b/SoC-2024-Microprojects.md
> index 644c0a6..782441f 100644
> --- a/SoC-2024-Microprojects.md
> +++ b/SoC-2024-Microprojects.md
> @@ -41,7 +41,10 @@ to search, so that we can remove this microproject idea.
>  Find one test script that verifies the presence/absence of
>  files/directories with 'test -(e|f|d|...)' and replace them with the
>  appropriate `test_path_is_file`, `test_path_is_dir`, etc. helper
> -functions.
> +functions. Note that this conversion does not directly apply to control
> +flow constructs like `if test -e ./path; then ...; fi` because the
> +replacements are intended to assert the condition instead of merely
> +testing for it.

Thanks for picking it up.  Of course there is one case in which we
should use test_path_* helpers to replace such an if...then...fi
construct; e.g., c431a235 (t9146: replace test -d/-e/-f with
appropriate test_path_is_* function, 2024-02-14) did exactly that.

I am not sure how best to express that in the already crowded
description above, though.  Rewriting the existing test this way

	Find one test script that uses 'test [!] -(e|f|d|...)' to
	assert the presence/absense of files/directories to make the
	test fail directly with the exit status of such "test"
	commands, and replace them with the appropriate helper
	functions like `test_path_is_file`, that give more
	informative error messages when they fail.

would exclude use of "test -e" as a conditional in control statements,
so we could mention what c431a235 did as an exception to the rule,
perhaps like

	Note that the above excludes "test -f" and friends used as a
	condition in control statements such as "if test -e path
	...", but as an exception, if such a "if" statement just
	open-codes what these helpers do, replacing it is warranted.

But that does not read very well, even to myself.  Sigh....

Thanks.

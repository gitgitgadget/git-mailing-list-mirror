Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76D6168BE
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 21:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726869423; cv=none; b=en/Z3XO5OlFUaLkhl6s5PD+8iV5FBfIQI71dH4TEmcRY0RG45zUsuM8EjSZwuTpjEIO8wG2JXTlIRESwwV4Wzb5E3d1Qo5STsMyhTYpRqX8uqu3SCr0qyhrcsPzkF3fWXWE4mtYhbOlTABNKkjVubJCcZ/ZWUZPKM8Qm621JLQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726869423; c=relaxed/simple;
	bh=C0jvaSOXMXaZKcACCDWdM/mJ2SkImX27X77GG6udqiE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uw3f0tKQMVocPORLqXmc4MOhF2J0D+K+jMW8EnPXS+o4T6HfquMdD83qX28Rd8kC/Grurk2X1DttTscMPfWRO7NL08+C1LmAFWXvl/9dFgq/AHk9s6CjWOMYBMRWDEeVBdtVBx2nms678XKNTgvkTeJeT+RxSKeLvwgKbf+NgA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eh/OFLRC; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eh/OFLRC"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 370E41FFD7;
	Fri, 20 Sep 2024 17:57:00 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=C0jvaSOXMXaZKcACCDWdM/mJ2SkImX27X77GG6
	udqiE=; b=eh/OFLRCX/h2EDlYHSs8bQCPkDpvXho4auHpnNBB8giqGMolVT5Zzi
	Z6Ucybf+ffsqOnuOgFiuaPWFhK4/UqmiDl/a26pAByt48DLu5Cekacu/SGAQVLv5
	FoRDAq+ZET/YGpe9M0V4d2QJoHwE8nro6jaQ0DOqWX2vs007gS5co=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A67F1FFD6;
	Fri, 20 Sep 2024 17:57:00 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F4831FFD3;
	Fri, 20 Sep 2024 17:56:59 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  liuzhongbo.gg@gmail.com,
  Johannes.Schindelin@gmx.de,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/3] maintenance: configure credentials to be silent
In-Reply-To: <pull.1798.git.1726790423.gitgitgadget@gmail.com> (Derrick Stolee
	via GitGitGadget's message of "Fri, 20 Sep 2024 00:00:20 +0000")
References: <pull.1798.git.1726790423.gitgitgadget@gmail.com>
Date: Fri, 20 Sep 2024 14:56:58 -0700
Message-ID: <xmqqfrpudm51.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 42CB67EA-779B-11EF-A68F-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Add a new configuration value, 'credential.interactive', to specify to the
> credential helper that it should not prompt for user interaction. This
> option has been respected by Git Credential Manager since 2020 [1], so this
> is now presenting it as an official Git config value.

So, the other helpers are also supposed to check for the variable
and fail when it has to go interactive now.

> These changes were first merged into the microsoft/git fork in August 2023
> [2] but were not upstreamed immediately. The change has been a positive one
> for users of that fork, as they no longer get pop-ups and they also are not
> getting maintenance.lock file blocks when the prefetch task waits for
> credentials. This has become even more important recently as credential
> lifetimes have been restricted significantly, leading to a higher likelihood
> that this will happen during a background prefetch.

Sounds good.


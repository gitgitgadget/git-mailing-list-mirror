Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CD981AC0
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325110; cv=none; b=mf5PYu0pzmsoSzCa+m3JeHD0PO5J456fYqxeyTtRTZtM3nCvzeLMwyv3fQE65MXzTtiGKVKuGhImsS6Uq5CcVOJUGMb6GDHlap2l2ZHxnsAGZ5Z+ag1mznZUWx3pST7WhBzRI5DJWqq2MiWUH8AUS9/Hb9EBVYuJtZcgvL0otyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325110; c=relaxed/simple;
	bh=QmAlCOyLMv8+eOdXVR8nwdDzsmny67nhe0I5dJKOr4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mx2aDIXJACqAdaS5vwrkrbfnQ0ayJNCArbD7FwN23MP806RLZBIBHCmZEQ7TBeFTKlOEldkJPJMeBdUuYJeHw3IL2jGUkr4eIRDoXV5AQO6SZ4quVb4G9jZdeOB7qXkAcOtOmrh+5Atj4TqulnZ7ISTQ5paGd7nSQxcl4YaZza8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OHbLPj8K; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OHbLPj8K"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 19BCD1D7599;
	Wed,  7 Feb 2024 11:58:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QmAlCOyLMv8+eOdXVR8nwdDzsmny67nhe0I5dJ
	KOr4Y=; b=OHbLPj8Kmt0u5FUK01rWIXd4LV8RVqdEfznF0XGkieAHDQmT66A+IG
	sJJM4YH5qo6QAfSj20J38295DiHnNu5x+v3lpF4c9GNApZogY5vWar8lHd/skqVv
	7sCEeLgepKxqEm1oJSgWeUoEsi5tsnKxrXULJQTmjGE9qrQpye6Vo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FC271D7598;
	Wed,  7 Feb 2024 11:58:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 631BE1D7596;
	Wed,  7 Feb 2024 11:58:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 5/5] cache-tree: avoid an unnecessary check
In-Reply-To: <43c04749513d07733f5fa2c15a694d99d31fe6e3.1707324462.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 07 Feb 2024
	16:47:41 +0000")
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
	<pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
	<43c04749513d07733f5fa2c15a694d99d31fe6e3.1707324462.git.gitgitgadget@gmail.com>
Date: Wed, 07 Feb 2024 08:58:25 -0800
Message-ID: <xmqqwmrgb49a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1C5A1188-C5DA-11EE-A6ED-25B3960A682E-77302942!pb-smtp2.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The first thing the `parse_tree()` function does is to return early if
> the tree has already been parsed. Therefore we do not need to guard the
> `parse_tree()` call behind a check of that flag.

Makes sense, and it doubly makes sense to keep this separate from
the change done to the same location in [4/5].

Will queue.

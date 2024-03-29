Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218523C68C
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711691205; cv=none; b=TWwCLatZDSmfpgXSdzxDgsNkfLjva6ksRpPJjX9okvxaG0sc7IGKjwgGHiF756nr/v/NtqIztQK0uYvTOLF7ti7bN0/+dOZILXXD7brmmY9sJP06yBLKf2new1HUJxvIdjni14IMPID25SGGf7YMnlEK0Gc++LgeqpeFbAKvE3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711691205; c=relaxed/simple;
	bh=HF+xEsCkDAWvXf5Lfov8w17N133mzgBoFFWLmgcVR1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uJMhByl53FUhi0Qf06c+FoACWqSVZwXzjOXeUBkFxmRGmBbiN8LQOQ7BhfwvWgOMnYMGH7f7w3SrKe7o/EAriYxYhy8ykOI+4LO05IPExnQTJplDTqJ+ATsXGQCQqvvPRchnXPvV+4wWou0i8oiB5cswmsOP6kPA656qCe8akj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mPbBEvGl; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mPbBEvGl"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C48321F0546;
	Fri, 29 Mar 2024 01:46:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HF+xEsCkDAWvXf5Lfov8w17N133mzgBoFFWLmg
	cVR1E=; b=mPbBEvGlblmfSlJ+0MKOb1txM8O05bDZx2eGW+CNHl7JMu4vG3wRgP
	fOpUlV36DnhESFdSdUh/j7QQbdtvj/awH+LbmwRrnP6um57s6Z4IMiblDjPzbT4l
	RQKFB4MfMORKEWstHPFtHi75M109treWLnLAKjbh3m7R/R6foe9qU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ACE6C1F0545;
	Fri, 29 Mar 2024 01:46:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C7F41F0544;
	Fri, 29 Mar 2024 01:46:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: vk <g@vkabc.me>,  Karthik Nayak <karthik.188@gmail.com>,
  git@vger.kernel.org
Subject: Re: [GSoC] Microproject help
In-Reply-To: <ZgO-W3E-CeT3n7vl@tanuki> (Patrick Steinhardt's message of "Wed,
	27 Mar 2024 07:36:11 +0100")
References: <51647635a10e31e800f87e8bd4a2e62c@vkabc.me>
	<CAOLa=ZRrmyZ48C5r8MWioyjySWdKtLxhtDBg5F2tRsExHaR-fg@mail.gmail.com>
	<a344deea98bdd2daa7671fae45c0bf11@vkabc.me> <ZgO-W3E-CeT3n7vl@tanuki>
Date: Thu, 28 Mar 2024 22:46:35 -0700
Message-ID: <xmqqo7axvbd0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B49C740E-ED8F-11EE-ACAF-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Hint: the `maintenance_task_pack_refs()` can in fact be converted to use
> `refs_pack_refs()` instead. I was briefly considering doing that in [1],
> but then didn't want to do such an unrelated refactoring in an already
> long patch series.
>
> So if you decide to do that you should probably build on top of my patch
> series to avoid conflicts.

As the microproject is a learning experience for skills to work well
with others, we may want to suggest an area where there won't be
much conflicts, i.e. skill to find an area that are relatively
quiescent to avoid stepping each other's toes.

To be quite honest, I'd rather not to see a task that uses
run_command() API and gets done in safe process isolation turned
into an internal call by pure amateurs, unless competent mentors
go through the change with fine toothed comb and make sure there are
no unintended consequences and side effects of doing it in process.
This is especially true for microprojects, where the primary focus
is about learning the process of contribution and working with the
community, and not about learning the existing codebase and API.

Thanks.

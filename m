Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7D7C2FD
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555153; cv=none; b=XbqoudyZWOU+qSvk6GPMBwcyBOQNFjdthEr6dy/XcIuCxs7xxOC7KCHlhOmHW8By52HplepvT6ev8+/X9IeXqk7hgdDbs+UaUa6+1EzPUrO3xior4tvl0LNRYjTt4GKq89M9TgKlqwDOgi4O+DL3f2T/QHL0sedpS6hjHyQFLDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555153; c=relaxed/simple;
	bh=FrYrRPv6ziyiFersz7aWBoV2YnvA5HQSQNRbaFltCdY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LdcEu4xSX2kJdV1XApy8Mrd9sM+/DwDMvcfkJu4JrkSN2Ff8firoM55h2550po8L/m57LcUfnPt+EbO4Ic2EMKFiuCbIm28Y63g7PyaxyBdizGMc5HqSJ2/SfFGwv3RE9UtB5r+BMTJeW4FsPV+VlL8JuzO+cu8m3Zt73333Jv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XRaOMLok; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XRaOMLok"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 269E92CBE8;
	Thu,  5 Sep 2024 12:52:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FrYrRPv6ziyi
	Fersz7aWBoV2YnvA5HQSQNRbaFltCdY=; b=XRaOMLok2fD2PAy5xcCsTatNu7tP
	Jf57Bl8xiAdtHvvh6icEGJ3c+I6VvfWDZqiuty1cqO3WVE6UdwKTThLG6qcrR+Hs
	wxyZIgfFdI1m0v8TOqTLB+t/F7H9d3/F7g4yBue3OZuCwk5COaZDVqCmGXHF2XPq
	Nweuv4exrnea5Oc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DEBA2CBE7;
	Thu,  5 Sep 2024 12:52:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8705C2CBE6;
	Thu,  5 Sep 2024 12:52:30 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "Patrick Steinhardt [ ]" <ps@pks.im>,  Derrick
 Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] remote: prefetch config
In-Reply-To: <CAG=Um+0WinvE4CQPTwKdxMxj4xBJ9Z1SBWVrGzTMKM3CbMni0w@mail.gmail.com>
	(Shubham Kanodia's message of "Thu, 5 Sep 2024 22:13:19 +0530")
References: <pull.1779.git.1725472799637.gitgitgadget@gmail.com>
	<pull.1779.v2.git.1725504725976.gitgitgadget@gmail.com>
	<xmqqcyli3x1w.fsf@gitster.g>
	<CAG=Um+0WinvE4CQPTwKdxMxj4xBJ9Z1SBWVrGzTMKM3CbMni0w@mail.gmail.com>
Date: Thu, 05 Sep 2024 09:52:29 -0700
Message-ID: <xmqqy1462gc2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3D678838-6BA7-11EF-98EE-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Shubham Kanodia <shubham.kanodia10@gmail.com> writes:

>>
>>         int prefetch; /* is prefetch enabled? */
>>
> ...
> Updating my patch =E2=80=94 please let me know if there's anything else=
 I can
> improve here.

Renaming the .prefetch member to .prefetch_enabled would eliminate
the need to add any comment on the member in the header file.

Thanks.

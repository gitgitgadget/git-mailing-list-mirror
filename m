Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3891F26AC1
	for <git@vger.kernel.org>; Mon, 20 May 2024 20:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716235626; cv=none; b=Xc4N1X6wwlJ/zcc6i8y6YqeHCiZpZSRTbKY8CGNHgcpcjuRSWAyr2okom/c7rRswj3RXjmR/fjs0OESo6ucxST9H8usYhA7pp66GYkx5LVVeyFBSmhvtkiW5C6DdBrAdrPN2/ZJPmroPJBmi6aIfvtY2GFdcZ0dBAplMb7ZGJkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716235626; c=relaxed/simple;
	bh=iIHqhHG/DOHGAZimkQZWhCMH78cDMP+NYs0YbmHYr7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JICuJU7lrjqs2HB3JpNd46f5FARhXiE19R+Ys8Q1E5Jv/NE0mqJxlUmQ73Bvd92vqhgv22E7TRJ005q1/oUGP6H4rFg4l9V0JRPm6wlvaBURENV0aqUOlZsdK0i3wiLULAht7ODLFxujwTXJ002/EiWINVPcXjUoPXP5IZM5ocU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eNg0AKh0; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eNg0AKh0"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB2B028899;
	Mon, 20 May 2024 16:07:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iIHqhHG/DOHGAZimkQZWhCMH78cDMP+NYs0Ybm
	HYr7U=; b=eNg0AKh0UQyq2d3BCl5ESUTR0lQjDyN46OTMN7fClbDyAtHMb3pAov
	Rgk326y8g4Pj/4VVvyA0W9bV8NDLK84xG7gZGvoXqMDY+Vxrbei2O+oW0HX4LOXw
	MCBBoAc/Bl7HM3+m/thw+kmJ4Jx92gsVpCaWdXt3B3Nt+5CCv5tcw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CE64928898;
	Mon, 20 May 2024 16:07:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B1C0F28897;
	Mon, 20 May 2024 16:07:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Jeff King <peff@peff.net>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "brian m. carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 5/8] hook(clone protections): add escape hatch
In-Reply-To: <736b43a1-a371-4d6f-7739-b5b64e060585@gmx.de> (Johannes
	Schindelin's message of "Mon, 20 May 2024 21:38:02 +0200 (CEST)")
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
	<pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
	<b841db8392ebd924d1893829a7e5e22240f1e9cf.1716028366.git.gitgitgadget@gmail.com>
	<20240518181432.GA1570600@coredump.intra.peff.net>
	<c201bbe3-b404-feed-fcef-8333f72068dc@gmx.de>
	<20240518194724.GB1573807@coredump.intra.peff.net>
	<86d57213-e3b2-c985-6d69-71568c66fc9c@gmx.de>
	<20240518211224.GA1574761@coredump.intra.peff.net>
	<xmqqed9yob4v.fsf@gitster.g>
	<5e0d660a-b1ee-2202-752c-d46d3b0c8a19@gmx.de>
	<xmqqzfskfiu3.fsf@gitster.g>
	<736b43a1-a371-4d6f-7739-b5b64e060585@gmx.de>
Date: Mon, 20 May 2024 13:07:01 -0700
Message-ID: <xmqq1q5wfdsq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 85F3C94E-16E4-11EF-AECD-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> As brian already said, you can reduce the score by making Git do
>> nothing, which is _also_ an absurd position to take "security" (in air
>> quotes) over everything else like usability and functionality.  And this
>> time, the layered security went a bit too aggressive.
>
> Right. And I never said that we should do something as absurd, so I fail
> to see your point.

It went a bit too aggressive, closer to an absurd version of Git
that does nothing, for users of git-lfs and the hooksdir config.
Luckily these two were reported/found soon enough but we do not know
what other fallouts remain.

> Let me quickly iterate on this here patch series (as well as the
> `tentative/maint-*` branches) so that we can accelerate toward a fixed
> version again; Git LFS has been broken for long enough, I'd think.

It would be nice to go back to the pre-2.39.4 state so that we
can redo it from the clean slate soon.

Thanks.

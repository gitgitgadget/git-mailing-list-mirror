Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A410CA7D
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 02:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709086527; cv=none; b=lZ9TJNqU3lA140ZgKXTco+eG+pr5lJrOTLvwwphq6Hhs7lqHn1JKjqrkkgMDJS5tmsXmYVPTtYavH+N6zmC+pLfsonR/OLH3RchefQ2IOgh3Y0CiOmXduaBJqSTzeQAiMzaMGOP2vt4XV7ETzHwpCXxiSAg6/Ht9wreN72D9P5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709086527; c=relaxed/simple;
	bh=YIeeKRgjE86mS8+sinDHD8FawOBLSsX7dGYl1tYLEwc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bhdUSe0N4sWn6CC9WE4IEAEqoWcyxZYiw6ltOnm7os/k5DjhY+TeiQJbflnEqNp8T4X3YD9rOf/FXlVxHduAbLo/8wrDs8xNEkk1H6ndDF5G+ojmWrQTvB+HlDjn5SRbGtIAud7ymow6CJblsTiETvkIVFaDcxubCOaODkr2S/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BzOx4PO9; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BzOx4PO9"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6FE6227489;
	Tue, 27 Feb 2024 21:15:25 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YIeeKRgjE86mS8+sinDHD8FawOBLSsX7dGYl1t
	YLEwc=; b=BzOx4PO9ZX4Z0ItaLApEjb0znJ/srHerfNLlLaGeTWUcmXfBh+Xlp6
	fZ8NFxXsQbVOyxBiC5gCZyftT5ukFzm1nen6pdFSCcmP5lhqNIUEZihn80JO5YSg
	Bp4HDKl4zU3KePetCokqwRERplylI1rfoBGkR+1CnUEKsAPpar7gs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B65427488;
	Tue, 27 Feb 2024 21:15:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A989827487;
	Tue, 27 Feb 2024 21:15:21 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: David Aguilar <davvid@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  =?utf-8?Q?Jean-?=
 =?utf-8?Q?R=C3=A9my?= Falleri
 <jr.falleri@gmail.com>
Subject: Re: [PATCH] git-difftool--helper: honor `--trust-exit-code` with
 `--dir-diff`
In-Reply-To: <CAJDDKr5+3jszG=psh=kUGDjNCeTDGPSS-qDuN=JAq-3ua=bNDg@mail.gmail.com>
	(David Aguilar's message of "Tue, 27 Feb 2024 17:52:38 -0800")
References: <976C9BF2-CB82-429A-B9FA-6A14BCFFCA3D@gmail.com>
	<c071e44c52171b9b19a04d91666be48d762d19bf.1708072576.git.ps@pks.im>
	<xmqqttm8i8hb.fsf@gitster.g>
	<CAJDDKr5+3jszG=psh=kUGDjNCeTDGPSS-qDuN=JAq-3ua=bNDg@mail.gmail.com>
Date: Tue, 27 Feb 2024 18:15:20 -0800
Message-ID: <xmqqplwhmj0n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 39ACB7EE-D5DF-11EE-BEAE-A19503B9AAD1-77302942!pb-smtp21.pobox.com

David Aguilar <davvid@gmail.com> writes:

>> The last time David was on list seems to be in April 2023; just in
>> case let's CC him for an Ack (or something else).
>
> Thanks! I'm still lurking around.
> I've been meaning to make some Git-adjacent announcements and
> contributions soon..
>
> Until then:
>
> Acked-by: David Aguilar <davvid@gmail.com>

Thanks.  

It always is nice to hear from old-timer project participants.



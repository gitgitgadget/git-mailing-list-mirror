Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199A23B78D
	for <git@vger.kernel.org>; Fri, 24 May 2024 03:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716523007; cv=none; b=FVZsTZYfPLRtuKclIgW9LRSnbe7zfDHChLQ+JDZ/7LBqIqpINb+5aprDJ9SOofGR5taL7P6fvOqXuAka0BNVSs10xSIqZXJskIqm59hnfhx+Q+6jG4C9zoliAiwdpOEV62yde6FOtaCyy/Zsn4qXrNHIsh3GsXQQzK2s94xuTp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716523007; c=relaxed/simple;
	bh=YopcrrvuWwVkpqs9RtGFp9W6L9lDKiSbsSY8s2PXJSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CI09yd2AjfYC+9arCN738UkpddY0skBFPC94KFbzqpdTtt0Hx5nNxsT3ZswC9j6pPzQW0W12bCHvMxhc4dkR0UgQ5TrPTsHSaBv3YT2e+EvPReO5nCW3dedRb8K6sWPRXFg7A6xutxU7VwiTO6UVuCziVIGOQXrsCa9oSW6EPYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lqtF43Pm; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lqtF43Pm"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D32625505;
	Thu, 23 May 2024 23:56:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YopcrrvuWwVkpqs9RtGFp9W6L9lDKiSbsSY8s2
	PXJSI=; b=lqtF43PmzVAjovk/MRaDlSzKebqH8nb0AhCWxA2vm/EnfONUWC/NcT
	JXpZmQw5lAHamvoy57xCRZW8UyM2IKCkNojmjFvvDoHkHa1YkBhJuH6D26Da3mUn
	G1LU9afBJ0YhQnEuGo07XbfK/JLZsFp84g9pV/EqUUnyU1hDdkoNI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 75A5425504;
	Thu, 23 May 2024 23:56:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 95F3425503;
	Thu, 23 May 2024 23:56:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/2] give range-diff at the end of single patch output
In-Reply-To: <8b08ccd0953aec5a2fcb3a61bc86c32d@manjaro.org> (Dragan Simic's
	message of "Fri, 24 May 2024 01:35:17 +0200")
References: <20240523225007.2871766-1-gitster@pobox.com>
	<83436db5996b129032c2869f331980d0@manjaro.org>
	<xmqq34q8qfek.fsf@gitster.g>
	<8b08ccd0953aec5a2fcb3a61bc86c32d@manjaro.org>
Date: Thu, 23 May 2024 20:56:41 -0700
Message-ID: <xmqqed9rq2va.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A1B5FB94-1981-11EF-8F54-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> To me, a range diff is like an additional description of the
> actual patch, or like a really long footnote, so to me it makes
> more sense to put it at the end of the "document".  Sometimes I
> don't even want or need to look at that footnote, so not needing
> to scroll down is another plus.

That apparently makes the three of us, counting Patrick [*].

Personally, for a single-patch "series", I find that interdiff is
often easier to see than the range diff, but that is a separate
story.

[Reference]
 * https://lore.kernel.org/git/Zk7UsJjhY_FV2z8C@tanuki/

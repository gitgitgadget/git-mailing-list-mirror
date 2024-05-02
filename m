Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D0F23A9
	for <git@vger.kernel.org>; Thu,  2 May 2024 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714682857; cv=none; b=cp0lF5+hxZAwXsJXA3CyK2DH9sfyoKiLDZ7LgHr0mCvxDUb28HC0LkxZ/n0gWAcWcIdLPKk2eK/D4uSjagCRws7P4GfdHktJ3/i8XbnkVfBxYbrWDPs8sL2nL2S1xjsJJTF7DVpc9PHuV9P2lT6eDpEO7HENcHQ27oYQOS//6Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714682857; c=relaxed/simple;
	bh=Oj1UaYGNH2TkM3fI9tlQ4H8iGcEdfqfzeGEbepeB8Do=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tc8mxSoCE1uVymKYjAAZ5hqaomJGIwDkHFbHSRTMm1SB/gQOj6vxVUDhMDD693N7hL3xtOeUu8KWc2h73fZVdp8h2IJyMjjNwE93f2xVWeSXCFhSLHvD26jL9hCXB0dk8zN6FDsnLc2qQW9riQSgAzEqI2OSekxyD/Tm8RH3shs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VRENz8lG; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VRENz8lG"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D6667322C6;
	Thu,  2 May 2024 16:47:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Oj1UaYGNH2TkM3fI9tlQ4H8iGcEdfqfzeGEbep
	eB8Do=; b=VRENz8lGsBfdrWxBup4DRyHvM8sZYdj5RGv72M/utxDOYzf+xWpKLY
	dqUiUuOFc0F0hDPtr9k8L5CXk7LcvVKjhnIN0Jehpyl3IFMWTNlMXDpxvXS6XmeH
	f11JABGOPzao03RNc20aiahPYBki7OeC3Jqn4+NCrV8SRzcA3woUU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CD362322C5;
	Thu,  2 May 2024 16:47:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 39A53322C3;
	Thu,  2 May 2024 16:47:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johan Walles <johan.walles@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Chunk header @@@ counts wrong?
In-Reply-To: <xmqqmsp8c5d3.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	02 May 2024 13:43:04 -0700")
References: <CAKtyTbevS7W-X4qoO=uPnHmXCEtKhqycD8DZZY-oK-z0p4CEAQ@mail.gmail.com>
	<xmqqmsp8c5d3.fsf@gitster.g>
Date: Thu, 02 May 2024 13:47:30 -0700
Message-ID: <xmqqfrv0c55p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 329D185E-08C5-11EF-BB02-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> * 51 plus-space (new to v1 but already in v2) lines
>
> I think you failed to count three lines in v2 and merge result, they
> look like "<<< HEAD" "======" ">>> 8eec118"; new to v1 but already
> in v2 lines are 54, not 51, no?

Ah, I take that back.  These have ++ that are new relative to parent
#1 and parent #2 (i.e. only the tentative merge result has them).
So, yes, I think you are counting correctly.

Sorry, but I do not know what's counting the hunk length numbers in
today's code offhand, so I won't be digging it further for now.

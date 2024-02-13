Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6339C5F54E
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845304; cv=none; b=o7b1RR3nuPTDfW6BeVrBEGxzdHnzfbDbeleqJMFn8LiI/O4peZMtFwC5CzXZwOchg7Q3Ny6Rv+b0vbCE3xR9S8cUyDx1wZDkWM3eNixkukiYosu1Vsv2LHofS+bKEiEI0XzrGVcdpG6zYNNpynx2HBNbzYQr3EmtHJ76e641vmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845304; c=relaxed/simple;
	bh=Y2p4MMJjefaj6uucUFDMAHTUlVf1mMesC0frVB089wM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nxMX2zglr73Ix7z6LtLegz/EYtjupEcF0HqFt2TMp0wX0ma8yfPW0XRIQdc+q2cy/b2vOJ2dlcZJtGGd8G4ftIlS97I7gVOCIdnA3UKb0Z6SBoiD7cDsxHNcggaTVThyIZusK6kc8vnir3NyYt+fI1r1Saapd9Z6mh8v5n+kLz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hahf5sqE; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hahf5sqE"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D8C071C5462;
	Tue, 13 Feb 2024 12:28:21 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Y2p4MMJjefaj6uucUFDMAHTUlVf1mMesC0frVB
	089wM=; b=hahf5sqEkfzyQx2A2WMGNBaAIx+gDIAxb+SMQLBSe7ekoB4Rz8qLEZ
	LHlKWCLg6AyhF6Mj4VAX13R3RbC+V9b6lg/hpeu6enYffHL4KJpHSUD+tEU62Nhp
	qS9fewYH9NqbQL+2n0Pk7W16FMeLlmPWiDXDgHVF+FiJiKBWGb1O4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D04A41C5461;
	Tue, 13 Feb 2024 12:28:21 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 436061C5460;
	Tue, 13 Feb 2024 12:28:21 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Josh Steadmon <steadmon@google.com>,  git@vger.kernel.org,
  johannes.schindelin@gmx.de,  phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 1/6] t0080: turn t-basic unit test into a helper
In-Reply-To: <20240213074118.GA2225494@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 13 Feb 2024 02:41:18 -0500")
References: <cover.1705443632.git.steadmon@google.com>
	<cover.1706921262.git.steadmon@google.com>
	<da756b4bfb9d1ce0d1213d585e72acfbf667e2a2.1706921262.git.steadmon@google.com>
	<20240207225802.GA538110@coredump.intra.peff.net>
	<ZcqFOVuR0sxFDDUv@google.com> <xmqq34tx5q6o.fsf@gitster.g>
	<20240213074118.GA2225494@coredump.intra.peff.net>
Date: Tue, 13 Feb 2024 09:28:20 -0800
Message-ID: <xmqqh6ic6zpn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 48A6FFA2-CA95-11EE-AF58-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> Likewise (mine is the latest version in Debian unstable). The change to
> sort comes from their[1] eedea52a, which was in GNU make 4.2.90. But the
> matching documentation change didn't happen until 5b993ae, which was
> 4.3.90 in late 2021. So that explains the mystery.
>
> Those dates imply to me that we should keep the $(sort), though. Six
> years is not so long in distro timescales, especially given that Debian
> unstable is on a 4-year-old version. (And if we did want to get rid of
> it, certainly we should do so consistently across the Makefile in a
> separate patch).

Sounds sensible.  The topic is expecting a reroll so I'll make sure
I won't touch it until I see an update.

Thanks.

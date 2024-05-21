Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E6F487B0
	for <git@vger.kernel.org>; Tue, 21 May 2024 21:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716328003; cv=none; b=DB7NWHU7OMfeJBiEb+qUx3ido/mgVKmCLsHDRhK176HBgnwGOjI25jvnyKTUaUk7K4lXM8LlpdSSGngzCfFqQW7cFIL+Gf2OFw3WSsiI7HUq6C4BFBcgR+148BZvyqWrk29CuaZYqbZgSAyZpIlCArJmmPXtUFBKPY/8i8cEG5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716328003; c=relaxed/simple;
	bh=iipuzpMnxR8UQLNViL+YsZGNmOxGW/HZ81UanBJm2a8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PUNXik8w9zEOyKRSXUWEJ70f+b+jMAsrbNyBKJAAs3fWD5Fh+0j2XYcy+30mkJBzjeSMx6MLZwiihVMsOJBTvL7ED/WlSJSNdL1R12olplEA34WaVLq8j8Wea9TQI8m3JQd3lJeDXumPTjvXdiwq2B8ZgJevpnSBki4gmDvVjNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bw6UwcUy; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bw6UwcUy"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F40192E86F;
	Tue, 21 May 2024 17:46:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iipuzpMnxR8UQLNViL+YsZGNmOxGW/HZ81UanB
	Jm2a8=; b=Bw6UwcUyegP1aRq8zW3aUa/2vinnLSlmG3kDKb4pRwW2Xn9hlHHDNr
	XbYjBUCfAPAkv9RaSA4LOblUJJIIt5YkRQ+6yfhrC3xoME95XvjboYI9R4lZUEzC
	uBKkpppJatlZ6FVAPDQ87qa9+LcYQ38fpZBTfNaaJZAfbhp++UkxA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E5F972E86E;
	Tue, 21 May 2024 17:46:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F1C4A2E86D;
	Tue, 21 May 2024 17:46:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/12] Fix various overly aggressive protections in
 2.45.1 and friends
In-Reply-To: <937e89c6-6161-42ba-670d-8f20ff90a7d0@gmx.de> (Johannes
	Schindelin's message of "Tue, 21 May 2024 23:14:18 +0200 (CEST)")
References: <20240521195659.870714-1-gitster@pobox.com>
	<937e89c6-6161-42ba-670d-8f20ff90a7d0@gmx.de>
Date: Tue, 21 May 2024 14:46:36 -0700
Message-ID: <xmqqmsoi96tf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 99E56494-17BB-11EF-AD62-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 21 May 2024, Junio C Hamano wrote:
>
>> I'll figure out a way to convey conflict resolutions as this topic
>> gets merged up to newer maintenance tracks on the list so that
>> people can assist with ensuring correctness of the result by
>> reviewing, and follow up. ("git show --remerge-diff" might turn out
>> to be such a way, but I do not know yet).
>
> I pushed 12/12 to https://github.com/dscho/git's
> `various-fixes-for-v2.45.1-and-friends` branch, and updated the
> `tentative/maint-*` branches accordingly:

Thanks, but I suspect it is not productive use of your time to merge
these up until we know we are happy with what we are merging up.

Even though I did the 12/12 that reverts the "iffy ownership check
during repository discovery", it is far from clear without
discussion if that is a reasonable thing to do or use of
safe.directory by narrow non-target audience (like k.org that may
use gitolite and/or bare git for hosting) that lets nobody access
trusted user repositories.  Every time we find new issues or
different solutions, somebody has to merge it up, eventually to
maint-2.45, but I am afraid it may be a bit too early to commit.

>  + b9a96c4e5dc...c6da96aa5f0 maint-2.39 -> tentative/maint-2.39 (forced update)
>  + 4bf5d57da62...fff57b200d1 maint-2.40 -> tentative/maint-2.40 (forced update)
>  + 5215e4e3687...616450032a0 maint-2.41 -> tentative/maint-2.41 (forced update)
>  + 33efa2ad1a6...b1ea89bc2d6 maint-2.42 -> tentative/maint-2.42 (forced update)
>  + 0aeca2f80b1...093c42a6c6b maint-2.43 -> tentative/maint-2.43 (forced update)
>  + 9953011fcdd...3c7a7b923b3 maint-2.44 -> tentative/maint-2.44 (forced update)
>
> Ciao,
> Johannes

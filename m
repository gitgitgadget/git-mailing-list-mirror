Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA16415534E
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 21:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082156; cv=none; b=MATI9ul+6IA1ZPL45iwTgU0IqVDUXuyXiZUlCGp5IBQYgB9kkJRiSCLI/vwLXjt4PbKerkj7nKSzTtPm/bbEWzG2omiivR+f4Gys0/sVmjbm1zqz2leM07dPXzYCLmMHsVFwbkVPunXZP8DhusZko/I+odRqZIADS4XusJLehL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082156; c=relaxed/simple;
	bh=Hk0FQPTL45YKAXmfaQCoU7J6BXP9dQirrvhaghAN5hI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PlbcKA4VuYkP3ssRUo7ofwmdB1/rSE7Ki4KQAa8D5+zaL54puuR5UrnFN53wGweNyILe+qbrPUVSpYo8SVgxD3T1ctahNoRMLzvzybZ/nCZOpdvXkLgyPnl0z7bmY6UVxfsbAazj1HrBldKDUrO9CkizZZ2ONArrbhZFG3na8Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=l3PZMVMT; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l3PZMVMT"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4936E259EE;
	Thu, 25 Apr 2024 17:55:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Hk0FQPTL45YKAXmfaQCoU7J6BXP9dQirrvhagh
	AN5hI=; b=l3PZMVMTVHzggohQV8siK7A6OrOkyuDbvLMADD25vt5N/AD9Y31uRa
	yBNTC7yFKXdRZDbTC/9ix3tSwKC8Wgm2TdZOivHAmlq+0Hwfas2ySpv3p6pLJDPC
	4n108ByJ5z650MdVqj5XxC5YaHtfK3YvMyysW08xH4H2q4VBGT+Hg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 417A4259ED;
	Thu, 25 Apr 2024 17:55:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8BA2B259EC;
	Thu, 25 Apr 2024 17:55:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Jeff King <peff@peff.net>,  chris.torek@gmail.com,  git@vger.kernel.org,
  ps@pks.im
Subject: Re: [PATCH v3 0/8] refs: add symref support to 'git-update-ref'
In-Reply-To: <CAOLa=ZTjwRnqmXRuWpN7o86DZdfOsgZwR7=Gk0A3EG0zSHiCBA@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 25 Apr 2024 14:14:34 -0700")
References: <20240412095908.1134387-1-knayak@gitlab.com>
	<20240423212818.574123-1-knayak@gitlab.com>
	<20240423220308.GC1172807@coredump.intra.peff.net>
	<CAOLa=ZRk8QR4qkbkRm6AirapdrAqz6bG-tXfY3zRQU_9XkJM1Q@mail.gmail.com>
	<xmqq4jbpgw32.fsf@gitster.g>
	<CAOLa=ZTjwRnqmXRuWpN7o86DZdfOsgZwR7=Gk0A3EG0zSHiCBA@mail.gmail.com>
Date: Thu, 25 Apr 2024 14:55:48 -0700
Message-ID: <xmqqcyqdds4b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 94853820-034E-11EF-96D3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

>> IOW, we should add support for operation modes other than "--stdin"
>> as well, shouldn't we?
>>
>> Thanks.
>
> That's a good point, I was thinking of something like this too, but
> didn't want to bloat this series. Would it make sense to add this
> functionality in a follow up series with the cleanup that Patrick
> mentioned [1] too?

Going multi-step is usually a preferred approach but we have to be
sure that we do not have to retract the way earlier steps gave our
users when we move to later steps.  "Earlier we said that your
commands should look like this, but now you have to give your
commands differently" is absolutely what we want to avoid.

So, "in this iteration, you can use this enhanced feature only via
the "--stdin" mode, but we promise we will make the same available
on the command line" is perfectly fine.  You may need to retitle the
topic to clarify the scope of each iteration, though.

Thansk.


Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856D318044
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502475; cv=none; b=Bu+0qgubO57bGoKFSLn5qBmAn3VBIKTVgnig2RoXs7jq6hBXw5uvJ9oFlsWlL25phjQfhM3y6Km57m+LcoQOHCuzdKQeJYiqwGBC/0Bnkpr/FO1O/6/p/AFNDvKHt8dFPkhRiZKZZqkv1UDViDu4FcZipF3+FPGs6Bx9u4e7xck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502475; c=relaxed/simple;
	bh=BmV0SfSc6gXNvFaxY/Scqoi4P9DzjMAFa7y4en7gIHk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qhq/HQ+b2Gu+Y7BwEoPN2mmctF4DOH8xZNP2km9vONtc62CiMwv26mjR5XttyswP5djtsW7mzobYmnNw0qt4QPl/gc2OPg5u5ofpN3fb1bRhK5Cmf6y/vCvlBO2RAnmGb3FGiuc+va9lK6sErukRn7l8z+bLSf8sUQNqtEAfIH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JoZc3t6a; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JoZc3t6a"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E5001203CE;
	Tue, 30 Apr 2024 14:41:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BmV0SfSc6gXNvFaxY/Scqoi4P9DzjMAFa7y4en
	7gIHk=; b=JoZc3t6a7qyaLYvG5K9l/J6NV/EMyzcLr2rWhbiX5x2fbu/I5JKVuS
	dloTtS84RRBTQqaAW45F/mU4oTl+omnpdSdERc5ODbKBy3ZGhN4uyEW1qa9eymVu
	UrYGn5aSP1VyVUTTgGUwcrVVBXCzB5j2naZi9gofhZsLpXswfZc1M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DD69A203CD;
	Tue, 30 Apr 2024 14:41:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E426F203CC;
	Tue, 30 Apr 2024 14:41:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Beat Bolli <bb@drbeat.li>,  git@vger.kernel.org,  Beat Bolli
 <dev+git@drbeat.li>
Subject: Re: [PATCH 3/3] color: add support for 12-bit RGB colors
In-Reply-To: <xmqqmspazrj3.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	30 Apr 2024 10:31:12 -0700")
References: <20240429164849.78509-1-dev+git@drbeat.li>
	<20240429164849.78509-4-dev+git@drbeat.li>
	<20240430105727.GI1279403@coredump.intra.peff.net>
	<xmqqmspazrj3.fsf@gitster.g>
Date: Tue, 30 Apr 2024 11:41:05 -0700
Message-ID: <xmqqikzyzoam.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 353116EC-0721-11EF-83E3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>>> @@ -146,7 +146,10 @@ test_expect_success 'non-hex character in RGB color' '
>>>  	invalid_color "#12x456" &&
>>>  	invalid_color "#123x56" &&
>>>  	invalid_color "#1234x6" &&
>>> -	invalid_color "#12345x"
>>> +	invalid_color "#12345x" &&
>>> +	invalid_color "#x23" &&
>>> +	invalid_color "#1x3" &&
>>> +	invalid_color "#12x"
>>>  '
>>
>> This made me wonder what we'd do with "#1", "#12", "#1234", etc. Looking
>> at the code change, I think we'd continue to reject them. I wonder if it
>> is worth covering here.
>
> Worth covering in this test, yes, but I am perfectly OK with leaving
> it outside the series as a #leftoverbit clean-up.

Ah, I take it back.  The preimage was added by [2/3] so it is fair
to say that that step would be the right place to do that from the
get-go.


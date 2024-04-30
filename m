Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D959917F385
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498282; cv=none; b=dijZTal+h9lDLWbu3PEOAFZSB+vsgdCOz7aRCUm5X3JRjz4aiQaUduy/L5C5wsdKghKjgQEGBBt3pgmXY6zeMPsVI8GI33x4dr4FlAP8JC+6A6PAEQTYxaoyCgjJasgsiWzQ9sFO4ZTdpUpOEy/KVsl0A5Z5AuD8Gl5rdJuaDLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498282; c=relaxed/simple;
	bh=yMLNmhlgYH/Ct6qNfSiy6xbLnpXlRt04H5hVd1Qs6wU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HrATzjTUx0YSQDrTZXWxoX0FS54P4TlBb9s4vNe0OQ2uY6Ki2VrBuLrDmLcspkAk+8KhGOh1LT4EKPgRJsiHR2AP3Iv+aJgOXIV7QYXOmNdwqXOVbnxDqkTVG0GzhLOfXv3umN+p8K2NFKpQi+vWytfqWOkPGJT7/3J73UUZJQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NstL2xor; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NstL2xor"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FBBF2C4E1;
	Tue, 30 Apr 2024 13:31:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yMLNmhlgYH/Ct6qNfSiy6xbLnpXlRt04H5hVd1
	Qs6wU=; b=NstL2xory630frQNDP4KfbEzti/103EgRRIbGyDr733ak9ddEBEQp0
	9orsrMfnzCgQZ9FBpv2qZQ0M94r0V3g2Lr37DPuU3gLJWfhGjHbLUj/WsdUvQss0
	a0a7lUH3V82Umojn3OD6Oh/qTJD1qi6NHQXLtVKxH24T/lge5eTgc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 775322C4E0;
	Tue, 30 Apr 2024 13:31:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D06FD2C4DF;
	Tue, 30 Apr 2024 13:31:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Beat Bolli <bb@drbeat.li>,  git@vger.kernel.org,  Beat Bolli
 <dev+git@drbeat.li>
Subject: Re: [PATCH 3/3] color: add support for 12-bit RGB colors
In-Reply-To: <20240430105727.GI1279403@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 30 Apr 2024 06:57:27 -0400")
References: <20240429164849.78509-1-dev+git@drbeat.li>
	<20240429164849.78509-4-dev+git@drbeat.li>
	<20240430105727.GI1279403@coredump.intra.peff.net>
Date: Tue, 30 Apr 2024 10:31:12 -0700
Message-ID: <xmqqmspazrj3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 715398AC-0717-11EF-B448-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> On Mon, Apr 29, 2024 at 06:48:49PM +0200, Beat Bolli wrote:
>
>> -test_expect_success '24-bit colors' '
>> -	color "#ff00ff black" "[38;2;255;0;255;40m"
>> +test_expect_success 'RGB colors' '
>> +	color "#ff00ff #0f0" "[38;2;255;0;255;48;2;0;255;0m"
>>  '
>
> Heh, I would still think of it as a shorthand for 24-bit color, but I
> guess you could argue it is now 12-bit color. :)
>
> (Only observing, I think the new name is fine).
>
>>  test_expect_success '"default" foreground' '
>> @@ -146,7 +146,10 @@ test_expect_success 'non-hex character in RGB color' '
>>  	invalid_color "#12x456" &&
>>  	invalid_color "#123x56" &&
>>  	invalid_color "#1234x6" &&
>> -	invalid_color "#12345x"
>> +	invalid_color "#12345x" &&
>> +	invalid_color "#x23" &&
>> +	invalid_color "#1x3" &&
>> +	invalid_color "#12x"
>>  '
>
> This made me wonder what we'd do with "#1", "#12", "#1234", etc. Looking
> at the code change, I think we'd continue to reject them. I wonder if it
> is worth covering here.

Worth covering in this test, yes, but I am perfectly OK with leaving
it outside the series as a #leftoverbit clean-up.

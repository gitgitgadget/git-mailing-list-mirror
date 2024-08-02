Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E1A25632
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722626946; cv=none; b=FcUg2YjQPrJPZDF7xxZCriD9qwgZToIA0xSDQoDnZ8xAMwNLVa8COuxv6f9/1CHJ0bYyQJw13F5kK//dYLjEqnFhcsoxi57MB5cZWmfTOzxQArz7/h7QG53Ac0FrIlKcxa6RZbjqSyctBOWU1I55JDXm4hjf7aY4CjH8LSFz7r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722626946; c=relaxed/simple;
	bh=TX+fU3EjfYroYkkdihKAesYsfaPaSTDeGid2cXfkl+s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S9M/IzkQsm5BsfIVD74VWECxAmzE/TGbLE5r8f1uK2a0u/yWzqXuzjNDF7xd+6X43BtIS2JiMMYnWgQWCfkXscsrysKXOOUWqDSgssGqNuFUOoUV4VMStDrI7GdpA7OoCm9gZA9JFdDXYZanTs5YPdpeGp5Hparf3R1535UZgk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=p1F0pApv; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p1F0pApv"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C7142363C7;
	Fri,  2 Aug 2024 15:29:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TX+fU3EjfYroYkkdihKAesYsfaPaSTDeGid2cX
	fkl+s=; b=p1F0pApvkfXlBuWgt6Ieiu4f4f9ZioO3gEK5Vacdp9GyrTDPFDmw4Q
	3Vxhf4feXffDbYIXqbcFOEaii/4T84aWmZ6Qe0Fq127k0N/s8wINehZkTTDqk0PX
	gQBTefCv646WNeImBEgJX9CyIdEEhnLq7kfhm7pz55gyCpC02nN9c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AB5B6363C6;
	Fri,  2 Aug 2024 15:29:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9A360363B8;
	Fri,  2 Aug 2024 15:29:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v5] http: do not ignore proxy path
In-Reply-To: <a0b916a4-8941-4c06-263d-0ae92dcaf29e@alum.mit.edu> (Ryan
	Hendrickson's message of "Fri, 2 Aug 2024 14:03:08 -0400 (EDT)")
References: <pull.1767.v4.git.1722489776279.gitgitgadget@gmail.com>
	<pull.1767.v5.git.1722576007398.gitgitgadget@gmail.com>
	<xmqq7ccygbx6.fsf@gitster.g>
	<2ba77de5-f103-c2f0-c009-71700c8a020d@alum.mit.edu>
	<xmqqv80idf52.fsf@gitster.g>
	<a0b916a4-8941-4c06-263d-0ae92dcaf29e@alum.mit.edu>
Date: Fri, 02 Aug 2024 12:28:58 -0700
Message-ID: <xmqqh6c2d8qt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 784860F6-5105-11EF-B937-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Ryan Hendrickson <ryan.hendrickson@alum.mit.edu> writes:

> At 2024-08-02 10:10-0700, Junio C Hamano <gitster@pobox.com> sent:
>
>> Ryan Hendrickson <ryan.hendrickson@alum.mit.edu> writes:
>>
>>> Hmm. I'd be inclined to take the preliminary clean-up approach, but
>>> some of the existing strings (there are also two "Unsupported
>>> ..."/"Supported ..." strings near the "Could not set..."s) are going
>>> through gettext, and I'm reluctant to interfere with the l10n process.
>>
>> I do not see what you mean by interfering with the localization.
>>
>> If we are updating text to be translated anyway, giving translators
>> the strings that need to be translated _earlier_ rather than later
>> would be more helpful to them, no?
>
> Probably true, but as a new contributor I don't know whether changing
> msgids means more people need to review the patch, more files need to
> be changed, a translation team needs to be notified, the change needs
> to be pushed a different branch... whatever your process is. Localized
> strings are generally more of a headache for drive-by contributors, in
> my experience across different projects.
>
>>> Is this blocking feedback? This strikes me as speculative
>>> over-engineering
>>
>> No, it is loosening a pattern that is overly tight and as a side
>> effect shortening the line to more readable length ;-).
>
> Blocking or not?

If we are updating anyway, that question is irrelevant, no?  This
version may hit 'seen' but until the next version comes it will not
advance to 'next'.

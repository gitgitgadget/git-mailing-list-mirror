Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BDA16CD3B
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848631; cv=none; b=auBB0liuD/3YDrl1Fjv8jdX2n77pirE4+yueXjESRenaoQ3Omx+TkoGBE6QhTmCgeENQW2D0f9YDekYnv0wL1PtSbb8qVJLB5g5i0rWyJI+DfXF4OWWhPOrLoINsFnmfs5Xbw8hGlawJzIEC6BfWh236SAcdxQsYrJxHM4JWPx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848631; c=relaxed/simple;
	bh=GbrG+/cDlaFTaKSrRbGg1HtaJn74TR5eM0zuuQnZtAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IiMgVBgjHw2Qu9ukuUQ+1UI6VlNywSU84mXieZqEGBwzD1mByQP2gi/5GjPqEEQO1ealMCT2qL9nMJhe893RTRUBf+z27gXmrFld/hN+7Mw0EPMm51b1Y5Fu2Lj2FDFe8u3xfwIgqjYKjQOLz9gi0AR6C20Uvfk2UVS24K00Mns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GWPFfCDa; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GWPFfCDa"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 25D8C28FB3;
	Mon,  1 Jul 2024 11:43:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GbrG+/cDlaFTaKSrRbGg1HtaJn74TR5eM0zuuQ
	nZtAc=; b=GWPFfCDaM7ocAI3llCJJbZkFrwt9IBfzVN54gV5PHPO+z08YB0BLkL
	bNKipnyN5LCLKI249peUnNTrKEy0QGaNA8oZR0ynLZ/H5rChzKHPBcTFQ2phkHWA
	KsnRcrhHCDPbZgGP7iYrPJiv42mIUxGq9J53V+5kvpxK0kHdu8F3o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1E66F28FB2;
	Mon,  1 Jul 2024 11:43:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B7D0128FB1;
	Mon,  1 Jul 2024 11:43:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Pavel Rappo <pavel.rappo@gmail.com>,  Git mailing list
 <git@vger.kernel.org>
Subject: Re: Determining if a merge was produced automatically
In-Reply-To: <ZoKXt0jPphoM5nmJ@google.com> (Jonathan Nieder's message of "Mon,
	1 Jul 2024 13:49:11 +0200")
References: <CAChcVu=Kwqj7JhXqQW6Ni9+3TdSfdmHfSTJQWm1_uO2kczSm8g@mail.gmail.com>
	<ZoKXt0jPphoM5nmJ@google.com>
Date: Mon, 01 Jul 2024 08:43:45 -0700
Message-ID: <xmqqh6d9yv66.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B42A3DB4-37C0-11EF-B6E7-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Jonathan Nieder <jrnieder@gmail.com> writes:

>> However, this bit means that I shouldn't entirely trust its output:
>>
>>> The output emitted when this option is used is subject to change, and so is its interaction with other options (unless explicitly documented).
>>
>> What is my best course of action?
>
> I'd encourage proposing a patch to make the documentation say what you
> wish it said.

I do not think that was what Pavel wanted to get suggestion on, but
it is certainly something that would benefit not just a single
person but other users ;-)

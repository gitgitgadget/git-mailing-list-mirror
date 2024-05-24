Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E15126F06
	for <git@vger.kernel.org>; Fri, 24 May 2024 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568099; cv=none; b=PLSau8su+EQBtjscG2xMjQAEbN9pexw/CJYRAHC7P4SnFWmIZsyDQYYIKzONQWHpG/zWbEEjcR98FPn1oTuJGFRB6oKxrL9pb1YewDGVq/nqMhxZVqoDz+p55ys3cnEZTTwbYPuACrtseLQIjRrQroZQWCK+46nlpm8+Io2alro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568099; c=relaxed/simple;
	bh=TWeJpAygk8Xd9ic5KiJWVbytlLtrzc8N3Fu0cNFxZN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OPjR+G1lCK2ZrndqRqS3FLYkv/ZrJIJJq88O1OKEkQjMjPEfF/l6rPXz4ifxLLUCCz91oCN3Z/RvMLfxw6nnElQ/VqMVIo/h0uANKja+VHCqWQjY5Ud1d2beWTs1X+WFpr0pWNE1A8EXA04nQ9Dpnw1n3BYlcSmkUGbk27NGq0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q9Gtusrs; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q9Gtusrs"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 81BFF260D1;
	Fri, 24 May 2024 12:28:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TWeJpAygk8Xd9ic5KiJWVbytlLtrzc8N3Fu0cN
	FxZN8=; b=Q9GtusrsjYqfGu5jJSPbrBqTu1fuXfCUFrmc0BdItFxeUhxSaI3j2x
	+42vJRrFz0eFW9fzS4QJ8rptJ13IpEPqrk4m/4GLU3PU+ROR/i9cPZhweCIu97AQ
	3yU8oxIfCvT74VwxSPeTdRtiu2/PcWHC/0NqSc9PamuIHf1VHcdnI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A296260D0;
	Fri, 24 May 2024 12:28:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 99774260CF;
	Fri, 24 May 2024 12:28:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/9] refs: ref storage format migrations
In-Reply-To: <ZlBC5O4CHqrx1di7@tanuki> (Patrick Steinhardt's message of "Fri,
	24 May 2024 09:33:56 +0200")
References: <cover.1716451672.git.ps@pks.im> <xmqqwmnkv7ay.fsf@gitster.g>
	<ZlBC5O4CHqrx1di7@tanuki>
Date: Fri, 24 May 2024 09:28:13 -0700
Message-ID: <xmqqv833maxu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9EA5027E-19EA-11EF-B53D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Documenting the limitation is a good place to start.  For normal
>> users, would it be sufficient to
>> 
>>  (1) tell your colleagues that this repository is currently closed
>>      and do not push into it;
>> 
>>  (2) configure "git gc --auto" to never kick in;
>> 
>>  (3) delist the repository from "git maintenance" schedule.
>> 
>> before they try this feature out?
>
> I think (2) wouldn't even be needed. Auto-GC only kicks in when there is
> a write in the repository, and if both (1) and (3) are true then there
> are none. But other than that yes, (1) and (3) should be sufficient.

So it may make sense to document something like that at least?

Thanks.

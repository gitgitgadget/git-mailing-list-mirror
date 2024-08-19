Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D491553BC
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097616; cv=none; b=UFZMxVCUz8Pn91/9PKUr/gvIr4rS55c3/hKndG36OVLqtunmqZ+7wf1cQU5P67uevzZgtLY3yyg9Nfj+AU74HW6LyCne+qRnxl7D3Y7dgfHc2x5j7yUaQiVOzxFey8zbhO7usprWF5SFpGbDXtNe1W4VdfQSGVwzGJWU4ybvLUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097616; c=relaxed/simple;
	bh=ZzwvtjquB+yxTIUVqageAyzUzwrrNLtht7QBQnOSYTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S3PTCKq1pcMsVCNcmoZTr/EhvY+WEKbKH4tH3JTqm6KN1F8MaKybCtKGygtNMFzp40fBuIRdeOd1Cs2gTZ63dSqKJQhkOJAhtCmpi7qmgi509PY00jhDoDxqoR5nsc8rs+F87UvvVSFvn4TMZ719BbVSLOkHHDm3Z7HXUWzWl8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CGC3nfio; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CGC3nfio"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AAB2223470;
	Mon, 19 Aug 2024 16:00:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZzwvtjquB+yxTIUVqageAyzUzwrrNLtht7QBQn
	OSYTA=; b=CGC3nfioY5Pm808kDvw1X07IatAT4A+Q1dmppd+cdXlfXLTm0ze21F
	bjHfezK18+ol52pikyDp+L+JrJl6vJIxRMCutK3wkVddi9SCrZFFlMp2NT1FCSt5
	NYPiRIp2GI5nOJJpk9FfVfiZ7krSCgBpg4Od/JCGeGJLqaXsj7bz8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A07D52346F;
	Mon, 19 Aug 2024 16:00:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECA8B23469;
	Mon, 19 Aug 2024 16:00:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  John Cai <johncai86@gmail.com>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] Add 'promisor-remote' capability to protocol v2
In-Reply-To: <ZrDYIFolRlERFdUT@tanuki> (Patrick Steinhardt's message of "Mon,
	5 Aug 2024 15:48:16 +0200")
References: <20240731134014.2299361-1-christian.couder@gmail.com>
	<20240731134014.2299361-4-christian.couder@gmail.com>
	<ZrDYIFolRlERFdUT@tanuki>
Date: Mon, 19 Aug 2024 13:00:11 -0700
Message-ID: <xmqq5xrwe110.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A54F04F2-5E65-11EF-B300-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> +In this case, or if the client doesn't want to use any promisor remote
>> +the server advertised, the client should reply only "promisor-remote"
>> +without any value or "=" sign after it.
>
> Why does the client have to advertise anything if they don't want to use
> any of the promisor remotes?

Yeah, it is not very well justified why an empty capability needs to
be sent (from both sides).  My recommendation is to drop that part
of the design, but if there is a reason to keep, it should be done
by explaining how differently the other side should behave when the
capability is not sent at all and when the capability with no
promisor remote is sent.

>> +The "promisor.advertise" and "promisor.acceptFromServer" configuration
>> +options can be used on the server and client side respectively to
>> +control what they advertise or accept respectively. See the
>> +documentation of these configuration options for more information.
>
> One thing I'm not totally clear on is the consequence of this
> capability. What is the expected consequence if the client accepts one
> of the promisor remotes? What is the consequence if the client accepts
> none?

Yes, I also found the documentation lacking in that respect.  The
series talks about how the exchange can proceed, without saying much
(if anything) about what both sides want to exchange promisor-remote
for---what effect does it have on the behaviour of both sides to
send one.  I covered this point in one of my reviews a bit more.

  https://lore.kernel.org/git/xmqqikwl2zca.fsf@gitster.g/

> In the former case I'd expect that the server is free to omit objects,
> but that isn't made explicit anywhere, I think. Also, is there any
> mechanism that tells the client exactly which objects have been omitted?
> In the latter case I assume that the result will be a full clone, that
> is the server fetched any objects it didn't have from the promisor?
>
> Or does the server side continue to only honor whatever the client has
> provided as object filters, but signals to the client that it shall
> please contact somebody else when backfilling those promised objects?

Thanks.

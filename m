Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4B7770E1
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604057; cv=none; b=cqG15HFgnBNlOaqMe1UdTHOlc1h1H9FeXXuABW+DDO3TjrWtmE/UdSbjWZN20xQKqu5fymw2+vnA991qHSAv5R4dg6NyILoaIT7cAyylBPNkJOHW42FsL1MnMS+LatbXyie+JaEOX4UewvVZXNvTJ2Y2XuuAJgPth4HH7j4J2/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604057; c=relaxed/simple;
	bh=5DWGxbCgTY0VbrVhjJjsl8TBlb8Iotkv0G9IUMoaJd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G8X0GhO9Htra4adq1b7SGc7Ff+7TEbGOgfYQapgncQzF3bq7RUHjXXdCrmWmjBzZkt7ldjKQAkTnCS6VHa+x9X6NpEVFtQdDn3g7uRC1kvhgxaTAYcIdkSfoR24VSYv8CWenznVVhQWLP+d9Q/oTMp7a6FaEEiFkUpx30SrPkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=akWkOlhf; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="akWkOlhf"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D6A5933039;
	Fri, 28 Jun 2024 15:47:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5DWGxbCgTY0VbrVhjJjsl8TBlb8Iotkv0G9IUM
	oaJd0=; b=akWkOlhfvyWB0GJKFyRf4xz7GBjHCf5emhUq7Yy6zKZNDBgmj/32mg
	hkqLbSiaG0o8o9ejnVlFpEkIsQHIVslUi49Kkg4USjdCcvZt58vFObo4yHiUzct1
	TWWNs5FOJGoG5/lgRxsn8fqw/lVT2allRjta/2qcvjvW4kISViQPA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CBBC233038;
	Fri, 28 Jun 2024 15:47:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B648933036;
	Fri, 28 Jun 2024 15:47:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Josh Soref" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Phillip
 Wood" <phillip.wood123@gmail.com>,  "Jeff King" <peff@peff.net>,  "Patrick
 Steinhardt" <ps@pks.im>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <avila.jn@gmail.com>,  "John
 Cai" <johncai86@gmail.com>,  "Aryan Gupta" <garyan447@gmail.com>,  "Linus
 Arver" <linusa@google.com>
Subject: Re: [PATCH 1/4] refs: add referent parameter to
 refs_resolve_ref_unsafe
In-Reply-To: <f6abd59c-ea86-423f-9172-79779932418b@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 28 Jun 2024 17:30:08 +0200")
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
	<011c10f488610b0a795a843bff66723477783761.1717694801.git.gitgitgadget@gmail.com>
	<xmqq34pqlyou.fsf@gitster.g>
	<F64F4F3A-EF82-4281-8A75-0DDC8FA65D4B@gmail.com>
	<xmqqed99k7xo.fsf@gitster.g>
	<f6abd59c-ea86-423f-9172-79779932418b@app.fastmail.com>
Date: Fri, 28 Jun 2024 12:47:29 -0700
Message-ID: <xmqqle2o26jy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 418191BC-3587-11EF-9BBF-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

>> ...
>> https://github.com/gitgitgadget/git/pull/1694#issue-2187804953, it
>> carried over the email addresses as Markdown-formatted hyperlinks.
>> Currently it reads
>>
>>    Cc: Christian Couder [chriscool@tuxfamily.org](mailto:chriscool@tuxfamily.org)
>>...
>>    cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
>>
>> when I click on "edit", where the last line must be from your manual
>> fix which GGG picked up. I've cleaned up the PR description manually
>> now, and for this message I'm also attempting to clean up those square
>> brackets.
>
> When I read that I assumed that Aryan had made the same mistake.

Ah, I see.

I wonder if there are things we can do to help reduce the pain in
future users of GGG here.

 - Is there some documentation update we can make on our end,
   perhaps in Documentation/MyFirstContribution (SubmittingPatches
   does not talk about GGG other than refering readers to
   MyFirstContribution)?

 - Or the welcome message GGG adds to the pull-request that begins
   with "Thanks for taking the time to contribute" can mention
   something about this?

 - Or possibly the handling of Cc: addresses done by GGG can be
   tweaked not to cause this?

Anything else?

Thanks.

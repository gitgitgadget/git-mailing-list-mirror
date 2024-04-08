Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE4E13E411
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587952; cv=none; b=ApiQVS/+otqhF2CIn8NydogKmXwXLin7JQ6diwS/EXq6VdcXOdtdneyqKqPZlOha2l7Wj042iDNsLo5fGe+J5Dvl5EgtlNHCp3+t1s26J8JrI7YRqFv+PUVeCUD5MVY9KzPrUrUBdeQFyeQNAZyj7vUZbsQ8gfcWFjh8MF/fDBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587952; c=relaxed/simple;
	bh=vVr9flNWzsPcHdnBha0p1ICmMSVZY3UOjKXmSr2bsA0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n0AYiMh1UrQLvg9iRDEID3kqhlmT3fwhHqvPjmOlJYSPT8sBk9VrzuU5lI8z6xuXu9fxHSZs/YWYnNs9onJ6rp+kjwsh6ly+dY96Z8xrVXTpaNpFZUdYd2XXBxB/+AYnij1nVXjTxgAU6MjzGFAbqmkOQ3HLuzoIGU5yM8S+oRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fb3KJ/C8; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fb3KJ/C8"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 94F583880E;
	Mon,  8 Apr 2024 10:52:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vVr9flNWzsPcHdnBha0p1ICmMSVZY3UOjKXmSr
	2bsA0=; b=fb3KJ/C89D7/SZ7EesHd22zbi/t5Gno48AwexvTsfFGlxxsYMQjWog
	QzCUI6UUNK/7fdU0KzoRiKMg7iFUhsEEXss5RKLE/9uLFNcifmiG3xKcoVbvegj7
	qp6LvQYK3+XVdEZqJbXKo29uF47dRQq69a0aBwDZnWWjE8RNBHxU8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C68A3880D;
	Mon,  8 Apr 2024 10:52:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 05D683880C;
	Mon,  8 Apr 2024 10:52:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Thalia Archibald
 <thalia@archibald.dev>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/8] fast-import: tighten parsing of paths
In-Reply-To: <ZhONyBIFlWbNHNwN@tanuki> (Patrick Steinhardt's message of "Mon,
	8 Apr 2024 08:25:12 +0200")
References: <20240322000304.76810-1-thalia@archibald.dev>
	<cover.1711960552.git.thalia@archibald.dev>
	<A820E635-14FA-403C-B932-D7F9FE57C092@archibald.dev>
	<CAPig+cSu5dLoDew-efAB-H95B53fteDGNO=_1jc9i_MUqdpw-g@mail.gmail.com>
	<ZhONyBIFlWbNHNwN@tanuki>
Date: Mon, 08 Apr 2024 07:52:18 -0700
Message-ID: <xmqqpluzgb4t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 99A1D52E-F5B7-11EE-B9AD-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Regarding `Reviewed-by:`: that trailer doesn't mean that someone
>> merely read and commented on a patch. Instead, it's explicitly _given_
>> by a reviewer to indicate that the reviewer has thoroughly reviewed
>> the patch set and is confident that it is ready to be merged into the
>> project, at which point Junio typically adds the `Reviewed-by:`.

Just to clarify, "adds" means "cuts the reviewed-by lines written by
the reviewers in their review messages and pasts them into the
commit message, either amending the commits after the fact or while
applying them".  I do _not_ judge from the sideline the quality of
reviews given by others and say "yeah, that is an adequate review,
so I'll forge _their_ reviewed-by trailer".

> Anyway, I'm currently trying to make it a habit to pick up and review
> random patch series that didn't get any attention at all every once in a
> while, ...

I have noticed your effort and appreciated it very much.  I wish
there were many more others who do the same.  I of course have been
playing that role for some time as the final catch-all reviewer, but
a single person does not scale.

Thanks.

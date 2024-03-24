Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EE21C692
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 21:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711317082; cv=none; b=Yizwn/LK6EM9Q0w/PAIPdyyCQMMKMCmkzGmHmr+HJt7P1wzFN/mD/QvV52/xR63V91Rl5ofKZxHvH6Pgh5KVAcPgL/i4FlMr4d3H1oGzwJPjrtxwTFv4IytvQMJrVn46hrl+gA4BT/9TgEKiFk8StmY0T5bGXOyiCIEpc0VXov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711317082; c=relaxed/simple;
	bh=rxOLy3Eouec/sC+wJT5bssK4dk0u8NWL52j9unu8PfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m4R0xoyQCOIdWDdS9u6ZDGNZNdVVht777OrKd2LVFzyhVAdoCx3o6cRKIF+jSoqIa1OZga9gf1ZFQjKWQcI4PrVSrqPiK1xR/ujr4lU/vpUZh9cqjlVQ0ILfX0K1dIZUdFin0ybUS8+KXpsQ6+GPhKVN880jwPb9r5vaOBenJRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bIWHxcq4; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bIWHxcq4"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E2BC1E12C3;
	Sun, 24 Mar 2024 17:51:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rxOLy3Eouec/
	sC+wJT5bssK4dk0u8NWL52j9unu8PfE=; b=bIWHxcq4fjvJDtIXUlH76CxI0VDc
	OKnvkWBiibCfs8ya4CveWZu0nx3sCVqnkyBghNBzSCXVGUUffcMZtCrkxNAWD4n5
	lTomFAJtBVYMGD1MCKLsX+RAjHwv0/QT/mZ8Apeb2WmzgwuAAnahhCaCY2Hxsk0e
	Bvis2jgR6zKfP8Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7585C1E12C2;
	Sun, 24 Mar 2024 17:51:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DF6AD1E12C1;
	Sun, 24 Mar 2024 17:51:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marcel =?utf-8?Q?R=C3=B6thke?= <marcel@roethke.info>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] rerere: fix crash during clear
In-Reply-To: <ZdnSEFgLdev3L2qs@roethke.info> ("Marcel =?utf-8?Q?R=C3=B6thk?=
 =?utf-8?Q?e=22's?= message of
	"Sat, 24 Feb 2024 12:25:04 +0100")
References: <20240218114936.1121077-1-marcel@roethke.info>
	<20240218194603.1210895-1-marcel@roethke.info>
	<xmqqplwsx730.fsf@gitster.g> <ZdnSEFgLdev3L2qs@roethke.info>
Date: Sun, 24 Mar 2024 14:51:17 -0700
Message-ID: <xmqqplvjpacq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A561F186-EA28-11EE-8D8E-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Marcel R=C3=B6thke <marcel@roethke.info> writes:

> On 2024-02-19 17:22:43, Junio C Hamano wrote:
>> Marcel R=C3=B6thke <marcel@roethke.info> writes:
>>
>> > When rerere_clear is called, for instance when aborting a rebase, an=
d
>> > the current conflict does not have a pre or postimage recorded git
>> > crashes with a SEGFAULT in has_rerere_resolution when accessing the
>> > status member of struct rerere_dir.
>>
>> I had to read this twice before realizing the reason why I found it
>> hard to grok was because of a missing comma between "recorded" and
>> "git".
>
> fixed
> ...
> I'm unfortunately not sure how it happened. I do have the initial state
> of the repository and I think I know the commands that were executed,
> but I could not reproduce it.
>
> I will look into adding a test case though.

It has been about a month.  Any new development on this topic?

Thanks. =20

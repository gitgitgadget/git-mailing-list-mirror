Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CF817C217
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 19:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726860134; cv=none; b=NmlHFfTjgWB9LaEyoOOO5l7E9l8yl9/kjd8wRlkO4kdATMjqaMMxcVk1F5WGGSwUz2c/QNytJChr54vN/74wKfphyoQHKDstxrE7b2a3IiLi4oZVdv1JY7jaOdCqYydYevI8OXTj/MRFzp7N+Ndc1oM4B+TMpQSoBeNIgAE+A9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726860134; c=relaxed/simple;
	bh=ztwojbolMoMSLvFsAqirwNLxNpMyG2dMLAzncV0H78I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rb6EwZ5gIi1rQEZ6+3li5t2a0+EaNriunbUR2qq3rDGG+TRbmvpiyEgU4e9ce3Ru2ZRdvEXsqabTQ4aoR8ahtgf5XW1JHjCd9E7F7AwIdlvwGpnX86mYvuoDtdoJX5mD7yy+bZKVvfan/i2aYsAhH+gCsHjz50HFqKvtfhxfrnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tZX2en+z; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tZX2en+z"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 338F51DE7F;
	Fri, 20 Sep 2024 15:22:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ztwojbolMoMSLvFsAqirwNLxNpMyG2dMLAzncV
	0H78I=; b=tZX2en+zzlBSJUSJUFMDPPitEJkzsYgLuUgVKZZU0nPKDBfaoaIeRq
	Qd10aKZNlnC7i9+A99j87wdxPgAx5wCIKoo0xdprKfo1rRrTPmYBoGcgo74+Eo2x
	e3//KWjslu2HEBPIejcieZV9hLvSCwog20EUOr8ag3qatem5OSBzQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AF731DE7E;
	Fri, 20 Sep 2024 15:22:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F3941DE7D;
	Fri, 20 Sep 2024 15:22:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [TOPIC 05/11]: SHA 256 / Git 3.0
In-Reply-To: <Zu2EdQs6xf2FRkpa@nand.local> (Taylor Blau's message of "Fri, 20
	Sep 2024 10:19:33 -0400")
References: <Zu2DmS30E0kKug2a@nand.local> <Zu2EdQs6xf2FRkpa@nand.local>
Date: Fri, 20 Sep 2024 12:22:10 -0700
Message-ID: <xmqqzfo2f7vh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A2B6BD00-7785-11EF-B926-9B0F950A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> * Peff: I have a proposal for Git 3.0, maybe this has been discussed?
>   Can we get rid of some of the older protocols (dumb HTTP)?

Please discuss these on list.  Removal of http walker (both for
fetching and pushing) you have my blessing ;-)

> * Patrick: Lots of esoteric things, like show-branch, which apparently
>   nobody uses.

You remove show-branch and you will stop seeing "What's cooking"
("git show-branch master $branch1 $branch2 ..."  is used as a way to
find the commits on each topic branch in flight, instead of running
"git log master..$branch" N times).

> * Elijah: not just removals, but changing defaults, etc.

Yes.

> * Emily: are we interested in non-backwards compatible changes, like
>   adding multi-Author fields to commits?
> * Peff: I think that's a bad example, it can be done without breaking
>   compatibility, but it was decided to not to do it. You're welcome to
>   resurrect the discussion.

Good.

>    * Taylor: the items on that document aren't a checkbox list of things
>      to do before Git 3.0, but isn't a "let's get all of these things
>      done and then we'll release Git 3.0".

Yes.

>       * More that we'll all wake up one day, realize that we've done all
>         or enough of what would go into Git 3.0, then remove a bunch of
>         code, and ship it.

Not exactly (see my recent comment on feature.git3 on the list---we
need a good transition plan and early adopter opt-in mechanism).




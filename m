Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E14177980
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713468129; cv=none; b=Chomhu+uddP/vl1L4vJmsBdoICmF61pH/OE3GDK+VPgOi3yNTcX2ENcS03vxSm2laJsM+/6Ua6G4QinRE7unRQlvcELwiQ97Gat0axUNaxjhliASb49oQUbh/iQ42eb/Z+4dwv8lpejFV2HeCYNYU+SXNBFNQSMbQ+LVWOqTEOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713468129; c=relaxed/simple;
	bh=2b6FVzkB47/yLM0gP0ZV2R0MT6Lw27cCZKE3q9la2cI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T8z5q8g6XWZMcJSqkglG+mJTS3YGOH0bbSoUijIxSsdgLUijbKu8qRZuOQWvXf3TCVvtV1vjywJ65dfe9a8v9u1b9vpPSsy6y3Lb8Lkz3wYsdL3gS1UbVgTc5ZwgXXpM0cdUAqvvFZ8eVYaSLFoY3LOiHPGoIj1JZo/JIRQYV2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uYTSAeok; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uYTSAeok"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4615A1EB7E8;
	Thu, 18 Apr 2024 15:22:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2b6FVzkB47/yLM0gP0ZV2R0MT6Lw27cCZKE3q9
	la2cI=; b=uYTSAeok4pqgzAoruSsRHocelNd/EG5aGT24m9xSjRpZOPoiC0sN9M
	HjHx9dr+UAX1325Ks0rEAetI5/j0977EcZFUlL+EP6GjwDF90+7B4wPFfpy1w144
	djHr9IAAdgpwxb4T8HL+m1VOzJG+c3NbMPPv/4iMPIBhVKLbOgR2E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 13F741EB7E6;
	Thu, 18 Apr 2024 15:22:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 301581EB7E5;
	Thu, 18 Apr 2024 15:22:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/4] upload-pack: support a missing-action
In-Reply-To: <20240418184043.2900955-1-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 18 Apr 2024 20:40:39 +0200")
References: <20240418184043.2900955-1-christian.couder@gmail.com>
Date: Thu, 18 Apr 2024 12:21:59 -0700
Message-ID: <xmqqo7a6tr1k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EDE72C48-FDB8-11EE-8397-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> `git pack-objects` already supports a `--missing=<missing-action>`
> option, so that it can avoid erroring out if some objects aren't
> available.
>
> It is interesting to have `git upload-pack` support a similar way to
> avoid sending some objects in case they aren't available on the
> server.

Is it interesting?  In what way?

> For example, in case both the server and the client are using a
> separate promisor remote that contain some objects, it can be better
> if the server doesn't try to send such objects back to the client, but
> instead let the client get those objects separately from the promisor
> remote. (The client needs to have the separate promisor remote
> configured, for that to work.)

It is unclear what the precondition for such an arrangement to work
reliably, and a lot more importantly, how we can validate that the
precondition holds when "fetch" talks to "upload-pack".  If you get
it wrong, you'd have a server that would corrupt repositories that
fetch from it.

That is where my "Is it really interesting?  I do not find your
explanation convincing yet." above primarily comes from.


Presumably "fetch" could tell "upload-pack" something like:

	I know how to fetch missing objects from this and that
	promisor remotes, so if you choose to, you may omit objects
	that you know are available from these promisor remotes when
	sending objects to me.

using a new capability, and we can allow upload-pack to omit objects
only when such a new capability tells it to?

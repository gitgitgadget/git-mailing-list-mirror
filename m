Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184D81396
	for <git@vger.kernel.org>; Sun, 19 May 2024 01:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716081323; cv=none; b=bvaJCinKSfir7y2O8c38dQiSRsDmLtgV4xEbNm+yCAFek9a6QlgUaljxyePikMDE98EU3PSw6+TUZrWkoAB3oHVm1DIRrPagB6CUb+YAFVVgUuaprsu6iYZz9SHHWMsMryc06CuD5aUKpbpRFX66QpYpV2CZaq5s5aT9Cq6MCVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716081323; c=relaxed/simple;
	bh=B/xotyPCH75oXbo3kWvcBcdlCP/CAU12VWM2cLEDZl0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IbLM2IlGhxTi+pMYAbmym/nhpR47Q1UamsLroM+szEvQjmY3sxi3YFjZ3fEjCTwuIYwI/l4bVwB7cWc5Bww2TdZq9Bm89lnPDJigvk+IG6joz1RH7Z3EgscvJDD2xnDJ6QzfawNobo5s8cL0Yi+IcimAS04s/CRDoGOoHg1LOMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IIDvGZSE; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IIDvGZSE"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BB69433C6B;
	Sat, 18 May 2024 21:15:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=B/xotyPCH75oXbo3kWvcBcdlCP/CAU12VWM2cL
	EDZl0=; b=IIDvGZSE27Hjts8daGjOA8Qm8DHafueJm0Brg3uaw+XVrR7WVWMGma
	gge7TUK/J3gOONUNyAq1twsIxMln0lJbZETuA7H5rEgH1JMFEyk0ZfaqePZY6Yiv
	TR8+KqoHZMnVpMM05COWvDx0zcjZjAR8Xkihw/l+HIngLmqVDpasA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A03BB33C69;
	Sat, 18 May 2024 21:15:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ABA5933C68;
	Sat, 18 May 2024 21:15:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Johannes Schindelin
 via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "brian
 m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 5/8] hook(clone protections): add escape hatch
In-Reply-To: <20240518211224.GA1574761@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 18 May 2024 17:12:24 -0400")
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
	<pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
	<b841db8392ebd924d1893829a7e5e22240f1e9cf.1716028366.git.gitgitgadget@gmail.com>
	<20240518181432.GA1570600@coredump.intra.peff.net>
	<c201bbe3-b404-feed-fcef-8333f72068dc@gmx.de>
	<20240518194724.GB1573807@coredump.intra.peff.net>
	<86d57213-e3b2-c985-6d69-71568c66fc9c@gmx.de>
	<20240518211224.GA1574761@coredump.intra.peff.net>
Date: Sat, 18 May 2024 18:15:12 -0700
Message-ID: <xmqqed9yob4v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3E9B35C2-157D-11EF-A689-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> But it sounds like we're throwing away our usual release-engineering
> practices (where the usual practice for a regression is "revert it, it
> can happen in the next cycle") in favor of a security fix. Again, for a
> vulnerability fix, that makes sense. But for layered defense, I find it
> less compelling.

I find it a lot less compelling, too.

It unfortunately involves about the same amount of conflict
management to do the (partial) revert for all these maintenance
tracks as it would then later take a "fix in the next cycle" for all
these tracks, which made me feel somewhat hesitant.

But considering that we are not talking about lifting vulnerability
fix, it may make sense to do the (partial) revert all the way down
to 2.39 track but do the "fix in the next cycle" only for 2.45 and
later (or even in 2.46 only, without even aiming to touch 2.45
track).

Thanks for a dose of sanity.


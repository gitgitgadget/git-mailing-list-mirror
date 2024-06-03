Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CD01311B5
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717433997; cv=none; b=e1kOk2+0Wss6RD8K8Tn0BqScFhP7MTX2KhMadn5bJyRH/EncmkBWM9+M6FUvv4WrJUbplbUNWkR8GfaEND2+t/G05VOVPIVoncLVbqLVu8g9GLfRIwP5B5u2fZLsy7Z/MuO89Mpik9woWeJNskQ2vKW0HiatWZ3mkt6iVgW2CCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717433997; c=relaxed/simple;
	bh=2yWwFAoG91+l7p2CxyAU1N9KX/qA/hiVjaZWzh7vt+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cPFzKVFAKYQ4Wm/jOLxgqxJr18WeO4qfVYtt0Q3ruy1pLdJ4vOluirF3X4yI065wLmK2GfTJUc2OYEIEsrJx+FpqlYiCliM1R5iYc0pnvnHTvq8/QPkZVi2/Gu9SSC6BEeyTqVtvnQNZrAU7vaGkBSLWb4d6egSxAEiZMQS4FGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=A39Gzp/8; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A39Gzp/8"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 26028338F8;
	Mon,  3 Jun 2024 12:59:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2yWwFAoG91+l7p2CxyAU1N9KX/qA/hiVjaZWzh
	7vt+E=; b=A39Gzp/8g4fdfN5e/WgQejyhZgrlfRl+vE7idAPPo/aQA9U9f7Hm+Y
	wrxYHH7gL5+hq9d1eXwMOjXx5OnjcBP49HOo2KEQmqguxIkHWUoGFqTkDL5hkcPz
	4iz/+yHqEeIHpDww/sG25K22PWr48Sgbn64ut1Qhj2wwPHbqyoaEA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1EBBA338F7;
	Mon,  3 Jun 2024 12:59:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 400F8338F6;
	Mon,  3 Jun 2024 12:59:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 00/27] Compile with `-Wwrite-strings`
In-Reply-To: <cover.1717402403.git.ps@pks.im> (Patrick Steinhardt's message of
	"Mon, 3 Jun 2024 11:38:56 +0200")
References: <cover.1716983704.git.ps@pks.im> <cover.1717402403.git.ps@pks.im>
Date: Mon, 03 Jun 2024 09:59:51 -0700
Message-ID: <xmqqh6ea3qt4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B2730EB2-21CA-11EF-BF85-8F8B087618E4-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Changes compared to v2:
>
>   - I have split up the second patch into multiple patches. This was
>     done so that we can have a deeper look at the respective sites that
>     need adjustment.

We will see how well this helps reviewer.

>   - I dropped the local string arrays that I used in v2 and instead now
>     use string constants with casts in some places where we expect that
>     those should never be written to. This has the benefit that we would
>     segfault in case that expectation is violated, instead of silently
>     allowing a write to those local arrays.

Nice.

>   - I adapted multiple commit messages to not only mention freeing of
>     string constants, but also that writing to string constants is
>     illegal.

Nice again.

> Due to the split-up patch the range-diff got quite messy and was barely
> readable anymore. I thus included an interdiff instead, which should be
> way easier to read.

Triply nice.

Thanks.

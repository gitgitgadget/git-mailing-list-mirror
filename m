Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF51BC09D
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934773; cv=none; b=OXXIBH9efIn2atLyo4A8w56paxrK4BLLXA5fRPz9xQggP2KlrdjAGfbN5X4EWunOozUK/i8Z2pHT9J3H3VnTp/y0wn+Yrf3sGWxUZm+2JexximGcVyU7zy+9nYnaj9vTvtxobrdHk3nzAuHmXzZFCvOkJABjjWuwG7bBEj3ITN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934773; c=relaxed/simple;
	bh=AAWy0maOYLc5RDYBiRu1gdkLvkXIDlwE2vrKkvELj08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SPOYbtWVysNoLGHjN6iuEgHQYlpZeq49ebj7rVpPCHJ0G2utlplT6aVm63ntiSg2aqwymzPzumhIOWFoJu6NMl4SZensERy4SKxA0jeG6VIwM3DROGr5snn3+XWvblMbM4cydpluW89NSmvJzTOP6Ch8nUDfsQxbZlSi9d0YsKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=o6ik/lPT; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o6ik/lPT"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 540CC316BE;
	Tue,  2 Jul 2024 11:39:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AAWy0maOYLc5RDYBiRu1gdkLvkXIDlwE2vrKkv
	ELj08=; b=o6ik/lPTrE7eyEupnUgOYCtrxHvLZHPSm/LQ+2ap19KkYeVIQvTQ0l
	IdkSICyL6E9Z18xy6OqMsef3tGRwvODtT2rWSs4slex6lujcUqHfOpcJFx2gxZX3
	hozR90ithLS6UYLQEktWj0JxF/6mP0ggSCReMyRNzozgRLxC9yBIs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4CC05316BD;
	Tue,  2 Jul 2024 11:39:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CDCD9316BA;
	Tue,  2 Jul 2024 11:39:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v6 00/11] ref consistency check infra setup
In-Reply-To: <CAOLa=ZSFTcMn+CsEcE1G5hnW37rw81zcUaXBywVY7xbBN7mhkA@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 2 Jul 2024 10:33:36 +0000")
References: <Zn2Ah3WDhtOmzrzn@ArchLinux> <ZoLHtmOKTfxMSxvw@ArchLinux>
	<CAOLa=ZSFTcMn+CsEcE1G5hnW37rw81zcUaXBywVY7xbBN7mhkA@mail.gmail.com>
Date: Tue, 02 Jul 2024 08:39:25 -0700
Message-ID: <xmqqplrvst02.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 44411436-3889-11EF-A3F1-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> If I understood Junio's comments correctly, he was drawing out the point
> about if we even need the separation of options for refs. Since the only
> option we're adding is a verbose:
> ...
> Your approach seems to take a different path though, where we create a
> new route of creating two new structs, one for refs and another for
> objects and adding both to fsck_objects. If we're doing this, wouldn't
> it be better to use the enum+union idea, like Junio mentioned? That way
> we would have clarity around which type it represents.

Yup.  If we are going to over-engineer this, enum+union would be a
reasonable way to do so, but we should ask if we need to split (and
more importantly, if we know the problem space well enough to make
the right split) in the first place.  Just like premature optimization
is bad, premature factoring and over-modularization is bad.

Thanks.


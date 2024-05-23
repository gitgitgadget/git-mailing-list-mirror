Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D964C12B7F
	for <git@vger.kernel.org>; Thu, 23 May 2024 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478558; cv=none; b=YGmCUo72xHZvcSK92n+4RNI5qOVwRwQz2fFi0r+1rGO3j67wCPSeWFvD/sEiHYB+k7OLpNR/aziLtX7cEM3HuENTY2gvrMn1dcFlMMBmuuuaWfiefLNXy3DkAWFXtMjF319DDG0KrvQbwAMemeVhanLFKjmxlLCmqrDE4eOOoig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478558; c=relaxed/simple;
	bh=mVICBif+4KJRwoUrEQjgXqmhokl+ea7yb4xk7rJXJTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ipkqJn282UzVWoWpELNNJD15gmTrhzvjkRBoYDIOORwYdGYtM/Zz7mXywZi7bfD07zk/B544k2/zmHVfSkCRc3qTNdpQTuZYFFViSGoIgwJ6DIo7WOTvwv51q/8jB2oPPyC45sEUgZCFBfNYUlxWGntyoMlPimeP4vIc9+3fDRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TjAGqiR+; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TjAGqiR+"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7350E1D07A;
	Thu, 23 May 2024 11:35:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mVICBif+4KJRwoUrEQjgXqmhokl+ea7yb4xk7r
	JXJTI=; b=TjAGqiR+A+aDD0NcK5p6dzI3wZgxS9o9bwK54S6WU9s98Ea3oUs5Kz
	iB+kJ/HKfHVZgiWUDHy3CsLoO25vngk0jB7kIApUp86xg+xza1HpOwqBWFiRIqHS
	37u3+D69p5hFsQeJSEd1DxAzZCI23XMqljJnxWhJteCg7iiPnp4fc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6CA771D079;
	Thu, 23 May 2024 11:35:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 110EA1D078;
	Thu, 23 May 2024 11:35:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Kyle Lippincott <spectral@google.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: avoid bare "gcc" for osx-gcc job
In-Reply-To: <20240523091059.GE1306938@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 23 May 2024 05:10:59 -0400")
References: <20240509162219.GA1707955@coredump.intra.peff.net>
	<20240509162415.GB1708042@coredump.intra.peff.net>
	<CAO_smVhE25ZQqc1f_fx9oPX-kH8SHxwEc=mqOAi-xQ91+pF1CA@mail.gmail.com>
	<20240510220228.GA1962678@coredump.intra.peff.net>
	<xmqqseyp1dys.fsf@gitster.g> <Zj-pGGGJEXlH02nR@framework>
	<20240516071930.GB83658@coredump.intra.peff.net>
	<ZkXX5MlN3EbaMhNG@tanuki>
	<20240517081909.GB1517321@coredump.intra.peff.net>
	<xmqqseygjrwo.fsf@gitster.g>
	<20240523091059.GE1306938@coredump.intra.peff.net>
Date: Thu, 23 May 2024 08:35:51 -0700
Message-ID: <xmqqle40wnfs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 23B7946C-191A-11EF-A7F8-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> ... be a pain in practice, though, because now the CI results aren't quite
> deterministic. So if commit X introduces a bug in some combination, we
> might not find out until later, and seeing that X passed all tests
> doesn't absolve it of responsibility anymore.

Right.  A poor idea retracted.

Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626DF1A57D4
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524394; cv=none; b=fqdavdLIZt1iEfnACFzT2k1gX2QQiBW+HGgo5zsECK9l2eOw7G+wOnZLWksJRHT40yfMerjoY+j7qIoEN9nPj4rlln/+u6Zh4jVDR0SS1Y7uwRBj8ApK4iXB9PF8J51ooQLxRUU5w3FVkQhVra0UNTMhI0NwVNdP0oUmbnfG7tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524394; c=relaxed/simple;
	bh=hQjZZS1Xng2sR0bxsmeIke4gANPMWg8XKm1S0LpCNKQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d/6FbE4gfR6yqemZpx13Qx+zNlrTe1QTPqpzBid9Uf2tJeldKp2Aa+UQYdOrs+sRPTKdYiquicH7jbBAixOa3PBfQ4xa7slTih43BgF0W2XfIOF+A6SVYB32X7ysIkCBd54VS5DhtxpY97jSv8lLAmHvVoCki67Psn679zAv1uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jUhv74E9; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jUhv74E9"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C999F28328;
	Thu,  1 Aug 2024 10:59:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hQjZZS1Xng2sR0bxsmeIke4gANPMWg8XKm1S0L
	pCNKQ=; b=jUhv74E9I7W75TDbjql0W+ZWp2DffQsWeuNErUbjhJgtgMkgk9z7d9
	7IGmX0+uRHOcGil1HJhqdwJdxer3fwpTTe3JKw9N5hsd48MxBAxqd6409xybtD/N
	lCCMOcZP5nrf8Vg3EXPWGzew3xQCxu9wNzSGWVt6uGJghykcUZ6ck=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C1A1828327;
	Thu,  1 Aug 2024 10:59:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C905228323;
	Thu,  1 Aug 2024 10:59:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org,
  "brian m. carlson" <sandals@crustytoothpaste.net>,  "W. Michael Petullo"
 <mike@flyn.org>
Subject: Re: Git clone reads safe.directory differently?
In-Reply-To: <20240801061417.GD621899@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 1 Aug 2024 02:14:17 -0400")
References: <20240727215845.GA1263246@coredump.intra.peff.net>
	<ZqZjRMqpEV_3WIkD@imp.flyn.org>
	<20240728224807.GA1299337@coredump.intra.peff.net>
	<ZqjQi6i2kiY4gcc1@imp.flyn.org>
	<Zqlo-i8uCb1Yr4Jm@tapette.crustytoothpaste.net>
	<xmqqv80m8pha.fsf@gitster.g>
	<ZqlxtGIyz0G9jlJr@tapette.crustytoothpaste.net>
	<20240731072832.GB595974@coredump.intra.peff.net>
	<xmqqo76d7coa.fsf@gitster.g> <xmqq1q391afc.fsf@gitster.g>
	<20240801061417.GD621899@coredump.intra.peff.net>
Date: Thu, 01 Aug 2024 07:59:47 -0700
Message-ID: <xmqqbk2cxp98.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B2A431D4-5016-11EF-BDE3-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> ... if that is OK or not. My mental model has remained "it is OK to run
> upload-pack on an untrusted repository", but it would make sense to get
> input from folks who looked at this in the past, like Dscho, and/or to
> reassess the threat model from scratch.
>
> In particular I did not follow all of the potential issues with linked
> local files. Are we good now after other fixes (in which case this patch
> is OK)? Are we good only for non-local clones (so this patch is OK only
> combined with a fix for clone to check ownership for --local mode)? Or
> are there still problems if an attacker controls the repo paths, in
> which case upload-pack should remain conservative?

Good questions.

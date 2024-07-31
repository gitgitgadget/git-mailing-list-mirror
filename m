Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5D01A76C2
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722443034; cv=none; b=LUy68TdqJk/4jw3MRwja5jZS6Xsn1LiprmPocDIvkz6vx1bdaimPk0MHsfQ4MtsENycOmRxRl5hyZYhk9fCb30snZj3fhItHhvZ6raG+PnVXuSoIwUedjY4hzL+NrU21pwdixbP7gyO5r4jMcS9x1PYtfqbFNHtk2N3fwv7cZZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722443034; c=relaxed/simple;
	bh=C25ALLaMh1an4SSaD1wwEGccc9xrsc9L22xDPOyugDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nVgkJci/+c1lqapLuIST2bE5DwmoVSJ4AZi6zeYA3iFS5nxo7Sr5nxGUOY90D8lpqoC9lj4v1GewcISQONl+XlTw8ZS/fH5vREaEjqDbrazKsfnFvORvyk10wthOvZcxwlAwiC/4Yv9hlF2Wgz5HD+Kc382lyK+jO09siEdferI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GDRHyGLB; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GDRHyGLB"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 920A91F102;
	Wed, 31 Jul 2024 12:23:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=C25ALLaMh1an4SSaD1wwEGccc9xrsc9L22xDPO
	yugDk=; b=GDRHyGLBN9ct+8Ge9nhU0nDRd/sFMrtlDIuuSlErm7g7k/JdZU3/go
	CnAbi8Bc2xrkMwFscxI4Szziu8Hr1WVPeNpzKYjuf4OrrS3IieMFmI9FYTIFJemn
	0/imsyAmkMI6TWdiWvFKCs7KZ6XoAPkXbhv3PkSA3M5ABO+6v3z0A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 89FFD1F101;
	Wed, 31 Jul 2024 12:23:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E06731F100;
	Wed, 31 Jul 2024 12:23:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  "W. Michael Petullo"
 <mike@flyn.org>,  git@vger.kernel.org
Subject: Re: Git clone reads safe.directory differently?
In-Reply-To: <20240731072832.GB595974@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 31 Jul 2024 03:28:32 -0400")
References: <ZqUc8DJ1uKcHYlcy@imp.flyn.org>
	<20240727215845.GA1263246@coredump.intra.peff.net>
	<ZqZjRMqpEV_3WIkD@imp.flyn.org>
	<20240728224807.GA1299337@coredump.intra.peff.net>
	<ZqjQi6i2kiY4gcc1@imp.flyn.org>
	<Zqlo-i8uCb1Yr4Jm@tapette.crustytoothpaste.net>
	<xmqqv80m8pha.fsf@gitster.g>
	<ZqlxtGIyz0G9jlJr@tapette.crustytoothpaste.net>
	<20240731072832.GB595974@coredump.intra.peff.net>
Date: Wed, 31 Jul 2024 09:23:49 -0700
Message-ID: <xmqqo76d7coa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 458D997C-4F59-11EF-870C-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> It could be that "clone" should try to avoid a "--local" clone from a
> repo with different ownership, if the local hardlink path is more
> dangerous. But that distinction is not something upload-pack even knows
> about, so the code would have to go into clone.

Sounds good.

> And then upload-pack
> could be free to drop the ownership check. Certainly a lot of people
> have complained about it (I had actually thought we reverted it in
> v2.45.2, but that was just the extra hooks defense-in-depth; so again, I
> may be getting confused about the extra value of the enter_repo()
> ownership check that came at the same time).

As enter_repo() is about the protocol driver thing and not about
normal users working inside a repository, calls to it appear only in
receive-pack, upload-pack, upload-archive, http-backend, and daemon.

Among them, upload-pack is the only thing we promise that is safe to
work even in a hostile repository?  If we push into a repository
over the local transport, we would trigger post-receive hook as
ourselves, which we would probably not want.  The same story goes
for daemon, http-backend, and upload-archive.

So we probably need to add another axis to the "strict" parameter
enter_repo() takes to selectively disable the ownership checks only
for upload-pack, or something like that.

We may want to restrict "tar.<format>.command" only to protected
configuration and then we may be able to loosen the ownership check
for the upload-archive command.

Thanks.

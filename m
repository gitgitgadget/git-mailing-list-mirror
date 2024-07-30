Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E88618FC9A
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 22:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722380124; cv=none; b=uMhi+xkEPnH5fHB1HE66P3I0Kc4JvW+ufpq678+qUyHkX2jJZ8ErTMslKRI+fF9HpCHaEElC8memmB0hlJJ1MxMKgM9MvhhT2AgCjzAtiIOvuOC35KzmZzQyIbcsFyB0zKWfW8NzMsWZhRscKJf1mcW6iDJuF7E9RRtaKZr6zvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722380124; c=relaxed/simple;
	bh=OOf5dTaPt9LxPiXXYIRdWVRb8nrU0+uzPTtQPmoxIFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CccmN0JPgW36IkWpBmizxeAvfsMdgsbYTcJU+VzwCYrhIdUjjsTZhe+FS/qH65xx0ROe8MPG9lb42DVjyCMqkigAuWEiCiMGvJJnQA16Zpz2c0nMEorSTsJx+A3MKoUJ0SWMgD89uV/FTbosXlIVqg/RA0iwfExApEN0vqrLy6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=c+JTeFlT; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="c+JTeFlT"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 918721CCD6;
	Tue, 30 Jul 2024 18:55:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OOf5dTaPt9LxPiXXYIRdWVRb8nrU0+uzPTtQPm
	oxIFc=; b=c+JTeFlTALCymyNmw2WHHuz44v0lvkvgSZJJQdKNQssqqZG1jizClz
	sCbXeXbWZjZwBTckeNuPBBklsHARlOtZfe3o3qoAY21J5XHTa69qhBtN50x7xxHw
	GpVsJm8z9VK+lWXwj6a2MaPIO6bWXNMY0PRmdbxGZLnLTRKnKccY8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A3B01CCD5;
	Tue, 30 Jul 2024 18:55:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 254A11CCD4;
	Tue, 30 Jul 2024 18:55:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: "W. Michael Petullo" <mike@flyn.org>,  Jeff King <peff@peff.net>,
  git@vger.kernel.org
Subject: Re: Git clone reads safe.directory differently?
In-Reply-To: <xmqqv80m8pha.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	30 Jul 2024 15:49:37 -0700")
References: <ZqUc8DJ1uKcHYlcy@imp.flyn.org>
	<20240727215845.GA1263246@coredump.intra.peff.net>
	<ZqZjRMqpEV_3WIkD@imp.flyn.org>
	<20240728224807.GA1299337@coredump.intra.peff.net>
	<ZqjQi6i2kiY4gcc1@imp.flyn.org>
	<Zqlo-i8uCb1Yr4Jm@tapette.crustytoothpaste.net>
	<xmqqv80m8pha.fsf@gitster.g>
Date: Tue, 30 Jul 2024 15:55:17 -0700
Message-ID: <xmqqr0ba8p7u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CB379354-4EC6-11EF-8226-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> When you are using "--no-local" on the same machine, I do not think
> there is any guarantee that "upload-pack" side is safe.  And that is
> where the safe.directory thing needs to kick in.

Ah, I take it back.  packObjectsHook won't run based on what the
untrusted source repository configures, so at least we have been
aware of the fact that upload-pack must be more careful than other
stuff.


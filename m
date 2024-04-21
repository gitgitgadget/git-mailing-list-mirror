Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7275D286AC
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713723481; cv=none; b=Kemts/nOwkDhTt8zo3W6dLJIHqqUrg/oE/LDUSuQt1hPcSvawJc/x6pteIu9yqwDDauY7UI8uWAQYRyGK2vlYfRCYLmBZ2DftWfvmnx56ac3EzEkQODJgjqUi1HRIHgdyq8yu6BPKZkaWOjVJi5paPxN0zEnYuUKLnP/9orzKVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713723481; c=relaxed/simple;
	bh=RoZFDzLCBpZkzAlb8B43NiDe3Nf0wuO/nWhl9Pl5+9M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rr2mLiw55xdQaSnxam8bQqf7yX4c1pOr3HxclsovB4r50Qq0GwFFnavNPPnke3xG5VMWUZj09No35CpT5EUpS+8rOrok2pdRqVzlhcChNhIV8aYPiVv857vJ1qTecHBhQxtjAfKQmHHPo2C6ID9LLkXbtObX2IOfrHZbrTbE6DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=F1D5JGVv; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F1D5JGVv"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 51D9D230A2;
	Sun, 21 Apr 2024 14:17:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RoZFDzLCBpZk
	zAlb8B43NiDe3Nf0wuO/nWhl9Pl5+9M=; b=F1D5JGVvgR9slYWPjStlaGvQ/vvQ
	qmb73sZruJnX+6eCB5qvLRr0QT2/QLBsXkZIVflDW52Ad2pRG1iKJX4CTUDWH3CG
	rfUGC+EmGbqowvNSAf12dUMvgQJ/ASAx5xvfHlOGYCH1NZa+IBb9wP0F4F61y1bl
	duB39+v7gb7dNbY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C70D230A1;
	Sun, 21 Apr 2024 14:17:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 98A44230A0;
	Sun, 21 Apr 2024 14:17:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: German Lashevich <german.lashevich@gmail.com>,  git@vger.kernel.org
Subject: Re: Possible git-diff bug when using exit-code with diff filters
In-Reply-To: <82561c70-ec33-41bf-b036-52310ffc1926@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 21 Apr 2024 12:42:18 +0200")
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
	<82561c70-ec33-41bf-b036-52310ffc1926@web.de>
Date: Sun, 21 Apr 2024 11:17:48 -0700
Message-ID: <xmqqy1961sxf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 769CF8DE-000B-11EF-BC40-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> You can more easily reproduce it by setting the environment variable
> GIT_EXTERNAL_DIFF or the configuration setting diff.external -- no
> attributes needed.

Indeed.

A much simpler fix may be to declare that these two features are
imcompatible and fail the execution upfront, instead of just
silently ignoring one of the two options.

As a person who is very much used to the external diff not
contributing to the exit status (who also invented the external diff
driver interface), I would be a wrong person to judge if such a
simplified approach is desirable, of course, but just throwing it
out as a food for thought.

Thanks.

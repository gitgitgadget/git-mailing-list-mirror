Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100E71822F8
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722095888; cv=none; b=rvYzeUV53vBPKbpZ9zkI+8cggATkz+kDhsD+/lKiS2OUpNHg1TpRrtd5f6bb8cKFI6Lvzaukp9fPoIqE0OAoSWyYgBxkCJrbNUCaEP9197BqF7WU/P7MgQc96tzqUKnZYuj/cuyIPKCf3MB8MB6kRynyQRmkc+9CnKiVKQTJWm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722095888; c=relaxed/simple;
	bh=CbtMyIa21S9yaWJplF2HjLYiv95Be9NMI+Z1OVKd6nY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d/VZAqNHNQP0Fdi9Pn2x7JQKxbxgXrB1hWxiZ0N7O3zXRJPnIpO06Sk0f2FW9tI8ZZu2YpmwGbw44j71btJA5AfPHbAzBVfefq1jWmC66xaBxNExMNPL04LoM+Fk2Mp+EYNnuSHYqiV3r3jKfrH8QuiMGZ0BfEC3V+2F0cld5Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=p5JYUlFr; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p5JYUlFr"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C0E372D29B;
	Sat, 27 Jul 2024 11:58:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CbtMyIa21S9yaWJplF2HjLYiv95Be9NMI+Z1OV
	Kd6nY=; b=p5JYUlFrcwUr1HBQtfr0A2l7rxoGRePQp/laVVRUZJGNMr8QOP9Z08
	2wvmhGJJ2ywmH8Qww8GgSAnF9vU+G84uskqFfAs2POf4jK7JjRpu1tZxM3S0A8Iq
	wbFlF/RoET/Q3LHPUWTkvDibPWQV1MXoN+hGODvJDU5j/drB2fYyI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B10932D299;
	Sat, 27 Jul 2024 11:58:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C3B82D298;
	Sat, 27 Jul 2024 11:58:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Bug with bash and OpenSSL usage on Windows
In-Reply-To: <xmqqttgasufx.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	27 Jul 2024 08:53:06 -0700")
References: <CAD+08a87xxVRxO1eiWiam-7xvq=AyKUB-MzqG-r=rM_SYbquBQ@mail.gmail.com>
	<ZqUF0ANz9qX-wWEN@tapette.crustytoothpaste.net>
	<xmqqttgasufx.fsf@gitster.g>
Date: Sat, 27 Jul 2024 08:58:03 -0700
Message-ID: <xmqqplqysu7o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 023588B8-4C31-11EF-80B9-BAC1940A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> I've been wondering if we can somehow reduce the occurrence of such
> an issue in the first place.  Elaborating a bit more in the
> "Reporting bugs" section of the documentation landing page is
> probably the 0-th step, ...
> ...
> +respective packagers, not to the Git mailing list.  How to report
> +bugs in some sample binary packages are found here:
> +
> + Git for Windoes: https://github.com/git-for-windows/git
> + Ubuntu: https://help.ubuntu.com/stable/ubuntu-help/report-ubuntu-bug.html.en
> + Debian: https://www.debian.org/Bugs/Reporting 

I forgot to mention that this weather-balloon patch was primarily to
show the shape of the documentation updates, and corrections to use
more appropriate URLs or additions for other binary distributors are
of course welcome.

Thanks.

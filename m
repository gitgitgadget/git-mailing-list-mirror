Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCB514D431
	for <git@vger.kernel.org>; Thu, 16 May 2024 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873791; cv=none; b=IlNlM0dM9SW7G275uLCf+I7JR07Rxp8zb1xHEKaqD6KA2MxE0KfklUWTBIwtagTa4Ar0mF3ly2qyVxUrbFiYGHAeTkdxrtasT7VKvkmlg3xqwcZqdTM411H7iSxzJRgbjz/XX0j4ytVCoQWUst9tmoSSQP4MJ5SWkq5CJBOTEsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873791; c=relaxed/simple;
	bh=YKCiWJbyyIAkB1AZhVIPGH11ZrngGsPTmwyNaI0PHxU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gm5Q8PGkd926OtOty5DNJ6lk6DbC6tg7l7EoMouj8MofepbmxDxQiuH5MkUTc/mSwxZEgazYKwTO4CWJBRYzYYyzMpTuvWD+tgToceAatExVRNiZLuBArP+xFnQfum4jZ9MGmB86C1Kl46/vmeup5L9WeWK+qoHu6eah2pEs6c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WxX3krrf; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WxX3krrf"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B69F8268C4;
	Thu, 16 May 2024 11:36:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YKCiWJbyyIAkB1AZhVIPGH11ZrngGsPTmwyNaI
	0PHxU=; b=WxX3krrfhiR9rtMp60B4cw/k/ZFe/FT2e7R4AlEQDZjikZtXLgcL3W
	BODOPPoBEUN9s4xSDQiuv7uKIUrposggB2Xcgc+4rGo/RGd1orc1DULnRYJZslQt
	f1p+b9ej9hAF0jXoPLvfOPGP24JGpx9PXo7o/4DldcDsUEtk3tDdo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AEA7E268C3;
	Thu, 16 May 2024 11:36:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 47C19268C2;
	Thu, 16 May 2024 11:36:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sam James <sam@gentoo.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] diff: copies-harder support
In-Reply-To: <8734qihft5.fsf@gentoo.org> (Sam James's message of "Wed, 15 May
	2024 23:27:02 +0100")
References: <20240311213928.1872437-1-sam@gentoo.org>
	<875xwr27le.fsf@gentoo.org> <87sezm1116.fsf@gentoo.org>
	<8734qihft5.fsf@gentoo.org>
Date: Thu, 16 May 2024 08:36:18 -0700
Message-ID: <xmqq8r09u5u5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0B0D44C8-139A-11EF-9224-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Sam James <sam@gentoo.org> writes:

> ping - let me know if I need to do anything different. Thanks!
>
>>>
>>>
>>>>  Documentation/config/diff.txt   |  8 +++++---
>>>>  Documentation/config/status.txt |  4 +++-
>>>>  diff.c                          | 14 +++++++++++---
>>>>  diff.h                          |  1 +
>>>>  diffcore-rename.c               |  6 ++++--
>>>>  merge-ort.c                     |  2 +-
>>>>  merge-recursive.c               |  2 +-
>>>>  7 files changed, 26 insertions(+), 11 deletions(-)

Copies-harder is supported from the command line already.  We do not
want a configuration variable for it.  diff.renames configuration
was already a mistake enough.  Let's not pile on a new mistake on an
old mistake that it is too late for us to take back.

Thanks.

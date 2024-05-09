Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C226AA7
	for <git@vger.kernel.org>; Thu,  9 May 2024 16:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715273554; cv=none; b=KDmZP8tiGE2jlrvvqwyNCdZaiHgOiKqwb9NZGq0UQG14UnY6J444WFroaKkUiyUO6QlbZs0bqwz1RE74CjxuFqrUnX9ythgBU9C8Pht2r2yWnLjCeYfUHSgL+z/DXu17wNLs4j5E4Xob5+P2AlvGe4wRTdyEEqS4c/B217ssgbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715273554; c=relaxed/simple;
	bh=jHWEGi19WHS7Sti3ZWMc9l5A8td9bo7ZPjeWMzUCw8A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XEvzINaSrg0e+6OdwnDdszgNRQqh4ceGZcYRoQxQhzTh6Iu7TrA+63RMbhPbHgYFhjXAJtu0QDCS8JYIFkXC2aKc7RIDfelOAdqtWwiNevEFbYcZttqbFi77MXNwc2SE/aI/v7ZG6yVoDLz6uRu5L8VHP/yepQ8Pa0s2q69uAMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uOCGkb7N; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uOCGkb7N"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 402D23793D;
	Thu,  9 May 2024 12:52:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jHWEGi19WHS7Sti3ZWMc9l5A8td9bo7ZPjeWMz
	UCw8A=; b=uOCGkb7NSMwIHjyFX/KrM9WxFizgPXYBYX7LgioPemE9T/KSZxltGJ
	N9L7JwngWoZxnkgJ+oFWctJdAZRf3ngedOiTNZJ4L/rPOlbKI3Cpw2hUVJrUhAvr
	DGcVyVzEhke+OqEd/gh2oZFmaF6SaSeDPwX9ywL305tppD9NSUGbs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 38F213793C;
	Thu,  9 May 2024 12:52:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 98DCA3793B;
	Thu,  9 May 2024 12:52:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] un-breaking osx-gcc ci job
In-Reply-To: <20240509162219.GA1707955@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 9 May 2024 12:22:19 -0400")
References: <20240509162219.GA1707955@coredump.intra.peff.net>
Date: Thu, 09 May 2024 09:52:30 -0700
Message-ID: <xmqq7cg3udv5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 86E2F05A-0E24-11EF-A02B-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> The osx-gcc job seems to break reliably for me, which started in the
> last week or so (since the last time I actually triggered CI). The third
> patch fixes it, but I noticed while investigating that the job is not
> even running gcc at all! That's fixed in the second patch. And the first
> one is just a cleanup I found along the way.
>
> I'm not sure that this job carries a huge amount of value over the
> osx-clang one, so we might consider just ditching it. But in the
> meantime, this should get things passing again.

Thanks.

>   [1/3]: ci: drop mention of BREW_INSTALL_PACKAGES variable
>   [2/3]: ci: avoid bare "gcc" for osx-gcc job
>   [3/3]: ci: stop installing "gcc-13" for osx-gcc
>
>  .github/workflows/main.yml | 3 +--
>  ci/install-dependencies.sh | 2 --
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> -Peff

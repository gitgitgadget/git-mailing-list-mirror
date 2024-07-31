Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC913156CF
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441068; cv=none; b=eKYvFgKHVIQn7B4bmwCq547D2I4Kd3WMhLsjJc7JgX7albGRsePB4SXg4KPgLcx1k0q7COAL/BbEbIZwF+kiXEyxurjST5RWDgsMtq6bfbddAKaddwkVb5+9CuAoujr4fwB0tkg8aM/2/rC2/+03jkrjFOLkK0ubA+Zm/DY7miA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441068; c=relaxed/simple;
	bh=yRUYH8rYKhxGHOKl6xo32F92HcEwIF7IDrGi51GbEwE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sQq0+fv/KvB0HFjn+xOIWobJRCKPjJgt6WFmQiFuqxkmT8PUNkA4hQgtCEWT1PzWY7br1JftwS6XeskE/8m2QOi8FYf4NFcK3k/wsChAv+k5wA5JZjFDZRSbRHXsKoG/GiABaLVyrat8ULI8EAOMg7/bx+BbPSPE/dV+v948igs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=K9DvFVAa; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="K9DvFVAa"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 707EF24592;
	Wed, 31 Jul 2024 11:51:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yRUYH8rYKhxGHOKl6xo32F92HcEwIF7IDrGi51
	GbEwE=; b=K9DvFVAaGnpz18nVjdDxp30FEBwyOoPkzS3tDi0mu3TPN8nSPaMy6h
	Wnnb48l2d3TFk1HBV9IIRuNkShOZ6ncKfSYqKNTsu1MtbQTsu103Ht7OcwZUhU/g
	BBT5KNdycGtDw8OakMVOpSN5QPx26ZVQPz+pk+HPIRQcfCERUiryw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6951D24591;
	Wed, 31 Jul 2024 11:51:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5D34024590;
	Wed, 31 Jul 2024 11:51:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Kyle Lippincott
 <spectral@google.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Josh
 Steadmon <steadmon@google.com>
Subject: Re: [RFC PATCH 0/3] Introduce clar testing framework
In-Reply-To: <cover.1722415748.git.ps@pks.im> (Patrick Steinhardt's message of
	"Wed, 31 Jul 2024 11:04:11 +0200")
References: <cover.1722415748.git.ps@pks.im>
Date: Wed, 31 Jul 2024 08:51:00 -0700
Message-ID: <xmqq7cd18srf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B0367622-4F54-11EF-9E4E-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>   - The clar gives us the ability to pick which tests to run via command
>     line parameters, which I personally like more than picking the
>     specific binary to run.

One thing I am very unhappy about the current t/unit-tests/ is that
the GIT_SKIP_TESTS mechanism is not effective at all.  If we can
wrap clar's test selection syntax inside t/Makefile to work with
GIT_SKIP_TESTS (or its superset equivalent), that would be a great
plus.

>   - The clar replaces some test assertions that we already have. They
>     feel a bit more mature, but overall there aren't all that many
>     assertions available. If we wanted to pick it up, then we'd likely
>     have to add some more wrappers.

That is a slight bummer, as importing an externally developed one is
with the hope that we won't have to enhance or maintain it, but
we'll see how much burden it will be.

>   - The clar uses longjmp instead of manually having to `return` from
>     functions in case there was an assertion failure. This is easier to
>     work with in my opinion.
>
> Also, note that I only tested this on my Linux machine. I have no clue
> whether this works as-is on Windows, but I do know that libgit2 tests
> run on Linux, macOS and Windows. So it should work in theory, it's just
> a matter of polishing this series.
>
> I'm happy to hear your thoughts on this, even if it ultimately ends up
> being shot down.

Thanks for getting the ball going.  Let's see how fast and far it rolls.

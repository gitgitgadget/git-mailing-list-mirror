Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ED38F40
	for <git@vger.kernel.org>; Sun, 18 Aug 2024 01:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723945049; cv=none; b=Oe/O3eOhAWwCHXlFCT0a7ozsrgE/Vm8M7YjZfdr87BAjv17y3FyEiO4lEixa9zLP9kgNd/636JtDT3TI/ifkqgX2x/P5UcFP4/HzfVsLqwpSP0JzUArRpJWipcBjNbKvDjg3q2EcZMPkwQR+FDJ71ToXjWu3uQ/eAoizjMXKF/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723945049; c=relaxed/simple;
	bh=3qNFizmoiD+h7P96/y17SI/qxgO88cHMMO3RZOx7Y98=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VuXkwVNJ7T47TMtwcQFlNxZlO+vXNum7gWgH6muN9MItPq52Z8NoS2s5F8bJofjW8R5hzpTSCyHvfAtMhyjjSWYknkWzu8swqMVMJ/So0MjZsGucHYV0yAxcakHgN0JVCSvHrdNFKYAAGXphDktzra8PsQLCtzGfQ3zblQga7/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=U/rY2d3g; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U/rY2d3g"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AF001C339;
	Sat, 17 Aug 2024 21:37:26 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3qNFizmoiD+h7P96/y17SI/qxgO88cHMMO3RZO
	x7Y98=; b=U/rY2d3gerI1OcZFZur0nbbXKNI6toY94LGPyiZyudysNqZ4y9TrCr
	mM2ppzqfJ2fU4V1wyXKrpj5Otaqn2RVDp/MkaCRmFjjSSY4c0ra0JCljpE7EHbSi
	6V/W6LqyuDQJH6AX5zz6pObnNZHkQ4quYfGQoE8i9eWl8G19Fblnw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 911BF1C338;
	Sat, 17 Aug 2024 21:37:26 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0328C1C337;
	Sat, 17 Aug 2024 21:37:25 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Patrick Steinhardt
 <ps@pks.im>,  Josh Steadmon <steadmon@google.com>,  Dragan Simic
 <dsimic@manjaro.org>,  "Jason A. Donenfeld" <Jason@zx2c4.com>,
  git@vger.kernel.org,  calvinwan@google.com,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  rsbecker@nexbridge.com,
  mh@glandium.org
Subject: Re: [PATCH v2 0/5] Introduce cgit-rs, a Rust wrapper around libgit.a
In-Reply-To: <CAPig+cTYd_AbzKeXUnbY1cW75xzHC7n4u-5pD0Q6ss8TdX7NEw@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 16 Aug 2024 20:15:07 -0400")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1723242556.git.steadmon@google.com>
	<Zrdn6QcnfmZhyEqJ@zx2c4.com>
	<6398d60387a6607398e4b8731363572e@manjaro.org>
	<CAPig+cSotr8CNZLy4xnm4qyJsuQsxjzsYMVU5sf3eeoEiE8aXg@mail.gmail.com>
	<xmqq5xs688cz.fsf@gitster.g>
	<CAPig+cSVNqBPjV3_41f6Ag2X4+-q4HidEo0D=1UaMG-Kv7pa5Q@mail.gmail.com>
	<k4cokm5xtwazlv44ys2uzmrfufubbq7tcmcwzasuccog3zcojf@4ftvda4nfqxj>
	<Zr86bF3y_YMZx0CQ@tanuki>
	<Zr_G59cz9HwtYUk3@tapette.crustytoothpaste.net>
	<CAPig+cTYd_AbzKeXUnbY1cW75xzHC7n4u-5pD0Q6ss8TdX7NEw@mail.gmail.com>
Date: Sat, 17 Aug 2024 18:37:24 -0700
Message-ID: <xmqqv7zyhaqz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6C513486-5D02-11EF-894B-9B0F950A682E-77302942!pb-smtp2.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> (The case with the CMake project files is similar. In the end, the
> people interested in utilizing them took on the responsibility of
> maintaining them.)

That is a good analogy.  We would all be slowed down if you have to
adjust CMake stuff (or autoconf stuff for that matter) when the
build procedure changes you made only to Makefile (because you only
have a ready access and expertise on the "make" proper), but in
practice, niche things that nobody cares about (and remember, if no
stakeholder is there to volunteer, you cannot force others to care
about your niche) will bitrot enough to cause somebody to care and
get fixed.  Another possibility is that it proves that nobody cares,
and we just drop that part.  Either outcome is fine in the end.

I think the Rust thing will proceed the same way.  At least, I am
sensing that this time there are already motivated to lend help from
outside the group of folks that are proposing this change.




Received: from dcvr.yhbt.net (public-inbox.org [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86723C01
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758763002; cv=none; b=cZwPsV7jzWQaSX7nDBzapevWx8LTsCZbvA/7x/8MiMXpgXWlnmHoII1UFGJGyxef/iDPSJL7Xi5IpJCZ507UIGYFRrmEx1nM1B7FzqrhVBHnxeuljuXiuNz8D1cBRLxHPrCs56kQ8vGuVWmntOtC2r0qhax4Y15e4wVYkvRPv84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758763002; c=relaxed/simple;
	bh=b/FbCFPQh3S77derjQfi+kHPnHQcdnNMRuJxdMsuknk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGGi3o05WYoZUNLl8A21AmbqUJgUr3OJXh76CX8ZokHgeM4FLotUtQStMZedRGQDYa9GYv6Foq7Yrcr0Q0hWATNO9O1JSQxRhDWK2HBFyCwLcfAL9d+jZlLc0f+SSzOCLA0jPOTUSOTAjhgESeXPH3dw2TiCVdcVg/pSu+3mjMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=5m56zD+Z; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="5m56zD+Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1758762643;
	bh=b/FbCFPQh3S77derjQfi+kHPnHQcdnNMRuJxdMsuknk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=5m56zD+ZLRKQhgfVH5yoKoderlCHy4WtrE61UuRkj0qMiSQzj5et7gQ/sifvTVBYD
	 ips3gt/EYhnAK5tPlpHe2nSYFvWa2IGwPSN0LWrhl0M94veb3CfSsEvQVTuyDvUz4P
	 9ELtGrSkyWsadBn85FHVtFTH/n3kFEwRZEbTbCKA=
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C47261F47D;
	Thu, 25 Sep 2025 01:10:43 +0000 (UTC)
Date: Thu, 25 Sep 2025 01:10:43 +0000
From: Eric Wong <e@80x24.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: what's missing from newer C? [was: [PATCH v5 0/9] Introduce Rust
 ....]
Message-ID: <20250925011043.M401827@dcvr>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>

Patrick Steinhardt <ps@pks.im> wrote:
> this small patch series introduces Rust into the core of Git. This patch
> series is designed as a test balloon, similar to how we introduced test
> balloons for C99 features in the past. The goal is threefold:

>   - Give distributors time to ease into the new toolchain requirements.
>     Introducing Rust is impossible for some platforms and hard for
>     others.
> 
>   - Announce that Git 3.0 will make Rust a mandatory part of our build
>     infrastructure.

Newer (and perhaps experimental) C has some safety and ergonomic
features which Rust advocates might be overlooking:

1. C23 has stdckdint.h for checked arithmetic to prevent overflows

2. __counted_by__ attribute in clang 18 and gcc 15 for
   guarding against buffer overflows:
   https://people.kernel.org/gustavoars/how-to-use-the-new-counted_by-attribute-in-c-and-linux
   It's easy to fall back to disabling it for unsupported compilers.

3. __cleanup__ attribute is supported by TinyCC, gcc, and clang
   for many years (even decades), now.  Auto cleanup makes managing
   locks for parallelism much easier along with normal resource
   management ergonomic improvement.  __cleanup__ should be trivial
   for other compiler maintainers to add (even TinyCC supports it)

4. Userspace RCU provides concurrent data structures even w/o
   RCU (and AFAIK ConcurrencyKit, too, but I've never used CK)

5. compilers check format strings nowadays (but I dislike format
   strings for performance reasons unless using qrintf)

6. regexps (POSIX ERE or PCRE2) are already used by git and can
   be used more extensively to make safer parsers.  There's also
   things like wuffs and re2c to generate C (I've yet to try
   either).

We also have Valgrind, ASAN, TSAN, etc...

__cleanup__ and __counted_by__ are the biggest deals to me and I
hope they'll be standardized soon.  The rest of the other stuff
is pretty well-known at this point...


What else is missing from C?


FWIW, I detest hacking in verbose AOT languages in general and
don't write a lot of C as a result.  However, I've spent a
large part of this century fixing C code written by others for
the usual memory leaks, memory errors, races, overflows, etc.

I'm not particularly a fan of the C code in git for a variety
of reasons but have sought to improve it here and there
(container_of, list.h, etc.)

Building git nowadays is painful for me due to the (lack of)
speed from lld/gold/mold on my ancient hardware.  Rust's
famously slow compilation speeds would mean only developers
willing to work for and/or promote $MEGACORP interests would be
able to afford to hack on code.

Thanks for reading.

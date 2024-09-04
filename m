Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6722513D516
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484119; cv=none; b=UW5RvkFtd2pNIYVCg86z8u5CWzYOfcfVOy2/SCjLaELq1Hk1XoxwDZHzSAtERfoIUAGRaIH1gQQuAUF2rvozqml0S6vcoCtgBZPQ66C0Ecao7Wv2vcqacUKy4edGbLjQxD4cOTEGLP0qhn/W4joboC9yup84pQSKvssIjsEJ5AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484119; c=relaxed/simple;
	bh=/HtJcVXzrxYOU0ufC+/66dm+w6SoEa6DIwTUrLNVEOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qHzN6DblYcCMPEsphV7MRgkw7xYJ5YEgiIysfGvT1TKhSrjuGPztR3t/rhiDb7f9ahajEB4SpYJo+Zuxpd7rGPG84u9tlK210Dkn6uxpsdcP5Ol/tCL5O6u17uSP2ml7KGa5OURpAEPCu7tlRnqH9pEiJEpVO++DXJ3bZNGM0Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=n230yVFn; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n230yVFn"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CA7320821;
	Wed,  4 Sep 2024 17:08:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/HtJcVXzrxYOU0ufC+/66dm+w6SoEa6DIwTUrL
	NVEOo=; b=n230yVFnZygt1NqoNRtZz6BSwWFoIqtwuel6BAc5rImYVSQ6ZCMYJu
	6E3wpbd7noRB8eCwvyfKBurQAuWlIVmdnsDKunUVKyESFVh59/ZSSGwN8ytAdPlb
	uLuepvwIXAiFOGjttUEX7V+DB2GNjjFQKuw3OZPlv4yXKQOJ+N7DQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1277920820;
	Wed,  4 Sep 2024 17:08:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 63FD72081E;
	Wed,  4 Sep 2024 17:08:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Calvin Wan <calvinwan@google.com>,  Josh Steadmon <steadmon@google.com>,
  git@vger.kernel.org,  spectral@google.com,  emilyshaffer@google.com,
  emrass@google.com,  rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 6/6] contrib/cgit-rs: add a subset of configset
 wrappers
In-Reply-To: <ZtivGeDZ_MZDEDB_@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 4 Sep 2024 19:03:53 +0000")
References: <20240904173053.1220621-1-calvinwan@google.com>
	<xmqq8qw79slu.fsf@gitster.g>
	<ZtivGeDZ_MZDEDB_@tapette.crustytoothpaste.net>
Date: Wed, 04 Sep 2024 14:08:35 -0700
Message-ID: <xmqq7cbr86uk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D9C23E2C-6B01-11EF-8274-9B0F950A682E-77302942!pb-smtp2.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The C-style types have long been available in libc and other crates that
> are designed to work with C FFI, and as a practical matter you do need
> to use that crate somewhere in your stack (or reimplement it) to call
> functions in libc and the other core system libraries, so you're not
> really lacking those types.

Glad to know that the feature we need was already there.  So, it is
just the interface was in flux when they worked on the version
Debian happens to ship right now, I guess.

> They're also available in the `std::os::raw` module as of Rust 1.1; it's
> just that as of Rust 1.64, they're in `std::ffi` and `core::ffi` as
> well, mostly to help embedded systems (which don't have `std`, and thus,
> don't have `std::os::raw`).  Using `std::os::raw` or `libc` should be
> fine for Git, since we're not targeting operating system kernels,
> bootloaders, or firmware such as UEFI (I hope).

Yup, as long as we have a clean migration path (like the one you
showed Calvin in your other message in this thread), and use of a
slightly older way will not immediately be deprecated in a newer
version of Rust, then we should be fine going forward.

Thanks.

Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D86D189B8D
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137637; cv=none; b=A+s6zrebVB+3IU35C/dJnyLOmAeJifLPA3RVT9d1QvUjS5g5meOoP2y1lSXf6yB7jvdEy1I0AgYXSBTs98v2ICwLPNePp8lHOIc2BS9gQ+MSPp56nrlzkPLIBUmO4+aP385ExnHTqw+COdPyKEjVLowAExBvBBM/+VhmmnGkBgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137637; c=relaxed/simple;
	bh=GJTAoByfu1abi6UXPf8oIqmQNYiGRKdvVquZxY5f9DY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vy/emaymeZccnGtoq7No0q1wwKYIPE+gtW8O7ejPGKbVhjvlmOtjrxSVRWQchCWLLsUtptAVJXjuSK93nr84DnUyZJnqp7ZCujks1Cv5rkTDNcTVJYiMWzgWCGoKij+YKgqzUJwwwMQcBvo9Vr41D0Wh+x8u+QNJrYLv5lQ7szg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jGmQBrBJ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jGmQBrBJ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6F83623ADA;
	Thu,  8 Aug 2024 13:20:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GJTAoByfu1abi6UXPf8oIqmQNYiGRKdvVquZxY
	5f9DY=; b=jGmQBrBJbJ1pwd+LoxNsyg2OOeseoT11Xz0cm+qXYIy1IdoN35mUHA
	hO5iOt8y+ph6NJbPl/hgWF6dNZ1c7cgLNO52+FyNCylr5/hvUgrGnFIaNXWTkQak
	ozUu1rqiEk1afXG5Ql7pTuivAPrs1pckBAcw/izeAsg9d//mQ2g5w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B2F723AD9;
	Thu,  8 Aug 2024 13:20:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 54D3723AD8;
	Thu,  8 Aug 2024 13:20:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Josh Steadmon <steadmon@google.com>,  git@vger.kernel.org,
  calvinwan@google.com,  spectral@google.com,  emilyshaffer@google.com,
  emrass@google.com,  rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 0/6] [RFC] Introduce cgit-rs, a Rust wrapper around
 libgit.a
In-Reply-To: <ZrSxLU-7rmlvdTHC@zx2c4.com> (Jason A. Donenfeld's message of
	"Thu, 8 Aug 2024 20:51:09 +0900")
References: <cover.1723054623.git.steadmon@google.com>
	<ZrSxLU-7rmlvdTHC@zx2c4.com>
Date: Thu, 08 Aug 2024 10:20:29 -0700
Message-ID: <xmqqv80bgcde.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 83AB9F86-55AA-11EF-9147-BF444491E1BC-77302942!pb-smtp20.pobox.com

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:

> Cgit maintainer here...
>
> On Wed, Aug 07, 2024 at 11:21:25AM -0700, Josh Steadmon wrote:
>> * bikeshedding on the name (yes, really). There is an active, unrelated
>>   CGit project [4] that we only recently became aware of. We originally
>>   took the name "cgit" because at $DAYJOB we sometimes refer to git.git
>>   as "cgit" to distinguish it from jgit [5].
>
> Indeed, please find something else. Cgit is a real project, used by
> many, such as git.kernel.org, and it'll turn into a real hassle for both
> of us if there's ambiguity and confusion.
>
> What about libgit-rs? Or even libgit3, where the rustness of it is
> simply an implementation detail, so the name won't feel dated 15 years
> from now when everything is written in Rust anyway and -rs is so 2020s?

libgit-rs sounds like a descriptive and good name.

I am not sure about the wisdom of _not_ saying anything about Rust.
In 2035 maybe nobody is writing in Rust but in not-yet-invented
alternative that is even better.

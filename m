Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772D72376F2
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758396337; cv=none; b=dxO+CSTNaeRY/R/YQ5Thp9cn0+5FrpNNB8gt3sVw1I9R5lkf/stpOT3EIBRiYkHeUUoRDzwUcKeAMnhmBTvASKku4y5281zVPv0B28SaFB+hbeccH8AunnCNr/LpCS2HYY/TUXcmZGV3f8rqF5ruYXsgmL275VcREM9YsNyXL3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758396337; c=relaxed/simple;
	bh=ikrSOcURnDcgyFuiIWAOPaH3Ep/3mVwoj5N+XTJbEr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UHLgylJoRND3vQa2AofTf2a9bDEBlS7lhEP0xnp50Z5EKo5e5glWR5NvTPIhv9nH+odbOpo0mHHRXkUMox6mlnvq8sSVe0jPIzACjkYsISeRaw7DtJTjfXZ/L3StyDRUfIvEtLy0WLwejQo4vw5/SsJc3+jot4Ycj7l/GsOFIes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 2CA9A3415DE;
	Sat, 20 Sep 2025 19:25:33 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: rsbecker@nexbridge.com,
  CAH=ZcbCUL-rWw5E6p26T0039gs9q-P8iK5fp73-RzTzKiZ0zMQ@mail.gmail.com,
  20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im,
  Johannes.Schindelin@gmx.de,  ben.knoble@gmail.com,  cb@256bit.org,
  collin.funk1@gmail.com,  contact@hacktivis.me,  eschwartz@gentoo.org,
  git@vger.kernel.org,  gitster@pobox.com,  me@ttaylorr.com,
  newren@gmail.com,  phillip.wood123@gmail.com,
  pierre-emmanuel.patry@embecosm.com,  ps@pks.im,
  sandals@crustytoothpaste.net
Subject: Re: [PATCH RFC 0/3] Introduce Rust and announce that it will become
 mandatorty
In-Reply-To: <CAH=ZcbDJR7gJ0tyQ-bk-n+Zid_csED74+X5OkTfbEiy5-_2R-w@mail.gmail.com>
Organization: Gentoo
References: <8799E6DB-FC85-4F71-A6C1-363D1AC8ED06@macos-powerpc.org>
	<000001dc2a5d$ea10ffe0$be32ffa0$@nexbridge.com>
	<CAH=ZcbDJR7gJ0tyQ-bk-n+Zid_csED74+X5OkTfbEiy5-_2R-w@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 31.0.50
Date: Sat, 20 Sep 2025 20:25:30 +0100
Message-ID: <87qzw10vv9.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> On Sat, Sep 20, 2025 at 12:39=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>> To clarify, gcc is not available on all platforms. The overlap where gcc=
 is
>> supported and Rust is support is likely high, but more, where gcc is not
>> supported then it is highly unlikely that Rust is supported. mrustc is a
>> difficult more that requires gcc even if that is not clearly stated - it
>> does not build with c17, for example. This double requirement is making =
the
>> probability of being able to continue to support git even less for me on
>> NonStop. My team is working hard to push Rust availability and we realize
>> that gccrs is an easier path, but those two are currently outside of our
>> control because of complexities in the loader on NonStop.
>
> Is there a C compiler that works on NonStop and Linux? I ask because
> I'm wondering if code from gccrs could help with augmenting that
> compiler. From what I understand gccrs is written in C++17, but Rust's
> native approach uses mrustc to bootstrap, and then the rest of the
> Rust compiler is written in Rust. I don't have $500,000 to spare for
> testing on real NonStop hardware, but if there was a C compiler that
> worked on NonStop and Linux then there'd at least be the possibility
> of people trying to make Rust work with it.

[Just some small technical notes, it doesn't need a reply.]

GCC defaults to C++17 but is written in C++14 (recently changed from
C++11). I think the gccrs people may have talked about whether they can
use C++17 to make some things easier (I suspect if they requested that,
it would be approved, at least I'd support it and argue in favour).

mrustc isn't part of any official Rust bootstrap path, Rust upstream
just use binaries. mrustc currently needs GCC for some trivial reasons
(like hardcoding some workarounds for bugs w/ GCC-specific flags). I
suspect it wouldn't be too hard to get it working with Clang. I don't
know how many extensions it relies on in general that may be common but
not in the standard.

But mrustc is written in C++, not C -- AFAIK NonStop has no C++ compiler.

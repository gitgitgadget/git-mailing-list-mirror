Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692751E0B86
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756838828; cv=none; b=cx6gUokoPZPY1ldRpg18g7ms6tb2gVXQlNrAqhL1KzRRTE8rAJvR7JA3aHQj/CLqtcmcd+UPZVYlW4ZVgyp8srG+uiHpyrcL+qxrefGovflCYJwqTOCdysQD/QgHToNfTWSwaij4+Fl7AbQMGOnQAGlIjJeCywr4ecb4hc0Yink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756838828; c=relaxed/simple;
	bh=H4UF5aJuObkUmViKK+RCW+FTrwCx8REysVY0lLwjNOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Asyre0pHUm20xh535N5u5WZDG8JkYqaD113jgHn4Xy8jAG9pw1SQDyN5IeJlUiExG5YRacXOlUjS0jJ03feUn/JJv0EKqJrlmJLKFTrqQ+WhHpP1Zu8nPq/IzYVNZV3Y49+PA+zcuDo6goorFNbJzswaMfZy3XDvUN+z3U1ThDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 59F1A340D85;
	Tue, 02 Sep 2025 18:47:02 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Junio C Hamano <gitster@pobox.com>,
  Taylor Blau <me@ttaylorr.com>,  rsbecker@nexbridge.com,  'Elijah Newren'
 <newren@gmail.com>,  'Kristoffer Haugsbakk'
 <kristofferhaugsbakk@fastmail.com>,  'Josh Soref'
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  'Christian Brabandt'
 <cb@256bit.org>,  'Phillip Wood' <phillip.wood123@gmail.com>,  'Eli
 Schwartz' <eschwartz@gentoo.org>,  "'Haelwenn (lanodan) Monnier'"
 <contact@hacktivis.me>,  'Johannes Schindelin'
 <Johannes.Schindelin@gmx.de>,  'Matthias =?utf-8?Q?A=C3=9Fhauer'?=
 <mha1993@live.de>,
  'Collin Funk' <collin.funk1@gmail.com>,  'Mike Hommey' <mh@glandium.org>,
  'Pierre-Emmanuel Patry' <pierre-emmanuel.patry@embecosm.com>,  "'D. Ben
 Knoble'" <ben.knoble@gmail.com>,  'Ramsay Jones'
 <ramsay@ramsayjones.plus.com>,  'Ezekiel Newren'
 <ezekielnewren@gmail.com>,  'Josh Steadmon' <steadmon@google.com>,
  'Calvin Wan' <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
In-Reply-To: <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
Organization: Gentoo
References: <030a01dc1433$ee3e2510$caba6f30$@nexbridge.com>
	<4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com>
	<031601dc143f$7a9a25d0$6fce7170$@nexbridge.com>
	<CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
	<aK5mJI1NfVQDmDXN@nand.local>
	<01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
	<xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local>
	<xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im>
	<aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
User-Agent: mu4e 1.12.12; emacs 31.0.50
Date: Tue, 02 Sep 2025 19:47:00 +0100
Message-ID: <87plc8lmjf.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-09-02 at 11:16:19, Patrick Steinhardt wrote:
>> As Pierre-Emmanuel menitoned in [1], the backend is likely to stabilize
>> next year. One or two years of backports for that particular LTS version
>> doesn't feel too bad. And if it does become more involved we can maybe
>> also distribute the load and rely on maintainers of impacted platforms
>> without Rust to help out with the backporting.
>
> I'm very much in favour of supporting gccrs when it's available, but I
> also want to say that it currently is targeting 1.49, which is much
> older than we want.  It's also not necessarily going to be fully usable
> or bug free in that amount of time.
>
> I also want to point out that it's important that the maintainers of
> affected platforms build the tooling necessary for their platforms to be
> supported.  I'm not seeing ports of LLVM to those architectures or
> contributions to gccrs that would make those platforms easier to
> support.

This isn't accurate. gccrs doesn't need particular porting to arches: at
least not yet, and if it does, it'll be very minor; any changes of this
sort will be in crates themselves which would go upstream.

As for the libgccjit-based backend for rustc, see
https://github.com/rust-lang/rustc_codegen_gcc/issues/49,
https://github.com/rust-lang/rustc_codegen_gcc/issues/744, and
https://github.com/rust-lang/rustc_codegen_gcc/issues/742 for discussion
and complications. But to say that nobody is doing it or working towards
it is inaccurate.

>
>> Also, all of this feels like a significant shift. I'm strongly in favor
>> of adopting Rust in our codebase, but I think we should do so carefully.
>> So we might take it extra carefully and say that Rust will become a
>> mandatory dependency in Git 3.0, where the last release before Git 3.0
>> will become an LTS release.
>
> I'd prefer we not wait that long.  I'm doing some work in building the
> new loose object mapping using Rust and it's much more efficient than
> writing it in C because we don't have to sort the data when we use a
> BTreeMap.  The code is much simpler, shorter, and easier to write.
>

I still think adopting Rust is a compatibility break and a "breaking
change". Again, keeping in mind that for adopting C99 features (!), the
Git project used "test balloons" very very recently.

> Nobody else is currently working on the interoperability code and we
> expressed that we ideally wanted it for Git 3.0.  Being able to use Rust
> means I can write that code faster, with fewer errors (and hence less
> debugging time), and better tests.  Otherwise, I'm afraid that it will
> take longer and we might not have it fully upstream for Git 3.0.
>
> We also have this series right now, which we'd have to abandon if we're
> not going to support Rust right away.  I'd like to retain Ezekiel as a
> contributor and incorporate Rust, and I think the best time to adopt
> Rust is now, not at Git 3.0.

I think there's going to be various issues that arise even on platforms
that support Rust that would make it fitting for Git 3.0, at least for
the first few releases that incorporate Rust. I'll note that the series
isn't currently using Meson's Rust integration as QEMU is doing.

sam

Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478851D6DA9
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757071973; cv=none; b=AFLGBGF5PlL4LbrnZ/DaatPrdDGZqxz1CQVJereL6senSLhZ2d8qKFdjK91p/iMXKZGtGmOxggwR2eXh0Tt8s+k6hd1r/HeZzRU0WJInBs9+/sT/41+wVdHMZYTRW/8ysFan9Wd3A/KnVPA0pKX7Uybqh26bL7MNU5aFwqS42mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757071973; c=relaxed/simple;
	bh=s2RfVqYVQjp4VPL340wQ6TS2cvPAK6u9HxSpFXTCJAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lkEsvTT1fN/4Pd/n3+6houZLMLQlscTrkYSe63How1+VLAT0yqi4yfRSn4nCkWLuDpaz/cLX3HyergH6UNzOkQ6isG9bRGzFX3A6IpAZ/ilAFJvCp1/TwL/awkEgB9zkFO3lUXFeZplRzosuGj57nNk7SUD8tqzbCMUscTL8oxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 037213406BF;
	Fri, 05 Sep 2025 11:32:46 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  phillip.wood@dunelm.org.uk,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Junio C Hamano <gitster@pobox.com>,
  Taylor Blau <me@ttaylorr.com>,  rsbecker@nexbridge.com,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Josh Soref
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Christian Brabandt
 <cb@256bit.org>,  Eli Schwartz <eschwartz@gentoo.org>,  "Haelwenn
 (lanodan) Monnier" <contact@hacktivis.me>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Matthias =?utf-8?Q?A=C3=9Fhauer?=
 <mha1993@live.de>,  Collin
 Funk <collin.funk1@gmail.com>,  Mike Hommey <mh@glandium.org>,
  Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Ramsay Jones
 <ramsay@ramsayjones.plus.com>,  Ezekiel Newren <ezekielnewren@gmail.com>,
  Josh Steadmon <steadmon@google.com>,  Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
In-Reply-To: <ada227ec-94aa-4563-800e-05c116a361a8@gmail.com>
Organization: Gentoo
References: <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
	<aK5mJI1NfVQDmDXN@nand.local>
	<01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
	<xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local>
	<xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im>
	<aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
	<aLfU5sEa-RE3X4G2@pks.im>
	<aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net>
	<aLl6iFXeAvL_hvqR@pks.im>
	<CABPp-BFNoLC+TdtuEq5Nx+VcFJ-WFga2r0E+eq=fFaaCN_sRGg@mail.gmail.com>
	<ada227ec-94aa-4563-800e-05c116a361a8@gmail.com>
User-Agent: mu4e 1.12.12; emacs 31.0.50
Date: Fri, 05 Sep 2025 12:32:44 +0100
Message-ID: <87cy85f82r.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Elijah
>
> On 05/09/2025 04:54, Elijah Newren wrote:
>> (1) "without advance notice" was already pointed out to be
>> inaccurate
>> in this thread, including in the exact email you are responding to;
>> you could argue that there hasn't been _sufficient_ advance notice,
>> but then there should be more details about what is and isn't
>> sufficient.  Merely repeating this claim which brian just barely
>> pointed out to you as false almost feels dishonest.
>
> I think there is a difference of understanding of what constitutes
> "advanced notice". While it is true that there have been discussions
> on the list for a couple of years where people were clearly
> enthusiastic about adopting rust those discussions have always petered
> out after concerns about portability were raised without us actually
> adopting rust. In those discussions there has been no clear conclusion
> about whether rust would be mandatory or optional. I think from the
> point of view of an outsider who was following the mailing list it has
> not been clear exactly where the rust discussion was going. For
> someone not following the mailing list but just reading the release
> notes there has been no indication that we're thinking of rust
> mandatory for building git as opposed to offering rust bindings for
> our C code.
>
>> (2) "pull the rug away" seems hyperbolic.  I would have liked some
>> explanation as to how a transition period is expected to help, and how
>> the existing transition period has been insufficient.
>
> I'm very unclear what "the existing transition period" has been
>
>> [...] > (4) you suggest that adding Rust as an optional component
>   should avoid
>> the problem, yet we've already had Rust as an optional component for
>> the last three releases, going back to 2.49.0.  (libgit-rs and
>> libgit-sys).
>
> Right but from the point of view of someone trying to build git on a
> platform without rust support there is a world of difference between
> having some optional bindings for rust external projects to use, and
> making rust mandatory to build git.

Entirely agreed with the whole email.

I'll make some further observations wrt bindings:

1) Distributions often don't enable bindings for languages unless a user
requests them, or at the very least they're considered low priority (and
bindings existing for a language in a project do *not* imply the project
is going to be rewritten in that language);

2) There would be no value in distributions building Rust bindings
because Rust doesn't really support "system-wide" libraries. It doesn't
make sense as far as I can tell to install the bindings right now. I
don't even know where Rust bindings should be installed to, I've never
seen a package want them installed before.

3) It's not integrated with the Meson build system we're using so I
wouldn't have paid any attention to it, at least unless a user requested
it;

4) It's in contrib/.

>
> I would like us to adopt rust but I am concerned about the
> implications for platforms without rust and think we should give some
> notice in the form a clear announcement in the release notes once we
> have a concrete plan. That plan should include a decision on what
> commitment we can realistically offer with regard to security updates
> for platforms without a rust compiler so maintainers on those
> platforms have a clear idea of how long they will be supported.
>
> Thanks
>
> Phillip


sam

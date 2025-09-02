Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF3D1B2186
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812635; cv=none; b=MDVvcTdP5atFCh5e8JuK11vQswtTe5BpEMB8HR6h3G/uZFzUqQarL4y4kKe3wcQPCIR18ApbrW2Bx7AP4OiNwYVI08NGxrHqj1Ziuv38+0KAwiYYIAB96D0TsIBivi6KcKRxZMwSUQT721oCut5qDdah1onTpF0uQoCFMB8kLgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812635; c=relaxed/simple;
	bh=7Ui5aZpdqdiHpAAujw4QD49XnQ80BCUOnbL3/5rmbhs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JAXiSEZwRs9SCadrHeFADz4jVclflTby15NMUpqndKXyvAemgJLvd3kl0E9GUKMoWRaXyeQ2NmpezLQEYwOWlX50OKU19ufyEIbCnRmUxcfFBzliDaCk3YEiKei/nF+m5yQOed+jodpTKT2R71VYfgiC0xgQ8hFd7FTkNwd13C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id AE5AE340CF2;
	Tue, 02 Sep 2025 11:30:29 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,  Taylor Blau <me@ttaylorr.com>,
  rsbecker@nexbridge.com,  'Elijah Newren' <newren@gmail.com>,  'Kristoffer
 Haugsbakk' <kristofferhaugsbakk@fastmail.com>,  'Josh Soref'
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "'brian m. carlson'"
 <sandals@crustytoothpaste.net>,  'Christian Brabandt' <cb@256bit.org>,
  'Phillip Wood' <phillip.wood123@gmail.com>,  'Eli Schwartz'
 <eschwartz@gentoo.org>,  "'Haelwenn (lanodan) Monnier'"
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
In-Reply-To: <aLbSA5KsBdD4wW_B@pks.im>
Organization: Gentoo
References: <03939951256baaaec3fcc690cfa38ee12fb553ce.1755921357.git.gitgitgadget@gmail.com>
	<030a01dc1433$ee3e2510$caba6f30$@nexbridge.com>
	<4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com>
	<031601dc143f$7a9a25d0$6fce7170$@nexbridge.com>
	<CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
	<aK5mJI1NfVQDmDXN@nand.local>
	<01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
	<xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local>
	<xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im>
User-Agent: mu4e 1.12.12; emacs 31.0.50
Date: Tue, 02 Sep 2025 12:30:26 +0100
Message-ID: <87qzwpm6r1.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Aug 27, 2025 at 01:22:34PM -0700, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>> 
>> > (As an aside, I mentioned in my earlier email to Randall that I have a
>> > suspicion that Rust code will have fewer security issues than C code,
>> > and so the likelihood of needing to backport a security fix from Rust to
>> > C seems lower to me than having to simply patch old C code. Time will
>> > tell, I guess.)
>> 
>> Just like back when scripted Porcelains were rewritten in C, in 5
>> years, when a lot of the existing C code is rewritten, who among us
>> would care to backport or "simply patch" old C code?
>> 
>> This of course assumes that these platforms that lack Rust still
>> lack Rust after 5 years, yet still matters to the users, and the
>> vendor does not care to support Git themselves.  Maybe one of these
>> three conditions would change and make the problem go away ;-)
>
> It will definitely require additional maintenance by us. I think it's
> reasonable to say that platforms without Rust won't get new features
> anymore. But when it comes to security fixes or significant bugs I think
> it's less sensible to say that they're left on their own.
>
> I proposed this in a separate branch of these threads, but we could
> counteract this by declaring the last major version before we introduce
> Rust as an LTS version that will receive both security and severe bug
> fixes going forward. Ideally, that LTS release would continue to be
> maintained until the gcc-rs backend is ready for prime time, which
> should alleviate a lot of the portability concerns.
>

That would be enormously appreciated and make me happy if it is possible.

> As Pierre-Emmanuel menitoned in [1], the backend is likely to stabilize
> next year. One or two years of backports for that particular LTS version
> doesn't feel too bad. And if it does become more involved we can maybe
> also distribute the load and rely on maintainers of impacted platforms
> without Rust to help out with the backporting.

I'd be open to that if we're still in the position of needing it by then.

>
> Also, all of this feels like a significant shift. I'm strongly in favor
> of adopting Rust in our codebase, but I think we should do so carefully.
> So we might take it extra carefully and say that Rust will become a
> mandatory dependency in Git 3.0, where the last release before Git 3.0
> will become an LTS release.

This is what I was hoping for :)

It should be considered a "breaking change" in a sense (the
"compatibility profile" of git changed) and 3.0 would be fitting.

It would perhaps liberate git developers in feeling free to make other
changes while adopting Rust as well if they see fit.

>
> Patrick
>
> [1]: <7bf054a1-0196-4ad8-aaa4-a432cd2c93a5@embecosm.com>

sam

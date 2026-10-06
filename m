Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C983E3D9DB1
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293792; cv=none; b=UuXwv8N8JtCWmzF54QBbYhvPDJQ5vstVmSWFoIz2Y+7q2U84CRL8F7CYHOI4dXIiZRnubDiB1pFZgGzeLWz43pPdp4G+lE5NTBMSksvZSaXRPAeiTblvuFVz1xYAjG7se4bfPcdFolvN8k06VJvRV2VVcZ4XMgdh/SVkC5kUYUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293792; c=relaxed/simple;
	bh=cjVFMwCCL7mTTb3qkdvXFDP6oQrI2mRrDfqXXgKwBXw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BHhQ/79V7sAIWugEpWI6cOls/n67JgNJpW04qWqKnv83Q0AGLdV/8p2UAps4cE246uwkWhBA4hO+ZXr55Y73yYYyN9/1s0CGQG/iJ+dMnm2bqdzItA4x28F9cDWoqmO1bH1VFHNZBsfzQlQv+PtYLKwaS7cCaXkq4egGFhvNPZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=oG7A9ABc; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="oG7A9ABc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1791293785; x=1791898585;
	i=johannes.schindelin@gmx.de;
	bh=YGnKlKTBmYc7zQGCD9OtcqPfnrvOkoWcZ8TPYwSXZU0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oG7A9ABctF6/2PmkxrsB6AZDGjrGDOP7I8FVdSd0eQb/ag1S2dsmPj2o66ulglaW
	 SANXua0q/1wCOi2a6GmXpyAy8lQcPvIZ9QgAiQBQRpeDgRyJJ7MS8xeGwXYv5v0Hm
	 mTw9PnBYw+/3nmXhm5tTncBLT9kLEKeV2mQ1ZUpyl4kqXbZP5j4GFk6fx7DtDwBwZ
	 Rm6IAV8RzN1MeK3QYC9iuxHj9uy+oD7ePcd7y/CA9DYxKh7ZLw0RktdQuSn269ian
	 JUVoskqfzO7BBTYt1PbYdeplA9dZJLPzb6k3GKZ3krmI582EHPds5t07ZqtyWbGf0
	 r4aGJv+ATKczYC1f0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUm7-1xOlvT3aud-001rmh; Tue, 06
 Oct 2026 15:36:24 +0200
Date: Tue, 6 Oct 2026 15:36:23 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Scott Chacon <schacon@gmail.com>
cc: Patrick Steinhardt <ps@pks.im>, 
    "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Scott Chacon <scott@gitbutler.net>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] sign a SHA-256 digest of the tree in commits
 and tags
In-Reply-To: <CAP2yMaJ+ss9M_27+kBN0q_aFUd-5GNqzQHM2orayKH+enOAG1Q@mail.gmail.com>
Message-ID: <98da6faf-2000-9ade-4ca1-ce753f592ec7@gmx.de>
References: <20261002081846.25144-1-scott@gitbutler.net> <asAAn8NZwB29WhGR@fruit.crustytoothpaste.net> <CAP2yMaKF4CRvtfTQDVe51SqEm_DnoVOmED5kcUSg7UvLkBp4Xg@mail.gmail.com> <asOa6dgpj0qV5QAU@pks.im>
 <CAP2yMaJ+ss9M_27+kBN0q_aFUd-5GNqzQHM2orayKH+enOAG1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=832332827593368617912937851288
X-Provags-ID: V03:K1:fLSvC6nVMXrobV7ps+Ihuy13MsP1LF7b+D3rLPCM7id4+3EIyts
 +7YF/J2dP1sRDTbBNtT3P+Rz6Qu99RJsEPUifSq31WD6Iqt1miqfq55LX9RD/vsfsVzAGww
 fdvmxlZpTWqRSQ8tOSNRLMrXH5e6zwi3TpL2HdjUViLe8+htnfUeP4XXCd7W4zDJtYbQMj2
 k34l00yAMQNhjvRZbxrMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L0tvVmdpbfI=;m3iAacObFBOten2QnfyEriiWXrH
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--832332827593368617912937851288
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Scott & Patrick,

On Mon, 5 Oct 2026, Scott Chacon wrote:

> On Mon, Oct 5, 2026 at 2:41=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wr=
ote:
>
> > The biggest problem I have is that the ecosystem has been entirely
> > unwilling to do anything about the SHA-256 move before we announced
> > that this is going to become mandatory. Only then were developers even
> > able to convince anybody (especially those paying the wages) to get
> > the time to implement support for it.
>=20
> Bit of a simple question, but is it possible that this is because
> nobody really finds it a concerning problem?

I do agree that there has been an enormous reluctance to move to SHA-256.

One part is of course, that there was no sense of urgency, not even with
the SHAttered paper, because of the difficulty to apply it to Git objects
(which by happenstance rather than design made creating collisions
harder).

Out of curiosity, I researched the feasibility half a year ago: generating
two different `.c` files with the same blob OID where one of them carries
_some_ malicious payload (and an enormous number of seemingly random
bytes, carefully ensuring no NULs) would have a rough price tag of ~$10k
and a month of rented RTX 3090s. So that's not _purely_ theoretical, and
those numbers are likely lower today than half a year ago.

=46rom my point of view, though, the much bigger part of the reluctance
stems from the ginormous amount of work required to migrate existing
repositories to SHA-256, and all that for little to no perceived benefit!

And it's not just an incredible amount of work, there are issues:

- Maintaining a local-only SHA-1 <-> SHA-256 mapping would be _required_
  for transition periods (forget about flag days, they are not feasible),
  and the resources (time!) are prohibitive for most serious data shapes.

- There are still no satisfying answers to the question how to deal with
  submodules. "Just use only SHA-1 or only SHA-256" is an answer that I
  heard as frequently as it is out of touch with reality: submodules often
  fetch from 3rd-party projects who don't exactly bend over to do what
  _you_ happen to need.

- There are still only absolutely unsatisfying answers to the question how
  to deal with partial or shallow clones. Unless you try flag days (which
  are, let's face it, practical only for ridiculously small teams).

- It is totally impossible to discern between a short SHA-1 and a short
  SHA-256. (No "this is SHA-256" prefix, or "first letter is an inverse
  hex digit" kind of discerning pattern there.)

  This has many corollaries, e.g.: The minimum hex digits for short OIDs
  changes substantially depending whether or not you have only one hash,
  or maintain a local mapping between SHA-1 <-> SHA-256. Just to name one.

There are many more issues with SHA-256 repositories, not least of which
that many a logic hard-codes "40 hex-digits" as the size of the hash.
Tooling. Services. Platforms. I know that the immediate reaction will be:
"Well, they should have prepared better!" which brings me back to
above-mentioned out-of-touch comment.

The worst part about this? The rationale that we need to switch to SHA-256
by default because SHA-1 makes Git repositories cryptographically weak
rarely matters in practice:

- The Git objects are already on The Server, in most cases. Let's face it,
  Git isn't used in a distributed manner. Most projects have their
  canonical central repository from which everybody clones. It would be
  simply impossible to replace existing objects with SHA-1-same copies on
  those servers.

- While many projects are developed in Git repositories, they are usually
  distributed via packages, including source packages, with separate
  actual cryptographic signatures. And those signatures are what matters,
  not Git's SHA-1.

- The well-known adage that the weakest link in the chain is what breaks
  it is quite true even in code security. It is pretty expensive (see
  above) to create SHA-1 collisions, especially ones that would not be
  spotted _immediately_. It is much, much easier to target the human
  element in the chain. You don't need SHA-1 collisions for that at all,
  just an overworked open source maintainer, and it is also much cheaper.

> > So there is some kind of ossification happening in the space. But
> > things are finally moving now that the due-date is drawing closer. I
> > would be extremely hesitant to change course again and drop this
> > breaking change now that there finally is some movement. Because the
> > only consequence of that would be that the ecosystem will stop working
> > on it again. And even more so, I would even expect that this will make
> > the next time we want to do a breaking change exponentially harder as
> > the lesson learned is that nobody needs to do anything.
> >
> > Maybe I'm too pessimistic about this, but I don't think so. We've been
> > working on this whole transition for almost a decade by now, and only
> > now where we're forcing the ecosystem to adapt are large players like
> > GitHub even moving.

I do agree that essentially only something like the "threat" of Git v3.0
switching to SHA-256 by default could have moved the industry players (and
not all of them, some of them still won't be able to support SHA-256, due
to the lack of funding for the work that would be required).

Having said that, I do think that we have to keep an open mind.

We need to keep the option open to decide "at the last minute" to satisfy
ourselves in Git v3.0 with having excellent support for SHA-256 and at the
same time _not forcing_ everybody and their cats to use it.

A feature like SHA-256 should probably be enabled only because users want
it, not because a few Git contributors want it so badly that they propose
to make it the default in v3.0. _The default_ should be switched to
SHA-256 only to solve a real problem that real users recognize and want to
see solved.

Ciao,
Johannes

--832332827593368617912937851288--

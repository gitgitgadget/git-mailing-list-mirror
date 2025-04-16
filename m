Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B433227E89
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744803395; cv=none; b=BGygAKpux3ShqwoSPpQ0A5OqdtgOe3iq6UgAeBPAZRlabuEbBiAA3D+Fqti40jjf29OaHG49UQH0swR1UawZMaJ8Eqa0YlV5k9sUd6oRUPN93WVjyW0eKCF1qM9QAOJfDQ2RXmEoB3UlGkavapjQBJDozxlK0DTvBUyPB4nGS+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744803395; c=relaxed/simple;
	bh=nn3quOCpvcM4cwvqpLCDmOoK9tbclistmpdCCXe3zOE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=YNsg6MklU8nG+L/Kl3sDpGDSUbmgyeF/8wCJV/rbwpen2vME8OEHcJXYl9X2uxagJxIoKay/hZcgRpj54It0qkJx4rvO70Gm6pW5IUyT59Qw+A+tZdls8qOS2aV1Z3Ge7bLTDt1eJUBPEaL7dZdmXQ5iWrRxS0gt5GHibpDH7Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZczWK3mdHz9trK;
	Wed, 16 Apr 2025 13:36:29 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Apr 2025 13:36:26 +0200
Message-Id: <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
From: "Remo Senekowitsch" <remo@buenzli.dev>
To: "D. Ben Knoble" <ben.knoble@gmail.com>, "Nico Williams"
 <nico@cryptonector.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, "Junio C Hamano" <gitster@pobox.com>,
 "Martin von Zweigbergk" <martinvonz@google.com>, "Git Mailing List"
 <git@vger.kernel.org>, "Edwin Kempin" <ekempin@google.com>, "Scott Chacon"
 <scott@gitbutler.com>, "philipmetzger@bluewin.ch"
 <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com> <xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby> <20250408125521.GA17892@mit.edu> <Z/VGYrrVZYQ13TLj@ubby> <20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby> <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
In-Reply-To: <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>

On Mon Apr 14, 2025 at 9:54 PM CEST, D. Ben Knoble wrote:
> On Wed, Apr 9, 2025 at 12:56=E2=80=AFPM Nico Williams <nico@cryptonector.=
com> wrote:
>> Let's nail down the semantics of these change ID headers.  Here is a
>> proposal to bang on:
>>
>>  - change IDs get preserved on cherry-pick and on `pick`s in rebases
>>
>>  - users can manually remove or change these change IDs, naturally,
>>    though generall they would not
>>
>>  - the actual change IDs are either free-form or they are URIs -- pick
>>    one, but if they are URIs they should be URIs to CRs, and approved
>>    CRs should perhaps have links to integration reports etc.
>
> Using URIs [to code reviews] looks to me like it makes some
> assumptions about what creates or consumes these headers, right?
> Especially since the URI should point to a code review=E2=80=A6 Is there =
a way
> to do that which is downstream-agnostic?
>
> Further, and maybe this is my ignorance of Gerrit showing: how would
> you attach a URI to a local commit when authoring it? You don't have
> the review URI when running `git commit`, do you? (Maybe I
> misunderstood; I'm seeing an odd chicken-egg problem here.)
>
> Which begs another question: what/who applies the initial change ID to
> a commit and when?

These are all great questions, which the originally proposed format
(fixed-width reverse-hex) has answers to. I think a URI would be
strictly worse.

* Using a reverse-hex ID makes no assumptions about what consumes these
  headers. There can be multiple different consumers which treat the ID
  differently with different URI schemes.

* Attaching a reverse-hex ID to a local commit when authoring it is
  trivial: you generate it randomly.

This is one of those cases where being maximally restrictive about the
format will enable maximal flexibility downstream.

One example: GitHub has a URL scheme that looks like this:
github.com/org/repo/compare/<ref1>..<ref2>

This doesn't work if the refs contain slashes, as branches sometimes do
(e.g. feat/foo, username/bar). If the change-id is a URI, this type of
URL scheme doesn't work reliably.

That is not to say we should design the change-id around GitHub, it's
just an example how making the format more free-form (URI is more
free-form than fixed-width reverse-hex) makes it more difficult to get
stuff working downstream.

And lastly, laser-etching the URI scheme of one particular tool into
your commit history means the history is at great risk of degrading
over time. URI schemes change, domains change, tools become outdated
and are replaced.

Adding some ephemeral configuration to a tool that constructs a URI out
of a reverse-hex ID on the other hand is trivial.

> PS This discussion feels somewhat related to the classic GitHub
> problem of not presenting interdiffs/range-diffs: GitHub shows a
> too-flat source diff on force-pushes. Perhaps better web UI tooling
> about interdiff review (which I think is one of the things Gerrit
> does/wants to do?) makes change IDs less necessary, since interdiffs
> help connect evolutions of commits?

I think it's the other way around: Building a code review UI built on
git and centered around interdiffs today is _hard_, that's why we don't
have it yet. Adding change-ids to commits will make it much easier,
paving the way for these tools to be implemented.

Remo

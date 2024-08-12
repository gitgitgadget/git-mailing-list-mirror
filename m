Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA76189BB1
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486274; cv=none; b=EtFCJAdxLkEMgSUMw7HUKoPL6e7j50xxVL0SBxBOp/dhg27TBCU23tdOpdNGqHctOVs2hYf3NuPDqQYrCPHipnhkwhgwDgIb+rbZvu5H4gRwCL8M/nL/isKOVtM8YdMf3RHvI8m90Cix9zRZetiCAqMShnSl9BUQVWnvm2r3P5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486274; c=relaxed/simple;
	bh=34UYgw5GuzupdUVVPo5HoQsJ2nAT2HZ7v7txeyoxLOs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HYOVWq9Q/szfh9a9g5XBd2doP2HZJ22MsBHL4+i7NwvWxWHtejH4ezM8y/3xIYhQLSG7iUGoCxsK+doIrzc+tySZjHu6Lt8r+5NXA+eyhhL91P0TcISE5YA4ekCqoFDoqPTWdAbZUbDYuB3C1nuJkDQtsi+JdgmuM5RFDMdvicM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TBb+eBG+; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TBb+eBG+"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7868A3D78A;
	Mon, 12 Aug 2024 14:11:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=34UYgw5GuzupdUVVPo5HoQsJ2nAT2HZ7v7txey
	oxLOs=; b=TBb+eBG+oL923QZ8QGUZF+ZFv7WGn/aoCJc3Z6KTh+b4Tcidyz9sGr
	zoGShzTdrCFG9DtIjyRoM5gvvJ7fCQJkpAHVvuJCJQQ2AxPJPnF40LbSor70wrU+
	bR7mPd0brGAbkZzPUByHxlSHD/PvsDi9cksqluk+X6WfJPZZmqH6k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 716D13D789;
	Mon, 12 Aug 2024 14:11:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ECA5E3D788;
	Mon, 12 Aug 2024 14:11:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Dragan Simic <dsimic@manjaro.org>,  "Jason A. Donenfeld"
 <Jason@zx2c4.com>,  Josh Steadmon <steadmon@google.com>,
  git@vger.kernel.org,  calvinwan@google.com,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  rsbecker@nexbridge.com,
  mh@glandium.org,  sandals@crustytoothpaste.net
Subject: Re: [PATCH v2 0/5] Introduce cgit-rs, a Rust wrapper around libgit.a
In-Reply-To: <CAPig+cSVNqBPjV3_41f6Ag2X4+-q4HidEo0D=1UaMG-Kv7pa5Q@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 12 Aug 2024 05:03:57 -0400")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1723242556.git.steadmon@google.com>
	<Zrdn6QcnfmZhyEqJ@zx2c4.com>
	<6398d60387a6607398e4b8731363572e@manjaro.org>
	<CAPig+cSotr8CNZLy4xnm4qyJsuQsxjzsYMVU5sf3eeoEiE8aXg@mail.gmail.com>
	<xmqq5xs688cz.fsf@gitster.g>
	<CAPig+cSVNqBPjV3_41f6Ag2X4+-q4HidEo0D=1UaMG-Kv7pa5Q@mail.gmail.com>
Date: Mon, 12 Aug 2024 11:11:07 -0700
Message-ID: <xmqqed6t4nno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3FE32DE4-58D6-11EF-8D7B-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> A tangent: Speaking of external/other projects, I don't think we've
> seen an explanation yet as to why this Rust wrapper is proposed as a
> `contrib/` item of Git itself, as opposed to being a separate project.
>
> I can only think of two possible reasons why they might want it in the
> Git project itself...
>
> (1) Easier access to the library portions of Git ("libgit") since that
> portion of the code is not otherwise published as a standalone
> library.

This is not a good reason at all, if we look at what (the real) cgit
project does ;-), which is to bind us as their submodule.

> (2) Perhaps the intention is that this Rust wrapper work will allow
> Rust to be used within Git itself[3]? If that's the case, then
> `contrib/` seems the wrong resting place for this code.

The contrib/ hierarchy is a mixed bag, and we may want to clean it
up by Git 3.0 happens.

 - We used to put things that one-way depend on Git that are (1)
   useless by themselves, if Git did not exist, and (2) Git can do
   fine without them in the contrib/ hierarchy.

   The primary reason for doing so was because the Git was young and
   relatively unknown, and our community was small.  Even for an
   add-on that may be at most "nice to have" from Git's point of
   view, it made some sense to give these add-ons wider exposure by
   simply being bundled with Git.  We stopped doing that after Git
   ecosystem have matured enough and encouraged them to move either
   up (i.e. prove that Git cannot really do fine without it because
   the add-on is so useful, and become the first class part of Git)
   or out (i.e. it may be a fine add-on, but there are other similar
   add-ons that aim to achieve the same, similar, or overlapping
   goal---unlike the nascent era of Git, it should be able to become
   an independent project to compete fairly with others on its merit
   alone).

 - We have some stuff like completion and prompt scripts that have
   proven that the end-user experience cannot be "fine without", but
   haven't moved out of "contrib/", mostly by inercia.

 - We also have things that are meant to help Git developers in the
   hierarchy (Cocci rules come to mind).  This one could fall into
   that category, but I am not sure.

> On the other hand, as a standalone project, a big benefit is that the
> Rust wrapper could have its own release cadence distinct from Git,
> which would likely be very beneficial since it is such a young
> (indeed, nascent) library; it is likely that the maintainers will want
> to release early and often at this stage.

That's cgit approach.  If something is useless if Git did not exist,
but Git does not need it at all to function, that may be a sensible
thing to do.

If we plan to eventually be able to rewrite the logic for say
history traveral or specifying "set of commits" in such a way that
is more involved than just "those that can be reached from these tip
commits excluding the ones that can be reached from those bottom
commits" (in other words, "A..B C..D" that is not "^A B ^C D"), and
find it unpleasant to do in C and want to employ Rust, for example,
we'd certainly need it somewhere in _our_ tree.  Perhaps by the time
it happens we might have an extension/dll mechanism in such a way
that those who do not want (or cannot build) certain extensions can
opt out and these "optional" things would by convention live
somewhere other than the main source code live, but even then,
contrib/ sounds like a wrong place and we'd do so perhaps in extra/
or something.

> [1]: Other Rust projects carry vendored copies of projects upon which
> they rely. For instance, the "native_tls" crate has a vendored copy of
> OpenSSL[2].
>
> [2]: https://docs.rs/native-tls/latest/native_tls/#cargo-features
>
> [3]: https://lore.kernel.org/git/CABPp-BFWsWCGogqQ=haMsS4OhOdSwc3frcAxa6soQR5ORTceOA@mail.gmail.com/

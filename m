Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F39C4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 17:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA5620EDD
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 17:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L0FaFCuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753589AbgJWRgg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 13:36:36 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53881 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753585AbgJWRgg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 13:36:36 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 321E9F18F2;
        Fri, 23 Oct 2020 13:36:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pkiOcEOezjk9
        OyOw9vPVa6NOmRY=; b=L0FaFCuXIhj1N34/B0wcJSdVbufZ5S4Nzx/okobGXH7d
        8ldEcNSonf6NaOrSll2RRqgyo4Zqr4wl30DQHS6cEX0B3kYZXm/6jSQrTqki+4Re
        nUylFBY3XHNURAz9NRyno/T+mYjfF9e+D+4lJ/1D062ytkgH8wFnSsWJS3QtJzI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ewDBJ9
        Ut862sx8iDDNzchOtoQCK32un1rIGdBkZmUqNtt6QsT8a7bFqO2X6/MK4z8V3QzS
        3WAWDVv73fyS1e04GdtY4SxBqIUUbPh5d8oZ8w3J95Um9FJ3cvYC6uzoTSbHn+2v
        jua+uouZzj2dHS4l11tkn9fnNorBdgFiQEomU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A127F18F1;
        Fri, 23 Oct 2020 13:36:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 56AABF18F0;
        Fri, 23 Oct 2020 13:36:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
References: <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com>
        <20201008014855.1416580-1-jonathantanmy@google.com>
        <CAFQ2z_MRzz41x0Osvf6unvQ4Bk-RsA9NxbWZWpfwwJ2D=4Pv7A@mail.gmail.com>
        <873625i9tc.fsf@evledraar.gmail.com>
Date:   Fri, 23 Oct 2020 10:36:26 -0700
In-Reply-To: <873625i9tc.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 23 Oct 2020 11:13:51 +0200")
Message-ID: <xmqqlffwhmjp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 47F7BC42-1556-11EB-BAA1-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> It's not just about the number of lines, but things coming up in grep,
> and now unique code really stands out (e.g. strbuf_add_void, should
> probably be just added to the main strbuf.h if it's needed...), and of
> course the cost of attention of eyeballing an already big series on the
> ML & the churn every time we have updates.

These are all valid concerns.

> Overall I'm all for having this carved out in its own directory at a
> cost of a bit more maintenance burden if it can be shared with libgit2 =
&
> be a standalone library.

Do you mean by "this" the reftable stuff as a whole, or only the
duplicated support library part?  If the latter is split out of what
we import as our reftable/ directory, and stored in a separate
directory that we do not have to import (because we have strbuf and
other stuff) but other people may choose to use (because they may
not have strbuf and other stuff), that may work.  Also, if the
contents of reftable/ directory wants a pluggable allocator, the
main code can be written to call reftable_malloc (or whatever), with
a thin shim to interface with us (i.e. reftable_malloc() would be
implemented as a thin wrapper around xmalloc() for us) which is
stored in a separate directory just for us to interface with the
main reftable library.  For libgit2, there will be a separate
directory that uses a different implementation of reftable_malloc()
that would let them plug their preferred allocator.  An arrangement
like that might work.

I do not offhand know if that kind of overhead is worth the trouble
or if there are better ways, though.

> I am concerned that it seems this code can't be maintained in git.git b=
y
> anyone not willing to sign a contract with Google.

It can be maintained in git.git; the trouble comes when they want to
update us.

I however suspect that, as the primary intended audience, it is hard
to imagine that the reftable library as a standalone project will be
successful without going through the usual reviews and testing in
git.git.  So even though there exists github.com/google/reftable
repository, its contents may not matter very much in practice,
unless they come here and beg for the change we make ourselves
anyway.  Perhaps I am being naive.  I dunno.

> I sent a tiny PR for
> a typo fix at [1] and got directed to sign [2] before someone at Google
> could look at it. I see brian raised this before in [3] but there wasn'=
t
> a reply to that point.
>
> Is there some summary of how this part of integrating it is supposed to
> work going forward?

Yeah, thanks for raising a good point.  We definitely need to figure
this part out.

> At first glance that seems like a recipe for perma-forking this pretty
> much from day one, i.e.:
>
>  A. Upstream changes happen
>  B. We get a patch to the bundled library to this ML
>  =3D=3D> Google employees maintaining A can't even look at B
>  =3D=3D> Patch B can't be integrated into A
>
> 1. https://github.com/google/reftable/pull/2
> 2. https://cla.developers.google.com/about/google-individual
> 3. https://lore.kernel.org/git/20200512233741.GB6605@camp.crustytoothpa=
ste.net/

Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CDA19E819
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770823004; cv=none; b=cdY6z8VBe9z5yZ/lj53J8aFv0b7frEvqnRblS5Nd4pvfOIT7ZYDjh6MRIgt+wQhpeCb5KMfsl1LdXdw72wFe8ItVEbv39ciRIAskVBacA2YP7Co7+0i6TeIz1egfYDyy7lfymeaazX4cEqWL9s7W9PuFiAasbjoP2VuYcWQWBpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770823004; c=relaxed/simple;
	bh=z7m8hh7kYbsyLOywZqGnv2pcFDaMPYNXZNYAdx9j69s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNApBPIvoScqtyrPD+9GTo7j0Fo2JIhzx0wv6u6wHzyhRTYSnxhxBMWy+WDv6pBkVmNffJj80tD1wuSgYiQmxtaYzDuAS2AWJ4T27uIpUYXRDwhxXf+vWgK/beXCXtXUHWALF0XI+M4PIhOKy5TGRltBY1KRQazLLb55BA3NSqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Bz6oTYPO; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Bz6oTYPO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1770822994; x=1771082194;
	bh=A/o2avpyDKEougAIWbG5ORhtJlzB/ZUmVS55yLUUq68=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Bz6oTYPOp5WP5cg8QW0SFEyTIvFDzgLoTWdtlomsoBXgEPQHgfpJME6a9HTjxlt0f
	 vIScrszs2kmxva/lWhbTUQIVoh3Zdu7i/c2E60pgLz0S/AcuOIpiR9pKRbCcSulmiN
	 cAPBGEB99DbHYFfoZ4OvY7dl8qhe8lNofjDC5456uh3GtuTLwxZ8x7T3hNnRJF3HHC
	 dFBiJXNqrSlpT2mrBF5FFK/Jzg1Ks43ZcZEqCmpWs13kSNJLxURXYUbbdQdZ5fMbwB
	 p5n0wXtVWY9YLskZYWBJZo+gAEswj6XeIdjwFxzZoMVetBb/RStv7egAGX0JxVMBRG
	 kjMNvQX93LOmQ==
Date: Wed, 11 Feb 2026 15:16:30 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Chandra <Chandrakr@pm.me>
Cc: Chandra Kethi-Reddy via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: [PATCH] RE: add: support pre-add hook
Message-ID: <LQvDJSyBjBqEvnPMAY4rI3oAHHSNnBZmHV9vfKbeSFeLEIO7kAFMg8CWM9e81_QKCuoL0_a7qMMUwmcLK9Aut9abH0fqpKB5g6KOEya-n7I=@pm.me>
In-Reply-To: <xmqq8qd0zan1.fsf@gitster.g>
References: <pull.2045.git.1770737573475.gitgitgadget@gmail.com> <xmqqldh0zcpa.fsf@gitster.g> <xmqq8qd0zan1.fsf@gitster.g>
Feedback-ID: 10057713:user:proton
X-Pm-Message-ID: bd6b748409bac38c8b8162328783649fefe4e3ac
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thank you for the thorough feedback -- v2 follows the architecture you outl=
ined.

The hook now runs after staging is computed, receiving two positional argum=
ents: a temporary copy of the original index ($1) and the lockfile containi=
ng the proposed index ($2). Hook authors inspect the computed result direct=
ly.

One trade-off: since staging must complete to produce $2, blobs are written=
 to the object store before the hook fires. I think it's worth it though fo=
r the reasons you mentioned re: hook authors.=20

The CI failure is a result of an ar/parallel-hooks conflict.=20

Appreciate the time, effort, and thought you put into review and feedback. =
Excited to hear back

Chandra Kethi-Reddy

Sent with Proton Mail secure email.

On Wednesday, February 11th, 2026 at 12:31 AM, Junio C Hamano <gitster@pobo=
x.com> wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > The hook takes no clue from anything derived from the command line,
> > not even the pathspec (or list of individual paths computed using
> > the pathspec by the command) or the mode of operation like '-u' or
> > '--renormalize'.  I am not sure how effective a decision the invoked
> > hook can make to approve or deny in this lack of information.
>=20
> And I do not necessarily suggest passing the pathspec arguments or
> command line options that the "git add" command received from its
> caller down to the hook, which will force hook authors to emulate
> what "git add" would do to these arguments and options, and they
> will certainly get it wrong.
>=20
> I wonder if we can split write_locked_index() into two so that
> writing out the in-core index to the temporary/lockfile can happen
> separately from the call to commit_locked_index().  If we can do so,
> then the following would become a viable and better implementation
> of this new feature to run the "pre-add" hook:
>=20
>  * Determine if we will need to run this "pre-add" hook, at the
>    location in the code you addded the run_hooks_opt() invocation,
>    but do *NOT* run any hook there yet.
>=20
>  * Instead, create a temporary copy of the index file if the above
>    says "Yes, we are going to run the hook".
>=20
>  * Let the code path to update the in-core index, i.e., letting
>    everythning up to the "finish:" label to run normally.
>=20
>  * Perform the first-half of the write_locked_index(), writing the
>    new index contents into the lockfile, but stopping before
>    committing it to the final name.
>=20
>  * If we are running the hook, run it with two arguments, the name
>    of the temporary copy of the original index we created earlier,
>    and the name of this lockfile that has the proposed contents of
>    the index if the hook allowed "git add" to proceed.
>=20
>  * If we ran the hook and hook succeeded, or if we did not have to
>    run the hook at all, then commit the lockfile.  Otherwise abort
>    the "git add" command and rollback_lock_file().
>=20
>  * Remove the temporary file we created earlier (if any).
>=20
> Your hooks can "GIT_INDEX_FILE=3D$1 git diff --cached --name-only" to
> find out which paths already had changes added before this
> invocation of "git add", and similarly using $2 get the list of
> paths that will add further changes with this invocation.  The
> latter set of paths you can inspect to see if you like the
> additional changes brought in, perhaps like
>=20
>     #!/bin/sh
>     paths=3D$(GIT_INDEX_FILE=3D$2 git diff --cached --name-only)
>     GIT_INDEX_FILE=3D$1 git diff $paths >patch.txt
>=20
>     if grep "^+.*secret" patch.txt
>     then
>         echo "do not divulge company secret!" >&2
> =09exit 1
>     fi
>=20
> or something.
>=20
> 

Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BAB84D0D
	for <git@vger.kernel.org>; Thu, 23 May 2024 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716503031; cv=none; b=o/fGZyCVDiS5FsTAqh1imOciy3XmFumuXuTwEotXSF01JsngX7JknzfzpaGfD7wCfMkLx/5TEgsKp2WrbnutyTiJ1rop0p8CwXXiQImGPzLJ1aShrRWfjcqPSlMGTXKEP6mrwvJAeowI+UkED5e8P926nO5Fs1wSBmLQBdWy+FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716503031; c=relaxed/simple;
	bh=8JbGnilI1cAYDoq/D4iob5xNJ9bZeSlW4kkBNGS0W9U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OsZJ/K68j5Tozr0b+YKRE0RndIwj5WlCjiCrRe1eDOLMS4Mc23jk6Q2m9aRNy+o9k9j7klqxjxf1Th6OrptpVGyrCaU4RozOPb4w/zxryrgmx1iHwwfjvKHOTnFWReZ+a9xk9CTjik5yVBLe88aEbvUeze8zNzn+ffupUPki0co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MgOEvfjX; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MgOEvfjX"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 001BB233E6;
	Thu, 23 May 2024 18:23:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8JbGnilI1cAYDoq/D4iob5xNJ9bZeSlW4kkBNG
	S0W9U=; b=MgOEvfjX2FPRQ6tuYdDLYIxPDTqoNahgqdafeUepCwt1BhN2M53yYX
	zmAd6gyxHXXcgBrIbMi7ASuw6nPLOFHjHpE3jZybD02xAjn8AQ558m+DdqdSQrhL
	WZx6D4pw1y+RLIebQYytjbV8DDkXAaMc5JpiPllfKan265BUTy/UQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EC072233E5;
	Thu, 23 May 2024 18:23:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A6F6B233E4;
	Thu, 23 May 2024 18:23:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Tom Hughes <tom@compton.nu>
Cc: git@vger.kernel.org,  chriscool@tuxfamily.org,  jonathantanmy@google.com
Subject: Re: [PATCH] promisor-remote: add promisor.quiet configuration option
In-Reply-To: <20240523131926.1959245-1-tom@compton.nu> (Tom Hughes's message
	of "Thu, 23 May 2024 14:19:26 +0100")
References: <20240523131926.1959245-1-tom@compton.nu>
Date: Thu, 23 May 2024 15:23:44 -0700
Message-ID: <xmqqsey8qia7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1E8834E0-1953-11EF-BB75-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Tom Hughes <tom@compton.nu> writes:

> Add a configuration optione to allow output from the promisor
> fetching objects to be suppressed/

"optione" -> "option", "suppressed/" -> "suppressed.".

> This allows us to stop commands like git blame being swamped
> with progress messages and gc notifications from the promisor
> when used in a partial clone.

"git blame" -> "'git blame'", perhaps.

It is an interesting observation.  I thought "git blame" was quite
bad at streaming (i.e., until it learned the origin of each and
every line, it never produced any output the user asked for), which
actually would make it a non issue that the output the user wanted
gets mixed with the progress messages and other garbage.  Unless the
user understands that "git blame" is not spending time itself, but
is waiting for necessary blobs to be fetched from the promisor, and
is expected to wait unusally longer than the fully local case,
having to stare at a blank/unchanging screen would make it uneasy
for the end-user and that is why we have progress eye-candy.

I am OK for promisor.quiet being optional, but I am torn when I
imagine what comes next.  On one hand, I myself probably would find
it neat to make these lazy fetches happen completely silently as if
nothing strange is happening from the point of view of end-users
(except for some operations may be unusually slow compared to fully
local repository).  On the other hand, I suspect people will be
tempted to push it to be on by default at which time it may hurt
unsuspecting (new) users who may have been helped by progress bars.

> diff --git a/Documentation/config/promisor.txt b/Documentation/config/promisor.txt
> new file mode 100644
> index 0000000000..98c5cb2ec2
> --- /dev/null
> +++ b/Documentation/config/promisor.txt
> @@ -0,0 +1,3 @@
> +promisor.quiet::
> +	If set to "true" assume `--quiet` when fetching additional
> +	objects for a partial clone.

OK.

> diff --git a/promisor-remote.c b/promisor-remote.c

The implementation is absolutely trivial and straight-forward.

> +test_expect_success TTY 'promisor.quiet=false works' '

Do not say "works"---recall the best practice of writing a good bug
reports.  Stating your expectation more explicitly, e.g. "shows
progress messages" or somesuch.

> +	rm -rf server server2 repo &&
> +	rm -rf server server3 repo &&

Why remove the same thing twice?

> +	test_create_repo server &&
> +	test_commit -C server foo &&
> +	git -C server repack -a -d --write-bitmap-index &&
> +
> +	git clone "file://$(pwd)/server" repo &&
> +	git hash-object repo/foo.t >blobhash &&

Do you need a temporary file, or would

	blobhash=$(git hash-object repo/foo.t) &&

work just fine?  Of course you'd later have to say

	... git -C repo cat-file -p $blobhash

instead of "$(cat blobhash)".  Even simpler, I wonder if you can
remove this hash-object invocation, and then do

	... git -C repo cat-file -p :foo.t


> +	rm -rf repo/.git/objects/* &&

This! IS! BAD! for the reason stated later ...


> +	git -C server config uploadpack.allowanysha1inwant 1 &&
> +	git -C server config uploadpack.allowfilter 1 &&

... but these are OK and expected, ...

> +	git -C repo config core.repositoryformatversion 1 &&
> +	git -C repo config extensions.partialclone "origin" &&

... and this is way too different from what would happen in the real
life.

I'd prefer not to see manual destruction of $GIT_DIR/objects/* or
manual futzing of repository format version and extensions.  These
configuration variables are *NOT* for end-users to futz with, and
the tests should not be doing so either.

Can't we prepare the "repo" only by creating a partial clone in an
usual way?

> +	git -C repo config promisor.quiet "false" &&

This of course is good, as this is what the test wants to check.

> +	test_terminal git -C repo cat-file -p $(cat blobhash) 2>err &&

It seems that exactly the same set of comments apply to the next
one, so I'll refrain from repeating myself.

Thanks.

> +test_expect_success TTY 'promisor.quiet=true works' '
> +	rm -rf server server2 repo &&
> +	rm -rf server server3 repo &&
> +	test_create_repo server &&
> +	test_commit -C server foo &&
> +	git -C server repack -a -d --write-bitmap-index &&
> +
> +	git clone "file://$(pwd)/server" repo &&
> +	git hash-object repo/foo.t >blobhash &&
> +	rm -rf repo/.git/objects/* &&
> +
> +	git -C server config uploadpack.allowanysha1inwant 1 &&
> +	git -C server config uploadpack.allowfilter 1 &&
> +	git -C repo config core.repositoryformatversion 1 &&
> +	git -C repo config extensions.partialclone "origin" &&
> +	git -C repo config promisor.quiet "true" &&
> +
> +	test_terminal git -C repo cat-file -p $(cat blobhash) 2>err &&
> +
> +	# Ensure that no progress messages are written
> +	! grep "Receiving objects" err
> +'
> +
>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd

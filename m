Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A714923A8
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721160186; cv=none; b=jLXqlbK+OfbwEKqLUwkQz3U9WzCjL++8j+7L8QaBFbkQgDppvyHY/nvOamUdoUKFftpAi2euaIhmJ1MuJUD66NfKCO0Nd7qgw5hnofy7Z2MX/hhh/gOcyvrOgF9jqLrjZuT19CQdDYHdIH/ekcZlbOEAsUzgmGOsTRBwyeJqCOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721160186; c=relaxed/simple;
	bh=M4ZuhOz21eliT9Whnt7z+QtBEdTaQO/fIalJPKYBzt0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UJnTY+yUiFCIumnTRgO1tdWkYy4dZpXW7/azlqemrPdXUU6A5cCgdJRS76K33uPJGw5qWE9+SDAoHprW9gU1eVgLUFwnXoe8TNwO4kd2aI6gbr/8veNIVY35YE84+y3BL6jzcjMGArTlG+8fhEiU2NvV5qAsYe4VyKl6zsj9ZLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XfmirFjI; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XfmirFjI"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 71C9B3704E;
	Tue, 16 Jul 2024 16:02:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=M4ZuhOz21eliT9Whnt7z+QtBEdTaQO/fIalJPK
	YBzt0=; b=XfmirFjIZLJPIQQj3TBB3nxQFgKRj35lGIFFSjII5E4FOcHlvOysyK
	h17q78aSxfIGBi89YSnajJOt3rW39i5KifRuPyGSWurD44YZp1M7/8RA0k97zhb9
	f7SJNhH+eK7/sRmI+ofPxYHo1QK8cx1Ab8skjWtWlSLje2vQImNbw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 69F083704D;
	Tue, 16 Jul 2024 16:02:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DB0993704C;
	Tue, 16 Jul 2024 16:02:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Scott Moser <scott.moser@chainguard.dev>,  git@vger.kernel.org
Subject: Re: Can dependency on /bin/sh be removed?
In-Reply-To: <20240716192307.GA12536@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 16 Jul 2024 15:23:07 -0400")
References: <CADaTQqDZ_6wORXOFc2CE90aizgHJ116NDHZhNeY4Nx7NH8DHJw@mail.gmail.com>
	<xmqq8qy21k9f.fsf@gitster.g>
	<20240715235212.GA628996@coredump.intra.peff.net>
	<20240716192307.GA12536@coredump.intra.peff.net>
Date: Tue, 16 Jul 2024 13:02:54 -0700
Message-ID: <xmqqo76x6r69.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 645F60B2-43AE-11EF-A56D-C38742FD603B-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

>   [credential]
>   helper = cache --socket=/path/to/socket --timeout=123
>
> Arguably we could have gotten away with word-splitting ourselves,
> sticking the result in child_process.args, and avoided the shell. But
> the use of the shell is documented in gitcredentials(7):
>
>   helper
>     The name of an external credential helper, and any associated
>     options. If the helper name is not an absolute path, then the string
>     git credential- is prepended. The resulting string is executed by
>     the shell (so, for example, setting this to foo --option=bar will
>     execute git credential-foo --option=bar via the shell. See the
>     manual of specific helpers for examples of their use.
>
> So users may be depending on that to do "--socket=$HOME/.foo", or even
> more exotic shell constructs.
>
> Again, it's possible that we could detect that no shell metacharacters
> are in play and do the word-splitting ourselves. But at that point I
> think it should go into run-command's prepare_shell_cmd(). That is, I I
> think it could take space out of the list of metachars that force us to
> invoke the shell, and do the word-splitting there. But not having
> thought very hard about it, there are probably corner cases where that
> optimization is detectable by the user (presumably unusual IFS, but
> maybe more?).

Well, I strongly object to an approach for us to "parse" anything.
But even then it would be sensible to formulate:

	argv[0] = sh
	argv[1] = -c
	argv[2] = git-credential-cache --socket=/path/	--timeout=123 "$@"
	argv[3] = -
	argv[4] = NULL

and if there is an argument say "get", extend it to

	argv[0] = sh
	argv[1] = -c
	argv[2] = git-credential-cache --socket=/path/	--timeout=123 "$@"
	argv[3] = -
	argv[4] = get
	argv[5] = NULL

before passing the array to execv(), no?

And with the metacharacter optimization to drop .use_shell we
already have, a single-token /bin/myhelper case would then become

	argv[0] = /bin/myhelper
	argv[1] = get
	argv[2] = NULL

naturally.

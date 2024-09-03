Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A021D5CC0
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390722; cv=none; b=nAGD2dA1xsi1pidDiK8ep+879Vo8M1rKlRGnvjt8jPTb0lplExdf55tWQpof7Bp0dRcYZzYzeN4UJh1KAWj40ILLCI5UQIRFzK0jE07+IPtYHQBsYvHHcqIMRpoCAXw1fhfdI7RAtG0SDuDWPYZEyXD/EMiR8+2ouEOpGcrVrF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390722; c=relaxed/simple;
	bh=ONO0c9liFzIRs0+AEnCPmLGIIDFOmvdqYVP/y6sbNOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=War+Q18yYTwW8NIr9I8kv9anp4O7lHTyWTPUJZfhUZwPVNrtO57dxbIfKK4/HBV1WffD+QkcA5UsShFMYdQQVA9r+NoM2Ze5KXJDurJeMCvgTNdTmyQp90UD1A9jygC3gbkfrZ0ofd0QOd8rbbu9aHI2QBIhNQpObuuZiEV0/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SydyHey/; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SydyHey/"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5196438991;
	Tue,  3 Sep 2024 15:11:59 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ONO0c9liFzIRs0+AEnCPmLGIIDFOmvdqYVP/y6
	sbNOM=; b=SydyHey/4NKp26Nq8kuIB9kzL4UTJhxydNi2N3Nwo/nCEhV20B2iX0
	Y5RUsVDbbuhQr2ytiWGukvwA//t5z9/Bxs7pYfApIVIOe6e6Vp6RTq+V6TvDXLo7
	sGSXZoxvAug/2JxYzTn6flhKvX6aYyY5wfsftSbOr1gwAq/UP6Nd0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4773038990;
	Tue,  3 Sep 2024 15:11:59 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD5BC3898F;
	Tue,  3 Sep 2024 15:11:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kevin Lyles via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Kevin Lyles
 <klyles+github@epic.com>,  Kevin Lyles <klyles@epic.com>
Subject: Re: [PATCH v3 1/2] Allow using stdin in run_on_* functions
In-Reply-To: <b310593aec24ff102e2d5cf29c1d8386adbce45d.1725386044.git.gitgitgadget@gmail.com>
	(Kevin Lyles via GitGitGadget's message of "Tue, 03 Sep 2024 17:54:03
	+0000")
References: <pull.1770.v2.git.git.1725052243.gitgitgadget@gmail.com>
	<pull.1770.v3.git.git.1725386044.gitgitgadget@gmail.com>
	<b310593aec24ff102e2d5cf29c1d8386adbce45d.1725386044.git.gitgitgadget@gmail.com>
Date: Tue, 03 Sep 2024 12:11:56 -0700
Message-ID: <xmqqttewimbn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 63DFDA04-6A28-11EF-9D31-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Kevin Lyles via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH v3 1/2] Allow using stdin in run_on_* functions

Imagine that these two commits are applied and appear among hundreds
of other commits in the list of contributions.  Would this commit
title blend in and belong to others?

    $ git log --oneline --no-merges -100

cf. Documentation/SubmittingPatches:describe-changes.

At least, it should somehow hint that the patch is about updating
the t1092 test script.

    Subject: t1092: allow run_on_* functions to use standard input

or something.

> From: Kevin Lyles <klyles@epic.com>
>
> The 'run_on_sparse' and 'run_on_all' functions previously did not work
> correctly for commands accepting standard input.


Our convention is to first describe the status quo in the present
tense, so "previously did not" -> "do not".

It would be helpful to explain why they do not work, perhaps like
so:

    ... functions do not work for commands that consume their
    standard input, because they attempt to run the same command in
    multiple repositories that are set up differently to inspect
    their behaviour differences.

> This also indirectly
> affected 'test_all_match' and 'test_sparse_match'.

"affected" -> "affects".

> Now, we accept standard input and will send it to each command that we
> run. This does not impact using the functions for commands that don't
> need standard input.

And after presenting the observation on the status quo and pointing
out the issue we are going to address, it is our convention to write
what to do in imperative mood, as if we are ordering the codebase to
"become like so".  E.g.

    To allow these commands to consume the standard input, first
    slurp the contents fed from the standard input to a temporary
    file, and then run each attempt with its standard input
    redirected from the temporary file.  This way, these multiple
    attempts will all see the same contents from their standard
    input.

    Note that a command that does not read from the standard input
    does not have to redirect its standard input from </dev/null
    when using these run_on_* helper functions, as the standard
    input of the test environment is already connected to /dev/null.

or something, perhaps.


> Signed-off-by: Kevin Lyles <klyles@epic.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 6fa7f5e9587..87953abf872 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -179,22 +179,26 @@ init_repos_as_submodules () {
>  }
>  
>  run_on_sparse () {
> +	cat >run_on_sparse-input &&

Mixture of word_with_underscore-and-dash-separation look unexpected;
use "run-on-sparse-input" instead, as the output files seem to be
named that way?

>  	(
>  		cd sparse-checkout &&
>  		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-checkout-out 2>../sparse-checkout-err
> -	) &&
> +	) <run_on_sparse-input &&
>  	(
>  		cd sparse-index &&
>  		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-index-out 2>../sparse-index-err
> -	)
> +	) <run_on_sparse-input

Shouldn't the temporary file be removed at the end, or are the
callers expected to live with them?  Unless the test is about
"ls-files -u" or "status", that is usually OK.

>  }
>  
>  run_on_all () {
> +	cat >run_on_all-input &&
> +
>  	(
>  		cd full-checkout &&
>  		GIT_PROGRESS_DELAY=100000 "$@" >../full-checkout-out 2>../full-checkout-err
> -	) &&
> -	run_on_sparse "$@"
> +	) <run_on_all-input &&
> +	run_on_sparse "$@" <run_on_all-input
>  }
>  
>  test_all_match () {
> @@ -221,7 +225,7 @@ test_sparse_unstaged () {
>  	done
>  }
>  
> -# Usage: test_sprase_checkout_set "<c1> ... <cN>" "<s1> ... <sM>"
> +# Usage: test_sparse_checkout_set "<c1> ... <cN>" "<s1> ... <sM>"
>  # Verifies that "git sparse-checkout set <c1> ... <cN>" succeeds and
>  # leaves the sparse index in a state where <s1> ... <sM> are sparse
>  # directories (and <c1> ... <cN> are not).

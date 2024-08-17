Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D97712CDA5
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 11:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723893793; cv=none; b=W5pR/sckR9YzPQHy7hEa9iZKvuejRGeTB0oJuh2qxbGXtON4JQLLynIb6r+zQwoD3F0mOdpa5LmwMoFaMvrD52Ka1LmTXDgCB2eCe5vvylEPGeBcEJmKeLnXxlz7A7Syo0H8KWAx6KR3rus9YanZMfUsLLkDbvqNFQRubp6VGh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723893793; c=relaxed/simple;
	bh=RO8F7JKKR7CvhQd1LTZsV6dWe6oZszNYg/2Id4GOoyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=czfUwO6StGBQEjZcxrTlkjQzwCS0ukqL95+/w5x88s0NBgc3F5Vu/aFAJe21Ewj2v+WAena4x+LtclOehXyj0c68FLQWWqyJOKC8L2/GTO6B3VywthBrEF0FH/WvlhddPpEgqqLJMS6d9MTfrpi+P2sAtsmw+6sk4Z8/Xmzqc7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EKpbsibn; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EKpbsibn"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3868C360A5;
	Sat, 17 Aug 2024 07:22:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RO8F7JKKR7CvhQd1LTZsV6dWe6oZszNYg/2Id4
	GOoyg=; b=EKpbsibn21RuYkXpQpe8wc/ofm0bqNtGLH6M3Rg0C/5o3T+OosDFCP
	Q+3+mrygpInSh7kjnD6jNLY9kmf+9PYs4nSFruNmzgcZpo7/s6OE6cX0SqyXYNiP
	1mcRGeKaoytz+5cjE6HhxvSSayUemdy+J0UZ2EMCh2j3js3VFDulg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D7FB360A3;
	Sat, 17 Aug 2024 07:22:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6AACD360A2;
	Sat, 17 Aug 2024 07:22:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Matheus Tavares <matheus.tavb@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  newren@gmail.com,
  ps@pks.im,  Lincoln Yuji <lincolnyuji@hotmail.com>,  Rodrigo Siqueira
 <siqueirajordao@riseup.net>
Subject: Re: [PATCH v2] rebase -x: don't print "Executing:" msgs with --quiet
In-Reply-To: <be3c968b0d9085843cd9ce67e85aadfaaafa69c8.1723848510.git.matheus.tavb@gmail.com>
	(Matheus Tavares's message of "Fri, 16 Aug 2024 19:48:30 -0300")
References: <767ea219e3365303535c8b5f0d8eadb28b5e872e.1723778779.git.matheus.tavb@gmail.com>
	<be3c968b0d9085843cd9ce67e85aadfaaafa69c8.1723848510.git.matheus.tavb@gmail.com>
Date: Sat, 17 Aug 2024 04:22:22 -0700
Message-ID: <xmqq34n3jswh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F998B558-5C8A-11EF-A171-9B0F950A682E-77302942!pb-smtp2.pobox.com

Matheus Tavares <matheus.tavb@gmail.com> writes:

> `rebase --exec` doesn't obey --quiet and ends up printing a few messages
> about the command being executed:
> ...
> -static int do_exec(struct repository *r, const char *command_line)
> +static int do_exec(struct repository *r, const char *command_line, int quiet)
>  {
>  	struct child_process cmd = CHILD_PROCESS_INIT;
>  	int dirty, status;
>  
> -	fprintf(stderr, _("Executing: %s\n"), command_line);
> +	if (!quiet)
> +		fprintf(stderr, _("Executing: %s\n"), command_line);

This is very much understandable and match what the proposed log
message explained.

> @@ -4902,7 +4903,7 @@ static int pick_one_commit(struct repository *r,
>  	if (item->command == TODO_EDIT) {
>  		struct commit *commit = item->commit;
>  		if (!res) {
> -			if (!opts->verbose)
> +			if (!opts->quiet && !opts->verbose)
>  				term_clear_line();

This is not, though.  The original says "if not verbose, clear the
line", so presumably calling the term_clear_line() makes it _less_
verbose.  The reasoning needs to be explained. 

I actually would have expected that this message ...

>  			fprintf(stderr, _("Stopped at %s...  %.*s\n"),
>  				short_commit_name(r, commit), item->arg_len, arg);

... goes away when opts->quiet is in effect ;-).

Another thing, if _all_ calls to term_clear_line() is done under the
same "not quiet, and not verbose" condition, perhaps it is easier to
follow the resulting code if a helper function that takes a single
argument, opts, and does eomthing like:

	static void helper(struct replay_opts *opts)
	{
		/* 
                 * explain why we shouldn't call term_clear_line()
                 * under opts->quiet or opts->verbose here.
		 */
		if (opts->quiet || opts->verbose)
			return;
		term_clear_line();
	}

Once we understand why it makes sense to treat quiet and verbose the
same way with repect to clearing the line, we can properly fill the
"explain" above, and give an intuitive name to the helper, which will
help readers understand the callers, too.

> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index ae34bfad60..15b3228c6e 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -235,6 +235,13 @@ test_expect_success 'rebase --merge -q is quiet' '
>  	test_must_be_empty output.out
>  '
>  
> +test_expect_success 'rebase --exec -q is quiet' '
> +	git checkout -B quiet topic &&
> +	git rebase --exec true -q main >output.out 2>&1 &&
> +	test_must_be_empty output.out
> +	
> +'

Thanks.

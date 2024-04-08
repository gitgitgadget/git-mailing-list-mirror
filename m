Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E108814884C
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712615389; cv=none; b=Qwuq0pFSiloyRKHSDKIa68j5S1oddneSv/GBDgn9lpLjX9Hn+kjPmwdK1ut1w+xjOJW92HO9JH/tLSaT8hOin7NNePfKlyFjK8K6Xux7kyQOioZMErc8In/8DJqflEMVdReI9tf4mMneyCgDiUJLpgPbEtGIx0TKA897kh583/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712615389; c=relaxed/simple;
	bh=Hd86yeDy/c2FPyEroelr+KD1zLH+vHF+hVuCB428ye0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SFyRck5cuSzgOyhEQVVjmf8cPWsg4FbY7ds+gtAxa6NZ1hAvZIsuBbyiyAT9A3DPmW2FYVv/IfTl14wRSDYsiT26HQeQWF3k5Gg+1Uu0bzo0CL61lWMeIT2cvhgD7gmE4lfzG+DLNOPfRxR0C7K66HWMSSFqo03DVD+8W15bPFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NDagkw/U; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NDagkw/U"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 248733B5BE;
	Mon,  8 Apr 2024 18:29:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Hd86yeDy/c2FPyEroelr+KD1zLH+vHF+hVuCB4
	28ye0=; b=NDagkw/UtMwZco1z+PqgifFpAsOTF8SCOk3d7DjVqm8vH14XNPnL/6
	KIdDkubB2nP6CF8LcmNsVWaBw60OSrzg+D7nNa2yPck7IjN1wdRWFeKL3SAtSBw/
	bzSxTg78dUOt94gDO5rjhg9+SVg7h9gi7/Ul+SM7r0p/STTJ/tfBY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1BDB43B5BD;
	Mon,  8 Apr 2024 18:29:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9B9453B5BC;
	Mon,  8 Apr 2024 18:29:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Stefan Haller <lists@haller-berlin.de>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,
  =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 2/2] rebase -i: improve error message when picking merge
In-Reply-To: <fbc6746e0188ed7b69c238935ec85b69112ddd79.1712585788.git.gitgitgadget@gmail.com>
	(Phillip Wood via GitGitGadget's message of "Mon, 08 Apr 2024 14:16:27
	+0000")
References: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
	<pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>
	<fbc6746e0188ed7b69c238935ec85b69112ddd79.1712585788.git.gitgitgadget@gmail.com>
Date: Mon, 08 Apr 2024 15:29:42 -0700
Message-ID: <xmqqle5n7ajt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7F4CA9B6-F5F7-11EE-B962-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The only todo commands that accept a merge commit are "merge" and
> "reset". All the other commands like "pick" or "reword" fail when they
> try to pick a a merge commit and print the message
>
>     error: commit abc123 is a merge but no -m option was given.
>
> followed by a hint about the command being rescheduled. This message is
> designed to help the user when they cherry-pick a merge and forget to
> pass "-m". For users who are rebasing the message is confusing as there
> is no way for rebase to cherry-pick the merge.
>
> Improve the user experience by detecting the error when the todo list is
> parsed rather than waiting for the "pick" command to fail and print a
> message recommending the "merge" command instead. We recommend "merge"
> rather than "exec git cherry-pick -m ..." on the assumption that
> cherry-picking merges is relatively rare and it is more likely that the
> user chose "pick" by a mistake.

Now, the mention of "all the other commands" makes me curious what
should happen when your "squash" and "fixup" named a merge commit.
I think it should just error out without any recourse, but it is
more than likely that I am missing some use cases where it is useful
to "squash" or "fixup" a merge commit on top of an existing commit?

> It would be possible to support cherry-picking merges by allowing the
> user to pass "-m" to "pick" commands but that adds complexity to do
> something that can already be achieved with
>
>     exec git cherry-pick -m1 abc123

I have no strong opinions between this and "merge" for "pick",
"edit", and "reword".

> Reported-by: Stefan Haller <lists@haller-berlin.de>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c                   | 37 +++++++++++++++++++++++++++++++++--
>  t/t3404-rebase-interactive.sh | 33 +++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+), 2 deletions(-)

So, having thought about my version of a solution from the problem
description above without looking at your answers, let's see how you
solved it.

> diff --git a/sequencer.c b/sequencer.c
> index a3154ba3347..4012c6f88d9 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2573,7 +2573,35 @@ static int check_label_or_ref_arg(enum todo_command command, const char *arg)
>  	return 0;
>  }
>  
> -static int parse_insn_line(struct repository *r, struct replay_opts *opts UNUSED,
> +static int error_merge_commit(enum todo_command command)
> +{
> +	switch(command) {
> +	case TODO_PICK:
> +		return error(_("'%s' does not accept merge commits, "
> +			       "please use '%s'"),
> +			     todo_command_info[command].str, "merge -C");
> +
> +	case TODO_REWORD:
> +		return error(_("'%s' does not accept merge commits, "
> +			       "please use '%s'"),
> +			     todo_command_info[command].str, "merge -c");
> +
> +	case TODO_EDIT:
> +		return error(_("'%s' does not accept merge commits, "
> +			       "please use '%s' followed by '%s'"),
> +			     todo_command_info[command].str,
> +			     "merge -C", "break");

OK.  And when hitting the "break", they know that they are supposed
to say "git commit --amend" and then "git rebase --continue"?

> +	case TODO_FIXUP:
> +	case TODO_SQUASH:
> +		return error(_("cannot squash merge commit into another commit"));

OK, this is as I expected.

> +	default:
> +		BUG("unexpected todo_command");
> +	}
> +}
> +
> +static int parse_insn_line(struct repository *r, struct replay_opts *opts,
>  			   struct todo_item *item, const char *buf,
>  			   const char *bol, char *eol)
>  {
> @@ -2679,7 +2707,12 @@ static int parse_insn_line(struct repository *r, struct replay_opts *opts UNUSED
>  		return status;
>  
>  	item->commit = lookup_commit_reference(r, &commit_oid);
> -	return item->commit ? 0 : -1;
> +	if (!item->commit)
> +		return -1;
> +	if (is_rebase_i(opts) && item->command != TODO_MERGE &&
> +	    item->commit->parents && item->commit->parents->next)
> +		return error_merge_commit(item->command);

This is good for now, but we may see command other than TODO_MERGE
learn how to handle a merge commit, and when that happens, I wonder
what we want to do here.  One thought is to do this:

	if (is_rebase_i(opts) && is_merge_commit(item->commit))
        	return error_merge_commit(item);

and teach error_merge_commit() to silently return 0 on TODO_MERGE.
Other commands, when they learn how to deal with a merge commit,
will then update their entries in error_merge_commit().

Would we want to customize the message from error_merge_commit() to
make it closer to cut-and-paste ready?  For that, something like

	int error_merge_commit(struct todo_item *item)
	{
		switch (item->command) {
		case TODO_PICK:
			return error(_("'%s'" is bad, plase use "
				       '%s %s'"),
				todo_command_info[item->command].str,
				"merge -C",
				oid_to_hex(item->commit->oid));
		...
		}
	}

might go in a more friendly way.


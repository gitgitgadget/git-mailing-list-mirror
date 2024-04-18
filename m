Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E8194C6A
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713474238; cv=none; b=m8uarbUlp/TvTNJfQJvlYSN8jQyxTTsXMKot9J8MzBeZbrl2CL8a2wEhg07cvg0EgqGXnUA3d6dNQbm+aH6c4QscR0o9Ht8gtn9H4nYJiv5TJPQZQsNBAWD0qY5wq5RqiBtccYg601zDKIcCqMuAPvvdy8EbpTwTC3aKGw3a8Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713474238; c=relaxed/simple;
	bh=NuOlfPCULcADzHOOCesLIhiD5c/9OEN3CVmGdVJlfCY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nujbGqVQAaG4lldY9A3DRs9TyEuvYNZysO1Mjtoo94kx8XGiaTsroUvXWtws3ROAPCUorrUdJFM78fBmdXmoWV9fmsXzkhy16dEHJt4qcF7O+agRHO9PuChIdnSKBA4ary4QTUyz9Mm1sV2H9c/jBaEDe+hGzVRfQSQjKr7z50E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AHeB9yNM; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AHeB9yNM"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E8B51E78C4;
	Thu, 18 Apr 2024 17:03:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NuOlfPCULcADzHOOCesLIhiD5c/9OEN3CVmGdV
	JlfCY=; b=AHeB9yNMl56PqdokQAcwhCkply01UVRRo1PU0yTSszT/okEaKG7wKW
	7BTgB4LKLK0I1HBaddxACxuGpP5Gjm5hbHnI4O+EGKRyb5+VRhPrfyvypDDm/HJz
	wGqSaVk/KHfc50E3nl3YzTkiONRfehGKGua6yh0KcGMs7NB5qVlMM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 15D0F1E78C2;
	Thu, 18 Apr 2024 17:03:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7BFB81E78C1;
	Thu, 18 Apr 2024 17:03:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  David Bimmler <david.bimmler@isovalent.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/5] sequencer: store commit message in private context
In-Reply-To: <fcef79ede656ba8e6dcd153e115095c123e0f05d.1713445918.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Thu, 18 Apr 2024 14:14:08 +0100")
References: <cover.1713445918.git.phillip.wood@dunelm.org.uk>
	<fcef79ede656ba8e6dcd153e115095c123e0f05d.1713445918.git.phillip.wood@dunelm.org.uk>
Date: Thu, 18 Apr 2024 14:03:54 -0700
Message-ID: <xmqqcyqmqt6t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2AE8422C-FDC7-11EE-B6B1-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Add an strbuf to "struct replay_ctx" to hold the current commit
> message. This does not change the behavior but it will allow us to fix a
> bug with "git rebase --signoff" in the next commit. A future patch
> series will use the changes here to avoid writing the commit message to
> disc unless there are conflicts or the commit is being reworded.

Is the machinery stopping due to conflicts the only reason why we
may want to write the message out to the filesystem?  I am wondering
if there are hooks that kick in before each commit gets picked, and
observe what the message being prepared to be used for the commit
is.

By the way, while I personally am fond of the spelling "disc",
nobody in the recent commit uses it (I saw another reference or two
in earlier steps of this series).  Perhaps "disc" -> "file", because
many filesystems are no longer on a spinning medium these days?

> The changes in do_pick_commit() are a mechanical replacement of "msgbuf"
> with "ctx->message". In do_merge() the code to write commit message to
> disc is factored out of the conditional now that both branches store the
> message in the same buffer.

Nice.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c | 96 ++++++++++++++++++++++++++++-------------------------
>  1 file changed, 50 insertions(+), 46 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index edc49c94cce..31e4d3fdec0 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -211,6 +211,11 @@ static GIT_PATH_FUNC(rebase_path_keep_redundant_commits, "rebase-merge/keep_redu
>   * A 'struct replay_ctx' represents the private state of the sequencer.
>   */
>  struct replay_ctx {
> +	/*
> +	 * The commit message that will be used except at the end of a
> +	 * chain of fixup and squash commands.
> +	 */
> +	struct strbuf message;
>  	/*
>  	 * The list of completed fixup and squash commands in the
>  	 * current chain.
> @@ -226,13 +231,18 @@ struct replay_ctx {
>  	 * current chain.
>  	 */
>  	int current_fixup_count;
> +	/*
> +	 * Whether message contains a commit message.
> +	 */
> +	unsigned have_message :1;
>  };

OK.  Having this member means we specifically allow message.len==0
to be a valid commit log message.

If it weren't for alignment and padding concern, it would have been
much nicer to have this member next to the .message member, and then
we do not even need such comment, as long as the name of the member
is clear enough (say, .message_valid).  Alas, we do want to have the
larger stuff near the front of the struct, and this member has to
sit near the end, so we need a comment to tell readers the linkage
between the two.  I still do not see a need for a 3-line comment for
this member, though ;-)

> +	ctx->have_message = 1;
> +	if (write_message(ctx->message.buf, ctx->message.len,
> +			  git_path_merge_msg(r), 0)) {
> +		    ret = error_errno(_("could not write '%s'"),
> +				      git_path_merge_msg(r));
> +		    goto leave_merge;
> +	}

As we are writing the in-core message to disc, we know they are in
sync, in other words, if we wanted to "read" the message, we know we
do not have to go back to disc and instead use the in-core version.

So, when do we *not* have .have_message member true?  Before we
found out the original message by reading the commit?  In this step,
the .have_message member is only set and not acted upon, so it is a
bit hard to see how it is meant to be used before moving to the next
step.  Let's see how it goes.

Thanks.

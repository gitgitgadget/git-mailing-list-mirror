Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5412130A4E
	for <git@vger.kernel.org>; Fri, 24 May 2024 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564830; cv=none; b=ksMrAVDk6QkRc7NIKkAfehRg7NElTyhJ7r4fa4TD5fkFkVWH4pp1cFg6u48hXJvlocRH1moY3gtQycCdQmYbf7ACczBVfmVXqKeUrI+StSYGWD2SFugql0dwrLo7zRTzhvXY2fL6EfXH+hTR+bjGTGMgLPZGklRzBhPnqpjS9Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564830; c=relaxed/simple;
	bh=5NHUz/kQnPZDUqIOzlSFlD3qL+KsqFM8VNW6I+Y88BM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g6cMofyDgTcLk2RZkHJKRq9eMLXVCxaDSRLMo02bAbGFDJAITqu9cLPLzgNiIJRxN0ZhTtQcvsm95p631Hjw5pqmI9PonnKAQhghp39lopIZeoqCtHErB4dir3bVl5ZRzqAM5tGXybpKMfiXRNOMMHFgIaKPmbmXgkuChQnvHtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MS4j92w4; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MS4j92w4"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 28DD829801;
	Fri, 24 May 2024 11:33:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5NHUz/kQnPZDUqIOzlSFlD3qL+KsqFM8VNW6I+
	Y88BM=; b=MS4j92w41cGEtOC6A0k6dAlCLy7YH3XN/SmkEV1B8NsRN8aBO3U0Dy
	8vFJ8dkG0K3ePZHy/NMgGgHhtUYIrPeyaKryY/RX0Q+3ZFsGsnUxscHYAfDX0+8B
	e7CQG00lp3jaWisde7OGjk0JuxNo53upWtAnyHw8neqapNd8O0evM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2141A297FE;
	Fri, 24 May 2024 11:33:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3DC86297F9;
	Fri, 24 May 2024 11:33:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Wienand <iwienand@redhat.com>
Cc: git@vger.kernel.org,
    Johannes Sixt <j6t@kdbg.org>, Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 3/3] run-command: show prepared command
In-Reply-To: <ZlA_WIn1y7Oo_D88@fedora19.localdomain> (Ian Wienand's message of
	"Fri, 24 May 2024 17:18:48 +1000")
References: <20240523042143.1220862-1-iwienand@redhat.com>
	<20240523043806.1223032-1-iwienand@redhat.com>
	<20240523043806.1223032-3-iwienand@redhat.com>
	<xmqqpltcwnqm.fsf@gitster.g> <xmqqttiop05y.fsf@gitster.g>
	<xmqq4janpwqq.fsf@gitster.g> <ZlA_WIn1y7Oo_D88@fedora19.localdomain>
Date: Fri, 24 May 2024 08:33:43 -0700
Message-ID: <xmqqsey7ns14.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 01F1CC98-19E3-11EF-971A-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Ian Wienand <iwienand@redhat.com> writes:

> On Thu, May 23, 2024 at 11:09:01PM -0700, Junio C Hamano wrote:
>> So with this applied on top of the topic, 'seen' does pass with
>> SHELL_PATH set to say /bin/dash, but this still fails CI jobs on
>> Windows.  
>
> Sigh, it looks like windows uses prepare_shell_cmd() instead.  I think
> it's still probably valid to dump the full command there for the same
> reasons, which I'll add in v4.

Ahh, it's the large conditional compilation in start_command().

On non-Windows side, we just do

	if (prepare_cmd(&argv, cmd) < 0) {
		failed_errno = errno;
		...
		goto end_of_spawn;
	}
	... pipe(), fork(), and exec() ...

but on Windows side, we have

	if (cmd->git_cmd)
		cmd->args.v = prepare_git_cmd(&nargv, sargv);
	else if (cmd->use_shell)
		cmd->args.v = prepare_shell_cmd(&nargv, sargv);

	cmd->pid = mingw_spawnvpe(cmd->args.v[0], cmd->args.v,
				  (char**) cmd->env.v,
				  cmd->dir, fhin, fhout, fherr);

And the thing is, prepare_cmd() already has

	if (cmd->git_cmd) {
		prepare_git_cmd(out, cmd->args.v);
	} else if (cmd->use_shell) {
		prepare_shell_cmd(out, cmd->args.v);
	} else {
		strvec_pushv(out, cmd->args.v);
	}

I am wondering (and not suggesting to do this as a part of this
series, but to decide if we should leave a left-over-bits note here)
if the Windows side can be updated to also use prepare_cmd().  Do
folks a lot more familiar with Windows than I (cc'ed j6t and dscho)
have comments on this?

Anyway.

If you unconditionally add the printf's to both prepare_cmd() and
prepare_shell_cmd(), you'll see two printf output on a non-Windows
platform if we are spawning a shell cmd.

It appears that the best place to "show the prepared command" is
*NOT* in any of these prepare_* helper functions, but after these
two callers in start_command() receives the prepared command from
these helpers, namely:

        diff --git c/run-command.c w/run-command.c
        index 1b821042b4..9d0fa6afe4 100644
        --- c/run-command.c
        +++ w/run-command.c
        @@ -745,6 +745,7 @@ int start_command(struct child_process *cmd)
                                error_errno("cannot run %s", cmd->args.v[0]);
                        goto end_of_spawn;
                }
        +	/* Here show argv in the trace */

                if (pipe(notify_pipe))
                        notify_pipe[0] = notify_pipe[1] = -1;
        @@ -912,6 +913,7 @@ int start_command(struct child_process *cmd)
                        cmd->args.v = prepare_git_cmd(&nargv, sargv);
                else if (cmd->use_shell)
                        cmd->args.v = prepare_shell_cmd(&nargv, sargv);
        +	/* Here show cmd->args.v in the trace */

                cmd->pid = mingw_spawnvpe(cmd->args.v[0], cmd->args.v,
                                          (char**) cmd->env.v,

We would not have to do so and instead have trace-printf(s) only in
prepare_cmd() if/when the Windows side is updated to stop switching
between the prepare_git/prepare_shell and instead let prepare_cmd()
do the switching, (which may require an update to prepare_cmd() if
needed).  But until that happens, logging at the caller seems to be
the best approach among equally bad ones.

Thanks.

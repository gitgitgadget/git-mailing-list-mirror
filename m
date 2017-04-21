Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43817207BD
	for <e@80x24.org>; Fri, 21 Apr 2017 02:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034810AbdDUCji (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 22:39:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59456 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1034800AbdDUCjf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 22:39:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDBC07C2C1;
        Thu, 20 Apr 2017 22:39:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jAF3fV9jdkmR
        yZvaumuHOvU2vSo=; b=eu+3HymRxMYAm7zolnSdLgL3IKpFXjFc+WPweNSKuL6G
        qgq/r4v64rzRI6aDJAkh4W3HIlo7WD8II2cZALOZfLK59KGFT4olFbDzzOqgrUH0
        LHmvviax8sx9e6LeG1RQowjWhKlHTENWJkY0eVPQu+m54gUHX/zhfJ0HiZHtS3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vzcItB
        zQ3PLWM5OKwmMquIw4GwiCIbp2Lwhx6iLWQOYAXLho+UoU8AUfbckgLqNUIpw6z6
        W+0vAimL1ic5efuPMY6ZIJ2Mk65T7AYLdakyE55N1OKQpnyK/Q3WQneAv7v78rOS
        w8knAo5aJxfliDux6hLQ2g0sY3L3L9bVfpJeQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D58977C2C0;
        Thu, 20 Apr 2017 22:39:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 496E67C2BF;
        Thu, 20 Apr 2017 22:39:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/6] worktree move: new command
References: <20170420101024.7593-1-pclouds@gmail.com>
        <20170420101024.7593-4-pclouds@gmail.com>
Date:   Thu, 20 Apr 2017 19:39:32 -0700
In-Reply-To: <20170420101024.7593-4-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Thu, 20 Apr 2017 17:10:21 +0700")
Message-ID: <xmqq4lxi7acb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C087C174-263B-11E7-8C4D-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> There are two options to move the main worktree, but both have
> complications, so it's not implemented yet. Anyway the options are:
>
>  - convert the main worktree to a linked one and move it away, leave th=
e
>    git repository where it is. The repo essentially becomes bare after
>    this move.
>
>  - move the repository with the main worktree. The tricky part is make
>    sure all file descriptors to the repository are closed, or it may
>    fail on Windows.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---
>  Documentation/git-worktree.txt         |  7 +++++-
>  builtin/worktree.c                     | 41 ++++++++++++++++++++++++++=
++++++++
>  contrib/completion/git-completion.bash |  2 +-
>  t/t2028-worktree-move.sh               | 31 +++++++++++++++++++++++++
>  4 files changed, 79 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
> index 553cf8413f..b47a3247bb 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -12,6 +12,7 @@ SYNOPSIS
>  'git worktree add' [-f] [--detach] [--checkout] [-b <new-branch>] <pat=
h> [<branch>]
>  'git worktree list' [--porcelain]
>  'git worktree lock' [--reason <string>] <worktree>
> +'git worktree move' <worktree> <new-path>
>  'git worktree prune' [-n] [-v] [--expire <expire>]
>  'git worktree unlock' <worktree>
> =20
> @@ -71,6 +72,11 @@ files from being pruned automatically. This also pre=
vents it from
>  being moved or deleted. Optionally, specify a reason for the lock
>  with `--reason`.
> =20
> +move::
> +
> +Move a working tree to a new location. Note that the main working tree
> +cannot be moved yet.
> +

You do not need to say "yet" here.  It may come, or it may never
come, and it does not matter to the readers an iota when they read
this.  The only thing that matters to them that they need to know is
that they cannot move the primary one.

> +static int move_worktree(int ac, const char **av, const char *prefix)
> +{
> +	struct option options[] =3D {
> +		OPT_END()
> +	};
> +	struct worktree **worktrees, *wt;
> +	struct strbuf dst =3D STRBUF_INIT;
> +	const char *reason;
> +
> +	ac =3D parse_options(ac, av, prefix, options, worktree_usage, 0);
> +	if (ac !=3D 2)
> +		usage_with_options(worktree_usage, options);
> +
> +	strbuf_addstr(&dst, prefix_filename(prefix, av[1]));
> +	if (file_exists(dst.buf))
> +		die(_("target '%s' already exists"), av[1]);
> +
> +	worktrees =3D get_worktrees(0);
> +	wt =3D find_worktree(worktrees, prefix, av[0]);
> +	if (!wt)
> +		die(_("'%s' is not a working directory"), av[0]);
> +	if (is_main_worktree(wt))
> +		die(_("'%s' is a main working directory"), av[0]);

s/directory/tree/ perhaps, as Documentation/git-worktree.txt
advertises these as "working trees"?

The user _may_ be well aware that av[0] is the primary one, and this
message would solicit a "Huh--so what?" from such a user, unless it
says that moving the primary one is not supported.

> +	reason =3D is_worktree_locked(wt);
> +	if (reason) {
> +		if (*reason)
> +			die(_("already locked, reason: %s"), reason);

Good.

> +		die(_("already locked, no reason"));

I would suggest s/, no reason// here.  To somebody who reads these
two lines of calls to die(), it is clear what you wanted to mean by
that (i.e. we would have given the reason string if it were
avalable, but there isn't, so we are stressing the fact that we got
nothing), but to an end user who only sees the latter, without
necessarily knowing that some other times the former message may
have been given, it is confusing.

For that matter, I am not sure "already" is a good phrase to use
here.  It's not like the end-user is asking to lock the worktree.
If we refuse to move a locked worktree, perhaps we should say so.
i.e. "cannot move a locked working tree (reason for locking: %s)"
or something.


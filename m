Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0BBEC8758
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 19:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjIGTsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 15:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjIGTsI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 15:48:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDF11703
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 12:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694116082; x=1694720882; i=johannes.schindelin@gmx.de;
 bh=UfUECOy6YlBG1FkRiRZMJUrY+qFZE8BE2OCVycTKcSA=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=l7PkkanwFjHyPWJgsuNAAOdC1nWIqe2naFsnZJntgQHTeOz2RKljJaJke6qaFO9wKBSn390
 fBWtsWJ+Ys7+EK+0J05J3SoMds7GETRGhzX73K5Mj433Xlv0qo/ADd5m2Wx5aJsylkbMS630V
 vqc4mhpMOJ//NJzDbcsrc28O5DQDAfS0vJr8LQq1YzK5z5vmXHMoRa4G1o0foOQYAS/6zLFUa
 JLZAv0mopEObeQhQP38j9dvAPjZT3M9reMZ8UPHtSHUwQd+/t1fam4loqR2hvKOzDN48Jy4Ug
 tw9oeTp6X85irXBASZo8kOF2dk/AqnIJXpsk9mKcFYWPkUA1lsUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.130]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Qr-1q5B011FUB-00aGsK; Thu, 07
 Sep 2023 14:57:10 +0200
Date:   Thu, 7 Sep 2023 14:57:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: ignore signals when forking subprocesses
In-Reply-To: <pull.1581.git.1694080982621.gitgitgadget@gmail.com>
Message-ID: <912205bc-37c5-edbf-2f85-f26991ad65eb@gmx.de>
References: <pull.1581.git.1694080982621.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8V94F3vPKJOdWaK6w5sB/EkDqxEjLEMvy9B6Kt1RoDTJm2n284E
 7aC5TMM4sHjp9+b1HBGfgZiJanPVELqCJosUEtGbAlSqm6OK4s3ZHUQ1aPAc1s/0xHoA7jm
 +w/rDL1NqXQSJ1gaY08plLlXaNsTL6ceTtt2SUKDYf3jTM565ZE7ZfErY1uPearkUfOKM/t
 TFSd0wxX4go4xrIOMthsw==
UI-OutboundReport: notjunk:1;M01:P0:gffMbLDdwSA=;0vy/jyK5hB8Oy7vC3WbYW3hglaX
 AvSIludCyQsfJKEVEbrmypNvEtdS6Jh3KuVnJ0y2xlDKPzIeZEi9RcXUEtu4O2FFS4EYQ/ede
 qeXZY1k0tg3MONol7XrsXJBAq9OUQNjma9UV002UvyYJgM+/6aWHUKj/7IhJHtRU91fp1DPLh
 6ipJ/A17hEgV+CTFQM8Mlcpe5ALWUcDKkHmzv0pFaFtKMqpkQDK6Am2zVJaSfzJFZdD5PaABs
 hqjtztZzVauN+HHiaqGI7hjWi7TM1F4d8VeUVl0T8M50FMn8eLs3YUJaNQHaNkfmyWG6QshmM
 KPasv/LtN59tVU4MP1qGbM9LbF85mzvB600sSM7ktS5MGzfGPoFQTvVuLPc85I5aIEdqzM4qB
 FYSKi76swpey3+qy06EqcKijgFm70rrA6nmTa9a8ItcDF2+XNQg7uoIhD85wvBvL3bDjtCo4K
 WFZxruRW4wHHKyZozl932KVuwMV9pYTmvRMRmNTkXTyMSGiAp6yKzAClqIg9SgD0RhKh8xCpr
 +498MbEQ++qS3BeJBtUnWOCwZSQ0jYyM3IlzzZRygLWjRFtz58i1aKL97SjNCaYnumCKU5dI2
 f6aSBox2C6RSudTPAv9LrQ9ZhQ5eDmjkdKNTffcED1d7EQbwu9/Rh0sb+n+jX6rux/uQC8BLB
 pI3g3jwwAXnjGUFkrznnFrkO29J4OHLCPZVymSNLYIzw67RRgSyUmPeHD97iTtXS0lWoFdeHv
 vJC93CPVaTi5Nagg6tAPemYjm7VFMT4ZGkM/HS0kthaRYSOBugbueSYJmZ8mH+1lrERmyEz8l
 xKt0U2LueYeAhnt2DIzzaSpbnicBO1Hj4dhM2TYzF+XGXnzcSzKKf2P/fSPlv58rcS7xzsA7W
 WHVWUcvtTKlbGKo9fD4vJJr/Lhq1IPIH6hklhKqgX5R5Bj7V2ZfGOqcPH/CPLv271vhCyP6/D
 uHGe9OXnAqbQHRHdbZ51QUqngSU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 7 Sep 2023, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If the user presses Ctrl-C to interrupt a program run by a rebase "exec"
> command then SIGINT will also be sent to the git process running the
> rebase resulting in it being killed. Fortunately the consequences of
> this are not severe as all the state necessary to continue the rebase is
> saved to disc but it would be better to avoid killing git and instead
> report that the command failed. A similar situation occurs when the
> sequencer runs "git commit" or "git merge". If the user generates SIGINT
> while editing the commit message then the git processes creating the
> commit will ignore it but the git process running the rebase will be
> killed.
>
> Fix this by ignoring SIGINT and SIGQUIT when forking "exec" commands,
> "git commit" and "git merge". This matches what git already does when
> running the user's editor and matches the behavior of the standard
> library's system() function.

ACK

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>     rebase -i: ignore signals when forking subprocesses
>
>     Having written this I started thinking about what happens when we fo=
rk
>     hooks, merge strategies and merge drivers. I now wonder if it would =
be
>     better to change run_command() instead - are there any cases where w=
e
>     actually want git to be killed when the user interrupts a child proc=
ess?

I am not sure that we can rely on arbitrary hooks to do the right thing
upon Ctrl+C, which is to wrap up and leave. So I _guess_ that we will have
to leave it an opt-in.

However, we could easily make it an option that `run_command()` handles,
much like `no_stdin`.

Ciao,
Johannes

>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1581%2=
Fphillipwood%2Fsequencer-subprocesses-ignore-sigint-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1581/phil=
lipwood/sequencer-subprocesses-ignore-sigint-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1581
>
>  sequencer.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index a66dcf8ab26..26d70f68454 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1059,6 +1059,7 @@ static int run_git_commit(const char *defmsg,
>  			  unsigned int flags)
>  {
>  	struct child_process cmd =3D CHILD_PROCESS_INIT;
> +	int res;
>
>  	if ((flags & CLEANUP_MSG) && (flags & VERBATIM_MSG))
>  		BUG("CLEANUP_MSG and VERBATIM_MSG are mutually exclusive");
> @@ -1116,10 +1117,16 @@ static int run_git_commit(const char *defmsg,
>  	if (!(flags & EDIT_MSG))
>  		strvec_push(&cmd.args, "--allow-empty-message");
>
> +	sigchain_push(SIGINT, SIG_IGN);
> +	sigchain_push(SIGQUIT, SIG_IGN);
>  	if (is_rebase_i(opts) && !(flags & EDIT_MSG))
> -		return run_command_silent_on_success(&cmd);
> +		res =3D run_command_silent_on_success(&cmd);
>  	else
> -		return run_command(&cmd);
> +		res =3D run_command(&cmd);
> +	sigchain_pop(SIGINT);
> +	sigchain_pop(SIGQUIT);
> +
> +	return res;
>  }
>
>  static int rest_is_empty(const struct strbuf *sb, int start)
> @@ -3628,10 +3635,14 @@ static int do_exec(struct repository *r, const c=
har *command_line)
>  	struct child_process cmd =3D CHILD_PROCESS_INIT;
>  	int dirty, status;
>
> +	sigchain_push(SIGINT, SIG_IGN);
> +	sigchain_push(SIGQUIT, SIG_IGN);
>  	fprintf(stderr, _("Executing: %s\n"), command_line);
>  	cmd.use_shell =3D 1;
>  	strvec_push(&cmd.args, command_line);
>  	status =3D run_command(&cmd);
> +	sigchain_pop(SIGINT);
> +	sigchain_pop(SIGQUIT);
>
>  	/* force re-reading of the cache */
>  	discard_index(r->index);
> @@ -4111,7 +4122,11 @@ static int do_merge(struct repository *r,
>  				NULL, 0);
>  		rollback_lock_file(&lock);
>
> +		sigchain_push(SIGINT, SIG_IGN);
> +		sigchain_push(SIGQUIT, SIG_IGN);
>  		ret =3D run_command(&cmd);
> +		sigchain_pop(SIGINT);
> +		sigchain_pop(SIGQUIT);
>
>  		/* force re-reading of the cache */
>  		if (!ret) {
>
> base-commit: 1fc548b2d6a3596f3e1c1f8b1930d8dbd1e30bf3
> --
> gitgitgadget
>

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E5FC433EF
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 02:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiAACHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 21:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiAACHB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 21:07:01 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8815DC061574
        for <git@vger.kernel.org>; Fri, 31 Dec 2021 18:07:01 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so9747074pji.3
        for <git@vger.kernel.org>; Fri, 31 Dec 2021 18:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MFLAVbxBCGA8AmuW52+JcN5VgGhIS+pvnfdusF2XRr4=;
        b=mkS7SWCM+47QG1F6dW8eVXRbcDdPcJJ4Mql7gfNhMpzx6SZfvxi3HCxWAX098zwDiv
         UfOtBHsH16yt+xitNIAKLY7dylCC1HuJNb9NVL5I+p3VJMhB/Lfa8KJiP2vvPMdPjJNR
         RwoKmzCDGsJ73C5CVMvhBUCJSRWFTTv2IFiADXaTgDwNbWSRf0+uHRDweP7Ry8fJUBAd
         86buXYyVlpADr791Kt6DzZilBYI9Tlde2VLXeTv5hvBCZlKbN7ZxqA1XS4nIaTy1FF4n
         zJOoI4GQW1l1ZoY/k0j1aRPhij9xb+kfmRekPoenYjE+as7gcZL/bfBzKirJW4Ic78Uc
         GyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MFLAVbxBCGA8AmuW52+JcN5VgGhIS+pvnfdusF2XRr4=;
        b=7SSd4826KQAiP8uNeZ64pfPURqDGR+iwCXO7OOLeQEL/jHPSvBe2QnI4omWT3ulfw4
         UFYaRp+J4DozZjm2QARDQWvlxwQ+Sl9g2zbJW4qb8y1Z3Rq2mBB+ub3mwVcdkQxEAVyH
         /ChmLmdANTxQrrWoDeqSjthn+EgJGU7AbPo+5IbviXqAEIJ+ap69hwK9/c7YtydB2oe0
         lw4HEENTHb4zNMxgDLSDS2K7bbrfQKxDhxCNp4fqV0ZyeK41Uap7wZg1Gknrg1SEMe18
         WcTQNXVVwj64Zpdp6ocEzxxfS3OlEH/ei8uSvS4x5REzvXPMcjyM+6pOxHtJzwrtALlY
         8R7A==
X-Gm-Message-State: AOAM530Z8viGxqsh0+k4RESIx3cvFUWwS+W/Bx5SGxpZD3HAUxjlgp7a
        Jh9H0c32IbLtrDuCufXS/SaExnNLBeg=
X-Google-Smtp-Source: ABdhPJyTenhhpI+pCLC2dPiyF4MovnW4KrY9p02fnT5oR7sqE+fgGEdwS+sfBeDiwzvGLwsqCk17cw==
X-Received: by 2002:a17:90a:dd42:: with SMTP id u2mr40837754pjv.148.1641002820978;
        Fri, 31 Dec 2021 18:07:00 -0800 (PST)
Received: from smtpclient.apple (104-13-226-1.lightspeed.irvnca.sbcglobal.net. [104.13.226.1])
        by smtp.gmail.com with ESMTPSA id nv2sm32152268pjb.12.2021.12.31.18.07.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Dec 2021 18:07:00 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH 1/2] builtin/reflog.c: use parse-options for expire
 subcommand
From:   John Cai <johncai86@gmail.com>
In-Reply-To: <9bd3c6672c4232e0a5c0905b834146ca02af8a4b.1640932151.git.gitgitgadget@gmail.com>
Date:   Fri, 31 Dec 2021 18:06:58 -0800
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C9B7D67-D21C-44EA-B3FB-9605968AD0FF@gmail.com>
References: <pull.1175.git.git.1640932151.gitgitgadget@gmail.com>
 <9bd3c6672c4232e0a5c0905b834146ca02af8a4b.1640932151.git.gitgitgadget@gmail.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Dec 30, 2021, at 10:29 PM, John Cai via GitGitGadget =
<gitgitgadget@gmail.com> wrote:
>=20
> From: John Cai <johncai86@gmail.com>
>=20
> Switch out manual argv parsing for the reflog expire subcommand to use
> the parse-options API.
>=20
> Signed-off-by: "John Cai" <johncai86@gmail.com>
> ---
> builtin/reflog.c | 72 ++++++++++++++++++++++++------------------------
> 1 file changed, 36 insertions(+), 36 deletions(-)
>=20
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 175c83e7cc2..afaf5ba67e2 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -11,13 +11,8 @@
> #include "revision.h"
> #include "reachable.h"
> #include "worktree.h"
> +#include "parse-options.h"
>=20
> -/* NEEDSWORK: switch to using parse_options */
> -static const char reflog_expire_usage[] =3D
> -N_("git reflog expire [--expire=3D<time>] "
> -   "[--expire-unreachable=3D<time>] "
> -   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] "
> -   "[--verbose] [--all] <refs>...");
> static const char reflog_delete_usage[] =3D
> N_("git reflog delete [--rewrite] [--updateref] "
>    "[--dry-run | -n] [--verbose] <refs>...");
> @@ -539,6 +534,14 @@ static void set_reflog_expiry_param(struct =
cmd_reflog_expire_cb *cb, int slot, c
> 		cb->expire_unreachable =3D =
default_reflog_expire_unreachable;
> }
>=20
> +static const char * reflog_expire_usage[] =3D {
> +	N_("git reflog expire [--expire=3D<time>] "
> +   "[--expire-unreachable=3D<time>] "
> +   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] "
> +   "[--verbose] [--all] <refs>..."),
> +	NULL
> +};
> +
> static int cmd_reflog_expire(int argc, const char **argv, const char =
*prefix)
> {
> 	struct expire_reflog_policy_cb cb;
> @@ -547,6 +550,29 @@ static int cmd_reflog_expire(int argc, const char =
**argv, const char *prefix)
> 	int explicit_expiry =3D 0;
> 	unsigned int flags =3D 0;
>=20
> +	const struct option options[] =3D {
> +		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune =
any entries"),
> +				EXPIRE_REFLOGS_DRY_RUN),
> +		OPT_BIT(0, "rewrite", &flags,
> +				N_("rewrite the old SHA1 with the new =
SHA1 of the entry that now precedes it"),
> +				EXPIRE_REFLOGS_REWRITE),
> +		OPT_BIT(0, "updateref", &flags,
> +				N_("update the reference to the value of =
the top reflog entry"),
> +				EXPIRE_REFLOGS_UPDATE_REF),
> +		OPT_BIT(0, "verbose", &flags, N_("print extra =
information on screen."),
> +				EXPIRE_REFLOGS_VERBOSE),
> +		OPT_EXPIRY_DATE(0, "expire", &cb.cmd.expire_total,
> +				N_("prune entries older than the =
specified time")),
> +		OPT_EXPIRY_DATE(0, "expire-unreachable", =
&cb.cmd.expire_unreachable,
> +			N_("prune entries older than <time> that are not =
reachable from the current tip of the branch")),
> +		OPT_BOOL(0, "stale-fix", &cb.cmd.stalefix,
> +				N_("prune any reflog entries that point =
to broken commits")),
> +		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of =
all references")),
> +		OPT_BOOL(1, "single-worktree", &all_worktrees,
> +				N_("limits processing to reflogs from =
the current worktree only.")),
> +		OPT_END()
> +	};
> +
> 	default_reflog_expire_unreachable =3D now - 30 * 24 * 3600;
> 	default_reflog_expire =3D now - 90 * 24 * 3600;
> 	git_config(reflog_expire_config, NULL);
> @@ -560,41 +586,15 @@ static int cmd_reflog_expire(int argc, const =
char **argv, const char *prefix)
>=20
> 	for (i =3D 1; i < argc; i++) {

I was hoping we could get rid of this for loop altogether, but I =
couldn=E2=80=99t figure out a clean way since --expire and =
expire-unreachable
take a value __and__ set a flag bit. So I kept this for loop for the =
sole purpose of setting the explicit_expiry bit flag. Any suggestions?

> 		const char *arg =3D argv[i];
> -
> -		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
> -			flags |=3D EXPIRE_REFLOGS_DRY_RUN;
> -		else if (skip_prefix(arg, "--expire=3D", &arg)) {
> -			if (parse_expiry_date(arg, =
&cb.cmd.expire_total))
> -				die(_("'%s' is not a valid timestamp"), =
arg);
> +		if (starts_with(arg, "--expire=3D")) {
> 			explicit_expiry |=3D EXPIRE_TOTAL;
> -		}
> -		else if (skip_prefix(arg, "--expire-unreachable=3D", =
&arg)) {
> -			if (parse_expiry_date(arg, =
&cb.cmd.expire_unreachable))
> -				die(_("'%s' is not a valid timestamp"), =
arg);
> +		} else if (starts_with(arg, "--expire-unreachable=3D")) =
{
> 			explicit_expiry |=3D EXPIRE_UNREACH;
> 		}
> -		else if (!strcmp(arg, "--stale-fix"))
> -			cb.cmd.stalefix =3D 1;
> -		else if (!strcmp(arg, "--rewrite"))
> -			flags |=3D EXPIRE_REFLOGS_REWRITE;
> -		else if (!strcmp(arg, "--updateref"))
> -			flags |=3D EXPIRE_REFLOGS_UPDATE_REF;
> -		else if (!strcmp(arg, "--all"))
> -			do_all =3D 1;
> -		else if (!strcmp(arg, "--single-worktree"))
> -			all_worktrees =3D 0;
> -		else if (!strcmp(arg, "--verbose"))
> -			flags |=3D EXPIRE_REFLOGS_VERBOSE;
> -		else if (!strcmp(arg, "--")) {
> -			i++;
> -			break;
> -		}
> -		else if (arg[0] =3D=3D '-')
> -			usage(_(reflog_expire_usage));
> -		else
> -			break;
> 	}
>=20
> +	argc =3D parse_options(argc, argv, prefix, options, =
reflog_expire_usage, 0);
> +
> 	/*
> 	 * We can trust the commits and objects reachable from refs
> 	 * even in older repository.  We cannot trust what's reachable
> --=20
> gitgitgadget
>=20


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59310C4708C
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 14:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiLEOYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 09:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiLEOXy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 09:23:54 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3144EB1E
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 06:23:50 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3cbdd6c00adso119212137b3.11
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 06:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqm8Nt7V5j7P8bIp7roACStT7e6askjtet/NbGWnFa0=;
        b=axp/ehdiccbRscJlAss7IEOW6/8IQH3CT88i329/A9hVCKc/I1yqsoVCfb71taVeGx
         fIGbpzO7XMeaj7cgwoh8wF8cjxAi2m0/eX8AVWyzfCQwwlJ/syonaGWrYyDJ8DMjS9SF
         /h+ncJfUrA5Y6tROzUm0jyTndqPHe8VjbNDOeAj27TsAl9EyZya8WTB4LYaiL56BHFeX
         HE2h0ykA1fzExlMqyjCeFzhZ1tR2WukrhmjKUUgqJGrxjAqfq/6qfenpjX1cJ9N6on8h
         ohXV6G8+CevQ93o65qkE8F+siy58xV7ORTbGfrpmxloxokztoFPUCxjpNdxfIs00Yc9Z
         1BPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqm8Nt7V5j7P8bIp7roACStT7e6askjtet/NbGWnFa0=;
        b=mq08bGuKbaOAVPEQ6yygX0gOi0oyIX8a0sfyahLqRneRqK5Y/7K6hE+6X0hLldLtLT
         8ug20b1fSYfBK0ta45baiyfPExT70/40LrttuX6DuXotNz9TrjvejSrZgU4r3/S1rUuc
         UJHq7GU9gRdHiOj0Y1x1KlZHj853p3xjVdMdZAjDd1RsAfDK2bk5L/oDsmktrhTwttxt
         9bO1C7TtNFBCKr2MWLCajh1DVktuEKO6b0EKpFc7RamRkv1NzN5rGq8ynW5Cu/hM9N0I
         WYjD63uIjh6+Ykl0b1mcrL7Y30ZakRGfaHCoB3K9IFhvFOt4YxIu8mcLjgfUKaVPn9Wu
         ZHNA==
X-Gm-Message-State: ANoB5pk4v7OAKKAtjtiuN4z6cHGPTwxb6WQT4oFVUOgbFQD4HnG/QGx0
        2SPs1xMzvn2o8uoC4oty/972yz+oo9y+74tVNl4=
X-Google-Smtp-Source: AA0mqf77cTHRjQByRazE/NYyk7zJlep+2XnsqsELf7vlktAUze2jRzEopUgHCXpkfhG2dxH9cacfBR8cViAj1cnmTk8=
X-Received: by 2002:a81:4ec8:0:b0:3b1:ef5d:ab0d with SMTP id
 c191-20020a814ec8000000b003b1ef5dab0dmr52676823ywb.43.1670250229691; Mon, 05
 Dec 2022 06:23:49 -0800 (PST)
MIME-Version: 1.0
References: <20221205133525.60464-1-tenglong.tl@alibaba-inc.com> <20221205133525.60464-2-tenglong.tl@alibaba-inc.com>
In-Reply-To: <20221205133525.60464-2-tenglong.tl@alibaba-inc.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 5 Dec 2022 22:23:38 +0800
Message-ID: <CAOLTT8QcvPfXKap2aa6iyi0jq-cySL=XjDP2G2wG8m57=u0aGw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] push: introduce '--heads' option
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, --cc=avarab@gmail.com,
        tenglong.tl@alibaba-inc.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Teng Long <dyroneteng@gmail.com> =E4=BA=8E2022=E5=B9=B412=E6=9C=885=E6=97=
=A5=E5=91=A8=E4=B8=80 21:44=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Teng Long <dyroneteng@gmail.com>
>
> The '--all' option of git-push built-in cmd support to push all branches
> (refs under refs/heads) to remote. Under the usage, a user can easlily
> work in some scenarios, for example, branches synchronization and batch
> upload.
>
> '--all' was introduced for a long time, meanwhile, git supports to
> customize the storage location under "refs/". when a new git user see
> the usage like, 'git push origin --all', we might feel like we're
> pushing _all_ the refs instead of just branches without looking at the
> documents until we found the related description of it or '--mirror'.
>

"--all" sounds like it will include all things: branches, tags, but it only
includes branches under ref/heads/, which does cause a little confusion
for users.

> To ensure compatibility, we cannot rename '--all' to another name
> directly, one way is, we can try to add a new option '--heads' which be
> identical with the functionality of '--all' to let the user understand
> the meaning of representation more clearly. Actually, We've more or less
> named options this way already, for example, in 'git-show-ref' and 'git
> ls-remote'.
>
> At the same time, we fix a related issue about the wrong help
> information of '--all' option in code.
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  Documentation/git-push.txt |  1 +
>  builtin/push.c             | 13 +++++++------
>  t/t5523-push-upstream.sh   | 19 ++++++++++++-------
>  3 files changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 5bb1d5aae25..a5d18fb90b6 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -147,6 +147,7 @@ already exists on the remote side.
>  `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
>
>  --all::
> +--heads::
>         Push all branches (i.e. refs under `refs/heads/`); cannot be
>         used with other <refspec>.
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 60ac8017e52..970cabaa78b 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -588,11 +588,12 @@ int cmd_push(int argc, const char **argv, const cha=
r *prefix)
>         struct option options[] =3D {
>                 OPT__VERBOSITY(&verbosity),
>                 OPT_STRING( 0 , "repo", &repo, N_("repository"), N_("repo=
sitory")),
> -               OPT_BIT( 0 , "all", &flags, N_("push all refs"), TRANSPOR=
T_PUSH_ALL),
> +               OPT_BIT( 0 , "all", &flags, N_("push all branches"), TRAN=
SPORT_PUSH_ALL),
> +               OPT_BIT( 0 , "heads", &flags, N_("push all branches"), TR=
ANSPORT_PUSH_ALL),

Maybe OPT_ALIAS() will be better?

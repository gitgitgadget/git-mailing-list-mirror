Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217A9C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 15:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbiEXPVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 11:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238878AbiEXPVP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 11:21:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EFB19290
        for <git@vger.kernel.org>; Tue, 24 May 2022 08:21:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s3so23477848edr.9
        for <git@vger.kernel.org>; Tue, 24 May 2022 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HTN05O3MkeyE28Y2bwNHHsK7660VM7o7vjqbd1QV4Lc=;
        b=XRSQcFZf2Le6rprwvOMtqu70xvyNIfpyk9d2//vingxk8ghhDWt1yfo3pUVHz5WiPG
         +ihrSpgoyBD4SPXcxwqTL9ySCUcGpmpis+fWLdT6ICNLIVBI5x17YqmtwBJCQELPoZV/
         iQGlaBi37vp2bOY9Axo/OQlZPi6POGUaCxyj7G08g+PdAZlAAA5MDbVlrr1dRko5mSpG
         6OkRmjc0+mSYf+z+GtiOCoUZEsmtIktV/SUEIQGnyv7v/nO8O86c9pGoMVtzG4sgpVe4
         qd70SCCywhXXUFCoHsN2ijbkwABajcylxifDltoVOSpXiDgSApACm6nMeob5wbBvPW/e
         XvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HTN05O3MkeyE28Y2bwNHHsK7660VM7o7vjqbd1QV4Lc=;
        b=jk5bllj3STJanB85IBEfImaUxg1dUqiHDyzRAZIXQpF1/A+/CDtoTPhx8l3t6nTq5y
         8sDbq4Z1PZG8141Ujbmi5EF46fUDnxC4UD88l0fz9lgs1t35i3w35utEmZBD+pecbUfp
         zZKENmbe3zoSaCCuHcPceHCGr6KJLOl2kpftIQCzbJ3A7+kByZeFhXfvj8FlaZRzpGMs
         9oiiVvj5QITNyTskMA6dDSaY2mk3sMT+OVCHRD1h1E+YZomF//eNO8l5/nuE2jEvTdv0
         Yg35LZs3ZCGqz13ke0q4syuL8vpi+vKQ9O0dOS6TvRsSh0uXmAvk5Sz24ieDAHsbIgoH
         wqdg==
X-Gm-Message-State: AOAM533GHphGcz2qQr7SyqJBPnMq8vJ/HBmvbppZms5Yr0rgIRp6mSfs
        or8ogqhQSsUwW9edfcih2Jze9fxso8AxvhewT0E=
X-Google-Smtp-Source: ABdhPJy+rwxIIHt8tPSOo5BWQ1FmqkrhsfGeKqrHBZbK1djHeTJ4RK4CBREy7u5e3a/jR355n63PczO80uPMP6txP+E=
X-Received: by 2002:a05:6402:1910:b0:42b:5046:7f88 with SMTP id
 e16-20020a056402191000b0042b50467f88mr15211373edz.319.1653405672537; Tue, 24
 May 2022 08:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <7c064f43ed426c9e3b54e1ae5313d6b9332a47cb.1653141169.git.kevin@kevinlocke.name>
 <68c66aef7ca4dba53faec9e6d2f3b70fe58ac33e.1653403877.git.kevin@kevinlocke.name>
In-Reply-To: <68c66aef7ca4dba53faec9e6d2f3b70fe58ac33e.1653403877.git.kevin@kevinlocke.name>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 24 May 2022 08:21:01 -0700
Message-ID: <CABPp-BHHMUJdKbj31B-5Ov0xQLeyAqJOQiHxT_Z_9zXbYEcZRA@mail.gmail.com>
Subject: Re: [PATCH v3] setup: don't die if realpath(3) fails on getcwd(3)
To:     Kevin Locke <kevin@kevinlocke.name>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2022 at 7:51 AM Kevin Locke <kevin@kevinlocke.name> wrote:
>
> Prior to Git 2.35.0, git could be run from an inaccessible working
> directory so long as the git repository specified by options and/or
> environment variables was accessible.  For example:
>
>     git init repo
>     mkdir -p a/b
>     cd a/b
>     chmod u-x ..
>     git -C "${PWD%/a/b}/repo" status
>
> If this example seems a bit contrived, consider running with the
> repository owner as a substitute UID (e.g. with runuser(1) or sudo(8))
> without ensuring the working directory is accessible by that user.
>
> The code added by e6f8861bd4 ("setup: introduce
> startup_info->original_cwd") to preserve the working directory attempts
> to normalize the path using strbuf_realpath().  If that fails, as in the
> case above, it is treated as a fatal error.
>
> This commit treats strbuf_realpath() errors as non-fatal.  If an error
> occurs, setup_original_cwd() will continue without applying removal
> prevention for cwd, resulting in the pre-2.35.0 behavior.  The risk
> should be minimal, since git will not operate on a repository with
> inaccessible ancestors, this behavior is only known to occur when cwd is
> a descendant of the repository, an ancestor of cwd is inaccessible, and
> no ancestors of the repository are inaccessible.
>
> Signed-off-by: Kevin Locke <kevin@kevinlocke.name>
> ---
>
> Notes:
> Changes since v2:
>  * Use trace2_data_string(), rather than trace_printf(), to report
>    realpath failure.
>
> Changes since v1:
>  * Set startup_info->original_cwd = NULL when strbuf_realpath() fails,
>    rather than setting it to the un-normalized path.
>  * Add a trace message when realpath fails to aid debugging.
>  * Remove potential realpath failure cause from comment before it.
>  * Improve format for reference to e6f8861bd4 in commit message.
>  * Clarify when the pre-2.35.0 behavior may occur as a result of this
>    commit in the commit message.
>  * Remove 'Fixes:' tag from commit message.
>
>  setup.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index a7b36f3ffbf..38bd55cbac1 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -458,11 +458,19 @@ static void setup_original_cwd(void)
>          *     not startup_info->original_cwd.
>          */
>
> -       /* Normalize the directory */
> -       strbuf_realpath(&tmp, tmp_original_cwd, 1);
> -       free((char*)tmp_original_cwd);
> -       tmp_original_cwd = NULL;
> -       startup_info->original_cwd = strbuf_detach(&tmp, NULL);
> +       /* Try to normalize the directory. */
> +       if (strbuf_realpath(&tmp, tmp_original_cwd, 0)) {
> +               free((char*)tmp_original_cwd);
> +               tmp_original_cwd = NULL;
> +               startup_info->original_cwd = strbuf_detach(&tmp, NULL);
> +       } else {
> +               trace2_data_string("setup", the_repository,
> +                                  "realpath-path", tmp_original_cwd);
> +               trace2_data_string("setup", the_repository,
> +                                  "realpath-failure", strerror(errno));
> +               tmp_original_cwd = NULL;
> +               goto no_prevention_needed;
> +       }
>
>         /*
>          * Get our worktree; we only protect the current working directory
> --
> 2.35.1

Looks good to me:

Reviewed-by: Elijah Newren <newren@gmail.com>

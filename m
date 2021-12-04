Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B48BC433EF
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 18:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbhLDSrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 13:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352475AbhLDSpc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 13:45:32 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FCAC061751
        for <git@vger.kernel.org>; Sat,  4 Dec 2021 10:42:06 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r25so25092330edq.7
        for <git@vger.kernel.org>; Sat, 04 Dec 2021 10:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dTz+H/x7dBVSuWEN+672kMc/JmxXG9AarxUdKRbyjUA=;
        b=c31S2tAbsZx7PZjI4OeGxs8dLRdmaJ7g7qlW0ajRxPlKlS7sekmBufxuN3SbVHZsiW
         hOwosgORgzhUO+FbvvcKzvsJRj8iIrhi6XRYibM7tvDDrOTJbPw39F6YpoSf3ZdvoG0u
         aFYf3LrdPl23ty77uSO5Uff9OJrpDB06OlrVdljLUCHQhqjeYGPny43ulCDDSi7ytbF9
         1wfvcIdHENM8LpmMIgU7reCWMImt1Li2rP8nPhIF/bDb9POBi88wSM0xti+M4QSfC7aw
         +kXk+9jB57vH7jdACwa4ofnvrjxxDc4F9cyLYIo3rRWXRGU0LnoCRa8qMH3MJb8nzYze
         HXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dTz+H/x7dBVSuWEN+672kMc/JmxXG9AarxUdKRbyjUA=;
        b=R8Xy3rXM7WCKOLXkePxtyrCInwd6MWc4yikqrhsNkT6o4oly7dPhii4lJMoZvHMYAv
         0oE3mG40q8Qmcsm9PU3Il9L+CMA2XCGVvsTbvQRXaH8MAcRU9PHVxtUx4JDXml5e1aJ0
         7j1xuDDQSmhl7Ci7Cme8JsL9eHWRjGaTCM+T8flBRC8q7NnZ21ziyzcseeVQ8GDDWHD/
         uEgKohow7E3AVi4yOZzY2JPcUtEqEMMKI0SEjTIC80DRvEjl1oJ8ZB+o/ahAds85pag9
         spS+HdvpXLQwcOwm3LHesTsGWxHA+7/xUOUO1tTaAyBb20mqg8kebYrMsp89ee/Lr6J8
         zm+Q==
X-Gm-Message-State: AOAM532zq0dVjoXbKl1PsL0sA9OPFo5BvQvQpRwDAzUugFGJ9C7be9HW
        7p4S3V0Ip7PtxOS7cP0TbxLJYbvBNK1dQy+V0kC+P/2X
X-Google-Smtp-Source: ABdhPJxoAmWCKAa/i9oEUhgF0ckg3ipUnKFrpu9vOKVnrMBNX9Jo2mfZtvdSMJW/vMJDO7I9zWqW3naigYdsDBTynH4=
X-Received: by 2002:a05:6402:d73:: with SMTP id ec51mr37191888edb.175.1638643325178;
 Sat, 04 Dec 2021 10:42:05 -0800 (PST)
MIME-Version: 1.0
References: <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
 <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com> <09c2ff9f89833b3ac918a399e10d1b6abe71b339.1638566165.git.gitgitgadget@gmail.com>
In-Reply-To: <09c2ff9f89833b3ac918a399e10d1b6abe71b339.1638566165.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 4 Dec 2021 10:41:53 -0800
Message-ID: <CABPp-BEN2m9bqhQ+bDOa75-OWaZjXs7dv-=VBQTY9_O2LYGkJA@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] git: esnure correct git directory setup with -h
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 3, 2021 at 1:16 PM Lessley Dennington via GitGitGadget
<gitgitgadget@gmail.com> wrote:

Simple typo in the subject of the commit message: "esnure" -> "ensure"

> From: Lessley Dennington <lessleydennington@gmail.com>
>
> Ensure correct git directory setup when -h is passed with commands. This
> specifically applies to repos with special help text configuration
> variables and to commands run with -h outside a repository. This
> will also protect against test failures in the upcoming change to BUG in
> prepare_repo_settings if no git directory exists.
>
> Note: this diff is better seen when ignoring whitespace changes.
>
> Co-authored-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
> ---
>  git.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/git.c b/git.c
> index 60c2784be45..03a2dfa5174 100644
> --- a/git.c
> +++ b/git.c
> @@ -421,27 +421,28 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>         int status, help;
>         struct stat st;
>         const char *prefix;
> -
> +       int run_setup = (p->option & (RUN_SETUP | RUN_SETUP_GENTLY));
>         prefix = NULL;
>         help = argc == 2 && !strcmp(argv[1], "-h");
> -       if (!help) {
> -               if (p->option & RUN_SETUP)
> -                       prefix = setup_git_directory();
> -               else if (p->option & RUN_SETUP_GENTLY) {
> -                       int nongit_ok;
> -                       prefix = setup_git_directory_gently(&nongit_ok);
> -               }
> -               precompose_argv_prefix(argc, argv, NULL);
> -               if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &&
> -                   !(p->option & DELAY_PAGER_CONFIG))
> -                       use_pager = check_pager_config(p->cmd);
> -               if (use_pager == -1 && p->option & USE_PAGER)
> -                       use_pager = 1;
> -
> -               if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) &&
> -                   startup_info->have_repository) /* get_git_dir() may set up repo, avoid that */
> -                       trace_repo_setup(prefix);
> +       if (help && (run_setup & RUN_SETUP))
> +               /* demote to GENTLY to allow 'git cmd -h' outside repo */
> +               run_setup = RUN_SETUP_GENTLY;
> +
> +       if (run_setup & RUN_SETUP)
> +               prefix = setup_git_directory();
> +       else if (run_setup & RUN_SETUP_GENTLY) {
> +               int nongit_ok;
> +               prefix = setup_git_directory_gently(&nongit_ok);
>         }
> +       precompose_argv_prefix(argc, argv, NULL);
> +       if (use_pager == -1 && run_setup &&
> +               !(p->option & DELAY_PAGER_CONFIG))
> +               use_pager = check_pager_config(p->cmd);
> +       if (use_pager == -1 && p->option & USE_PAGER)
> +               use_pager = 1;
> +       if (run_setup && startup_info->have_repository)
> +               /* get_git_dir() may set up repo, avoid that */
> +               trace_repo_setup(prefix);
>         commit_pager_choice();
>
>         if (!help && get_super_prefix()) {
> --
> gitgitgadget

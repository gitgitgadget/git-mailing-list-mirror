Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECBE020248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfCHJUk (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:20:40 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54017 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfCHJUk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:20:40 -0500
Received: by mail-it1-f195.google.com with SMTP id v2so19842563ith.3
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9e3zevfBPlfFxQRRByGKEB13tEWE9r3Y4d2DT7MSnsk=;
        b=KCFsOpfzU4EZn/uhNE+bBCd5UOKNTsJPiKwAn6nDb5in4BDmQ9SQH0QS4Ie3gGo50g
         oknag/1n7ZQ6JLtodFmnaH9vdx0DgiA1feVnmk5eQRxqFkJDY5/SsGej1SaXYJW0IbW9
         NJ53xu/DOxOUJ+XXf8OUtzvHh6GFumTpBTOcMgkmUCmEzkRcYpgWLUAf9KunvO5f4ohj
         jMy255zVlIraH/3RKk7O0UxomLJX9+WYCNU31XHOnvHQa+TzsvgyMprSOL9KE70pAbSB
         LSheSUN3OhspLn643r00t9JoYjCbzMz2Eh2hovq0X7gyQSl6OHZKMnNHPYg5mSe+l0Lm
         Hryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9e3zevfBPlfFxQRRByGKEB13tEWE9r3Y4d2DT7MSnsk=;
        b=pK6KQ2rUaTTHDOfxH6m1BggBDbuPEMdWW31j1R1JmVaxSxv4QVIfsLrITgLnnW+gk1
         tfkN0A7Mn2ww5WNtiqX5c5sOJLvX3mKMzjWFgoXhMF/yNvvk6bWuia9qWziL8+V3KEkx
         kqUBMl5xj5D6UvkD4ZNfoaVcbFFIVcZYycKqr+kVI6MxW12Ro0Wh536jPN6D8GqJXzWQ
         KbhttIyMzRmqEfLypAzM1nkNbdukC1Y8ObB0FtVKCKAU9rTtobWzpCivuajUEKIAUO96
         uMrkrSWd7EwaGg3Z84K3ycn+XO2nhpnnTsmbhlIXqj8GXe1532t41ArtkUFFOZCzhktd
         AltQ==
X-Gm-Message-State: APjAAAXuKu4sP/PucdWLc3Ir41ock4jCYg2mpm7QxtdKQO1WQ3m7bIyL
        TERO4OVmTV1K4DssreJKQaRA5gcREc1DZiiN1Ps=
X-Google-Smtp-Source: APXvYqwqJZye7mYele9d+mb0NVLTlXHp25mPPh77ra439Q9DPgp2P0ih0z/vSf+gNGGT+ZmEiN2NGQh5BGGOI7LkvEY=
X-Received: by 2002:a02:568a:: with SMTP id u10mr10208101jad.130.1552036839351;
 Fri, 08 Mar 2019 01:20:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550508544.git.msuchanek@suse.de> <e134801d570d0a0c85424eb80b41893f4d8383ca.1550679076.git.msuchanek@suse.de>
In-Reply-To: <e134801d570d0a0c85424eb80b41893f4d8383ca.1550679076.git.msuchanek@suse.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 8 Mar 2019 16:20:13 +0700
Message-ID: <CACsJy8D_ahM_7mLaAijJsZ0e8BF6PBfr3pPisOnYmRH7U8kmqA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] worktree: fix worktree add race.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michal Suchanek <msuchanek@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Marketa Calabkova <mcalabkova@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio, it seems 2/2 is stuck in an endless discussion. But 1/2 is good
regardless, maybe pick it up now and let 2/2 come later whenever it's
ready?

On Wed, Feb 20, 2019 at 11:16 PM Michal Suchanek <msuchanek@suse.de> wrote:
>
> Git runs a stat loop to find a worktree name that's available and then does
> mkdir on the found name. Turn it to mkdir loop to avoid another invocation of
> worktree add finding the same free name and creating the directory first.
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v2:
> - simplify loop exit condition
> - exit early if the mkdir fails for reason other than already present
> worktree
> - make counter unsigned
> ---
>  builtin/worktree.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 3f9907fcc994..85a604cfe98c 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -268,10 +268,10 @@ static int add_worktree(const char *path, const char *refname,
>         struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
>         struct strbuf sb = STRBUF_INIT;
>         const char *name;
> -       struct stat st;
>         struct child_process cp = CHILD_PROCESS_INIT;
>         struct argv_array child_env = ARGV_ARRAY_INIT;
> -       int counter = 0, len, ret;
> +       unsigned int counter = 0;
> +       int len, ret;
>         struct strbuf symref = STRBUF_INIT;
>         struct commit *commit = NULL;
>         int is_branch = 0;
> @@ -295,8 +295,12 @@ static int add_worktree(const char *path, const char *refname,
>         if (safe_create_leading_directories_const(sb_repo.buf))
>                 die_errno(_("could not create leading directories of '%s'"),
>                           sb_repo.buf);
> -       while (!stat(sb_repo.buf, &st)) {
> +
> +       while (mkdir(sb_repo.buf, 0777)) {
>                 counter++;
> +               if ((errno != EEXIST) || !counter /* overflow */)
> +                       die_errno(_("could not create directory of '%s'"),
> +                                 sb_repo.buf);
>                 strbuf_setlen(&sb_repo, len);
>                 strbuf_addf(&sb_repo, "%d", counter);
>         }
> @@ -306,8 +310,6 @@ static int add_worktree(const char *path, const char *refname,
>         atexit(remove_junk);
>         sigchain_push_common(remove_junk_on_signal);
>
> -       if (mkdir(sb_repo.buf, 0777))
> -               die_errno(_("could not create directory of '%s'"), sb_repo.buf);
>         junk_git_dir = xstrdup(sb_repo.buf);
>         is_junk = 1;
>
> --
> 2.20.1
>


-- 
Duy

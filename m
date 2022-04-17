Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A718C433EF
	for <git@archiver.kernel.org>; Sun, 17 Apr 2022 02:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbiDQCGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 22:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiDQCGW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 22:06:22 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFB61A82A
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 19:03:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id u18so14044507eda.3
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 19:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lTl+qcnyAbsf9dcFPZCemNwN6X052pNKTFb9vo9HYsw=;
        b=G4IMNM7QkIPooCXBP+nLRmLVZz3reEjOUrNqbb6kslvbxbfgWOpo1wK29FKZrbib9c
         9x/JQ56APlL6JdLPzHlcVO1sx87O6H0ZUOGkZiO9xj6iGNTTg3CKiuCIDekxZPZvVOdj
         CVP7CBNB2Heao50AJsuiQQeLaMEP+5A+Ch6rPmXcbXwxQ5gOlxSsdi2yU0Tgl3/aR7Qk
         R8+u44/rhqvdL/bEGd+SGP02pftEwyXgPuOYHbnLRMizHieJ5Mc8CYvjvyYnMxY139py
         LryP2p9I/MtpDw0zWoPncJgi1KUKbXeFILMAMeU1GrS1jTPjkmuRZAZCRRbiVV89y1MU
         Z5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lTl+qcnyAbsf9dcFPZCemNwN6X052pNKTFb9vo9HYsw=;
        b=rgKQVjzN3d5N0ggiHGZIvCL664D3q+JjTRIHmaWIEH9yQXuFgboQzbvovdf7+hrox+
         C1y1sUSH1qARJttfHxADNyOZA4m0KvYCh9DgYyU59njIh/QIERWcQ+Ig4lUqBnTXJ3N+
         rVsVvcB3iB3dWB7LWhd49SgE20A/6l73v1+DhlU3k60Cdik5wDwPTeBATVg1Bx7UaSWd
         egrVhyEqVaH+4zA//2W9lrUC9VPY14CxdSIB6B4DCJS+KHHDIe1Tese71Gy8ScRn+AE2
         cAtmoweDGffCbNhYp6KPYmK+P8tUit/04iBkmr35RRi2dBlHJp5+zKDxiEVkVRFbnxbO
         ztlw==
X-Gm-Message-State: AOAM532Y/QWoEaZyOkYEY3oxJI3TVYUXeJPSmbWZ7UiP7GrcVyT6LnAz
        VYWaqodCmjvvb1RDu2QNhRL7zGumzS5fdZpFl/VIQdLk
X-Google-Smtp-Source: ABdhPJwKIEh+ZGA82ntmrM2h+W4bQQWx4oAHGM80m7F8+1hIli+WiSD4VXCpA87pJB42xWiF22XFT8fVFJ5YvQKwuYc=
X-Received: by 2002:a05:6402:1385:b0:413:2bc6:4400 with SMTP id
 b5-20020a056402138500b004132bc64400mr6183252edv.94.1650161026763; Sat, 16 Apr
 2022 19:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com> <1c3ec1654225ff090c194fa646f974082bd9c944.1645441854.git.gitgitgadget@gmail.com>
In-Reply-To: <1c3ec1654225ff090c194fa646f974082bd9c944.1645441854.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 16 Apr 2022 19:03:35 -0700
Message-ID: <CABPp-BEqjv8BVe3G5x=3wRbL9GH8GeWe4Yv2wiUse4vjWcd58w@mail.gmail.com>
Subject: Re: [PATCH 5/7] rebase --apply: make reflog messages match rebase --merge
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 21, 2022 at 3:19 PM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The apply backend creates slightly different reflog messages to the
> merge backend when starting and finishing a rebase and when picking
> commits. The choice of backend is really an implementation detail so
> it is confusing to have the same command create different messages
> depending on which backend is selected. Change the apply backend so
> the reflog messages from the two backends match as closely as
> possible. Note that there is still a difference when committing a
> conflict resolution - the merge backend will use "(continue)" rather
> than "(pick)" in that case as it does not know which command created
> the conflict that it is committing.

I've always been slightly annoyed by the various differences in these
backends; it's nice to see another one disappearing.

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/rebase.c          | 9 +++++----
>  t/t3406-rebase-message.sh | 2 +-
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index e50361fc2a9..678339c7bf7 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -580,10 +580,10 @@ static int move_to_original_branch(struct rebase_options *opts)
>         if (!opts->onto)
>                 BUG("move_to_original_branch without onto");
>
> -       strbuf_addf(&branch_reflog, "%s finished: %s onto %s",
> +       strbuf_addf(&branch_reflog, "%s (finish): %s onto %s",
>                     getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
>                     opts->head_name, oid_to_hex(&opts->onto->object.oid));
> -       strbuf_addf(&head_reflog, "%s finished: returning to %s",
> +       strbuf_addf(&head_reflog, "%s (finish): returning to %s",
>                     getenv(GIT_REFLOG_ACTION_ENVIRONMENT), opts->head_name);
>         ropts.branch = opts->head_name;
>         ropts.flags = RESET_HEAD_REFS_ONLY;
> @@ -613,7 +613,8 @@ static int run_am(struct rebase_options *opts)
>
>         am.git_cmd = 1;
>         strvec_push(&am.args, "am");
> -
> +       strvec_pushf(&am.env_array, GIT_REFLOG_ACTION_ENVIRONMENT "=%s (pick)",
> +                    getenv(GIT_REFLOG_ACTION_ENVIRONMENT));

Kinda sad that we're still forking subprocesses and passing things via
environment variable, but that's outside the scope of this series.
Fix looks fine.

>         if (opts->action && !strcmp("continue", opts->action)) {
>                 strvec_push(&am.args, "--resolved");
>                 strvec_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
> @@ -1763,7 +1764,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>                 printf(_("First, rewinding head to replay your work on top of "
>                          "it...\n"));
>
> -       strbuf_addf(&msg, "%s: checkout %s",
> +       strbuf_addf(&msg, "%s (start): checkout %s",
>                     getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
>         ropts.oid = &options.onto->object.oid;
>         ropts.orig_head = &options.orig_head,
> diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
> index bb2a4949abc..5c6cd9af3bc 100755
> --- a/t/t3406-rebase-message.sh
> +++ b/t/t3406-rebase-message.sh
> @@ -88,7 +88,7 @@ test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
>  write_reflog_expect () {
>         if test $mode = --apply
>         then
> -               sed 's/(finish)/finished/; s/ ([^)]*)//'
> +               sed 's/(continue)/(pick)/'
>         else
>                 cat
>         fi >expect
> --
> gitgitgadget

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6683CC433F5
	for <git@archiver.kernel.org>; Sun, 17 Apr 2022 02:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiDQCJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 22:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiDQCJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 22:09:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8DF31539
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 19:07:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 21so14080628edv.1
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 19:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wnhQX6x3x3T7KyxwRpXN61JmM0aSU6DTm+dMFIWx0qg=;
        b=B7taj70std3AMhUt5Gg7upiqwFhAFfufTf2rMpjiLnLjvsLkWnuztdtWXOMaVIQwDV
         KwfNZhUHQrK+FvsPKvUdBUgpwfDgVNwzLOZjJp47UAS9JrsCrq7qutL+oT8iitGx31qk
         YwAm7CA9ap5oDygQzZnNlb6aC7+LBrVyp/ueUP+KJHxIVZRHdCafsrH4Oee6dN5JHqTz
         QfG5IBoGsURRdizM9liHGOGWkYVHoj/XSqOKjHOG+3HweH4yg+3oLrvefSIqUji346Bh
         SASYvvHX1akwLxI0QAF4SxS4G6eLbUT3FwCJBjZb33C/X1FN5qyrjHykNUHtdG+VMvWx
         xbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wnhQX6x3x3T7KyxwRpXN61JmM0aSU6DTm+dMFIWx0qg=;
        b=4P6iRPvE4G9cmT/e5ijLir5DqUkLJx896UXLd2XxgU2eVzvlFUXHI5MofmaOVjLHOl
         BPuiTFUCsrcPp0l9jYe//i7q+mgzzLfFYzpSchEaE1BG1SrogUtorY9d0E8ukerBfuZv
         Y0l97aAY9/F9ThOBCcqIt8R61Tt0Oy+59OoWYt3ywD3KLms6s+Fr+2PUVkt3i3UTRg1z
         6B/CcClhatI++n+9lhT+2d78lv6R3mo/r4tVRSTWl0yXkisuoKiVLco6VMG41hcktjBV
         dMlp3y4hXL7U/Qppeq9o40Mfuq/wQasYj4OW1zDS3MG30JlCgZ+ipc9Mywq/nloSqdtX
         Z3EQ==
X-Gm-Message-State: AOAM530VcbS6CyKeggyrSoB5w2NaLk0FaY5DD6JuowqEKlMO23s/iFNL
        XmEFZCnsT5j4HsihTlLWviAnsCtWZ1QhVQ95XPY=
X-Google-Smtp-Source: ABdhPJwUavB5YE4hijSMXSzrf/smSkgdQNGHRmRsFZNKdQOQlOd2v27wgHwg4Z1bArIg1nHCa5LglSjVr51T4j87Umw=
X-Received: by 2002:aa7:cc82:0:b0:410:d2b0:1a07 with SMTP id
 p2-20020aa7cc82000000b00410d2b01a07mr6080312edt.359.1650161242011; Sat, 16
 Apr 2022 19:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com> <c863cebbdc8485225af40593cf2952c933f4ea8d.1645441854.git.gitgitgadget@gmail.com>
In-Reply-To: <c863cebbdc8485225af40593cf2952c933f4ea8d.1645441854.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 16 Apr 2022 19:07:10 -0700
Message-ID: <CABPp-BFZgtNNjSF-WS67_vZd5d3Hg0YvimhKFY6X=gNnX8FC-Q@mail.gmail.com>
Subject: Re: [PATCH 6/7] rebase --abort: improve reflog message
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
> When aborting a rebase the reflog message looks like
>
>         rebase (abort): updating HEAD
>
> which is not very informative. Improve the message by mentioning the
> branch that we are returning to as we do at the end of a successful
> rebase so it looks like.
>
>         rebase (abort): returning to refs/heads/topic

That is _so_ much nicer.

> If GIT_REFLOG_ACTION is set in the environment we no longer omit
> "(abort)" from the reflog message. We don't omit "(start)" and
> "(finish)" when starting and finishing a rebase in that case so we
> shouldn't omit "(abort)".

I agree.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/rebase.c          | 28 ++++++---------------
>  t/t3406-rebase-message.sh | 51 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+), 20 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 678339c7bf7..70426e17b40 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -992,23 +992,6 @@ static void NORETURN error_on_missing_default_upstream(void)
>         exit(1);
>  }
>
> -static void set_reflog_action(struct rebase_options *options)
> -{
> -       const char *env;
> -       struct strbuf buf = STRBUF_INIT;
> -
> -       if (!is_merge(options))
> -               return;
> -
> -       env = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
> -       if (env && strcmp("rebase", env))
> -               return; /* only override it if it is "rebase" */
> -
> -       strbuf_addf(&buf, "rebase (%s)", options->action);
> -       setenv(GIT_REFLOG_ACTION_ENVIRONMENT, buf.buf, 1);
> -       strbuf_release(&buf);
> -}
> -
>  static int check_exec_cmd(const char *cmd)
>  {
>         if (strchr(cmd, '\n'))
> @@ -1287,18 +1270,23 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>         }
>         case ACTION_ABORT: {
>                 struct string_list merge_rr = STRING_LIST_INIT_DUP;
> -               options.action = "abort";
> -               set_reflog_action(&options);
> +               struct strbuf head_msg = STRBUF_INIT;
>
> +               options.action = "abort";
>                 rerere_clear(the_repository, &merge_rr);
>                 string_list_clear(&merge_rr, 1);
>
>                 if (read_basic_state(&options))
>                         exit(1);
> +
> +               strbuf_addf(&head_msg, "%s (abort): returning to %s",
> +                           getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
> +                           options.head_name ? options.head_name
> +                                             : oid_to_hex(&options.orig_head));
>                 ropts.oid = &options.orig_head;
> +               ropts.head_msg = head_msg.buf;
>                 ropts.branch = options.head_name;
>                 ropts.flags = RESET_HEAD_HARD;
> -               ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
>                 if (reset_head(the_repository, &ropts) < 0)
>                         die(_("could not move back to %s"),
>                             oid_to_hex(&options.orig_head));
> diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
> index 5c6cd9af3bc..ceca1600053 100755
> --- a/t/t3406-rebase-message.sh
> +++ b/t/t3406-rebase-message.sh
> @@ -187,6 +187,57 @@ test_reflog () {
>         EOF
>         test_cmp expect actual
>         '
> +
> +       test_expect_success "rebase $mode --abort reflog${reflog_action:+ GIT_REFLOG_ACTION=$reflog_action}" '
> +       git checkout conflicts &&
> +       test_when_finished "git reset --hard Q" &&
> +
> +       git log -g -1 conflicts >branch-expect &&
> +       (
> +               if test -n "$reflog_action"
> +               then
> +                       GIT_REFLOG_ACTION="$reflog_action" &&
> +                       export GIT_REFLOG_ACTION
> +               fi &&
> +               test_must_fail git rebase $mode main &&
> +               git rebase --abort
> +       ) &&
> +
> +       git log -g --format=%gs -3 >actual &&
> +       write_reflog_expect <<-EOF &&
> +       ${reflog_action:-rebase} (abort): returning to refs/heads/conflicts
> +       ${reflog_action:-rebase} (pick): P
> +       ${reflog_action:-rebase} (start): checkout main
> +       EOF
> +       test_cmp expect actual &&

I was confused by the ordering at first, before I realized that `git
log -g` is going to give you reflogs from newest to oldest instead of
vice-versa.  Looks good.

> +
> +       # check branch reflog is unchanged
> +       git log -g -1 conflicts >branch-actual &&
> +       test_cmp branch-expect branch-actual
> +       '
> +
> +       test_expect_success "rebase $mode --abort detached HEAD reflog${reflog_action:+ GIT_REFLOG_ACTION=$reflog_action}" '
> +       git checkout Q &&
> +       test_when_finished "git reset --hard Q" &&
> +
> +       (
> +               if test -n "$reflog_action"
> +               then
> +                       GIT_REFLOG_ACTION="$reflog_action" &&
> +                       export GIT_REFLOG_ACTION
> +               fi &&
> +               test_must_fail git rebase $mode main &&
> +               git rebase --abort
> +       ) &&
> +
> +       git log -g --format=%gs -3 >actual &&
> +       write_reflog_expect <<-EOF &&
> +       ${reflog_action:-rebase} (abort): returning to $(git rev-parse Q)
> +       ${reflog_action:-rebase} (pick): P
> +       ${reflog_action:-rebase} (start): checkout main
> +       EOF
> +       test_cmp expect actual
> +       '
>  }

And thanks for checking the detached HEAD case too.

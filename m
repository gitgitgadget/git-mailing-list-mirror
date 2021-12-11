Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38883C433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 10:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhLKK7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 05:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhLKK7n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 05:59:43 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C56C061714
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 02:59:42 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y13so36941462edd.13
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 02:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XndsKAv4xyMeRo4zNSnttP9fTDatifTHJupyLxYzwD4=;
        b=jq/HYtVKU46BuhXnl8tg38kTp4L2B8RdKSF9ZixP2qqYu30qxfcI0DV2KMrxEaMdwv
         HCmez+i31iDy0KcryjC9PMK9IQcTw9LjabRzhXppMDDbJ7iYDdl/fRw644wlQk0ApoEt
         jVXpIcaaV4EYkwu1hAXpmpy8hSLKxcQmTPd+IpeaqZtIVYJKXX0cRndVDZI6sN2DLBPL
         ezwtEFQ09HPocrEuCh9XpfnLFyW+ZZEmhX4wvrytQc+OqtUT2RFgFQ4pu6zo6NxJAxtZ
         ppDh6ulHprTIeiBJfo9ZbHvl3xLTa39mlYU3d4s+ru3HG5Hps/e6sIAwNGTNSzR8Rybh
         mhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XndsKAv4xyMeRo4zNSnttP9fTDatifTHJupyLxYzwD4=;
        b=NPjarh4ro6W8uxg4kiDiMBRnbTf1xFfKlnO1N2kLrLU5o9plaKVTRU7CSjLvn1OXS9
         fZG6vHVNyqF/H6de68gwm0snpSQrpvci2MlnjmrdL2dh+T1SxeVsz0FOLVUMAh+t+UTA
         U1tqnO//FSNadmWtV019TOs7m1AdwFJ6rp7E5m5wIeKckAGF3noLr7/DbYFZWKvhGHeQ
         FOzNri5on8/euWu4T9LBtJMF+77jHpMQO3taej6RmTLwb8REyJb6Uw+qlei2Zr5QmHF5
         u8osXU71sn/alAeuV9fP+LMoAIzZdm+y30XMf5bHZtTnNyK+WnPHm4qwGq7/iGRdlXSa
         LmeQ==
X-Gm-Message-State: AOAM532q/P6z2RXYF4EqCrgesY8aiCAyhqiHWbfDGNoEOJPFUHVgccQn
        bZoI9dLskoF1ZCCvLn4KaQwP0RQiw7dye6ciHBM=
X-Google-Smtp-Source: ABdhPJznGCbqEgTGkFVap3U85zysdt7rghLkTj3nnGxklKyWjoLFyw2vhJ7xHx/bLgyE+avCZ88FNanGHKCwOStboWE=
X-Received: by 2002:aa7:c902:: with SMTP id b2mr45897612edt.320.1639220380944;
 Sat, 11 Dec 2021 02:59:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
 <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com> <45a5b5e981804c540991a63675909c4155b86b5e.1638975482.git.gitgitgadget@gmail.com>
In-Reply-To: <45a5b5e981804c540991a63675909c4155b86b5e.1638975482.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 11 Dec 2021 02:59:29 -0800
Message-ID: <CABPp-BEHW4VLG18twcM_8iOco1jZ2iuGT+KN8aS+-sAAnBhTnw@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] rebase --apply: set ORIG_HEAD correctly
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 8, 2021 at 6:58 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> At the start of a rebase ORIG_HEAD is updated to tip of the branch

Could we insert a comma between "rebase" and "ORIG_HEAD"?  Otherwise I
try to read it as "At the start of a `rebase ORIG_HEAD` is updated..."
and get totally lost.  I had to re-read the sentence a few times
before I understood what it was trying to say.

Also, perhaps s/to tip of/to the tip of/ ?

> being rebased. Unfortunately reset_head() always uses the current
> value of HEAD for this which is incorrect if the rebase is started
> with "git rebase <upstream> <branch>" as in that case ORIG_HEAD should
> be updated to <branch>. This only affects the "apply" backend as the
> "merge" backend does not yet use reset_head() for the initial
> checkout. Fix this by passing in orig_head when calling reset_head()
> and add some regression tests.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/rebase.c           |  1 +
>  reset.c                    |  4 +++-
>  reset.h                    |  4 ++++
>  t/t3418-rebase-continue.sh | 26 ++++++++++++++++++++++++++
>  4 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index b55a9cff05d..e942c300f8c 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1769,6 +1769,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>         strbuf_addf(&msg, "%s: checkout %s",
>                     getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
>         ropts.oid = &options.onto->object.oid;
> +       ropts.orig_head = &options.orig_head,
>         ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
>                         RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
>         ropts.head_msg = msg.buf;
> diff --git a/reset.c b/reset.c
> index e02915c0f65..448cb3fd785 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -15,6 +15,7 @@ static int update_refs(const struct reset_head_opts *opts,
>         unsigned detach_head = opts->flags & RESET_HEAD_DETACH;
>         unsigned run_hook = opts->flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
>         unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
> +       const struct object_id *orig_head = opts->orig_head;
>         const char *switch_to_branch = opts->branch;
>         const char *reflog_branch = opts->branch_msg;
>         const char *reflog_head = opts->head_msg;
> @@ -43,7 +44,8 @@ static int update_refs(const struct reset_head_opts *opts,
>                                 strbuf_addstr(&msg, "updating ORIG_HEAD");
>                                 reflog_orig_head = msg.buf;
>                         }
> -                       update_ref(reflog_orig_head, "ORIG_HEAD", head,
> +                       update_ref(reflog_orig_head, "ORIG_HEAD",
> +                                  orig_head ? orig_head : head,
>                                    old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
>                 } else if (old_orig)
>                         delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
> diff --git a/reset.h b/reset.h
> index 7ef7e43ea8c..a28f81829d8 100644
> --- a/reset.h
> +++ b/reset.h
> @@ -22,6 +22,10 @@ struct reset_head_opts {
>          * The commit to checkout/reset to. Defaults to HEAD.
>          */
>         const struct object_id *oid;
> +       /*
> +        * Optional value to set ORIG_HEAD. Defaults to HEAD.
> +        */
> +       const struct object_id *orig_head;
>         /*
>          * Optional branch to switch to.
>          */
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index 22eca73aa3e..130e2f9b553 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -308,4 +308,30 @@ test_expect_success 'there is no --no-reschedule-failed-exec in an ongoing rebas
>         test_expect_code 129 git rebase --edit-todo --no-reschedule-failed-exec
>  '
>
> +test_orig_head_helper () {
> +       test_when_finished 'git rebase --abort &&
> +               git checkout topic &&
> +               git reset --hard commit-new-file-F2-on-topic-branch' &&
> +       git update-ref -d ORIG_HEAD &&
> +       test_must_fail git rebase "$@" &&
> +       test_cmp_rev ORIG_HEAD commit-new-file-F2-on-topic-branch
> +}
> +
> +test_orig_head () {
> +       type=$1
> +       test_expect_success "rebase $type sets ORIG_HEAD correctly" '
> +               git checkout topic &&
> +               git reset --hard commit-new-file-F2-on-topic-branch &&
> +               test_orig_head_helper $type main
> +       '
> +
> +       test_expect_success "rebase $type <upstream> <branch> sets ORIG_HEAD correctly" '
> +               git checkout main &&
> +               test_orig_head_helper $type main topic
> +       '
> +}
> +
> +test_orig_head --apply
> +test_orig_head --merge
> +
>  test_done
> --

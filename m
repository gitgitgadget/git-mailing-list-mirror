Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FB2C433F5
	for <git@archiver.kernel.org>; Sun, 17 Apr 2022 01:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbiDQCBm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 22:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbiDQCBi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 22:01:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D3D1928E
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 18:59:04 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z99so14030959ede.5
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 18:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/MM0McmQHi/YqbmBJmApo64B7Xz6rWaC3+jvwY4c3M=;
        b=EUZQW0V867zygS+2jnXMxridE1cAsYE+Fs/dQ/DgKLL7eSTGNPnSqnBzcC7o/2byfm
         X78wuMcIbYepdQciBdciXLmcoxwa58IAt/tt44K578dM5fFC3Gj0/yp15BuvtA8LXe9h
         hqNTkPyb0vnXAsASE2FPYoSfgjmQXH6X7f/FzgC6ysBbjcllFUdC4YkFaoID2jhKbA5/
         rwDlWBXSk5Zpv6cAEFWP0dW/ukNt78qdv9+0F3eOLIWz4wqbU3XcZwz5XOGKeUjItXYh
         zWY6S45ZlcvhFgcbOfwvFoJK+tc8Ehbj7Sf0ir4urZ/oLZhh/7LMzovDtRyHFrHcEKFT
         gPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/MM0McmQHi/YqbmBJmApo64B7Xz6rWaC3+jvwY4c3M=;
        b=vhibLJHIw6665ltEw/jUEp0Tqwxd129VtRjlAwqkiVomeISF06zKpQrWpPcDZ8BVnP
         3gLmsHMK4wK5553AqlrtzFOGQcpe7JoNAIoZwqD7C1DQAugxU78nTRCkv58bLuAwqfGx
         IifeHzS/BZJu08BiEJIFoB26oDg/GcyqWdk8ZbPR1PLY3DfOxwlGPYltV6RFo1Gerk6c
         Fi1Viv0kyl4hk+YtZ+5iWnB0cycSP4K2WKAIgLSMUTZtsU9XisqTc0S3dntFBKKgGzVk
         9w6d3X+8lWxImTuVj4lQZdQj8PAsIfnAYO1Qh/UaUEkVFFLYjmvJOZqZc+TSufGmgD6w
         iZ2A==
X-Gm-Message-State: AOAM530/JSGDz3zBLLPZ1n0DFfE1RSXw7JZPMEXd/O/6+XPUgr8id9QM
        O+8BZROzfqDYG+rmZjBf5/TLBHoRjfphgHWDNkU260Yj
X-Google-Smtp-Source: ABdhPJwiPJwfIfC+VTcYtQIqliXmhIgkRApo8MM7bPT42R8nPhVCfXeQYVnjvV3vTaZ+bqaOASrFlAgl8dPej32VGg0=
X-Received: by 2002:aa7:cc82:0:b0:410:d2b0:1a07 with SMTP id
 p2-20020aa7cc82000000b00410d2b01a07mr6057050edt.359.1650160743348; Sat, 16
 Apr 2022 18:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com> <f4e6e94bc2c894f369546d16d147d970b71554e7.1645441854.git.gitgitgadget@gmail.com>
In-Reply-To: <f4e6e94bc2c894f369546d16d147d970b71554e7.1645441854.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 16 Apr 2022 18:58:52 -0700
Message-ID: <CABPp-BFQhTPoBmB9i0K70DggpQgiB1P+=KPScaEXYeBikkd1uw@mail.gmail.com>
Subject: Re: [PATCH 3/7] rebase --merge: fix reflog message after skipping
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
> The reflog message for every pick after running "rebase --skip" looks
> like
>
>         rebase (skip) (pick): commit subject line
>
> Fix this by not appending " (skip)" to the reflog action.

Nice catch, and cool that the fix was so simple.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/rebase.c          |  2 --
>  t/t3406-rebase-message.sh | 24 ++++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index cd9a4f3e2f1..36863117fba 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1273,8 +1273,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>                 struct string_list merge_rr = STRING_LIST_INIT_DUP;
>
>                 options.action = "skip";
> -               set_reflog_action(&options);
> -
>                 rerere_clear(the_repository, &merge_rr);
>                 string_list_clear(&merge_rr, 1);
>                 ropts.flags = RESET_HEAD_HARD;
> diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
> index 3ca2fbb0d59..8aa6a79acc1 100755
> --- a/t/t3406-rebase-message.sh
> +++ b/t/t3406-rebase-message.sh
> @@ -163,6 +163,30 @@ test_reflog () {
>         # check there is only one new entry in the branch reflog
>         test_cmp_rev fast-forward@{1} X
>         '
> +
> +       test_expect_success "rebase $mode --skip reflog${reflog_action:+ GIT_REFLOG_ACTION=$reflog_action}" '
> +       git checkout conflicts &&
> +       test_when_finished "git reset --hard Q" &&
> +
> +       (
> +               if test -n "$reflog_action"
> +               then
> +                       GIT_REFLOG_ACTION="$reflog_action" &&
> +                       export GIT_REFLOG_ACTION
> +               fi &&
> +               test_must_fail git rebase $mode main &&
> +               git rebase --skip
> +       ) &&
> +
> +       git log -g --format=%gs -4 >actual &&
> +       write_reflog_expect <<-EOF &&
> +       ${reflog_action:-rebase} (finish): returning to refs/heads/conflicts
> +       ${reflog_action:-rebase} (pick): Q
> +       ${reflog_action:-rebase} (pick): P
> +       ${reflog_action:-rebase} (start): checkout main
> +       EOF
> +       test_cmp expect actual
> +       '
>  }
>
>  test_reflog --merge
> --
> gitgitgadget
>

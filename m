Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F180C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 08:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbiB1IRi convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 28 Feb 2022 03:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiB1IRh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 03:17:37 -0500
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A737381B7
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 00:16:59 -0800 (PST)
Received: by mail-pj1-f52.google.com with SMTP id bx9-20020a17090af48900b001bc64ee7d3cso10650362pjb.4
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 00:16:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O+2erfgSzAwxsTngxjZn/68G/o/eZSHfhI9xDhxxq3Q=;
        b=c/Mi0GkKdTbGlyc3HhZ46L4A82vYwkv9kWk/bT6LJcSZg3KpCsI2dT7m3DFOwLK1je
         RcHcZSxLD1L9F3thmDbQW2n0N2NpoWwEfQk3x/8/v9Ur68LDzAwzn2HGpy1lLW6ZWfsG
         wIaktjj7JmMn4Q6xNT4tu5ePOvxxRaKRxHBzBrlTQBJNQRBjXHNeWBOXf+WMk/Z+g6wI
         zd1KOvBLyhBixwYaJ/zxhPzDsQnb8xs7ePTga7Ciic/jBIGFK3JZf0h89X7ZFN7gy39w
         TPgoJx6+xGvOuyuDAwgpej7UJR3C+mA39MC+xo8Qf/cwRbTBo9PAA8FTcNB+RC4frPng
         R1Ag==
X-Gm-Message-State: AOAM530TMMedo2tOYH9+94I4kGKI6S1HGjDa7xrWd4q946BuiRbnnOhT
        mwKFmjPf3n/0YA0K8F1U1yTAGn/i0VWrThVUglMDxAqBp7oDqQ==
X-Google-Smtp-Source: ABdhPJx+e0lCJKrmySI+3FQjWVw7KLKwxU3m/gY/kXncA+kNi+95Pg6GUEsS3he41mD9xCkgeEqw802H7A7CqRKe7HU=
X-Received: by 2002:a17:902:c215:b0:14f:f1c2:9fe3 with SMTP id
 21-20020a170902c21500b0014ff1c29fe3mr19456839pll.145.1646036218601; Mon, 28
 Feb 2022 00:16:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.1164.git.1645801727732.gitgitgadget@gmail.com>
In-Reply-To: <pull.1164.git.1645801727732.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 28 Feb 2022 03:16:47 -0500
Message-ID: <CAPig+cTx-n_WQqvVYyegtvW8gRbXEPsm5C7fmHq=9PZeANZ-wQ@mail.gmail.com>
Subject: Re: [PATCH] worktree: add -z option for list subcommand
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 25, 2022 at 10:08 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Add a -z option to be used in conjunction with --porcelain that gives
> NUL-terminated output. This enables 'worktree list --porcelain' to
> handle worktree paths that contain newlines.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>     For a previous discussion of the merits of adding a -z option vs quoting
>     the worktree path see
>     https://lore.kernel.org/git/CAPig+cT-9sjmkdWFEcFS=rg9ziV9b6uWNMpQ8BTYP-a258La6Q@mail.gmail.com/

Thanks for resubmitting.

> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> @@ -223,7 +223,13 @@ This can also be set up as the default behaviour by using the
> +-z::
> +       When `--porcelain` is specified with `list` terminate each line with a

Nit: s/`list`/&,/

> +       NUL rather than a newline. This makes it possible to parse the output
> +       when a worktree path contains a newline character.

Or, perhaps:

    Terminate each line with NUL rather than a newline when
    `--porcelain` is specified with `list`. This makes it possible...

might be simpler(?).

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -575,35 +575,38 @@ static int add(int ac, const char **av, const char *prefix)
> -static void show_worktree_porcelain(struct worktree *wt)
> +static void show_worktree_porcelain(struct worktree *wt, int line_terminator)
>  {
> -       printf("worktree %s\n", wt->path);
> +       printf("worktree %s%c", wt->path, line_terminator);
>         if (wt->is_bare)
> -               printf("bare\n");
> +               printf("bare%c", line_terminator);
>         else {
> -               printf("HEAD %s\n", oid_to_hex(&wt->head_oid));
> +               printf("HEAD %s%c", oid_to_hex(&wt->head_oid), line_terminator);
>                 if (wt->is_detached)
> -                       printf("detached\n");
> +                       printf("detached%c", line_terminator);
>                 else if (wt->head_ref)
> -                       printf("branch %s\n", wt->head_ref);
> +                       printf("branch %s%c", wt->head_ref, line_terminator);
>         }

Good, this is easier to read than the previous version which manually
called `fputc(line_terminator, stdout)` repeatedly for the
termination. The diff is also more easily digested.

>         if (reason && *reason) {
>                 struct strbuf sb = STRBUF_INIT;
> -               quote_c_style(reason, &sb, NULL, 0);
> -               printf("locked %s\n", sb.buf);
> +               if (line_terminator) {
> +                       quote_c_style(reason, &sb, NULL, 0);
> +                       reason = sb.buf;
> +               }
> +               printf("locked %s%c", reason, line_terminator);

Junio's suggestion downstream that write_name_quoted() would be
simpler makes sense, but (as he says) is not necessarily worth a
reroll.

> @@ -681,12 +684,15 @@ static void pathsort(struct worktree **wt)
> +               OPT_SET_INT('z', NULL, &line_terminator,
> +                           N_("fields are separated with NUL character"), '\0'),

Same comment as previous review [1]:

    "fields" sounds a little odd. "lines" might make more sense.
    "records" might be even better and matches the wording of some
    other Git commands accepting `-z`.

> @@ -696,6 +702,8 @@ static int list(int ac, const char **av, const char *prefix)
>                 usage_with_options(worktree_usage, options);
>         else if (verbose && porcelain)
>                 die(_("options '%s' and '%s' cannot be used together"), "--verbose", "--porcelain");
> +       else if (!line_terminator && !porcelain)
> +               die(_("'-z' requires '--porcelain'"));

Same comment as my previous review[1]:

    Other error messages in this file don't quote command-line
    options, so `die(_("-z requires --porcelain"));` would be more
    consistent.

However, considering all the recent work Jean-Noël Avila has been
doing to recently, perhaps this should instead mirror his change to
the die() message just above the new one and instead be:

    die(_("'%s' requires '%s'"), "-z", "--porcelain");

> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
> @@ -64,6 +64,27 @@ test_expect_success '"list" all worktrees --porcelain' '
> +test_expect_success '"list" all worktrees --porcelain -z' '
> +       test_when_finished "rm -rf here _actual actual expect &&
> +                               git worktree prune" &&
> +       printf "worktree %sQHEAD %sQbranch %sQQ" \
> +               "$(git rev-parse --show-toplevel)" \
> +               $(git rev-parse HEAD --symbolic-full-name HEAD) >expect &&
> +       git worktree add --detach here main &&
> +       printf "worktree %sQHEAD %sQdetachedQQ" \
> +               "$(git -C here rev-parse --show-toplevel)" \
> +               "$(git rev-parse HEAD)" >>expect &&
> +       git worktree list --porcelain -z >_actual &&
> +       cat _actual | tr "\0" Q >actual &&

Same comment as my previous review[1]:

    Or just use nul_to_q():
      nul_to_q <_actual >actual &&
    (And there's no need to `cat` the file.)

> +       test_cmp expect actual
> +'
> +
> +test_expect_success '"list" -z fails without --porcelain' '
> +       test_when_finished "rm -rf here && git worktree prune" &&
> +       git worktree add --detach here main &&
> +       test_must_fail git worktree list -z
> +'

Same comment as my previous review[1]:

    I don't think there's any need for this test to create (and
    cleanup) a worktree. So, the entire test could collapse to:

      test_expect_success '"list" -z fails without --porcelain' '
        test_must_fail git worktree list -z
      '

[1]: https://lore.kernel.org/git/CAPig+cT-9sjmkdWFEcFS=rg9ziV9b6uWNMpQ8BTYP-a258La6Q@mail.gmail.com/

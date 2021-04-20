Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5E3C43460
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3527D60C3E
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbhDTX1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 19:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbhDTX1M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 19:27:12 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCF1C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 16:26:40 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id k25so40684679oic.4
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 16:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GSzqhcfz6MczM9N7ckFfR1JRS13g2QY1B+19X2i9c7c=;
        b=j1xudRpE6QheOF+ybsTSga1zsHzFweeTlABdZp9o5l8Gs5xoIsleMLJC829sIWLbV2
         z8hFA9QQnPaxJ9KCzNiHGYqKsxhd/AzZTc7N9DRIZ7US33m7GB90v/b6gnPSs3/OleQ5
         YmzMsSJBEgOx6QnrP2P+eCHXtJ4ujCXIpl1uxl3nv1mqwKYwGBGMSd74XG9gk2iW/JRV
         6m8KJo7x+LhgfUGgnYlHPcb2W32yojqoND8LAqx+UhX2odQSYKcld1zKMxafiS9BHFbj
         MVK35TnkKOniiIewTZ5I3Z3NF2j9pcScc705iRltuNBoEjQBXZCHisOrISbJOdnkrOwJ
         niEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GSzqhcfz6MczM9N7ckFfR1JRS13g2QY1B+19X2i9c7c=;
        b=Gm+iO+Xnfo7JmpZZAkhQiFBZb0GzX8NEcMg4g4lKz6a9ZtvGxsU39jGrDt9GQdwB4a
         0S9p1c7kwJO+921UOkVoGrcJEIj5EXbX6dmQYYURlBQxbbWmVKZ0MA6vtOHW3nSy3+Z2
         XDxl8eao9VNiD/kGHRi5NYFzIZwp6YH9BkwcGtFJr06wlkmFK4tJn20w9qQlfwiirjS9
         ijp/kJa9DPzsf/g2BMhtOVe+QUbbtdiuv+Akh8L9lOsvOun3hvK+7A/3kd8yPKOThP9H
         IweZ+CNgvYOZ3IYdvuzsS4SFoINLrF6vRzvsHtUJUbKP5dF3H+t96TU0A8ukP3JUpb35
         zBOQ==
X-Gm-Message-State: AOAM530ev93qUeKcBdWDc4l8Fh4zXAgqH41NLAHgwyKxZWEGUL8BUKAY
        QHDBxxYCSM2OmNWgj2P3vbetqCTQR3VE39jU7bM=
X-Google-Smtp-Source: ABdhPJz6roKYIbQBky9sN3Nh0cqdjfd9z4gVkQ81LHo8STKgyFa8KnAgXjhen5gtGAg7Dxa9dI7yKNQKOLKdHCjqIGA=
X-Received: by 2002:aca:1a0b:: with SMTP id a11mr4762499oia.167.1618961199520;
 Tue, 20 Apr 2021 16:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.git.1618322497.gitgitgadget@gmail.com> <e86f874dd41291da66848068e7725a172dee231e.1618322497.git.gitgitgadget@gmail.com>
In-Reply-To: <e86f874dd41291da66848068e7725a172dee231e.1618322497.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 20 Apr 2021 16:26:28 -0700
Message-ID: <CABPp-BHVSPLsXT36=pyrXRR_d9oWCs2aFhA0jh6_u4DzVcTMDg@mail.gmail.com>
Subject: Re: [PATCH 04/10] status: skip sparse-checkout percentage with sparse-index
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 7:01 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> 'git status' began reporting a percentage of populated paths when
> sparse-checkout is enabled in 051df3cf (wt-status: show sparse
> checkout status as well, 2020-07-18). This percentage is incorrect when
> the index has sparse directories. It would also be expensive to
> calculate as we would need to parse trees to count the total number of
> possible paths.
>
> Avoid the expensive computation by simplifying the output to only report
> that a sparse checkout exists, without the percentage.

Makes sense.  The percentage wasn't critical, it was just a nice UI
bonus.  The critical part is notifying about being in a sparse
checkout.

It makes me wonder slightly if we'd want to remove the percentage for
both modes just to keep them more similar.  I'll ask some folks for
their thoughts/opinions.  Of course, that could always be tweaked
later and doesn't necessarily need to go into your series.

> This change is the reason we use 'git status --porcelain=v2' in
> t1092-sparse-checkout-compatibility.sh. We don't want to ensure that
> this message is equal across both modes, but instead just the important
> information about staged, modified, and untracked files are compared.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh |  8 ++++++++
>  wt-status.c                              | 14 +++++++++++---
>  wt-status.h                              |  1 +
>  3 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 6598c12a2069..e488ef9bd941 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -196,6 +196,14 @@ test_expect_success 'status with options' '
>         test_all_match git status --porcelain=v2 -uno
>  '
>
> +test_expect_success 'status reports sparse-checkout' '
> +       init_repos &&
> +       git -C sparse-checkout status >full &&
> +       git -C sparse-index status >sparse &&
> +       test_i18ngrep "You are in a sparse checkout with " full &&
> +       test_i18ngrep "You are in a sparse checkout." sparse
> +'
> +
>  test_expect_success 'add, commit, checkout' '
>         init_repos &&
>
> diff --git a/wt-status.c b/wt-status.c
> index 0c8287a023e4..0425169c1895 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1490,9 +1490,12 @@ static void show_sparse_checkout_in_use(struct wt_status *s,
>         if (s->state.sparse_checkout_percentage == SPARSE_CHECKOUT_DISABLED)
>                 return;
>
> -       status_printf_ln(s, color,
> -                        _("You are in a sparse checkout with %d%% of tracked files present."),
> -                        s->state.sparse_checkout_percentage);
> +       if (s->state.sparse_checkout_percentage == SPARSE_CHECKOUT_SPARSE_INDEX)
> +               status_printf_ln(s, color, _("You are in a sparse checkout."));
> +       else
> +               status_printf_ln(s, color,
> +                               _("You are in a sparse checkout with %d%% of tracked files present."),
> +                               s->state.sparse_checkout_percentage);
>         wt_longstatus_print_trailer(s);
>  }
>
> @@ -1650,6 +1653,11 @@ static void wt_status_check_sparse_checkout(struct repository *r,
>                 return;
>         }
>
> +       if (r->index->sparse_index) {
> +               state->sparse_checkout_percentage = SPARSE_CHECKOUT_SPARSE_INDEX;
> +               return;
> +       }
> +
>         for (i = 0; i < r->index->cache_nr; i++) {
>                 struct cache_entry *ce = r->index->cache[i];
>                 if (ce_skip_worktree(ce))
> diff --git a/wt-status.h b/wt-status.h
> index 0d32799b28e1..ab9cc9d8f032 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -78,6 +78,7 @@ enum wt_status_format {
>  };
>
>  #define SPARSE_CHECKOUT_DISABLED -1
> +#define SPARSE_CHECKOUT_SPARSE_INDEX -2
>
>  struct wt_status_state {
>         int merge_in_progress;
> --
> gitgitgadget

Looks good.

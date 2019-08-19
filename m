Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FE471F461
	for <e@80x24.org>; Mon, 19 Aug 2019 16:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfHSQDD (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 12:03:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39069 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfHSQDD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 12:03:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so9269436wra.6
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 09:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZhYodY/J+RaKRuvgiRor1NKWv58EXDceP/vdnifhy+s=;
        b=ohDSfHKw+EEG43LpOjFTDGKBluSloWS6hglORy3PiXqu1wVbKNvpO13W/OIABNZg4J
         O2MtasjpXH568UaK5DWijx7h+27bptF6kHHGzmke+qX8SEIxWxfFhiWMO6N4Z33i0JU5
         ssZSw1SROaGDaKEThau0rpxe7LwOyK5cjw2ZjkodzF8OTexLXmAuutE5/nV/Tck6GJF4
         w322TUjkhg+a6japRxuBP4XBFTsyZwZGRIYa5Fpn4AWOV8aADaWN/UTYjZk8UVkTr1zT
         Oz+LXn8nv+GUU5bHz9tu5wYYgqLgZmHeO8sIvUgcoIh1B9Ah4yDF5L4pWmw84dOhPb8G
         TwjA==
X-Gm-Message-State: APjAAAXROgRvHaLFY4IJjx4jZhdSYKAHCrL04G8vDllnE4/10I70QfjF
        +W89c2uWPC9KwmSacZHEgzC7w9qAOyH1MLq6BuE=
X-Google-Smtp-Source: APXvYqxveANZH2idcJTDEcoFLd8goTisXjB66NBAainheHOBGlbnkCSJhBDZc97soNkSGU107Vw8FcHYlxHd+r0ZYIM=
X-Received: by 2002:a5d:4492:: with SMTP id j18mr28270677wrq.53.1566230580607;
 Mon, 19 Aug 2019 09:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566182184.git.liu.denton@gmail.com> <058f877c342e8ee6683235c32946e5238e7e87f5.1566182184.git.liu.denton@gmail.com>
In-Reply-To: <058f877c342e8ee6683235c32946e5238e7e87f5.1566182184.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 19 Aug 2019 12:02:49 -0400
Message-ID: <CAPig+cQE0r5tzTJ5qp1DSgE5L4Zu1W9kuwA0LKbZcVVTO2nK6A@mail.gmail.com>
Subject: Re: [PATCH 1/3] t4014: clean up style
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 18, 2019 at 10:38 PM Denton Liu <liu.denton@gmail.com> wrote:
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> @@ -96,7 +97,7 @@ test_expect_success "format-patch doesn't consider merge commits" '
>         git merge --no-ff slave &&
> -       cnt=$(git format-patch -3 --stdout | grep "^From " | wc -l) &&
> +       cnt=$(git format-patch -3 --stdout >patch && grep "^From " patch | wc -l) &&
>         test $cnt = 3

Just below here, you update tests to use test_line_count(). Why not do
the same here?

> @@ -104,21 +105,22 @@ test_expect_success "format-patch result applies" '
>
>         git checkout -b rebuild-0 master &&
>         git am -3 patch0 &&
> -       cnt=$(git rev-list master.. | wc -l) &&
> -       test $cnt = 2
> +       git rev-list master.. >list &&
> +       test_line_count = 2 list
>  '
> @@ -357,7 +370,7 @@ test_expect_success 'reroll count (-v)' '
>  check_threading () {
>         expect="$1" &&
>         shift &&
> -       (git format-patch --stdout "$@"; echo $? > status.out) |
> +       (git format-patch --stdout "$@"; echo $? >status.out) |
>         # Prints everything between the Message-ID and In-Reply-To,
>         # and replaces all Message-ID-lookalikes by a sequence number
>         perl -ne '
> @@ -372,12 +385,12 @@ check_threading () {
>                         print;
>                 }
>                 print "---\n" if /^From /i;
> -       ' > actual &&
> +       ' >actual &&
>         test 0 = "$(cat status.out)" &&
>         test_cmp "$expect" actual
>  }

Not a new issue, but this is more difficult to reason about than it
could be due to the manual squirreling away of the status code of the
Git command which is upstream of the pipe. More straightforward would
be:

    ...
    shift &&
    git format-patch --stdout "$@" >patch &&
    perl -ne '...' <patch >actual &&
    test_cmp "$expect" actual

No need for capturing or manually checking format-patch's exit code
since the &&-chain handles it for you. And, you no longer have a Git
command upstream of a pipe.

> @@ -852,20 +865,22 @@ test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
> -git_version="$(git --version | sed "s/.* //")"
> +git_version="$(git --version >version && sed "s/.* //" version)"

Meh. The exit code is being ignored anyhow since this is not part of a &&-chain.

> @@ -1649,19 +1665,32 @@ test_expect_success 'format-patch -o overrides format.outputDirectory' '
>  test_expect_success 'format-patch --base' '
>         [...]
>         echo >expected &&
>         echo "base-commit: $(git rev-parse HEAD~3)" >>expected &&
> -       echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --stable | awk "{print \$1}")" >>expected &&
> -       echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --stable | awk "{print \$1}")" >>expected &&
> -       signature >> expected &&
> +       git show --patch HEAD~2 >patch &&
> +       git patch-id --stable <patch >patch.id.raw &&
> +       awk "{print \$1}" <patch.id.raw >patch.id &&
> +       echo "prerequisite-patch-id: $(cat patch.id)" >>expected &&
> +       git show --patch HEAD~1 >patch &&
> +       git patch-id --stable <patch >patch.id.raw &&
> +       awk "{print \$1}" <patch.id.raw >patch.id &&
> +       echo "prerequisite-patch-id: $(cat patch.id)" >>expected &&

Not a big deal, but you could take advantage of the fact that you're
already invoking 'awk', thus avoid the 'echo':

    awk "{print \"prerequisite-patch-id:\", \$1}" <patch.id.raw >patch.id &&

> +       signature >>expected &&
>         test_cmp expected actual1 &&
>         test_cmp expected actual2 &&
>         echo >fail &&
>         echo "base-commit: $(git rev-parse HEAD~3)" >>fail &&
> -       echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --unstable | awk "{print \$1}")" >>fail &&
> -       echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --unstable | awk "{print \$1}")" >>fail &&
> +       echo "prerequisite-patch-id: $(
> +               git show --patch HEAD~2 >patch &&
> +               git patch-id --unstable <patch >patch.id.raw &&
> +               awk "{print \$1}" <patch.id.raw)" >>fail &&
> +       echo "prerequisite-patch-id: $(git show --patch HEAD~1 >patch &&
> +               git patch-id --unstable <patch >patch.id.raw &&
> +               awk "{print \$1}" <pattch.id.raw)" >>fail &&

Hmph, why is this case transformed in a different way than the case
immediately above.

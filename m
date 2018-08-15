Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A25D81F404
	for <e@80x24.org>; Wed, 15 Aug 2018 16:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbeHOTwf (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 15:52:35 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46536 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbeHOTwf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 15:52:35 -0400
Received: by mail-qk0-f194.google.com with SMTP id 191-v6so1228362qki.13
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 09:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXH1ZvVZxZIqypuXF4UgnMApx/LH+oq3FE1yyW2q9tY=;
        b=mMXNtxJ/9YM6sYxm/WQ5X2f8qijAJqMSMXmCRi7eHUnhWfWLQ+8CBbiG/WP4XM0ULu
         qCplt3jomY0D98Joagg7FIaZ+QL59jPlB6lDnKiPVhjwMVUnZti0VZl76nSX254cvd/z
         C7iQD9gbJpncwJIpKKtZMZBB9EA0b6kkBW836lr31olckryCtQ6CX5E6PlxDzVfQ9mHi
         VwhQVtD/mKPRrdpIQddFOGBkdaiECXQqOYS0smM2rLwEJkES+1/UTMijNsLxFS3xAUdQ
         PKUkSUCjgcONev3tP/f3sRruXfaNSMgmtYdHqflEq1Sw5wHrYYsjf8K6IIC3d2YswLiX
         4VVg==
X-Gm-Message-State: AOUpUlGxuzlcUJ4tSr/pwkZyTu7fTRsF/7RLS4Q4DorY2EsgYvpNoHTy
        Q4e+6Kx7zrxsGO9Ar7puPseQ4qbECyOk5VO3/D6CFr8d
X-Google-Smtp-Source: AA+uWPxfGWVSgP7AcqGttTq2cyRz0KG72p0L9f04IwEsDUpDwHjMrk9sM2bwmhzSEexjmcqR3nxeyO0olKH+TUHUTcQ=
X-Received: by 2002:ae9:de05:: with SMTP id s5-v6mr23507615qkf.145.1534352377576;
 Wed, 15 Aug 2018 09:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180815111544.30711-1-samuel.maftoul@gmail.com>
In-Reply-To: <20180815111544.30711-1-samuel.maftoul@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 15 Aug 2018 12:59:26 -0400
Message-ID: <CAPig+cSUy7rFwhmJ1SFHsAjPkoWparfY6wAjV=6kJyUL3SLQUw@mail.gmail.com>
Subject: Re: [PATCH] branch: support configuring --sort via .gitconfig
To:     samuel.maftoul@gmail.com
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 7:16 AM <samuel.maftoul@gmail.com> wrote:
> Add support for configuring default sort ordering for git branches. Command
> line option will override this configured value, using the exact same
> syntax.

Your Signed-off-by: is missing. See Documentation/SubmittingPatches.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -1034,6 +1034,11 @@ branch.autoSetupRebase::
> +branch.sort::
> +       This variable controls the sort ordering of branches when displayed by
> +       linkgit:git-branch[1]. Without the "--sort=<value>" option provided, the
> +       value of this variable will be used as the default.

I realize that you copied this description from 'tag.sort', thus
inherited its existing weakness, but as a reader of this, the first
question which popped into my head was "what are the possible
<value>s? This description gives no clues and leaves the reader
hanging. Better would be either to list the values or point the reader
(possibly with a linkgit:) at documentation which does list them.

> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> @@ -272,6 +272,10 @@ start-point is either a local or remote-tracking branch.
>         full refname (including `refs/...` prefix). This lists
>         detached HEAD (if present) first, then local branches and
>         finally remote-tracking branches.
> +       The keys supported are the same as those in `git for-each-ref`.
> +       Sort order defaults to the value configured for the `tag.sort`

Did you mean s/tag/branch/?

> +       variable if it exists, or lexicographic order otherwise. See
> +       linkgit:git-config[1].

Except for the "See linkgit:git-config[1]", isn't this new text mostly
duplicating what this item already says? When I look at
Documentation/git-branch.txt, I see:

    Sort based on the key given. Prefix `-` to sort in descending
    order of the value. You may use the --sort=<key> option
    multiple times, in which case the last key becomes the primary
    key. **The keys supported are the same as those in `git
    for-each-ref`. Sort order defaults to** sorting based on the
    full refname (including `refs/...` prefix). This lists
    detached HEAD (if present) first, then local branches and
    finally remote-tracking branches.

I added ** to highlight the existing text which this duplicates.

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> @@ -1305,4 +1305,50 @@ test_expect_success 'tracking with unexpected .fetch refspec' '
> +test_expect_success 'configured committerdate sort' '
> +       git init sort &&
> +       (
> +               cd sort &&
> +               git config branch.sort committerdate &&
> +               [...]
> +       )
> +'
> +
> +test_expect_success 'option override configured sort' '
> +       (
> +               cd sort &&
> +               git branch --sort=refname >actual &&

I would trust this test more if it explicitly configured "branch.sort"
rather than inheriting the value from test(s) above it. That way you
wouldn't have to worry about someone later inserting a test above this
one which changes or removes the value.

> +               cat >expect <<-\EOF &&
> +                 a
> +               * b
> +                 c
> +                 master
> +               EOF
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'invalid sort parameter in configuration' '
> +       (
> +               cd sort &&
> +               git config branch.sort "v:notvalid" &&
> +               test_must_fail git branch
> +
> +       )
> +'

Style: Lose the unnecessary blank line.

Thanks.

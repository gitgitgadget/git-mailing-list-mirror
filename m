Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1FAC07E9C
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 07:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12D4F613CF
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 07:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349565AbhGLHoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 03:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbhGLHhM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 03:37:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539BCC06119D
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 00:30:46 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w14so14849538edc.8
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 00:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xsWKKfrLZUZOkO5OTUj45IwTvxOOhaQktr5KbDMfAYw=;
        b=Bqw4IYbwb74yW9sZ10uBfO9Y+QtIG2hy4gmz05OXRZmqn2K/MhX/qfx77volLuUDPI
         xCRfA0g6YvkTDZ/HOyr9fnGpMGZdagvoFpWK6h6V/PaFfLtFFw/sKRQ7aKsNqV51sh8T
         CYG1t99DkXH+/osMxAmEq9WKjJd/rYV3zrzfatG5tL/4Xf+Ff2Laf/hgNrPUamkIkSpa
         /gfYiHuvajSp9KpDkl3VinmyPQrLc61QXdoeS2NOP3w/OXHXXJm1MNOad9wU9kWsCt/z
         me1zMiMwf+4WGwR8ehl62bK3lKV5eD6h/l+uxCnE3zOl+PF1cKHrJWJ2tyDfOq+onUzD
         aQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xsWKKfrLZUZOkO5OTUj45IwTvxOOhaQktr5KbDMfAYw=;
        b=MP9E/OLmFBU1+1loSK5doPYLbAeHZelolyKgwsZ1XE/GstsMy3yfVTNygzUGDaB3oO
         TEk0M0/07q0UpyRyF8ahc59knSUDPNVjQ6Y1/H6GTt6klBkmKqByxVsvg/1j9LbRC5/z
         BXXUM5qKRgloW+8o4DLgVhVKWX+AYBx6qck+Xag8QaERWOMjkFNsVhq/G6lhQlZQK7Lv
         yEifMdG90T7NNntveJccO8kZK8BAFgga3z68cVEvKuiZi+Q8Mowh10vIIjqTt67dCgG9
         um3IKLR0srMel3TmnmLpntoHYmmsiRKwcOT/ts6qBoOPeg7/DYd9AdGX6hPmqT2wm3pN
         tDfg==
X-Gm-Message-State: AOAM530Fm4cvbwqlBXTNGrQr6nlqGmkhcmsPIvYIM3iLJkaJT4kPSvSr
        fGTNi/HzMGbrtXURsk7KUGTYeVlpg+MdnfhQxvg=
X-Google-Smtp-Source: ABdhPJwiZPUFKeGR1FrVfLKrwh2918CNUICvDzYqFwOpKxJkbVMhh1rE1Ub9Dk0NEDFBHrRk6sPxaWuuBybT8INXkuQ=
X-Received: by 2002:a05:6402:458:: with SMTP id p24mr62443150edw.142.1626075044877;
 Mon, 12 Jul 2021 00:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210706224321.14371-1-sandals@crustytoothpaste.net> <20210711215510.191626-1-sandals@crustytoothpaste.net>
In-Reply-To: <20210711215510.191626-1-sandals@crustytoothpaste.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 12 Jul 2021 09:30:33 +0200
Message-ID: <CAP8UFD2BVba_vsXaTPkXgYDGg28xApoyDrrT2fdTddvM1_3CiA@mail.gmail.com>
Subject: Re: [PATCH v2] rev-list: add option for --pretty=format without header
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 11, 2021 at 11:55 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> In general, we encourage users to use plumbing commands, like git
> rev-list, over porcelain commands, like git log, when scripting.
> However, git rev-list has one glaring problem that prevents it from
> being used in certain cases: when --pretty is used with a custom format,
> it always prints out a line containing "commit" and the object ID.  This
> makes it unsuitable for many scripting needs, and forces users to use
> git log instead.
>
> While we can't change this behavior for backwards compatibility, we can
> add an option to suppress this behavior, so let's do so, and call it
> "--no-commit-header".  Additionally, add the corresponding positive
> option to switch it back on.
>
> Note that this option doesn't affect the built-in formats, only custom
> formats.  This is exactly the same behavior as users already have from
> git log and is what most users will be used to.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> Changes from v1:
> * Ensure this applies only to custom formats.
> * Fix the issue with --abbrev-commit mentioned by Junio.
> * Add tests for additional cases, including built-in formats.
> * Update documentation to reflect this data.

Thanks! This version mostly looks good to me!

> diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> index 35a2f62392..41d0ca00b1 100755
> --- a/t/t6006-rev-list-format.sh
> +++ b/t/t6006-rev-list-format.sh
> @@ -41,22 +41,59 @@ test_expect_success 'setup' '
>         echo "$added_iso88591" | git commit -F - &&
>         head1=$(git rev-parse --verify HEAD) &&
>         head1_short=$(git rev-parse --verify --short $head1) &&
> +       head1_short4=$(git rev-parse --verify --short=4 $head1) &&
>         tree1=$(git rev-parse --verify HEAD:) &&
>         tree1_short=$(git rev-parse --verify --short $tree1) &&
>         echo "$changed" > foo &&
>         echo "$changed_iso88591" | git commit -a -F - &&
>         head2=$(git rev-parse --verify HEAD) &&
>         head2_short=$(git rev-parse --verify --short $head2) &&
> +       head2_short4=$(git rev-parse --verify --short=4 $head2) &&
>         tree2=$(git rev-parse --verify HEAD:) &&
>         tree2_short=$(git rev-parse --verify --short $tree2) &&
>         git config --unset i18n.commitEncoding
>  '
>
> -# usage: test_format name format_string [failure] <expected_output
> +# usage: test_format [argument...] name format_string [failure] <expected_output

Usually we use "option" instead of "argument" for the flags starting
with "-" or "--" before the required parameter. For example:

$ git rev-list -h
usage: git rev-list [OPTION] <commit-id>... [ -- paths... ]
...

(Yeah, I agree that [OPTION] is not very consistent with what other
commands show, which is usually "[<options>]".)

>  test_format () {
> +       local args=

Here...

> +       while true
> +       do
> +               case "$1" in
> +               --*)
> +                       args="$args $1"

...here...

> +                       shift;;
> +               *)
> +                       break;;
> +               esac
> +       done
>         cat >expect.$1
>         test_expect_${3:-success} "format $1" "
> -               git rev-list --pretty=format:'$2' main >output.$1 &&
> +               git rev-list $args --pretty=format:'$2' main >output.$1 &&

...and here "opts" might be better than "args".

> +               test_cmp expect.$1 output.$1
> +       "
> +}
> +
> +# usage: test_pretty [argument...] name format_name [failure] <expected_output

Here...

> +test_pretty () {
> +       local args=

...and in this function too.

> +       while true
> +       do
> +               case "$1" in
> +               --*)
> +                       args="$args $1"
> +                       shift;;
> +               *)
> +                       break;;
> +               esac
> +       done
> +       cat >expect.$1
> +       test_expect_${3:-success} "pretty $1 (without --no-commit-header)" "
> +               git rev-list $args --pretty='$2' main >output.$1 &&
> +               test_cmp expect.$1 output.$1
> +       "
> +       test_expect_${3:-success} "pretty $1 (with --no-commit-header)" "
> +               git rev-list $args --no-commit-header --pretty='$2' main >output.$1 &&
>                 test_cmp expect.$1 output.$1
>         "
>  }

[...]

> +test_pretty oneline oneline <<EOF
> +$head2 $changed
> +$head1 $added
> +EOF
> +
> +test_pretty short short <<EOF

test_pretty() accepts options like --no-commit-header, but it's only
used without any option. So I wonder if you forgot to add a few tests
with some options.

> +commit $head2
> +Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
> +
> +    $changed
> +
> +commit $head1
> +Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
> +
> +    $added
> +
> +EOF
> +
>  test_expect_success 'basic colors' '
>         cat >expect <<-EOF &&
>         commit $head2

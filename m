Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C35C1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E68206F8
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgCYGIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 02:08:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55347 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCYGIo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 02:08:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id z5so1028163wml.5
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 23:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6oKJ/Hl8zYeIHtzBzG2pDGEse6REPZ/MvnIFlAiesRs=;
        b=tfr7crdrGAJnoJaIsfyj5BGbtoNYekWe0OA9xDUOWrNbQjjtdRhcaRJXiaKvQ3vZ9V
         ZOKsky+KHl8nBeds+7XEEMEiKtmiO0xmfStEg444X2TTYLXrVsDeIryFXc1r3gMZWcEl
         UObaHfiURtMYhaWAbMNvvDYzxz/MzNTNncz1JJERpdhx8o9aSM5044G9q046UwO//8l5
         4lbV0nOiJ+eVPZ+sIFZiZIMz8fDLJI0eY6G9vN1HlEPw5g7gHEgJMeqVGXNoK5DCxB91
         duZv/gt4ZQ8m3F83VGdKzU4QfiQ+3nOjmLEeHKuAyr5aGwwfcHoYM3rtP6zL/ZXzBrhF
         GFDQ==
X-Gm-Message-State: ANhLgQ04xQ0RzwjjCEAX6qs/Q0zHBqJhnw0m9n/BHJZL3EUbNnzX1mg0
        w8OUo09N9XvrWm7+7mE+tnKwJ9I033D1uHA0y18=
X-Google-Smtp-Source: ADFU+vvBbQbrksuGnfpV1h30HkkW+mwPaoFhpn9tdU8JBchw+y9olYHKW1bQuE7sRHy9EvRtI2WcHxBQBshANHlmyPo=
X-Received: by 2002:a7b:c08a:: with SMTP id r10mr1715213wmh.130.1585116522654;
 Tue, 24 Mar 2020 23:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585115341.git.liu.denton@gmail.com> <674de50db28a50554d7af6e5c869c427d06f78aa.1585115341.git.liu.denton@gmail.com>
In-Reply-To: <674de50db28a50554d7af6e5c869c427d06f78aa.1585115341.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 25 Mar 2020 02:08:31 -0400
Message-ID: <CAPig+cQHZa4yELo3ncCVkbyrKWcPnZ4wjROMMbQGjm8dXK38GA@mail.gmail.com>
Subject: Re: [PATCH 2/8] t5512: generate references with generate_references()
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 25, 2020 at 1:55 AM Denton Liu <liu.denton@gmail.com> wrote:
> t5512: generate references with generate_references()

This summary doesn't say anything useful. How about this instead?

    t5512: stop losing git exit code in here-docs

> The expected references are generated using a here-doc with some inline
> subshells. If one of the `git rev-parse` invocations within the
> subshells failed, its return code is swallowed and we won't know about

s/failed/fails/

> it. Replace these here-docs with generate_references(), which actually
> reports when `git rev-parse` fails.

A couple nits below...

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
> @@ -4,6 +4,14 @@ test_description='git ls-remote'
> +generate_references () {
> +       for i
> +       do
> +               oid=$(git rev-parse "$i") || return 1
> +               printf '%s\t%s\n' "$oid" "$i"

I think the more usual way to say this in our test suite would be:

    oid=$(git rev-parse "$i") &&
    printf '%s\t%s\n' "$oid" "$i" || return 1

which has the nice property that someone can come along and insert
additional code in the loop body before the final "|| return 1"
without having to spend a lot of time trying to work out if the
&&-chain is intact or broken.

> +       done
> +}
> @@ -43,34 +51,19 @@ test_expect_success 'ls-remote self' '
>  test_expect_success 'ls-remote --sort="version:refname" --tags self' '
> -       cat >expect <<-EOF &&
> -       $(git rev-parse mark)   refs/tags/mark
> -       $(git rev-parse mark1.1)        refs/tags/mark1.1
> -       $(git rev-parse mark1.2)        refs/tags/mark1.2
> -       $(git rev-parse mark1.10)       refs/tags/mark1.10
> -       EOF
> +       generate_references refs/tags/mark refs/tags/mark1.1 refs/tags/mark1.2 refs/tags/mark1.10 >expect &&

This gets awfully wide and loses some readability. Perhaps:

    generate_references \
        refs/tags/mark \
        refs/tags/mark1.1 \
        refs/tags/mark1.2 \
        refs/tags/mark1.10 >expect &&

>         git ls-remote --sort="version:refname" --tags self >actual &&
>         test_cmp expect actual
>  '

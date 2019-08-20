Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A63AC1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 02:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfHTClg (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 22:41:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46966 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfHTClg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 22:41:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id z1so10665987wru.13
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 19:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H6hOZj7XXJgAjJCAothWBw5yRQEMkVF1ITqIwKhmRas=;
        b=djc1hLeShPY7yyAb9zAYAtB1x1r28JqDSvuurCLKdJ3u29NwkO1tgFG+BkpHkQeHqw
         7b3QD0jFiYXqSlRBRfOPS+4z2x3E4iS3ZBldGo6EaUt23skV7iNFYzmzzlWkG3VB8B47
         xfCX/jJwQQ++YYLAYksmDNKzhgMwA7vb1UKa0TU2k/nzC8660pzgVV7wrY5a3zvfGpBG
         PgVQprJuETbLcmQo2ruHF/ENwhFDaLVpck+dGe75fgEvAoDhfeCxBg/6XMZWPxP7FQ65
         +SUED7X2R0zjHGxLk7hc0ziRHncmtEUN1uas2pieNvJErF4Xsb27/pmYzsjqJnpvAvUZ
         az5A==
X-Gm-Message-State: APjAAAWwfIMjZs9+WQSLzIxD5HFrShcP7I/qwm49eReOLQnLssWggC4Q
        wNX/aMKfrSqcQHL/+DpfVqugcdpXKnAzPWavS0U=
X-Google-Smtp-Source: APXvYqzVUazRJEnkYMU4AopXKyCsYVDTXr64vZ8aNtaojjzL5oe1IH+amuSljr6K7Q5Ipe6/yJfYi/sxokdNYMe17HA=
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr29600999wrs.10.1566268894069;
 Mon, 19 Aug 2019 19:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566258525.git.liu.denton@gmail.com> <76a0a274fde564f709d294acd7d6da17167f05b5.1566258525.git.liu.denton@gmail.com>
In-Reply-To: <76a0a274fde564f709d294acd7d6da17167f05b5.1566258525.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 19 Aug 2019 22:41:22 -0400
Message-ID: <CAPig+cSzq7KB4y+wuuVtVS7oi=uK2FY0+UkfOXx1jp-oe=fs4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] t4014: clean up style
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 19, 2019 at 7:53 PM Denton Liu <liu.denton@gmail.com> wrote:
> In Git's tests, there is typically no space between the redirection
> operator and the filename. Remove these spaces.
>
> Since output is silenced when running without `-v` and debugging
> output is useful with `-v`, remove redirections to /dev/null.
>
> Change here-docs from `<<\EOF` to `<<-\EOF` so that they can be indented
> along with the rest of the test case.
>
> Convert all instances of `cnt=$(... | wc -l) && test $cnt = N` into
> uses of `test_line_count()`.
>
> For style, move the ending sq of test cases onto its own line whenever
> they do not conform.
>
> Rename output files from "expected" to "expect" to conform with the
> usual convention.
>
> Finally, refactor to remove Git commands upstream of pipe as well as Git
> commands that are in a non-variable-assignment subshell (e.g. `echo
> "base-commit: $(git rev-parse HEAD)"`. This way, if an invocation of a
> Git command fails, the return code won't be lost. Keep upstream non-Git
> commands since we have to assume a base level of sanity.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> This patch is getting a little unwieldy. Perhaps we could split it into
> several smaller patches? Unfortunately, I'm not really sure where a
> logical place to split it would be.

The bullet points in the commit message, each of which is a distinct
change, give a strong hint as to how the commit could be split into
smaller pieces. It would make repeated review easier (though I'm not
sure it's worth re-rolling just for that).

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> @@ -62,26 +63,24 @@ test_expect_success setup '
>  test_expect_success "format-patch --ignore-if-in-upstream" '
>
>         git format-patch --stdout \
>                 --ignore-if-in-upstream master..side >patch1 &&
> -       cnt=$(grep "^From " patch1 | wc -l) &&
> -       test $cnt = 2
> -
> +       grep "^From " patch1 >from1 &&
> +       test_line_count = 2 from1
>  '

Here you've removed the blank line following the body before the
closing quote, which brings the formatting more in line with current
style, however, you could do the same with the blank line before the
body. Ditto for other tests.

Another style fix would be to change the double quotes in the test
title to single quotes (here and in other tests).

> @@ -357,7 +369,7 @@ test_expect_success 'reroll count (-v)' '
>  check_threading () {
>         expect="$1" &&
>         shift &&
> -       (git format-patch --stdout "$@"; echo $? > status.out) |
> +       git format-patch --stdout "$@" >patch &&
>         # Prints everything between the Message-ID and In-Reply-To,
>         # and replaces all Message-ID-lookalikes by a sequence number
>         perl -ne '
> @@ -372,12 +384,11 @@ check_threading () {
>                         print;
>                 }
>                 print "---\n" if /^From /i;
> -       ' > actual &&
> -       test 0 = "$(cat status.out)" &&
> +       ' <patch >actual &&
>         test_cmp "$expect" actual
>  }

If you do break this patch into smaller pieces, this might deserve its
own patch (or not) because it requires a bit of extra reasoning by the
reviewer.

> @@ -852,20 +866,21 @@ test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
> -git_version="$(git --version | sed "s/.* //")"
> -
>  signature() {
> +       git_version="$(git --version >version && sed "s/.* //" version)" &&
>         printf "%s\n%s\n\n" "-- " "${1:-$git_version}"
>  }

Windows folks are not going to like you for this change since process
creation is so expensive on that platform, and the point of setting
that variable globally was to avoid repeated invocation (especially
since the output of "git --version" won't change). This function
appears to be invoked only three times presently, but that number
could increase in the future as new tests are added. Consequently, it
might be best to drop this change.

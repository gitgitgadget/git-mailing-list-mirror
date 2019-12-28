Return-Path: <SRS0=w8S9=2S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D01C2D0C6
	for <git@archiver.kernel.org>; Sat, 28 Dec 2019 08:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F9B20838
	for <git@archiver.kernel.org>; Sat, 28 Dec 2019 08:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfL1IeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Dec 2019 03:34:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36828 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfL1IeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Dec 2019 03:34:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so28139174wru.3
        for <git@vger.kernel.org>; Sat, 28 Dec 2019 00:34:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yljHEb7lI+sKO+FTPYTCz9x5oz26vaejXAQdXchzNgY=;
        b=QMDo15KB2HWK/vHTM0KkVE5zp3WLSMOt4fnd7pfVeXZpFU2a3BCJkB7O+iL9L5vcoZ
         up79F8T8527Rm9V8dLDuQ022DikaP8ZXGWgP8CAjv2G5prYa5gsJVQOP/8nRyNX6SlBJ
         IljDIq3PdZdZM0Aauxmxr+KXyp8iG5Vm3FYbeTBvept9WHjzArDr85HZZAgY9XxgSPF5
         ju5b8xhW9pepqTAKT7cNlFEXHMWGiRSYA30oVJBZGCPdt3QLdajbWN9dF3AkzC3ZNJlt
         wNKQnC+kmNlZolBf7W1vxlZQperv2epP8ggCBgRElcRCCxlJWbgiHjS1Wcd9HGeQVZuP
         k1UA==
X-Gm-Message-State: APjAAAWtydMMdeGl3uIHn9IKtC9HEWafwurOgOk3VKFDL3YVrvmS7AAX
        FQ3Q32+HEzbjWw94X4vjwlNz2M9VGTp+tAESdn4=
X-Google-Smtp-Source: APXvYqxDJCZFXv159cJJVcMx2K/3Yn0/5f16K5hOh6X2t3Sz8Mejc+5u4j08HF35pBI8n0SjVqIfvMV3pR7CQohrkeY=
X-Received: by 2002:adf:db84:: with SMTP id u4mr55950637wri.317.1577522054412;
 Sat, 28 Dec 2019 00:34:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577454401.git.liu.denton@gmail.com> <4eab751a3cf00bbffaf4b1084928dad264fa1572.1577454401.git.liu.denton@gmail.com>
In-Reply-To: <4eab751a3cf00bbffaf4b1084928dad264fa1572.1577454401.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 28 Dec 2019 03:34:03 -0500
Message-ID: <CAPig+cT242CjL9S0OcS1Pbsgf-u1N=SQzNfLdao03LU2OGEciQ@mail.gmail.com>
Subject: Re: [PATCH 04/16] t2018: teach do_checkout() to accept `!` arg
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 27, 2019 at 8:47 AM Denton Liu <liu.denton@gmail.com> wrote:
> Before, we were running `test_must_fail do_checkout`. However,
> `test_must_fail` should only be used on git commands. Teach
> do_checkout() to accept `!` as a potential first argument which will
> prepend `test_must_fail` to the enclosed git command and skips the
> remainder of the function.

There's a grammatical problem here. s/skips/skip/ is one way to fix it.

Use imperative mood when writing commit messages. Drop words such as
"before" and "were". For instance:

    Stop using test_must_fail() with non-Git commands because...

(Same comment applies to pretty much all commit messages in this series.)

> This increases the granularity of the test as, instead of blindly
> checking that do_checkout() failed, we check that only the specific
> expected invocation of git fails.

This may be a case of trying to describe in prose too much of what is
better described by the code itself. As a reviewer, I spent more time
trying to figure out what this was saying that I did merely looking at
the code and comprehending why the two checks following the
git-checkout invocation should be skipped. Consequently, I lean toward
dropping "...and skips the remainder..." through the end of the commit
message.

More below...

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
> @@ -13,6 +13,12 @@ test_description='checkout'
>  #
>  # If <checkout options> is not specified, "git checkout" is run with -b.
>  do_checkout () {
> +       should_fail= &&
> +       if test "x$1" = "x!"
> +       then
> +               should_fail=test_must_fail &&
> +               shift
> +       fi &&

You forgot to update the function comment to talk about the new
optional "!" argument.

> @@ -26,10 +32,13 @@ do_checkout () {
> -       git checkout $opts $exp_branch $exp_sha &&
> +       $should_fail git checkout $opts $exp_branch $exp_sha &&

If I read this literally, it says that the git checkout should always
fail. A more wisely chosen variable name would help to alleviate this
problem.

When you start parameterizing the actual invocation of a command like
this (I'm not talking about the command arguments which are also
parameterized), the abstraction level and cognitive load increase...

> -       test $exp_ref = $(git rev-parse --symbolic-full-name HEAD) &&
> -       test $exp_sha = $(git rev-parse --verify HEAD)
> +       if test -z "$should_fail"
> +       then
> +               test $exp_ref = $(git rev-parse --symbolic-full-name HEAD) &&
> +               test $exp_sha = $(git rev-parse --verify HEAD)
> +       fi
>  }

You could reduce the cognitive load by making the code easier to
understand at-a-glance (though at the cost of a minor bit of
duplication) by structuring it instead like this:

    if test -n "$should_fail"
    then
        test_must_fail git checkout $opts $exp_branch $exp_sha
    else
        git checkout $opts $exp_branch $exp_sha &&
        test $exp_ref = $(git rev-parse --symbolic-full-name HEAD) &&
        test $exp_sha = $(git rev-parse --verify HEAD)
    fi

where 'should_fail' is either empty or non-empty depending upon
whether "!" was supplied as an argument. (And, when coded this way,
"should_fail" is a reasonable variable name.)

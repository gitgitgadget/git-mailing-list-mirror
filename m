Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3403BC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 04:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344469AbiBPESN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 23:18:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344482AbiBPERi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 23:17:38 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08B33F884
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 20:17:01 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h18so1744428edb.7
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 20:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bAmiqaproIGGa3i8BhtSXY9/KRElAje4nL0//fj4aOM=;
        b=YlmYCsxHkllhusNWYDfyDg8+6N6W9O7DJn7Ma1ww7WLIQwcOcTc8L0yCGjcZQDtZnk
         hiC+IfU0EjkYHXTsiO5q4KGaPTjwFMOlZDKrAlnyF85nNPPzQ1ZTSEHP7NnspL7UbnsE
         Fhx2c8BpBqf9a/A0drmoBILkvbFYhnMosVmm0hpn1QxJSZBSR1/wAUpKc0ZCi2BUXoY2
         +tGgBVbiMTdz0DZVtt3E+B6MkdHhsCxBSw08UOkqHFO1EjNPEcAP6J5VBffd2PTiABRW
         l3M906tOGIPGfarv9EVa76XVI7oxdIVuoG4p1dQA06RL57xJQMj0uaQrGcdJSLh3WHVE
         63nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bAmiqaproIGGa3i8BhtSXY9/KRElAje4nL0//fj4aOM=;
        b=x4BDwJ5cufgLpTH2nXQt1PaPmvlIsFnF9V6930QllsWJsNaPl8v+lKQvjIWtqD+b5b
         OALXfYLekWCLtkjxdGnGd0N7nGsQ9mCW6QJ0T2dAend01mfyRWBFQS8ox9IaYS85eU/h
         t4drK+3aZvrXukiRMml2Anb/4Bxr1rsKG+JQAm1PXNl7lZrBcIh6kAKPjXTKwxI+c+85
         mC5ZcIm4mkczxPFTwgOPPxv6YISkyYu2DArk+JIV2ReeE2JcZsAa9LQ8PR5HnuF9/fk4
         5S5rHbnzPJj3hstklfkqFXfwKK6yGXOeOMl+OxZFTGsKwfpEB6AsYG4QFJX8cx2fMoRN
         vtYQ==
X-Gm-Message-State: AOAM531U3hNvdyLNrFHtJjOjDTmKCtb3OHbzMIrYxvySXc0n9rF/gkC3
        3++VHtVju/b2fMw+tKNIorURcopQsaS05YyoW3o=
X-Google-Smtp-Source: ABdhPJwTjD/PN49gXh2o+jRK9kZVjAFa8FdVd8oHjr0QjOyrklWhy+I/1cUhy4pEL/AY8YbO6AmKIvWtjMdzJf8owaQ=
X-Received: by 2002:a05:6402:27ca:b0:410:1249:7c85 with SMTP id
 c10-20020a05640227ca00b0041012497c85mr1019518ede.192.1644985020186; Tue, 15
 Feb 2022 20:17:00 -0800 (PST)
MIME-Version: 1.0
References: <20220215221615.20683-1-patrick.marlier@gmail.com> <20220215221615.20683-2-patrick.marlier@gmail.com>
In-Reply-To: <20220215221615.20683-2-patrick.marlier@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Feb 2022 20:16:48 -0800
Message-ID: <CABPp-BFnrd4=DM-xQtw+j=LRkA4fwYp1EZ2j3cBVjZRsYPU-9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] clean: avoid to differentiate untracked and ignored
 when appropriate
To:     Patrick Marlier <patrick.marlier@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 15, 2022 at 2:16 PM Patrick Marlier
<patrick.marlier@gmail.com> wrote:

Could I suggest a bit longer commit message?  Perhaps:

"""
clean: avoid traversing into untracked dirs when unnecessary

When deleting all untracked and ignored files and any nested
repositories (such as with `git clean -ffdx`), we do not need to recurse
into an untracked directory to see if any of the entries under it are
ignored or a nested repository.  Special case this condition to avoid
unnecessary recursion.
"""

> ---
>  builtin/clean.c  |  4 +++-
>  t/t7300-clean.sh | 24 ++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 18b37e3fd9..1b1454d052 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -978,7 +978,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>                 remove_directories = 1;
>         }
>
> -       if (remove_directories && !ignored_only) {
> +       if (remove_directories && ignored && !exclude_list.nr && force > 1)
> +               ; /* No need to recurse to look for ignored files */
> +       else if (remove_directories && !ignored_only) {
>                 /*
>                  * We need to know about ignored files too:
>                  *
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index 0399701e62..684eba914b 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -788,4 +788,28 @@ test_expect_success 'traverse into directories that may have ignored entries' '
>         )
>  '
>
> +test_expect_success 'avoid traversing into untracked directories' '
> +       test_when_finished rm -f output error trace.* &&
> +       test_create_repo avoid-traversing-untracked-hierarchy &&

I think you may have been copying from an example earlier in the file
that I like wrote.  As someone else recently pointed out to me,
t/test-lib-functions.sh points out that test_create_repo is deprecated
and we should just use "git init <dirname>" instead.

> +       (
> +               cd avoid-traversing-untracked-hierarchy &&
> +
> +               mkdir -p untracked/subdir/with/b &&
> +               mkdir -p untracked/subdir/with/a &&
> +               >untracked/subdir/with/a/random-file.txt &&
> +
> +               GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
> +               git clean -ffdx
> +       ) &&
> +
> +       # Make sure we only visited into the top-level directory, and did
> +       # not traverse into the "untracked" subdirectory since it was excluded
> +       grep data.*read_directo.*directories-visited trace.output |
> +               cut -d "|" -f 9 >trace.relevant &&
> +       cat >trace.expect <<-EOF &&
> +        ..directories-visited:1
> +       EOF
> +       test_cmp trace.expect trace.relevant
> +'
> +
>  test_done
> --
> 2.35.1

Looks good, other than those minor items.  Thanks for working on this!

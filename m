Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958D5C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 16:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhLIQel (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbhLIQek (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 11:34:40 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F12C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 08:31:07 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id t5so21151956edd.0
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 08:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJ8ADoCYWcekDKwUVv9Zkr/dzeflmzkMl4wEJ8MEuHU=;
        b=R2yf5A40oYsyxBcraeza5/JHlFbDmT6Mx8IO5fyJ3N/xbd4HwCCW11ubf6Tzq8x8m3
         EF6YYBUINZ/09HULdCHEyyFWhbMBnGQQuj0+m+JAQKKeNfrtQecgLbuKHMgSiz0Kns5Y
         LMVNK42j2KCL+reUhLaCZTXg2nkL4ExJB50Ru5x1xThyeH56EgHCG/+6fuCDONRBXehV
         Q/+/aXohW2F7zYNcIBU1j1l4115yFGmZ3f/mFABMoKUHuFdKcK6Iwt+EPrDJDue/3J07
         TJJhd2jjcuAkxcfXS+IJwTGRxu4oOeN3nAtyjRqKORkbI9yC1EzozZ3rOrWiBuS9YDof
         03qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJ8ADoCYWcekDKwUVv9Zkr/dzeflmzkMl4wEJ8MEuHU=;
        b=dbgeU+rIbt1MAEyfn2R3Vv/H8vGIYyvAJEVQKnkuZIcs6SH0lyzXH/98oXFEuvDBzj
         b07qqOMjn8Frzyd3wvf9kYWgnLxUnaMZgfY8vkeVJSG1qenhroNiONyb0PiHiA9VezzW
         lxoMDLglZQeGc6g8ZCbNWH3OQVElmV9oQ0PI7Y6GhsvCJm9g8T/1LeD+d3jCCfN4ug9E
         A/slaj1BmtnbxB6PGrsaGlyuY+EcM9EG03LQW9tdVA9Y5sVNkMgn7e+ZsJ2o1SwRyQY5
         P6+uGLsvVmoAxYwTK2C857GsUqnwogVowUhjFBCNlckaXQEfzprS6ulou6LIhQu/ItXW
         56Zg==
X-Gm-Message-State: AOAM533FIEWGbpVlTKFl2akWpuxJDbWm74Zx0s6QcLrfVAmwB3yIK5MH
        6e9fb7DlDo3Jq4BQoYf7G3totibR7ebExmFmiFU=
X-Google-Smtp-Source: ABdhPJwOvxjXQC1l4pSg6Oxf9Z7LAItNBpVJ0sWOkhFi2OUaGbCW9vi6Pndkp+RcM83S0UC63gOi2zAYayNAUWfbblg=
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr30449916edu.186.1639067286916;
 Thu, 09 Dec 2021 08:28:06 -0800 (PST)
MIME-Version: 1.0
References: <20211209051115.52629-1-sunshine@sunshineco.com> <20211209051115.52629-3-sunshine@sunshineco.com>
In-Reply-To: <20211209051115.52629-3-sunshine@sunshineco.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Dec 2021 08:27:55 -0800
Message-ID: <CABPp-BGBZ6_CqbUg3=sK2b4yELC5NHHyH68_df22n=t=hARH_g@mail.gmail.com>
Subject: Re: [PATCH 02/19] t1010: fix unnoticed failure on Windows
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <ericsunshine@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 9, 2021 at 12:22 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Microsoft Windows, a directory name should never end with a period.
> Quoting from Microsoft documentation[1]:
>
>     Do not end a file or directory name with a space or a period.
>     Although the underlying file system may support such names, the
>     Windows shell and user interface does not.
>
> Naming a directory with a trailing period is indeed perilous:
>
>     % git init foo
>     % cd foo
>     % mkdir a.
>     % git status
>     warning: could not open directory 'a./': No such file or directory
>
> The t1010 "setup" test:
>
>     for d in a a. a0
>     do
>         mkdir "$d" && echo "$d/one" >"$d/one" &&
>         git add "$d"
>     done &&
>
> runs afoul of this Windows limitation, as can be observed when running
> the test verbosely:
>
>     error: open("a./one"): No such file or directory
>     error: unable to index file 'a./one'
>     fatal: adding files failed
>
> The reason this problem has gone unnoticed for so long is twofold.
> First, the failed `git add` is swallowed silently because the loop is
> not terminated explicitly by `|| return 1` to signal the failure.
> Second, none of the tests in this script care about the actual directory
> names or even the number of tree entries.

Is this true?  The names look like they were selected on the basis that
    '.' < '/' < '0'

> They care only that the tree
> synthesized in the index and created by `git write-tree` matches the
> tree created by the output of `git ls-tree` fed into `git mktree`, and
> the failure of `git add "a./one"` doesn't change that outcome.

We have multiple paths in the code that write tree structures, and
it's important that the order be
  100644 blob $OID1 a.
  040000 tree $OID2 a
  100644 blob $OID3 a0

i.e. that 'a' as a tree object sorts as though it were actually named
'a/'.  I suspect the code might have been making sure that the
different paths creating tree objects did so consistently, and the
special handling of subdirectories is the edge case that needs careful
checks.

> Skipping these tests on Windows by, for instance, checking the
> FUNNYNAMES predicate would avoid the problem, however, the funny-looking
> name is not what is being tested here. Rather, the tests are about
> checking that `git mktree` produces stable results for various input
> conditions, such as when the input order is not consistent or when an
> object is missing.
>
> Therefore, resolve the problem simply by using a directory name which is
> legal on Windows (i.e. "a-" rather than "a."). While at it, add the
> missing `|| return 1` to the loop body in order to catch this sort of
> problem in the future.

The choice to replace '.' with '-' is excellent since '-' < '/' as well.

>
> [1]: https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/t1010-mktree.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
> index 48bfad07ab..3c08194526 100755
> --- a/t/t1010-mktree.sh
> +++ b/t/t1010-mktree.sh
> @@ -6,10 +6,10 @@ TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>
>  test_expect_success setup '
> -       for d in a a. a0
> +       for d in a a- a0
>         do
>                 mkdir "$d" && echo "$d/one" >"$d/one" &&
> -               git add "$d"
> +               git add "$d" || return 1
>         done &&
>         echo zero >one &&
>         git update-index --add --info-only one &&
> --
> 2.34.1.307.g9b7440fafd

The patch itself looks good; I'm just slightly unsure about the one
claim in the commit message.

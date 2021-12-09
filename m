Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6097BC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 16:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241362AbhLIQ4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238100AbhLIQ4j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 11:56:39 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB23C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 08:53:06 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id e3so21828923edu.4
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 08:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/ww5wk11CGoI+BPqVupFrc3cftj+sfFycJN9H229gY=;
        b=CBt6b2pdZ2EDX+HAqsHMbv2AY99U4YQcT9hsUTtIOLbYvsPlHy2UaWIpTo6K29nvR8
         nxcxlHKR9FgM9e2LXNUyzxIVAu86r7bKLLfwo7YLgfAUdjq445wGYdJgtm7aZpkAbvxp
         fn2J4s21QCDgpeQhIeCdDXd3bl3887cLPBZsXDbKIV2nctvAfxOPent1k1uq9FN+TWvQ
         IET8ymH8YO18tjiLzc5YsVyVUcqVAti8DLp9i+fPlKxzLmatrxmStn06ovp76yGXWZTZ
         JqQMz2z4uSwvcaD0kyBdPeGfBMYwpGhbsU2LJmWWrXoPGUj8/wPFIjrmT5YCVZ/WxlHO
         uGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/ww5wk11CGoI+BPqVupFrc3cftj+sfFycJN9H229gY=;
        b=ysXnFtCqfinG3o7d+qj/yVK47m7kj+3Epq84ArXi+ciuBb5h1ToZ0paiIVu+ShjTha
         rr1AQtXutoMjNFmTkrQTt5WiqdVBnMWewvNoxMJi6tOgjVxpJB+9iBHfUcDXaPHlIC8C
         lIA5p78XhhiNRSQyDz8F4823sWnEAYuce5jMxd0FWKeB/ZDch2THWGSJRdCmfzpbeldm
         zovMS6cRfOwt3Y/VQqLjeosvKKdQ1uB1E1YkqvLVkTBDwMJ+Vr6FuooG5YVtA+jCUlOW
         +2/quRoWbzT7KaK879FtQYAlon8KOUJ1tdpjqJL5Ntd/cvm6oq7GXbKcL6jEUAvbK0D6
         cQvA==
X-Gm-Message-State: AOAM531gi54AMMVvOFOerN41a5pqrOCoYleYpCBYku5NFjBkF7K2mVsA
        n3llQswLIzwAhkTzLbuOSOSR/oNjsYvHKxeFfX8=
X-Google-Smtp-Source: ABdhPJzE6VXz8VEwo0Xobx0Rqyv/NFF76OK00Cpa3z3O6PpzbNyP6/G7AZL5bri/CY8U9wpsAclbJ1KBmnSi+Rz4TFI=
X-Received: by 2002:a17:906:7209:: with SMTP id m9mr16994912ejk.434.1639068642982;
 Thu, 09 Dec 2021 08:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20211209051115.52629-1-sunshine@sunshineco.com> <20211209051115.52629-16-sunshine@sunshineco.com>
In-Reply-To: <20211209051115.52629-16-sunshine@sunshineco.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Dec 2021 08:50:31 -0800
Message-ID: <CABPp-BGrjPKJAp_-yOH37d84Y0LhGwTOSboOm9xFYXp+68BrWw@mail.gmail.com>
Subject: Re: [PATCH 15/19] tests: simplify by dropping unnecessary `for` loops
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <ericsunshine@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 8, 2021 at 11:39 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> Rather than manually looping over a set of items and plugging those
> items into a template string which is printed repeatedly, achieve the
> same effect by taking advantage of `printf` which loops over its
> arguments automatically.

I didn't know this about printf; handy.

Patch looks good.

>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/t3005-ls-files-relative.sh      | 10 ++--------
>  t/t3600-rm.sh                     |  5 +----
>  t/t4025-hunk-header.sh            | 10 ++--------
>  t/t4125-apply-ws-fuzz.sh          |  5 +----
>  t/t6416-recursive-corner-cases.sh | 30 ++++++------------------------
>  t/t7110-reset-merge.sh            |  2 +-
>  t/t9400-git-cvsserver-server.sh   |  2 +-
>  7 files changed, 14 insertions(+), 50 deletions(-)
>
> diff --git a/t/t3005-ls-files-relative.sh b/t/t3005-ls-files-relative.sh
> index 6ba8b589cd..fbfa210a50 100755
> --- a/t/t3005-ls-files-relative.sh
> +++ b/t/t3005-ls-files-relative.sh
> @@ -39,10 +39,7 @@ test_expect_success 'ls-files with mixed levels' '
>  test_expect_success 'ls-files -c' '
>         (
>                 cd top/sub &&
> -               for f in ../y*
> -               do
> -                       echo "error: pathspec $SQ$f$SQ did not match any file(s) known to git"
> -               done >expect.err &&
> +               printf "error: pathspec $SQ%s$SQ did not match any file(s) known to git\n" ../y* >expect.err &&
>                 echo "Did you forget to ${SQ}git add${SQ}?" >>expect.err &&
>                 ls ../x* >expect.out &&
>                 test_must_fail git ls-files -c --error-unmatch ../[xy]* >actual.out 2>actual.err &&
> @@ -54,10 +51,7 @@ test_expect_success 'ls-files -c' '
>  test_expect_success 'ls-files -o' '
>         (
>                 cd top/sub &&
> -               for f in ../x*
> -               do
> -                       echo "error: pathspec $SQ$f$SQ did not match any file(s) known to git"
> -               done >expect.err &&
> +               printf "error: pathspec $SQ%s$SQ did not match any file(s) known to git\n" ../x* >expect.err &&
>                 echo "Did you forget to ${SQ}git add${SQ}?" >>expect.err &&
>                 ls ../y* >expect.out &&
>                 test_must_fail git ls-files -o --error-unmatch ../[xy]* >actual.out 2>actual.err &&
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index ed3952eb98..e74a318ac3 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -274,10 +274,7 @@ test_expect_success 'Resolving by removal is not a warning-worthy event' '
>         git reset -q --hard &&
>         test_when_finished "rm -f .git/index.lock msg && git reset -q --hard" &&
>         blob=$(echo blob | git hash-object -w --stdin) &&
> -       for stage in 1 2 3
> -       do
> -               echo "100644 $blob $stage       blob"
> -       done | git update-index --index-info &&
> +       printf "100644 $blob %d\tblob\n" 1 2 3 | git update-index --index-info &&
>         git rm blob >msg 2>&1 &&
>         test_i18ngrep ! "needs merge" msg &&
>         test_must_fail git ls-files -s --error-unmatch blob
> diff --git a/t/t4025-hunk-header.sh b/t/t4025-hunk-header.sh
> index 6356961de4..5397cb7d42 100755
> --- a/t/t4025-hunk-header.sh
> +++ b/t/t4025-hunk-header.sh
> @@ -14,15 +14,9 @@ test_expect_success setup '
>
>         (
>                 echo "A $NS" &&
> -               for c in B C D E F G H I J K
> -               do
> -                       echo "  $c"
> -               done &&
> +               printf "  %s\n" B C D E F G H I J K &&
>                 echo "L  $NS" &&
> -               for c in M N O P Q R S T U V
> -               do
> -                       echo "  $c"
> -               done
> +               printf "  %s\n" M N O P Q R S T U V
>         ) >file &&
>         git add file &&
>
> diff --git a/t/t4125-apply-ws-fuzz.sh b/t/t4125-apply-ws-fuzz.sh
> index 9671de7999..090987c89b 100755
> --- a/t/t4125-apply-ws-fuzz.sh
> +++ b/t/t4125-apply-ws-fuzz.sh
> @@ -10,10 +10,7 @@ test_expect_success setup '
>         git add file &&
>
>         # file-0 is full of whitespace breakages
> -       for l in a bb c d eeee f ggg h
> -       do
> -               echo "$l "
> -       done >file-0 &&
> +       printf "%s \n" a bb c d eeee f ggg h >file-0 &&
>
>         # patch-0 creates a whitespace broken file
>         cat file-0 >file &&
> diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
> index 84f5082366..690c8482b1 100755
> --- a/t/t6416-recursive-corner-cases.sh
> +++ b/t/t6416-recursive-corner-cases.sh
> @@ -24,14 +24,8 @@ test_expect_success 'setup basic criss-cross + rename with no modifications' '
>                 cd basic-rename &&
>
>                 ten="0 1 2 3 4 5 6 7 8 9" &&
> -               for i in $ten
> -               do
> -                       echo line $i in a sample file
> -               done >one &&
> -               for i in $ten
> -               do
> -                       echo line $i in another sample file
> -               done >two &&
> +               printf "line %d in a sample file\n" $ten >one &&
> +               printf "line %d in another sample file\n" $ten >two &&
>                 git add one two &&
>                 test_tick && git commit -m initial &&
>
> @@ -96,14 +90,8 @@ test_expect_success 'setup criss-cross + rename merges with basic modification'
>                 cd rename-modify &&
>
>                 ten="0 1 2 3 4 5 6 7 8 9" &&
> -               for i in $ten
> -               do
> -                       echo line $i in a sample file
> -               done >one &&
> -               for i in $ten
> -               do
> -                       echo line $i in another sample file
> -               done >two &&
> +               printf "line %d in a sample file\n" $ten >one &&
> +               printf "line %d in another sample file\n" $ten >two &&
>                 git add one two &&
>                 test_tick && git commit -m initial &&
>
> @@ -1588,10 +1576,7 @@ test_expect_success 'setup nested conflicts' '
>                 cd nested_conflicts &&
>
>                 # Create some related files now
> -               for i in $(test_seq 1 10)
> -               do
> -                       echo Random base content line $i
> -               done >initial &&
> +               printf "Random base content line %d\n" $(test_seq 1 10) >initial &&
>
>                 cp initial b_L1 &&
>                 cp initial b_R1 &&
> @@ -1777,10 +1762,7 @@ test_expect_success 'setup virtual merge base with nested conflicts' '
>                 cd virtual_merge_base_has_nested_conflicts &&
>
>                 # Create some related files now
> -               for i in $(test_seq 1 10)
> -               do
> -                       echo Random base content line $i
> -               done >content &&
> +               printf "Random base content line %d\n" $(test_seq 1 10) >content &&
>
>                 # Setup original commit
>                 git add content &&
> diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
> index a82a07a04a..3d62e10b53 100755
> --- a/t/t7110-reset-merge.sh
> +++ b/t/t7110-reset-merge.sh
> @@ -8,7 +8,7 @@ test_description='Tests for "git reset" with "--merge" and "--keep" options'
>  . ./test-lib.sh
>
>  test_expect_success setup '
> -    for i in 1 2 3; do echo line $i; done >file1 &&
> +    printf "line %d\n" 1 2 3 >file1 &&
>      cat file1 >file2 &&
>      git add file1 file2 &&
>      test_tick &&
> diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
> index a6a73effde..a60fe2e19f 100755
> --- a/t/t9400-git-cvsserver-server.sh
> +++ b/t/t9400-git-cvsserver-server.sh
> @@ -591,7 +591,7 @@ test_expect_success 'cvs annotate' '
>      cd cvswork &&
>      GIT_CONFIG="$git_config" cvs annotate merge >../out &&
>      sed -e "s/ .*//" ../out >../actual &&
> -    for i in 3 1 1 1 1 1 1 1 2 4; do echo 1.$i; done >../expect &&
> +    printf "1.%d\n" 3 1 1 1 1 1 1 1 2 4 >../expect &&
>      test_cmp ../expect ../actual
>  '
>
> --
> 2.34.1.307.g9b7440fafd
>

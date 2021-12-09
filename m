Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EECC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 16:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbhLIQuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbhLIQuL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 11:50:11 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD91AC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 08:46:37 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id l25so21525245eda.11
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 08:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8iMBeqt/kjFmmYzc7UWbxTqkLii7eRsNZy9vLgnJl9M=;
        b=csp+fxKhIfW7+4kiSB37F2FtqyjC6cPFujvI31w3WZ63E/+8Mj33FVLlHfDEUKRwoC
         RneA2fl+AG6xiotIEygloOXVjcsTcHmpLcJl5xOtcxM2zungv2E08u/313mpJny4MUpC
         v5cpbXGGst8eBNt3S2qLXg2k0UxIWZbuJ0Nofimi47JtUyBQyg7Nk1v4uJw6rkvqGPmb
         KQHi7VO/TTGqghAnu5u2n0OfYL86bmAsP2/pdfexXOaf4Gp8GrQ9+V0HsR15etJ3V9n/
         DZP27NAVwzN0PaQtXADaaY9PecRRbMJE6xZcjTQs3v3nYPCMbjU1VfpsB/Imjzze6Mo5
         12Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8iMBeqt/kjFmmYzc7UWbxTqkLii7eRsNZy9vLgnJl9M=;
        b=uP52bceHhA4M7FiijxghUbzVYfITHPK1/AYv4aQKPkojwAhpR9RrG9u99WcxwoyqvH
         BueVA/53E79lnRbXjDzV1Mo/q5lB1ftV0r+5tc8mYmevw40K9GJVyrrY+uRmBsnECP8k
         CGbVhdq9H3eE5qWWRtFBsz5wu5f9f9Ox2Qs0p5AcZWkDZLPuNwFrYdQbTcEM/7qo6zmj
         +rWyEGVS5+4c5kZnbl2ZMAtuijBCVRFEIB9IHU8VQV9457lxB0a7ccWUxZQ3dxFx7jO1
         sT6ri+dJGHxfYIZ/z9oc34tEn25fmVF4M0dYN2K2TQmjMseLE1bdNnSKz4VPMZHzo/rf
         w1Mg==
X-Gm-Message-State: AOAM53069Xal1ACtMK6vGciZIPZ0mDATEjuj2SXj06Ewu441ZJ7hhh3d
        IMLxAiTIKcvfLwXdBb1vevc3fypbYf6koxUEixw=
X-Google-Smtp-Source: ABdhPJyKyBzfgxrH9YCxo6ETIr2XkkWdhlYNwK3T7d8jCOWYDtozpyiqsNjOmQY/GwUSmGSM4RLmW5ilKKwRbxFYj/Q=
X-Received: by 2002:a17:907:1c9d:: with SMTP id nb29mr17749315ejc.74.1639068280674;
 Thu, 09 Dec 2021 08:44:40 -0800 (PST)
MIME-Version: 1.0
References: <20211209051115.52629-1-sunshine@sunshineco.com> <20211209051115.52629-12-sunshine@sunshineco.com>
In-Reply-To: <20211209051115.52629-12-sunshine@sunshineco.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Dec 2021 08:44:29 -0800
Message-ID: <CABPp-BGBhxbvh_Ob=bR8U9f-3muiBzWmFruKLXd=K7420i8COw@mail.gmail.com>
Subject: Re: [PATCH 11/19] tests: fix broken &&-chains in `$(...)` command substitutions
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <ericsunshine@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 8, 2021 at 11:39 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> The top-level &&-chain checker built into t/test-lib.sh causes tests to
> magically exit with code 117 if the &&-chain is broken. However, it has
> the shortcoming that the magic does not work within `{...}` groups,
> `(...)` subshells, `$(...)` substitutions, or within bodies of compound
> statements, such as `if`, `for`, `while`, `case`, etc. `chainlint.sed`
> partly fills in the gap by catching broken &&-chains in `(...)`
> subshells, but bugs can still lurk behind broken &&-chains in the other
> cases.
>
> Fix broken &&-chains in `$(...)` command substitutions in order to
> reduce the number of possible lurking bugs.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  contrib/subtree/t/t7900-subtree.sh |  2 +-
>  t/t0005-signals.sh                 |  2 +-
>  t/t0060-path-utils.sh              |  4 ++--
>  t/t1006-cat-file.sh                | 10 +++++-----
>  t/t3600-rm.sh                      |  2 +-
>  t/t7010-setup.sh                   |  2 +-
>  6 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index 4153b65321..1c1f76f04a 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -1445,7 +1445,7 @@ test_expect_success 'subtree descendant check' '
>         ) &&
>         test_create_commit "$test_count" folder_subtree/0 &&
>         test_create_commit "$test_count" folder_subtree/b &&
> -       cherry=$(cd "$test_count"; git rev-parse HEAD) &&
> +       cherry=$(cd "$test_count" && git rev-parse HEAD) &&
>         (
>                 cd "$test_count" &&
>                 git checkout branch
> diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
> index a5ec6a0315..eba75a2490 100755
> --- a/t/t0005-signals.sh
> +++ b/t/t0005-signals.sh
> @@ -48,7 +48,7 @@ test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
>  '
>
>  test_expect_success !MINGW 'a constipated git dies with SIGPIPE even if parent ignores it' '
> -       OUT=$( ((trap "" PIPE; large_git; echo $? 1>&3) | :) 3>&1 ) &&
> +       OUT=$( ((trap "" PIPE && large_git; echo $? 1>&3) | :) 3>&1 ) &&

Shouldn't the second ';' be replaced with '&&' as well?

>         test_match_signal 13 "$OUT"
>  '
>
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 34d1061f32..71a5d370cc 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -216,7 +216,7 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
>         mkdir second &&
>         ln -s ../first second/other &&
>         mkdir third &&
> -       dir="$(cd .git; pwd -P)" &&
> +       dir="$(cd .git && pwd -P)" &&
>         dir2=third/../second/other/.git &&
>         test "$dir" = "$(test-tool path-utils real_path $dir2)" &&
>         file="$dir"/index &&
> @@ -224,7 +224,7 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
>         basename=blub &&
>         test "$dir/$basename" = "$(cd .git && test-tool path-utils real_path "$basename")" &&
>         ln -s ../first/file .git/syml &&
> -       sym="$(cd first; pwd -P)"/file &&
> +       sym="$(cd first && pwd -P)"/file &&
>         test "$sym" = "$(test-tool path-utils real_path "$dir2/syml")"
>  '
>
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 658628375c..67a3f64c2d 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -211,14 +211,14 @@ done
>  test_expect_success "--batch-check for a non-existent named object" '
>      test "foobar42 missing
>  foobar84 missing" = \
> -    "$( ( echo foobar42; echo_without_newline foobar84; ) | git cat-file --batch-check)"
> +    "$( ( echo foobar42 && echo_without_newline foobar84 ) | git cat-file --batch-check)"
>  '
>
>  test_expect_success "--batch-check for a non-existent hash" '
>      test "0000000000000000000000000000000000000042 missing
>  0000000000000000000000000000000000000084 missing" = \
> -    "$( ( echo 0000000000000000000000000000000000000042;
> -        echo_without_newline 0000000000000000000000000000000000000084; ) |
> +    "$( ( echo 0000000000000000000000000000000000000042 &&
> +        echo_without_newline 0000000000000000000000000000000000000084 ) |
>         git cat-file --batch-check)"
>  '
>
> @@ -226,8 +226,8 @@ test_expect_success "--batch for an existent and a non-existent hash" '
>      test "$tag_sha1 tag $tag_size
>  $tag_content
>  0000000000000000000000000000000000000000 missing" = \
> -    "$( ( echo $tag_sha1;
> -        echo_without_newline 0000000000000000000000000000000000000000; ) |
> +    "$( ( echo $tag_sha1 &&
> +        echo_without_newline 0000000000000000000000000000000000000000 ) |
>         git cat-file --batch)"
>  '
>
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index bb9ef35dac..ed3952eb98 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -265,7 +265,7 @@ test_expect_success 'choking "git rm" should not let it die with cruft (induce S
>
>  test_expect_success !MINGW 'choking "git rm" should not let it die with cruft (induce and check SIGPIPE)' '
>         choke_git_rm_setup &&
> -       OUT=$( ((trap "" PIPE; git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&
> +       OUT=$( ((trap "" PIPE && git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&

Same here; shouldn't the second ';' be replaced with '&&' as well?

>         test_match_signal 13 "$OUT" &&
>         test_path_is_missing .git/index.lock
>  '
> diff --git a/t/t7010-setup.sh b/t/t7010-setup.sh
> index 0335a9a158..520f96d09f 100755
> --- a/t/t7010-setup.sh
> +++ b/t/t7010-setup.sh
> @@ -137,7 +137,7 @@ test_expect_success 'setup deeper work tree' '
>
>  test_expect_success 'add a directory outside the work tree' '(
>         cd tester &&
> -       d1="$(cd .. ; pwd)" &&
> +       d1="$(cd .. && pwd)" &&
>         test_must_fail git add "$d1"
>  )'
>
> --
> 2.34.1.307.g9b7440fafd
>

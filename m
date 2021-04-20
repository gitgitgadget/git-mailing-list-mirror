Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E851C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 21:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6B6661416
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 21:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbhDTVwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 17:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbhDTVws (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 17:52:48 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ACEC06138A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 14:52:16 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id v6so12647631oiv.3
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 14:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+TKuqEGBuCn+ytwF6yYXVT5rJ2LgSnnRQWVv8Ol7kCQ=;
        b=Aie73n7fZD4ZqjLejYfs5Ktp1ukC47iOtCBjiWihO1y92RmPnAAi0Mf/3HNVFPKq9z
         xihD5uNMUp+IRR/5R//F/kki2QTZkGzGgGkfmj3uXzOjtgthF/+CO1yJzfemddWdQNFb
         h0gI2g5sKIZoTxnoWm0xv+dqYmClXjBMSRlJ2Et/21ajpRZoNq8ul7f6dW+GoRUjC66X
         mRF9+so+zlH1PP4dJKH7PRBdoKOOHkHWP4h1rN+vOV//vZaZAShpi726Au9vCXtkxLg5
         ETjJCixgBYEB+5txOrO/pX0s1uufxIj1vnqcgSM/rFpDn8Q4waZWGiNh4OJ/C2dtdayp
         n5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+TKuqEGBuCn+ytwF6yYXVT5rJ2LgSnnRQWVv8Ol7kCQ=;
        b=uU1tNslGQeebMP8gP/2gkCdpTRj6jnNa15LJAXlAQxpZQzyk0Plrqw9FrmIXqf6E98
         alli5KZutSZCuJdnDCaDl7O/u+CQiGRPmMkOabUf8uuMgQVTpR+ePHJ8OtXlcGYFD4Tg
         L5BH8tmCfym1vI2X5GJpK2RdsZs50JWPJsCowMiTlVJ3SS9vTrVeQeWFloX0/e0LhfSf
         tf2H70LE8AeT/ZmSh2QMJYiSnNa1+TyFxxAnAZf1Zl7pc2bqpxPPPX7yOqOblxkcCMA9
         VKhnsB+nWNV6snX8KgOQfEY4l1/q7ke5Elvcz8XAqS+joMCUP2iuIINrrUIgyg5WQvk+
         my4Q==
X-Gm-Message-State: AOAM533fmAZGuiokik6D3vKGdZyOImj/VadWaiINjiYK2mgiLkAdJa0X
        bCnU7O0Sr2gcx6CuZwG7NVPEkAwp+tXwUdlZTCU=
X-Google-Smtp-Source: ABdhPJy5hU9Fg6iZe4Q3DKm7/WNtof1M7Z1qgUvzSGVxhA9KXptgTLlZaGaQk6x3UamFir1F1+0Dh9SvWRcKLtfRJPg=
X-Received: by 2002:a54:4498:: with SMTP id v24mr4627655oiv.31.1618955535722;
 Tue, 20 Apr 2021 14:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.git.1618322497.gitgitgadget@gmail.com> <b2cb5401eff83c43ca805a36bf41a28a6ffc3630.1618322497.git.gitgitgadget@gmail.com>
In-Reply-To: <b2cb5401eff83c43ca805a36bf41a28a6ffc3630.1618322497.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 20 Apr 2021 14:52:04 -0700
Message-ID: <CABPp-BFhyFiKSXdLM5q5t=ZKzr6V0pY7dbheierRaOHFbMEdkg@mail.gmail.com>
Subject: Re: [PATCH 01/10] t1092: add tests for status/add and sparse files
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 7:01 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Before moving to update 'git status' and 'git add' to work with sparse
> indexes, add an explicit test that ensures the sparse-index works the
> same as a normal sparse-checkout when the worktree contains directories
> and files outside of the sparse cone.
>
> Specifically, 'folder1/a' is a file in our test repo, but 'folder1' is
> not in the sparse cone. When 'folder1/a' is modified, the file
> 'folder1/a' is shown as modified, but adding it fails. This is new
> behavior as of a20f704 (add: warn when asked to update SKIP_WORKTREE
> entries, 2021-04-08). Before that change, these adds would be silently
> ignored.
>
> Untracked files are fine: adding new files both with 'git add .' and
> 'git add folder1/' works just as in a full checkout. This may not be
> entirely desirable, but we are not intending to change behavior at the
> moment, only document it.

Personally, I'd say not desirable and we should throw an error just
like we do with skip-worktree entries that the user happens to try to
git add.  I've had reports from users that got confused by what
happens after this.  I've been meaning to create some patches to fix
it up, but wanted to avoid getting in the way of the sparse-index work
and have been a bit tied up on other projects to boot.

I'll note in particular that it's easy for users after running "git
add" to run other things such as "git sparse-checkout reapply" or "git
switch $otherbranch" and suddenly the file disappears from the working
tree.  From the sparse-checkout machinery that makes sense; this path
doesn't match the .git/info/sparse-checkout list of paths, so it
should be removed from the working tree.  But it's very disorienting
to users.  Especially if some of those commands are side-effects of
other commands (e.g. our build system invokes "git sparse-checkout
reapply" in various cases, most common of which is that even a simple
"git pull" can bring down code with dependency changes and thus a need
for new sparsity rules and whatnot), but it definitely can just happen
in ways users don't expect with their own commands (e.g. the git
switch/checkout example).

The patch looks good, but it'd be nice if while documenting it we also
add a comment that we believe we want to change the behavior (for
sparse-checkout both with and without sparse-index).  It's one of
those many paper-cuts we still have.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 36 ++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 12e6c453024f..6598c12a2069 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -232,6 +232,42 @@ test_expect_success 'add, commit, checkout' '
>         test_all_match git checkout -
>  '
>
> +test_expect_success 'status/add: outside sparse cone' '
> +       init_repos &&
> +
> +       # folder1 is at HEAD, but outside the sparse cone
> +       run_on_sparse mkdir folder1 &&
> +       cp initial-repo/folder1/a sparse-checkout/folder1/a &&
> +       cp initial-repo/folder1/a sparse-index/folder1/a &&
> +
> +       test_sparse_match git status &&
> +
> +       write_script edit-contents <<-\EOF &&
> +       echo text >>$1
> +       EOF
> +       run_on_all ../edit-contents folder1/a &&
> +       run_on_all ../edit-contents folder1/new &&
> +
> +       test_sparse_match git status --porcelain=v2 &&
> +
> +       # This "git add folder1/a" is completely ignored
> +       # by the sparse-checkout repos. It causes the
> +       # full repo to have a different staged environment.
> +       test_must_fail git -C sparse-checkout add folder1/a &&
> +       test_must_fail git -C sparse-index add folder1/a &&
> +       git -C full-checkout checkout HEAD -- folder1/a &&
> +       test_sparse_match git status --porcelain=v2 &&
> +
> +       test_all_match git add . &&
> +       test_all_match git status --porcelain=v2 &&
> +       test_all_match git commit -m folder1/new &&
> +
> +       run_on_all ../edit-contents folder1/newer &&
> +       test_all_match git add folder1/ &&
> +       test_all_match git status --porcelain=v2 &&
> +       test_all_match git commit -m folder1/newer
> +'
> +
>  test_expect_success 'checkout and reset --hard' '
>         init_repos &&
>
> --
> gitgitgadget
>

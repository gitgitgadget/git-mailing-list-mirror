Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D51DC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 07:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbhKWIBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 03:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbhKWIBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 03:01:16 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9393C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 23:58:08 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id r11so88237335edd.9
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 23:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0CtWF0wIe/MOjRXwLI0EUUwVhY8XhI+xpYbk5y5ba88=;
        b=BXUfPHIkmyqgtJFrginIkvftu1+uhs32kjjnRfvwURX7n9FkGnKFzHIyh5oN2gPq9L
         lKzoK034jhmakNNzGk/NNNdL2SqMxRxpU54Tzgua2ZJ0Iw9GmZbPUV7YUJOJnzVfyJHq
         jvJfC9E7KQMr5gUsvOGkXF4TP+2GmIpeMqn5DKYQGzPoi1/cau2Q7jRIxeBZErtCdDLk
         /qn8yUnTLaclBLaSbnx7dvt5oQ9lMjP7LQDdhQ3d8KgIDIXo6HhZF4vrv0NiTrqt5k0D
         axvbC+EYZy0CIFSdpDPzDZmEfdsDhg3VsuIPNR6vQy0eTR3WqTNr/PRVxhpE/ltpbXRR
         RYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0CtWF0wIe/MOjRXwLI0EUUwVhY8XhI+xpYbk5y5ba88=;
        b=yYqVr61IZGls+Cys9CGDOMzhd4gXmNq7CoaOJ+3bdzJX5MJ/kQkX+WFedAHn/ki4lw
         WhMjz65cdoLnksHBECp1ntT1Sr6Wjn6NLwrqiUg4OwlkInq+1AT8mPhTHiPHjENQNHqh
         3J5l/Ws+erJJAOrVBu8ZDX+chC+3NpqbL3n8hLHFjH90cMEeOiDtH0rk2C1ZX+B3YGQ8
         Fm3rtCBw0KcOoANFc/S7EQeyT3SOKrkDCcmLKBEugEiFsO4wBaJpeXf3VUjtBwzZhUpu
         ffhv7BADCsmBpv9q2B1ejacx3nQ8x9hdNWTNFhgx1IvNIrIh3LOzWQeZ6vtLa0vXmrmR
         e7vw==
X-Gm-Message-State: AOAM530QR6+TwFUOC9chLA/dLewXASCGo19XW3vdTLwK/IK9hm8QRA34
        G7hRU6bIzCtDJEmJvYjg3ZKRM9R/VPrx6K82Fqc=
X-Google-Smtp-Source: ABdhPJzEUeI1DiyU5fpozqC+uwVt5Jykt1fochUiZTi79WJfNMfOjG/7fReW3dNxmHQQNTTk4qEwmXmGLfWXB4Ryu2s=
X-Received: by 2002:a50:d543:: with SMTP id f3mr6152265edj.56.1637654287292;
 Mon, 22 Nov 2021 23:58:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.1050.git.1634232352.gitgitgadget@gmail.com> <ddcee003c9292d1b4cdd64a97f9e1731a72faee8.1634232353.git.gitgitgadget@gmail.com>
In-Reply-To: <ddcee003c9292d1b4cdd64a97f9e1731a72faee8.1634232353.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Nov 2021 23:57:55 -0800
Message-ID: <CABPp-BGM-57Xxxb-MRvkkgGFbVn4z6PEZFKryuBCwj7Ymr_oSA@mail.gmail.com>
Subject: Re: [PATCH 2/2] blame: enable and test the sparse index
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 14, 2021 at 10:25 AM Lessley Dennington via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Lessley Dennington <lessleydennington@gmail.com>
>
> Enable the sparse index for the 'git blame' command. The index was already
> not expanded with this command, so the most interesting thing to do is to
> add tests that verify that 'git blame' behaves correctly when the sparse
> index is enabled and that its performance improves. More specifically, these
> cases are:
>
> 1. The index is not expanded for 'blame' when given paths in the sparse
> checkout cone at multiple levels.
>
> 2. Performance measurably improves for 'blame' with sparse index when given
> paths in the sparse checkout cone at multiple levels.
>
> The `p2000` tests demonstrate a ~60% execution time reduction when running
> 'blame' for a file two levels deep and and a ~30% execution time reduction
> for a file three levels deep.
>
> Test                                         before  after
> ----------------------------------------------------------------
> 2000.62: git blame f2/f4/a (full-v3)         0.31    0.32 +3.2%
> 2000.63: git blame f2/f4/a (full-v4)         0.29    0.31 +6.9%
> 2000.64: git blame f2/f4/a (sparse-v3)       0.55    0.23 -58.2%
> 2000.65: git blame f2/f4/a (sparse-v4)       0.57    0.23 -59.6%
> 2000.66: git blame f2/f4/f3/a (full-v3)      0.77    0.85 +10.4%
> 2000.67: git blame f2/f4/f3/a (full-v4)      0.78    0.81 +3.8%
> 2000.68: git blame f2/f4/f3/a (sparse-v3)    1.07    0.72 -32.7%
> 2000.99: git blame f2/f4/f3/a (sparse-v4)    1.05    0.73 -30.5%

Looks good.

> We do not include paths outside the sparse checkout cone because blame
> currently does not support blaming files outside of the sparse definition.
> Attempting to do so fails with the following error:
>
> fatal: no such path '<path outside sparse definition>' in HEAD

While technically accurate, this wording is misleading; it implies
that there is something unique to sparse checkouts, and perhaps even
to cone mode, affecting how blame handles files not in the working
directory.  That's not true, though; git blame without a revision has
always reported an error when given a file that does not exist in the
working tree.  Try this in git.git:

$ rm t/README
$ git blame t/README
fatal: Cannot lstat 't/README': No such file or directory

The reason is that with no revisions, calling git blame with a
filename means asking the question "Which commit did each line in that
file come from?"  If there's no file, the question just doesn't make
sense.  You could make sense of it by thinking in terms of some
revision of the file, but then you're passing a revision along --
which works just fine in a sparse checkout too.

>
> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
> ---
>  builtin/blame.c                          |  3 +++
>  t/perf/p2000-sparse-operations.sh        |  2 ++
>  t/t1092-sparse-checkout-compatibility.sh | 24 +++++++++++++++++-------
>  3 files changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 641523ff9af..af3d81e2bd4 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -902,6 +902,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>         long anchor;
>         const int hexsz = the_hash_algo->hexsz;
>
> +       prepare_repo_settings(the_repository);
> +       the_repository->settings.command_requires_full_index = 0;
> +
>         setup_default_color_by_age();
>         git_config(git_blame_config, &output_option);
>         repo_init_revisions(the_repository, &revs, NULL);
> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
> index bff93f16e93..9ac76a049b8 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -115,5 +115,7 @@ test_perf_on_all git reset --hard
>  test_perf_on_all git reset -- does-not-exist
>  test_perf_on_all git diff
>  test_perf_on_all git diff --staged
> +test_perf_on_all git blame $SPARSE_CONE/a
> +test_perf_on_all git blame $SPARSE_CONE/f3/a
>
>  test_done
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 1070bff1a83..54826e858a9 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -485,15 +485,16 @@ test_expect_success 'blame with pathspec inside sparse definition' '
>         test_all_match git blame deep/deeper1/deepest/a
>  '
>
> -# TODO: blame currently does not support blaming files outside of the
> -# sparse definition. It complains that the file doesn't exist locally.
> -test_expect_failure 'blame with pathspec outside sparse definition' '
> +# Blame does not support blaming files outside of the sparse
> +# definition, so we verify this scenario.

As above, this is misleading.  It'd be better to word it something like:

# Without a revision specified, blame will error if passed any file that
# is not present in the working directory (even if the file is tracked).
# Here we just verify that this is also true with sparse checkouts.

> +test_expect_success 'blame with pathspec outside sparse definition' '
>         init_repos &&
>
> -       test_all_match git blame folder1/a &&
> -       test_all_match git blame folder2/a &&
> -       test_all_match git blame deep/deeper2/a &&
> -       test_all_match git blame deep/deeper2/deepest/a
> +       test_sparse_match git sparse-checkout set &&
> +       test_sparse_match test_must_fail git blame folder1/a &&
> +       test_sparse_match test_must_fail git blame folder2/a &&
> +       test_sparse_match test_must_fail git blame deep/deeper2/a &&
> +       test_sparse_match test_must_fail git blame deep/deeper2/deepest/a
>  '
>
>  test_expect_success 'checkout and reset (mixed)' '
> @@ -871,6 +872,15 @@ test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
>         )
>  '
>
> +test_expect_success 'sparse index is not expanded: blame' '
> +       init_repos &&
> +
> +       ensure_not_expanded blame a &&
> +       ensure_not_expanded blame deep/a &&
> +       ensure_not_expanded blame deep/deeper1/a &&
> +       ensure_not_expanded blame deep/deeper1/deepest/a
> +'
> +
>  # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
>  # in this scenario, but it shouldn't.
>  test_expect_success 'reset mixed and checkout orphan' '
> --
> gitgitgadget

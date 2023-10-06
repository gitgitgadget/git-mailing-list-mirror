Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8500DE92FE5
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 05:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjJFFOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 01:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjJFFOy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 01:14:54 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF2BB6
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 22:14:52 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c27d653856so34362671fa.0
        for <git@vger.kernel.org>; Thu, 05 Oct 2023 22:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696569290; x=1697174090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGXCk2RXR3iSZiHZygXzza7dmDm+5xBpo05H/cVy98w=;
        b=QyT+ozGwRFgeggzmO92ZUI5aCoWwjagIWb3NWxEso11XCPyloeBN0EuhYGZSuHQzPc
         PIV0tFpRZKL38XgIJ8Ya8gt4jMoNFu0syE5di4yYE46zwkZqBLwgaHbv6R8KmJS4tWoU
         Y4ana3rq5i5apctoCV1Wpe/1tybxy2nBTHKcwcjU9R2x7Ui9k9xyerQAKzWYxkQSr37u
         vzmaO08HmpOqVoJivG2NnEtzM3ETnelgk2gyJ+bQwcLbmAtkPwxiZZrsrcEbU4ROJ+E/
         3gJCWNIgd0qzVcJhhA0aC5BZ2/HU6cgRiITtzNFQwAbHjVfJiEfKZP6OLN0+v8KRaqUB
         8TFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696569290; x=1697174090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGXCk2RXR3iSZiHZygXzza7dmDm+5xBpo05H/cVy98w=;
        b=jupSoMbocsdZkrLfp75wxA5tVODG6RCJoXSz7jCMLGt+XVRDTMFlyhgMUbK0K9rn7V
         12B1JlAluOFGGqkJMWyY20c8ZyVnYs62Qzi1o8FOqUEEabgYAFN3HWvtM4ohKJwSWreL
         rqrF/3AvEVwbRfyCGogcpn5rXLomb1YjBe2cZqdWaz5y74yToGOO9QN/VQ3ydndBZ9LC
         01uEhbjHWttiEnuryeEGNlBnChgxX3aoyyQzjbFALiNpU6+T8matqsmvIA8Vn0e02YhL
         k27wGsyf/sv/dsrmca/h0PjQ7BngBuINYkvMKxoWTP0ndywRYapwwc16PvkTkX+wbOmd
         O7mA==
X-Gm-Message-State: AOJu0YzX14EepMhuNUqHihNaQK3ZSFJAdmJjXkL2FY3echtVdkw79oAF
        +zptPSyuBTuBCZwBm9Mqpt+HzjbjzACcz6GRxSoB1eb+sKo=
X-Google-Smtp-Source: AGHT+IFLI3oxLroIwQxwghmrZ3ZYXl1qqfkEcfNWLSIoRF/oROKXr7zaf8ecDQc6pMU3KbKFTvmYUo4al/8x7BXTPP0=
X-Received: by 2002:a2e:a546:0:b0:2bf:f861:f523 with SMTP id
 e6-20020a2ea546000000b002bff861f523mr4607187ljn.4.1696569290248; Thu, 05 Oct
 2023 22:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1583.git.git.1696519349407.gitgitgadget@gmail.com>
In-Reply-To: <pull.1583.git.git.1696519349407.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 5 Oct 2023 22:14:38 -0700
Message-ID: <CABPp-BG_cQ011a15HSVRtJDq7MxgqY2_tD8aZm0Qc4F6ZU0NPA@mail.gmail.com>
Subject: Re: [PATCH] merge-ort: initialize repo in index state
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 5, 2023 at 9:14=E2=80=AFAM John Cai via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: John Cai <johncai86@gmail.com>
>
> initialize_attr_index() does not initialize the repo member of
> attr_index. Starting in 44451a2e5e (attr: teach "--attr-source=3D<tree>"
> global option to "git", 2023-05-06), this became a problem because
> istate->repo gets passed down the call chain starting in
> git_check_attr(). This gets passed all the way down to
> replace_refs_enabled(), which segfaults when accessing r->gitdir.
>
> Fix this by initializing the repository in the index state.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> Helped-by: Christian Couder <christian.couder@gmail.com>
> ---
>     merge-ort: initialize repo in index state
>
>     initialize_attr_index() does not initialize the repo member of
>     attr_index. Starting in 44451a2e5e (attr: teach "--attr-source=3D" gl=
obal
>     option to "git", 2023-05-06), this became a problem because istate->r=
epo
>     gets passed down the call chain starting in git_check_attr(). This ge=
ts
>     passed all the way down to replace_refs_enabled(), which segfaults wh=
en
>     accessing r->gitdir.
>
>     Fix this by initializing the repository in the index state.

Out of curiosity, are the changes in 44451a2e5e and its predecessors
sufficient to allow us to gut this nasty initialize_attr_index() hack
from merge-ort?  See the comment at the top of the function and this
old mailing list thread:
https://lore.kernel.org/git/CABPp-BE1TvFJ1eOa8Ci5JTMET+dzZh3m3NxppqqWPyEp1U=
eAVg@mail.gmail.com/.

I never wanted to generate an index, Stolee didn't like it either, but
the attribute code seemed hardcoded to require an index and I had gone
down enough rabbit holes trying to get merge-ort into shape.  But I
still absolutely hate this awful hack.

If we do have to live with it still, then...

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-158=
3%2Fjohn-cai%2Fjc%2Fpopulate-repo-when-init-attr-index-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1583/j=
ohn-cai/jc/populate-repo-when-init-attr-index-v1
> Pull-Request: https://github.com/git/git/pull/1583
>
>  merge-ort.c           |  1 +
>  t/t4300-merge-tree.sh | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 7857ce9fbd1..172dc7d497d 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -1902,6 +1902,7 @@ static void initialize_attr_index(struct merge_opti=
ons *opt)
>         struct index_state *attr_index =3D &opt->priv->attr_index;
>         struct cache_entry *ce;
>
> +       attr_index->repo =3D the_repository;

Can we use opt->repo instead and reduce the number of places
hardcoding the_repository?


>         attr_index->initialized =3D 1;
>
>         if (!opt->renormalize)
> diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
> index 57c4f26e461..254453fff9c 100755
> --- a/t/t4300-merge-tree.sh
> +++ b/t/t4300-merge-tree.sh
> @@ -86,6 +86,26 @@ EXPECTED
>         test_cmp expected actual
>  '
>
> +test_expect_success '3-way merge with --attr-source' '
> +       test_when_finished rm -rf 3-way &&
> +       git init 3-way &&
> +       (
> +               cd 3-way &&
> +               test_commit initial file1 foo &&
> +               base=3D$(git rev-parse HEAD) &&
> +               git checkout -b brancha &&
> +               echo bar>>file1 &&
> +               git commit -am "adding bar" &&
> +               source=3D$(git rev-parse HEAD) &&
> +               echo baz>>file1 &&
> +               git commit -am "adding baz" &&
> +               merge=3D$(git rev-parse HEAD) &&
> +               test_must_fail git --attr-source=3DHEAD merge-tree -z --w=
rite-tree \
> +               --merge-base "$base" --end-of-options "$source" "$merge" =
>out &&
> +               grep "Merge conflict in file1" out
> +       )
> +'
> +
>  test_expect_success 'file change A, B (same)' '
>         git reset --hard initial &&
>         test_commit "change-a-b-same-A" "initial-file" "AAA" &&
>
> base-commit: 493f4622739e9b64f24b465b21aa85870dd9dc09
> --
> gitgitgadget

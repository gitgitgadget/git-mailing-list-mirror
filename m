Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0DAC636CC
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 22:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBKWlG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Feb 2023 17:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBKWlF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2023 17:41:05 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C6EA5D0
        for <git@vger.kernel.org>; Sat, 11 Feb 2023 14:41:04 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id u75so5968689pgc.10
        for <git@vger.kernel.org>; Sat, 11 Feb 2023 14:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cBSV76aHh28lc5JDY72W9twR0XyC2b5twd88gxA3nX8=;
        b=ZUUW+Wa3EbW/J3t0qGu1E9T+qtyLKlc39jqtyc2hhKQRASWyL27j++9A40jff6TE0z
         S8oXeEgjDOfnpSgjFSl/sVx93sE2k6JoKRl9Eo8QnFX3tbRUMCRsfNhjEyj2vSHXZO2j
         Hl8wgzp3z5BOOp8Mov75OgI5UeU2WWpspCy/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBSV76aHh28lc5JDY72W9twR0XyC2b5twd88gxA3nX8=;
        b=UIhIKiC1nKCnbgHR4WxFPHmjYZiaEOIcvXn6DZoaO2xG3VLisGxR5f1/CtMIyCxO65
         mdHPMu5rvvIoBaJj2llJ+jlDbCinmaJqwkTV8vq5ccFKWUueg/WCjp5CRNFQJR/2z1Xh
         P7NP5ZP60BRsxDbkp3rXldIfFTvIrdT61TSBH1B/l+E3G9mTHK+LVvQ1yfff0cO/BQHN
         1NwN/VGZBUiO+c4EV5uMHgPSM/0hKpiDOpJFwNVfHendqZtq5TB2qhP7azCSMO5eqnhT
         PCf1PuTMuBRzkTlGQSuN+NgC3ZGZ9Dv0bcMvrwPoQ6Rc0CbxfkEUBs381aiM9qtfRwBI
         C+cA==
X-Gm-Message-State: AO0yUKXuWeY00xOpkHefA+D0q4mV5PxHuBeffPoGqe4+pYueAWcMlMIS
        lMFtsW6qdvTsyAsbqryzFd3CELNvosBRozAMJ6cPWVCB5/g6I40M
X-Google-Smtp-Source: AK7set9u9EMwctu1ShbZwPELzlGqxTO+wwOb3TtHJ9BQdgBc6YbWi5Z/EGKXmOv309xZYhab4Kk4Pi13nSUpADBq/bM=
X-Received: by 2002:a65:6aa2:0:b0:4fb:9525:3a1c with SMTP id
 x2-20020a656aa2000000b004fb95253a1cmr57712pgu.11.1676155263097; Sat, 11 Feb
 2023 14:41:03 -0800 (PST)
MIME-Version: 1.0
References: <CA+tAvojz0u7AbcNnY1qyy3VznKhYTiAO1dL+rfOD3O6mOtsa8A@mail.gmail.com>
 <20230211222353.1984150-1-andy@halogix.com>
In-Reply-To: <20230211222353.1984150-1-andy@halogix.com>
From:   Andrew Wansink <wansink@uber.com>
Date:   Sat, 11 Feb 2023 14:40:26 -0800
Message-ID: <CA+tAvoijGhyySwfQCAuf2=vK5dvvLHu-U+YikRef2v24ECDr9Q@mail.gmail.com>
Subject: Re: [RFC PATCH] upload_pack.c: make deepen-not more tree-ish
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry to spam the list with this patch twice, I failed to follow the
instructions correctly the first time and sent a diff with the
whitespace stipped.

- Andrew


On Sat, Feb 11, 2023 at 2:23 PM Andrew Wansink <andy@halogix.com> wrote:
>
> This unlocks `git clone --shallow-exclude=<commit-sha1>`
>
> git-clone only accepts --shallow-excude arguments where
> the argument is a branch or tag because upload_pack only
> searches deepen-not arguments for branches and tags.
>
> Make process_deepen_not search for commit objects if no
> branch or tag is found then add them to the deepen_not
> list.
>
> Signed-off-by: Andrew Wansink <wansink@uber.com>
> ---
>
> At Uber we have a lot of patches in CI simultaneously,
> the CI jobs will frequently clone the monorepo multiple
> times for each patch.  They do this to calculate diffs
> between a patch and its parent commit.
>
> One optimisation in this flow is to clone only to a specific
> depth, this may or may not work, depending on how old the
> patch is.  In this case we have to --unshallow or discard
> the shallow clone and fully clone the repo.
>
> This patch would allow us to clone to exactly the depth we
> need to find a patch's parent commit.
>
>  t/t5500-fetch-pack.sh | 30 ++++++++++++++++++++++++++++++
>  upload-pack.c         | 35 +++++++++++++++++++++++++++++++----
>  2 files changed, 61 insertions(+), 4 deletions(-)
>
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index d18f2823d86..8d5045cc1b9 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -899,6 +899,36 @@ test_expect_success 'shallow clone exclude tag two' '
>         )
>  '
>
> +test_expect_success 'shallow clone exclude commit' '
> +       test_create_repo shallow-exclude-commit &&
> +       (
> +       cd shallow-exclude-commit &&
> +       test_commit one &&
> +       test_commit two &&
> +       test_commit three &&
> +       commit_two_sha1=$(git log -n 1 --pretty=tformat:%h HEAD^) &&
> +       git clone --shallow-exclude=${commit_two_sha1} "file://$(pwd)/." ../shallow3-by-commit &&
> +       git -C ../shallow3-by-commit log --pretty=tformat:%s HEAD >actual &&
> +       git log -n 1 --pretty=tformat:%s HEAD >expected &&
> +       test_cmp expected actual
> +       )
> +'
> +
> +test_expect_success 'shallow clone exclude commit^' '
> +       test_create_repo shallow-exclude-commit-carat &&
> +       (
> +       cd shallow-exclude-commit-carat &&
> +       test_commit one &&
> +       test_commit two &&
> +       test_commit three &&
> +       commit_two_sha1=$(git log -n 1 --pretty=tformat:%h HEAD^) &&
> +       git clone --shallow-exclude=${commit_two_sha1}^ "file://$(pwd)/." ../shallow23-by-commit &&
> +       git -C ../shallow23-by-commit log --pretty=tformat:%s HEAD >actual &&
> +       git log -n 2 --pretty=tformat:%s HEAD >expected &&
> +       test_cmp expected actual
> +       )
> +'
> +
>  test_expect_success 'fetch exclude tag one' '
>         git -C shallow12 fetch --shallow-exclude one origin &&
>         git -C shallow12 log --pretty=tformat:%s origin/main >actual &&
> diff --git a/upload-pack.c b/upload-pack.c
> index 551f22ffa5d..0c8594f4744 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -985,10 +985,37 @@ static int process_deepen_not(const char *line, struct string_list *deepen_not,
>         if (skip_prefix(line, "deepen-not ", &arg)) {
>                 char *ref = NULL;
>                 struct object_id oid;
> -               if (expand_ref(the_repository, arg, strlen(arg), &oid, &ref) != 1)
> -                       die("git upload-pack: ambiguous deepen-not: %s", line);
> -               string_list_append(deepen_not, ref);
> -               free(ref);
> +
> +               switch (expand_ref(the_repository, arg, strlen(arg), &oid, &ref)) {
> +               case 1:
> +                       // tag or branch matching arg found
> +                       string_list_append(deepen_not, ref);
> +                       free(ref);
> +                       break;
> +               case 0: {
> +                       // no tags or branches matching arg
> +                       struct object *obj = NULL;
> +                       struct commit *commit = NULL;
> +
> +                       if (get_oid(arg, &oid))
> +                               die("git upload-pack: deepen-not: no ref or object %s", arg);
> +
> +                       obj = parse_object(the_repository, &oid);
> +                       if (!obj)
> +                               die("git upload-pack: deepen-not: object could not be parsed: %s", arg);
> +
> +                       commit = (struct commit *)peel_to_type(arg, 0, obj, OBJ_COMMIT);
> +                       if (!commit)
> +                               die("git upload-pack: deepen-not: object not a commit: %s", arg);
> +
> +                       string_list_append(deepen_not, oid_to_hex(&commit->object.oid));
> +                       break;
> +               }
> +               default:
> +                       // more than 1 tag or branch matches arg
> +                       die("git upload-pack: ambiguous deepen-not: %s", arg);
> +               }
> +
>                 *deepen_rev_list = 1;
>                 return 1;
>         }
> --
> 2.39.1
>

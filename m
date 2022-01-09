Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7852C433EF
	for <git@archiver.kernel.org>; Sun,  9 Jan 2022 04:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbiAIEZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 23:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiAIEZC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 23:25:02 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD24AC06173F
        for <git@vger.kernel.org>; Sat,  8 Jan 2022 20:25:01 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id k15so39159578edk.13
        for <git@vger.kernel.org>; Sat, 08 Jan 2022 20:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDiyb0YysYySPlnUYgPLfdLyKkkKq/wTMCepid5tbr0=;
        b=FSe4K+AR+H5YDNbfWQdLbO1FLwgpIfOx2J+d2+CJQQVf5z15tRHQmo5Eoe1E87DLfx
         HwQTvbjkPwPkWqHn0D6UTyHndklN1DpI2lKYnqsxNiZVfYQLpFI42iG9ap5zyks+DEQI
         DK/jdkfVJbkm0xQhuB0egs6TdLFW2kD5xIw10KWd0NzL3iF9w8mxF1dgnlfbZ1IoTnvr
         /xMphX/JCe0txudzUVx5TcTcr+XPas7ehTQFrOqDnFzD7CUwGNEPdKvkzSY4rVyPVREM
         l5fZcZqNHXgfR41QyPKepDfLobTeIg31kjDrQZTQrAtXkoLNdrevD6pioY38zyVAG6QR
         x+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDiyb0YysYySPlnUYgPLfdLyKkkKq/wTMCepid5tbr0=;
        b=7YSoHRxZQbfgbbEUOgXXbLzBBGiQuZS4AgNDo+nmIFnEs9wwNsOwb/+BMUDLCXZL3H
         BF0tjuwzrT5y0KF83lJrYyyd75VPKhA7ezg9UgHKMETRux+N2jK3fFy+VRjzAkwameyO
         vctYQTy6lfj8JD0mbT/G85/DP1bnnmpN46GwWlmDtN3F6mJuoF4bxXeaDK72dFFmmfG+
         VE9ObsFYR1jmax44F3yX04fkpa1xY3WTC9Q7SBvC1RmdewDVj3fpdoR8qKsyR6luTy9P
         thECAXzvOav+VU1rtkS5KN48MdhbGZIdx+ZbeF0ASc3wsfUViCsFvsg8FZfp9X4m6mzT
         UO8A==
X-Gm-Message-State: AOAM533uXbqvYJScUR6UrKqtLVhNduQXsdYFVjLAF3ttZB2rBQmCdyv0
        sDfBrpJzosMMvbaBH0diRxLsp9mmNMWRAi9ec/A=
X-Google-Smtp-Source: ABdhPJwwh+v/7OsrnjYyKlOsYdjiltFKHK0wn1nO8dWrXr8Ma+r50D9bsjovp/AH42WbkyBUQdZ7uvJQeOefj4J1kg0=
X-Received: by 2002:a17:907:160e:: with SMTP id hb14mr55945556ejc.328.1641702300486;
 Sat, 08 Jan 2022 20:25:00 -0800 (PST)
MIME-Version: 1.0
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com> <de7fc14356231a60c8cac9aa6f92a7fec1560b6a.1641317820.git.gitgitgadget@gmail.com>
In-Reply-To: <de7fc14356231a60c8cac9aa6f92a7fec1560b6a.1641317820.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 8 Jan 2022 20:24:49 -0800
Message-ID: <CABPp-BEmT-2+G_PRvhCFkzOc4oP+_5--ESz9=dHAO7gzDsHUOw@mail.gmail.com>
Subject: Re: [PATCH 9/9] update-index: reduce scope of index expansion in do_reupdate
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 4, 2022 at 9:37 AM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Victoria Dye <vdye@github.com>
>
> Expand the full index (and redo reupdate operation) only if a sparse
> directory in the index differs from HEAD.

This was a bit hard to parse and follow for me.  Perhaps:

Avoid pre-emptively expanding to a full index in update-index's do_reupdate().
However, if a sparse directory in the index differs from HEAD, we will need to
then expand the index and restart the operation.

> Only the index entries that differ
> between the index and HEAD are updated when performing `git update-index
> --again`, so unmodified sparse directories are safely skipped. The index
> does need to be expanded when sparse directories contain changes, though,
> because `update_one(...)` will not operate on sparse directory index
> entries.
>
> Because the index should only be expanded if a sparse directory is modified,
> add a test ensuring the index is not expanded when differences only exist
> within the sparse cone.
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/update-index.c                   | 14 +++++++++++---
>  t/t1092-sparse-checkout-compatibility.sh |  5 ++++-
>  2 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 605cc693bbd..52ecc714d99 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -606,7 +606,7 @@ static struct cache_entry *read_one_ent(const char *which,
>                         error("%s: not in %s branch.", path, which);
>                 return NULL;
>         }
> -       if (mode == S_IFDIR) {
> +       if (!the_index.sparse_index && mode == S_IFDIR) {
>                 if (which)
>                         error("%s: not a blob in %s branch.", path, which);
>                 return NULL;
> @@ -743,8 +743,6 @@ static int do_reupdate(int ac, const char **av,
>                  */
>                 has_head = 0;
>   redo:
> -       /* TODO: audit for interaction with sparse-index. */
> -       ensure_full_index(&the_index);
>         for (pos = 0; pos < active_nr; pos++) {
>                 const struct cache_entry *ce = active_cache[pos];
>                 struct cache_entry *old = NULL;
> @@ -761,6 +759,16 @@ static int do_reupdate(int ac, const char **av,
>                         discard_cache_entry(old);
>                         continue; /* unchanged */
>                 }
> +
> +               /* At this point, we know the contents of the sparse directory are
> +                * modified with respect to HEAD, so we expand the index and restart
> +                * to process each path individually
> +                */
> +               if (S_ISSPARSEDIR(ce->ce_mode)) {
> +                       ensure_full_index(&the_index);
> +                       goto redo;
> +               }
> +
>                 /* Be careful.  The working tree may not have the
>                  * path anymore, in which case, under 'allow_remove',
>                  * or worse yet 'allow_replace', active_nr may decrease.
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index bc0741c970d..0863c9747c4 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1225,7 +1225,10 @@ test_expect_success 'sparse index is not expanded: update-index' '
>
>         ensure_not_expanded update-index --add README.md &&
>         ensure_not_expanded update-index a &&
> -       ensure_not_expanded update-index --remove deep/a
> +       ensure_not_expanded update-index --remove deep/a &&
> +
> +       ensure_not_expanded reset --soft update-deep &&
> +       ensure_not_expanded update-index --add --remove --again
>  '
>
>  # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
> --
> gitgitgadget

I think the rest makes sense.  Thanks for working on these!

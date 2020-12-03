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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44B4C63777
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 06:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D7B92067C
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 06:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgLCGKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 01:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbgLCGKR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 01:10:17 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F34DC061A4D
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 22:09:37 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id i30so246480ooh.9
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 22:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VbXnMeP75DulfCaX/Ztr0FdG6CTKrIGq7OWSSD97TxA=;
        b=K8XhvBNb25QGVbKPpi18joqRFrD6nL0eHx6B/a+ILcc4j/ZfSvBJPYqvvcCSQ8qNHl
         SdBPtDVHHZFkX/MrvmefwVne7CthWscI/RJkYsdvFhVTx0SqJyp0JQoSbkQNG6OyhVRo
         2Fa7rBUlXCCy7A+tgCY+IcopyBVdOv5ZfvW8eDktZADyAy/XcZ4TVMMF1twaID4/JJeI
         2h8OeWJFSYtEdjPqz2bSXOQqe/lL7XYebESzwNkMXUVpWGUT8EKt2e2u/SrWxFftk4zC
         STrfk4GmbobJUMDLSemCi1doV+S2jwLqqLy3R2Tx3nZRqspSLohSGP7xgqx8sJLY+k+a
         s+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VbXnMeP75DulfCaX/Ztr0FdG6CTKrIGq7OWSSD97TxA=;
        b=ifrSw9QEu9aJxxFxvjtBsHVhfW2BxcOjUX/pNHIyja1SHe7VMdGh7OUKhDnioqWDwq
         J2DX3NYvFwm+DCCwhG6p5IIeotGvl1pn6wRLn5YtQlJsu89xS9YcwlkTQksMlP55rhpX
         L6ujhPlrwxUQ0Vjq3y8/wh5dvYYesu82lxM6LJ2Sbh4xF10kMj8fPfRTEQZy/Dvxc1iz
         j4PLR/qPylA+RGQ6mA/up7t72dfX5HsXVvlRZ2BEA/vo/9gLXtqdL7Hl+7rz/KvhgHk8
         OXCAm+EvZIDLoV32UhBh6rP8lkaKQtz2njkoA5magFQ/HZNNQzYM8xNYA+r0nDMP+xQl
         mvjA==
X-Gm-Message-State: AOAM530uJMfQ2Z9HDqU7smDvWAB+L0AL4jG+AbRm/u24wB+ZdSAPX0H/
        HnKxD2fwfya49xiaYYZzb2lGiUBEIWw01QPI9QtZzVNichlkHQ==
X-Google-Smtp-Source: ABdhPJyonOU8t0MtdLYwUaWLXJRg5dQO8NC5DsZnLa04PNXumz+5BbWJEcifQeMi832hYM6HqzS6VQuJHyoBtirF3TA=
X-Received: by 2002:a4a:7b4b:: with SMTP id l72mr1067561ooc.45.1606975776393;
 Wed, 02 Dec 2020 22:09:36 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201108213838.4880-1-sorganov@gmail.com>
 <20201108213838.4880-25-sorganov@gmail.com>
In-Reply-To: <20201108213838.4880-25-sorganov@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Dec 2020 22:09:25 -0800
Message-ID: <CABPp-BGZO+7bRdCAGFdetOkmwyFnHxDPQ=SD4f6TSa9ZYGFn=A@mail.gmail.com>
Subject: Re: [PATCH v1 24/27] doc/git-log: describe new --diff-merges options
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 8, 2020 at 1:46 PM Sergey Organov <sorganov@gmail.com> wrote:
>
> Describe all the new --diff-merges options in the git-log.txt
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  Documentation/git-log.txt | 79 +++++++++++++++++++++++----------------
>  1 file changed, 46 insertions(+), 33 deletions(-)
>
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 2b8ac5ff882a..de498a189646 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -120,45 +120,58 @@ DIFF FORMATTING
>  By default, `git log` does not generate any diff output. The options
>  below can be used to show the changes made by each commit.
>
> -Note that unless one of `-c`, `--cc`, or `-m` is given, merge commits
> -will never show a diff, even if a diff format like `--patch` is
> -selected, nor will they match search options like `-S`. The exception is
> -when `--first-parent` is in use, in which merges are treated like normal
> -single-parent commits (this can be overridden by providing a
> -combined-diff option or with `--no-diff-merges`).
> +Note that unless one of `--diff-merges` variants (including short
> +`-m`, `-c`, and `--cc` options) is explicitly given, merge commits
> +will not show a diff, even if a diff format like `--patch` is
> +selected, nor will they match search options like `-S`. The exception
> +is when `--first-parent` is in use, in which case
> +`--diff-merges=first-parent` is implied.
>
> --c::
> -       With this option, diff output for a merge commit
> -       shows the differences from each of the parents to the merge result
> -       simultaneously instead of showing pairwise diff between a parent
> -       and the result one at a time. Furthermore, it lists only files
> -       which were modified from all parents.
> -
> ---cc::
> -       This flag implies the `-c` option and further compresses the
> -       patch output by omitting uninteresting hunks whose contents in
> -       the parents have only two variants and the merge result picks
> -       one of them without modification.
> +--diff-merges=(off|none|first-parent|separate|combined|dense-combined)::
> +--no-diff-merges::
> +       Specify diff format to be used for merge commits. This has no
> +       effect unless diff output is enabled in the first place (e.g.,
> +       with `--patch` option.)

This seems inconsistent with c7eaf8b4c3 ("log: when --cc is given,
default to -p unless told otherwise", 2015-08-20); shouldn't these
imply -p?

> ++
> +--diff-merges=(off|none):::
> +--no-diff-merges:::
> +       (default) Disable output of diffs for merge commits. Useful to
> +       override implied value.
> ++
> +--diff-merges=first-parent:::
> +       This option makes merge commits show the full diff with
> +       respect to the first parent only, exactly like  regular
> +       commits.

Not sure that "exactly like regular commits" is helpful here; I'd
personally rather cut those four words out.  I'm worried it'll be
taken not as an implementation explanation, but as a "this treats
merge commits in the natural way that regular commits are" which users
may mistakenly translate to "it shows what changes the user manually
made as part of the commit" which is not at all the correct mapping.

> ++
> +--diff-merges=separate:::
> +-m:::
> +       This makes merge commits show the full diff with respect to
> +       each of the parents. Separate log entry and diff is generated
> +       for each parent.
> ++
> +--diff-merges=combined:::
> +-c:::
> +       With this option, diff output for a merge commit shows the
> +       differences from each of the parents to the merge result
> +       simultaneously instead of showing pairwise diff between a
> +       parent and the result one at a time. Furthermore, it lists
> +       only files which were modified from all parents.
> ++
> +--diff-merges=dense-combined:::
> +--cc:::
> +       With this option the output produced by
> +       `--diff-merges=combined` is further compressed by omitting
> +       uninteresting hunks whose contents in the parents have only
> +       two variants and the merge result picks one of them without
> +       modification.
>
>  --combined-all-paths::
>         This flag causes combined diffs (used for merge commits) to
>         list the name of the file from all parents.  It thus only has
> -       effect when -c or --cc are specified, and is likely only
> -       useful if filename changes are detected (i.e. when either
> -       rename or copy detection have been requested).
> +       effect when `--diff-merges=[dense-]combined` is in use, and
> +       is likely only useful if filename changes are detected (i.e.
> +       when either rename or copy detection have been requested).
>
> --m::
> -       This flag makes the merge commits show the full diff like
> -       regular commits; for each merge parent, a separate log entry
> -       and diff is generated. An exception is that only diff against
> -       the first parent is shown when `--first-parent` option is given;
> -       in that case, the output represents the changes the merge
> -       brought _into_ the then-current branch.
> -
> ---diff-merges=off::
> ---no-diff-merges::
> -       Disable output of diffs for merge commits (default). Useful to
> -       override `-m`, `-c`, or `--cc`.
>
>  :git-log: 1
>  include::diff-options.txt[]
> --
> 2.25.1

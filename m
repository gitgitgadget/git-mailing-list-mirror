Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD16DC433F5
	for <git@archiver.kernel.org>; Sat,  7 May 2022 03:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445434AbiEGDaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 23:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445429AbiEGDaO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 23:30:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F4F5DE55
        for <git@vger.kernel.org>; Fri,  6 May 2022 20:26:28 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y3so17527493ejo.12
        for <git@vger.kernel.org>; Fri, 06 May 2022 20:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IDwpK6XrtdszfahxVq7N0Pe/De+IBmbZbgkNBw2bKMQ=;
        b=L4w9QXPQZJvRAvAlUqsgs71zFuI99w3VWU9qj3X8Bxmk3E5a+BpueKSqSZ7ZwcpgdP
         dS11GUTq3x4uOCBPDIfpn+cZ80VLMmql7v2EcTBUpBe7tmr38RRgbroBx64tjUdqarM0
         +An99ICM41WB02xX9SFgME3xhRDv3wKBzyWlIc/mgKsp6GZcHj+mb7AbTwYsW+t3ZbI5
         JI5mO62dh+/DE8iPAeitrMCx8C90GMysTt6fRNEKx6G2QcKJ9sNn1et0K8CMl33+6os+
         glak71NIFVaZr4dGJ8GbHn0Q+JKc/jxDFNkBlO0lhB68KmgYlJ4GJyPLfJSlbJe96m0Z
         /a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IDwpK6XrtdszfahxVq7N0Pe/De+IBmbZbgkNBw2bKMQ=;
        b=Sf9gvspTWVQqgG4QAzpx66+pt3GlDQE1NP6+NWAC6o+NJ1mb4DbOVLYneOzGgRst4g
         /lkE7b9KQKTM/mMtzw7TNo0+YIM2WjUyB9iDDapYzUOR90fZG9bQIIU2Mw0dOK4jurFO
         DT+VsHZdK0hKw0N2yaPrD7WNYf4kSuUDYDNIU8Cp767xNHzcwUhuaxVddYZAXNEq/kmL
         n9XYgHVpZ4KlqEPlj66i/CuLf1d6pKSX41ZChD4ue04JY5spn1rFVc/0R2P1Nv1wXex5
         +2pBgW89bH7oqGqmBoQYPDexsG7uPCVDE4zkeTPHpljApZCIocnaQ+1fc8i2IBkRgQ2L
         dpGg==
X-Gm-Message-State: AOAM532A+X9oJ6XvlBLC5d2uPA13+KEyyG6yzp/XhtjptOzH2wS+cWcD
        Z05RShUbDpqxX1rNJ84iz51BLNce9/gAprYT04U=
X-Google-Smtp-Source: ABdhPJyRNzW5eCiJnLhYNWvPjGS8Gey/21+5gSpqQztC1orcfXQfqq1GgdxPDT/5cFPXpZp7PdSweLhNTz+VbR1c9TY=
X-Received: by 2002:a17:907:7f26:b0:6f4:69c:196f with SMTP id
 qf38-20020a1709077f2600b006f4069c196fmr5555255ejc.613.1651893987156; Fri, 06
 May 2022 20:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220505203234.21586-1-ggossdev@gmail.com> <20220505203234.21586-2-ggossdev@gmail.com>
In-Reply-To: <20220505203234.21586-2-ggossdev@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 6 May 2022 20:26:15 -0700
Message-ID: <CABPp-BFwiLXMVaFs-Lc-zU6X=pBiF8+o9rOuHEAArD2zMQ1NNQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] dir: consider worktree config in path recursion
To:     Goss Geppert <gg.oss.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        christian w <usebees@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 5, 2022 at 1:32 PM Goss Geppert <gg.oss.dev@gmail.com> wrote:
>
> Since 8d92fb2927 (dir: replace exponential algorithm with a linear one,
> 2020-04-01) the following no longer works:
>
>     1) Initialize a repository.
>     2) Set the `core.worktree` location to a parent directory of the
>        default worktree.
>     3) Add a file located in the default worktree location to the index
>        (i.e. anywhere in the immediate parent directory of the gitdir).
>
> This commit adds a check to determine whether a nested repository that
> is encountered in recursing a path is actually `the_repository`.  If so,
> simply treat the directory as if it doesn't contain a nested repository.
>
> Prior to this commit, the `add` operation was silently ignored.
> ---
>  dir.c | 37 ++++++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index f2b0f24210..cef39f43d8 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1861,7 +1861,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>          */
>         enum path_treatment state;
>         int matches_how = 0;
> -       int nested_repo = 0, check_only, stop_early;
> +       int check_only, stop_early;

This part of the patch, along with two other parts below, is
orthogonal to the actual fix being made.  It probably makes the code
clearer, but should be done in an independent cleanup commit.

>         int old_ignored_nr, old_untracked_nr;
>         /* The "len-1" is to strip the final '/' */
>         enum exist_status status = directory_exists_in_index(istate, dirname, len-1);
> @@ -1893,16 +1893,39 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>
>         if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
>                 !(dir->flags & DIR_NO_GITLINKS)) {
> +               /*
> +                * Determine if `dirname` is a nested repo by confirming that:
> +                * 1) we are in a nonbare repository, and
> +                * 2) `dirname` is not an immediate parent of `the_repository->gitdir`,
> +                *    which could occur if the `worktree` location was manually
> +                *    configured by the user
> +                */

This is a good comment, but it'd be really nice to be able to point a
user at a testcase in the testsuite for them to inspect further (e.g.
"see t####, 'TESTCASE DESCRIPTION' for an case where this matters").

> +               int nested_repo;

Just this line immediately above this comment is part of the orthogonal cleanup.

>                 struct strbuf sb = STRBUF_INIT;
>                 strbuf_addstr(&sb, dirname);
>                 nested_repo = is_nonbare_repository_dir(&sb);
> +
> +               if (nested_repo) {
> +                       char *real_dirname, *real_gitdir;
> +                       strbuf_reset(&sb);
> +                       strbuf_addstr(&sb, dirname);
> +                       strbuf_complete(&sb, '/');
> +                       strbuf_addstr(&sb, ".git");

> +                       real_dirname = real_pathdup(sb.buf, 0);
> +                       real_gitdir = real_pathdup(the_repository->gitdir, 0);

I haven't thought it through, but is there a reason you can't just
compare the_repository->gitdir to sb.buf at this point?  Why is
real_pathdup needed?

> +
> +                       nested_repo = !!strcmp(real_dirname, real_gitdir);
> +                       free(real_gitdir);
> +                       free(real_dirname);
> +               }

Everything up to here other than the two parts I mentioned as being
orthogonal (both relating to where "nested_repo" is defined), makes up
the actual fix.

>                 strbuf_release(&sb);
> -       }
> -       if (nested_repo) {
> -               if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
> -                   (matches_how == MATCHED_RECURSIVELY_LEADING_PATHSPEC))
> -                       return path_none;
> -               return excluded ? path_excluded : path_untracked;
> +
> +               if (nested_repo) {
> +                       if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
> +                               (matches_how == MATCHED_RECURSIVELY_LEADING_PATHSPEC))
> +                               return path_none;
> +                       return excluded ? path_excluded : path_untracked;
> +               }

This final block is part of the orthogonal code cleanup that belongs
in a separate commit.

>         }
>
>         if (!(dir->flags & DIR_SHOW_OTHER_DIRECTORIES)) {
> --
> 2.36.0

Thanks for finding, reporting, and sending in a patch.  Could you
split up the patch as indicated above, and add a testcase to the patch
with the fix, and include your Signed-off-by trailer on the commits?

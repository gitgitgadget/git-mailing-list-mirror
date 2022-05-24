Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979EAC433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 14:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbiEXOc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 10:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbiEXOcy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 10:32:54 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5572062124
        for <git@vger.kernel.org>; Tue, 24 May 2022 07:32:53 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id f9so35829274ejc.0
        for <git@vger.kernel.org>; Tue, 24 May 2022 07:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DtgenKpSSFbeBGYB5JKkwR+TzjwAI+6VbAnNSk2mkCc=;
        b=BqdGH7UTCqZzPCkyvqOW9z8Ed76+xUfEysu/l8kd/x+eDevDMw4HocL+9pr+vKvZGx
         weu5Lq7RAFkZDX+eSlYhayGMd++i5hpbeZhoBCDZxv0lXc19z9kPqWB6h9ehtkOeTfc/
         NW0wvgFB6+NiCtB8dEv5S4CANdHii5wC06LS8p6J9TKgMbm54RIap1ko59bMbjrmtcua
         ofmDqVp8L8y0rreZUy301Hfp3SYWBDu0teZZOcdG15dPL+ngnA964HmErkwjg48EX2KA
         e8CYYtfwtwE7wAxr5rUeVMH3dZsBCIGUWgrgoyfgxkmhedsrhMYoVG+/PSKH8IY0Njlj
         WTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DtgenKpSSFbeBGYB5JKkwR+TzjwAI+6VbAnNSk2mkCc=;
        b=eon32IsA3KLi0+LbVbW7MrNYAl6E8o93/ITwA0nwVdwmStzYJdECk0eTcqiBQRwH0a
         4noGH1AMYnBjeiRZMENjRdSABv2uTfoHCLSCdCznddVEqskYMM/TEu0RkqRo1Jd6lXEj
         QZnSB8ubQBmeAYQI8CSb6LPfD3xNPTzcd7+MsYopnrpWVm6mOVz01MAKtQWR6Wf5blKd
         5/Eq0S+RMscQ6bM+Xjc3QQECUTBq951QrcxqRUz16a+DtyNhu0X8eFkGjGVEIXNvAu0W
         tJpl+jNOMqXAUJo3767ELtznRQRUCfPnY8NF44G8UY4uTR41YwYuY2OR817MroLt+QxN
         sfEA==
X-Gm-Message-State: AOAM5335vVC82QcRENzTZbPBxDb/UCGvRsVS3IEhWuEn6bl65ANwJ+uX
        oE/3iAtaVzKXfm49Z1Jxgl6DwxT/kchmj8s3Sug=
X-Google-Smtp-Source: ABdhPJyhDUZRN222Jbl2GLy9Pv+uvQFaOUUMsuNdhK5C+XbNuBAg2kysl7pKAZA+UO2YQRzy0sm1rys5rACxZhBZ1FQ=
X-Received: by 2002:a17:907:7ea9:b0:6fe:d412:ec2c with SMTP id
 qb41-20020a1709077ea900b006fed412ec2cmr10858085ejc.613.1653402771705; Tue, 24
 May 2022 07:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220505203234.21586-1-ggossdev@gmail.com> <20220520192840.8942-1-ggossdev@gmail.com>
 <20220520192840.8942-3-ggossdev@gmail.com>
In-Reply-To: <20220520192840.8942-3-ggossdev@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 24 May 2022 07:32:39 -0700
Message-ID: <CABPp-BGkGu8NZ6wOiMFEVQ+s=28CUMiD-+upWweAtZBjg9ciAA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dir: cache git_dir's realpath
To:     Goss Geppert <gg.oss.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        christian w <usebees@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 20, 2022 at 12:29 PM Goss Geppert <gg.oss.dev@gmail.com> wrote:
>
> When traversing the directory tree, the realpath of the `git_dir` is
> required each time a nested repository is encountered to determine how
> the nested repository should be treated.  To prevent excessive resource
> usage in pathological cases (e.g. many nested repositories, a long path,
> symlinks, etc.), cache the realpath after the first usage until the
> traversal is complete.
> ---
>  dir.c | 63 ++++++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 43 insertions(+), 20 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index e45e117875..45b89560fc 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -47,10 +47,22 @@ struct cached_dir {
>         struct untracked_cache_dir *ucd;
>  };
>
> +/*
> + * Support data structure for the recursing into the directory tree.
> + */
> +struct traversal_cache {
> +       /*
> +        * The realpath for the `git_dir` may be required in the recursion and is
> +        * cached for repeated use.
> +        */
> +       char *real_gitdir;
> +};
> +
>  static enum path_treatment read_directory_recursive(struct dir_struct *dir,
>         struct index_state *istate, const char *path, int len,
>         struct untracked_cache_dir *untracked,
> -       int check_only, int stop_at_first_file, const struct pathspec *pathspec);
> +       int check_only, int stop_at_first_file, const struct pathspec *pathspec,
> +       struct traversal_cache *cache);
>  static int resolve_dtype(int dtype, struct index_state *istate,
>                          const char *path, int len);
>  struct dirent *readdir_skip_dot_and_dotdot(DIR *dirp)
> @@ -1852,7 +1864,8 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>         struct index_state *istate,
>         struct untracked_cache_dir *untracked,
>         const char *dirname, int len, int baselen, int excluded,
> -       const struct pathspec *pathspec)
> +       const struct pathspec *pathspec,
> +       struct traversal_cache *cache)
>  {
>         /*
>          * WARNING: From this function, you can return path_recurse or you
> @@ -1906,13 +1919,13 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>                 nested_repo = is_nonbare_repository_dir(&sb);
>
>                 if (nested_repo) {
> -                       char *real_dirname, *real_gitdir;
> +                       char *real_dirname;
>                         strbuf_addstr(&sb, ".git");
>                         real_dirname = real_pathdup(sb.buf, 1);
> -                       real_gitdir = real_pathdup(the_repository->gitdir, 1);
> +                       if (!cache->real_gitdir)
> +                               cache->real_gitdir = real_pathdup(the_repository->gitdir, 1);
>
> -                       nested_repo = !!strcmp(real_dirname, real_gitdir);
> -                       free(real_gitdir);
> +                       nested_repo = !!strcmp(real_dirname, cache->real_gitdir);
>                         free(real_dirname);
>                 }
>                 strbuf_release(&sb);
> @@ -1944,7 +1957,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>                                 return path_excluded;
>
>                         if (read_directory_recursive(dir, istate, dirname, len,
> -                                                    untracked, 1, 1, pathspec) == path_excluded)
> +                                                    untracked, 1, 1, pathspec, cache) == path_excluded)
>                                 return path_excluded;
>
>                         return path_none;
> @@ -2045,7 +2058,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>         untracked = lookup_untracked(dir->untracked, untracked,
>                                      dirname + baselen, len - baselen);
>         state = read_directory_recursive(dir, istate, dirname, len, untracked,
> -                                        check_only, stop_early, pathspec);
> +                                        check_only, stop_early, pathspec, cache);
>
>         /* There are a variety of reasons we may need to fixup the state... */
>         if (state == path_excluded) {
> @@ -2242,7 +2255,8 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
>                                            struct index_state *istate,
>                                            struct strbuf *path,
>                                            int baselen,
> -                                          const struct pathspec *pathspec)
> +                                          const struct pathspec *pathspec,
> +                                          struct traversal_cache *cache)
>  {
>         /*
>          * WARNING: From this function, you can return path_recurse or you
> @@ -2264,7 +2278,7 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
>                  * with check_only set.
>                  */
>                 return read_directory_recursive(dir, istate, path->buf, path->len,
> -                                               cdir->ucd, 1, 0, pathspec);
> +                                               cdir->ucd, 1, 0, pathspec, cache);
>         /*
>          * We get path_recurse in the first run when
>          * directory_exists_in_index() returns index_nonexistent. We
> @@ -2280,13 +2294,14 @@ static enum path_treatment treat_path(struct dir_struct *dir,
>                                       struct index_state *istate,
>                                       struct strbuf *path,
>                                       int baselen,
> -                                     const struct pathspec *pathspec)
> +                                     const struct pathspec *pathspec,
> +                                     struct traversal_cache *cache)
>  {
>         int has_path_in_index, dtype, excluded;
>
>         if (!cdir->d_name)
>                 return treat_path_fast(dir, cdir, istate, path,
> -                                      baselen, pathspec);
> +                                      baselen, pathspec, cache);
>         if (is_dot_or_dotdot(cdir->d_name) || !fspathcmp(cdir->d_name, ".git"))
>                 return path_none;
>         strbuf_setlen(path, baselen);
> @@ -2348,7 +2363,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
>                 strbuf_addch(path, '/');
>                 return treat_directory(dir, istate, untracked,
>                                        path->buf, path->len,
> -                                      baselen, excluded, pathspec);
> +                                      baselen, excluded, pathspec, cache);
>         case DT_REG:
>         case DT_LNK:
>                 if (pathspec &&
> @@ -2549,7 +2564,8 @@ static void add_path_to_appropriate_result_list(struct dir_struct *dir,
>  static enum path_treatment read_directory_recursive(struct dir_struct *dir,
>         struct index_state *istate, const char *base, int baselen,
>         struct untracked_cache_dir *untracked, int check_only,
> -       int stop_at_first_file, const struct pathspec *pathspec)
> +       int stop_at_first_file, const struct pathspec *pathspec,
> +       struct traversal_cache *cache)
>  {
>         /*
>          * WARNING: Do NOT recurse unless path_recurse is returned from
> @@ -2572,7 +2588,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
>         while (!read_cached_dir(&cdir)) {
>                 /* check how the file or directory should be treated */
>                 state = treat_path(dir, untracked, &cdir, istate, &path,
> -                                  baselen, pathspec);
> +                                  baselen, pathspec, cache);
>                 dir->visited_paths++;
>
>                 if (state > dir_state)
> @@ -2587,7 +2603,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
>                         subdir_state =
>                                 read_directory_recursive(dir, istate, path.buf,
>                                                          path.len, ud,
> -                                                        check_only, stop_at_first_file, pathspec);
> +                                                        check_only, stop_at_first_file, pathspec, cache);
>                         if (subdir_state > dir_state)
>                                 dir_state = subdir_state;
>
> @@ -2661,7 +2677,8 @@ int check_dir_entry_contains(const struct dir_entry *out, const struct dir_entry
>  static int treat_leading_path(struct dir_struct *dir,
>                               struct index_state *istate,
>                               const char *path, int len,
> -                             const struct pathspec *pathspec)
> +                             const struct pathspec *pathspec,
> +                             struct traversal_cache *cache)
>  {
>         struct strbuf sb = STRBUF_INIT;
>         struct strbuf subdir = STRBUF_INIT;
> @@ -2713,7 +2730,8 @@ static int treat_leading_path(struct dir_struct *dir,
>                 strbuf_reset(&subdir);
>                 strbuf_add(&subdir, path+prevlen, baselen-prevlen);
>                 cdir.d_name = subdir.buf;
> -               state = treat_path(dir, NULL, &cdir, istate, &sb, prevlen, pathspec);
> +
> +               state = treat_path(dir, NULL, &cdir, istate, &sb, prevlen, pathspec, cache);
>
>                 if (state != path_recurse)
>                         break; /* do not recurse into it */
> @@ -2986,6 +3004,9 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
>                    const char *path, int len, const struct pathspec *pathspec)
>  {
>         struct untracked_cache_dir *untracked;
> +       struct traversal_cache cache = {
> +               .real_gitdir = NULL,
> +       };
>
>         trace2_region_enter("dir", "read_directory", istate->repo);
>         dir->visited_paths = 0;
> @@ -3003,8 +3024,10 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
>                  * e.g. prep_exclude()
>                  */
>                 dir->untracked = NULL;
> -       if (!len || treat_leading_path(dir, istate, path, len, pathspec))
> -               read_directory_recursive(dir, istate, path, len, untracked, 0, 0, pathspec);
> +       if (!len || treat_leading_path(dir, istate, path, len, pathspec, &cache)) {
> +               read_directory_recursive(dir, istate, path, len, untracked, 0, 0, pathspec, &cache);
> +       }
> +       FREE_AND_NULL(cache.real_gitdir);
>         QSORT(dir->entries, dir->nr, cmp_dir_entry);
>         QSORT(dir->ignored, dir->ignored_nr, cmp_dir_entry);
>
> --
> 2.36.0

This makes sense as a way to avoid the call to real_pathdup() if
that's what we want, but I feel it's a micro-optimization that isn't
worth this code churn.  I'd rather drop this patch from the series and
just use the real_pathdup() you had before (see
https://lore.kernel.org/git/CABPp-BGXRzYCvyM38dEUvQ125+VtRu++7L9UiRz98u+1=Lov7A@mail.gmail.com/).
Let's see what Junio says, but I'm hoping he agrees this patch isn't
needed.

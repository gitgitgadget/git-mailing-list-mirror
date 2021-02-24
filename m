Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7101C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 05:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A248564D9A
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 05:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhBXFYP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 00:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhBXFYO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 00:24:14 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30748C061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 21:23:34 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id z126so1246169oiz.6
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 21:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+wTatz45+AzDcH96OtTu08qiLzHgBHsecgW2YZNbNg=;
        b=DorSrSi5JLFU3mmBBjr1XZiWJaCTD0FtGRoF10idOFpTH2E6bc2jhbE/8qLZhayzsH
         daxM7RgVHC/CANeT/UDXdiuKkF13bLN2QdMTn/UZYGMuK3g2b7uANZ4YLzXws9o7mYTn
         SJvfNYEf02f0pS+6rhxg+wWTYscPap9rvbtg59u8we0m6A2AFpRZC8NpKCJ6zNUScbeY
         byeEtrkOuMTTMCNCAf0UIWoLJaE5pAfkaq2u5tc20U2UPYuB4DZxb2b7vbVydQSHL24m
         2vitnm3WhECB6kQOQnLYcKG3+lqeelIH7xqjrdrjhAQ1pQESQh8VpDQ588fMm9Rdqyfu
         YNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+wTatz45+AzDcH96OtTu08qiLzHgBHsecgW2YZNbNg=;
        b=XGxx9bsjzc+IrEVZGRrf4J6rDbgcngagAL/ysrsFulAkkQim3yNN2Z39pUF4doS5Zw
         vxuHEPjjLs6Z5aLqNEycw96Irseh79S1ivtrt5fBK22M1uUMqX0K2oRJmhI9B3s08smo
         deDwwoyOn5kldnwXLUy/tm88aDpoDydHQJ3lbU3h8DpQ+7rn4o/747DM01/FqNTYb6ev
         vC1YO05lfcKbA02c0MReh/sG0ASWb7IDiCsCcInQo93Rb5P4PBrrT1fDDHoD3XZ80yz+
         YboVDQn/ghoDcZoCvzpvdo1uYyteOWFaxhXf+F/iVolgFiHbJq+lG0gCOFmrxQELrOdW
         nSsA==
X-Gm-Message-State: AOAM532e5LCq0f+OZnI1Wxs2/CgMjU4eWeCVsdeYI1Hwcq2JGoWrPmKe
        d7qGk7C1aVID4Jn4vrTiTMWdI8Yl9Nz6/A+LB9/IOatr0M0=
X-Google-Smtp-Source: ABdhPJx1zBGIdBUiFOiTqUzKGSEDq8SGfFVvd4/SxaqMYVun3cunsEd77FWD3luzb0pmYhOjYlhs4dbIO4bT5F9nds8=
X-Received: by 2002:aca:b407:: with SMTP id d7mr1543942oif.167.1614144213594;
 Tue, 23 Feb 2021 21:23:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614138107.git.matheus.bernardino@usp.br> <a8a8af22a03f73c572c3d45d9e7dbb0503451fa2.1614138107.git.matheus.bernardino@usp.br>
In-Reply-To: <a8a8af22a03f73c572c3d45d9e7dbb0503451fa2.1614138107.git.matheus.bernardino@usp.br>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Feb 2021 21:23:22 -0800
Message-ID: <CABPp-BGDDuEdiTYpM-KZJm=ZHuKpOmVHV6pCXuY6H1nmVCaMdQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] pathspec: allow to ignore SKIP_WORKTREE entries on
 index matching
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 8:05 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Add the 'ignore_skip_worktree' boolean parameter to both
> add_pathspec_matches_against_index() and
> find_pathspecs_matching_against_index(). When true, these functions will
> not try to match the given pathspec with SKIP_WORKTREE entries. This
> will be used in a future patch to make `git add` display a hint
> when the pathspec matches only sparse paths.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  builtin/add.c          |  4 ++--
>  builtin/check-ignore.c |  2 +-
>  pathspec.c             | 10 +++++++---
>  pathspec.h             |  5 +++--
>  4 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 5fec21a792..e15b25a623 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -177,7 +177,7 @@ static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec,
>                         *dst++ = entry;
>         }
>         dir->nr = dst - dir->entries;
> -       add_pathspec_matches_against_index(pathspec, &the_index, seen);
> +       add_pathspec_matches_against_index(pathspec, &the_index, seen, 0);

One thing to consider here is something Stolee has suggested to me
multiple times -- introducing an enum with self-documenting values.
For example:

enum ignore_skip_worktree_values {
  HEED_SKIP_WORKTREE = 0,
  IGNORE_SKIP_WORKTREE = 1
};

This would allow all the function callers to pass HEED_SKIP_WORKTREE
instead of a bare 0, and allows code readers to avoid looking up
function signatures to find the meaning behind the 0.  It's a minor
point, though.

>         return seen;
>  }
>
> @@ -578,7 +578,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>                 int i;
>
>                 if (!seen)
> -                       seen = find_pathspecs_matching_against_index(&pathspec, &the_index);
> +                       seen = find_pathspecs_matching_against_index(&pathspec, &the_index, 0);
>
>                 /*
>                  * file_exists() assumes exact match
> diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
> index 3c652748d5..235b7fc905 100644
> --- a/builtin/check-ignore.c
> +++ b/builtin/check-ignore.c
> @@ -100,7 +100,7 @@ static int check_ignore(struct dir_struct *dir,
>          * should not be ignored, in order to be consistent with
>          * 'git status', 'git add' etc.
>          */
> -       seen = find_pathspecs_matching_against_index(&pathspec, &the_index);
> +       seen = find_pathspecs_matching_against_index(&pathspec, &the_index, 0);
>         for (i = 0; i < pathspec.nr; i++) {
>                 full_path = pathspec.items[i].match;
>                 pattern = NULL;
> diff --git a/pathspec.c b/pathspec.c
> index 7a229d8d22..e5e6b7458d 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -21,7 +21,7 @@
>   */
>  void add_pathspec_matches_against_index(const struct pathspec *pathspec,
>                                         const struct index_state *istate,
> -                                       char *seen)
> +                                       char *seen, int ignore_skip_worktree)
>  {
>         int num_unmatched = 0, i;
>
> @@ -38,6 +38,8 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
>                 return;
>         for (i = 0; i < istate->cache_nr; i++) {
>                 const struct cache_entry *ce = istate->cache[i];
> +               if (ignore_skip_worktree && ce_skip_worktree(ce))
> +                       continue;
>                 ce_path_match(istate, ce, pathspec, seen);
>         }
>  }
> @@ -51,10 +53,12 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
>   * given pathspecs achieves against all items in the index.
>   */
>  char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
> -                                           const struct index_state *istate)
> +                                           const struct index_state *istate,
> +                                           int ignore_skip_worktree)
>  {
>         char *seen = xcalloc(pathspec->nr, 1);
> -       add_pathspec_matches_against_index(pathspec, istate, seen);
> +       add_pathspec_matches_against_index(pathspec, istate, seen,
> +                                          ignore_skip_worktree);
>         return seen;
>  }
>
> diff --git a/pathspec.h b/pathspec.h
> index 454ce364fa..8202882ecd 100644
> --- a/pathspec.h
> +++ b/pathspec.h
> @@ -151,9 +151,10 @@ static inline int ps_strcmp(const struct pathspec_item *item,
>
>  void add_pathspec_matches_against_index(const struct pathspec *pathspec,
>                                         const struct index_state *istate,
> -                                       char *seen);
> +                                       char *seen, int ignore_skip_worktree);
>  char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
> -                                           const struct index_state *istate);
> +                                           const struct index_state *istate,
> +                                           int ignore_skip_worktree);
>  int match_pathspec_attrs(const struct index_state *istate,
>                          const char *name, int namelen,
>                          const struct pathspec_item *item);
> --
> 2.30.1

Looks good.

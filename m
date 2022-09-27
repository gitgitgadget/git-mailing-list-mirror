Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD25C6FA90
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 08:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiI0IMI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 04:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiI0ILF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 04:11:05 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8388A7E4
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 01:05:46 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b24so10031796ljk.6
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 01:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gVoRVI1+4xQDZaW0GjNqau8BrJDb2ZC3pIEcXBkiAIQ=;
        b=aBhz1F2X7dg6JvrP814Nw0wN98kzdagm2fcycFHdS/72i2Ks9fz5aU1aSVSt+jkjb+
         Es5a9z+383gmMG8pt0XUlYROcgA6tVxLSMQhzwGAgixa/jtAI8ajaWBw5VF3tlBF1rEz
         6O8xrtQffTu84i3kgcERJffosXFH7w3vgH6hmKg2IT8E6y0AzwrZru9pBb5i0wt6Sbyo
         /99k6GEhxGzAlGOCsM2xjeqOHDPCCqWN7IzgRe07kg0AGFONR2SaA4DuF6iSZ1m8HGiO
         VvY+MzpWpoQM44JIPMODdLdW/0fO/ZeiiGq+/oKMsXXEDpttZDeNP5VAs/2+EPsUjmop
         udWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gVoRVI1+4xQDZaW0GjNqau8BrJDb2ZC3pIEcXBkiAIQ=;
        b=oTzRl19AQdYW0oDLaLlImC4c++1lHRoQSGDuxI+890+alM7Pwd4QxVxCGUenwp4K7t
         jOFMUTMsZp4OKQWGe4OVMKss4M05BpAnKZozjP39fIQxw/BERaB6lt8wCRzJOetQ1dDz
         kTcLGo9GbJ4RoBLRqiWnOCZlaBpA6zuiduxZM52pLoamUEkc5NyRgNutoCUUh77Ds0fk
         uTCAUjXjFuOj5A3C5VxM0RWe8RCPePFSDTCvr4oNQTDwcVP4bHgkTMEzqA7H/MY0ZlkJ
         skiPHsfcQdvYUqRMpj/aclK1k9pz8iH9AFP+YaOZ0K/PWziexyheIQybEvOLk5ayblLU
         Nh/w==
X-Gm-Message-State: ACrzQf0g9d8sin/jSdOYEVHzdnHtMzAWQZQSHw45If5pNNQhPeUeleCu
        iB65j8WJt6585wDBRVkBfAhwQOt2ja7P5RKgum0=
X-Google-Smtp-Source: AMsMyM4WWD1S2C3U3jrPZlcuJkTPtfIDCcnl+egbm3JJy7ab73imyRb3oRUsj4A2VzxlgHcG4mDWQT+mRpGT/WoBdOs=
X-Received: by 2002:a05:651c:903:b0:26c:2f7f:c037 with SMTP id
 e3-20020a05651c090300b0026c2f7fc037mr9843614ljq.325.1664265944514; Tue, 27
 Sep 2022 01:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1362.v3.git.1663875999939.gitgitgadget@gmail.com>
 <pull.1362.v4.git.1664229348.gitgitgadget@gmail.com> <087207ae0b0932fcec9aa25e97bbe9227eff81cb.1664229348.git.gitgitgadget@gmail.com>
In-Reply-To: <087207ae0b0932fcec9aa25e97bbe9227eff81cb.1664229348.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 27 Sep 2022 01:05:32 -0700
Message-ID: <CABPp-BHau2qwoxj121H-cpjTPPCpfxjMpmhya0mV79qyvkpQ+g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] merge-ort: return early when failing to write a blob
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2022 at 2:55 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In the previous commit, we fixed a segmentation fault when a tree object
> could not be written.
>
> However, before the tree object is written, `merge-ort` wants to write
> out a blob object (except in cases where the merge results in a blob
> that already exists in the database). And this can fail, too, but we
> ignore that write failure so far.
>
> Since we will always write out a new tree object in addition to the blob
> (and if the blob did not exist in the database yet, we can be certain
> that the tree object did not exist yet), the merge will _still_ fail at
> that point, but it does unnecessary work by continuing after the blob
> could not be written.

I don't think this is quite true.  I've had a number of users come to
me with "messed up git repositories" where I eventually discover that
users just randomly add "sudo" to some of their commands because when
things don't work, sometimes "sudo" fixes it.  That means they've
created stuff in their .git directory which may be owned by root,
perhaps even some of the .git/objects/XX directories.  However, they
may have other .git/objects/XX directories owned by their normal user.

If just some .git/objects/XX directories are owned by root and not
others, then it may be when users run git commands as themselves that
some things can be written to the object database but not others.  In
particular, it could be that writing blob objects fail, but writing a
tree object which references those blobs succeeds.

> Let's pay close attention and error out early if the blob could not be
> written. This reduces the error output of t4301.25 ("merge-ort fails
> gracefully in a read-only repository") from:
>
>         error: insufficient permission for adding an object to repository database ./objects
>         error: error: Unable to add numbers to database
>         error: insufficient permission for adding an object to repository database ./objects
>         error: error: Unable to add greeting to database
>         error: insufficient permission for adding an object to repository database ./objects
>         fatal: failure to merge
>
> to:
>
>         error: insufficient permission for adding an object to repository database ./objects
>         error: error: Unable to add numbers to database
>         fatal: failure to merge
>
> Note: This patch adjusts two variable declarations from `unsigned` to
> `int` because their purpose is to hold the return value of
> `handle_content_merge()`, which is of type `int`. The existing users of
> those variables are only interested whether that variable is zero or
> non-zero, therefore this type change does not affect the existing code.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  merge-ort.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index f3bdce1041a..e5f41cce481 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -2807,6 +2807,8 @@ static int process_renames(struct merge_options *opt,
>                                                            pathnames,
>                                                            1 + 2 * opt->priv->call_depth,
>                                                            &merged);
> +                       if (clean_merge < 0)
> +                               return -1;
>                         if (!clean_merge &&
>                             merged.mode == side1->stages[1].mode &&
>                             oideq(&merged.oid, &side1->stages[1].oid))
> @@ -2916,7 +2918,7 @@ static int process_renames(struct merge_options *opt,
>                         struct version_info merged;
>
>                         struct conflict_info *base, *side1, *side2;
> -                       unsigned clean;
> +                       int clean;
>
>                         pathnames[0] = oldpath;
>                         pathnames[other_source_index] = oldpath;
> @@ -2937,6 +2939,8 @@ static int process_renames(struct merge_options *opt,
>                                                      pathnames,
>                                                      1 + 2 * opt->priv->call_depth,
>                                                      &merged);
> +                       if (clean < 0)
> +                               return -1;
>
>                         memcpy(&newinfo->stages[target_index], &merged,
>                                sizeof(merged));
> @@ -3806,10 +3810,10 @@ static int write_completed_directory(struct merge_options *opt,
>  }
>
>  /* Per entry merge function */
> -static void process_entry(struct merge_options *opt,
> -                         const char *path,
> -                         struct conflict_info *ci,
> -                         struct directory_versions *dir_metadata)
> +static int process_entry(struct merge_options *opt,
> +                        const char *path,
> +                        struct conflict_info *ci,
> +                        struct directory_versions *dir_metadata)
>  {
>         int df_file_index = 0;
>
> @@ -3823,7 +3827,7 @@ static void process_entry(struct merge_options *opt,
>                 record_entry_for_tree(dir_metadata, path, &ci->merged);
>                 if (ci->filemask == 0)
>                         /* nothing else to handle */
> -                       return;
> +                       return 0;
>                 assert(ci->df_conflict);
>         }
>
> @@ -3870,7 +3874,7 @@ static void process_entry(struct merge_options *opt,
>                  */
>                 if (ci->filemask == 1) {
>                         ci->filemask = 0;
> -                       return;
> +                       return 0;
>                 }
>
>                 /*
> @@ -4065,7 +4069,7 @@ static void process_entry(struct merge_options *opt,
>         } else if (ci->filemask >= 6) {
>                 /* Need a two-way or three-way content merge */
>                 struct version_info merged_file;
> -               unsigned clean_merge;
> +               int clean_merge;
>                 struct version_info *o = &ci->stages[0];
>                 struct version_info *a = &ci->stages[1];
>                 struct version_info *b = &ci->stages[2];
> @@ -4074,6 +4078,8 @@ static void process_entry(struct merge_options *opt,
>                                                    ci->pathnames,
>                                                    opt->priv->call_depth * 2,
>                                                    &merged_file);
> +               if (clean_merge < 0)
> +                       return -1;
>                 ci->merged.clean = clean_merge &&
>                                    !ci->df_conflict && !ci->path_conflict;
>                 ci->merged.result.mode = merged_file.mode;
> @@ -4169,6 +4175,7 @@ static void process_entry(struct merge_options *opt,
>
>         /* Record metadata for ci->merged in dir_metadata */
>         record_entry_for_tree(dir_metadata, path, &ci->merged);
> +       return 0;
>  }
>
>  static void prefetch_for_content_merges(struct merge_options *opt,
> @@ -4285,7 +4292,10 @@ static int process_entries(struct merge_options *opt,
>                         record_entry_for_tree(&dir_metadata, path, mi);
>                 else {
>                         struct conflict_info *ci = (struct conflict_info *)mi;
> -                       process_entry(opt, path, ci, &dir_metadata);
> +                       if (process_entry(opt, path, ci, &dir_metadata) < 0) {
> +                               ret = -1;
> +                               goto cleanup;
> +                       };
>                 }
>         }
>         trace2_region_leave("merge", "processing", opt->repo);
> --
> gitgitgadget

Patch looks good to me, though.

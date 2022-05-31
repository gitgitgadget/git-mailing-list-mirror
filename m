Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42005C433EF
	for <git@archiver.kernel.org>; Tue, 31 May 2022 09:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244931AbiEaJ4R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 05:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbiEaJ4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 05:56:16 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD53215A2B
        for <git@vger.kernel.org>; Tue, 31 May 2022 02:56:15 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id v15so12349867pgk.11
        for <git@vger.kernel.org>; Tue, 31 May 2022 02:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KRM3YI0O0bhO0taML6lNLSc9TTTFuOYqOyj1SoebtNM=;
        b=B3ONcd+AuORRrseXkxcPyapcZpACJ1rLvuVxjRVYiGOB2lZv4NIK1bKbHjN/h73/T3
         2XBlGI9IMP4bLxDPYxatVkD2m5uOzCHlTa30erMl4autc0YgnaOOB49h3gkhLP7RTo1G
         95znUcM3nQBkEeOC9qf/PEx3ThqRAEwuW0OXl3sMrYoqsFy0YGMJgVqZ+XAU1ITDYBWv
         QXYrN/2ZF3nPtSoPBWO4ci/rL2kFXAFSXh63EKT51TiVyyPrugGfYUVePpI9dx9ELDZh
         HsxxgG91N+ByAoyQZq/039qomsbnTgk6389f60Lv1PeonHZBjc8HuqBMKhiKUvSL7NLz
         rWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KRM3YI0O0bhO0taML6lNLSc9TTTFuOYqOyj1SoebtNM=;
        b=pD/xuM57kyrqt0DSxgb0ihewhokWXhHKTc1TAiNSqAJgq3oyqKLal5xr/Af8/8yDNo
         0jQEKLloLYdsGmGsMbnrGXI93cJv9TAf9evVi0w+ZFCHEVRk2txzG/PHOXveiv2BdRsk
         kxpFiFB9THFjTuJJMPqDgb2xXmX464SltOygUMy+hTUZYSpGyRbudgOmy1KoU7r0hNl/
         ZPE7sB4n7q39wKYynNgipdOSMC7lkZocAsTPOFQ8Io4YqVqZCiMPCuJxyua9UBurfW9v
         UeScHQGlks02RPMO+Sqm/L7Op6WfLJhQV/W2oUD/97F19wLLffoBFYkvC1AEJ/V7pLXM
         EjVw==
X-Gm-Message-State: AOAM532DnrX+gj/nQ1Jv4UIRKJms5rAv31/rAbjirWDf1pxXQ9mBPMWd
        x/RnjSLYdPr2LbIClDNCoBCR3awKHNPW4dk5fzM=
X-Google-Smtp-Source: ABdhPJzBlUvJrAFqMbhInv1w3aTCyC5+eavBhP3JUe0RbSx6siaXm0E4hdzrQTHNZLArqcyu6lNihZClPeAr4nsUAQU=
X-Received: by 2002:a05:6a00:16cb:b0:517:c8ff:6ff6 with SMTP id
 l11-20020a056a0016cb00b00517c8ff6ff6mr60377804pfc.46.1653990975226; Tue, 31
 May 2022 02:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-1-shaoxuan.yuan02@gmail.com> <20220527100804.209890-5-shaoxuan.yuan02@gmail.com>
 <bc51f198-629f-0b68-a8e4-8135f61c0d03@github.com>
In-Reply-To: <bc51f198-629f-0b68-a8e4-8135f61c0d03@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Tue, 31 May 2022 17:56:01 +0800
Message-ID: <CAJyCBORo-x4jbKhtn+vUE=1TxpM83_3JWj5cvJEJJHHsv2Q0bg@mail.gmail.com>
Subject: Re: [WIP v2 4/5] mv: add check_dir_in_index() and solve general dir
 check issue
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, vdye@github.com, gitster@pobox.com,
        newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 27, 2022 at 11:27 PM Derrick Stolee
<derrickstolee@github.com> wrote:
>
> On 5/27/2022 6:08 AM, Shaoxuan Yuan wrote:
> > +/*
> > + * Check if an out-of-cone directory should be in the index. Imagine this case
> > + * that all the files under a directory are marked with 'CE_SKIP_WORKTREE' bit
> > + * and thus the directory is sparsified.
> > + *
> > + * Return 0 if such directory exist (i.e. with any of its contained files not
> > + * marked with CE_SKIP_WORKTREE, the directory would be present in working tree).
> > + * Return 1 otherwise.
> > + */
> > +static int check_dir_in_index(const char *name, int namelen)
> > +{
> > +     int ret = 1;
> > +     const char *with_slash = add_slash(name);
> > +     int length = namelen + 1;
> > +
> > +     int pos = cache_name_pos(with_slash, length);
> > +     const struct cache_entry *ce;
> > +
> > +     if (pos < 0) {
> > +             pos = -pos - 1;
> > +             if (pos >= the_index.cache_nr)
> > +                     return ret;
> > +             ce = active_cache[pos];
> > +             if (strncmp(with_slash, ce->name, length))
> > +                     return ret;
> > +             if (ce_skip_worktree(ce))
> > +                     return ret = 0;
>
> This appears to check if the _first_ entry under the directory
> is sparse, but not if _all_ entries are sparse. These are not
> the same thing, even in cone-mode sparse-checkout. The t1092
> test directory has files like "folder1/0/0/a" but if
> "folder1/1" is in the sparse-checkout cone, then that first
> entry has the skip-worktree bit, but "folder1/1/a" and "folder1/a"
> do not.

Yes, it is checking the first entry and this would not work without the
lstat in the front. But I think the "lstat < 0" makes sure that this directory
cannot be partially sparsified.

It is either missing both in the worktree and index, or missing in the worktree
but present in index (with all its content sparsified). And because of that,
I think only the first entry needs to be checked.

> > +     }
> > +     return ret;
>
> At the moment, it doesn't seem like we need 'ret' since the
> only place you set it is in "return ret = 0;" (which could
> just be "return 0;" while the others are "return 1;"). But,
> perhaps you intended to create a loop over 'pos' while
> with_slash is a prefix of the cache entry?

I agree that this variable is redundant. But I fail to understand
the logical relation between before "But," and after "But,". Please
elaborate on that?

> > +                     else if (!check_dir_in_index(src, length) &&
> > +                                      !path_in_sparse_checkout(src_w_slash, &the_index)) {
>
> style-nit: You'll want to align the different parts of your
> logical statement to agree with the end of the "else if (",
>
>         else if (A &&
>                  B) {
>

This one is interesting because it appears just alright in my VSCode editor.
Later I found that it is because git-diff is using a tab size of 8 or something,
but my VSCode uses tab size of 4. After I configured the git-diff tab rendering
size, it looks alright. Same for another style nit down below.

> > +                             modes[i] = SKIP_WORKTREE_DIR;
>
> If we are moving to a flags-based model, should we convert all
> "modes[i] =" to "modes[i] |=" as a first step (before adding the
> SKIP_WORTKREE_DIR flag)?
>
> > +                             goto dir_check;
>
> Hm. While I did recommend using 'goto' to jump to a common end
> place in the loop body, I'm not sure about jumping into another
> else-if statement. This might be a good time to extract the
> code from "else if (src_is_dir)" below into a helper method that
> can be used in both places.

Right, this is suspicious. I wasn't familiar at all with C/C++, and being able
to do this inter-if-else jump also startled me.
I agree that it should be something more legitimate, like extracting a
method for it.

> > +                     }
> >                       /* only error if existence is expected. */
> >                       else if (modes[i] != SPARSE)
> >                               bad = _("bad source");
> > @@ -218,7 +264,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
> >                               && lstat(dst, &st) == 0)
> >                       bad = _("cannot move directory over file");
> >               else if (src_is_dir) {
> > -                     int first = cache_name_pos(src, length), last;
> > +                     int first, last;
> > +dir_check:
> > +                     first = cache_name_pos(src, length);
> >
> >                       if (first >= 0)
> >                               prepare_move_submodule(src, first,
> > @@ -229,7 +277,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
> >                       else { /* last - first >= 1 */
> >                               int j, dst_len, n;
> >
> > -                             modes[i] = WORKING_DIRECTORY;
> > +                             if (!modes[i])
> > +                                     modes[i] |= WORKING_DIRECTORY;
>
> This appears to only add the WORKING_DIRECTORY flag if modes[i] is
> already zero. This maybe implies that we wouldn't understand
> "WORKING_DIRECTORY | SKIP_WORKTREE_DIR" as a value.

At this point, I cannot think of the reason for writing it this way. And yes,
this does not make sense...

> >                               n = argc + last - first;
> >                               REALLOC_ARRAY(source, n);
> >                               REALLOC_ARRAY(destination, n);
> > @@ -331,7 +380,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
> >                       printf(_("Renaming %s to %s\n"), src, dst);
> >               if (show_only)
> >                       continue;
> > -             if (mode != INDEX && mode != SPARSE && rename(src, dst) < 0) {
> > +             if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
> > +                     rename(src, dst) < 0) {
>
> style-nit: align your logical statements.
>
> >                       if (ignore_errors)
> >                               continue;
> >                       die_errno(_("renaming '%s' failed"), src);
> > @@ -345,7 +395,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
> >                                                             1);
> >               }
> >
> > -             if (mode == WORKING_DIRECTORY)
> > +             if (mode & (WORKING_DIRECTORY | SKIP_WORKTREE_DIR))
> >                       continue;
>
> Ok, here you check if _either_ mode is enabled, which is good. Maybe
> you don't need the "if (!mode[i])" part above.
>
> Thanks,
> -Stolee

-- 
Thanks & Regards,
Shaoxuan

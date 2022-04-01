Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5953C433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 12:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345978AbiDAMvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 08:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345974AbiDAMvO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 08:51:14 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712843D1D1
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 05:49:24 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-de3eda6b5dso2625372fac.0
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 05:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iiKhhd4+AC9ihhpaWY9r89fh/tdEcqK6HSnAuBHyFZU=;
        b=RDCUtoF+UxHaASdH2ENIgGL9wV1WulgyDRkT5RepLQHGlvffUH3VhBDbBMaWBD0Cbt
         ePnAJaBo9BH6fyWyphhCRAdxdxNV21LS9xUxwFCF+A6OeGp36qRdGo6SHQtBqD4kZHbp
         vhsxTCiXkfsSQ6fZSueR+BdlMNT0ZsevpMRpwbLPjQAlayyWj35fCo6VI9IU2l8RdQ9y
         gV5mHhOap0U4iaBsjzwinvlvZFMOo9AU2nrrhd4bYRXkiHjqQNpuLrEEpxP+wgOYM0qJ
         ULHWyPme0xLFh8vFxi1E+GBFdpKHZmDttmI6p/Ymts27zhj4uJ9AhPFbF0cyH/2VlQJR
         gnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iiKhhd4+AC9ihhpaWY9r89fh/tdEcqK6HSnAuBHyFZU=;
        b=8JESfzn3d2w8Sby98ox+2fbUfIA0/B/ZM3jvQ6GBpTmcWb+/cZ3ifhTDyDB7sLsmiz
         TRZPO/0VdvBgm2z5T3aFJEVWXduFH7+IGCsr2JQLszkKsxXtHlErOboLRQqKF4sgj9ps
         tvN8MK1VRO9FKqqrbBeFXeUNGoqjoqSabdi9oX1MHd1DxNCybgJ9T1+q/mpPsOgbM+Ro
         YqEF9xSoaEWY/92I4HhgPXIg4Mr1FHbS0m+b/Y74jIFRiBwI6UqS1vttmENrkKYtPYuF
         ytrrW8f00Tx7Xqf8BZYeyBt+F8OWCf1VTaeddLYCEf50jZq7kRqa610QbdL6mAJGy/d3
         Tslg==
X-Gm-Message-State: AOAM533UxVktkfEUIn7sfjEcwKwwvnxZcH0XAJzVr5rqnK4RJKLgt3FS
        FqoO6WnxdUleVJou79zYHU8qs1ps+5sE4B+ndtN80DTcbLekNQ==
X-Google-Smtp-Source: ABdhPJyn0WgnhaTo+vXYEp+n5mUeuQcdTTNh4vZT5peVnFfmNuYArNiV6o+XQT5Wpku1iUph1rYqKET7xqohoTNa4Es=
X-Received: by 2002:a05:6870:f697:b0:da:b3f:3268 with SMTP id
 el23-20020a056870f69700b000da0b3f3268mr4895925oab.280.1648817362181; Fri, 01
 Apr 2022 05:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220331091755.385961-3-shaoxuan.yuan02@gmail.com> <52784078-c748-a4a0-68b4-db3c133dfa80@github.com>
In-Reply-To: <52784078-c748-a4a0-68b4-db3c133dfa80@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Fri, 1 Apr 2022 20:49:10 +0800
Message-ID: <CAJyCBOQmUYe53ahpEXQZAWMoers0o7b1xuCYu_k-LrfvKTkV-g@mail.gmail.com>
Subject: Re: [WIP v1 2/4] mv: add check_dir_in_index() and solve general dir
 check issue
To:     Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 1, 2022 at 5:28 AM Victoria Dye <vdye@github.com> wrote:
>
> Shaoxuan Yuan wrote:
> > Originally, moving a <source> directory which is not on-disk due
> > to its existence outside of sparse-checkout cone, "giv mv" command
> > errors out with "bad source".
> >
> > Add a helper check_dir_in_index() function to see if a directory
> > name exists in the index. Also add a SPARSE_DIRECTORY bit to mark
> > such directories.
> >
>
> Hmm, I think this patch would fit better in your eventual "sparse index
> integration" series than this "prerequisite fixes to sparse-checkout"
> series. Sparse directories *only* appear when you're using a sparse index
> so, theoretically, this shouldn't ever come up (and thus isn't testable)
> until you're using a sparse index.

After reading your feedback, I realized that I totally misused
the phrase "sparse directory". Clearly, this patch series does not
deal with sparse-
index yet, as "sparse directory" is a cache entry that points to a
tree, if sparse-index
is enabled. Silly me ;)

What I was *actually* trying to say is: I want to change the checking
logic of moving
a "directory that exists outside of sparse-checkout cone", and I
apparently misused
"sparse directory" to reference such a thing.

> Since it's here, though, I'm happy to review what you have (even if you
> eventually move it to a later series)!

Thanks!

> > diff --git a/builtin/mv.c b/builtin/mv.c
> > index 32ad4d5682..9da9205e01 100644
> > --- a/builtin/mv.c
> > +++ b/builtin/mv.c
> > @@ -115,6 +115,25 @@ static int index_range_of_same_dir(const char *src, int length,
> >       return last - first;
> >  }
> >
> > +static int check_dir_in_index(const char *dir)
> > +{
>
> This function can be made a lot simpler - you can use `cache_name_pos()` to
> find the index entry - if it's found, the directory exists as a sparse
> directory. And, because 'add_slash()' enforces the trailing slash later on,
> you don't need to worry about adjusting the name before you look for the
> entry.

Yes, if I correctly used the phrase "sparse directory", but I did not...
I think I can use 'cache_name_pos()' to
check a directory *iff* it is a legit sparse directory when using sparse-index?

In my case, I just want to check a regular directory that is not in
the worktree,
since the cone pattern excludes it. And in a non-sparse index, cache
entry points only
to blobs, not trees, and that's the reason I wrote this weird function
to look into the
index. I understand that sounds not compatible with how git manages
index, but all
I want to know is "does this directory exist in the index?" (this
question is also quasi-correct).

I tried to find an existing API for this job, but I failed to find
any. Though I have a hunch
that there must be something to do it...

> > +     int ret = 0;
> > +     int length = sizeof(dir) + 1;
> > +     char *substr = malloc(length);
> > +
> > +     for (int i = 0; i < the_index.cache_nr; i++) {
> > +             memcpy(substr, the_index.cache[i]->name, length);
> > +             memset(substr + length - 1, 0, 1);
> > +
> > +             if (strcmp(dir, substr) == 0) {
> > +                     ret = 1;
> > +                     return ret;
> > +             }
> > +     }
> > +     free(substr);
> > +     return ret;
> > +}
> > +
> >  int cmd_mv(int argc, const char **argv, const char *prefix)
> >  {
> >       int i, flags, gitmodules_modified = 0;
> > @@ -129,7 +148,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
> >               OPT_END(),
> >       };
> >       const char **source, **destination, **dest_path, **submodule_gitfile;
> > -     enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX, SPARSE } *modes;
> > +     enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX, SPARSE,
> > +     SPARSE_DIRECTORY } *modes;
> >       struct stat st;
> >       struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
> >       struct lock_file lock_file = LOCK_INIT;
> > @@ -197,6 +217,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
> >                        */
> >
> >                       int pos = cache_name_pos(src, length);
> > +                     const char *src_w_slash = add_slash(src);
> > +
> >                       if (pos >= 0) {
> >                               const struct cache_entry *ce = active_cache[pos];
> >
> > @@ -209,6 +231,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
> >                               else
> >                                       bad = _("bad source");
> >                       }
> > +                     else if (check_dir_in_index(src_w_slash) &&
> > +                     !path_in_sparse_checkout(src_w_slash, &the_index)) {
> > +                             modes[i] = SPARSE_DIRECTORY;
> > +                             goto dir_check;
> > +                     }
>
> In if-statements like this, you'll want to line up the statements in
> parentheses on subsequent lines, like:
>
>         else if (check_dir_in_index(src_w_slash) &&
>                  !path_in_sparse_checkout(src_w_slash, &the_index)) {
>
> ...where the second line is indented 1 (8-space-sized) tab + 1 space.
>
> In general, if you're trying to align code (in this repository), align first
> with as many tabs as possible, then the "remainder" with spaces. Note that
> this isn't 100% consistent throughout the repository - older lines might not
> have been aligned properly - but you should go for this styling on any new
> lines that you add.

Will do.

>
> >                       /* only error if existence is expected. */
> >                       else if (modes[i] != SPARSE)
> >                               bad = _("bad source");
> > @@ -219,7 +246,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
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
> > @@ -230,7 +259,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
> >                       else { /* last - first >= 1 */
> >                               int j, dst_len, n;
> >
> > -                             modes[i] = WORKING_DIRECTORY;
> > +                             if (!modes[i])
> > +                                     modes[i] = WORKING_DIRECTORY;
> >                               n = argc + last - first;
> >                               REALLOC_ARRAY(source, n);
> >                               REALLOC_ARRAY(destination, n);
> > @@ -332,7 +362,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
> >                       printf(_("Renaming %s to %s\n"), src, dst);
> >               if (show_only)
> >                       continue;
> > -             if (mode != INDEX && mode != SPARSE && rename(src, dst) < 0) {
> > +             if (mode != INDEX && mode != SPARSE && mode != SPARSE_DIRECTORY &&
> > +              rename(src, dst) < 0) {
> >                       if (ignore_errors)
> >                               continue;
> >                       die_errno(_("renaming '%s' failed"), src);
> > @@ -346,7 +377,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
> >                                                             1);
> >               }
> >
> > -             if (mode == WORKING_DIRECTORY)
> > +             if (mode == WORKING_DIRECTORY || mode == SPARSE_DIRECTORY)
>
> I'm a bit confused - doesn't this mean the sparse dir move will be skipped?
> In your commit description, you mention that this 'mv' succeeds with the
> '--sparse' option, but I don't see any place where the sparse directory
> would be moved.

Well, you know the drill, I did not use "sparse directory" correctly, let alone
'SPARSE_DIRECTORY' enum bit in this hunk. I think it makes some sense
if you apply my actual meaning of 'SPARSE_DIRECTORY' here (it should be
something like OUT_OF_CONE_WORKING_DIRECTORY)? Because such
directory is not on disk, it cannot be "rename()"d, and should also skip the
"rename_cache_entry_at()" function. If all the files under the directory are
moved/renamed, then (in my opinion) the directory is both moved to the
destination,
both in the worktree and in the index.

-- 
Thanks & Regards,
Shaoxuan

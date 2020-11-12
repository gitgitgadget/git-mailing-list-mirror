Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63CDC2D0E4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47966206FB
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zp8tk41g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgKLWa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgKLWa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:30:56 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F40C0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:30:56 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id o25so8251988oie.5
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SSU8F3QEWBKaQkjBuk4Pv1s9i8j1OMqP4hQrzY0sNEA=;
        b=Zp8tk41g/gB3qGf55k/Q+DkYBqqq7E5nByRT8NSFGNuhNRwJYwrhN/s1r5VT1uDSzh
         wred8GAYBGP1bq9Cps7L8iEtLv3FxW+iSQ/sYquNcGMmNsTdAXLJ2L/2Q98OltsDEIZU
         Y/GQFNYU89LR/rHmp4oTRKcM2y1tVBx4q1MSL4eG4Utkn4lWKPnAnG8f5IoPEf9/Vdx3
         dZifOvaj4vjPz7uLAtcYyKc7TFQxT+Dm68q2ibwY3eAkTQ5YsO/3cenNvYc3CBk9AIfu
         WxPXsaFegdtYN6uQGLDkbbmNcGxRvh1ucW7DNdpPAi36p4MYb1JRjYupEA9uJDZfFKUS
         k/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SSU8F3QEWBKaQkjBuk4Pv1s9i8j1OMqP4hQrzY0sNEA=;
        b=pMYzB9FxfOL2bog2snKeTQNXC3HQ7YEeENjMkPSZx5V305Uqo++mlKO+EVrUwVPPCS
         uAkahaDcm0sE/Ns/yrOMvc2HkTPjR2o0W2Ly4kul+MOk/6HrysXeROmdfXrBvIABI8e7
         Sf7jEg2y9b4iOPMKvS/jzfJRtqxOz+aduuG/EWFkJG9V7FhtYGrRoA0+VwR7ZvJUiLw9
         KzkAAp/ZY/pv/+b31LmJKw3WasUVav6rPG30rCDno0bo78QOjTIkgeoeZIZspoYKFY1L
         ZWcOIwNgBg4JZs/zKLnCs8pnfF5d1M2px1BT0js6Vf+ey8kOjy3ICYzZxNoPVg5b/fpR
         DsTQ==
X-Gm-Message-State: AOAM532VK1er3b+vQbsg/rL8P/PVH31tO9FgaqdG18/Gv/Rt+Nrt1HIz
        LYs9jXcE+4+AhmtiESKCa1X7a6OtlWhEFgboM3kp0Exicv3ejw==
X-Google-Smtp-Source: ABdhPJwEQ1Ye5qRZDm8WqwJ/qWmnIOXsXaKBev4u2HQ8aUUtr3x11biyIRxgxff58TlN3yGCCIhwgZLJ9BFuPONcf7I=
X-Received: by 2002:aca:3756:: with SMTP id e83mr2704oia.31.1605220254944;
 Thu, 12 Nov 2020 14:30:54 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-16-newren@gmail.com> <20201112201524.3438029-1-jonathantanmy@google.com>
In-Reply-To: <20201112201524.3438029-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 12 Nov 2020 14:30:43 -0800
Message-ID: <CABPp-BFwn5+S_swrtZEq6DmZx6kbB0xO_d=ZJkqs4H6FG1vo1Q@mail.gmail.com>
Subject: Re: [PATCH v2 15/20] merge-ort: step 3 of tree writing -- handling
 subdirectories as we go
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 12, 2020 at 12:15 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Firstly, from [1]:
>
> > Thanks for the reviews!  I was hoping to see some comments on patch
> > 15, as it's possibly the gnarliest.  It's a relatively straightforward
> > algorithm, just lots of bookkeeping.
>
> I was planning to send this out yesterday, but couldn't finish it. :-P
> Indeed, a lot of things to think about.
>
> [1] https://lore.kernel.org/git/CABPp-BFgQX6Ash03x7z+RfE3ytbw3x0DzDSBrGddgMr_soODoA@mail.gmail.com/
>
> [snip commit message]
>
> Thanks for the thorough explanation.
>
> > @@ -353,6 +353,9 @@ static int string_list_df_name_compare(const char *one, const char *two)
> >
> >  struct directory_versions {
> >       struct string_list versions;
> > +     struct string_list offsets;
>
> Looking below (and at the explanation in the commit message), this is a
> mapping from full paths to integers casted to the pointer type.
>
> > +     const char *last_directory;
> > +     unsigned last_directory_len;
>
> Is this just the last entry in "versions"?

No, it's a simple cache of strlen(info->last_directory), so I don't
have to recompute that length multiple times.  Perhaps I should add a
comment to that effect.

> >  static void write_tree(struct object_id *result_oid,
> > @@ -409,12 +412,100 @@ static void record_entry_for_tree(struct directory_versions *dir_metadata,
> >               /* nothing to record */
> >               return;
> >
> > +     /*
> > +      * Note: write_completed_directories() already added
> > +      * entries for directories to dir_metadata->versions,
> > +      * so no need to handle ci->filemask == 0 again.
> > +      */
> > +     if (!ci->merged.clean && !ci->filemask)
> > +             return;
> > +
> >       basename = path + ci->merged.basename_offset;
> >       assert(strchr(basename, '/') == NULL);
> >       string_list_append(&dir_metadata->versions,
> >                          basename)->util = &ci->merged.result;
> >  }
>
> Conceptually, I can see how the algorithm below inserts directories, but
> I don't understand the significance of "!ci->merged.clean" in the change
> above.

Checking ci->filemask is likely an out-of-bounds memory read if
ci->merged.clean is true.  (ci may point to something that was
allocated with the size of a merge_info or a conflict_info.)  Perhaps
I could extend the comment to say that conflicted directories, i.e.
paths that are unclean with ci->filemask == 0 can be skipped because
they were already handled.

> > +static void write_completed_directories(struct merge_options *opt,
> > +                                     const char *new_directory_name,
> > +                                     struct directory_versions *info)
> > +{
> > +     const char *prev_dir;
> > +     struct merged_info *dir_info = NULL;
> > +     unsigned int offset;
> > +     int wrote_a_new_tree = 0;
> > +
> > +     if (new_directory_name == info->last_directory)
> > +             return;
>
> Pointer equality is OK here presumably because of the string interning
> of directory names.

Yes, precisely.

> I'm starting to think that it might be too difficult to keep track of
> where strings are interned. Maybe there should be a data structure
> containing all interned strings, and make the path a struct or something
> like that (to clearly indicate that the string inside comes from the
> interned string data structure).

Good news: Interned strings already are stored as the keys of our
primary data structure -- the strmap known as opt->priv->paths.  All
relative paths from the root of the repository that are relevant to
the merge at all -- both for files and directories -- are interned by
collect_merge_info() inside that "paths" strmap.

I guess I should note that it eventually gets _slightly_ more
complicated.  Due to renames and directory renames, I might need to
remove a path from opt->priv->paths.  In such a case there will be an
auxiliary string_list named "paths_to_free" that stores the interned
strings which are no longer part of opt->priv->paths.

> > +     /*
> > +      * If we are just starting (last_directory is NULL), or last_directory
> > +      * is a prefix of the current directory, then we can just update
> > +      * last_directory and record the offset where we started this directory.
> > +      */
> > +     if (info->last_directory == NULL ||
> > +         !strncmp(new_directory_name, info->last_directory,
> > +                  info->last_directory_len)) {
>
> Git has starts_with() for prefix checking. (May not be as optimized as
> this one, though.)
>
> > +             uintptr_t offset = info->versions.nr;
> > +
> > +             info->last_directory = new_directory_name;
> > +             info->last_directory_len = strlen(info->last_directory);
> > +             string_list_append(&info->offsets,
> > +                                info->last_directory)->util = (void*)offset;
> > +             return;
> > +     }
>
> Due to the way this is sorted, there might be a jump of 2 or more
> directories. (The commit message also provides such an example - from ""
> to "src/moduleB", without going through "src".)
>
> > +     /*
> > +      * At this point, ne (next entry) is within a different directory
> > +      * than the last entry, so we need to create a tree object for all
> > +      * the entries in info->versions that are under info->last_directory.
> > +      */
>
> There's no "ne" below.

Oops, that code has been heavily refactored since that comment.
Something like this would be more up-to-date:
    /*
     * The next entry will be within new_directory_name.  Since at this
     * point we know that new_directory_name is within a different
     * directory than info->last_directory, we have all entries for
     * info->last_directory in info->versions and we need to create a
     * tree object for them.
     */

> > +     dir_info = strmap_get(&opt->priv->paths, info->last_directory);
> > +     assert(dir_info);
> > +     offset = (uintptr_t)info->offsets.items[info->offsets.nr-1].util;
> > +     if (offset == info->versions.nr) {
> > +             dir_info->is_null = 1;
> > +     } else {
> > +             dir_info->result.mode = S_IFDIR;
> > +             write_tree(&dir_info->result.oid, &info->versions, offset);
> > +             wrote_a_new_tree = 1;
> > +     }
>
> I was trying to figure out the cases in which offset would be
> info->versions.nr - if such a case existed, and if yes, would it be
> incorrect to skip creating such a tree because presumably this offset
> exists in info->offsets for a reason. Do you know in which situation
> offset would equal info->versions.nr?

Yes, it is possible that all files within the directory become empty
as a result of merging[1], and in such cases this line of logic will
trigger (note that record_entry_for_tree(), which is what adds more
items to info->versions, returns early if ci->merged.is_null).  We do
not want to write out an empty tree for the directory or record the
tree's hash for its parent directory, we simply want to omit it
entirely.  Omitting it entirely is handled by the line
"dir_info->is_null = 1".

[1] The simplest example is when one side doesn't touch anything
within a directory but the other side deletes the whole directory.
Files can also disappear in a merge for other reasons, such as being
deleted on both sides, or being renamed.  If _all_ files within the
directory are removed by the merge logic, the directory has no
entries.

>
> > +     /*
> > +      * We've now used several entries from info->versions and one entry
> > +      * from info->offsets, so we get rid of those values.
> > +      */
> > +     info->offsets.nr--;
> > +     info->versions.nr = offset;
>
> OK.
>
> > +     /*
> > +      * Now we've got an OID for last_directory in dir_info.  We need to
> > +      * add it to info->versions for it to be part of the computation of
> > +      * its parent directories' OID.  But first, we have to find out what
> > +      * its' parent name was and whether that matches the previous
> > +      * info->offsets or we need to set up a new one.
> > +      */
> > +     prev_dir = info->offsets.nr == 0 ? NULL :
> > +                info->offsets.items[info->offsets.nr-1].string;
> > +     if (new_directory_name != prev_dir) {
> > +             uintptr_t c = info->versions.nr;
> > +             string_list_append(&info->offsets,
> > +                                new_directory_name)->util = (void*)c;
> > +     }
>
> Because of the possible jump of 2 or more directories that I mentioned
> earlier, there may be gaps in the offsets. So it makes sense that we
> sometimes need to insert an intermediate one.
>
> I wonder if the code would be clearer if we had explicit "begin tree"
> and "end tree" steps just like in list-objects-filter.c (LOFS_BEGIN_TREE
> and LOFS_END_TREE). Here we have "end tree" (because of the way the
> entries were sorted) but not "begin tree". If we had "begin tree", we
> probably would be able to create the necessary offsets in a loop at that
> stage, and the reasoning about the contents of the offsets would not be
> so complicated.
>
> If we really only want one side (i.e. you don't want to introduce a
> synthetic entry just to mark the end or the beginning), then my personal
> experience is that having the "begin" side is easier to understand, as
> the state is more natural and easier to reason about. (Unlike here,
> where there could be gaps in the offsets and the reader has to
> understand that the gaps will be filled just in time.) But that may just
> be my own experience.

Interesting, I'll take a look into it.

>
> > +     /*
> > +      * Okay, finally record OID for last_directory in info->versions,
> > +      * and update last_directory.
> > +      */
> > +     if (wrote_a_new_tree) {
> > +             const char *dir_name = strrchr(info->last_directory, '/');
> > +             dir_name = dir_name ? dir_name+1 : info->last_directory;
> > +             string_list_append(&info->versions, dir_name)->util = dir_info;
> > +     }
> > +     info->last_directory = new_directory_name;
> > +     info->last_directory_len = strlen(info->last_directory);
> > +}
>
> OK - several entries in info->versions were deleted earlier (through
> info->versions.nr = offset), and we add one here to represent the tree
> containing all those deleted versions.
>
> > @@ -541,22 +635,27 @@ static void process_entries(struct merge_options *opt,
> >                */
> >               struct conflict_info *ci = entry->util;
> >
> > +             write_completed_directories(opt, ci->merged.directory_name,
> > +                                         &dir_metadata);
> >               if (ci->merged.clean)
> >                       record_entry_for_tree(&dir_metadata, path, ci);
> >               else
> >                       process_entry(opt, path, ci, &dir_metadata);
> >       }
>
> Trying to make sense of this: we pass in the directory name of the
> current entry so that if the last directory is *not* a prefix of the
> current directory (so we either went up a directory or went sideways),
> then we write a tree (unless offset == info->versions.nr, which as I
> stated above, I still don't fully understand - I thought we would always
> have to write a tree). So maybe the name of the function should be
> "write_completed_directory" (and document it as "write a tree if
> ???"), since we write at most one.

Yeah, write_completed_directory() would be better.  And just to
reiterate on the offset == info->versions.nr thing, we do not want to
write a tree if it turns out that the merged result of all files
within the directory is to delete them all.

> In this kind of algorithm (where intermediate accumulated results are
> being written), there needs to be a last write after the loop that
> writes whatever's left in the accumulation buffer. I do see it below
> ("write_tree"), so that's good.
>
> > -     /*
> > -      * TODO: We can't actually write a tree yet, because dir_metadata just
> > -      * contains all basenames of all files throughout the tree with their
> > -      * mode and hash.  Not only is that a nonsensical tree, it will have
> > -      * lots of duplicates for paths such as "Makefile" or ".gitignore".
> > -      */
> > -     die("Not yet implemented; need to process subtrees separately");
> > +     if (dir_metadata.offsets.nr != 1 ||
> > +         (uintptr_t)dir_metadata.offsets.items[0].util != 0) {
> > +             printf("dir_metadata.offsets.nr = %d (should be 1)\n",
> > +                    dir_metadata.offsets.nr);
> > +             printf("dir_metadata.offsets.items[0].util = %u (should be 0)\n",
> > +                    (unsigned)(uintptr_t)dir_metadata.offsets.items[0].util);
> > +             fflush(stdout);
> > +             BUG("dir_metadata accounting completely off; shouldn't happen");
> > +     }
>
> Sanity check, OK.
>
> [snip rest]
>
> In summary, I think that the code would be easier to understand (for
> everyone) if there were both BEGIN_TREE and END_TREE entries. And for me
> personally, once the offset == info->versions.nr part is clarified
> (perhaps there is something obvious that I'm missing).

I'm not sure how the BEGIN_TREE/END_TREE entries would look, but I'll
investigate.

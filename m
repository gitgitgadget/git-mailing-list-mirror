Return-Path: <SRS0=euRE=EN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1BAC2D0A3
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 00:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9715020728
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 00:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qo7f6Ib5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgKGA1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 19:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgKGA1G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 19:27:06 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2BAC0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 16:27:06 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id u127so3317207oib.6
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 16:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JLOMGgiMxnOOOtt7mYdeaDDYHBflCz6bA3jlBt1IM/Y=;
        b=qo7f6Ib5o3vM4QMiuo45TJidZyiLJEy6igyg07Nwg0Qq+wsgXJbM29dG6DULYLoEdO
         k6CpV9k5kWWkQ+Pb1M9GNxjeIIr3A2jrkTjJ0c4q5OfRZcGEGtF3qminrPOIKFXUF0x8
         RLqiVq77U9yK1MmckAO7yR5NIxU+5QwgEMxNeuyzZCsLtDWXuGSH+MfhFZqwwY0bip9/
         9eTKpv+4wn0vPwUEAJcFO2BlmM/JnJoHyPo8ndehDBgN51hxDpYu71lWLHjSd4hWEdUS
         TCjBQ0kT+HPn/9QJGUwBpBe+YFWiWAcDjtPlBDAsayT4mY3yGr9+6IHVN/T85TfEBN+D
         uG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JLOMGgiMxnOOOtt7mYdeaDDYHBflCz6bA3jlBt1IM/Y=;
        b=tTUwxmXGJgCbaOi1kfn4g6bP3BlVQYE/AJ/MGJ/RDTkuMyHy1oFwNPejm2EQK01gX2
         sBfdLaVAruRbePjQ3hz9i7HjCx8T4Ho8OYM73iq9xuDiJhyIY9v0mryfk0xUlYfQ91kB
         EFPbHQ8Bn87hbGAhECmGFkSIyU7xSaPVolgBJFD0lLllAdhAvSdhu9bbE52DYJVQ79Vk
         vxY9xQsvoqBNkULODxH0rHWxs2Z8NTDdzgwx+7/GBq83Vx+z2u9UfnNUZy2Rt7pilmYD
         hje5t2/1w3GwicYGOjEhSf/qPBRjK5WTKY1BdWcI1WCJgI3CjiDKROjjTApmiWfXYJhW
         Lagw==
X-Gm-Message-State: AOAM532IEMhDJi/bhltzZmyLGUGEQezjwffd23Qc08db35jIZomXMNRZ
        M/Ho308T8fuztEYvrtyVtRd7VrPiQOIHvUEDBP8=
X-Google-Smtp-Source: ABdhPJwU7TRuLFYJtqk91WQXunZQXakaBdeY+jiUVSItx2ljxmd8F5nKF1P0A9K/jQn04HuN1W5oYj0cpiR/8d6sUlw=
X-Received: by 2002:aca:3756:: with SMTP id e83mr2614296oia.31.1604708825818;
 Fri, 06 Nov 2020 16:27:05 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-10-newren@gmail.com> <20201106225828.774616-1-jonathantanmy@google.com>
In-Reply-To: <20201106225828.774616-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 6 Nov 2020 16:26:54 -0800
Message-ID: <CABPp-BEyosjCpBr-8B19YXZV0mpn3oYAXoaaROKFNZQ+p4ZMnQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/20] merge-ort: record stage and auxiliary info for
 every path
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 6, 2020 at 2:58 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > +static void setup_path_info(struct merge_options *opt,
> > +                         struct string_list_item *result,
> > +                         const char *current_dir_name,
> > +                         int current_dir_name_len,
> > +                         char *fullpath, /* we'll take over ownership */
> > +                         struct name_entry *names,
> > +                         struct name_entry *merged_version,
> > +                         unsigned is_null,     /* boolean */
> > +                         unsigned df_conflict, /* boolean */
>
> Booleans could be int, I think?

I guess this goes back to the question on patch 6 where you suggested
I mark some unsigned variables (derived from bit math on other
unsigned quantities) instead be int.  I guess it could, but I have the
same question; since "boolean" isn't available in C, does int vs.
unsigned matter?

> > +                         unsigned filemask,
> > +                         unsigned dirmask,
> > +                         int resolved          /* boolean */)
> > +{
> > +     struct conflict_info *path_info;
> > +
> > +     assert(!is_null || resolved);
> > +     assert(!df_conflict || !resolved); /* df_conflict implies !resolved */
> > +     assert(resolved == (merged_version != NULL));
> > +
> > +     path_info = xcalloc(1, resolved ? sizeof(struct merged_info) :
> > +                                       sizeof(struct conflict_info));
> > +     path_info->merged.directory_name = current_dir_name;
> > +     path_info->merged.basename_offset = current_dir_name_len;
> > +     path_info->merged.clean = !!resolved;
> > +     if (resolved) {
> > +             path_info->merged.result.mode = merged_version->mode;
> > +             oidcpy(&path_info->merged.result.oid, &merged_version->oid);
> > +             path_info->merged.is_null = !!is_null;
> > +     } else {
> > +             int i;
> > +
> > +             for (i = 0; i < 3; i++) {
> > +                     path_info->pathnames[i] = fullpath;
> > +                     path_info->stages[i].mode = names[i].mode;
> > +                     oidcpy(&path_info->stages[i].oid, &names[i].oid);
> > +             }
> > +             path_info->filemask = filemask;
> > +             path_info->dirmask = dirmask;
> > +             path_info->df_conflict = !!df_conflict;
> > +     }
> > +     strmap_put(&opt->priv->paths, fullpath, path_info);
>
> So these are placed in paths but not unmerged. I'm starting to wonder if
> struct merge_options_internal should be called merge_options_state or
> something, and each field having documentation about when they're used
> (or better yet, have functions like collect_merge_info() return their
> calculations in return values (which may be "out" parameters) instead of
> in this struct).

Right, unmerged is only those paths that remain unmerged after all
steps.  record_unmerged_index_entries() could simply walk over all
entries in paths and pick out the ones that were unmerged, but
process_entries() has to walk over all paths, determine whether they
can be merged, and determine what to record for the resulting tree for
each path.  So, having it stash away the unmerged stuff is a simple
optimization.

Renaming to merge_options_state or even just merge_state would be fine
-- but any renaming done here will also affect merge-recursive.[ch].
See the definition of merge_options in merge-recursive.  (For history,
merge-recursive.h stuffed state into merge_options, which risked funny
misusage patterns and made the API unnecessarily complex...and made it
suggest that alternative algorithms needed to have the same state.
So, the state was moved to a merge_options_internal struct.  That's
not to say we can't rename, but it does need to be done in
merge-recursive as well.)

As for having collect_merge_info() return their calculations in return
values, would that just end with me returning a struct
merge_options_internal?  Or did you want each return value added to
the function signature?  Each return value in the function signature
makes sense right now for this super-simplified initial 20 patches,
but what about when this data structure gains all kind of
rename-related state that is collected, updated, and passed between
these areas?  I'd have a huge number of "out" and "in" fields to every
function.  Eventually, merge_options_internal (or whatever it might be
renamed to) expands to the following, where I have to first define an
extra enum and two extra structs so that you know the definitions of
new types that show up in merge_options_internal:

enum relevance {
    RELEVANT_NO_MORE = 0,
    RELEVANT_CONTENT = 1,
    RELEVANT_LOCATION = 2,
    RELEVANT_BOTH = 3
};

struct traversal_callback_data {
    unsigned long mask;
    unsigned long dirmask;
    struct name_entry names[3];
};

struct rename_info {
    /* For the next six vars, the 0th entry is ignored and unused */
    struct diff_queue_struct pairs[3]; /* input to & output from
diffcore_rename */
    struct strintmap relevant_sources[3];  /* filepath => enum relevance */
    struct strintmap dirs_removed[3];      /* directory => bool */
    struct strmap dir_rename_count[3];     /* old_dir => {new_dir => int} */
    struct strintmap possible_trivial_merges[3]; /* dirname->dir_rename_mask */
    struct strset target_dirs[3];             /* set of directory paths */
    unsigned trivial_merges_okay[3];          /* 0 = no, 1 = maybe */
    /*
     * dir_rename_mask:
     *   0: optimization removing unmodified potential rename source okay
     *   2 or 4: optimization okay, but must check for files added to dir
     *   7: optimization forbidden; need rename source in case of dir rename
     */
    unsigned dir_rename_mask:3;

    /*
     * dir_rename_mask needs to be coupled with a traversal through trees
     * that iterates over all files in a given tree before all immediate
     * subdirectories within that tree.  Since traverse_trees() doesn't do
     * that naturally, we have a traverse_trees_wrapper() that stores any
     * immediate subdirectories while traversing files, then traverses the
     * immediate subdirectories later.
     */
    struct traversal_callback_data *callback_data;
    int callback_data_nr, callback_data_alloc;
    char *callback_data_traverse_path;

    /*
     * When doing repeated merges, we can re-use renaming information from
     * previous merges under special circumstances;
     */
    struct tree *merge_trees[3];
    int cached_pairs_valid_side;
    struct strmap cached_pairs[3];   /* fullnames -> {rename_path or NULL} */
    struct strset cached_irrelevant[3]; /* fullnames */
    struct strset cached_target_names[3]; /* set of target fullnames */
    /*
     * And sometimes it pays to detect renames, and then restart the merge
     * with the renames cached so that we can do trivial tree merging.
     * Values: 0 = don't bother, 1 = let's do it, 2 = we already did it.
     */
    unsigned redo_after_renames;
};

struct merge_options_internal {
    struct strmap paths;    /* maps path -> (merged|conflict)_info */
    struct strmap unmerged; /* maps path -> conflict_info */
#if USE_MEMORY_POOL
    struct mem_pool pool;
#else
    struct string_list paths_to_free; /* list of strings to free */
#endif
    struct rename_info *renames;
    struct index_state attr_index; /* renormalization weirdly needs one... */
    struct strmap output;  /* maps path -> conflict messages */
    const char *current_dir_name;
    char *toplevel_dir; /* see merge_info.directory_name comment */
    int call_depth;
    int needed_rename_limit;
};


> > +     result->string = fullpath;
> > +     result->util = path_info;
> > +}
> > +
> >  static int collect_merge_info_callback(int n,
> >                                      unsigned long mask,
> >                                      unsigned long dirmask,
> > @@ -91,10 +136,12 @@ static int collect_merge_info_callback(int n,
> >        */
> >       struct merge_options *opt = info->data;
> >       struct merge_options_internal *opti = opt->priv;
> > -     struct conflict_info *ci;
> > +     struct string_list_item pi;  /* Path Info */
> > +     struct conflict_info *ci; /* pi.util when there's a conflict */
>
> Looking ahead to patch 10, this seems more like "pi.util unless we know
> for sure that there's no conflict".

That's too long for the line to remain at 80 characters; it's 16
characters over the limit.  ;-)

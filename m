Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99F0C2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 22:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761AE2087E
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 22:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in8bZHg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgKFWpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 17:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbgKFWpO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 17:45:14 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69829C0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 14:45:14 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id y22so2778241oti.10
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 14:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TjZv+gOUkOZkjprOnEwlGJr6yPSiCGLv+VIuCVpxJrM=;
        b=in8bZHg2GtSBR3iT97Twd4hZXeIbiI914J0R8WDbREtgvFv3Iwc2do8qMfgYK9+gen
         hXI/h9oVaFfEd+oUwjDVwYj98lkM/p4EgBQclyZOkm9Hi0ZT3VwPEbAVQjwOPpFGDuiS
         HvuoYrWj0qN5E7BAiitLra0YQY3U9g+wTBf5CbPRDqm+554DUJCr2xG+1Ys8eHXHKQCQ
         TvogvNcKi99z99oWS6cHHrxjQjcFL2NrwcQ2dfkw4J9D5lN+GaJeUo2+5zYYl5/DFV9f
         Dv+qQ0G/ILbjU1FwqRrWMyBz5Jw8YBVLcT17U4r2z21cDtsPTrSLWo+EnIAUWuENr1Lb
         zOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TjZv+gOUkOZkjprOnEwlGJr6yPSiCGLv+VIuCVpxJrM=;
        b=p/JZEQiNx5R5VVW5jMDzJyuTZSE/X0kJQkgAQk6V7SGxvXvzY1Vz0HSb521T9HbjZZ
         KoWgmqfRZ4qZprzCRtkTnu3wZDE8zPgm8Vtd2qWqLLI8MIoJDARMtDRFMPft9H+AvcyD
         ZoNqPdXay/VjgEhJ4HzodiGwNyM2OUOi6zgCDM94wtC9Yfx8DVZ+I6WGnOVYhT3IP3fX
         WXxsvyRv6/bzVTSe3AOm416LxilVaRGPIyaTzlibc+p0AYgXXeK1oynJn00OpNkFWDJd
         6bD3Pow7C6KRT4iYL+0/FNYhXMvv6h6/TPWFX2cIzVmaa3O6a/Ivo3GX7emKymxyQ97f
         GuvA==
X-Gm-Message-State: AOAM533OLIjWqF2xSQvBzpbzjbsn5n6FAIkkK11a2BDtwPaiCu+tsXJK
        LudDFxtdXK0zLoMa02T2LsshWf6mwYi4fAFDXW9WLMq22Ik=
X-Google-Smtp-Source: ABdhPJxKrz5PBu2baGwdAOD33Hd41vfS3SrvrljN8yF/9+9Tu1ulQWZTsMwsyOZQNjNCwlcG420faW9r5HbN2jY5sKs=
X-Received: by 2002:a05:6830:12c2:: with SMTP id a2mr2643342otq.162.1604702713641;
 Fri, 06 Nov 2020 14:45:13 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-2-newren@gmail.com> <20201106220521.757698-1-jonathantanmy@google.com>
In-Reply-To: <20201106220521.757698-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 6 Nov 2020 14:45:02 -0800
Message-ID: <CABPp-BHx4w1_JAen0fupCzosu0NfoTsT9d8dEve7n5VJZ0EvBQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] merge-ort: setup basic internal data structures
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 6, 2020 at 2:05 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> I'm not very familiar with the merge machinery, but I'll attempt a
> review of at least the first 10 patches.

Thanks for taking a look!

> > merged_info contains all relevant information for a non-conflicted
> > entry.  conflict_info contains a merged_info, plus any additional
> > information about a conflict such as the higher orders stages involved
> > and the names of the paths those came from (handy once renames get
> > involved).  If an entry remains conflicted, the merged_info portion of a
> > conflict_info will later be filled with whatever version of the file
> > should be placed in the working directory (e.g. an as-merged-as-possible
> > variation that contains conflict markers).
>
> I think that this information should be in the .c file.

Okay.

> > diff --git a/merge-ort.c b/merge-ort.c
> > index b487901d3e..9d5ea0930d 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -17,6 +17,46 @@
> >  #include "cache.h"
> >  #include "merge-ort.h"
> >
> > +#include "strmap.h"
> > +
> > +struct merge_options_internal {
> > +     struct strmap paths;    /* maps path -> (merged|conflict)_info */
> > +     struct strmap unmerged; /* maps path -> conflict_info */
> > +     const char *current_dir_name;
> > +     int call_depth;
> > +};
>
> Maybe document if the path is from the root of the directory or just the
> filename as it appears in a tree object?

Yeah, full relative path from toplevel.  I'll try to add some
documentation to that effect.

> I would have expected "unmerged" to be a "strset", but I guess it's more
> convenient for it to be a map itself. Maybe just document it as "all
> mappings in paths wherein the value is a struct conflict_info".

Makes sense.  And yeah, it's not a strset just because of the simple
optimization to avoid needing to do another lookup in paths afterwards
to get the actual conflict_info; the only time it is used is as a loop
over the still-unmerged entries to try to three-way merge them and
such.

> There seems to be 2 ways of referring to something that we couldn't
> merge - "conflicted" (or "having a conflict") and "unmerged". Should we
> stick to one of them?

Uhm...perhaps, but it feels like I'm going to miss some while looking
over it.  Also, there are some semantic differences at play.  Since
the whole algorithm is divided around multiple stages --
collect_merge_info(), detect_and_process_renames(), process_entries(),
as of a given early stage we might just know that we couldn't merge it
*yet*.  For example, both sides modified the entry, or one side
modified and the other side is missing ("did they delete it or rename
it?").  After rename detection and three-way content merge, something
that had not been automatically mergeable as of an earlier step might
end up being so.  But we need names for stuff in the interim state.
But it's also possible for us to know at an early state that thing are
definitely going to be a conflict regardless of what later stages do
(e.g. both sides rename a path, but rename it differently).

> Also, looking ahead, I see that current_dir_name is used as a temporary
> variable in the recursive calls to collect_merge_info_callback(). I
> would prefer if current_dir_name went in the cbdata to that function
> instead, but if that's not possible, maybe document here that
> current_dir_name is only used in collect_merge_info_callback(), and
> temporarily at that.

Yeah, not possible.  collect_merge_info_callback() has to be of
traverse_callback_t type (from tree-walk.h), which provides no extra
parameters for extra callback data.  I can add a documentation
comment.

> > +struct version_info {
> > +     struct object_id oid;
> > +     unsigned short mode;
> > +};
>
> OK.
>
> > +struct merged_info {
> > +     struct version_info result;
> > +     unsigned is_null:1;
> > +     unsigned clean:1;
> > +     size_t basename_offset;
> > +      /*
> > +       * Containing directory name.  Note that we assume directory_name is
> > +       * constructed such that
> > +       *    strcmp(dir1_name, dir2_name) == 0 iff dir1_name == dir2_name,
> > +       * i.e. string equality is equivalent to pointer equality.  For this
> > +       * to hold, we have to be careful setting directory_name.
> > +       */
> > +     const char *directory_name;
> > +};
>
> I'm not sure how most of the fields in this struct are to be used, but
> perhaps that will be clearer once I read the subsequent code.
>
> > +struct conflict_info {
> > +     struct merged_info merged;
> > +     struct version_info stages[3];
> > +     const char *pathnames[3];
>
> Why would these be different across stages? (Rename detection?)

Yes, as noted in the portion of the commit message that you said you
wanted in the .c file.

>
> > +     unsigned df_conflict:1;
>
> OK.
>
> > +     unsigned path_conflict:1;
>
> This doesn't seem to be assigned anywhere in this patch set?

Oh, right, I could drop it for now and add it back later when it is
used.  It's basically non-content conflict other than the specialized
D/F conflict.  So, things like rename/delete, moved by directory
rename, rename/rename(1to2), and rename/add/delete.  I could have
potentially lumped it in with df_conflict or made df_conflict a
subset, but df_conflict is different enough from the others that it
got a special flag.

But yeah, since it's all rename-related stuff and this patchset
doesn't have any rename handling yet, I probably should have left it
out until I added that stuff later.

> > +     unsigned filemask:3;
> > +     unsigned dirmask:3;
>
> I wonder if this needs to be documented that the least significant bit
> corresponds to stages[0], and so forth.

Maybe I should just put a comment to look at tree-walk.h?  The struct
traverse_info has a "fn" member with a big comment above it describing
mask & dirmask; filemask is just mask & ~dirmask.

> > +     unsigned match_mask:3;
>
> I think this can be derived by just looking at the stages array? Maybe
> document as:
>
>   Optimization to track which stages match. Either 0 or at least 2 bits
>   are set; if at least 2 bits are set, their corresponding stages match.

Yep, I only wanted to compute the match_mask once (I always got
annoyed in merge-recursive.c that we were re-comparing what had
already been compared and computed within unpack_trees()).  I like
your suggested comment; will add it.

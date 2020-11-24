Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4E2C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 20:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 585EC206F7
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 20:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmkIEdPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbgKXUTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 15:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730773AbgKXUTr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 15:19:47 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4FBC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 12:19:47 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id o3so44693ota.8
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 12:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EGZ8JXXfK1Nv9a12ZCxOXO9K/uuoZ2cgvRcRfJwY60A=;
        b=KmkIEdPXr/Jq5ZoBloUcaj6i5x0wdCQyEFn11pFooBx0W0TWaNm4H2aYcSUjtXS9ap
         ldZVHMlvsLu3RrQW9G3ls2RFSszAHlm8ctRzxpPHpbQudBstTx7rnhheYh17at9Nqjvo
         gCiySKtsTMjt2FPnkXz1hu3P42swiv+s3WVZwsAQDB/f5QsOwiherZRWailNnwOEgEYp
         fN/k1P/lTEIXBCVOKztMTZjTIuEfjZR6ekgLKFqXwairJKYGpcaV3REof/tsh+pBszJC
         MgEvCVfkdrDhuBdL/qJQ8HxkFKq3hY/TvTXEKT7Ua7C/nDwB3nfJD2M5zY9vbaNU2Y96
         HTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EGZ8JXXfK1Nv9a12ZCxOXO9K/uuoZ2cgvRcRfJwY60A=;
        b=PYQeAunI/fu3dX8wrZywKBK6wdY/gkyl5oyfSnLRz7B18UmC6OlHFFuWZk67sSaaCh
         /0qqR12bx8P9M6i6loxOCOm8qv9LQ5j0md1t610ga5UX54b0ko2zhDKSOMnL8VDFk+2X
         tRfRV/xvI0BFVgfQXYCn51ZpmLZZ8D8eB9L3sLvU1+kGrRZfrDThi/pnQdNcvoMqKr1A
         z3CIcLXXSRpYHhkYnUXiwaSEsuN9YHgpkNAA5l/aVm1BYfUeKzKggQ/+JLVUxVJnzUie
         p2re1rUcAxOGA0zXyxpfk3SitEaOdVTnFMy6DSPLCdq+UIbD2dKQYIvyPy7GOaHkoUSE
         YjDw==
X-Gm-Message-State: AOAM531F5JYCcl7pKvC6ueUFwfHqxTnQDedOSm5sGX5v0c5+tAqgr/Hh
        18Eti3UUP1tddeltf97DJTAi8oP8l7vzhWVMwG8=
X-Google-Smtp-Source: ABdhPJwLGcIMCE73KYuyvuQn/CWTjww2NiBvKqZE+2MmTT3WObqzzYZ+zv8zVbWSJbK7OSmMsGrW8okWrv6QM3nDziM=
X-Received: by 2002:a05:6830:1002:: with SMTP id a2mr269376otp.316.1606249186339;
 Tue, 24 Nov 2020 12:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-16-newren@gmail.com> <20201112201524.3438029-1-jonathantanmy@google.com>
 <CABPp-BFwn5+S_swrtZEq6DmZx6kbB0xO_d=ZJkqs4H6FG1vo1Q@mail.gmail.com>
In-Reply-To: <CABPp-BFwn5+S_swrtZEq6DmZx6kbB0xO_d=ZJkqs4H6FG1vo1Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 24 Nov 2020 12:19:35 -0800
Message-ID: <CABPp-BHa21aeXwzykyQAtGd3rzOiE++Gozu7umOSYihc_145iA@mail.gmail.com>
Subject: Re: [PATCH v2 15/20] merge-ort: step 3 of tree writing -- handling
 subdirectories as we go
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 12, 2020 at 2:30 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Nov 12, 2020 at 12:15 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> >
> > > +     /*
> > > +      * Now we've got an OID for last_directory in dir_info.  We need to
> > > +      * add it to info->versions for it to be part of the computation of
> > > +      * its parent directories' OID.  But first, we have to find out what
> > > +      * its' parent name was and whether that matches the previous
> > > +      * info->offsets or we need to set up a new one.
> > > +      */
> > > +     prev_dir = info->offsets.nr == 0 ? NULL :
> > > +                info->offsets.items[info->offsets.nr-1].string;
> > > +     if (new_directory_name != prev_dir) {
> > > +             uintptr_t c = info->versions.nr;
> > > +             string_list_append(&info->offsets,
> > > +                                new_directory_name)->util = (void*)c;
> > > +     }
> >
> > Because of the possible jump of 2 or more directories that I mentioned
> > earlier, there may be gaps in the offsets. So it makes sense that we
> > sometimes need to insert an intermediate one.
> >
> > I wonder if the code would be clearer if we had explicit "begin tree"
> > and "end tree" steps just like in list-objects-filter.c (LOFS_BEGIN_TREE
> > and LOFS_END_TREE). Here we have "end tree" (because of the way the
> > entries were sorted) but not "begin tree". If we had "begin tree", we
> > probably would be able to create the necessary offsets in a loop at that
> > stage, and the reasoning about the contents of the offsets would not be
> > so complicated.
> >
> > If we really only want one side (i.e. you don't want to introduce a
> > synthetic entry just to mark the end or the beginning), then my personal
> > experience is that having the "begin" side is easier to understand, as
> > the state is more natural and easier to reason about. (Unlike here,
> > where there could be gaps in the offsets and the reader has to
> > understand that the gaps will be filled just in time.) But that may just
> > be my own experience.
>
> Interesting, I'll take a look into it.
>

So, I've been going through making all the changes you and Derrick
suggested or highlighted...but I don't see how to tackle this one.
Perhaps I'm missing something.

Using your example of LOFS_BEGIN_TREE and LOFS_END_TREE from
list-objects-filter.c, I note that you handle it as part of
traverse_trees(), and thus you have a very natural "I'm going to
process this tree" point and "I'm done processing this tree" point.
There is no equivalent mapping to merge-ort that I can figure out.

merge-ort does use traverse_trees() in collect_merge_info(), and fills
opt->priv->paths with all full pathnames (both files and directories)
found in any of the three trees.  But I cannot process
files/directories at that time; rename detection needs
traverse_trees() to be finished to have all paths so far.  Further,
the list of pathnames from traverse_trees is not necessarily complete;
additional paths could be added by any of
  * Directory/file conflicts (need to move the file to a different location)
  * Directory/submodule conflicts (need to move something to a
different location)
  * Add/add conflicts of files of different types (e.g.
symlink/regular file; can't just content merge them with conflict
markers)
  * Directory rename detection (can move new files or even directories
on one side of history into a new directory on other side)

Thus, after traverse_trees() ends, my rename detection stuff can add
paths (including new directories), then process_entries() can add
paths -- and remove some when the resolution is to delete.  And the
code here in question runs as part of the process_entries() loop.

Now, we'd still be able to create synthetic BEGIN_TREE markers if we
operated in lexicographic ordering, but process_entries() *must*
operate in _reverse_ lexicographic ordering because:
  1) subtrees need to be written out before trees are; hashes of those
subtrees are used in the parent tree
  2) it's the only sane way to handle directory/file conflicts; I need
to know if all entries under the directory resolve to nothing; if not,
the directory is still in the way when it comes time to process the
file.

Granted, I could do some tricky calculations based on the reverse
lexicographic ordering of fullpaths (and their containing directories)
to figure out where trees begin and end -- but that takes us to
exactly what I *did* do.  It was precisely this step that you thought
should be made simpler, but I'm not seeing how to avoid it.

For now, I'll keep the code as-is, but add more comments to both the
data structure and the code.  If I've missed something about how I
could make use of your BEGIN_TREE idea, let me know and I'll look at
it again.

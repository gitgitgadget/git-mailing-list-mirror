Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2F2C2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 23:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD90620867
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 23:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3fw8V0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgKFXl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 18:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgKFXlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 18:41:25 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE88C0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 15:41:25 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id a12so2601743ybg.9
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 15:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9VvUSNXYqCpbrvisZiSr+spIysbk26aOI7wu6H4v5ew=;
        b=C3fw8V0LW1vHzF0VI0rXyOcIlMrlawiCUGnNkltDTAko3sJFBaijxpz6al4VAwY5Zt
         7KMkzYXKurS4GkgDD/2pdbljfKjutiIuylxmnyaC539v0alWhVz3RJsnd6wfJzZbCL2j
         gUPemzO9ZePd3vQLNz8eVITf6JdD0QaqWFwLAEgczF2W4mLr6cacpQLpHSMA0UJpWeUp
         0jqr3gRD25KYoS8Epkix5kS0BPXvAPgvqV1jFyXBeYzR7nSIDgFeGRKgb5ZDrBRASEMc
         CCmgbxrJYceNzZvvTj2n0O0dzkRoahiqHwtgeeLda11YRRZsBkQnXI8i81txmG0Zgbcd
         v1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9VvUSNXYqCpbrvisZiSr+spIysbk26aOI7wu6H4v5ew=;
        b=dIETgILRIoHEIS+phYIJuoQ1ohF57gritcH7zOFOLtReeV5l+ZYE0ao1PMfOBCxc4Q
         9kdAdB4TwpQ8ICznT0c1pmI5RcctpcYPHclI0TPaGuxe8wrp2dwHs/Sl+ew++d/eFAmD
         9nsFi8DMxlYQ+9AI5PL8BtIY1c4aVLav87PwWsqsI1Q8CAlIjIR316QD++TkinzlpPcg
         rUScQ7Urk/nG9v5brAN5ma3CYD3vns8cy7UAmzfFXnmxcfFcNgH2lTNoh4UnK6nVBgoE
         2bq8l6aRRtmuTX3A+jybCiaKpCEdRpkO7lM6Lt/Q/kfmtHpBR0hXaUSbUDdUAj7wpofb
         fi+A==
X-Gm-Message-State: AOAM532Aw8zKY6+lRWUnfQCSm+9BBGyDnYVJ7Ms5yeUszO50BZnCErGM
        9jWCfwRBX5eE5OQ6Drawb4+WdULUpwdU2f7kaAd0wZYrzlkDTA==
X-Google-Smtp-Source: ABdhPJxb1ihkQgpLaNfD+vkv5zJ1DZ3jvYjmOr+54vdD4yzOkEl3lsYVt7BJF/j5CUpHkvFBfuWtwfbDbvp4EOLgOYA=
X-Received: by 2002:a25:cbd0:: with SMTP id b199mr5968657ybg.470.1604706084681;
 Fri, 06 Nov 2020 15:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-9-newren@gmail.com> <20201106225211.772384-1-jonathantanmy@google.com>
In-Reply-To: <20201106225211.772384-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 6 Nov 2020 15:41:12 -0800
Message-ID: <CABPp-BHOvk+W0u_MYWtH8OC-Uh5bEfsRO6QuXZKWfDQ=8fyasA@mail.gmail.com>
Subject: Re: [PATCH v2 08/20] merge-ort: compute a few more useful fields for collect_merge_info
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 6, 2020 at 2:52 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > +     /*
> > +      * Note: We only label files with df_conflict, not directories.
> > +      * Since directories stay where they are, and files move out of the
> > +      * way to make room for a directory, we don't care if there was a
> > +      * directory/file conflict for a parent directory of the current path.
> > +      */
> > +     unsigned df_conflict = (filemask != 0) && (dirmask != 0);
>
> Suppose you have:
>
>  [ours]
>   foo/
>     bar/
>       baz
>     quux
>  [theirs]
>   foo
>
> By "we only label files with df_conflict, not directories", are you
> referring to not labelling "foo/" in [ours], or to "bar/", "baz", and
> "quux" (so, the files and directories within a directory)? At first I
> thought you were referring to the former, but perhaps you are referring
> to the latter.

The former.  I was drawing a distinction between how this code
operates, and how unpack_trees() operates, which probably only matters
to those familiar with unpack_trees() or who have been reading through
it recently.  unpack_trees() will note when there is a directory/file
conflict, and propagates that information to all subtrees, with every
path specially checking for the o->df_conflict_entry and then handling
it specially (e.g. keeping higher order stages instead of using an
aggressive or trivial resolutions).  However, leaving both a file and
a directory at the same path, while allowed in the index, makes for
ugliness and difficulty for users to resolve.   Plus it isn't allowed
in the working tree anyway.  We decided a while ago that it'd be
better to represent these conflicts differently[1], [2].

Also, at the time you are unpacking or traversing trees, you only know
if one side had a directory where the other side had a file.  You
don't know if the final merge result will actually have a
directory/file conflict.  If the file existed in both the base version
and unmodified on one side, for example, then the file will be removed
as part of the merge.  It is similarly possible that the entire
directory of files all need to be deleted or are all renamed
elsewhere.  So, you have to keep track of a df_conflict bit, but you
can't act on it until you've processed several other things first.

Since I already know I'm not going to move a whole directory of files
out of the way so that a file can be placed in the working tree
instead of that whole directory, the directory doesn't need to be
tweaked.  I'm not going to propagate any information about a
directory/file conflict at some path down to all subpaths of the
directory.  I only track it for the file that immediately conflicts,
and then only take action on it after resolving all the paths under
the corresponding directory to see if the directory/file conflict
remains.

[1] https://lore.kernel.org/git/xmqqbmabcuhf.fsf@gitster-ct.c.googlers.com/
and the thread surrounding it
[2] https://lore.kernel.org/git/f27f12e8e50e56c010c29caa00296475d4de205b.1603731704.git.gitgitgadget@gmail.com/,
which is now commit ef52778708 ("merge tests: expect improved
directory/file conflict handling in ort", 2020-10-26)

>
> > @@ -161,6 +179,13 @@ static int collect_merge_info_callback(int n,
> >               newinfo.name = p->path;
> >               newinfo.namelen = p->pathlen;
> >               newinfo.pathlen = st_add3(newinfo.pathlen, p->pathlen, 1);
> > +             /*
> > +              * If we did care about parent directories having a D/F
> > +              * conflict, then we'd include
> > +              *    newinfo.df_conflicts |= (mask & ~dirmask);
> > +              * here.  But we don't.  (See comment near setting of local
> > +              * df_conflict variable near the beginning of this function).
> > +              */
>
> I'm not sure how "mask" and "dirmask" contains information about parent
> directories. "mask" represents the available entries, and "dirmask"
> represents which of them are directories, as far as I know. So we can
> notice when something is missing, but I don't see how this distinguishes
> between the case that something is missing because it was in a parent
> directory that got deleted, vs something is missing because it itself
> got deleted.

Yeah, this is more comparisons to unpack_trees.  This code is about to
set up a recursive call into subdirectories.  newinfo is set based on
the mask and dirmask of the current entry, and then subdirectories can
consult newinfo.df_conflicts to see if that path is within a directory
that was involved in a directory/file conflict.  For example:

Tree in base version:
    foo/
        bar
    stuff.txt
Tree on side 1: (adds foo/baz)
    foo/
        bar
        baz
    stuff.txt
Tree on side 2: (deletes foo/, adds new file foo)
   foo
   stuff.txt

When processing 'foo', we have mask=7, dirmask = 3.  So, here
unpack_trees() would have set newinfo.df_conflicts = (mask & ~dirmask)
= 4.  Then when we process foo/bar or foo/baz, we have mask=2,
dirmask=0, which looks like there are no directory/file conflicts.
However, we can note that these paths are under a directory involved
in a directory/file conflict via info.df_conflicts whose value is 4.
unpack_trees() cared about paths under a directory that was involved
in a directory/file conflict, and someone familiar with that code
might ask why I don't also track the same information.  The answer is
that I don't track it, even though I thought about it, because it's
useless overhead since I'm going to leave the directory alone and move
the file out of the way.

Does that make sense?

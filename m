Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DCDC2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E54D020867
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GiYjGSGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbgKIWEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 17:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730467AbgKIWEf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 17:04:35 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CECC0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 14:04:34 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id a73so7462110pge.15
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 14:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=lqZBvnyQcOeOoExxb2Y/n0EG1TgCpHhi9XaHJkXYVxM=;
        b=GiYjGSGUhIlwxPP1bgY5lQNEWzRP8Y1WLU5VmSqio5Xp2QtKQDE7b7RH1u9hD4KMqK
         ooWCPezyFsWg7+BZB1v6qDnGt1jQGM5/uMFCvk8s0vl9Eu3Xsvz0fdWt9iDNwX2fkn+D
         M9jlResHMdx61/RB/Y2CiDs9rJzT2GpuOFlvfKZLVdjxkwYVkHZ+VOEAjqGHTKyCY686
         7w6IF5EuygTKLpGMZtK3vlxPe3aQeJKAZ71f1tFnQv+XqkaEObHBuf+BgaHvDORMEK+l
         24G6Nh7LJUYbiX7x/S9iAKte//jatsjZ6eSo21SDZS7gRqN9kWjkLJ2+g1XeED9qkLJo
         gB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lqZBvnyQcOeOoExxb2Y/n0EG1TgCpHhi9XaHJkXYVxM=;
        b=QTsTB0QfI8zVUUOGlIHdixqut58QVMPDMHMt0nBrtkar5RiZhIJe1Wf8CbaXveYZ2O
         zU1rcBHgbmWJrD/DKPxJDMZDbwFDs4O1rKUzzUX+rY32inmiapcQByy4XJYIVEJ+18h4
         hI5kYis+MDjZgvxIBa9uIAEVQkgAjYbvJsP1z5YY9GW1DA4q30nFyQ+vSVbqs7F0+KRW
         3IiLFEnOvsRkFp7aw1XP0Nez1dl5Jzd3r1Qqly7feOwd+6QvEcAeRDHVMaqhC2/XfS4J
         T76wBqmkX5nk6kSzEx1hEiHq3SepXiLIMTqdsx36f4AoKv6GZ/QMWrhflFGCMhVyyOZ2
         cR6w==
X-Gm-Message-State: AOAM5336lEDC4txPVHn7dMrL0b0Z7sOdt23LMmzFUsGuejmIWbz+V9d6
        rqZTC+parfAfeOES0IXf8ZNmQi1A/eomtPLM0sWC
X-Google-Smtp-Source: ABdhPJwAamchezi9r7WQZ737SxRb0ZDHQN9IRN0/365YrEfPJ6rn0mlIowznTag1vqjba8uLiR+lQtigAgEl61rOhNeX
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:e944:: with SMTP id
 n4mr16387756qvo.50.1604959473485; Mon, 09 Nov 2020 14:04:33 -0800 (PST)
Date:   Mon,  9 Nov 2020 14:04:31 -0800
In-Reply-To: <CABPp-BHOvk+W0u_MYWtH8OC-Uh5bEfsRO6QuXZKWfDQ=8fyasA@mail.gmail.com>
Message-Id: <20201109220431.2534786-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BHOvk+W0u_MYWtH8OC-Uh5bEfsRO6QuXZKWfDQ=8fyasA@mail.gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: Re: [PATCH v2 08/20] merge-ort: compute a few more useful fields for collect_merge_info
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Fri, Nov 6, 2020 at 2:52 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> >
> > > +     /*
> > > +      * Note: We only label files with df_conflict, not directories.
> > > +      * Since directories stay where they are, and files move out of the
> > > +      * way to make room for a directory, we don't care if there was a
> > > +      * directory/file conflict for a parent directory of the current path.
> > > +      */
> > > +     unsigned df_conflict = (filemask != 0) && (dirmask != 0);
> >
> > Suppose you have:
> >
> >  [ours]
> >   foo/
> >     bar/
> >       baz
> >     quux
> >  [theirs]
> >   foo
> >
> > By "we only label files with df_conflict, not directories", are you
> > referring to not labelling "foo/" in [ours], or to "bar/", "baz", and
> > "quux" (so, the files and directories within a directory)? At first I
> > thought you were referring to the former, but perhaps you are referring
> > to the latter.
> 
> The former.  I was drawing a distinction between how this code
> operates, and how unpack_trees() operates, which probably only matters
> to those familiar with unpack_trees() or who have been reading through
> it recently.

Just for clarification: do you mean "the latter"? (The "not" in my
question might be confusing.)

To be more illustrative in what I meant, at first I thought that you
were NOT labelling "foo/" in [ours], hence:

 [ours]
  foo/  <- unlabeled
 [theirs]
  foo   <- labeled

In this way, in a sense, you are indeed labelling only the file, not the
directory.

But instead what you seem to be doing is this:

 [ours]
  foo/     <- labeled
    bar/   <- unlabeled
      baz  <- unlabeled
    quux   <- unlabeled
 [theirs]
  foo      <- labeled

which is what I meant by NOT labelling "bar/", "baz", and "quux".

> unpack_trees() will note when there is a directory/file
> conflict, and propagates that information to all subtrees, with every
> path specially checking for the o->df_conflict_entry and then handling
> it specially (e.g. keeping higher order stages instead of using an
> aggressive or trivial resolutions).

And here it seems like you're describing that unpack_trees() would label
it in this way:

 [ours]
  foo/     <- labeled
    bar/   <- labeled
      baz  <- labeled
    quux   <- labeled
 [theirs]
  foo      <- labeled

(and you're emphasizing by contrast that merge-ort is NOT doing this).

> However, leaving both a file and
> a directory at the same path, while allowed in the index, makes for
> ugliness and difficulty for users to resolve.   Plus it isn't allowed
> in the working tree anyway.  We decided a while ago that it'd be
> better to represent these conflicts differently[1], [2].
> 
> Also, at the time you are unpacking or traversing trees, you only know
> if one side had a directory where the other side had a file.  You
> don't know if the final merge result will actually have a
> directory/file conflict.  If the file existed in both the base version
> and unmodified on one side, for example, then the file will be removed
> as part of the merge.  It is similarly possible that the entire
> directory of files all need to be deleted or are all renamed
> elsewhere.  So, you have to keep track of a df_conflict bit, but you
> can't act on it until you've processed several other things first.
> 
> Since I already know I'm not going to move a whole directory of files
> out of the way so that a file can be placed in the working tree
> instead of that whole directory, the directory doesn't need to be
> tweaked.  I'm not going to propagate any information about a
> directory/file conflict at some path down to all subpaths of the
> directory.  I only track it for the file that immediately conflicts,
> and then only take action on it after resolving all the paths under
> the corresponding directory to see if the directory/file conflict
> remains.
> 
> [1] https://lore.kernel.org/git/xmqqbmabcuhf.fsf@gitster-ct.c.googlers.com/
> and the thread surrounding it
> [2] https://lore.kernel.org/git/f27f12e8e50e56c010c29caa00296475d4de205b.1603731704.git.gitgitgadget@gmail.com/,
> which is now commit ef52778708 ("merge tests: expect improved
> directory/file conflict handling in ort", 2020-10-26)

Makes sense.

> > > @@ -161,6 +179,13 @@ static int collect_merge_info_callback(int n,
> > >               newinfo.name = p->path;
> > >               newinfo.namelen = p->pathlen;
> > >               newinfo.pathlen = st_add3(newinfo.pathlen, p->pathlen, 1);
> > > +             /*
> > > +              * If we did care about parent directories having a D/F
> > > +              * conflict, then we'd include
> > > +              *    newinfo.df_conflicts |= (mask & ~dirmask);
> > > +              * here.  But we don't.  (See comment near setting of local
> > > +              * df_conflict variable near the beginning of this function).
> > > +              */
> >
> > I'm not sure how "mask" and "dirmask" contains information about parent
> > directories. "mask" represents the available entries, and "dirmask"
> > represents which of them are directories, as far as I know. So we can
> > notice when something is missing, but I don't see how this distinguishes
> > between the case that something is missing because it was in a parent
> > directory that got deleted, vs something is missing because it itself
> > got deleted.
> 
> Yeah, this is more comparisons to unpack_trees.  This code is about to
> set up a recursive call into subdirectories.  newinfo is set based on
> the mask and dirmask of the current entry, and then subdirectories can
> consult newinfo.df_conflicts to see if that path is within a directory
> that was involved in a directory/file conflict.  For example:
> 
> Tree in base version:
>     foo/
>         bar
>     stuff.txt
> Tree on side 1: (adds foo/baz)
>     foo/
>         bar
>         baz
>     stuff.txt
> Tree on side 2: (deletes foo/, adds new file foo)
>    foo
>    stuff.txt
> 
> When processing 'foo', we have mask=7, dirmask = 3.  So, here
> unpack_trees() would have set newinfo.df_conflicts = (mask & ~dirmask)
> = 4.  Then when we process foo/bar or foo/baz, we have mask=2,
> dirmask=0, which looks like there are no directory/file conflicts.
> However, we can note that these paths are under a directory involved
> in a directory/file conflict via info.df_conflicts whose value is 4.
> unpack_trees() cared about paths under a directory that was involved
> in a directory/file conflict, and someone familiar with that code
> might ask why I don't also track the same information.  The answer is
> that I don't track it, even though I thought about it, because it's
> useless overhead since I'm going to leave the directory alone and move
> the file out of the way.
> 
> Does that make sense?

Ah...yes, that makes sense. I think I didn't notice the "newinfo", so I
didn't realize that we were setting the info of our children based on
ourselves. Perhaps I would have noticed it sooner if the comment had
read "If this file/directory cared about its parent directory (the
current directory) having a D/F conflict, then we'd propagate the masks
in this way:" instead of "If we did care about parent directories having
a D/F conflict", but perhaps the point is already obvious enough.

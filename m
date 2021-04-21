Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3763AC433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 16:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D2A6144B
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 16:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbhDUQMX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 12:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbhDUQMW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 12:12:22 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CD8C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 09:11:49 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 35-20020a9d05260000b029029c82502d7bso7991507otw.2
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 09:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Ut/W+ESRV6zGswezTp49jK6mMSlLv8np7t7xkfBRBM=;
        b=PZPC9LoZ4brMe5+ANfEoZ8BvdirWuTOTyE39DQCRulaaVhGIJpg1BnH3kl3R6yDk+G
         3N4uXTIOsa5xEc4sQaf8S10V+fBZdlTaFucxR+xp2X3Kh8R+YvoivNcHK2SWlhkunD7N
         v1vmG9klliTZrkh9H0DEkK1paQgEXVcITfN0RHdm42EkBOU2gXSI4+suv+LWUEtx4Mbc
         bdEMup3s2Pcjm7/Vyy9w+TH+tGIHFv47a5bPUlldvGL0quyP7KyYUkc9KZgR2IzSBIMB
         e//JkKRmkYGV9JY2PbAsw/8bBKBFg1J+KQWh4JqMXk9vltM1/oOdlf3eCqgrc2AaRkL1
         /5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Ut/W+ESRV6zGswezTp49jK6mMSlLv8np7t7xkfBRBM=;
        b=jBzyZ1j9CQ5JxSg+YvXdja1TZApReMqcVX3xju2jThW/zrayESyQ8rru6fpEjgEPsF
         pXBhXEchebaQ88W/mJ6bLA5blXgOQQv6f0aMY4Bf4+EXoShjL179jeD9itwRbguRdfzq
         /YoKSUGmIhL1v9kmEioF4EOvq/dsAJwmgytjuRpiLLClwA9AYQyhDFAhkRSCVwZrgy0I
         OrqJu2uTuj8MQmV/l/hRpaWodd3Q2rCBqyJ0Y96SFIDRyb0tbGyuvWewUb2s4RPHbh3t
         Wv+SImOZ5Mzzcj/1H+cvyk+vlslw7xw5DUe3praQCXUytZbBXdNyMwDoQOCBBdwZJAmD
         pGwg==
X-Gm-Message-State: AOAM530Jzk+EDPwIciRxxcE5yAMkLiifJ7uU7+g0FkdGvRWF5zn/yFry
        27lGACyJUbA8oQ4sOwDD9noYNVQXYgdGNe+7ukM=
X-Google-Smtp-Source: ABdhPJxj6KpPb/yeLarCErn1zjnBprj0VBr1S7sn/PerRy/sQVo/8En7qAaJg84ko6yH8sLOG88xsBtzSHP/oNPvNgE=
X-Received: by 2002:a9d:8a6:: with SMTP id 35mr23603606otf.316.1619021508656;
 Wed, 21 Apr 2021 09:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
 <0a3892d2ec9e4acd4cba1c1d0390acc60dc6e50f.1618322497.git.gitgitgadget@gmail.com>
 <CABPp-BHcdhO_kEdqR23sDdGAgoSu2R-HBWv-RmzQvJ0ysWtzxg@mail.gmail.com> <a777331a-aff6-766f-30da-eef052ad83ee@gmail.com>
In-Reply-To: <a777331a-aff6-766f-30da-eef052ad83ee@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Apr 2021 09:11:37 -0700
Message-ID: <CABPp-BEdXOrDecGZBxmwdMvLBse80s3J+O34Bwz5dRRvFPgnUA@mail.gmail.com>
Subject: Re: [PATCH 02/10] unpack-trees: make sparse aware
To:     Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

// Adding Matheus to cc due to the ignore_skip_worktree bit, given his
experience and expertise with the checkout and unpack-trees code.

On Wed, Apr 21, 2021 at 6:41 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 4/20/2021 7:00 PM, Elijah Newren wrote:
> > On Tue, Apr 13, 2021 at 7:01 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >> diff --git a/dir.h b/dir.h
> >> index 51cb0e217247..9d6666f520f3 100644
> >> --- a/dir.h
> >> +++ b/dir.h
> >> @@ -503,7 +503,7 @@ static inline int ce_path_match(struct index_state *istate,
> >>                                 char *seen)
> >>  {
> >>         return match_pathspec(istate, pathspec, ce->name, ce_namelen(ce), 0, seen,
> >> -                             S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));
> >> +                             S_ISSPARSEDIR(ce->ce_mode) || S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));
> >
> > I'm confused why this change would be needed, or why it'd semantically
> > be meaningful here either.  Doesn't S_ISSPARSEDIR() being true imply
> > S_ISDIR() is true (and perhaps even vice versa?).
> >
> > By chance, was this a leftover from your early RFC changes from a few
> > series ago when you had an entirely different mode for sparse
> > directory entries?
>
> I will double-check on this with additional testing and debugging.
> Your comments below make it clear that this patch would benefit from
> some additional splitting.
>
> >>  }
> >>
> >>  static inline int dir_path_match(struct index_state *istate,
> >> diff --git a/preload-index.c b/preload-index.c
> >> index e5529a586366..35e67057ca9b 100644
> >> --- a/preload-index.c
> >> +++ b/preload-index.c
> >> @@ -55,6 +55,8 @@ static void *preload_thread(void *_data)
> >>                         continue;
> >>                 if (S_ISGITLINK(ce->ce_mode))
> >>                         continue;
> >> +               if (S_ISSPARSEDIR(ce->ce_mode))
> >> +                       continue;
> >>                 if (ce_uptodate(ce))
> >>                         continue;
> >>                 if (ce_skip_worktree(ce))
> >
> > Don't we have S_ISSPARSEDIR(ce->ce_mode) implies ce_skip_worktree(ce)?
> >  Is this a duplicate check?  If so, is it still desirable for
> > future-proofing or code clarity, or is it strictly redundant?
>
> You're right, we could skip this one because the ce_skip_worktree(ce)
> is enough to cover this case. I think I created this one because I was
> auditing uses of S_ISGITLINK().
>
> >> diff --git a/read-cache.c b/read-cache.c
> >> index 29ffa9ac5db9..6308234b4838 100644
> >> --- a/read-cache.c
> >> +++ b/read-cache.c
> >> @@ -1594,6 +1594,9 @@ int refresh_index(struct index_state *istate, unsigned int flags,
> >>                 if (ignore_skip_worktree && ce_skip_worktree(ce))
> >>                         continue;
> >>
> >> +               if (istate->sparse_index && S_ISSPARSEDIR(ce->ce_mode))
> >> +                       continue;
> >> +
> >
> > I'm a bit confused about what could trigger ce_skip_worktree(ce) &&
> > !ignore_skip_worktree and why it'd be desirable to refresh
> > skip-worktree entries.  However, this is tangential to your patch and
> > has apparently been around since 2009 (in particular, from 56cac48c35
> > ("ie_match_stat(): do not ignore skip-worktree bit with
> > CE_MATCH_IGNORE_VALID", 2009-12-14)).
>
> This is probably better served with a statement like this earlier in
> the method:
>
>         if (ignore_skip_worktree)
>                 ensure_full_index(istate);
>
> It seems like ignoring the skip worktree bits is a rare occasion and
> it will be worth expanding the index for that case.

Maybe...I read the commit message that introduced the behavior and
it's not very convincing to me that SKIP_WORKTREE should be ignored
(it's also not that clear to me what the conditions are; is it just
update-index --really-refresh?); it may be worth double checking on
that assumption first, especially given how many other bugs existed
with skip_worktree stuff for years.  If it's necessary, then I agree
that your extra if-check makes sense.

In particular, I think it'd be really dumb for "update-index
--really-refresh" to read in and populate a huge subdirectory just to
stat files that don't exist because they are in directories that don't
exist.  And I think there's a pretty good argument to not update stat
information for skip_worktree entries in non-sparse-index cases even
in the presence of that flag, especially given Matheus' other recent
changes in this area (the emails just before we got to the point of
discussing SKIP_WORKTREE and racy clean entries...speaking of which,
it might be worthwhile pinging Matheus' for opinions on this issue
too.)

> >>                 if (pathspec && !ce_path_match(istate, ce, pathspec, seen))
> >>                         filtered = 1;
> >>
> >> diff --git a/unpack-trees.c b/unpack-trees.c
> >> index dddf106d5bd4..9a62e823928a 100644
> >> --- a/unpack-trees.c
> >> +++ b/unpack-trees.c
> >> @@ -586,6 +586,13 @@ static void mark_ce_used(struct cache_entry *ce, struct unpack_trees_options *o)
> >>  {
> >>         ce->ce_flags |= CE_UNPACKED;
> >>
> >> +       /*
> >> +        * If this is a sparse directory, don't advance cache_bottom.
> >> +        * That will be advanced later using the cache-tree data.
> >> +        */
> >> +       if (S_ISSPARSEDIR(ce->ce_mode))
> >> +               return;
> >> +
> >
> > I don't understand cache_bottom stuff; we might want to get Junio to
> > look over it.  Or maybe I just need to dig a bit further and attempt
> > to understand it.
>
> I remember looking very careful at this when I created this (and found
> it worth a comment) but I don't recall enough off the top of my head.
> This is worth splitting out with a careful message, which will force me
> to reexamine the cache_bottom member.
>
> >>         if (o->cache_bottom < o->src_index->cache_nr &&
> >>             o->src_index->cache[o->cache_bottom] == ce) {
> >>                 int bottom = o->cache_bottom;
> >> @@ -984,6 +991,9 @@ static int do_compare_entry(const struct cache_entry *ce,
> >>         ce_len -= pathlen;
> >>         ce_name = ce->name + pathlen;
> >>
> >> +       /* remove directory separator if a sparse directory entry */
> >> +       if (S_ISSPARSEDIR(ce->ce_mode))
> >> +               ce_len--;
> >>         return df_name_compare(ce_name, ce_len, S_IFREG, name, namelen, mode);
> >
> > Shouldn't we be passing ce->ce_mode instead of S_IFREG here as well?
> >
> > Note the following sort order:
> >    foo
> >    foo.txt
> >    foo/
> >    foo/bar
> >
> > You've trimmed off the '/', so 'foo/' would be ordered where 'foo' is,
> > but df_name_compare() exists to make "foo" sort exactly where "foo/"
> > would when "foo" is a directory.  Will your df_name_compare() call
> > here result in foo.txt being placed after all the "foo/<subpath>"
> > entries in the index and perhaps cause other problems down the line?
> > (Are there issues, e.g. with cache-trees getting wrong ordering from
> > this, or even writing out indexes or tree objects with the wrong
> > ordering?  I've written out trees to disk with wrong ordering before
> > and git usually survives but gets really confused with diffs.)
> >
> > Since at least one caller of compare_entry() takes the return result
> > and does a "if (cmp < 0)", this order is going to matter in some
> > cases.  Perhaps we need some testcases where there is a sparse
> > directory entry named "foo/" and a file recorded in some relevant tree
> > with the name "foo.txt" to be able to trigger these lines of code?
>
> I will do some testing to find out why removing the separator here was
> necessary or valuable.

I think you removed the separator because df_name_compare() assumes it
gets a regular filename (i.e. no trailing '/') and manually adds one
based on mode for directories.  You were probably worried about what
amounts to a non-sensical double '/', but df_name_compare() wouldn't
actually get to that point unless someone somehow recorded a path
within a git tree object that ended with a trailing '/'.  I'd rather
not have to worry about the double '/' and explain why it isn't
possible (or wonder about whether git trees with trailing '/'
characters could be recorded on some OS), so I think the trimming of
the separator as you did makes sense.

What doesn't make sense to me is that the code just below had a
hardcoded S_IFREG that it passed to df_name_compare, based on "this is
a cache entry, and index entries are _always_ regular files".  You
didn't change that, even though it's now a false assumption.
symlinks, and regular files should be passed as S_IFREG there, I'm not
sure what should be passed for submodules (though the fact that it's
been using S_IFREG for years suggests maybe that is the mode we want
for it, so we can't use ce->ce_mode), and I'm pretty sure sparse
directory entries should be passed as S_IFDIR in order to get the
sorting right unless you stop stripping the trailing '/' character.
I'm not exactly sure where the sorting for do_compare_entry() affects
the code later, but I tried to trace it out a little in my comments
above in order to guide some testing.

> >>  }
> >>
> >> @@ -993,6 +1003,10 @@ static int compare_entry(const struct cache_entry *ce, const struct traverse_inf
> >>         if (cmp)
> >>                 return cmp;
> >>
> >> +       /* If ce is a sparse directory, then allow equality here. */
> >> +       if (S_ISSPARSEDIR(ce->ce_mode))
> >> +               return 0;
> >> +
> >
> > Um...so a sparse directory compares equal to _anything_ at all?  I'm
> > really confused why this would be desirable.  Am I missing something
> > here?
>
> The context is that is removed from the patch is that "cmp" is the
> response from do_compare_entry(), which does a length-limited comparison.
> If cmp is non-zero, then we've already returned the difference.
>
> The rest of the method is checking if the 'info' input is actually a
> parent directory of the _path_ given at this cache entry.

Ah, thanks for the explanation.  So the only way we get here with
cmp==0 when we're dealing with a sparse directory entry is if we found
a directory by the same name....

> >>         /*
> >>          * Even if the beginning compared identically, the ce should
> >>          * compare as bigger than a directory leading up to it!
>
> The line after this is:
>
>         return ce_namelen(ce) > traverse_path_len(info, tree_entry_len(n));
>
> This comparison is saying "these paths match up to the directory specified
> by info and n, but we need 'ce' to be a file within that directory." But
> in the case of a sparse directory entry, we can skip this comparison.

Isn't this "must skip" rather than "can skip"?  If we're considering
the ce path "foo/bar/", then the traverse_path would be "foo/bar" and
we'd have:
    ce_namelen(ce) == 1 + traverse_path_len(info, tree_entry_len(n))
so this would return 1 for the comparison making them be treated as
non-equal even though they are what we consider equal entries.

In any event, it seems like this new check could use a better comment
than "then allow equality here".

> >> @@ -1243,6 +1257,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
> >>         struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
> >>         struct unpack_trees_options *o = info->data;
> >>         const struct name_entry *p = names;
> >> +       unsigned recurse = 1;
> >
> > "recurse" sent my mind off into questions about safety checks, base
> > cases, etc., instead of just the simple "we don't want to read in
> > directories corresponding to sparse entries".  I think this would be
> > clearer either if the variable had the sparsity concept embedded in
> > its name somewhere (e.g. "unsigned sparse_entry = 0", and check for
> > (!sparse_entry) instead of (recurse) below), or with a comment about
> > why there are cases where you want to avoid recursion.
>
> I can understand that. This callback is confusing because it _does_
> recurse, but through a sequence of methods instead of actually calling
> itself.
>
> It would be better to say something like "unpack_subdirectories = 1"
> and disabling it when we are in a sparse directory.

I like that name.

>
> >>
> >>         /* Find first entry with a real name (we could use "mask" too) */
> >>         while (!p->mode)
> >> @@ -1284,12 +1299,16 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
> >>                                         }
> >>                                 }
> >>                                 src[0] = ce;
> >> +
> >> +                               if (S_ISSPARSEDIR(ce->ce_mode))
> >> +                                       recurse = 0;
> >
> > Ah, the context here doesn't show it but this is in the "if (!cmp)"
> > block, i.e. if we found a match for the sparse directory.  This makes
> > sense, to me, _if_ we ignore the above question about sparse
> > directories matching equal to anything and everything.
>
> I believe that "anything and everything" concern has been resolved.

Yes, if we just improve the "then allow equality here" comment.

> >> @@ -1319,7 +1338,8 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
> >>                         }
> >>                 }
> >>
> >> -               if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
> >> +               if (recurse &&
> >> +                   traverse_trees_recursive(n, dirmask, mask & ~dirmask,
> >>                                              names, info) < 0)
> >>                         return -1;
> >>                 return mask;
> >
> > Nice.  :-)
> >
> >
> > I think your patch was mostly about the recurse stuff, which other
> > than the name or a comment about it look good to me.  However, all the
> > other preparatory small tweaks brought up a lot of questions or
> > confusion for me.  I'm worried there might be a bug or two, though I
> > may have just misunderstood some of the code bits.
>
> This patch could probably be split up a little to make these things
> clearer. Thanks for bringing up the tricky bits.
>
> -Stolee

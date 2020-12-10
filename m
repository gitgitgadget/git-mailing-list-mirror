Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56317C433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C74FD233EF
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbgLJA6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 19:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbgLJA5z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 19:57:55 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0596EC0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 16:57:15 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id s2so3907515oij.2
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 16:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UwnnqAjBnp5LJLuhxff3tJ7oHuNaLk7nW9Hj1i8aWyE=;
        b=JEZvitOwjRcTqayXQw5RI3BMBsVf+RWEM3FhvW1nCRqSpUpbs2c428F0byOgYL0eOC
         6zGERkWWVZbUozcsXoCvz/Kw8p1eXH57OAQlJMd3hIDJ7RBv7SrpsT/GhmPftCBg4zvz
         u+aHlhHP3D2LSYaLAg1GEfU9DbhQ22BYTziKHRJap55yCTe+27jG2sR1pOdYPXCOfnoN
         R/ojGirnhO80ZA2Hr/3md4N/5ACXj8LB35DGv5SxT2NIHeLhcJMGUz+OcPQPbc8Uea+P
         Q+TYN4jtrtzbxiLkCuEdKonY+1rUMJn+3ZnGzPBUVLm/pWUBGrHOH5L/b43nQ8+UyH+8
         YThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UwnnqAjBnp5LJLuhxff3tJ7oHuNaLk7nW9Hj1i8aWyE=;
        b=ImmVYVWWmXU1UL58PC+sD9rPATbUUxnJkp9MLtIjP4VQ/X96w+f1vfBSd0FDL4Rqel
         AUnjxgTqBa0pPb43JI7wSyF72nA1/jquyu4uSacx8VueuBWesHDDMaxZYbxP8I1wIrJt
         JRjlKbwotE9bVkaKEfE8a0ejPbJPNjh4nkpAowo3nqk5yoviUkPKnxVBESrsaZG5+5MH
         9K60ZuunCU+iWjkKWa+KuP/Qu4q+W7lFG44bz/i4wxQbMHI/mz2Q2vRc/kYn49n4vDP6
         imLI7NnR8nQo+tgls0uMml7KZCALwBVqVBtVwvLO5Bydr3DsGTGRX3xYNiT2Un8mtUoL
         EteA==
X-Gm-Message-State: AOAM530w8Lc5XnTDe+xnE8LcVnsEA3ww153X7yixwXfg+FUB6CQfB5MN
        FOczZM9+T1CGvP5OEzdjrzmZEP2mHDEG3LTgSLQ=
X-Google-Smtp-Source: ABdhPJzLOy5gNFKX+jO/l0fj/AhBnNNQ/JRNjk6PO6fCfyFWJTlT5dNFEbtRWMC+GykabPSLUq4YfgWEUBVJxxHLKeE=
X-Received: by 2002:aca:e083:: with SMTP id x125mr3850433oig.31.1607561834179;
 Wed, 09 Dec 2020 16:57:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
 <3e83b51628b6f3aeb71c5e637eca03dd63f9e95f.1607223276.git.gitgitgadget@gmail.com>
 <X9FXPHUZJAZKSset@nand.local>
In-Reply-To: <X9FXPHUZJAZKSset@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 9 Dec 2020 16:57:02 -0800
Message-ID: <CABPp-BEhVK9mMsqS-6Yg2ad5nG0=Pm5by80d9nrHKFp2hrMSBw@mail.gmail.com>
Subject: Re: [PATCH 7/7] Accelerate rename_dst setup
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 3:01 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Sun, Dec 06, 2020 at 02:54:36AM +0000, Elijah Newren via GitGitGadget wrote:
> > diff --git a/diffcore-rename.c b/diffcore-rename.c
> > index 816d2fbac44..fb3c2817c6b 100644
> > --- a/diffcore-rename.c
> > +++ b/diffcore-rename.c
> > @@ -5,67 +5,64 @@
> >  #include "cache.h"
> >  #include "diff.h"
> >  #include "diffcore.h"
> > -#include "object-store.h"
> >  #include "hashmap.h"
> > +#include "object-store.h"
>
> Shuffling around this object-store.h include looks like noise to me, but
> maybe there's a good reason for doing it.

Um, well...I guess I couldn't help myself from alphabetizing the
#include list (at least the portion after the initial "cache.h" or
"git-compat-util.h" must come first).  ;-)

I probably should have done it in a separate patch.

> >  #include "progress.h"
> >  #include "promisor-remote.h"
> > +#include "strmap.h"
> >
> >  /* Table of rename/copy destinations */
> >
> >  static struct diff_rename_dst {
> > -     struct diff_filespec *two;
> > -     struct diff_filepair *pair;
> > +     struct diff_filepair *p;
> > +     struct diff_filespec *filespec_to_free;
> > +     int is_rename; /* false -> just a create; true -> rename or copy */
> >  } *rename_dst;
> >  static int rename_dst_nr, rename_dst_alloc;
> > +/* Mapping from break source pathname to break destination index */
> > +static struct strintmap *break_idx = NULL;
> >
> > -static int find_rename_dst(struct diff_filespec *two)
> > -{
> > -     int first, last;
> > -
> > -     first = 0;
> > -     last = rename_dst_nr;
> > -     while (last > first) {
> > -             int next = first + ((last - first) >> 1);
> > -             struct diff_rename_dst *dst = &(rename_dst[next]);
> > -             int cmp = strcmp(two->path, dst->two->path);
> > -             if (!cmp)
> > -                     return next;
> > -             if (cmp < 0) {
> > -                     last = next;
> > -                     continue;
> > -             }
> > -             first = next+1;
> > -     }
> > -     return -first - 1;
> > -}
> > -
> > -static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two)
> > +static struct diff_rename_dst *locate_rename_dst(struct diff_filepair *p)
> >  {
> > -     int ofs = find_rename_dst(two);
> > -     return ofs < 0 ? NULL : &rename_dst[ofs];
> > +     /* Lookup by p->ONE->path */
> > +     int idx = break_idx ? strintmap_get(break_idx, p->one->path) : -1;
>
> I had to lookup the behavior of strintmap_get() to realize that it
> returns the map's "default value" to figure out why this double
> ternary was necessary, but I think that it is.
>
> Ideally, if break_idx is non-NULL, then we ought to be able to immediately
> return NULL, but it's possible that break_idx is non-NULL and simply
> doesn't contain p->one->path, in which case we also want to return NULL.
>
> So, I think this is as clear as it can be.
>
> > +     return (idx == -1) ? NULL : &rename_dst[idx];
> >  }
> >
> >  /*
> >   * Returns 0 on success, -1 if we found a duplicate.
> >   */
> > -static int add_rename_dst(struct diff_filespec *two)
> > +static int add_rename_dst(struct diff_filepair *p)
> >  {
> > -     int first = find_rename_dst(two);
> > -
> > -     if (first >= 0)
> > +     /*
> > +      * See t4058; trees might have duplicate entries.  I think
> > +      * trees with duplicate entries should be ignored and we
> > +      * should just leave rename detection on; while the results
> > +      * may be slightly harder to understand, that's merely a
> > +      * result of the underlying tree making no sense.  But I
> > +      * believe everything still works fine, the results do still
> > +      * make sense, and the extra overhead of doing this checking
> > +      * for a few historical weird trees from long ago seems like
> > +      * the dog wagging the tail to me.
> > +      *
> > +      * However: I don't feel like fighting that battle right now.
> > +      * For now, to keep the regression test passing, we have to
> > +      * detect it.  Since the diff machinery passes these to us in
> > +      * adjacent pairs, we just need to check to see if our name
> > +      * matches the previous one.
> > +      *
> > +      * TODO: Dispense with this test, rip out the test in t4058, and
> > +      * lobby folks for the change.
> > +      */
> > +     if (rename_dst_nr > 0 &&
> > +         !strcmp(rename_dst[rename_dst_nr-1].p->two->path, p->two->path))
> >               return -1;
> > -     first = -first - 1;
> >
> > -     /* insert to make it at "first" */
> >       ALLOC_GROW(rename_dst, rename_dst_nr + 1, rename_dst_alloc);
> > +     rename_dst[rename_dst_nr].p = p;
> > +     rename_dst[rename_dst_nr].filespec_to_free = NULL;
> > +     rename_dst[rename_dst_nr].is_rename = 0;
> >       rename_dst_nr++;
> > -     if (first < rename_dst_nr)
> > -             MOVE_ARRAY(rename_dst + first + 1, rename_dst + first,
> > -                        rename_dst_nr - first - 1);
> > -     rename_dst[first].two = alloc_filespec(two->path);
> > -     fill_filespec(rename_dst[first].two, &two->oid, two->oid_valid,
> > -                   two->mode);
> > -     rename_dst[first].pair = NULL;
> >       return 0;
>
> Very nice, this is much simpler than what was here before.
>
> > @@ -78,6 +75,14 @@ static int rename_src_nr, rename_src_alloc;
> >
> >  static void register_rename_src(struct diff_filepair *p)
> >  {
> > +     if (p->broken_pair) {
> > +             if (!break_idx) {
> > +                     break_idx = xmalloc(sizeof(*break_idx));
> > +                     strintmap_init(break_idx, -1);
> > +             }
> > +             strintmap_set(break_idx, p->one->path, rename_dst_nr);
> > +     }
> > +
>
> Makes sense.
>
> > @@ -664,8 +653,9 @@ void diffcore_rename(struct diff_options *options)
> >                        */
> >                       if (DIFF_PAIR_BROKEN(p)) {
> >                               /* broken delete */
> > -                             struct diff_rename_dst *dst = locate_rename_dst(p->one);
> > -                             if (dst && dst->pair)
> > +                             struct diff_rename_dst *dst = locate_rename_dst(p);
> > +                             assert(dst);
>
> You're not hurting anything, but I'm not convinced that this assert() is
> buying you anything that the line immediately below it isn't already
> doing.

It's identical for runtime correctness, yes.  But the primary point
isn't what happens at runtime, but what happens when future code
readers come along.  If I only keep the "if (dst->is_rename)" line
that comes after without the assert, then someone in the future will
come along (maybe even myself) and think "the original author wasn't
being careful here; they should change this to a check on (dst &&
dst->is_rename)" (because honestly, it is the kind of mistake I'm
prone to make).  However, if they were to do so, and some bug gets
introduced so that locate_rename_dst() returns a NULL for a pair of
interest, then they've masked a bug in the algorithm and made it fail
in harder-to-detect-and-track-down ways.  I wanted it to be clear that
dst == NULL is unacceptable.  I guess I could have marked it with
BUG(), but between an assertion and a NULL-pointer indirection, I
figured that code aborting under that condition was pretty well
covered.  :-)

> The rest of the patch looks good to me.
>
> Thanks,
> Taylor

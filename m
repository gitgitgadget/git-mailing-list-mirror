Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA19C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 21:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbhL1VKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 16:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbhL1VKL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 16:10:11 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E59C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 13:10:10 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w16so78463690edc.11
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 13:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rjB2rgOBcL1Wvoa0ke3JOROntFLOWP0bP3VJ6Vz6mRw=;
        b=jDn1FWntc6adFSgeGv6nDzqSFGvQwS7rowYcvSNeYwF/VbszGZvYHNbdzGn9q1evxf
         +nilknqjbMkaIpCn4ivA+AUU4/7Xw7IMaJnttyo+F1bf/noetUBLl91Wl84/1zdlqZuY
         GY++w277fQ4kU/e6bBeaX3AEVNtKNjHqiKDzTtdjWKDP27XydjkgN8dgOTVgmh3HIU4L
         XiYlJ+ilYfpDiuQGVS93UU8e9xT/Zsi1lI+D6XApokBC8KL5n/aQLrZq/FDsrYLPd1VN
         dSc1SCKT3T60J2cWDQmPIyFShHnhuL5L2bTCptg9vBFQdh/4kLUYvrBytSyjMxfiDaBY
         z1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rjB2rgOBcL1Wvoa0ke3JOROntFLOWP0bP3VJ6Vz6mRw=;
        b=qQiPt59uU9jsFkQypq8+YW7SnVJA8zj53tPU6EDd56A0iwEETH0OnH3RusTGuN3sJG
         0DqnEXym79wppvmoX0yrTNpNZA9Hg6GwSwiosALC4i0djACo1zILOrxfcqEWwsSvqyab
         LsUvNWtDxWMq521M4Q6KaJOv5LZQU5L/nLvSFTAno2G8qlUns+IhIsl1GB1Su7bETPqp
         9rbLePqqFCRZydL06vEvEVBM9aXhTHJgfIiaR1EgpI8/FXJ+cMMvGLH5wFru1YLEOhCY
         A+gCVv6eps4oZJQzdw+KG4CAWHw1/jhHFaVqC2hhltBNWdv5sf9fylX3KNnlt4wEFed2
         5/qg==
X-Gm-Message-State: AOAM531hJxewEGBfsqkx77SSI47KtPRb6LVZd7eM7tw1SF0YEK3WNVUh
        7IMu3gNIWfAjn3XLnPT3tOGDfDbNFanjO9Yz3z4=
X-Google-Smtp-Source: ABdhPJyR4rfzZc5I43SKvN31g2Swq4iX5E4avCrGt9jIfrCYch3MEoBweed1o60PJrWrXSxHfcaIKUzsDJt0ej4L7GA=
X-Received: by 2002:a05:6402:350b:: with SMTP id b11mr22645875edd.228.1640725808850;
 Tue, 28 Dec 2021 13:10:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com> <e94706513038adc85e818e8736ad713b2e6b6be4.1640419160.git.gitgitgadget@gmail.com>
 <20211228105733.lomkg23htd2kjtii@gmail.com>
In-Reply-To: <20211228105733.lomkg23htd2kjtii@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 28 Dec 2021 13:09:57 -0800
Message-ID: <CABPp-BH5XUsmTo=BD7osUgi4o=eFWgaQkN1qYDky6uqb9SykHA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] diff: add ability to insert additional headers for paths
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 28, 2021 at 2:57 AM Johannes Altmanninger <aclopte@gmail.com> wrote:
>
> On Sat, Dec 25, 2021 at 07:59:18AM +0000, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > When additional headers are provided, we need to
> >   * add diff_filepairs to diff_queued_diff for each paths in the
> >     additional headers map which, unless that path is part of
> >     another diff_filepair already found in diff_queued_diff
> >   * format the headers (colorization, line_prefix for --graph)
> >   * make sure the various codepaths that attempt to return early
> >     if there are "no changes" take into account the headers that
> >     need to be shown.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  diff.c     | 116 +++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  diff.h     |   3 +-
> >  log-tree.c |   2 +-
> >  3 files changed, 115 insertions(+), 6 deletions(-)
> >
> > diff --git a/diff.c b/diff.c
> > index 861282db1c3..aaa6a19f158 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -27,6 +27,7 @@
> >  #include "help.h"
> >  #include "promisor-remote.h"
> >  #include "dir.h"
> > +#include "strmap.h"
> >
> >  #ifdef NO_FAST_WORKING_DIRECTORY
> >  #define FAST_WORKING_DIRECTORY 0
> > @@ -3406,6 +3407,31 @@ struct userdiff_driver *get_textconv(struct repository *r,
> >       return userdiff_get_textconv(r, one->driver);
> >  }
> >
> > +static struct strbuf *additional_headers(struct diff_options *o,
> > +                                      const char *path)
> > +{
> > +     if (!o->additional_path_headers)
> > +             return NULL;
> > +     return strmap_get(o->additional_path_headers, path);
> > +}
> > +
> > +static void add_formatted_headers(struct strbuf *msg,
> > +                               struct strbuf *more_headers,
> > +                               const char *line_prefix,
> > +                               const char *meta,
> > +                               const char *reset)
> > +{
> > +     char *next, *newline;
> > +
> > +     for (next = more_headers->buf; *next; next = newline) {
> > +             newline = strchrnul(next, '\n');
> > +             strbuf_addf(msg, "%s%s%.*s%s\n", line_prefix, meta,
> > +                         (int)(newline - next), next, reset);
> > +             if (*newline)
> > +                     newline++;
> > +     }
> > +}
> > +
> >  static void builtin_diff(const char *name_a,
> >                        const char *name_b,
> >                        struct diff_filespec *one,
> > @@ -3464,6 +3490,17 @@ static void builtin_diff(const char *name_a,
> >       b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
> >       lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
> >       lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
> > +     if (!DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two)) {
> > +             /*
> > +              * We should only reach this point for pairs from
> > +              * create_filepairs_for_header_only_notifications().  For
> > +              * these, we should avoid the "/dev/null" special casing
> > +              * above, meaning we avoid showing such pairs as either
> > +              * "new file" or "deleted file" below.
> > +              */
> > +             lbl[0] = a_one;
> > +             lbl[1] = b_two;
> > +     }
>
> not so familiar with this logic, but I saw that without this change, the
> rename/rename conflict test fails. Is this because we add a file pair under
> the original name (that's been renamed on both sides). I wonder if we
> can sketch such a case in the comment.

That may be the only current test in the testsuite that fails without
this bit of logic, but I don't want the comment to be specific to the
rename/rename case.  Whenever we have a conflict/warning/whatever
message from the merge machinery tied to a path which doesn't show up
in either the automatic merge or the recorded merge commit, we will
hit this situation.  Even if I were to give a complete listing of all
the current cases, more could be added in the future.

> > +static void create_filepairs_for_header_only_notifications(struct diff_options *o)
> > +{
> > +     struct strset present;
> > +     struct diff_queue_struct *q = &diff_queued_diff;
> > +     struct hashmap_iter iter;
> > +     struct strmap_entry *e;
> > +     int i;
> > +
> > +     strset_init_with_options(&present, /*pool*/ NULL, /*strdup*/ 0);
> > +
> > +     /*
> > +      * Find out which paths exist in diff_queued_diff, preferring
> > +      * one->path for any pair that has multiple paths.
>
> Why do we prefer one->path?

run_diff() sets name = one->path, passes it along to run_diff_cmd(),
and from there it goes to fill_metainfo() and either
run_external_diff() or builtin_diff().

I'm wondering if I should just ignore two->path entirely and only use
one->path; I think I partially looked at both because of various
places in diff.c that already do but give preferential treatment to
one->path (diffnamecmp(), the calls to show_submodule*diff*(), what is
passed to write_name_quoted() in diff_flush_raw()).

> > +      */
> > +     for (i = 0; i < q->nr; i++) {
> > +             struct diff_filepair *p = q->queue[i];
> > +             char *path = p->one->path ? p->one->path : p->two->path;
> > +
> > +             if (strmap_contains(o->additional_path_headers, path))
> > +                     strset_add(&present, path);
> > +     }
> > +
> > +     /*
> > +      * Loop over paths in additional_path_headers; for each NOT already
> > +      * in diff_queued_diff, create a synthetic filepair and insert that
> > +      * into diff_queued_diff.
> > +      */
> > +     strmap_for_each_entry(o->additional_path_headers, &iter, e) {
> > +             if (!strset_contains(&present, e->key)) {
> > +                     struct diff_filespec *one, *two;
> > +                     struct diff_filepair *p;
> > +
> > +                     one = alloc_filespec(e->key);
> > +                     two = alloc_filespec(e->key);
> > +                     fill_filespec(one, null_oid(), 0, 0);
> > +                     fill_filespec(two, null_oid(), 0, 0);
> > +                     p = diff_queue(q, one, two);
> > +                     p->status = DIFF_STATUS_MODIFIED;
> > +             }
> > +     }
>
> All these string hash-maps are not really typical for a C program. I'm sure
> they are the best choice for an advanced merge algorithm

Agreed up to here.

> but they are not
> really necessary for computing/printing a diff.

Technically agree that it _could_ be solved a different way, but the
strmaps are a much more natural solution to this problem in this
particular case; more on this below.

> It feels like this is an
> implementation detail from merge-ort that's leaking into other components.

And I disagree here, on _both_ the explicit point and the underlying
suggestion that you seem to be making that strmap should be avoided
outside of merging.  The strmap.[ch] type was originally a suggestion
from Peff for areas of git completely unrelated to merging (see the
beginning of https://lore.kernel.org/git/20200821194857.GD1165@coredump.intra.peff.net/,
and the first link in that email).  It's a new datatype for git, much
like strbuf or string_list or whatever before it, that is there to be
used when it's a natural fit for the problem at hand.  The lack of
strmap previously led folks to abuse other existing data structures
(and in a way that often led to poor performance to boot).

> What we want to do is
>
>         for file_pair in additional_headers:
>                 if not already_queued(file_pair):
>                         queue(file_pair)

Yes, precisely.

> to do that, you use a temporary has-set ("present") that records everything
> that's already queued (already_queued() is a lookup in that set).
>
> Let's assume both the queue and additional_headers are sorted arrays.

That's a bad assumption; we can't rely on *either* being sorted.  I
actually started my implementation by trying exactly what you mention
first; I too thought it'd be more natural and clearer to do this.  Of
course, before implementing it, I had to verify whether
diff_queued_diff was sorted.  So, I added some code that would check
the order and fail if the queue wasn't sorted.  7 of the test files in
the regression testsuite had one or more failing tests.

I think the queue was intended to be sorted (see
diffcore_fix_diff_index()), but in practice it's not.  And I'm worried
that if I find the current cases where it fails to be sorted and "fix"
them (though I don't actually know if this was intentional or not so I
don't know if that's really a fix or a break), that I'd end up with
additional cases in the future where they fail to be sorted anyway.
So, no matter what, relying on diff_queued_diff being sorted seems
ill-advised.

Also...

> Then we could efficiently merge them (like a merge-sort algorithm)
> without ever allocating a temporary hash map.
>
> I haven't checked if this is practical (better wait for feedback).
> We'd probably need to convert the strmap additional_path_headers into an
> array and sort it (I guess our hash map does not guarantee any ordering?)

Right, strmap has no ordering either.  I was willing to stick those
into a string_list and sort them, but making temporary copies of both
the strmap and the diff_queued_diff just to sort them so that I can
reasonably cheaply ask "are items from this thing present in this
other thing?" seems to be stretching things a bit too far.
maps/hashes provide a very nice "is this item present" lookup and are
a natural way to ask that.  Since that is exactly the question I am
asking, I think they are the better data structure here.  So, this was
not at all a leak of merge-ort datastructures, but rather a picking of
the appropriate data structures for the problem at hand.

> > +
> > +     /* Re-sort the filepairs */
> > +     diffcore_fix_diff_index();
> > +
> > +     /* Cleanup */
> > +     strset_clear(&present);
>
> Not a strong opinion, but I'd probably drop this comment
>
> > +}
> > +
> >  static void diff_flush_patch_all_file_pairs(struct diff_options *o)
> >  {
> >       int i;
> > @@ -6337,6 +6442,9 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
> >       if (o->color_moved)
> >               o->emitted_symbols = &esm;
> >
> > +     if (o->additional_path_headers)
> > +             create_filepairs_for_header_only_notifications(o);
> > +
> >       for (i = 0; i < q->nr; i++) {
> >               struct diff_filepair *p = q->queue[i];
> >               if (check_pair_status(p))
> > @@ -6413,7 +6521,7 @@ void diff_flush(struct diff_options *options)
> >        * Order: raw, stat, summary, patch
> >        * or:    name/name-status/checkdiff (other bits clear)
> >        */
> > -     if (!q->nr)
> > +     if (!q->nr && !options->additional_path_headers)
> >               goto free_queue;
> >
> >       if (output_format & (DIFF_FORMAT_RAW |
> > diff --git a/diff.h b/diff.h
> > index 8ba85c5e605..06a0a67afda 100644
> > --- a/diff.h
> > +++ b/diff.h
> > @@ -395,6 +395,7 @@ struct diff_options {
> >
> >       struct repository *repo;
> >       struct option *parseopts;
> > +     struct strmap *additional_path_headers;
> >
> >       int no_free;
> >  };
> > @@ -593,7 +594,7 @@ void diffcore_fix_diff_index(void);
> >  "                show all files diff when -S is used and hit is found.\n" \
> >  "  -a  --text    treat all files as text.\n"
> >
> > -int diff_queue_is_empty(void);
> > +int diff_queue_is_empty(struct diff_options*);
> >  void diff_flush(struct diff_options*);
> >  void diff_free(struct diff_options*);
> >  void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc);
> > diff --git a/log-tree.c b/log-tree.c
> > index d4655b63d75..33c28f537a6 100644
> > --- a/log-tree.c
> > +++ b/log-tree.c
> > @@ -850,7 +850,7 @@ int log_tree_diff_flush(struct rev_info *opt)
> >       opt->shown_dashes = 0;
> >       diffcore_std(&opt->diffopt);
> >
> > -     if (diff_queue_is_empty()) {
> > +     if (diff_queue_is_empty(&opt->diffopt)) {
> >               int saved_fmt = opt->diffopt.output_format;
> >               opt->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
> >               diff_flush(&opt->diffopt);
> > --
> > gitgitgadget
> >

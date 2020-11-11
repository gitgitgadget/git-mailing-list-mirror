Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04E3C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 553CE20678
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/3gMAXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgKKQWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 11:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgKKQWt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 11:22:49 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5737FC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 08:22:48 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id f8so571106oou.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 08:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17le30Hb6rBKsYERX7+BH4nLiQ45jxSAhetlT1cmNsA=;
        b=u/3gMAXopEZ++xJMGn1JW/XsCuWoTAW8D7uQs0R/30ZrLYYxe90AR4P4eNEOEkYqwf
         cnYRtSdtj1Y3RtmzRIfCJ7sX0GNoSVjQDMSqqHpIpK5n0sSVkJyzDxkFkm22dEc5PB3p
         6Zi6a3uIa4NbbH/x41ghWKlR7lGrwwfIyZYzOIee/QVzomMJ9QW4Mx47p8TqX/Xy8rKc
         ZCl7Tu9rbupY8BP8Ib+f3Qbt9DzDM+mu6Udc3cLLKxnF1Rsh80wzyfGbAVkGvXCxLvEM
         zzkVSmrIb17Ra73igsvxA5mIsV1Wg/tA3QntLatB3HSa1BXLG1wIHrJNoCws2ViDF7VG
         9n9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17le30Hb6rBKsYERX7+BH4nLiQ45jxSAhetlT1cmNsA=;
        b=sTq/jwV3g18niQP+SLA4Eapw1rIGxlGlUJ8+CArys1kr1/fO3xnipPBOA30oU5xuvA
         dXiF5Zjpzbnb+fXpt4cW7xwAwKeYiqh871ykXdoI0PjL+Cgjyiir48hGpqGCQC2L2O2Q
         vrX+f+IfmK64Me1Spgq+GwPYh0Bq2S7b/wtZXNJ3AbQ6a1l4jc5Hs+ulEiVFJhV/MQEu
         kQWZ5HFbo5DwgCqSVf1PGeIgMJeebrBeSkQxgSqP3IksqmKzNTsA898KqAqqWIC/loh3
         F/OZBuR1wJ7ehiMy/p6CJAQuqBQpcF6B/kgjRujCkQZSb78jaZ/zZt/9LvP+tknrNyBq
         qGGg==
X-Gm-Message-State: AOAM532PMiBiKg+m9+IYUXiQ07XlyXquQABGOKFg+CxsOlISo7ashiuS
        wg/vYfWwp5JCMgSJMzrnfQ/r8gxx5076OYJ/J84=
X-Google-Smtp-Source: ABdhPJyAUwJX2iSiiGqEmvKGo4H+66S2FFoDyl+zhghYKXeoAGgQzj3QgW5B3TXxnPyWwhNNnMy6Lz2HaYhnl85hzhs=
X-Received: by 2002:a4a:9806:: with SMTP id y6mr17827254ooi.45.1605111767524;
 Wed, 11 Nov 2020 08:22:47 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-1-newren@gmail.com> <20201102204344.342633-4-newren@gmail.com>
 <3f1cd4b6-695d-7524-4cb7-7c31f370fe36@gmail.com>
In-Reply-To: <3f1cd4b6-695d-7524-4cb7-7c31f370fe36@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Nov 2020 08:22:36 -0800
Message-ID: <CABPp-BGtpXRSz+ngFz20j8W4qgpb8juogsLf6HF7b0-Pt=s6=g@mail.gmail.com>
Subject: Re: [PATCH v2 03/20] merge-ort: port merge_start() from merge-recursive
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for all the reviews and suggestions!

I'll avoid commenting on the simple fixes that I'm just going to
apply, and instead concentrate on the bigger questions you have in my
reply.

On Wed, Nov 11, 2020 at 5:53 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/2/2020 3:43 PM, Elijah Newren wrote:
> > The weirdest part here is that merge-ort and merge-recursive use the
> > same struct merge_options, even though merge_options has a number of
> > fields that are oddly specific to merge-recursive's internal
> > implementation and don't even make sense with merge-ort's high-level
> > design (e.g. buffer_output, which merge-ort has to always do).  I reused
> > the same data structure because:
> >   * most the fields made sense to both merge algorithms
> >   * making a new struct would have required making new enums or somehow
> >     externalizing them, and that was getting messy.
> >   * it simplifies converting the existing callers by not having to
> >     have different code paths for merge_options setup.
>
> I think this is appropriate. The other option would be to split the
> struct into "common options" and "specific options" but that starts
> to get messy if we add yet another merge strategy that changes what
> should be "common". Hopefully we can group options within the struct
> merge_options definition to assist with this?

I think we should plan on merge-recursive.[ch] being deleted before a
third merge strategy comes along, so the common options might make
sense.  But then again, it sounds like work towards simultaneously
supporting two backends in perpetuity, which isn't at all the current
plan[1].

As far as grouping and other cleanups, see the series included with
merge commit 280bd44551 ("Merge branch 'en/merge-recursive-cleanup'",
2019-10-15), particularly commits ff1bfa2cd5 ("merge-recursive: use
common name for ancestors/common/base_list", 2019-08-17), a779fb829b
("merge-recursive: comment and reorder the merge_options fields",
2019-08-17), and 8599ab4574 ("merge-recursive: consolidate unnecessary
fields in merge_options", 2019-08-17).  I guess we could change from
grouping by option similarity and instead group by which are in use by
which merge backends, but since the plan is to [eventually] kill
merge-recursive and then to just drop the unused or ignored fields, I
think helping users understand the purpose of the options (which
grouping-by-similarity aids with) is more important than grouping for
the purpose of reminding myself which ones to remove later.

[1] https://lore.kernel.org/git/xmqqk1ydkbx0.fsf@gitster.mtv.corp.google.com/

> For now, the assertions are a good approach.
>
> > I also marked detect_renames as ignored.  We can revisit that later, but
> > in short: merge-recursive allowed turning off rename detection because
> > it was sometimes glacially slow.  When you speed something up by a few
> > orders of magnitude, it's worth revisiting whether that justification is
> > still relevant.  Besides, if folks find it's still too slow, perhaps
> > they have a better scaling case than I could find and maybe it turns up
> > some more optimizations we can add.  If it still is needed as an option,
> > it is easy to add later.
>
> As long as it is easy to add later, I don't see much of a problem. Usually
> adding a knob to disable a feature is necessary to mitigate risk, and here
> we can simply adjust config to use the non-ort algorithm if we notice a data
> shape where rename detection makes the algorithm slow/unusable.

Yes, it should be pretty easy to add later.

> >  static void merge_start(struct merge_options *opt, struct merge_result *result)
> >  {
> > -     die("Not yet implemented.");
> > +     /* Sanity checks on opt */
> > +     assert(opt->repo);
> > +
> > +     assert(opt->branch1 && opt->branch2);
> > +
> > +     assert(opt->detect_directory_renames >= MERGE_DIRECTORY_RENAMES_NONE &&
> > +            opt->detect_directory_renames <= MERGE_DIRECTORY_RENAMES_TRUE);
> > +     assert(opt->rename_limit >= -1);
> > +     assert(opt->rename_score >= 0 && opt->rename_score <= MAX_SCORE);
> > +     assert(opt->show_rename_progress >= 0 && opt->show_rename_progress <= 1);
> > +
> > +     assert(opt->xdl_opts >= 0);
> > +     assert(opt->recursive_variant >= MERGE_VARIANT_NORMAL &&
> > +            opt->recursive_variant <= MERGE_VARIANT_THEIRS);
> > +
> > +     /*
> > +      * detect_renames, verbosity, buffer_output, and obuf are ignored
> > +      * fields that were used by "recursive" rather than "ort" -- but
> > +      * sanity check them anyway.
> > +      */
> > +     assert(opt->detect_renames >= -1 &&
> > +            opt->detect_renames <= DIFF_DETECT_COPY);
> > +     assert(opt->verbosity >= 0 && opt->verbosity <= 5);
> > +     assert(opt->buffer_output <= 2);
> > +     assert(opt->obuf.len == 0);
> > +
> > +     assert(opt->priv == NULL);
> > +
> > +     /* Initialization of opt->priv, our internal merge data */
> > +     opt->priv = xcalloc(1, sizeof(*opt->priv));
>
> nit: I would insert an empty line between this code and the
> multi-line comment below.
>
> > +     /*
> > +      * Although we initialize opt->priv->paths with strdup_strings=0,
> > +      * that's just to avoid making yet another copy of an allocated
> > +      * string.  Putting the entry into paths means we are taking
> > +      * ownership, so we will later free it.
> > +      *
> > +      * In contrast, unmerged just has a subset of keys from paths, so
> > +      * we don't want to free those (it'd be a duplicate free).
> > +      */
> > +     strmap_init_with_options(&opt->priv->paths, NULL, 0);
> > +     strmap_init_with_options(&opt->priv->unmerged, NULL, 0);
> >  }
>
> This approach looks fine to me.
>
> Thanks,
> -Stolee

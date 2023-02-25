Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A485C6FA8E
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 00:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBYAdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 19:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBYAdT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 19:33:19 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2571236099
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 16:33:16 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id f16so752092ljq.10
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 16:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NVaF8B9mrtPWZEWVBkf6yZKx5PjDx7XokqNrVt8PlFo=;
        b=ovgp16Q/6YLzVG4Ts6lZGjm1hYemZfIuOtiy+TaLoLFGH5umLgFjwOTsn9UGG7vEpo
         Adm/QhSzfdOkkrhImsDlqus1ygYFfp2A5q8lLjYsuqoo6ZKlCig0lNTWuHAzfYibRC2d
         Kvj095ZwaFpeDcNzOeVQKmATY4iNXV3h9+/LYxtd3IGaQsDB3AFj8u3ZD/beTh+CTF8+
         ugGjZnjtFBxAfm6G8QpC5Vkti5x5y4JjlMfxObC4fDUfc5YmOBzpddoG6338tn+pRFed
         KzjigGBpVIZ/rBF8WL4U8xALSmKN9gsFjzuZ+JsNZTV8r4alpB8skPFyMo+APYqO+hMo
         bvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVaF8B9mrtPWZEWVBkf6yZKx5PjDx7XokqNrVt8PlFo=;
        b=OkLBoP1jLQMM1S2cfox25PhWOAAygc6vhzWKROfCJeaBtmv1vQ1z2gxi9vnwhuQkMV
         vhfjnWJyrBfUvEgu9pshXJBjuDaagl5vvApWWEKGz5KkcYifH//4KPCYUkBEjauR9OhR
         BdZZaNNMH5gZfL8JkggmZsB53lHJb5UkI/9BOoUsD3jWaFTI+8YNhYDeDqZNcXjUPopk
         2UJyB5kWjMjF5/QM6VaZGO+P7JxpVpGYPLSqNFbduT7eo9bIwWGeFtlokX610kz30WwW
         WaiPwJcPblYxAGCCF7mBI/jV2A4livY6FnjmzZJdgdmQ5O07qRNd/Nc13s26hcET6EbT
         DbIQ==
X-Gm-Message-State: AO0yUKWqxqwVNFvAK+jht75tdOBOog+3j45vFB74o4bVIM39EsGiAH5A
        CCleBy4cu4xcRi187OHD9OFCcceN2F8Yc0JsIcz1UMIX0Ms=
X-Google-Smtp-Source: AK7set+5ZcMwbIYGZm1yDXfQh/SVnSNhrCVU3E72dU7/GzgXNtrsWG1NDWAjQ0zHO1hDMsyMCtLzkTFuC687WpMeLK4=
X-Received: by 2002:a2e:b551:0:b0:293:4be1:9c2d with SMTP id
 a17-20020a2eb551000000b002934be19c2dmr5466078ljn.6.1677285194224; Fri, 24 Feb
 2023 16:33:14 -0800 (PST)
MIME-Version: 1.0
References: <508837fc182b0adba96c3fcbd468f47f8f0a0aef.1677143700.git.gitgitgadget@gmail.com>
 <20230224223730.1510266-1-jonathantanmy@google.com>
In-Reply-To: <20230224223730.1510266-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 24 Feb 2023 16:33:02 -0800
Message-ID: <CABPp-BHhWpo532fqO_cuVrTJX550UrEv0ZFCf003HjLFQ+wfFg@mail.gmail.com>
Subject: Re: [PATCH 05/11] sparse-checkout: avoid using internal API of unpack-trees
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2023 at 2:37 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> > index c3738154918..4b7390ce367 100644
> > --- a/builtin/sparse-checkout.c
> > +++ b/builtin/sparse-checkout.c
> > @@ -219,14 +219,13 @@ static int update_working_directory(struct pattern_list *pl)
> >       o.dst_index = r->index;
> >       index_state_init(&o.result, r);
> >       o.skip_sparse_checkout = 0;
> > -     o.pl = pl;
> >
> >       setup_work_tree();
> >
> >       repo_hold_locked_index(r, &lock_file, LOCK_DIE_ON_ERROR);
> >
> >       setup_unpack_trees_porcelain(&o, "sparse-checkout");
> > -     result = update_sparsity(&o);
> > +     result = update_sparsity(&o, pl);
>
> This makes sense - setup_unpack_trees_porcelain() does not use o.pl, so
> there is no logic change.
>
> > @@ -2111,11 +2111,12 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
> >       trace_performance_enter();
> >
> >       /* If we weren't given patterns, use the recorded ones */
> > -     if (!o->pl) {
> > -             memset(&pl, 0, sizeof(pl));
> > +     if (!pl) {
> >               free_pattern_list = 1;
> > -             populate_from_existing_patterns(o, &pl);
> > +             pl = xcalloc(1, sizeof(*pl));
> > +             populate_from_existing_patterns(o, pl);
> >       }
> > +     o->pl = pl;
> >
> >       /* Expand sparse directories as needed */
> >       expand_index(o->src_index, o->pl);
> > @@ -2147,8 +2148,10 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
> >
> >       display_warning_msgs(o);
> >       o->show_all_errors = old_show_all_errors;
> > -     if (free_pattern_list)
> > -             clear_pattern_list(&pl);
> > +     if (free_pattern_list) {
> > +             clear_pattern_list(pl);
> > +             free(pl);
> > +     }
>
> When free_pattern_list is true, we free "pl" which was previously
> assigned to "o->pl". Do we thus need to also clear "o->pl"?

Yeah, I don't think the existing code will ever attempt to use o->pl
again under these circumstances, but setting it to NULL for
future-proofing makes sense.  I'll make that tweak; thanks for reading
carefully!

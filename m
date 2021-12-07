Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2828CC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbhLGSW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhLGSW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:22:27 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EFBC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 10:18:56 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id r11so60139456edd.9
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 10:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNowP0iCDrIbJTpp//sRGwZsBFN4EJyrHvw7UsA2qfE=;
        b=gd4imVkwpPyGDCQMlmG9Mlc/fUze+mwPmeuvgWrMmYEOhRbyYkEDi/iNFmU46w4AiQ
         7bZ9dqlDNMlSoXsBDYv4VI9cnaslKTyO0GuYdUfqxNg2DMqIsTu2ew2Ezhy2vdPWS8RK
         a+I1K9e3GmEgDqJVm/0yzh19jETTQQCWyrOqR0pbQ0nDcKLqHgJchqXfCwZxnlv0dtRm
         vm51GFzsN+SSCEMqPklFHXUPsvmdk+13nj4lUbehtix2LcVTomIvy2RU5E5b3mmtPjWn
         p2Xu8GYBM18aO1KUOWCQHqrETK2vYZ4gPLBHOse+zF1vMK6FwcHIiLrWMSYUFBgSRy72
         3/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNowP0iCDrIbJTpp//sRGwZsBFN4EJyrHvw7UsA2qfE=;
        b=a49R89cBDpE90OgwGc6kNOkiHXu6XayDU+e59KAMx77Rfw1ifi7sqyckSdnweyji22
         aSFJcljTQJqrZQgSIji5BmlwJjUoki79u0KPdyxAseWXKS2z2SL6PL5yAKNe0um52SCY
         z/pRojEnGbT9H1Ug5kbjlEg5kLC3sKlX/VPNvmTLHxNm2p+oE4uZu6Bq8lThzBRIuSS+
         ux0BWwwwV2khb554NebbdEQVz0IgGNHrYb6EOGfutuXv6bUGoTu+qZ7Smj4i9PMbydhM
         dwQplbco2NNp0x6Ju+UePesPaskyr7WV9X10G/3zExFsD7aHMF2crQdtqpdqlLaqIt4a
         awug==
X-Gm-Message-State: AOAM53195YCdhKFzRMy4vCgIMo42x/w/JAfJrd+mj69eeWvRSpNEvzU+
        LJqVeYWjcuITE69AEcXUrGzV9hako8ne3/0fTM0=
X-Google-Smtp-Source: ABdhPJweaDCVnrY602BE+nhbRSX5bO79Mdp/StC07NUnbeDALEbvlSq2hG60vnz+to6ziyBsWiOFLNtcLGDoxpGlujk=
X-Received: by 2002:a05:6402:d73:: with SMTP id ec51mr11401080edb.175.1638901135334;
 Tue, 07 Dec 2021 10:18:55 -0800 (PST)
MIME-Version: 1.0
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
 <a90687eb4c1ea6569250391cd2a8111a0e338316.1638648020.git.gitgitgadget@gmail.com>
 <0a9946da-b509-beb0-0558-12affab03d0b@gmail.com>
In-Reply-To: <0a9946da-b509-beb0-0558-12affab03d0b@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Dec 2021 10:18:43 -0800
Message-ID: <CABPp-BGeY4HiTqprgCQe_vBS+045agchaV=sEzx2vNSQbb4EtQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] sparse-checkout: enable `set` to initialize
 sparse-checkout mode
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 7, 2021 at 8:43 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/4/2021 3:00 PM, Elijah Newren via GitGitGadget wrote:
> >  static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
> >  {
> > +     int mode, record_mode;
> > +     const char *default_patterns[] = {"/*", "!/*/"};
>
> My gut reaction is that this array should be NULL terminated.

Sure, I can make that change.

> > +
> >       static struct option builtin_sparse_checkout_set_options[] = {
> > +             OPT_BOOL(0, "cone", &set_opts.cone_mode,
> > +                      N_("initialize the sparse-checkout in cone mode")),
> > +             OPT_BOOL(0, "sparse-index", &set_opts.sparse_index,
> > +                      N_("toggle the use of a sparse index")),
> >               OPT_BOOL(0, "stdin", &set_opts.use_stdin,
> >                        N_("read patterns from standard in")),
> >               OPT_END(),
> > @@ -700,11 +709,52 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
> >
> >       repo_read_index(the_repository);
> >
> > +     set_opts.cone_mode = -1;
> > +     set_opts.sparse_index = -1;
> > +
> >       argc = parse_options(argc, argv, prefix,
> >                            builtin_sparse_checkout_set_options,
> >                            builtin_sparse_checkout_set_usage,
> >                            PARSE_OPT_KEEP_UNKNOWN);
> >
> > +     /* Determine if we need to record the mode; ensure sparse checkout on */
> > +     record_mode = (set_opts.cone_mode != -1) || !core_apply_sparse_checkout;
> > +     core_apply_sparse_checkout = 1;
> > +
> > +     /* If not specified, use previous definition of cone mode */
> > +     if (set_opts.cone_mode == -1 && core_apply_sparse_checkout)
> > +             set_opts.cone_mode = core_sparse_checkout_cone;
> > +
> > +     /* Set cone/non-cone mode appropriately */
> > +     if (set_opts.cone_mode == 1) {
> > +             mode = MODE_CONE_PATTERNS;
> > +             core_sparse_checkout_cone = 1;
> > +     } else {
> > +             mode = MODE_ALL_PATTERNS;
> > +     }
> > +     if (record_mode && set_config(mode))
> > +             return 1;
>
> I think it is appropriate to still have the init steps before the modification
> of the worktree. I did have a brief pause to think about whether the set_config()
> should be delayed until modify_pattern_list() succeeds.
>
> > +     /* Set sparse-index/non-sparse-index mode if specified */
> > +     if (set_opts.sparse_index >= 0) {
> > +             if (set_sparse_index_config(the_repository, set_opts.sparse_index) < 0)
> > +                     die(_("failed to modify sparse-index config"));
> > +
> > +             /* force an index rewrite */
> > +             repo_read_index(the_repository);
> > +             the_repository->index->updated_workdir = 1;
> > +     }
> > +
> > +     /*
> > +      * Cone mode automatically specifies the toplevel directory.  For
> > +      * non-cone mode, if nothing is specified, manually select just the
> > +      * top-level directory (much as 'init' would do).
> > +      */
> > +     if (!core_sparse_checkout_cone && argc == 0) {
> > +             argv = default_patterns;
> > +             argc = 2;
>
> Perhaps use 'default_patterns_nr' as a constant near the definition of
> 'default_patterns' so these numbers are not so far apart?

Sounds like a good idea; will do.

>
> > +     }
> > +
> >       return modify_pattern_list(argc, argv, set_opts.use_stdin, REPLACE);
> >  }
>
> Thanks,
> -Stolee

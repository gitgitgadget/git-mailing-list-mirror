Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F24C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 22:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1437861279
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 22:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhFRWML (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 18:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbhFRWMK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 18:12:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D444CC061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 15:09:59 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id pf4-20020a17090b1d84b029016f6699c3f2so1648321pjb.0
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 15:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Pf1Tw4oElW/AGSV3kcugA5QHJJboaH4VvVimNk0iUtQ=;
        b=opqCPKttUMAsv/biN+7US957EAlwdyZ0wNG1VhzOQ1jM5pzRDBD7nssjPL9JyrFM4G
         EjG8MXyqgtNKeYFAFvKo62w+tuKYsLlvZtNRBEWDseG7Br2QI4hzuUhGEGVQ4G270EvW
         l7CaxXxxCqZlN1HGZkoHIkoiYjIqyFIgrNvD5OLEmFNC2bT1k+qVlLgRaxTkUjMon5/W
         V5gVYkNNAUr05ruhaDj71o3eMOnQzw39+h1XObwvTQrRsDIdvIZMK18GA54TH2o7KUOW
         0cVv+ypdO7XxLLyf11zoXsRCfate+X677sGNzrL06efTpC9zFMAqeKrv/2zW1qJPMaoO
         Vfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Pf1Tw4oElW/AGSV3kcugA5QHJJboaH4VvVimNk0iUtQ=;
        b=iO/o+QhItUfmxVt9yEVd0lIjW97T4EFgvNG5oZPOe80QWCIpWSyjzkeiT1CEvI4Hr1
         Wn/P/dF7qY07vpnKRCJLet2mHOmQaUi9ZjKuZqvw0FBy/2dkPNN/f0umvDX7BfzKJt+U
         KnvYBbbnCEWWzkWRPP/O2fYDMe5uaubUEQxrwgkDiHjndb0sOQBesXUFHnLiZt9xtIf1
         wEQvPuS7FpsyFKsS1z9ekIOXUwtxRCYxd8uBF+qHEyZWH5JV57+rKo4trUcg49JWqVFL
         BGr7amMUMyBrLpkuAh0lZ5mXEOsvN/1gnviNE6dj5S1D7xW8xhp1RodhTy6cO6qnxuKS
         qNsw==
X-Gm-Message-State: AOAM530n0H/yvfhczyA7RkKnA+a/bSWoQCAhxNtNE0XEoui24uFJQxxL
        kXqdBttZn9eqZ3QHx3O+IvhwBg==
X-Google-Smtp-Source: ABdhPJziX3uot72yXxs8y9N5rAhGZlvxIpygZKAhpCG1jd2ZcCNHM77anAlBQWMWxVqj+ZkK+xFZzQ==
X-Received: by 2002:a17:90a:4216:: with SMTP id o22mr24173867pjg.3.1624054198996;
        Fri, 18 Jun 2021 15:09:58 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:551d:e7ea:4a2f:6667])
        by smtp.gmail.com with ESMTPSA id fs10sm11698959pjb.31.2021.06.18.15.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 15:09:57 -0700 (PDT)
Date:   Fri, 18 Jun 2021 15:09:51 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 27/27] hooks: fix a TOCTOU in "did we run a hook?"
 heuristic
Message-ID: <YM0Zr1uiI0+ShZa5@google.com>
References: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
 <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
 <patch-27.27-d86fedf041-20210617T101217Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-27.27-d86fedf041-20210617T101217Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 17, 2021 at 12:23:01PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> Fix a Time-of-check to time-of-use (TOCTOU) race in code added in
> 680ee550d72 (commit: skip discarding the index if there is no
> pre-commit hook, 2017-08-14).
> 
> We can fix the race passing around information about whether or not we
> ran the hook in question, instead of running hook_exists() after the
> fact to check if the hook in question exists. This problem has been
> noted on-list when 680ee550d72 was discussed[1], but had not been
> fixed.
> 
> In addition to fixing this for the pre-commit hook as suggested there
> I'm also fixing this for the pre-merge-commit hook. See
> 6098817fd7f (git-merge: honor pre-merge-commit hook, 2019-08-07) for
> the introduction of its previous behavior.
> 
> Let's also change this for the push-to-checkout hook. Now instead of
> checking if the hook exists and either doing a push to checkout or a
> push to deploy we'll always attempt a push to checkout. If the hook
> doesn't exist we'll fall back on push to deploy. The same behavior as
> before, without the TOCTOU race. See 0855331941b (receive-pack:
> support push-to-checkout hook, 2014-12-01) for the introduction of the
> previous behavior.
> 
> This leaves uses of hook_exists() in two places that matter. The
> "reference-transaction" check in refs.c, see 67541597670 (refs:
> implement reference transaction hook, 2020-06-19), and the
> prepare-commit-msg hook, see 66618a50f9c (sequencer: run
> 'prepare-commit-msg' hook, 2018-01-24).
> 
> In both of those cases we're saving ourselves CPU time by not
> preparing data for the hook that we'll then do nothing with if we
> don't have the hook. So using this "invoked_hook" pattern doesn't make
> sense in those cases.
> 
> More importantly, in those cases the worst we'll do is miss that we
> "should" run the hook because a new hook appeared, whereas in the
> pre-commit and pre-merge-commit cases we'll skip an important
> discard_cache() on the bases of our faulty guess.
> 
> I do think none of these races really matter in practice. It would be
> some one-off issue as a hook was added or removed. I did think it was
> stupid that we didn't pass a "did this run?" flag instead of doing
> this guessing at a distance though, so now we're not guessing anymore.

Yeah, I think your solution is very neat. I like this patch.

 - Emily

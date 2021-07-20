Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE83C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E54AA60FF2
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhGTRPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 13:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhGTRPA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 13:15:00 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251B0C061762
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:55:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x17so29498444edd.12
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Q35b1M8k2Mut9yCX3g2hxC6spsa/8hXmd/+qItQckkk=;
        b=V/CmC6QYw7KuE0WrfPca++qvtM+WlcfR7YXYcg85d+nwWci3go7B0c4kCG7UlV92d4
         IkLYp7AXeDhlmWtgL5NkBoksy8viWUg5G4iQNa1wxKrePooSWyRW1cwKSasKgKXcDYzU
         EQfq1hY0fk9FGtI+4aYK0DMEwQ3mYnf6tmnZkEY0dM3gnbO1UXdx4ZOv3Hve2JhokOKJ
         3gAUP/hIUf2M22vMBPm/ntrbOZEuyv5nuIvqcNqkYrc0wzKihIogcommcmHYFLdHxIbC
         pqiJN5FJA3CKNphkpQjeyoJdYYz34E6QN3CgKF+4dpE8Jop3DJ6v2sZvN1Er+x/zsWmN
         CZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Q35b1M8k2Mut9yCX3g2hxC6spsa/8hXmd/+qItQckkk=;
        b=Kbs8oUHWrU+TC1cn2/djbArZkc1LLEO/BggD9S6slb9WGhkETVK0aHl+gUf7zoy+HA
         B/PZlhC7+DnsNVOgw391L26X2UW8oWUloYpk5WnMzBwIFDkVwn2AJ5DqiGDGdgTYqhf1
         5nSoSetahYtu5TDWlYWhUvZ5IUNE/PG4F5siW0UvEPcEI8Op1O8Mp/tFKrKP6R0SeJWS
         CBb0nyt9/c61GyxyUuWGq+CtHQuUm3JIfMRkavLr7at6Pf+s+xvuMQ2kYDMsvstu7fgm
         5hOZCoN2+jiGgxktikuqVZ+JMl601aWhrCyUUhGOM03IZ3o1x9tChgdW0L/v+qRhMvfR
         6QcQ==
X-Gm-Message-State: AOAM532VwGHu93l1F88Ahs0NncRj6iw6Sc0/GiiOaKvn2M7ZBKvjmN3O
        U9XrOZyS9TgPi0K/FHYZEdk=
X-Google-Smtp-Source: ABdhPJyAJg+XOSo4RY8peIi+UTpQv9udw8K9cHI4NA9zKXpS6OCzk5q3dhPV1v7aw3O8GqkHL5BoNg==
X-Received: by 2002:a05:6402:312e:: with SMTP id dd14mr42492611edb.33.1626803735761;
        Tue, 20 Jul 2021 10:55:35 -0700 (PDT)
Received: from szeder.dev (62-165-236-2.pool.digikabel.hu. [62.165.236.2])
        by smtp.gmail.com with ESMTPSA id kf3sm6282583ejc.118.2021.07.20.10.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 10:55:35 -0700 (PDT)
Date:   Tue, 20 Jul 2021 19:55:30 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v3 6/6] commit-graph: show usage on "commit-graph
 [write|verify] garbage"
Message-ID: <20210720175530.GA23408@szeder.dev>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
 <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
 <patch-6.6-5c1694e071e-20210720T113707Z-avarab@gmail.com>
 <20210720174739.GA2025@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210720174739.GA2025@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 07:47:39PM +0200, SZEDER Gábor wrote:
> On Tue, Jul 20, 2021 at 01:39:45PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > Change the parse_options() invocation in the commit-graph code to make
> > sense. We're calling it twice, once for common options parsing, and
> > then for the sub-commands.
> > 
> > But we never checked if we had something leftover in argc in "write"
> > or "verify", as a result we'd silently accept garbage in these
> > subcommands. Let's not do that.
> > 
> > Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> > ---
> >  builtin/commit-graph.c  | 10 ++++++++--
> >  t/t5318-commit-graph.sh |  5 +++++
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> > index bf34aa43f22..88cbcb5a64f 100644
> > --- a/builtin/commit-graph.c
> > +++ b/builtin/commit-graph.c
> > @@ -104,7 +104,10 @@ static int graph_verify(int argc, const char **argv)
> >  	opts.progress = isatty(2);
> >  	argc = parse_options(argc, argv, NULL,
> >  			     options,
> > -			     builtin_commit_graph_verify_usage, 0);
> > +			     builtin_commit_graph_verify_usage,
> > +			     PARSE_OPT_KEEP_UNKNOWN);
> > +	if (argc)
> > +		usage_with_options(builtin_commit_graph_verify_usage, options);
> 
> Checking 'argc' alone is sufficient to catch unsupported parameters.
> 
> Using PARSE_OPT_KEEP_UNKNOWN is not only unnecessary, but arguably
> wrong here

And it's wrong in 'multi-pack-index' and 'env--helper' as well.

> because 'git commit-graph write --foo' won't print "error:
> unknown option `foo'", and we don't want to pass the remaining
> unrecognized options to a different command, like e.g. 'git difftool',
> or another parse_options(), like e.g. 'git archive'.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCF0C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 18:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 553D2610A7
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 18:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhGTRqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 13:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbhGTRoA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 13:44:00 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0E6C061762
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 11:24:30 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id d9so24994290ioo.2
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 11:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LSEj8cqS+6VryDeVbrQi08K0JPc/ImMbpzWV12q4POk=;
        b=Y8vxj1cca+tRvBZ8LqdpeJVhsGLGihhR6nStMydsLbwYrddsA6vXA+fV1a1xM06X7x
         Ujozch1fyZcotbLPhYPOBbzdCEgIMR4XnHztG1yjmYnClyCo/5re7XVtlU6pbF7QnK+o
         SlMteW42/FHJoLT3uvDKJ55GZR5BoCpx6SjOXYEWXC7S6y5Vor0/vkpfmi+m+mcRL9+T
         bGpWW5n1LBnJh3sbIrKSML6yzF5Q1TRh0YBgjv7kufZgzUXYZuTMljdTrZpklvrpZYuO
         EVdETdj7hOuDv51Qlg2TQAQXz4v1c6+qeW/F6D5v8lsTisoZ8IJCsoKXaWQEnvDjts/t
         j+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LSEj8cqS+6VryDeVbrQi08K0JPc/ImMbpzWV12q4POk=;
        b=D/ndaIV8wjOe5qtUdPZTWcsN1sDb2zCN/aJt9gHEy3FP8wmE444Cy2wOk3sRhdWXZ5
         f1rg53oeYrxxjGt9mu1xNd90fcK/xwEFRX4BoYiXl21zqBRPlVozLm628kdmFRK+Fk8S
         TsqytLaSyq6jwlzpx+wDLSYXqxi0VZdXq9uSKlR1pnTEskTvdlwFF+ynJeS0zlTth3Hs
         SAPF47F7i3M5ZyVtkN0bDXpk2wVYn5gJWDKoIlG5HmgNblT6yBcCYYtSX61R2q/Vfdhq
         3XLPls+wPlaG9hBHo61xZiwn/Y3pF+ng6zv0+TNPA5J/96ro3dzXRLCZjJoeTtkTrMKL
         vv3w==
X-Gm-Message-State: AOAM532jpUR9mlbMRuN/7OWNu74UuEe2MX2NdZubolBLdj5A2lyrEe+5
        4lvOPnGNSRsIkxFUZHfaOJECcQ==
X-Google-Smtp-Source: ABdhPJzum5BdQaNVTGKfxbIA5gwZpwF6SZrZW35f0x+RSoXfBZ+M7j1jUwQVUEYYcKZ3jGFaPVkgKw==
X-Received: by 2002:a05:6638:3452:: with SMTP id q18mr25285224jav.111.1626805469819;
        Tue, 20 Jul 2021 11:24:29 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:9f71:89c7:e095:b8eb])
        by smtp.gmail.com with ESMTPSA id k21sm13051331ios.0.2021.07.20.11.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 11:24:29 -0700 (PDT)
Date:   Tue, 20 Jul 2021 14:24:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v3 6/6] commit-graph: show usage on "commit-graph
 [write|verify] garbage"
Message-ID: <YPcU3LSpa/r5nFCP@nand.local>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
 <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
 <patch-6.6-5c1694e071e-20210720T113707Z-avarab@gmail.com>
 <20210720174739.GA2025@szeder.dev>
 <20210720175530.GA23408@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210720175530.GA23408@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 07:55:30PM +0200, SZEDER Gábor wrote:
> On Tue, Jul 20, 2021 at 07:47:39PM +0200, SZEDER Gábor wrote:
> > On Tue, Jul 20, 2021 at 01:39:45PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > > Change the parse_options() invocation in the commit-graph code to make
> > > sense. We're calling it twice, once for common options parsing, and
> > > then for the sub-commands.
> > >
> > > But we never checked if we had something leftover in argc in "write"
> > > or "verify", as a result we'd silently accept garbage in these
> > > subcommands. Let's not do that.
> > >
> > > Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> > > ---
> > >  builtin/commit-graph.c  | 10 ++++++++--
> > >  t/t5318-commit-graph.sh |  5 +++++
> > >  2 files changed, 13 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> > > index bf34aa43f22..88cbcb5a64f 100644
> > > --- a/builtin/commit-graph.c
> > > +++ b/builtin/commit-graph.c
> > > @@ -104,7 +104,10 @@ static int graph_verify(int argc, const char **argv)
> > >  	opts.progress = isatty(2);
> > >  	argc = parse_options(argc, argv, NULL,
> > >  			     options,
> > > -			     builtin_commit_graph_verify_usage, 0);
> > > +			     builtin_commit_graph_verify_usage,
> > > +			     PARSE_OPT_KEEP_UNKNOWN);
> > > +	if (argc)
> > > +		usage_with_options(builtin_commit_graph_verify_usage, options);
> >
> > Checking 'argc' alone is sufficient to catch unsupported parameters.
> >
> > Using PARSE_OPT_KEEP_UNKNOWN is not only unnecessary, but arguably
> > wrong here
>
> And it's wrong in 'multi-pack-index' and 'env--helper' as well.

Thanks for spotting. Obviously this one is new, but the one in the midx
builtin is my fault; I'm not sure why it's there, because it's clearly
wrong.

So we should definitely fix this instance via a reroll of this series,
but that still leaves the others up for grabs. Ævar, are those (the ones
in the 'multi-pack-index' and 'env--helper' builtins) something that you
want to clean up while you're working in this area, or would you rather
that I take care of it?

I don't mind either way, just want to make sure that we don't duplicate
effort.

Thanks,
Taylor

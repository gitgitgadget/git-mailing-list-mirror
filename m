Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021FCC43461
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 16:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE3A20578
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 16:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="UaSCW3Ag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgICQfz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbgICQft (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 12:35:49 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664FAC061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 09:35:49 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w16so3631803qkj.7
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 09:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lDLWdc+o851tlcrHMFS2JluucnUd7OHX7J66UaHZo8A=;
        b=UaSCW3Ag/5ezchiNq1Zqe9VxQU5mMAvKPz2b5fd9JR3LQ8LdINj+2oBvmAI+FGGPP+
         s/mHOpKoyLcKtR3lY9o5R0CEN2D1N/vKhqqY78hc5GITLv4EAk0B2f7chH4zwwOEKkBM
         /jhotknFkHeerScBacPR9bo3+ycNdGCnb8nzOLwMaIB47On6sjdoXGAEPVQ72Ph/ueNd
         DJTPGGbAaWCzissiXR4Sb4wq+/VfyaCCf/MoU6KPGVxbLe79DRNuVfePtIC0UroWT4t5
         dKLCD3Y0FXC/ua1mGgX0mveGuWY453azTGFHgKI7bS7w6WAQ6JKVoEPSoIU72UZ/utzi
         qoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lDLWdc+o851tlcrHMFS2JluucnUd7OHX7J66UaHZo8A=;
        b=HzWT4PDDeKTDhiJ5UiDVH3C2DMH/hKuRTSzPOZ582PEwXHAWYdSvnm4EM7cTaOviHM
         jBzncOS7cO6nt9DdcLFaUugBff+YP0lFb3ZyqxVOjrckgoxZjnFxQyj9FWbfPF5sM1I+
         PF5moyk9Nm1GmJ2OpbWzOeczBc1IMQZxcy1A4A3T+t3u/PvPMa2/2puG9zBP7rJX7VWQ
         mOiq/wN8vyTpW9f602lIDbTxHDGUYpU3lIrmj0tn7pRj9qx2awvcdYRYGw+P1ZU2H6f4
         f/f9HUGhBPTboHorzQ98xFIpmjUvre+ECwmI8vNJBqel5wIhiOJMCeu9IwxFbsJCIfUG
         oXCg==
X-Gm-Message-State: AOAM532obFwufop9AAC2yomsyKsdnBLQBuTzJCu7Qbli97otL+Ekp+s+
        fhLInvV9kTpP75qgHwfDxNmXog==
X-Google-Smtp-Source: ABdhPJyHPl3+ihvSjRY2VfIoe1SWem8FwwTI8Oi+OUdc6KS1pzP4+oPFkT6Msv3WKZlCEm5H5UF6Iw==
X-Received: by 2002:a37:8282:: with SMTP id e124mr3865944qkd.308.1599150948516;
        Thu, 03 Sep 2020 09:35:48 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:945e:14e0:5690:8262])
        by smtp.gmail.com with ESMTPSA id d20sm2531686qkk.84.2020.09.03.09.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 09:35:47 -0700 (PDT)
Date:   Thu, 3 Sep 2020 12:35:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v3 14/14] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200903163513.GA6521@nand.local>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <09f6871f66bff838c067a3e0d23cd4622171f3bd.1597178915.git.me@ttaylorr.com>
 <20200818222329.GC29528@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200818222329.GC29528@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 19, 2020 at 12:23:29AM +0200, SZEDER Gábor wrote:
> On Tue, Aug 11, 2020 at 04:52:14PM -0400, Taylor Blau wrote:
> > Introduce a command-line flag and configuration variable to fill in the
> > 'max_new_filters' variable introduced by the previous patch.
>
> 'max_new_filters' is introduced in this patch.
>
> > The command-line option '--max-new-filters' takes precedence over
> > 'commitGraph.maxNewFilters', which is the default value.
>
> What "filters"?  While misnamed, the '--changed-paths' options did a
> good job at hiding the implementation detail that we use Bloom filters
> to speed up pathspec-limited revision walks; as far as I remember this
> was a conscious design decision.  Including "filter" in the name of
> the option and corresponding config variable goes against this
> decision.  Furthermore, by not being specific we might end up in abad
> situation when adding some other filters to the commit-graph format.
> Unfortunately, I can't offhand propose a better option name, all my
> ideas were horrible.

I don't disagree, but I can't come up with a better name either.
maxNewChangedPaths? maxNewSomething? I don't know. Usually I think
exposing this sort of detail is smelly, but I'm not so bothered by it
here. Similarly, this thread has been around for a while, and nobody
else has suggested a better name, so, I'm inclined to keep it.

> > +With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
> > +filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
> > +enforced. Overrides the `commitGraph.maxNewFilters` configuration.
>
> I think this description should also detail what happens with those
> commits for which no modified path Bloom filters are calculated, and
> which commands will calculate them (even implicitly).

OK, sure.

> >  static int get_bloom_filter_large_in_graph(struct commit_graph *g,
> > -					   const struct commit *c)
> > +					   const struct commit *c,
> > +					   uint32_t max_changed_paths)
> >  {
> >  	uint32_t graph_pos = commit_graph_position(c);
> >  	if (graph_pos == COMMIT_NOT_FROM_GRAPH)
> > @@ -965,6 +966,17 @@ static int get_bloom_filter_large_in_graph(struct commit_graph *g,
> >
> >  	if (!(g && g->bloom_large))
> >  		return 0;
> > +	if (g->bloom_filter_settings->max_changed_paths != max_changed_paths) {
> > +		/*
> > +		 * Force all commits which are subject to a different
> > +		 * 'max_changed_paths' limit to be recomputed from scratch.
> > +		 *
> > +		 * Note that this could likely be improved, but is ignored since
> > +		 * all real-world graphs set the maximum number of changed paths
> > +		 * at 512.
>
> I don't understand what the second part of this comment is trying to
> say; and real-world graphs might very well contain Bloom filters with
> more than 512 modified paths, because the applying that limit was
> buggy.

I'm trying to say that there is room for us to improve when we do and
don't recompute filters when the limit on the number of changed paths
deviates between layers, but that such deviations don't currently exist
in the wild.

Bugs are another thing, but we can't tell that they exist without
recomputing every filter.

Thanks,
Taylor

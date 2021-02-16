Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58374C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 22:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1485E64E08
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 22:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhBPW5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 17:57:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:35114 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230059AbhBPW53 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 17:57:29 -0500
Received: (qmail 15301 invoked by uid 109); 16 Feb 2021 22:56:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 22:56:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30388 invoked by uid 111); 16 Feb 2021 22:56:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 17:56:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 17:56:47 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] t/perf: handle worktrees as test repos
Message-ID: <YCxNr+ViJsRlGbQJ@coredump.intra.peff.net>
References: <YCwnPVFsYDa0SNmG@coredump.intra.peff.net>
 <YCwoOMo7obrNOGYX@coredump.intra.peff.net>
 <xmqqtuqbocae.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtuqbocae.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 02:52:57PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Feb 16, 2021 at 03:12:45PM -0500, Jeff King wrote:
> >
> >> Having written that, it occurs to me that an even simpler solution is to
> >> just always use the commondir as the source of the scratch repo. It does
> >> not produce the same outcome, but the point is generally just to find a
> >> suitable starting point for a repository. Grabbing the main repo instead
> >> of one of its worktrees is probably OK for most tests.
> >
> > The patch there is delightfully simple:
> >
> > diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> > index e385c6896f..7018256cd4 100644
> > --- a/t/perf/perf-lib.sh
> > +++ b/t/perf/perf-lib.sh
> > @@ -75,7 +75,7 @@ test_perf_create_repo_from () {
> >  	BUG "not 2 parameters to test-create-repo"
> >  	repo="$1"
> >  	source="$2"
> > -	source_git="$("$MODERN_GIT" -C "$source" rev-parse --git-dir)"
> > +	source_git="$("$MODERN_GIT" -C "$source" rev-parse --git-common-dir)"
> >  	objects_dir="$("$MODERN_GIT" -C "$source" rev-parse --git-path objects)"
> >  	mkdir -p "$repo/.git"
> >  	(
> >
> > but I do wonder if somebody would find it confusing.
> 
> That does look quite a lot simpler.
> 
> What are the possible downsides?  Per-worktree references may not be
> pointing at the same objects?

The main one IMHO is that HEAD would not be pointing where the user
might expect it to be.

-Peff

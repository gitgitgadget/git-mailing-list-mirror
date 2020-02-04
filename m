Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB7DC3524A
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 03:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD87B2087E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 03:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="PY5Azmtj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgBDD6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 22:58:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46222 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgBDD6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 22:58:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id k29so8719315pfp.13
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 19:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LE1G3CZiEe7jgez5JiSvr/Ahyao0oeldoenE7R5KT6E=;
        b=PY5AzmtjasKPGBoegH7DpMemyklznbuVsNeLQWkStxYTK+Q4IJMS8FYeisBHYb8jHc
         eHwkLBz0Ymm2Pp4wCVmQNiy0X9ODz2eyP76SDlO6YbAiEN/MgEXksD7NkByLnSABiwqP
         3zG8hrezMikc6Y2rp+RrJFm5hn0B/77da8+tFpqlfLQ7G987J9FM0YW9r3hkEAemP0LV
         pvLDiaCWuJiQcY+oDAICDhbB/v8hn+fCIkIcWQFGgWzkQZ58+hITw+VVPdM25Lu0fd+/
         aFE2/mneR6jcRFNfXo+z/hNqXZP+sNfOzybcHNxtVFU7Y6VdMYBni3I9Z2V4Nz4cwdPj
         7/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LE1G3CZiEe7jgez5JiSvr/Ahyao0oeldoenE7R5KT6E=;
        b=sLrn4wPyXVjVdyJ1rIoYV9G6xxR/+QK5XTXS80kHWsoSjvHc5jhR0V17xt1nb26zdh
         kMZiF6nK7NF/YVBsZXN3JhzpZeCDMe5WkVNI5lgaecs517X1y1OPgtKsinGf+Am2fgdT
         Wx/F0B87Pc2Tt+/xL9I5wBiYXh8OYVyFip61T0KRiJ6iz1NIcltRycno6yjw3dSo43eD
         pC8c76W1/ohFpk3P2FIUzXURr/JYHHCMSqJWnNuuVXX7j2lZglM4ZjhlDdjzcPOU/qui
         Giqer6eGAJjxbWsa5lfp6hOmLGUBG1RofrDfkGucWBnfUgGPxAuBxzSJTVPPHjrZ1pA7
         ehig==
X-Gm-Message-State: APjAAAVDxMNmyKnGWJWNEUjaC8XYEHeILGGE582oq579FBD/I1h3xQuf
        K5gBa6M5CMmPfAKFb4/vOd4OsQ==
X-Google-Smtp-Source: APXvYqwnWbNQ/ldWd7Q9RU/uZG4vXJO3PIDkrEZgMpPCiKnkbx1jgLbsl+BythhW4ZXbehTdcJGpbw==
X-Received: by 2002:a63:5345:: with SMTP id t5mr9509254pgl.254.1580788702478;
        Mon, 03 Feb 2020 19:58:22 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:7c5e:a7ec:bd9e:cd59])
        by smtp.gmail.com with ESMTPSA id bb5sm970031pjb.8.2020.02.03.19.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 19:58:22 -0800 (PST)
Date:   Mon, 3 Feb 2020 19:58:21 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH 1/3] builtin/commit-graph.c: support
 '--split[=<strategy>]'
Message-ID: <20200204035821.GB5790@syl.local>
References: <cover.1580430057.git.me@ttaylorr.com>
 <4f5bc19903f8a1f5b153b5665de378e743e12744.1580430057.git.me@ttaylorr.com>
 <20200131233434.GJ10482@szeder.dev>
 <nycvar.QRO.7.76.6.2002012223490.46@tvgsbejvaqbjf.bet>
 <20200203104730.GK10482@szeder.dev>
 <20200203111117.GC4153124@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200203111117.GC4153124@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 03, 2020 at 06:11:17AM -0500, Jeff King wrote:
> On Mon, Feb 03, 2020 at 11:47:30AM +0100, SZEDER Gábor wrote:
>
> > > -- snip --
> > > diff --git a/commit-graph.c b/commit-graph.c
> > > index a5d7624073f..af5c58833cf 100644
> > > --- a/commit-graph.c
> > > +++ b/commit-graph.c
> > > @@ -1566,7 +1566,8 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
> > >  	num_commits = ctx->commits.nr;
> > >  	ctx->num_commit_graphs_after = ctx->num_commit_graphs_before + 1;
> > >
> > > -	if (ctx->split_opts->flags != COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED) {
> > > +	if (ctx->split_opts &&
> > > +	    ctx->split_opts->flags != COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED) {
> > >  		while (g && (g->num_commits <= size_mult * num_commits ||
> > >  			    (max_commits && num_commits > max_commits) ||
> > >  			    (ctx->split_opts->flags == COMMIT_GRAPH_SPLIT_MERGE_REQUIRED))) {
> > > -- snap --
> >
> > Yeah, that's what I noted below, but I'm not sure that this is the
> > right solution.  Why doesn't cmd_fetch() call
> > write_commit_graph_reachable() with a real 'split_opts' parameter in
> > the first place?  Wouldn't it be better if it did?
>
> It used to provide a "blank" split_opts until 63020f175f (commit-graph:
> prefer default size_mult when given zero, 2020-01-02), which caused a
> bug. That bug was since fixed, but the idea was to keep things
> convenient for callers.
>
> Whether that's a good idea or not I guess is up for debate, but it
> certainly is what the commit-graph code has tried to provide for some
> time. If we're not going to follow that in this new code, then we should
> presumably also rip out all of the other "if (ctx->split_opts)" lines.

I think that this seems like a good step that we should probably take,
but I don't think that it's necessary for the series at hand. The
pattern in this function is to define a local variable which has the
same value as in split_opts, or a reasonable default if split_opts is
NULL (c.f., 'max_commits' and 'size_mult').

So, I think that a safe thing to do which prevents the segv and doesn't
change the pattern too much is to write:

  enum commit_graph_split_flags flags = COMMIT_GRAPH_SPLIT_MERGE_AUTO;
  if (ctx->split_opts) {
    /* ... */
    flags = ctx->split_opts->flags;
  }

  /* ... */

  if (flags != COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED) {
    while ( ... ) { ... }
  }

This is adding another local variable, which seems like an odd thing to
do *every* time that we add another member to split_opts. So for that
reason it seems like in the longer-term we should either force the
caller to pass in a blank, or do something else that doesn't require
this, but I think that the intermediate cost isn't too bad.

> -Peff

Thanks,
Taylor

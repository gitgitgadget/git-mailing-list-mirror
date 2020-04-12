Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07523C2D0EC
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 20:51:57 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE197206A1
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 20:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="jzllHEG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE197206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=git-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgDLUvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 16:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbgDLUvu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 16:51:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7BEC0A3BF5
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 13:51:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x3so3411079pfp.7
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 13:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gjeIesdv9FIHcSHaiA8fMBIvzurPSMF0r8opnEwpsao=;
        b=jzllHEG00/dZs8fGzunCzQsVpgE+wMoRX+mDq+FkkYltz5Y3gNn1Ottwczf1YfZ5tq
         3cevQ1BSgXOZMBx4+iUHRGftw/xSh3Du1PvVeyQ6Ex+n37YMNF3DUOFVWNBuVuYClBJS
         XIYxN5H4N2B+PV4O1qZjMXCro6bN3Xy7ZLDaMPpZ9YPd6BnWVxdBOvitd9zRBDPyJd1F
         KBHALsVIDjYRovW3LyodWg4WD8vc2SRUGGfnEMyRbPYIx5GpftnckTzrvL3f98svYa3a
         4YEEYnROpR0P/dbdiatq1whFJoQjKDRreh6dcdMkVbtQRK19YQQVvdUeJR5IEQQBOqbD
         kaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gjeIesdv9FIHcSHaiA8fMBIvzurPSMF0r8opnEwpsao=;
        b=kz86kQAd0oMwnN5glOycpSD5y8Og89YUHNARRWvC1OzkWNrJvRt9v8lWsNHXIcbon7
         VlS8zJ9E460OytE7hKk7B9u1i+6p9MvUaUbWCxi1MbriD2z6FHVJGlbbOffztPLyuhX0
         DlVKLgy9QcdJxHpPXuF4gJrtbP/1xbUdcIrQ+xlxRMJJqFW6sdZ8RNFxcWIaqd5VcpVx
         B8Dly19YhnLOgVNhvdJgsvXbnitGvfgxB5cykmAAhqvIb5y940LoRKJzU8otjXCIF2IS
         CAUNwQlQFJsZr1PhA6tUI+sS+8b6HTDl6DwcMxe46G7bxfGHZ+9nYUL5q5ugrvF5z7FX
         Q4Jw==
X-Gm-Message-State: AGi0PuYOEU1kLQzcYPuRDyapPcgS0ujCqrfC9hymUINli91CqpJVtV6O
        aVsb9M7p5wQKe3Brsu/ajriU7bWpdruKZw==
X-Google-Smtp-Source: APiQypIY1c48CDsPzzMYsp/l1M+zK9gUJR5gZX5e+X0mjSCXRgABMM3c/eUoq+SkdLmXKmMs/5Wg0A==
X-Received: by 2002:a63:3150:: with SMTP id x77mr10340231pgx.293.1586724709888;
        Sun, 12 Apr 2020 13:51:49 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id fa16sm7225777pjb.39.2020.04.12.13.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 13:51:49 -0700 (PDT)
Date:   Sun, 12 Apr 2020 14:51:48 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, jnareb@gmail.com,
        garimasigit@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/3] commit: write commit-graph with bloom filters
Message-ID: <20200412205148.GB50412@syl.local>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
 <bb5ce39d0283f14095d87dd0645e641ae799f16c.1586566981.git.gitgitgadget@gmail.com>
 <xmqqa73hheip.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa73hheip.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 11, 2020 at 02:57:18PM -0700, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index d3e7781e658..d2fdfdc4363 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -1701,7 +1701,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
> >  		      "not exceeded, and then \"git restore --staged :/\" to recover."));
> >
> >  	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
> > -	    write_commit_graph_reachable(the_repository->objects->odb, 0, NULL))
> > +	    write_commit_graph_reachable(the_repository->objects->odb,
> > +					 git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0) ? COMMIT_GRAPH_WRITE_BLOOM_FILTERS : 0,
> > +					 NULL))
>
> Yuck.  That is doubly mouthful.

Yeah, this is quite a mouthful indeed. I think the most conservative fix
would be something like:

  if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0)) {
    enum commit_graph_write_flags flags = 0;
    if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
      flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;

    if (write_commit_graph_reachable(the_repository->objects->odb,
                                     flags, NULL)) {
      /* ... */
    }
  }

and then ripping this knob out (as Junio suggests below, which I think
is a wise suggestion) out would be straightforward.

> I wonder how much value we are getting by having this call here in
> the first place.  This function being cmd_commit(), by definition we
> won't be updating the graph file unless the test script does "git
> commit".  We won't update the graph file upon "git rebase", "git
> merge", "git pull", "git fetch", etc., so it is not like with this
> hack, the test coverage for various traversal using the graph file
> would magically be perfect.  We'd still need an explicit call to
> "commit-graph write" at strategic places in the test scripts, no?

Yeah. It's definitely not a silver bullet for the reasons you mention,
but I think that it is helping out in some common cases. For example,
if we moved this check out to 'test_commit', then we'd be relying on
tests to use that instead of 'git commit'. On the other hand, this
catches either, since they both wind up in this builtin.

I guess you could push this check down much further to when we're about
to write a new object, and--if that new object is a commit--update the
commit-graph. That sounds awfully slow (and feels to me like a hack, but
I can't justify whether it's more or less of a hack than we already
have), but I think it would be OK, since this isn't the normal way to
run tests.

> How are we testing with and without bitmaps, and do we have a kludge
> like this one for the feature, or do we use a different mechanism
> to help writing tests easier to gain better coverage?

As far as I know after a brief search, we have no similar such mechanism
for bitmaps, so commit-graphs are a unique instance.

> In any case, I can see why we want a separate knob specific to the
> CHANGED_PATHS until the path filter part becomes as stable as the
> rest of the graph file, but after some time, we should remove that
> knob, and at that point, we always use the path filter whenever we
> use commit-graph, so that we won't have to suffer from the ugliness.
>
> Wait.  I wonder if we can tweak the arrangement a bit so that this
> layer does not need to know any more than GIT_TEST_COMMIT_GRAPH?
>
> For example, in commit-graph.c::write_commit_graph(), can we test
> the CHANGED_PATHS environment variable and flip the .changed_paths
> bit, no matter what the 'flags' argument to the function says?

It may be cleaner to have 'GIT_TEST_COMMIT_GRAPH' specify the flags that
it wants as its value, but the additional coupling makes me somewhat
uncomfortable.

> Thanks.
>
> >  		return 1;
> >
> >  	repo_rerere(the_repository, 0);

Thanks,
Taylor

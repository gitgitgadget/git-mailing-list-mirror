Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAA4C433E0
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 22:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2BC4205CB
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 22:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="yQ7RNZmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgFCWO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 18:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgFCWO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 18:14:56 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5485BC08C5C0
        for <git@vger.kernel.org>; Wed,  3 Jun 2020 15:14:56 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j1so2254173pfe.4
        for <git@vger.kernel.org>; Wed, 03 Jun 2020 15:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t/JsiJmTANBHw8h8bJdZlSxnqvBPRVoQI52g8IDRe/Y=;
        b=yQ7RNZmx1HbDt/5C0lebXaBad2qyGCzPzHBUpWJFd8UT+vLJsqbzGy+2NENsP/Yx8j
         2aIVuEFf/08IWHu+XszKkRF4IziY6TzhU9tubFmupkRW2MTMIG26I2E+Ivl2iJDv4Q6D
         KK9ur2bZh+L/txC2kVbADZ6YCc4YRSypc/m9A288eodP6W4qRLKP5mjoEv3JwsbcmvdY
         oAiVc5iPK3jvD0q3jBBFB/PlbqlnMdo2Fno7fbRltwpuzj9OQgXOl4qn/a9Zp4kHHrno
         oj0jATJY54r8bVawskiq202MyAm7zXE7KX4uGCxnlyjxC8NdzCvHYaI/qo/CX+Zhx1Dz
         pufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t/JsiJmTANBHw8h8bJdZlSxnqvBPRVoQI52g8IDRe/Y=;
        b=ZeLlOmCVEI7E3vJDwLO7ntoEU4YMekBlLqvIQgyQqLOw8qTSMV6IrDaI+QI5qAgNyS
         F9d3lygaNPzkufjChPNxLGf0ZJgqU2/4YIT11Urj8luNBmwJgKs1Fj3uv94Fxdj6BLAk
         zAqAr1j2KWVKih5H5tARIXRS/FsFQDByAmW9cNjOk2dzX1sTCCpnUo3/y5yYUwDbVMmL
         riIC5Jx6KXYBfSozVbihmgS1lPdLhwTuuHfm3J+CPs7fLG2TS9MevAYJbKJIfsvXyf71
         BqqBvs4gOXzvqewQSFOMgbit769HVmPK0DKy4zzmt3o/mx50TP6SBqdLTFQDkH+QeHaq
         DOwg==
X-Gm-Message-State: AOAM532zqQp8D8ciComkjiJXjpQ05aM24kpfyTYgxU7tYYpQifvdyLVZ
        tcTR6wk578hWURQGfFxpVXKYd+1KfbI=
X-Google-Smtp-Source: ABdhPJwmZzR9OqQpkd7TIBI5ovaiTYMmTRp6Rv3jNC2Yk3Aldz+EgXm0weozEvRmJKlbckllvB/psw==
X-Received: by 2002:a62:1b87:: with SMTP id b129mr1201629pfb.162.1591222495677;
        Wed, 03 Jun 2020 15:14:55 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id g65sm2646789pfb.61.2020.06.03.15.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 15:14:54 -0700 (PDT)
Date:   Wed, 3 Jun 2020 16:14:53 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jonathantanmy@google.com, gitster@pobox.com, newren@gmail.com,
        Jay Conrod <jayconrod@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 2/2] shallow.c: use '{commit,rollback}_shallow_file'
Message-ID: <20200603221453.GA36237@syl.local>
References: <20200423001438.GC19100@syl.local>
 <cover.1587601501.git.me@ttaylorr.com>
 <296e70790d7a391d471554b0bc5a58e2a091ce88.1587601501.git.me@ttaylorr.com>
 <20200603034213.GB253041@google.com>
 <20200603045248.GA20266@syl.local>
 <20200603051631.GA20678@syl.local>
 <20200603205151.GC253041@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200603205151.GC253041@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 03, 2020 at 01:51:51PM -0700, Jonathan Nieder wrote:
> Taylor Blau wrote:
>
> > Ah, this only sort of has to do with the object cache. In
> > 'parse_commit_buffer()' we stop parsing parents in the case that the
> > repository is shallow (this goes back to 7f3140cd23 (git repack: keep
> > commits hidden by a graft, 2009-07-23)).
>
> Ah, good analysis.  (In fact, the behavior is older: it's from
> 5da5c8f4cf4 (Teach parse_commit_buffer about grafting., 2005-07-30).)
> So this is additional "cached" data that needs to be invalidated by
> reset_repository_shallow.
>
> So the question is, what other information falls into that category?
>
> [...]
> > --- a/shallow.c
> > +++ b/shallow.c
> > @@ -90,6 +90,9 @@ static void reset_repository_shallow(struct repository *r)
> >  {
> >  	r->parsed_objects->is_shallow = -1;
> >  	stat_validity_clear(r->parsed_objects->shallow_stat);
> > +
>
> (nit: the above two lines wouldn't be needed if r->parsed_objects is
> being thrown away.)

Right, thanks. I don't think that it matters since you point out a
legitimate issue with dangling references, but serves me right for
working on this so late at night ;-).

> > +	parsed_object_pool_clear(r->parsed_objects);
> > +	r->parsed_objects = parsed_object_pool_new();
> >  }
>
> Shallows don't affect the ref store.  They only affect object walks.
> So r->parsed_objects does seem like the only place that could be
> affected.
>
> That said, with this change I'd worry about use-after-free from any
> existing references to objects in the pool.
>
> Stepping back, what I think I would like to see is to *not* have
> grafts and shallow state affect the in-memory persisted parsed
> objects.  Instead, act as an overlay in accessors that traverse over
> them.
>
> Lacking that, I like the idea of a "dirty bit" that gets written as
> soon as we have started lying in the parsed object pool.  Something
> like this.  What do you think?
>
> diff --git i/commit-graph.c w/commit-graph.c
> index 2ff042fbf4f..84b49ce903b 100644
> --- i/commit-graph.c
> +++ w/commit-graph.c
> @@ -149,7 +149,8 @@ static int commit_graph_compatible(struct repository *r)
>  	}
>
>  	prepare_commit_graft(r);
> -	if (r->parsed_objects && r->parsed_objects->grafts_nr)
> +	if (r->parsed_objects &&
> +	    (r->parsed_objects->grafts_nr || r->parsed_objects->substituted_parent))

This is a little tricky. Why would we set substituted_parent without
also incrementing grafts_nr? That seems like the real bug here: if we
incremented grafts_nr, then we would return a non-zero value from
'commit_graph_compatible' and rightly stop even without this sticky-bit.

I don't quite understand this myself. If it's an oversight, it's a
remarkably long-lived one. Do you have a better sense of this?

>  		return 0;
>  	if (is_repository_shallow(r))
>  		return 0;
> diff --git i/commit.c w/commit.c
> index 87686a7055b..762f09e53ae 100644
> --- i/commit.c
> +++ w/commit.c
> @@ -423,6 +423,8 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
>  	pptr = &item->parents;
>
>  	graft = lookup_commit_graft(r, &item->object.oid);
> +	if (graft)
> +		r->parsed_objects->substituted_parent = 1;
>  	while (bufptr + parent_entry_len < tail && !memcmp(bufptr, "parent ", 7)) {
>  		struct commit *new_parent;
>
> @@ -447,6 +449,7 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
>  	if (graft) {
>  		int i;
>  		struct commit *new_parent;
> +

Nit: unnecessary whitespace change, but I doubt it really matters much.

>  		for (i = 0; i < graft->nr_parent; i++) {
>  			new_parent = lookup_commit(r,
>  						   &graft->parent[i]);
> diff --git i/object.h w/object.h
> index b22328b8383..db02fdcd6b2 100644
> --- i/object.h
> +++ w/object.h
> @@ -26,6 +26,7 @@ struct parsed_object_pool {
>  	char *alternate_shallow_file;
>
>  	int commit_graft_prepared;
> +	int substituted_parent;
>
>  	struct buffer_slab *buffer_slab;
>  };
>
> Thanks,
> Jonathan

Thanks,
Taylor

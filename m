Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C357C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49A9B205ED
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Ycby8nob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgEMVce (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 17:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728711AbgEMVcd (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 17:32:33 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BC5C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:32:33 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b12so316856plz.13
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YbLdiZFTzBOnZrZyh36Xj2ZXnSxqGPxKBmrZ+xSO2Fs=;
        b=Ycby8nobz+ONGXL3//D+1fKTcqlpE0MGg0ONNDSo06BhtB4lKoshWeKGm/iR/PteMy
         6iYunazszBrPxyod6JcNH4kiaQ9LLkO4DBlWNFocd65EOPSGlA203Sd2XT3dSJ2fbSmu
         PZDXDSGpjSRqR8p5DnCu6fw9N0HJbn/F4mcLZf0ySUJWZFPDBHxJzCtpnJQrcSyf2F/9
         pKwnrYHkFiI3R/Mtp3xLwrn7s7rEl4YxuU60OrpoZPF18UttThd2YQDQ0gtcfODXHs2w
         FKPMjJkCRHqxCfhQ2YJnZIIsiB4jDHZjEh5nR1vpaBlMyiCIkUoTupmvcNo5vSofMeZS
         yo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YbLdiZFTzBOnZrZyh36Xj2ZXnSxqGPxKBmrZ+xSO2Fs=;
        b=K30QiWmrM2dqytR1q32RY2th7qw9h/pVzuZ9HWa/IPhF+YWTN8eSsmiP5R+vW9q/1+
         Rz7GHRAjVMp3IyvogAFk6nUDql6sGl7yDC+jXOpxYsuedD0CX64OX5xMdOL2JqAQHh6R
         cFNPskVMuyx5V7chFrxWFSYwyy/o0o+Tv5NNliqdhaHck5+yLvFnpEJBv+i9RjZugXOY
         01Im0c2l6BTn6+KOBVd7ZE7+9618r9CpkmEfLvQ81muDhSExVoCoMzdELCUhJxe1JNMB
         LI5MQSq5+7VTyzBrvlSYURE3H0DMoYZ8lTDtGKp20RsgsUTUx+l7Ytnl1wZZ6+tSN9dP
         esTA==
X-Gm-Message-State: AOAM530QiqigzNLP8RrQ/9CoppzV61ifWmuIKMw0bAhew+QpLvcxy6O+
        ePwwwvwit9oU56whw7DbUSYotQ==
X-Google-Smtp-Source: ABdhPJwnUOhIciV19xXHGBth6GUrljP453CE5cCOx9HPl4caZCjywR9T5UshPL0qx7lk1R6zYz9SRA==
X-Received: by 2002:a17:90a:4d4a:: with SMTP id l10mr11233290pjh.0.1589405551503;
        Wed, 13 May 2020 14:32:31 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id x4sm435176pff.67.2020.05.13.14.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:32:30 -0700 (PDT)
Date:   Wed, 13 May 2020 15:32:28 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, szeder.dev@gmail.com
Subject: Re: [PATCH 8/8] commit-graph: drop COMMIT_GRAPH_WRITE_CHECK_OIDS flag
Message-ID: <20200513213228.GC24173@syl.local>
References: <cover.1588641176.git.me@ttaylorr.com>
 <6c2d130b0cd4b6a8a541b362ae7dd44d4c282e3f.1588641176.git.me@ttaylorr.com>
 <20200507204005.GE29683@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200507204005.GE29683@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 07, 2020 at 04:40:05PM -0400, Jeff King wrote:
> On Mon, May 04, 2020 at 07:14:03PM -0600, Taylor Blau wrote:
>
> > If callers do wish to retain this behavior, they can easily work around
> > this change by doing the following:
> >
> >     git for-each-ref --format='%(objectname) %(objecttype) %(*objecttype)' |
> >     awk '/commit/ { print $1 }' |
> >     git commit-graph write --stdin-commits
>
> I know this came from my earlier email, but I think that recipe actually
> shows how to make your input work even if --check-oids were the default.
> If you really want the --check-oids behavior, you'd want the opposite:
> to complain about those ones. So it's something like:
>
>      git for-each-ref --format='%(objectname) %(objecttype) %(*objecttype)' |
>      awk '
>        !/commit/ { print "not-a-commit:"$1 }
>         /commit/ { print $1 }
>      ' |
>      git commit-graph write --stdin-commits
>
> > diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> > index 53a650225a..fcac7d12e1 100644
> > --- a/Documentation/git-commit-graph.txt
> > +++ b/Documentation/git-commit-graph.txt
> > @@ -47,8 +47,10 @@ with `--stdin-commits` or `--reachable`.)
> >  +
> >  With the `--stdin-commits` option, generate the new commit graph by
> >  walking commits starting at the commits specified in stdin as a list
> > -of OIDs in hex, one OID per line. (Cannot be combined with
> > -`--stdin-packs` or `--reachable`.)
> > +of OIDs in hex, one OID per line. OIDs that resolve to non-commits
> > +(either directly, or by peeling tags) are silently ignored. OIDs that
> > +are malformed, or do not exist generate an error. (Cannot be combined
> > +with `--stdin-packs` or `--reachable`.)
>
> Yeah, I think these semantics are good.
>
> > diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> > index 9eec68572f..3637d079fb 100644
> > --- a/builtin/commit-graph.c
> > +++ b/builtin/commit-graph.c
> > @@ -153,13 +153,14 @@ static int read_one_commit(struct oidset *commits, struct progress *progress,
> >
> >  	display_progress(progress, oidset_size(commits) + 1);
> >
> > +	if (oid_object_info(the_repository, &oid, NULL) < 0) {
> > +		error(_("object %s does not exist"), hash);
> > +		return 1;
> > +	}
> > +
> >  	result = lookup_commit_reference_gently(the_repository, &oid, 1);
> >  	if (result)
> >  		oidset_insert(commits, &result->object.oid);
> > -	else {
> > -		error(_("invalid commit object id: %s"), hash);
> > -		return 1;
> > -	}
> >  	return 0;
> >  }
>
> We can avoid the object-existence check entirely if
> lookup_commit_reference_gently() gives us an answer. And we'd expect
> that to be the common path.
>
> Also, using has_object_file() is cheaper than oid_object_info(), since
> it doesn't have to resolve the type for deltas.
>
> So perhaps:
>
>   result = lookup_commit_reference_gently(...);
>   if (result)
>           oidset_insert(...);
>   else if (has_object_file(&oid))
>           ; /* not a commit; quietly ignore;
>   else
>           return error(no such object...);
>
> That said, I think this technique misses some cases of corruption.
> You're checking that the outer-most object exists, but not any
> intermediate peeled objects. I.e., lookup_commit_reference_gently()
> might have failed for two reasons:
>
>   - an object it peeled to didn't exist
>
>   - an object it peeled to wasn't a commit
>
> To do it thoroughly, I think you'd have to call deref_tag() yourself and
> distinguish NULL there (an error) from a result where obj->type isn't
> OBJ_COMMIT (quietly ignore).

Makes sense. I initially worried a little bit about what to call the
error message (i.e., is is "this object doesn't exist" or "this object
exists but peels to a non-commit, or an otherwise missing object"). But,
I think just saying "invalid object: <hash>" is good enough here.

> >  enum commit_graph_write_flags {
> > -	COMMIT_GRAPH_WRITE_APPEND     = (1 << 0),
> > -	COMMIT_GRAPH_WRITE_PROGRESS   = (1 << 1),
> > -	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2),
> > -	/* Make sure that each OID in the input is a valid commit OID. */
> > -	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3),
> > -	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4),
> > +	COMMIT_GRAPH_WRITE_APPEND        = (1 << 0),
> > +	COMMIT_GRAPH_WRITE_PROGRESS      = (1 << 1),
> > +	COMMIT_GRAPH_WRITE_SPLIT         = (1 << 2),
> > +	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 3)
>
> As much as I love looking at matched-indentation lists, I think this
> diff is a good example of why it's not worth doing. It's much easier to
> see what's going on if the first three items aren't touched. I'd
> actually even leave BLOOM_FILTERS where it is, and accept the hole which
> could be refilled later.
>
> Your patch also loses the trailing comma after the final BLOOM_FILTERS
> entry.

Fixed both, thanks. I'll build these eight new patches and send them
shortly, thanks for your review.

> -Peff

Thanks,
Taylor

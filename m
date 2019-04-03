Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47A0620248
	for <e@80x24.org>; Wed,  3 Apr 2019 20:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfDCU5w (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 16:57:52 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:57250 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCU5w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 16:57:52 -0400
Received: by mail-oi1-f201.google.com with SMTP id j202so94220oih.23
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 13:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xqF+oAFHaWzO4jsWpAECh3/jahycuzRdzTxIjdTodJk=;
        b=ksLntaVAxxIJ1SY1xmbvcQsOf38//jJ709clvrB32Ty16DODiZmQOydZ9/buMeI9ne
         GdJ0NHADIq7cQNuI1WQ1+uHEsZM6qohrJY4Q3mmrI5sFQylw22d8mhRcIfNs3LLL6Q48
         aidl+H5ErhQrUBWe4hoLB/QKUAlJlfFnK/Vw9eSjTf/gLxhIf/sbwZDzRUYfoFQaiYiv
         FRdSYEpCl9nqoaEYmUC/p4oIIrVx/hwNvMDKfXLy3CatDZakdAQkWoZZTTC5hA6/0Jnb
         lNfxYL5oxL8HmIiEAydWZUBKJgbFMzVmRBwTXWEcfH30F35P1qbjNeTknZg7ts38ELap
         TaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xqF+oAFHaWzO4jsWpAECh3/jahycuzRdzTxIjdTodJk=;
        b=a9fkFzUFFG30mb7pZ7bjXA+obvFaYUyE4s6g1Gze2LqwBcXIi2v96xKmcOVKuawBBl
         /unDaUTaQM+U69wP2KGhaA6veWPXccNZJzgRrZPC3eijoqRsgmQdjtdI47dVc70GVjFj
         2R8nkJjniT3H7yvssSxhubx3+DzA6Z2CkatIeGwfA1GMihHvVVyN5aU9G7vN7743GQ0I
         4JzIGurhe/9DARhlPNQqcFxotUpdGl43FsG7Dnxa+cOCbsc10cDEujcaC3X99yL9Shth
         KI3XLFGDdfhDmKrPj0odIq9HiribqDD7M+PEgxIcdxJgrFu1r8aLaxEiLE1+mzfxsOeH
         AbHw==
X-Gm-Message-State: APjAAAWriDlS2duOGo+mBgn8mFJr4IFnaC8jptXUiDrghjq8pqtIbwpQ
        8bSi7XTMrNHSKQXRCJVasxOGq7+CN1z1bxCh3QQ0
X-Google-Smtp-Source: APXvYqw0n0ExbU+rvLl14Q4b++4jfZpcN+z6WJ0Rlo2pRg1Rm8cQQj2lIojZvswWF/JLRhpXsSMFn4TLY4tihWheGSVa
X-Received: by 2002:a05:6830:1381:: with SMTP id d1mr189857otq.4.1554325071878;
 Wed, 03 Apr 2019 13:57:51 -0700 (PDT)
Date:   Wed,  3 Apr 2019 13:57:48 -0700
In-Reply-To: <20190403194150.GA27199@sigill.intra.peff.net>
Message-Id: <20190403205748.107979-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190403194150.GA27199@sigill.intra.peff.net>
X-Mailer: git-send-email 2.21.0.197.gd478713db0
Subject: Re: [PATCH] clone: do faster object check for partial clones
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     steadmon@google.com, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, Apr 03, 2019 at 10:27:21AM -0700, Josh Steadmon wrote:
> 
> > For partial clones, doing a full connectivity check is wasteful; we skip
> > promisor objects (which, for a partial clone, is all known objects), and
> > excluding them all from the connectivity check can take a significant
> > amount of time on large repos.
> > 
> > At most, we want to make sure that we get the objects referred to by any
> > wanted refs. For partial clones, just check that these objects were
> > transferred.
> 
> This isn't strictly true, since we could get objects from elsewhere via
> --shared or --reference. Those might not be promisor objects.

I don't think local clones (which --shared or --reference implies) can
be partial, but the bigger point is below.

> Shouldn't we be able to stop a traversal as soon as we see that an
> object is in a promisor pack?
> 
> I.e., here:
> 
> > +	if (opt->check_refs_only) {
> > +		/*
> > +		 * For partial clones, we don't want to walk the full commit
> > +		 * graph because we're skipping promisor objects anyway. We
> > +		 * should just check that objects referenced by wanted refs were
> > +		 * transferred.
> > +		 */
> > +		do {
> > +			if (!repo_has_object_file(the_repository, &oid))
> > +				return 1;
> > +		} while (!fn(cb_data, &oid));
> > +		return 0;
> > +	}
> 
> for each object where you ask "do we have this?" we could, for the same
> cost, ask "do we have this in a promisor pack?". And the answer would be
> yes for each in a partial clone.
> 
> But that would also cleanly handle --shared, etc, that I mentioned. And
> more importantly, it would _also_ work on fetches. If I fetch from you
> and get a promisor pack, then there is no point in me enumerating every
> tree you sent. As long as you gave me a tip tree, then you have promised
> that you'd give me all the others if I ask.
> 
> So it seems like this should be a feature of the child rev-list, to stop
> walking the graph at any object that is in a promisor pack.

We currently already do a less optimal version of this - we pass
--exclude-promisor-objects to rev-list, which indeed stops traversal at
any promisor objects (whether in a promisor pack or referenced by one).
As far as I know, the problem is that to do so, we currently enumerate
all the objects in all promisor packs, and all objects that those
objects reference (which means we inflate them too) - so that we have an
oidset that we can check objects against.

A partial solution is for is_promisor_object() to first check if the
given object is in a promisor pack, avoiding generating the set of
promisor objects until necessary. This would work in a blob:none clone
with the refs pointing all to commits or all to blobs, but would not
work in a tree:none clone (or maybe, in this case, the clone would be
small enough that performance is not a concern, hmm).

Maybe the ideal solution is for rev-list to check if an object is in a
promisor pack and if --exclude-promisor-objects is active, we do not
follow any outgoing links.

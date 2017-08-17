Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D76720899
	for <e@80x24.org>; Thu, 17 Aug 2017 17:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753367AbdHQR44 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 13:56:56 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33821 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753283AbdHQR4z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 13:56:55 -0400
Received: by mail-pg0-f50.google.com with SMTP id u185so47448567pgb.1
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 10:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YKJ193IGyAaUWK9frPDO0SxqpakOUlJfSeg6qOY7I48=;
        b=YqRcgl2MTn2EMyQPQO3z3CuA9CqWsOzXCrYEBsI4Kx7bnZM1DnoGWzhJU47xbomSWy
         atBwAZJjxHvlVrh5CsOAFf8854GTh8THjI/89DF4M+vYE2ch4vU2CuhPynmAbiVtiJ+a
         VwPQWk0CN96ECKO+jYpTV28mdMpEmQLN+vNBbEU1FN/U0T9oK/fJdzKrc+6cIU76McxC
         AJu4UF7GJCLC0HuCyIsTUy6AEClZ9amGHZqIzknAeLi3LNmWEyn2F8UHk+gm9p6H8QtW
         ZaxlZtCe5JKcqtLY2ZDTL8U61tcyA2gxne94iEODsQcr6sjTK8i4VhejZSG5X6Ei1ejs
         MiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YKJ193IGyAaUWK9frPDO0SxqpakOUlJfSeg6qOY7I48=;
        b=RXrMNcZ8jizIKx1vMLOfNnib+zLSk6LE3puhsGk1FFCf5eO5HhvqJiY1aYWOdcmtwC
         YF57aYJTNhyZQhkQ3PMcbgZ24e1jRj2yxBAoyqYtoUdfhLdVwIEkPHgWV7q9n/iXBq3O
         VdHyJKIwjInw+xL9ouqF6aHcMA0pxa6xo/l5mVNtyvdKFC7wUJFVMQa30IHgBvmw1YH6
         sW/7CA7veW2gJIb2gTDf5SyLxmwKgg+d9jg9JzMnDDWC8WKBY6psnIqvkeu8vR85Zbe2
         O0Y6RA+i+ivjHep40dKtpnjPmnboBIFm+6THqJwtU0gil+eE7a/hrvQYGkteic3bGErm
         M4pg==
X-Gm-Message-State: AHYfb5jcDrBWvLlEU7jvHJMke1LIQp4U6rZ6gyWEv55xRiyewl3EWXa9
        qIYckZBjVhZFepsv
X-Received: by 10.99.177.15 with SMTP id r15mr6057076pgf.106.1502992614664;
        Thu, 17 Aug 2017 10:56:54 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:dc1f:8c2d:b088:2ecf])
        by smtp.gmail.com with ESMTPSA id x2sm8465237pfe.129.2017.08.17.10.56.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 17 Aug 2017 10:56:53 -0700 (PDT)
Date:   Thu, 17 Aug 2017 10:56:52 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>, s@kazlauskas.me,
        git@vger.kernel.org
Subject: Re: [PATCH] files-backend: cheapen refname_available check when
 locking refs
Message-ID: <20170817175652.GB109680@google.com>
References: <20170709112932.njac5m6jmgmjywoz@sigill.intra.peff.net>
 <4e81f1ecf190082d3415d96650014841cd4c5b19.1502982012.git.mhagger@alum.mit.edu>
 <20170817152240.coioktoqfkcvxldj@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170817152240.coioktoqfkcvxldj@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/17, Jeff King wrote:
> On Thu, Aug 17, 2017 at 05:12:50PM +0200, Michael Haggerty wrote:
> 
> > I was testing this using the reporter's recipe (but fetching from a
> > local clone), and found the following surprising timing numbers:
> > 
> > b05855b5bc (before the slowdown): 22.7 s
> > 524a9fdb51 (immediately after the slowdown): 13 minutes
> > 4e81f1ecf1 (after this fix): 14.5 s
> > 
> > The fact that the fetch is now significantly *faster* than before the
> > slowdown seems not to have anything to do with the reference code.
> 
> I bisected this (with some hackery, since the commits in the middle all
> take 13 minutes to run). The other speedup is indeed unrelated, and is
> due to Brandon's aacc5c1a81 (submodule: refactor logic to determine
> changed submodules, 2017-05-01).
> 
> The commit message doesn't mention performance (it's mostly about code
> reduction). I think the speedup comes from using
> diff_tree_combined_merge() instead of manually diffing each commit
> against its parents. But I didn't do further timings to verify that (I'm
> reporting it here mostly as an interesting curiosity for submodule
> folks).

Haha always great to see an unintended improvement in performance!  Yeah
that commit was mostly about removing duplicate code but I'm glad that
it ended up being a benefit to perf too.

> 
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index e9b95592b6..f2a420c611 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -631,11 +631,11 @@ static int lock_raw_ref(struct files_ref_store *refs,
> >  
> >  		/*
> >  		 * If the ref did not exist and we are creating it,
> > -		 * make sure there is no existing ref that conflicts
> > -		 * with refname:
> > +		 * make sure there is no existing packed ref that
> > +		 * conflicts with refname:
> >  		 */
> >  		if (refs_verify_refname_available(
> > -				    &refs->base, refname,
> > +				    refs->packed_ref_store, refname,
> >  				    extras, skip, err))
> >  			goto error_return;
> >  	}
> 
> This seems too easy to be true. :) But I think it matches what we were
> doing before 524a9fdb51 (so it's correct), and the performance numbers
> don't lie.
> 
> -Peff

-- 
Brandon Williams

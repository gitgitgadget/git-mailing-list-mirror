Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C105C433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 21:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 407F620758
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 21:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Fk2PQb3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIBVD2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 17:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBVD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 17:03:27 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21431C061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 14:03:27 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id h1so288986qvo.9
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 14:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sbkx2C04j1NdLoMplAo8M+XiW4ZEFyosjLjVUCqmZCU=;
        b=Fk2PQb3g2Ks8R16x5siRgs9A7NNVoKmsTQ7KmfuxgDkEJDgM3+49JULC7S56uyNTry
         jNBzUZUTp4wlLm4klFnqSBWMkgsCMRD8tmmvY/wcdHu6kpot8QgHRD5h0Q6EvzFxHS9y
         CmlOyHRsMbYsjikFxs/qlHzcgIfSuTbvqv6wy4F2WCWKit/bEM30cWmJmkpW82WcOBBX
         1xtLw0+SwxNpEkp0OXV3Jg9JLtawpaL9EVJXb6uMHYL1mDZrbUYS6V0OOugx09sDcMkS
         q1z2kEji6SOyN0hYKxDJ/wHwNA07yUH+xXb51VMgnLwrWHLg3yjoCIsHU28es2+jgq5U
         d+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sbkx2C04j1NdLoMplAo8M+XiW4ZEFyosjLjVUCqmZCU=;
        b=BBAlhZsSLRNTAT17ije4tN1nPmYNoPtGHzsyLmpgnD4oBJawnDsXSLmx/dduO5pADT
         Fr3p4gpEVSroAMGD+5t6wscnn3dd8uDbpYx7GZl+Fqld5d8ABj1vRVi3L4cEV475Mg5F
         p9/dhyVYo/3KCjvo7YEKyAKt+pYbp00BoDXMFM5JNn1iY3oxiVHCi+aLNoN5QdoSJ32Q
         VWbuzblr1IyR7QBmwUvO2BhxmFhTMjxxdtNpJKv4e5XPzSbxRdG1/UR5oLQrVOPWAoKT
         WUAPIs1NLoDnyO5LmPAKP+herh0bOmT+ilSCLUtSDrbHJzjiR/SjHOnxQl1LZSd8oyrn
         8ZoA==
X-Gm-Message-State: AOAM531gn8Je05/f6RJbXuvueb29I4JF+6W5H3UoIvGyGe9LCMa/5nDe
        kKdvUGqylOKZEwqUxWf1p217Qw==
X-Google-Smtp-Source: ABdhPJy+PbEU1Z3ihJkR794/Iw7kUFibvRscwNXiQRO3IPokueynxkUuKdbW6ZpOM3hFhYHjibsJ8g==
X-Received: by 2002:ad4:458e:: with SMTP id x14mr8666307qvu.111.1599080606302;
        Wed, 02 Sep 2020 14:03:26 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:945e:14e0:5690:8262])
        by smtp.gmail.com with ESMTPSA id j8sm452642qth.90.2020.09.02.14.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 14:03:25 -0700 (PDT)
Date:   Wed, 2 Sep 2020 17:03:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v3 14/14] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200902210322.GD5281@nand.local>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <09f6871f66bff838c067a3e0d23cd4622171f3bd.1597178915.git.me@ttaylorr.com>
 <20200812114929.GA19082@szeder.dev>
 <20200814202021.GE30103@syl.lan>
 <20200817225004.GB29528@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200817225004.GB29528@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 18, 2020 at 12:50:04AM +0200, SZEDER Gábor wrote:
> On Fri, Aug 14, 2020 at 04:20:21PM -0400, Taylor Blau wrote:
> > > > @@ -1486,10 +1499,15 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
> > > >  		ctx->order_by_pack ? commit_pos_cmp : commit_gen_cmp,
> > > >  		&ctx->commits);
> > > >
> > > > +	max_new_filters = ctx->opts->max_new_filters >= 0 ?
> > > > +		ctx->opts->max_new_filters : ctx->commits.nr;
> > >
> > > git_test_write_commit_graph_or_die() invokes
> > > write_commit_graph_reachable() with opts=0x0, so 'ctx->opts' is NULL,
> > > and we get segfault.  This breaks a lot of tests when run with
> > > GIT_TEST_COMMIT_GRAPH=1 GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1.
> >
> > Great catch, thanks. Fixing this is as simple as adding 'ctx->opts &&'
> > right before we dereference 'ctx->opts', since setting this variable
> > equal to 'ctx->commits.nr' is the right thing to do in that case.
>
> That would avoid the segfault, sure, but I would rather see all
> callers of write_commit_graph{_reachable}() passing a valid opts
> instance.  Just like we don't call the diff machinery with a NULL
> diff_options, or the revision walking machinery with a NULL rev_info.

I wouldn't mind that either, but this is definitely a common pattern
throughout the commit-graph machinery. So, if/when we do get away from
it, I'd rather do so uniformly than in some spots.

> > Unrelated to this comment, I am hoping to send out a final version of
> > this series sometime next week so that we can keep moving forward with
> > Bloom filter improvements.
> >
> > Have you had a chance to review the rest of the patches? I'll happily
> > wait until you have had a chance to do so before sending v5 so that we
>
> v5?  This is v3, and I'm unable to a find a v4.

Sorry, I clearly had too much on my mind when I was writing this ;). I'm
hopeful that with your careful review that v4 will be the last of this
topic.

Thanks,
Taylor

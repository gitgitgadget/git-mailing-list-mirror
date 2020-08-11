Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854C9C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6116220756
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="sT6IFhFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgHKVe6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKVe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 17:34:58 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106F4C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 14:34:58 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b14so287763qkn.4
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 14:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2eEDOHntIMoI3O5Dh9BrmmuviRy+93I7QtS70W1cmDw=;
        b=sT6IFhFqMKknqplvYZA5H89n9wMh6eTZF/s/edG3NIWO+WcZc+Oqtz44kVWLDPFjkW
         wsGtAMZ75RnPlfpUPjEnkm6KQ1YR+ytiQyHyI9PNOX1+SAqNHmke2jr7f3iKig3mIEzB
         R1+mCPdtqMJsPKLrPEY5YMAy3emhxAbJVxbMulzur4I8ODmrAQeX2OGZVPrKD1/sW8Ah
         XoYMINApFRUYoORjiUAob0QmvU03akLCWtdPX5EL5SFTlKgOh/apBuJluOGz7XOsId0M
         evS4XOmNBaJ+dwJQbGqPhUzSu1Grgyu1+8b3VMNHscQZBblx23gC/anfrRGzlkugGlLC
         m7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2eEDOHntIMoI3O5Dh9BrmmuviRy+93I7QtS70W1cmDw=;
        b=azab6D/S8h1jeTklBMNJkKLp4x1tt/cXggQh8fzlZCPpLFWZK53IvRZYDAKJyuxsu0
         05Is8JTq5WwTpXdgWGKWinU5/vhUaHYgZNLr0C05F05fR3uCnnTnsAgUEMFIwPk2unFx
         QtbpTt8CQtjEaI9Qd7K1nH7xQXncxrEwUoJBJdqNVcDN7KW2apUCj9NGcQn/NyN5Otx5
         gFj3GyR6ipErrPhH7gTW8JmMske/RlbVG8GHVKOo7txUDgkJA+hnfnl/rIyCZsI++4mZ
         q/SAwUhGp9TFhjDcnt+UCGCLlUDs8lBkqWV66sMOXA6Iu7B+LRTW3yg7klPxxlXP4BsJ
         Uxcw==
X-Gm-Message-State: AOAM5336xnhN0K1JMw7kufew4Uods2OFzAz8ximwoRNqSmFOdm/bDt+2
        QNxA8+BtiTdmO2imHScsg+87MQ==
X-Google-Smtp-Source: ABdhPJyyd6LF95cDH6QlIBbM/mVQ0TfWTpVoi6BOj4UyPBvgFHM0AprzZLCE3uJ8UMmmqTrdlXNBLw==
X-Received: by 2002:ae9:e8ca:: with SMTP id a193mr3147646qkg.6.1597181697228;
        Tue, 11 Aug 2020 14:34:57 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id g4sm123782qka.25.2020.08.11.14.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 14:34:33 -0700 (PDT)
Date:   Tue, 11 Aug 2020 17:34:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v3 01/14] commit-graph: introduce
 'get_bloom_filter_settings()'
Message-ID: <20200811213411.GB66656@syl.lan>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <e714e54240bb339d1ecebcea157b734abf1c14ef.1597178915.git.me@ttaylorr.com>
 <20200811211830.GS2898@szeder.dev>
 <20200811212118.GA66447@syl.lan>
 <20200811212716.GA13422@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200811212716.GA13422@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 11:27:16PM +0200, SZEDER Gábor wrote:
> On Tue, Aug 11, 2020 at 05:21:18PM -0400, Taylor Blau wrote:
> > On Tue, Aug 11, 2020 at 11:18:30PM +0200, SZEDER Gábor wrote:
> > > On Tue, Aug 11, 2020 at 04:51:19PM -0400, Taylor Blau wrote:
> > > > Many places in the code often need a pointer to the commit-graph's
> > > > 'struct bloom_filter_settings', in which case they often take the value
> > > > from the top-most commit-graph.
> > > >
> > > > In the non-split case, this works as expected. In the split case,
> > > > however, things get a little tricky. Not all layers in a chain of
> > > > incremental commit-graphs are required to themselves have Bloom data,
> > > > and so whether or not some part of the code uses Bloom filters depends
> > > > entirely on whether or not the top-most level of the commit-graph chain
> > > > has Bloom filters.
> > > >
> > > > This has been the behavior since Bloom filters were introduced, and has
> > > > been codified into the tests since a759bfa9ee (t4216: add end to end
> > > > tests for git log with Bloom filters, 2020-04-06). In fact, t4216.130
> > > > requires that Bloom filters are not used in exactly the case described
> > > > earlier.
> > > >
> > > > There is no reason that this needs to be the case, since it is perfectly
> > > > valid for commits in an earlier layer to have Bloom filters when commits
> > > > in a newer layer do not.
> > > >
> > > > Since Bloom settings are guaranteed to be the same for any layer in a
> > > > chain that has Bloom data,
> > >
> > > Is it?  Where is that guaranteed?
> >
> > There is no mechanism whatsoever to customize these settings that is
> > exposed to the user (except for the undocumented 'GIT_TEST' environment
> > variables).
>
> Let me rephrase it, then: where is it written in the commit-graph
> format specification that these must be the same in all layers?
>
> Nowhere.

OK. We can certainly document that this is the case. For this purpose,
all we really care about is that the graph _has_ Bloom filters anywhere.
If you wanted to return the exact matching settings, you could also
provide a commit and return the settings belonging to the graph that
contains that commit.

In the case where we don't have a commit, we could use the default
settings instead.

I think that we are a little bit dealing with a problem that doesn't
exist, since we do not document the sole method by which you would
change these settings. So, maybe we can think more about this, but my
preference would be to leave this patch alone.

Maybe Stolee can chime in, too.

> > > > it is sufficient to traverse the
> > > > '->base_graph' pointer until either (1) a non-null 'struct
> > > > bloom_filter_settings *' is found, or (2) until we are at the root of
> > > > the commit-graph chain.
> > > >
> > > > Introduce a 'get_bloom_filter_settings()' function that does just this,
> > > > and use it instead of purely dereferencing the top-most graph's
> > > > '->bloom_filter_settings' pointer.
> > > >
> > > > While we're at it, add an additional test in t5324 to guard against code
> > > > in the commit-graph writing machinery that doesn't correctly handle a
> > > > NULL 'struct bloom_filter *'.
> > > >
> > > > Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
> > > > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > Thanks,
> > Taylor
Thanks,
Taylor

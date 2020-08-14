Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE67EC433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BF9B20774
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="fz/dQs3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgHNURf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgHNURf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 16:17:35 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE439C061385
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:17:34 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id m7so9470609qki.12
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Tmisk5cHnOAn9bTBW7QI9M4AXgdB2rO1w0vLBpU1Ph4=;
        b=fz/dQs3BH3HXoWdvkhLWPw2J4i3aWmmvROA2opV7n7pxLSCwb24IVm81TUt0M7bXr9
         ukFUVwL8PfZiBtKrmqBaGA+HaTI70mBjP6QFcUPDxEOD4u8uwmRh3mE2TJDr2jTpQ6M+
         eQMboOQzuzkgCVrYgF0cSqYp19u67mFzMqXVQXSi+dlNDi6XEoaA4MrA8I2PESooGv4l
         fMV6pfejFroDmNRjXJzSv0Pf7ZQjPAD1MX2fPfIWy3cFApMElVrEX02KjtHql/V1bcrQ
         1wEXMdMNlbAJMxXtk7qSz/qcqVxYxUSJHslN1ig4WGrw7q0z3aHf2o12pAUFQfoDfs0a
         tWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Tmisk5cHnOAn9bTBW7QI9M4AXgdB2rO1w0vLBpU1Ph4=;
        b=Vn9pWMInoSifZYbRHGrLn7JdfB3QMckN0RKXaIhZ0RFIAzizWVsqjz6uM/5HWlD1gi
         qXO0dg/8hpYQaSOH/EH6QXvhhvhzcsumtSw/A0U5F5QWV7s9LLnfjAVxtXolagrc8YLJ
         /NPSntXcY4GooyRhLKyyYgzNT2gy72RM1RJQ7l5Lls4XY4MaXEoJVxuU+54RkFgxvwv6
         ktv/gqxCwSvu3UX9D2y5Wn+dKCc93FNh9lrIQnzeIJSgyjqOoJ/Mvh8SRnTb4G52nuQp
         AF+Fgk6SxOFsELrk6Ycq3HnpP+URVUlNg/dClPVU1yhaZuivjNwepAXqhbNaVaLmvouc
         z8LQ==
X-Gm-Message-State: AOAM530sYNfRNpLLigNLwoJ2+08djm95Kn35I63TkucaZgPnQ+lref6k
        8qQaUsPw8Q0+yLZHniaVloxqIw==
X-Google-Smtp-Source: ABdhPJwj55l4pLEQCt0RD+CywnvddPGuHgLdwc7q+kBqu7IYXaYaiSRtJRbP0yu+Wt0Q/p93eAGe/w==
X-Received: by 2002:a37:5d3:: with SMTP id 202mr3536641qkf.498.1597436254025;
        Fri, 14 Aug 2020 13:17:34 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3009:7f9d:1da1:7877])
        by smtp.gmail.com with ESMTPSA id l45sm11540717qtf.11.2020.08.14.13.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 13:17:33 -0700 (PDT)
Date:   Fri, 14 Aug 2020 16:17:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v3 01/14] commit-graph: introduce
 'get_bloom_filter_settings()'
Message-ID: <20200814201732.GD30103@syl.lan>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <e714e54240bb339d1ecebcea157b734abf1c14ef.1597178915.git.me@ttaylorr.com>
 <20200811211830.GS2898@szeder.dev>
 <20200811212118.GA66447@syl.lan>
 <20200811212716.GA13422@szeder.dev>
 <20200811213411.GB66656@syl.lan>
 <20200811235537.GC13422@szeder.dev>
 <d525c35e-12fb-1918-c02b-d0323ee9b664@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d525c35e-12fb-1918-c02b-d0323ee9b664@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 07:48:55AM -0400, Derrick Stolee wrote:
> On 8/11/2020 7:55 PM, SZEDER Gábor wrote:
> > On Tue, Aug 11, 2020 at 05:34:11PM -0400, Taylor Blau wrote:
> >> On Tue, Aug 11, 2020 at 11:27:16PM +0200, SZEDER Gábor wrote:
> >>> On Tue, Aug 11, 2020 at 05:21:18PM -0400, Taylor Blau wrote:
> >>>> On Tue, Aug 11, 2020 at 11:18:30PM +0200, SZEDER Gábor wrote:
> >>>>> On Tue, Aug 11, 2020 at 04:51:19PM -0400, Taylor Blau wrote:
> >>>>>> Many places in the code often need a pointer to the commit-graph's
> >>>>>> 'struct bloom_filter_settings', in which case they often take the value
> >>>>>> from the top-most commit-graph.
> >>>>>>
> >>>>>> In the non-split case, this works as expected. In the split case,
> >>>>>> however, things get a little tricky. Not all layers in a chain of
> >>>>>> incremental commit-graphs are required to themselves have Bloom data,
> >>>>>> and so whether or not some part of the code uses Bloom filters depends
> >>>>>> entirely on whether or not the top-most level of the commit-graph chain
> >>>>>> has Bloom filters.
> >>>>>>
> >>>>>> This has been the behavior since Bloom filters were introduced, and has
> >>>>>> been codified into the tests since a759bfa9ee (t4216: add end to end
> >>>>>> tests for git log with Bloom filters, 2020-04-06). In fact, t4216.130
> >>>>>> requires that Bloom filters are not used in exactly the case described
> >>>>>> earlier.
> >>>>>>
> >>>>>> There is no reason that this needs to be the case, since it is perfectly
> >>>>>> valid for commits in an earlier layer to have Bloom filters when commits
> >>>>>> in a newer layer do not.
> >>>>>>
> >>>>>> Since Bloom settings are guaranteed to be the same for any layer in a
> >>>>>> chain that has Bloom data,
> >>>>>
> >>>>> Is it?  Where is that guaranteed?
>
> Perhaps instead of "guaranteed" we could say "Git never writes
> a commit-graph chain with different settings between layers."
>
> >>>> There is no mechanism whatsoever to customize these settings that is
> >>>> exposed to the user (except for the undocumented 'GIT_TEST' environment
> >>>> variables).
> >>>
> >>> Let me rephrase it, then: where is it written in the commit-graph
> >>> format specification that these must be the same in all layers?
> >>>
> >>> Nowhere.
> >>
> >> OK. We can certainly document that this is the case.
> >
> > IMO we absolutely must document this first; ideally it should have
> > been carefully considered and documented right from the start.
>
> You're right. One of the major difficulties in bringing a Bloom
> filter implementation to the commit-graph feature when we did was
> that the split commit-graph was introduced between our initial
> prototypes and when it was finally prepared for a full submission.
>
> There certainly are gaps in the implementation and documentation.
> I think Taylor is doing a great job by addressing one of those gaps
> in a focused, thoughtful way.
>
> > Some thougths about this:
> >
> >   https://public-inbox.org/git/20200619140230.GB22200@szeder.dev/
>
> I appreciate your attention to detail. Your comments on the existing
> implementation do point out some of its shortcomings, and that is a
> valuable contribution.
>
> Actually converting those thoughts into patches is a lot of work.
>
> >> For this purpose,
> >> all we really care about is that the graph _has_ Bloom filters anywhere.
> >> If you wanted to return the exact matching settings, you could also
> >> provide a commit and return the settings belonging to the graph that
> >> contains that commit.
> >>
> >> In the case where we don't have a commit, we could use the default
> >> settings instead.
> >>
> >> I think that we are a little bit dealing with a problem that doesn't
> >> exist, since we do not document the sole method by which you would
> >> change these settings. So, maybe we can think more about this, but my
> >> preference would be to leave this patch alone.
> >
> > Other implementations can write split commit-graphs with modified path
> > Bloom filters as well, and at the moment there is nothing in the specs
> > that tells them not to use different Bloom filter settings in
> > different layers.
>
> You are 100% correct that there is a gap in documentation. That should
> be corrected at some point. (I don't consider it a blocker for this
> series.)
>
> But also: Git itself is the true test of a "correct" third-party
> implementation. libgit2 and JGit try to match Git, "warts and all".
> If another implementation wrote data that results in incorrect
> behavior by Git, then that implementation is wrong.
>
> Improving documentation can make those errors less likely.

I agree with this reasoning. Would anybody object to moving forward with
this series without a change in documentation today (but rather down the
road)?

> We also must design with "future Git" in mind, presenting it with
> enough flexibility to improve formats. The custom Bloom filter
> settings do allow that flexibility, but the requirement that all
> layers have identical settings exists for a reason (despite not
> being documented). It is important that any commit walk that intends
> to use the changed-path Bloom filters can compute the bloom keys
> for the test paths only once.
>
> Thanks,
> -Stolee

Thanks,
Taylor

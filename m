Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840DFC433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 18:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3B7222BA
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 18:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Bx24jKMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbgJISiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 14:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730740AbgJIShz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 14:37:55 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C2CC0613D2
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 11:37:53 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x20so4589050qkn.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=imskBWmgMbIMeK/q9KqDnZdjDF1a4HNKpeAAP2G9OqQ=;
        b=Bx24jKMXSozTVvfsaSlRu/9hJrzWtwzWAclARlGOeC+weIvPSUNuBVSGKlit10K0bb
         lCRRNYmhLy+AlHCo3PI6XjULC8Q6A7ngNXWNacpf7nR/m5YVb4WklgCpT0aSaGE477gi
         hNTjhl9NjaScnOtuUGUupsaaftUUnNhXoK9N3YV3yISVCiYHpB8UWce+1DRm7vc7yEp3
         mOTvSA5FRPDKXOOFvJxkpe+rgrc+3UwEDECs2urSYPQ9Jdsxf5toA5OAgGgcq7IOBuWo
         IvpcS99Y/1gLkFWrLDdjyS0N0OK+ek2VC3TCSErqupZSWua4QTzAaCrBZy3AhODsxBwe
         QqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=imskBWmgMbIMeK/q9KqDnZdjDF1a4HNKpeAAP2G9OqQ=;
        b=eSjFQnuA4goe9i9s9d4+EDPigQDBQ1NGDnuiMxDS2AZDlYCg0RmRYmhMzB+lTkeXdW
         ZkTYi9VvBun6M0BsgEStMeFIDyClMJHAoTRdX5ETWcNqaBasYT5BmwbfoiyiC+CtzVB0
         H5Gq2+D4OPXqXO5tQHRueN+ZGdhZ0fQQ1iSj39YySMh4Q4IvF5nvy0MZyzxADdaygpEw
         4D0N9wyR2nC7hZPSDnNxjxvqKTIZe9pho190Df6XXJ235wRzn2oW5gic3V4WWAbiu3e/
         8+Q7+yV7TW2TtIcJFHlvNueHpoASbeqn8NwmdUt43Mpk35HqKXxpP4ejyRLvMyP78gqK
         Cqiw==
X-Gm-Message-State: AOAM532ZtYho/GtPZrgLYKQNQw+UOmG/oj0tkDnl3llk9KiVCLJG0NgF
        En5fid09BAnURquIF0zjbGEolA==
X-Google-Smtp-Source: ABdhPJz8UypVjPPAEqpbjDL+X++FH9+XQEzMt4S+QkRe0td70MmkhOPXTpK7CUSKyO+PxbjgFYaC3A==
X-Received: by 2002:a37:a68b:: with SMTP id p133mr13933909qke.272.1602268673038;
        Fri, 09 Oct 2020 11:37:53 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:b0d1:9fbe:54fa:3044])
        by smtp.gmail.com with ESMTPSA id p5sm5113222qtu.13.2020.10.09.11.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 11:37:52 -0700 (PDT)
Date:   Fri, 9 Oct 2020 14:37:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        GIT Mailing-list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: 2.29.0.rc0.windows.1: Duplicate commit id error message when
 fetching
Message-ID: <20201009183750.GA437683@nand.local>
References: <20201008120658.GA2689590@coredump.intra.peff.net>
 <52782500-274e-2c72-39e2-be4252959d47@gmail.com>
 <5bbdaed5-df29-8bfe-01c2-eb2462dcca22@gmail.com>
 <267a9f46-cce9-0bd3-f28d-55e71cc8a399@virtuell-zuhause.de>
 <0d25e0ab-31ab-54c2-b518-bd9c0b0c4b7a@gmail.com>
 <2f30099a-4a3d-00f7-bb08-ca6c1f76bcd4@virtuell-zuhause.de>
 <64de22fd-2e1b-aaab-3a8e-f6f1d630a46e@gmail.com>
 <20201009175506.GA957408@coredump.intra.peff.net>
 <20201009182833.GA437455@nand.local>
 <4c138121-ef58-c870-60b2-8140e6e0cbee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c138121-ef58-c870-60b2-8140e6e0cbee@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 09, 2020 at 02:33:02PM -0400, Derrick Stolee wrote:
> > Makes sense; the second commit-graph write won't know that 'one' is
> > already in the graph because 'core.commitGraph' prevents
> > 'prepare_commit_graph()' from actually loading the graph (actually
> > loading the graph would be enough to stop the second write from
> > occurring at all.)
>
> Right. We aren't parsing from the commit-graph, so we don't see
> that these commits are already in the file.

OK, I feel even better knowing that you and I both agree on the cause of
this buglet ;-).

This also makes me think that this has probably existed since the
beginning of commit-graphs, and that it only became easier to tickle in
recent releases with things like '--split=no-merge'.

> >   - But on the other hand, writing a commit graph with `core.commitGraph` set
> >     to false makes no sense. So, I'd almost rather have us die()
> >     immediately if core.commitGraph is set to false.
>
> I agree that we should just give up, but die() would not be correct.
> We should just "return 0", possibly with a warning.

Yeah; that sounds much better.

> > I think I'd advocate for the latter, along with Stolee's patch to not
> > die in the case of duplicate commits in multiple layers of the graph.
>
> If we agree that writing a commit-graph makes no sense if the feature
> is disabled, then I can include a patch that has a test similar to
> Peff's and that change.

Sounds good. I'm certainly on board, but I want to hear what others
think, too.

I thought that we had a configuration variable to control whether or not
we write changed-path Bloom filters, so I was going to ask about what we
should do if that was set to false, and the caller passed
'--changed-paths'. But, I guess that my memory was wrong, since I
couldn't find such a variable to begin with (we _do_ have
'commitGraph.readChangedPaths', but since that only controls reading no
additional special care has to be taken).

Thanks for working on this.

> Thanks,
> -Stolee

Thanks,
Taylor

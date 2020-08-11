Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678B5C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 308E520781
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFQQXHrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgHKVSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgHKVSe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 17:18:34 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DD3C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 14:18:33 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id g19so14623682ejc.9
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fdd+4Dkc6aMq4vfAN915IBkc2eVeDgeZAYFfFVgj7yE=;
        b=NFQQXHrCOwk7ykDuElhwiktVYmV3KaaoANX4Sos/NUR+sFrw6hu+dKOYoW5xksAlLW
         Xfh1BQx4qA/d1sru+KGL9j52UtWd4Wu4ipEkaF6RRmMKTWm/5S0xHmd7f+lvGu39Huj2
         /YdjFZyFzQVCTpK1CdY7Lurulnn+LUaUnBcLjqVSqfpk29qwvtyCBDx6cjvrO8ZhSKsY
         03TYfRuR8aS7YzOYT/cKxD38nvfKp/skp/360J6OxNFILtwVRjn+MYYFw2JYT0zptE96
         zKZMCLwiKf+6Y5zKA1fDOiWFAgXV9dssscMpaP/KybJ/Szys1D+ZG8GFXTBIyQN+km7/
         G1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fdd+4Dkc6aMq4vfAN915IBkc2eVeDgeZAYFfFVgj7yE=;
        b=JsByRHANrw+mlK0nmGHbODv69aM2wPWUbhGgOEblXpVlTOLy0QLuMMF21doi39g446
         cm67xx2XWxp3G2V30YIO68neAg5+MlLIeP1YMtlPukiiyPWcQw5U+RHqO1Ri2ZJ54TWE
         Zz78xsorog20cVx7Wnbg2NsG0q6Da5WyIcTXU970uunltaIdExINriIWqcT5mNQjJsTx
         I4Ru5r7GZCDTJ6XL1yq7nmH1/SuXBbbcHkBhl4bFl3FviKeatswUYo1lqbrez5h1o2R6
         JLw/V3N8s2PYKUoEsSMwGWhbhiBFTF94F1r1HbozYX1dwVx2+J11dgsieZU0QxOOjtH3
         gsnw==
X-Gm-Message-State: AOAM531zBrCXgNym4we9EzJPhR8y1k07M7LoDZRO84NYbAV5yqjsumM/
        a9hkuClWKooVxdGNVkBM/nAH5EVZ
X-Google-Smtp-Source: ABdhPJzDSh0pngoUIU9sgXYFJv299w2yTV+0SlEAS7bREZkja8qCxNqCDcSftkh82aLllJylIaVfnw==
X-Received: by 2002:a17:906:c29a:: with SMTP id r26mr27873930ejz.153.1597180712487;
        Tue, 11 Aug 2020 14:18:32 -0700 (PDT)
Received: from szeder.dev (94-21-37-143.pool.digikabel.hu. [94.21.37.143])
        by smtp.gmail.com with ESMTPSA id g27sm83995edf.57.2020.08.11.14.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2020 14:18:31 -0700 (PDT)
Date:   Tue, 11 Aug 2020 23:18:30 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com
Subject: Re: [PATCH v3 01/14] commit-graph: introduce
 'get_bloom_filter_settings()'
Message-ID: <20200811211830.GS2898@szeder.dev>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <e714e54240bb339d1ecebcea157b734abf1c14ef.1597178915.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e714e54240bb339d1ecebcea157b734abf1c14ef.1597178915.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 04:51:19PM -0400, Taylor Blau wrote:
> Many places in the code often need a pointer to the commit-graph's
> 'struct bloom_filter_settings', in which case they often take the value
> from the top-most commit-graph.
> 
> In the non-split case, this works as expected. In the split case,
> however, things get a little tricky. Not all layers in a chain of
> incremental commit-graphs are required to themselves have Bloom data,
> and so whether or not some part of the code uses Bloom filters depends
> entirely on whether or not the top-most level of the commit-graph chain
> has Bloom filters.
> 
> This has been the behavior since Bloom filters were introduced, and has
> been codified into the tests since a759bfa9ee (t4216: add end to end
> tests for git log with Bloom filters, 2020-04-06). In fact, t4216.130
> requires that Bloom filters are not used in exactly the case described
> earlier.
> 
> There is no reason that this needs to be the case, since it is perfectly
> valid for commits in an earlier layer to have Bloom filters when commits
> in a newer layer do not.
> 
> Since Bloom settings are guaranteed to be the same for any layer in a
> chain that has Bloom data,

Is it?  Where is that guaranteed?

> it is sufficient to traverse the
> '->base_graph' pointer until either (1) a non-null 'struct
> bloom_filter_settings *' is found, or (2) until we are at the root of
> the commit-graph chain.
> 
> Introduce a 'get_bloom_filter_settings()' function that does just this,
> and use it instead of purely dereferencing the top-most graph's
> '->bloom_filter_settings' pointer.
> 
> While we're at it, add an additional test in t5324 to guard against code
> in the commit-graph writing machinery that doesn't correctly handle a
> NULL 'struct bloom_filter *'.
> 
> Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>

Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76C8C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C22A206C3
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="iq2q487W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgHKVVW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgHKVVV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 17:21:21 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC83C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 14:21:21 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j187so211408qke.11
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=J7a+ySS9/VVAh7awNZlUn3dGHQxfGdLSCl7j6IcnbdI=;
        b=iq2q487WKejRh7mmcTvCqa2zddCY4RtNPGKDMPaWqS3LJYDC/G2kwZBQy1rzcJP9Al
         aSF0T2zkcCKH65q4Tv/bXqcUYyV1h9yWOCR1FSkEruo3ElMWRJ7cGzP5fE0lejYB7R1Z
         ndrZKhLilgRWY6yTbTFQ9EjlvWR5woqxEPJOvEekiNAiOXiuJ7FMTGE7/cLdtjEUNUqF
         qCVTammHoesiFvqnyWwFFEyUD66vpWF5queJV2GruNpg1xnMS7AYMOWBafc2Hju+vfIo
         PLsFsiBYhkUbCjmQ60/SnnAcGo+0hd18xBp1PbX1S8+FF96/HX9URIF5paPB+SaDofZi
         kzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=J7a+ySS9/VVAh7awNZlUn3dGHQxfGdLSCl7j6IcnbdI=;
        b=tKT9eED3LlsdhWoqiTL0XIapxH8YwVq9G8ppRYZdBnzg8uLElC7gzyR+Gq9hThpVnJ
         GvrlQ1lKLMgPUfGe+3qzuzYF1vN88iEybwiOE4B2ht5YQS57T7g9Kx5dXjXoOsp2xoe8
         G/P+j6uSzms6Yvot3I/igiHWj8gv9N/NmOtKOGjMbQH0lg2bY1pE7E/L8Ih61ri/L7V0
         kRRDfDI62luM19myf1Vp6GY5yz/MCUvzj0iztBAtaIpzuv9PW4Y672L4Vhd1jIrtltgF
         frSJD/A/RRnd2plj/UK2V2ALx6ZXSJjoK80Ej6JXHg9MDgWm5rR/NJh8hsSDoUqvxBy5
         l+qg==
X-Gm-Message-State: AOAM532zd8lNFGRzYNru+ewZWHpXUrBLTugb9PcazaPIGBEfUX4YeGMW
        LjzvobhJDtqN+Vh2TX3sCyBvwg==
X-Google-Smtp-Source: ABdhPJz5RuboJLZPeCMbrJyaSw56h1JnpzaLvWgW05lA9txq9lLI/Uzb7Ahcu3jJv+btFHeusb45zg==
X-Received: by 2002:a05:620a:123c:: with SMTP id v28mr2840774qkj.366.1597180880868;
        Tue, 11 Aug 2020 14:21:20 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id z197sm74189qkb.66.2020.08.11.14.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 14:21:19 -0700 (PDT)
Date:   Tue, 11 Aug 2020 17:21:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v3 01/14] commit-graph: introduce
 'get_bloom_filter_settings()'
Message-ID: <20200811212118.GA66447@syl.lan>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <e714e54240bb339d1ecebcea157b734abf1c14ef.1597178915.git.me@ttaylorr.com>
 <20200811211830.GS2898@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200811211830.GS2898@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 11:18:30PM +0200, SZEDER Gábor wrote:
> On Tue, Aug 11, 2020 at 04:51:19PM -0400, Taylor Blau wrote:
> > Many places in the code often need a pointer to the commit-graph's
> > 'struct bloom_filter_settings', in which case they often take the value
> > from the top-most commit-graph.
> >
> > In the non-split case, this works as expected. In the split case,
> > however, things get a little tricky. Not all layers in a chain of
> > incremental commit-graphs are required to themselves have Bloom data,
> > and so whether or not some part of the code uses Bloom filters depends
> > entirely on whether or not the top-most level of the commit-graph chain
> > has Bloom filters.
> >
> > This has been the behavior since Bloom filters were introduced, and has
> > been codified into the tests since a759bfa9ee (t4216: add end to end
> > tests for git log with Bloom filters, 2020-04-06). In fact, t4216.130
> > requires that Bloom filters are not used in exactly the case described
> > earlier.
> >
> > There is no reason that this needs to be the case, since it is perfectly
> > valid for commits in an earlier layer to have Bloom filters when commits
> > in a newer layer do not.
> >
> > Since Bloom settings are guaranteed to be the same for any layer in a
> > chain that has Bloom data,
>
> Is it?  Where is that guaranteed?

There is no mechanism whatsoever to customize these settings that is
exposed to the user (except for the undocumented 'GIT_TEST' environment
variables).

> > it is sufficient to traverse the
> > '->base_graph' pointer until either (1) a non-null 'struct
> > bloom_filter_settings *' is found, or (2) until we are at the root of
> > the commit-graph chain.
> >
> > Introduce a 'get_bloom_filter_settings()' function that does just this,
> > and use it instead of purely dereferencing the top-most graph's
> > '->bloom_filter_settings' pointer.
> >
> > While we're at it, add an additional test in t5324 to guard against code
> > in the commit-graph writing machinery that doesn't correctly handle a
> > NULL 'struct bloom_filter *'.
> >
> > Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
Thanks,
Taylor

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615D8C001DF
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 23:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjGZXch (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 19:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGZXcg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 19:32:36 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333772704
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 16:32:35 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-576a9507a9bso22474667b3.1
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 16:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690414354; x=1691019154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k2f9tSGKgL+cbsbbsm8jsHdZpWA6YGdnc8fddx5Vaoc=;
        b=LpQ710UY7gPFxwe1w5VeNAPA3/BQGmPY1yHLRaZf1AwaJuRuVrXKKFTU7q+2E3YboS
         WwA6Q2msp/CjuJvCQeJpP2zbdXBISBzzsLz0N9N3JWNXg8xoQDeXPxWJ2OgkX5C8aPao
         PaPKX4CoWH89lE/BV7XmZyj9nS5tACvr8bdNmyd01V8UH6Agug63MF4JSnNdwKNeASIz
         GwCKkQiPKJ/VCBIzkFRwW/dzGKNLQ+qwANuQqVF88wX7WInNk99vd9MBbxVXOgZOWo/E
         6r/NSOd+vTy6UaTTzMN5XrFccNJd1moXRm09lF+q8gsygezFwkxQFBelXartA0xdZ7/p
         C9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690414354; x=1691019154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2f9tSGKgL+cbsbbsm8jsHdZpWA6YGdnc8fddx5Vaoc=;
        b=JbxALSK0AQ0hYPkaaxx4wDwvI0GUIsKN46BFlM+GweSwosd0DOiiA1u4DQ6azH87jF
         n06E2BdWhVy+PVwwZ1cAIfpmL2lxqqG9eJyEgC5QS3M0MJnYtEart9eNEK9PiwKojlbm
         abRwBLc7plkyJ0I1ZZol1ZTuJtgXhgrDBAL8ntNqLDDz8g5wpxdqJAezFiB58IbhxErQ
         72RSU7a4Nk6moA1oehPe1O0uj1lFlImKxPN+Atx91D/Ash/K1EyAFJr/z99lRQG+EKbF
         cokD6/tVS58BU5JXple3sCgcYkKoR3ijtySlg9TDU6FlbkxOIn3+UvA9BmSqxFT8/0El
         7nJg==
X-Gm-Message-State: ABy/qLY7Oo39lpQS2wCiPw+tmMxbbyE+SGaV6woP8//A388gl5b6/vW6
        w+fYx3ElFN2BLi1Gxvz4wevGog==
X-Google-Smtp-Source: APBJJlGQBWMg76IY3Xc/GtBvJvryt6qsde7GJPZcYfB0K7osB19ITsEkGqrmONukmbowt0dh5NFwKw==
X-Received: by 2002:a0d:ccd4:0:b0:56c:f547:e058 with SMTP id o203-20020a0dccd4000000b0056cf547e058mr1468605ywd.18.1690414354416;
        Wed, 26 Jul 2023 16:32:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b185-20020a0dd9c2000000b005837fe8dbe8sm111011ywe.8.2023.07.26.16.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 16:32:34 -0700 (PDT)
Date:   Wed, 26 Jul 2023 19:32:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/4] commit-graph: new filter ver. that fixes murmur3
Message-ID: <ZMGtEdBmgKu5pWHP@nand.local>
References: <ZLgqbB2JG8+HPoHN@nand.local>
 <20230720212753.2008505-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720212753.2008505-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 20, 2023 at 02:27:53PM -0700, Jonathan Tan wrote:
> > I think the early checks would be more expensive, since in the worst
> > case you have to walk the entire tree, only to realize that you actually
> > wanted to compute a first-parent tree diff, meaning you have to
> > essentially repeat the whole walk over again. But for repositories that
> > have few or no commits whose Bloom filters need computing, I think it
> > would be significantly faster, since many of the sub-trees wouldn't need
> > to be visited again.
>
> So for repositories that need little-to-no recomputation of Bloom
> filters, your idea likely means that each tree needs to be read once,
> as compared to recomputing everything in which, I think, each tree needs
> to be read roughly twice (once when computing the Bloom filter for the
> commit that introduces it, and once for the commit that substitutes a
> different tree in place).
>
> I could change the text of the commit message to discuss this (instead
> of the blanket statement that it would be too hard), although I think
> that an implementation of this can be done after this patchset. What do
> you think?

Right, I think that a sizeable portion of repositories will need to
compute relatively few Bloom filters overall. If you feel strongly that
it shouldn't be included in this series, I could live with that since
this is all behind a configuration variable anyway.

I think at minimum we should call it out in the documentation, at least
until such functionality is implemented, since unsuspecting users/forge
operators may bump the filter version forward and be surprised when they
suddenly have to recompute every existing Bloom filter.

Thanks,
Taylor

Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13571C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 16:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB973208C3
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 16:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="gkJ7ivd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIRQcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 12:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgIRQcq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 12:32:46 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F994C0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 09:32:46 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id t138so6828434qka.0
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 09:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uOzwysu/ntLJD/rruDhiqt5laEyTRDjAZv0UAKvPiT0=;
        b=gkJ7ivd+EtEMGGcvF3yfkpmbmUGVSkI8rk+ih6BhTLgaSxvAuPxnEhw/ow2olQsROG
         ByM4Ol35YzeUphS6Y0eXhwNu5b8TXLFjHkBoXZKyvpzgmNRT0VUdWEswRBTE+IvyGCYY
         74EDEtxsCOsSghuDRSgXWjJwSVtwnwDmk/+TbUI9D3Lp0tNu083Cr0pVXJ/g2rKXy4am
         1IXHXtWXsFn1jk5MFhRaf7k/YqboaBzJFKGcD8bkTdOp4brDXgazit9iN5k3jpXeKnVg
         h5EojZPh4+ZlDtIdCsh5X3BdhGDn1grMxqsGXDXECEBLF5XENOzv3JqQ8g6OqhVscdbe
         4bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uOzwysu/ntLJD/rruDhiqt5laEyTRDjAZv0UAKvPiT0=;
        b=AKyrprcoKVpXQJPREGkYQ4OylMTmyYpKQ5IFeQmb7tzXPu0Nzf4W/GrCqSTp6mtxbm
         Ayg5+7kXkqHYKHR1a02ln4Gsxog/obHjefEoFrTVDFm18GgJ3eut2Ra9H+oWNyh331FP
         +9OGf1GNRhzKoomJxMs2BxKKMtE9eVax//p6j+gb9nKq1B7lkSFtFZOMqXiOrRe6NuLp
         FP2M4D7oMeutKRqCLQRKEjE9/aXXOh972SRwFc0psjVfwTQGWHj0GnNiqZpl2XkJ5xGD
         ZribtuVs+GUVrJTrntQ/ijVoiHTlpkVJ9cQOB8uSXV7cbnC6XfSPB9qvF4JmXlcr5fpi
         HaJQ==
X-Gm-Message-State: AOAM531qNaaotZUZizCk8+OgdbNKn23LWUcwHBfGFXi9e9RvtGL1pjcp
        iOJ521yTlSVehGH+r29kJMp5pQ==
X-Google-Smtp-Source: ABdhPJxZOzEUkvdYz8y1jkl51k/dBVs7PLBHCZ8GZickCvD/nyek5lA2s0ptR5eT9oUplGYPnZF1XQ==
X-Received: by 2002:a37:d207:: with SMTP id f7mr33767682qkj.302.1600446765370;
        Fri, 18 Sep 2020 09:32:45 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id s15sm2364507qke.134.2020.09.18.09.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 09:32:44 -0700 (PDT)
Date:   Fri, 18 Sep 2020 12:32:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net
Subject: Re: [PATCH v3 08/13] bloom: use provided 'struct
 bloom_filter_settings'
Message-ID: <20200918163242.GA138001@nand.local>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600397826.git.me@ttaylorr.com>
 <3745baf8ef8810fe8e6031d06d2f6b8d967ef13c.1600397826.git.me@ttaylorr.com>
 <20200918162740.GA25148@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200918162740.GA25148@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 06:27:40PM +0200, SZEDER Gábor wrote:
> On Thu, Sep 17, 2020 at 10:59:27PM -0400, Taylor Blau wrote:
> > When 'get_or_compute_bloom_filter()' needs to compute a Bloom filter
> > from scratch, it looks to the default 'struct bloom_filter_settings' in
> > order to determine the maximum number of changed paths, number of bits
> > per entry, and so on.
> >
> > All of these values have so far been constant, and so there was no need
> > to pass in a pointer from the caller (eg., the one that is stored in the
> > 'struct write_commit_graph_context').
> >
> > Start passing in a 'struct bloom_filter_settings *' instead of using the
> > default values to respect graph-specific settings (eg., in the case of
> > setting 'GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS').
>
> I think this description misses the most important aspect of this
> patch: it fixes, even if only partially, the half-broken fix in
> 0087a87ba8 (commit-graph: persist existence of changed-paths,
> 2020-07-01).

Could you suggest an amendment? I understand what you are saying below,
but I'm not sure how or if you want it incorporated into this patch.

If you feel this is critical to change (I have no opinion either way),
then I'm happy to send a re-roll once review has stabilized. When do you
plan on finishing your read-through of this v3?

Thanks,
Taylor

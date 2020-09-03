Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0671C43461
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 16:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C2F32072A
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 16:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="nG00kkT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgICQmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgICQm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 12:42:29 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AAFC061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 09:42:29 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 60so2380245qtc.9
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 09:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9WggixQvpSGFYxFgeeoUcHlOz8+Gvs2E9DnixlFhXDg=;
        b=nG00kkT2Jsmvf4tupdrCSeynb56CZGBHyfvqa4i6w8irTzkLtc+LiQ51uemHEwjLzG
         IVgTE8RTZpDHPRB9B/IgLpkzwOP74Y338wIQx+cE95lPW0tmrtwS52Ci6RuakMFFgXJC
         BKDPMiyEWcWHbgR35hKx4dyyDJKH6xyLQNXA5Zw/asHNxoo+Y+poMt9qgu8u8oE+unTI
         IN7ywiWO9twsReWDPeZ7o2bAIRJtxw/cxQIOSb6T4x7lkYvXWoWLhVgitk7kh/9xR3Ws
         GYoh42+9qcBqGDOhLDqmSuznCscjKBGmCXsTW6U/BvBsUGXzB7ug7S6B0XAg8AOMNG3o
         cIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9WggixQvpSGFYxFgeeoUcHlOz8+Gvs2E9DnixlFhXDg=;
        b=oTWnY/7xms0zAgU/+2DfK9qK+cXCbQFPHjMbBrv4YQXX60MnkExpwNjTwLmULipMrV
         ieHbzPe3r+ypWQfVxAZTFNj9WYNWdM9zbhaA/6lOcIRaQA7nZzydg0SGboS/Hy050hRj
         qURyyfjfAsvPZKdDFfvWZRxoaDJJTPMUd6wxVSX7RC5LrJOaprEHnmLkJ4NrQ/rQgIjx
         gS9OsPSLJgJ+lnNpNqHE6e+cFpdDOvu+AaXn5bJ969eDSIrc2tCXkHFthERXaWhaPfu9
         B0LZ2smDZUxMoSz2gV36jTr2CC/cIIznZWdCoTl6hVy3Qr7Wi2k+HX0+6hUaFdS3NmNs
         bR1g==
X-Gm-Message-State: AOAM533GllmLqrwIT4arDFj7dXG3Tt3olCyPhkfQvkGj+D56YhVyarQr
        5ACSCMetK2gZLB8O6Bp/Hr6OIg==
X-Google-Smtp-Source: ABdhPJwlXWw57iE4BgaFAZHzgIo835Yotj9llQ9zCnrQsDXRKkTelPVUVLZ7fM4V+aVOqqMCevmiyQ==
X-Received: by 2002:ac8:67ce:: with SMTP id r14mr4401616qtp.239.1599151348786;
        Thu, 03 Sep 2020 09:42:28 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a97c:6dae:76a4:c715])
        by smtp.gmail.com with ESMTPSA id c40sm2486010qtb.72.2020.09.03.09.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 09:42:28 -0700 (PDT)
Date:   Thu, 3 Sep 2020 12:42:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com
Subject: Re: [PATCH v3 14/14] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200903164225.GA7905@nand.local>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <09f6871f66bff838c067a3e0d23cd4622171f3bd.1597178915.git.me@ttaylorr.com>
 <20200819082021.GA5238@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200819082021.GA5238@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 19, 2020 at 10:20:21AM +0200, SZEDER Gábor wrote:
> On Tue, Aug 11, 2020 at 04:52:14PM -0400, Taylor Blau wrote:
> > Introduce a command-line flag and configuration variable to fill in the
> > 'max_new_filters' variable introduced by the previous patch.
> >
> > The command-line option '--max-new-filters' takes precedence over
> > 'commitGraph.maxNewFilters', which is the default value.
> > '--no-max-new-filters' can also be provided, which sets the value back
> > to '-1', indicating that an unlimited number of new Bloom filters may be
> > generated. (OPT_INTEGER only allows setting the '--no-' variant back to
> > '0', hence a custom callback was used instead).
>
> Forgot the most important thing: Why?  Please explain in the commit
> message why this option is necesary, what problems does it solve,
> how it is supposed to interact with other options and why so.

This is already explained in detail in the patch 'commit-graph: add
large-filters bitmap chunk', although there is an error in the quoted
part of your email (which I wrote) which refers the reader to the
previous patch. The patch I'm actually referring two is the
twice-previous patch.

I'll fix that locally before re-sending.

Thanks,
Taylor

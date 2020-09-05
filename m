Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E801AC43461
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 18:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A64A02078E
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 18:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="HBbS3+VX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgIESB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 14:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbgIESB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 14:01:27 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8D1C061244
        for <git@vger.kernel.org>; Sat,  5 Sep 2020 11:01:25 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z2so7169429qtv.12
        for <git@vger.kernel.org>; Sat, 05 Sep 2020 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WHwd4AMhrIBE6D0lhleBdYTkrQurYuQfkL88OQLvdEo=;
        b=HBbS3+VXfUFRMLTXXVJnvNA0em6tdS2LH2T2ioptnNUuFE6YA0v7K2KzekB+BqpEw5
         XkMJtqzSIUXLMrUgOFcQPekjWOkiYVtc1/Kecb5Fr2Sv1ECvSPQ/P8v9Z3QDob+Zt6Db
         I+1g0JPsBYuXdIaYGsxyvAoORuB7e1rbhhtPfQwqEI8AmitjzbKQTAilRiXpWQ8Azd7b
         VZmyz8jqvcnPgDPBAOrYc/thr+k24pCU/u+wab3thXfuJRjBUTI2cqoc4BZqC/fVI7/z
         uHcY1r+PHAzLCnvz//TG3Rzz+s9mldJWNI9rynOXCcMTZNI4jDLfkb3co8tDFScMiiip
         INcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WHwd4AMhrIBE6D0lhleBdYTkrQurYuQfkL88OQLvdEo=;
        b=iMLyWHans8MBSpCGX8HKSvnFW8rZ4kcg20IcBO+AOI9MtUmC6oKWNcK6FwxKclJzcz
         M5TM4WooXtO9UiyUphK/l6OlCwupnJJliVVKOJtbxbr8Oigp0sLvODDA6Ae/GXeZB7uT
         t23vOFV52mwcLnYLFkFnG1DNOrfFo/UevSZnPz66t5xXOixK8Wg0ehPB81mXQQKYTeb9
         Y9FBlV15jEFhybdsNo5abJko9EQYoaYOW9WQeCzMF6oVX21xFcky74Un22+H+riRkfcP
         m6eOAz3E6mF1HT0kueS0ykWg6hnPqSlE7jcWt+pq4GspKav1RPV8lSPI5/hw70Y1Jw1E
         IP2Q==
X-Gm-Message-State: AOAM533E8Te+ua1unQeukpcWNXQoKy3Jjb6alrwbZPnBQhoR5UzSYWMx
        0FUtqFLSo03/QPKYg9OK6L9R+g==
X-Google-Smtp-Source: ABdhPJyLqV1J+0SeaL31qjCMWDSSrKEh4ofg28lrIbTUGKtHZOOrX1bFxQWWAtG9Bo61pxH58njUOQ==
X-Received: by 2002:ac8:3713:: with SMTP id o19mr12022766qtb.256.1599328884409;
        Sat, 05 Sep 2020 11:01:24 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:f423:2c6a:683a:2c57])
        by smtp.gmail.com with ESMTPSA id k6sm7365753qti.23.2020.09.05.11.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 11:01:23 -0700 (PDT)
Date:   Sat, 5 Sep 2020 14:01:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 07/14] bloom: split 'get_bloom_filter()' in two
Message-ID: <20200905180120.GB6820@nand.local>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1599172907.git.me@ttaylorr.com>
 <ba89a0cb837abc5fadbaa9514169636d85ee50cf.1599172908.git.me@ttaylorr.com>
 <85h7sc9m0v.fsf@gmail.com>
 <20200905173825.GA6820@nand.local>
 <CANQwDwcWveN03h=Ex0GFo-Mm89UT8_HXFMQcZWdDx9MPZYYodQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANQwDwcWveN03h=Ex0GFo-Mm89UT8_HXFMQcZWdDx9MPZYYodQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 05, 2020 at 07:50:01PM +0200, Jakub Narębski wrote:
> Hello,
>
> On Sat, 5 Sep 2020 at 19:38, Taylor Blau <me@ttaylorr.com> wrote:
> > Right, once we get handed back a filter from
> > 'get_or_compute_bloom_filter()', we can't distinguish between (a) a
> > commit with too many changes to store in a single Bloom filter, and (b)
> > a commit with no changes at all.
>
> We could change how we store either no-changes Bloom filter (as all
> zeros minimal size filter), or too-many-changes Bloom filter (as all
> ones, i.e. max unsigned value, minimal size filter). This change would
> not require to change any user of Bloom filter.

I don't think that's true. Say that we changed the empty Bloom filter to
be encoded as only having the most-significant bit set. First, we'd have
to write a Bloom filter where we didn't have to before. But the real
issue is that commit-graph files generated with new clients would
suddenly be unreadable by old clients.
>
> > It's unfortunate that callers can't pick between the two, but this
> > implementation is actually an improvement on the status-quo! Why?
> > Because right now we'll see an "empty" Bloom filter and recompute it
> > because it's "missing", only to discover that it has no changes.
> >
> > With this patch, we'll say "this filter looks too large", and stop
> > computing it, because we have already gone through the effort to compute
> > it once (and marked it in the BFXL chunk).
>
> Can we use this when computing trace2 values?

We could, but I don't think it's absolutely necessary. The test coverage
in t4216 gives us enough confidence already.

> [...]
> > > This is a minor issue, though.
> >
> > Thanks for raising it. I don't think that this is a show-stopper for
> > this series.
>
> I agree.

Thanks for your input!

> Best,
> --
> Jakub Narębski

Thanks,
Taylor

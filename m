Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B214C433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 12:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A02233F8
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 12:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbhAMMOG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 07:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbhAMMOG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 07:14:06 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01E3C061786
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 04:13:25 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b8so980191plx.0
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 04:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JPCRDkejd/Ycs25iVI01Hr/knS5eqgRQ17kbZodhgg8=;
        b=s4w8tWMtoz+zgTAvBgbNq76nHuhrg6jKSb0yApJ49yuGR4UArhXngtZ9hn76H2Hr7+
         LvQfsS0KIYgLjaK0M8gsAB8uAgDNjbLsP61J/LKHJ+8ML04zMiugQIAnkvM57SdAMiGQ
         SECB9rCp1PDwYBGXjHzz2T7cWm3xBH4JtWL04ye0i6XXnA1AfJWnEUtQc4woRfgFeuKj
         djot6X4BHYp0BgA3nMDWbDcrm5gg9xA5O/SBAQTEV//mpi3MM70dOn/xNRTbcWr9TlDm
         dCRygQfgEANY1x01mqpxJP75spOx5hq9+FEHAPKGQCvGwnTV9FCErZKLMbiEWI4DeBLw
         EQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JPCRDkejd/Ycs25iVI01Hr/knS5eqgRQ17kbZodhgg8=;
        b=PDcjDQA9zfnFsrcT+np4MepmW0L5Ie4XqwP0QMSsRGvg+rGEzVLXfozK7NJPzfFDRt
         5um7VrfRDNDClifRIYoFtZ9de39U4Cbk9wYi0BvbdqkIfw4dywAc4TpBv2f7B7mEl0UO
         ANWInP/UvjTVF4rvLgTwC+amOZyJCqudQ7CJfqa2cg0ANayqxZDm7CHelJRb9TSiljo4
         rKTvOJMKv1r55PGyqww052GNPvp0hgDamK6kKN5t94euSs2xBQt3Ya0+pl86qdNkllwQ
         cdSWNB6GKE89ycTcS/tsCOX82157EtrGC0h/zSeHxL5LNA3XEs30UwFFf9T3z5QEPCF3
         DWdw==
X-Gm-Message-State: AOAM531dixEUk7fz2aRWAt9/QBGN6VZunls+oALYG7alHu563r6n069A
        4VVSs8TWvOvlYxp2Ltd6Tg0BESxBPjHLEg==
X-Google-Smtp-Source: ABdhPJzCBPyoOIhGs0kCcp2sigxB0ixtZYYaLalxqI4YJM63Ak+iRKMDvg1Vnb5n/LoRncAf08t5FQ==
X-Received: by 2002:a17:90a:4817:: with SMTP id a23mr2125704pjh.16.1610540005616;
        Wed, 13 Jan 2021 04:13:25 -0800 (PST)
Received: from localhost ([2402:800:63a8:f5bb:2516:717f:2f37:c4c0])
        by smtp.gmail.com with ESMTPSA id iq3sm2521021pjb.57.2021.01.13.04.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 04:13:25 -0800 (PST)
Date:   Wed, 13 Jan 2021 19:13:23 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: test-tool: bloom: generate_filter for multiple string?
Message-ID: <X/7j4w22s3gEbm2R@danh.dev>
References: <20201231035438.22533-1-congdanhqx@gmail.com>
 <X/3+PG2hi71tj/UA@nand.local>
 <X/7guF05a/Bb/VNp@danh.dev>
 <31aec25c-07ef-b3b7-2759-494ad47bcfb1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31aec25c-07ef-b3b7-2759-494ad47bcfb1@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-01-13 07:06:59-0500, Derrick Stolee <stolee@gmail.com> wrote:
> On 1/13/2021 6:59 AM, Đoàn Trần Công Danh wrote:
> > On 2021-01-12 14:53:32-0500, Taylor Blau <me@ttaylorr.com> wrote:
> >> On Thu, Dec 31, 2020 at 10:54:38AM +0700, Đoàn Trần Công Danh wrote:
> >>> I'm reading the code for Bloom Filter to see if arXiv:2012.00472
> >>> could be an improvement.
> >>
> >> I'm late to the party, but I'm curious to hear which part of this
> >> article you think would help out the Bloom filter implementation.
> > 
> > Uhm, no. The article doesn't help the Bloom filter implementation.
> > The article was suggesting using Bloom filter to speed-up the
> > negotiation in fetch-pack and upload-pack. Which, in my own quick
> > experience, doesn't help much. Maybe it's me not understand the
> > article idea or I have made a naive implementation. However, I'm not
> > convinced to pursued further.
> 
> I saw that idea, and was immediately skeptical. Bloom filters still
> have size linear to the size of the set. By using a Bloom filter to
> describe "these are ALL the objects I have" instead of "these are
> the TIPS I have" the size will explode to be much larger than our
> current negotiation algorithm.

Yes, I saw that problem, too.

My implementation was trying to use it from the second round,
downstream will say: these are ALL the objects I have from our common
objects.

The result is not much different, though.

Thanks,

-- 
Danh

Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB323C43461
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 18:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92FFA2074D
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 18:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="eInlc5Mk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgIESjB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 14:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbgIESi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 14:38:59 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB67C061244
        for <git@vger.kernel.org>; Sat,  5 Sep 2020 11:38:58 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id c6so1461876qvj.1
        for <git@vger.kernel.org>; Sat, 05 Sep 2020 11:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=trtPQeHhrOklnRnHLue2H7fQCCVf1MQ2P4Qzf3+YyCg=;
        b=eInlc5Mk11JIjvjj2LjB/GJ68EJDYYwWS79rWERhNW6IlAaS+z2tWb78fvs663fdDi
         lp7uohatsl40N2IxK68EkmbHzAfz4sepz0fAy4ohUGVzGZsLZKbGs1Uu9Cuq9PIdL6jR
         eiZxXwa9yIXX+6Z5v8DW+VG8CmHkKvFcq2QAB1X9Qv9bPkffykmHazdxL4hc0+os8Tzv
         JT6laTcQ+INe6y2luJSR7YiL3dpHpLcShFeq3+9IhESNV6YbYsgyMvTdsw2hQINggGHR
         xw/SWxrKBlUP3EErx0zIT1N76jFsQ6mynkG2hHdUhzJXQfn/RWsoHJOi63LAwdd7bVRq
         N3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=trtPQeHhrOklnRnHLue2H7fQCCVf1MQ2P4Qzf3+YyCg=;
        b=G+4YFSoS3zJ+O/4eczd+XQWY2sc9zYEmtz2wU1BtThd/MnWVDvdXuAsBt6a6nlRy92
         xFbBmHA9Cw81YUICgrhfPF9sYRS4YWpd2ofV8UFvx/i6YIggMqfoR8hTqixnK596Le1q
         RH3+F7v4vOBoD6giXgrKCZXsBhaJIehob9rxbGz3qBoMCw3SkzJnTfI2LHAjYKHDvdTB
         fJIHHl/sue+HiQcZuOP2KdKte8iRw6ZCMc6rLa4jVDd4n0mHwELadYv7JBS5/Q6i2JCl
         hl/3xmHyHsEUb6zQU3cLuwR5AtcBzVb26O7hc/JHYuflx84VDksx0/mqZR/Ts8CNwtU3
         CQEQ==
X-Gm-Message-State: AOAM533cqer19K/2+948+HAoAT2xFFuo9GmjFJOHGe3tMwjIzIaWDlN0
        7uC5usLLzZOrn/Omml5F8QzY9fz1qPMhzfUP
X-Google-Smtp-Source: ABdhPJzx32aU2gQRmGwK+3tUstt460k2h7DDiaEcB8fNa2jdR4rsP/OU+2Ik08Vrj3+6t8BWKYRwkg==
X-Received: by 2002:a0c:b38a:: with SMTP id t10mr13438721qve.94.1599331137398;
        Sat, 05 Sep 2020 11:38:57 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:f423:2c6a:683a:2c57])
        by smtp.gmail.com with ESMTPSA id u15sm7674618qtj.3.2020.09.05.11.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 11:38:56 -0700 (PDT)
Date:   Sat, 5 Sep 2020 14:38:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>,
        Junio Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 07/14] bloom: split 'get_bloom_filter()' in two
Message-ID: <20200905183854.GC6820@nand.local>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1599172907.git.me@ttaylorr.com>
 <ba89a0cb837abc5fadbaa9514169636d85ee50cf.1599172908.git.me@ttaylorr.com>
 <85h7sc9m0v.fsf@gmail.com>
 <20200905173825.GA6820@nand.local>
 <CANQwDwcWveN03h=Ex0GFo-Mm89UT8_HXFMQcZWdDx9MPZYYodQ@mail.gmail.com>
 <20200905180120.GB6820@nand.local>
 <CANQwDwcD5XD3e7ar=8HPupobOZGDN4bgQJBS1Ad1m2NDx8eurw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANQwDwcD5XD3e7ar=8HPupobOZGDN4bgQJBS1Ad1m2NDx8eurw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 05, 2020 at 08:18:40PM +0200, Jakub Narębski wrote:
> Hello,
>
> On Sat, 5 Sep 2020 at 20:01, Taylor Blau <me@ttaylorr.com> wrote:
> > But the real issue is that commit-graph files generated with new
> > clients would suddenly be unreadable by old clients.
>
> Actually it is, at least in the form that I have proposed. The Bloom filter
> which has all bits set to zero would for every possible path reply that
> the path is not in set. Old clients would therefore work without changes.
> Therefore this is good representation of no-changes Bloom filter.
>
> The Bloom filter which has all bits set to one would for every possible
> path reply that the path is maybe in set. This is a good alternative
> representation of too-many-changes Bloom filter. Again, old clients
> would work without changes.

That's a very interesting thought. To be honest, I'm not crazy about
generating our own Bloom filters that have special meaning (i.e., that
even though they are interpreted the same way as any other filter, they
are specially-crafted to carry a certain meaning). Your proposal also
means that commit-graph files are going to get bigger, which is
something that you may or may not care about.

On the other hand, it does get rid of the BFXL chunk, which certainly
isn't the most elegant thing.

I don't know. I think my biggest objection is the size: we use the BIDX
chunk today to avoid having to write the length-zero Bloom filters; your
scheme would force us to write every filter. On the other hand, we could
continue to avoid writing length-zero filters, so long as the
commit-graph indicates that it knows this optimization.

Stolee: what do you think?

> Best,
> --
> Jakub Narębski

Thanks,
Taylor

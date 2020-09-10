Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C01C10DAA
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 02:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41C720BED
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 02:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="jzxzU32y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbgIJCVF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbgIJCT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 22:19:26 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621F7C0613ED
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 19:19:26 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id c18so3688244qtw.5
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 19:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kH2tXNdPtC8T39S5x2hHfWQxWd2uks8TXP1gMlmTETc=;
        b=jzxzU32yy/YMDtI2TCKm2ecqwvfr2uLQHGmcwidmu1x8W/apNn6xMrZpqWsE8kGHYY
         ZVYPDU+wblv0rvAe50mSTne5CcDkIt6gYZzynLxVSIx+O1SIikGvbNHObB+rRxeVAPY5
         VGrlRFo+30XkhBOzbsgRjvvYyNUij2POu65JrqiIxlJz6I3f6CJF2rU8N9zODWU43jfh
         2/0ZIJbRckZTgzo+pT+LdVSgcu6Xzc0BkRK90SvCO6V82JtGErb1GCKBZIxugscMjUnf
         03IEgexISVeUS57+naGrvG7yQOZqd72YiBLhar6Q7HyqKLkDFghINwuEH/YLX6g2amzM
         FohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kH2tXNdPtC8T39S5x2hHfWQxWd2uks8TXP1gMlmTETc=;
        b=F52NdAJXOLXBZQHGntEeSa1YKtpyAkyFCTX7Ihg1d10Fr2qUrQaCNUTxZPxBaq17+9
         Gg3lE7UpxFf+iCkMza7fUTPrFtHKROhF6A2LBNeiRAuzahJMRg4AtRXLpjYzjiZZW79w
         McBHuFjknIN4p6rVcQmNcwVbsTL9vHeg4d/GBLo5+JrBSJrdC+3GDNonxpafAqmEJc/w
         A1OA+/eM27vx48PIBqH8oSNCxZbA8xhqVJXpFgcnU3rcBJ5Da5zwcJXWdrW7BMGDCUv+
         m/PftOXTvA1Ym7PfNZbihfEFzhHgUVpHZkcV12JfhtDpcML+Nax2W7RwOOJwlG4q0t3q
         s4RQ==
X-Gm-Message-State: AOAM5338Rycrx1BJ4YovFUYCJjFLZVoSuBriKbRVHstBTlMgzgxGA3J0
        fyF+z9cjXJEH5DugL5EkO1xjRA==
X-Google-Smtp-Source: ABdhPJyiDN4QJD7MZy70uuJmaIMMWPIn6VtkISbEw+EirUEH071qbK8U+Iyy21UwOFVIEfKVaGLz1A==
X-Received: by 2002:aed:2b86:: with SMTP id e6mr5996418qtd.86.1599704365041;
        Wed, 09 Sep 2020 19:19:25 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:b02c:9c0a:1a83:70bb])
        by smtp.gmail.com with ESMTPSA id d10sm4438024qkk.1.2020.09.09.19.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 19:19:24 -0700 (PDT)
Date:   Wed, 9 Sep 2020 22:19:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git in Outreachy?
Message-ID: <20200910021916.GA503@nand.local>
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <CAP8UFD2rpNhDhyHdQNxS-KJZgcumsCpK_JQ5koCqXJd70s-+_w@mail.gmail.com>
 <20200903060041.GH4035286@google.com>
 <20200909182617.GA14981@nand.local>
 <20200910013915.GD667601@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200910013915.GD667601@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 09, 2020 at 06:39:15PM -0700, Jonathan Nieder wrote:
> Taylor Blau wrote:
> In other words: this isn't about changing how tests are executed ---
> it's about going from patches on list to git commits that can be
> tested.

Fair enough; it sounds like a Snowpatch-like tool might be useful for
that case.

> [...]
> >> - formats: on-disk reverse idx
> >
> > As a heads up, I think that I am going to start working on (an
> > alternative to) this myself,
>
> Neat!  I look forward to seeing what you build.  (Is this related to
> the bitmaps-using-midx-ordering work?)

You guessed it ;-). It's sort of a tricky issue: the pack-objects code
needs to know things like the position of an object in index order so
that it can look at the offset of the next object and determine its
size.

But, in the multi-pack case, things aren't so simple. It would be nice
if we could look at a bit position and say "you are at bit position N
and there are M different packs before you, so I know what position
you are within your pack", but this can't be done in general when you
have duplicate objects among packs in your MIDX.

The MIDX is only going to choose one of them, and so you don't know how
many "holes" are present before you. In my development version, I have a
bitmap extension I'm calling the "rev-cache" which acts like a mapping
between bit position and MIDX name order (which can then be used to look
up auxiliary info like which pack an object came from, its position in
the pack's index order, and so on).

But, having an on-disk mapping between objects and their position in
different orderings will be useful not only for this, but for:

  - avoiding building a reverse index in memory from scratch (which can
    occupy quite a bit of the heap in some repositories that we see),
    and

  - dropping GitHub's custom "bit-cache" extension, which maps objects
    from name order to bit position.

Anyway, obviously not related to Outreachy, and obviously many more
details to come once I have patches that are more mature, but I couldn't
help myself in the meantime.

> Thanks,
> Jonathan
>
> >> [*] https://github.com/ruscur/snowpatch

Thanks,
Taylor

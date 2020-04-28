Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C292AC83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 20:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D902176D
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 20:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="IzibWwW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgD1UAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728559AbgD1UAE (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 16:00:04 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B4BC03C1AB
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 13:00:02 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n16so10971126pgb.7
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 13:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yO+DTdcyYraGX/2XtVPJ8fFQfZUKzdT6on+iskw21OM=;
        b=IzibWwW4Jtrz6wfAB/7zhJ3mlPnVAGdndDfm2Tyw5CMxjSOdMDO9s6DjfugXWv4Jgb
         AZfWxakWti5mdIcAbviDjviXWnVmc1Inu40gAt5iYSamMTScQUEOm9n5gXtQf131aSAZ
         9N3N1Qj6PvEOAfd0zOkPfuaxcpWe/oqOUP6EbApKfyKQEkDwWzffdlb6Yk5rzoiUYICx
         YVbzqyqb0xa98teQHbwH1/2tFt1XR0NPUpfhcjTkqIRxL54jlQDyKly6hwCivS8WuDTI
         khOFWl2KjlP1L4QkwJ21Tdi0/xWZb/Q90YSyt1hjzqK9NDySXbaSv2TtNhD2ePuj1kBY
         Y9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yO+DTdcyYraGX/2XtVPJ8fFQfZUKzdT6on+iskw21OM=;
        b=lHAeAhcX5wu5bAKT6EwJgFZWN3rm2APbVAUSq/khBwGs43cRaoZZGNxAjAQ0Mdwaru
         BrNQXq5EPUb87aTlTINx6LFswFGZaJeeajhe7yXtE9XTxXYw2vEqt08+fY92nc7dTK05
         TxDzqRi7I9Uf0IU43QHiPTjQFQ/RWGr6kDyxmCntZMmBzHUfP3acdTqmTfbCdRzCfYXc
         InCMeWldgI8QNFKB6N0F9Qyc8qs4xBt5AChgIoRxqP7+4A/n7+/v0WS07000s0k1zRmg
         78FgyI8PciVgbqLrkQYF8kOa3Hmpd6P09/cQjPd1uOPHi3T/vOflic+8oAMOcNyYNnyj
         GU/g==
X-Gm-Message-State: AGi0PuYN3k3rbDx8dFu4F2cmghv7Lr+ir2SppsOtUip2nKFZ8kIZ5jJj
        yOIxucN9SsmKgfF3Ci7W/s3Dxg==
X-Google-Smtp-Source: APiQypKqNRARZhgETTYz3iwwi+Fqen61MSu6qxuQ9ZYugh/Eia/fhnasuYbrd56PXY1UjJeGWnjfSQ==
X-Received: by 2002:a62:7e8e:: with SMTP id z136mr30458441pfc.151.1588104002433;
        Tue, 28 Apr 2020 13:00:02 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id w69sm15782648pff.168.2020.04.28.12.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:00:00 -0700 (PDT)
Date:   Tue, 28 Apr 2020 13:59:57 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] fetch-pack: try harder to read an ERR packet
Message-ID: <20200428195957.GA45908@syl.local>
References: <20200428074442.29830-1-chriscool@tuxfamily.org>
 <xmqqzhav1kix.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzhav1kix.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 12:24:06PM -0700, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
> > From: SZEDER Gábor <szeder.dev@gmail.com>
> >
> > When the server has hung up after sending an ERR packet to the
> > client, the client might still be writing, for example a "done"
> > line. Therefore the client might get a write error before reading
> > the ERR packet.
> >
> > When fetching, this could result in the client displaying a
> > "Broken pipe" error, instead of the more useful error sent by
> > the server in the ERR packet.
>
> Hmm, if the connection gets severed just before the ERR packet the
> other side has written, we will see "Broken pipe" if we write
> "done", and no amount of "try to read to collect as much what they
> said as possible" would help.  If you are lucky and the connection
> is broken after the ERR reaches on this side, such an "extra effort"
> may help, but is it really worth the effort?  It is not clear to me
> if the extra complexity, one more API function people need to learn,
> and the need to think which one to use every time they want to say
> write_in_full(), are justifiable.
>
> I dunno.

I think that you're right. The more that I thought about my suggestion,
the more dumb I was convinced that it was.

Sorry.

Thanks,
Taylor

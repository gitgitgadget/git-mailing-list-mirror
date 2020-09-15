Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B1AC2D0E3
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 22:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ACA920936
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 22:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="tdxTAX/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgIOWVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbgIOQ1B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 12:27:01 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B676C06178B
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 09:26:59 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 16so4845588qkf.4
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 09:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jc8fGethuH/996bOnmXNyo18JlQ9lNGVgLyncON7+NQ=;
        b=tdxTAX/IQV7P7jUGiS/THAyUWTP9tH4D9xfGl3VHPVrXpC7j0Icy8ORjJ1lVkd7qjj
         hPzcD2F33ImXLonlrx+3w4HbPxQbtoqpqi3DQgTbbxoToAFPphXmIyEItAz4ZxwaL7Yy
         82sxjgbNBsz2Sj1AVOL5MNuuqkJFljd3kHCiKL7ZzrKVbTjyiEFxbDYdrtgdxy0D1kjP
         wxap/FFn/VZzDZQ/S/Zwuc0T0Dzd4hwCbTod8KsYt5e4C+Is/Ze94xpJSpq8U0tFD7In
         qhKSjlpnU6ZoZPj1TfBRt3NlHqPLwspyYUzFGlIM0gfj6tLZSCc6g1kugN4QCHahNWMd
         gwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jc8fGethuH/996bOnmXNyo18JlQ9lNGVgLyncON7+NQ=;
        b=Z094YGukrJetpI0xuQnrRhn2eyHYKy3YY3V1080CXiLMAEGuwo+jtzW3QQoxr+ODfb
         HYeZAia7DLhR3Xg0Fnkc8EFncVe8rVv05ooZbOiQ3Mu7+3ZlD9fkkod306UQ7mHdJH7v
         goRshYlSgsiumcMkUsqJSESjMDZKbV4OXk/z78sJb3hIzldfs7Iou09RqItxEPIxsZqi
         2PhX2JTyOMzRqXh1/dd/QlfFwqGOBqOIJI8WQRmrBVaakPcPk0i07WofpyXGqfp2mSOZ
         /nERMsNqHPabPWX8PWfPrw0Z7obhfCoZ7hqgRBgwfpy4IB242jSx1rQ8L5R16tLTXmaF
         FCIw==
X-Gm-Message-State: AOAM532Jq9yCIyelQU7Mqn/PTVGAsqTHqaj7RY2ebrhCAidilbNJwOyk
        KYMd3qnKXdJBp8sN+6ANp1ZJz/Uwqcy+NSkU
X-Google-Smtp-Source: ABdhPJwNVPLFDJ5K1tFcl/19ut01HfZD/MaVFqBrE7B9Og4nwc5JL1P7pjDjFpQWSbb8ZSxLs8LoIA==
X-Received: by 2002:a37:4f47:: with SMTP id d68mr18399244qkb.6.1600187218724;
        Tue, 15 Sep 2020 09:26:58 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:209c:e081:d56c:21a0])
        by smtp.gmail.com with ESMTPSA id g5sm16928356qtx.43.2020.09.15.09.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 09:26:58 -0700 (PDT)
Date:   Tue, 15 Sep 2020 12:26:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     "Liu, Xuhui (Jackson)" <Xuhui.Liu@amd.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Recall: But : git-p4 unshelve
Message-ID: <20200915162654.GA27715@nand.local>
References: <DM6PR12MB3194FC0CE3C2B8C78BC5B613FA200@DM6PR12MB3194.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR12MB3194FC0CE3C2B8C78BC5B613FA200@DM6PR12MB3194.namprd12.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Tue, Sep 15, 2020 at 12:45:38AM +0000, Liu, Xuhui (Jackson) wrote:
> Liu, Xuhui (Jackson) would like to recall the message, "But : git-p4 unshelve ".

The mailing list does not support recalling messages. Once you have sent
something to the list, it is there forever (and note that the mailing
list is mirrored on lore.kernel.org, public-inbox.org, and so on).

Thanks,
Taylor

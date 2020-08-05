Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D3CC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4637D22CAD
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="UR8Ve8lh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgHEUF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgHEQfG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 12:35:06 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81126C0086BE
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 08:10:21 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id j187so41901099qke.11
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9eH9RBcpsFjjykStnnGmwVXvRp/vtZXEwDaEuAlbgak=;
        b=UR8Ve8lh6q+zhq9X40DSh21x5OoY6F1j136E0yP5QashmU5QEtZOjZeDfh9sLQKPX5
         OG8aqvOK/Y8NNbHRiFL5zoHpZT/v/FAx3klERCju/H2DObh1unje5avZ49ycYaWRq/7u
         8Dcq8EByYb6G9aNHEhuqgXtyVflnUvvB8y1e5//b6Oja4pklmbEuBqjmPt2wHuX5SD1s
         2/Luv4QHcRPS5OzFGteqMkYdtrnaO7kL/QV7v6EHHAAV4eKyMQhbjvyLhaJkI+slq8sm
         3e1oR32Y2aWFKewXCn3saSPUMsMGzklow0c8SvDsuzuzFXxgV82VNHgkzxomAPffjhLy
         sO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9eH9RBcpsFjjykStnnGmwVXvRp/vtZXEwDaEuAlbgak=;
        b=TTmsENb9y43p/j+ytEsWStp5gvrUIA0pyauxmxfGbSze3Yx9dX2bI65AT4rVxB5DQ3
         uiTu+KOxQKRaNtpdrLHwsZcLUAgO1BsnQWebNN/nIJKwdNIjFWzq3Ucl6ivor0MM6sVH
         5ggv3tHRBg02gmT4FblxeUYE0SgAFBavURgEeFqyhBefz56bNnUwsvapK11+5VoJeJ/a
         GtxJnbyg8/93l0cQRcsAOFP3GPApmHx89+ALFYH8KxR2ILXK+iEglhFFG/yjmQ8ZQ5xI
         PxasbfqdRnSmUSjPTX3B3byfvd4qV186iLIR3PaD+Ko581yrNFwEgYDU9kzhw93KfL5q
         XQ/w==
X-Gm-Message-State: AOAM533Pb7x/QKdU/dbsN+cjDbhZYDr8CjrY7X6YOCE06ZqdQd0KpgOr
        TwjF0xgrNtyKV6pOea+dxNh0fg==
X-Google-Smtp-Source: ABdhPJzH9qYeeAD0qEfLOYVUeSGthDHvC8Qml+VwcuV9FGEV4ijdJOLF/Pzo+Sb0sVZNOyTFIm4lwg==
X-Received: by 2002:a37:a30b:: with SMTP id m11mr3833347qke.12.1596640214968;
        Wed, 05 Aug 2020 08:10:14 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id i75sm1698755qke.70.2020.08.05.08.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 08:10:13 -0700 (PDT)
Date:   Wed, 5 Aug 2020 11:10:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: racy test failure in tb/upload-pack-filters
Message-ID: <20200805151012.GB9546@syl.lan>
References: <20200805084240.GA1802257@coredump.intra.peff.net>
 <20200805090641.GR2898@szeder.dev>
 <20200805092658.GA1803042@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200805092658.GA1803042@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 05, 2020 at 05:26:58AM -0400, Jeff King wrote:
> On Wed, Aug 05, 2020 at 11:06:41AM +0200, SZEDER Gábor wrote:
>
> > > We can fix it by using test_i18ngrep, which just makes this grep a noop
> > > in the poison mode.
> >
> > I wonder whether changing that die to
> >
> >   die("%s: %s", _("remote error"), buffer + 4)
> >
> > would be better.
>
> That would definitely work, but it seems sad to have to make our code
> uglier. Plus I think it would hurt translations that want to format
> differently (e.g., would an RTL language want to swap the order?).

This is reason enough to not do this; I know that we are pretty averse
to translation lego, and even though this one seems innocuous, I think
it may be a deal breaker for such languages.

> It also wouldn't help other poison uses that could be expecting a "%s"
> to be filled.  Another option would be to make our poison code more
> realistic by copying placeholders like "%s" into the poison string. That
> would fix this problem, and allow some tests to relax a bit (e.g., if
> I'm looking for an error message that contains a filename, I _could_
> grep for just that filename, which would never actually be translated).
>
> But I think that gets pretty tricky, as we'd have to understand the
> whole set of placeholders (e.g., that "%s" is complete after two bytes,
> but "%lu" needs three bytes).

Might be a good direction to go in, but I agree it's outside of the
scope of this patch.

> Anyway, it seemed like limiting the damage to the tests themselves was
> the least bad thing.
>
> By the way, grepping for "remote error:" shows that when we get an error
> over sideband 3 we produce the same message but _don't_ translate it.
> That seems inconsistent.
>
> -Peff

Thanks,
Taylor

Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28C1C433DF
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 02:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A18E6222E9
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 02:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="IND0XOns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390904AbgJTCza (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 22:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbgJTCza (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 22:55:30 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19144C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 19:55:29 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id p16so465711ilq.5
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 19:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qURAff8yxrAIogNXIpEoYPxNV/pn7ClvktJ5joL6aww=;
        b=IND0XOnshGvylMiyoYD7ZKf729YrjHtYyQ1Oli+GfcpmQuZaqdQ2cCIZajd9vOde7z
         oj2Z6CNg/onY5DTDhiJM/xA2OeM7vMJwARjQOgx5qRPDVF8UuC+PqQUUqSDOzThehrdr
         9tihg6PQHxDPmpQcfbS+1I4vHr9I0NUbPXiRv2z6YUIQt1NHmtUYJjBZSsXcrqpkN259
         QFu4Vqi/v+jRHb4eFHJt1ovm02wkzSySXAAtS4YMR38nIYWBCQqqQFNOZXhowYE6jMvo
         0/OqQpmmbMimT7lDcEu0Ls/6Abrp5manx83ciUJKiV9eMEBiqpQ5DaThXBY7KAaHvssX
         vtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qURAff8yxrAIogNXIpEoYPxNV/pn7ClvktJ5joL6aww=;
        b=Spt5yHCnE0FZjWsyeM90LAhj8u6CgOI8eNddhkm6my7wYub1IX/01aqiwjl2S7Vivo
         lt36f1QMeWwhHn4a/fEDqch5178zy1ugVW4o1+fWWggSOW1UAR0vLZTZU2JHkM0NqcwA
         YRaJJJT2QRTFougsU8OP4aRsf1gP1KUY/T4Kjd9f+AoYH7lDS5gIY4ZcLIiCPvaeXrpa
         MUNy0CO+uVzLU8pGENfx2a609vxuu+mYGWjv/k0ybpIJOBXtKWS3wD2RcyIUOLeXharw
         gHuRC5zI/gu1oJT+eb/gHktAhuB4JyrRoNCEaxYR+g+cnAL5i5cUf9n9P9+8joucHfK/
         /7pw==
X-Gm-Message-State: AOAM5301+fc7Ab6P9IXz1o5SFFpk6LRLbY3fx/2C4fD8cjQTNSOgwnHn
        eSaihh4GcygENBclaq7acMS9WEwDu6JTyLKMc50=
X-Google-Smtp-Source: ABdhPJy8TA+WmnE1/K0K8LnsQs1NBAHQg0mm5zResbpmTOk2Rm5VID40sH8iJBRwUFxdFQGgs7KHlw==
X-Received: by 2002:a92:1b97:: with SMTP id f23mr395177ill.216.1603162528503;
        Mon, 19 Oct 2020 19:55:28 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:943f:d0f4:e8b9:b8f9])
        by smtp.gmail.com with ESMTPSA id f5sm401042ioq.5.2020.10.19.19.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 19:55:27 -0700 (PDT)
Date:   Mon, 19 Oct 2020 22:55:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        jeffhost@microsoft.com, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com, newren@gmail.com
Subject: Re: [PATCH v2 16/19] parallel-checkout: add tests for basic
 operations
Message-ID: <20201020025525.GG54484@nand.local>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
 <64b41d537e68a45f2bb0a0c3078f2cd314b5a57d.1600814153.git.matheus.bernardino@usp.br>
 <20201020013558.GA15198@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020013558.GA15198@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 19, 2020 at 06:35:58PM -0700, Jonathan Nieder wrote:
> > +
> > +	# Check that the expected number of workers has been used. Note that it
> > +	# can be different than the requested number in two cases: when the
> > +	# quantity of entries to be checked out is less than the number of
> > +	# workers; and when the threshold has not been reached.
> > +	#
> > +	local workers_in_trace=$(grep "child_start\[.\+\] git checkout--helper" trace | wc -l) &&
>
> Do we use grep's \+ operator in other tests?  I thought we preferred to
> use the more portable *, but it may be that I'm out of date.

You're not out-of-date; I looked at this myself a couple of months ago:

  https://lore.kernel.org/git/20200812140352.GC74542@syl.lan/

Thanks,
Taylor

Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44E1C433E0
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 16:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE2642067D
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 16:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="QdfHjfl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgGXQvh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 12:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgGXQvg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 12:51:36 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9B3C0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 09:51:36 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id dm12so4393956qvb.9
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 09:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8fG+NpL0+jhEgTD/FRITD1em3aC/CMU73wtH+xSRdWs=;
        b=QdfHjfl7WpqwP4CfvFDBOXLqHMSUczAVwFLnFH3cBzcDPza0rngzZzDVY+pevOzGwM
         GYGWFGLZTV6XOoySWns/ruGv98ek5mEcK/NfVxfuacpR4qiu5gTTt9ym7ItjEkYVrM2d
         fd4XREJYWmXSgfPC6VFaQg6nbet5tRvz/wUfTXVQd9KH6HLcf2JiFco+39ocV9TddXQJ
         R1ihjoCbGhypLcg/3vbBVyrTcwvk3NJyxfBslcOtvSY6nFiWbfKkbfYHeJ30Qdfhdkaa
         G3gf8JWYK3xL6iFq+fa35gzOxMOTV8cvhr+siwW4st0+Mfy3sd2Jwbu3j/8tggIMvtpD
         IaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8fG+NpL0+jhEgTD/FRITD1em3aC/CMU73wtH+xSRdWs=;
        b=cY6tJaSZ7odQZdsAvVLOWgg/dm77hB5eCltN2T+oWNs9msEc7qw6v4+Fg4s3qeyZ4h
         OThfqXBceX/LpgSLvhCaMzDliTolc0IIdWolSKkfvj+srT+PKt7RN9RXQR1AhJAxeLIP
         AdrXud4TBg+FgYzKPNfWEAT08H3eyQ/KRmXsKdbEe9kBSVSKyc6n393viENXvV5s4ymn
         DcRoswqSiOxbeNGFXR6hd+2oK0fMxxVti2dh3R6V4ZhZGld9AD+lTlME9V1FmKLrQMnV
         7fvP1EUY+pbcaTArLaiuQ3ItHH/j/U5rlSD9ryqZD2+E2dPDZHBdWNr5vKdBZzxQNNwC
         xLfQ==
X-Gm-Message-State: AOAM532PwYdC7GHfcdK9WvPhnhOCpC2zzE3f48Ku2CVT0JCtYYKwu5xh
        9CyAKGKQo/R7YDnhQO1hkN6KFw==
X-Google-Smtp-Source: ABdhPJyAStwTVT7yiVPFP2cpqXESO4tjn+DOcCis7PutdxhW6VHVqwfatSKxZKbjjg04rphAQh+hXw==
X-Received: by 2002:a05:6214:1584:: with SMTP id m4mr10265293qvw.60.1595609495483;
        Fri, 24 Jul 2020 09:51:35 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e588:f326:57e3:7769])
        by smtp.gmail.com with ESMTPSA id m203sm6636203qke.114.2020.07.24.09.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 09:51:34 -0700 (PDT)
Date:   Fri, 24 Jul 2020 12:51:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        chriscool@tuxfamily.org, gitster@pobox.com
Subject: Re: [PATCH v2 0/4] upload-pack: custom allowed object filters
Message-ID: <20200724165133.GA15287@syl.lan>
References: <cover.1595468657.git.me@ttaylorr.com>
 <20200723204325.GM11341@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200723204325.GM11341@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 23, 2020 at 10:43:25PM +0200, SZEDER Gábor wrote:
> On Wed, Jul 22, 2020 at 09:48:54PM -0400, Taylor Blau wrote:
> > Here's a much-delayed v2 of my series to teach upload-pack to limit the
> > kinds of object filters that it is willing to server in a request.
> >
> > Much is the same since last time, with two notable exceptions:
> >
> >   - We use the 'uploadpackfilter' top-level configuration key instead of
> >     pretending that 'uploadpack.filter' is top-level, which greatly
> >     simplifies the call to 'parse_config_key()'.
> >
> >   - Instead of writing an err packet, 'git upload-pack' simply 'die()'s,
>
> To clarify, I only recommended to pass the same message to die() as in
> the ERR packet, not dropping the ERR packet, because ...
>
> >     which propagates the error through 'git clone' always,
>
> it does in the new tests when creating a local clone, but does it
> really work with all protocols and remote helpers and what not?
>
> >     and resolves
> >     a flaky set of tests that used to result in a SIGPIPE.
>
> This doesn't resolve the SIGPIPE flakiness, because 'git upload-pack'
> can still abort while 'git clone' is still sending packets.  IOW we
> still need that 'test_must_fail ok=sigpipe' in all new tests.

Let me double check my understanding... I think that you are suggesting
the following three things:

  - Write the same message as an err packet over the wire as we do when
    'die()'ing from inside of upload-pack.c

  - Don't mark said message(s) for translation, matching what we do in
    the rest of upload-pack.c.

  - Re-introduce the 'test_must_fail ok=sigpipe' and stop grepping
    stderr for the right message.

Do I have that right?

Thanks,
Taylor

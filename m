Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF413C433E4
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 20:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 984CB20792
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 20:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpOMXsgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGWUnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgGWUnb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 16:43:31 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EFEC0619D3
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 13:43:30 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dg28so5497999edb.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 13:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M/gtzEKgG6PQmxX3Vgonb4tcmWLiUbCR+jvx6ZwuIKw=;
        b=TpOMXsgUv3UjVOsw5XCnwfFbbJP2GiHX4G1eEHG8uPixgiOXLSfctb6YiCNymw9Lam
         HmXdsTCx8X6mSNC/yFudQxGj4bfdfDdH4abwoLgH8T/Zs/Vlz9E48DNl/4wMv1IVjEpS
         QJyfAfCApVBvymiqbGYABAlE4854TVv6BjuGCWLXJqKlHC7VgKcnDww79C7dlZ8Pl1pc
         ef8RDesjyNLaey/aBaauhDqFEt2ej72bDWsIGkWn8bSgug16vX8k0diefZYG9gLrI7+G
         OZITKnr6sIhD8hTRMNVF2weWvx/hJ3BI5u8ZIODa3t40if/KMAjN/Aj/tlB0SVDihSH/
         mKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M/gtzEKgG6PQmxX3Vgonb4tcmWLiUbCR+jvx6ZwuIKw=;
        b=hSqJaywe3oh24f52eMhqSq5VNor+co5lWKGnWCWrCvMQ5tGvXF8mik1/zdIeE2OaAc
         lPVreeeB2QivT3/7+wncZ7/e//SX5wN/95Pvy/liwU2B/mqIlHC4FWjdQps4qH2sTopJ
         QLcbZpnxOdCCfVR/5ZqAah4qZQxzZWhgp8AAsPonpV1PitmnZRuyEoYAjF/fSS75P5uw
         aKkt/KXees/+51UwgXLX0AEX20/fZvrDCLfPHIW/udDcn3sI0M4siHGnAN3HEX44uDn/
         XS4qALZZpXooROSfqHqauSjbIF/8Xb1xYN+OUqH/pUJ7S++IKfWX/mFQSAxpH4435WLk
         D1dA==
X-Gm-Message-State: AOAM532al6bW1GeONOwZ2a7sT5SKeVP5POPrU1pEOje00/BBzU86j16L
        E3y+xLDDmRNDqA8dodIsPe8=
X-Google-Smtp-Source: ABdhPJzadJ9uTt3/Qy49NGFmgUaOw6BqqG4H68SJc5DsvnMQP5SOg3HCWDjvYUDkV2AuczqEGy4tQg==
X-Received: by 2002:a05:6402:204f:: with SMTP id bc15mr5029868edb.70.1595537009697;
        Thu, 23 Jul 2020 13:43:29 -0700 (PDT)
Received: from szeder.dev (62-165-238-20.pool.digikabel.hu. [62.165.238.20])
        by smtp.gmail.com with ESMTPSA id z1sm2379153edl.93.2020.07.23.13.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 13:43:28 -0700 (PDT)
Date:   Thu, 23 Jul 2020 22:43:25 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, chriscool@tuxfamily.org,
        gitster@pobox.com
Subject: Re: [PATCH v2 0/4] upload-pack: custom allowed object filters
Message-ID: <20200723204325.GM11341@szeder.dev>
References: <cover.1595468657.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1595468657.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 22, 2020 at 09:48:54PM -0400, Taylor Blau wrote:
> Here's a much-delayed v2 of my series to teach upload-pack to limit the
> kinds of object filters that it is willing to server in a request.
> 
> Much is the same since last time, with two notable exceptions:
> 
>   - We use the 'uploadpackfilter' top-level configuration key instead of
>     pretending that 'uploadpack.filter' is top-level, which greatly
>     simplifies the call to 'parse_config_key()'.
> 
>   - Instead of writing an err packet, 'git upload-pack' simply 'die()'s,

To clarify, I only recommended to pass the same message to die() as in
the ERR packet, not dropping the ERR packet, because ...

>     which propagates the error through 'git clone' always,

it does in the new tests when creating a local clone, but does it
really work with all protocols and remote helpers and what not?

>     and resolves
>     a flaky set of tests that used to result in a SIGPIPE.

This doesn't resolve the SIGPIPE flakiness, because 'git upload-pack'
can still abort while 'git clone' is still sending packets.  IOW we
still need that 'test_must_fail ok=sigpipe' in all new tests.


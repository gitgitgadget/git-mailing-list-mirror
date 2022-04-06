Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A63C433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 18:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240128AbiDFSPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 14:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240483AbiDFSPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 14:15:16 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE1826A088
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 10:05:44 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id 8so2363868ilq.4
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4xEh0YTn7XWS/7chU37oDPTrP9NC8ulLMovh69irOkI=;
        b=iLPAGjF5FVY5Cm1am/qhTXpgAeYb3UhpmzE1gUJIFSd/brnxGHH6DpVjltioYgAJeu
         SHu5grGCAd9wM6xuVYomQ9ccYEqltSRVGqaIlc9mESlY/f1JSI+6qK75pctwRs/IVeRl
         LC0WS6v+6kRAcx23+9cX8c8tOjZRpztjCz92arnPGBk5OquY1qijw8m1O96yPoF6xmVw
         vqfUW/nComwA6y4mnHNoK6fZE4Ly2LtRPVEGNIy2Y9FtJqP+BFt2kfd5juh6qQ136e1i
         JEWMFZGhhBI9eOJUtLe8cY/vQmJM4AlqZuslj8Ld5XO/pSrrxaOqHvk3ds/vERvlL1sT
         sKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4xEh0YTn7XWS/7chU37oDPTrP9NC8ulLMovh69irOkI=;
        b=G8PZOs6ntoMfJjDPhZMraj+gRpOlC87YWYRG65inimXT/VZ9/iZ4CWPG737s7HQg+k
         RFYKtF+4j5VGz19HtmIojTXlNQo86VNweNx0nRbNEqWA9xuPa0sY/5oo0GyJy43xjUjW
         Af4XTQYg8keMntG+DnVIQngEJA/qmYPhr49v0HiNQfCI5/pkHMIFd7u2Uq5WDMhPQfPc
         nQlMe4ig34kHrvpoErdF275WgvJD+XByHL2lYNelDfHNF2BzCXZ8NqSKq/2pYUlTP++g
         hgv/kPMi34+SUCxDfiNmV2tsUJ8juzIO7fOMORWjPVitxHoNtEe1ZTG2m1JxEKpCgAOw
         y8cw==
X-Gm-Message-State: AOAM532nmk24N8du2+apZ8iW6gQjZPl79HB8rqFptD09NI6zZRq8jeLq
        NxrUJhodY95rSfE5OO+pqOfyXA==
X-Google-Smtp-Source: ABdhPJwmmnQ8GyTsZ2f37ootvUnBnkoiqiZExs6Lb/yVfQ2rt2IcCapg//+bxQuJP3Y1NpCBqd7Ypg==
X-Received: by 2002:a92:cd8b:0:b0:2c9:ded9:f20d with SMTP id r11-20020a92cd8b000000b002c9ded9f20dmr4358630ilb.300.1649264744149;
        Wed, 06 Apr 2022 10:05:44 -0700 (PDT)
Received: from localhost ([104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f2-20020a056e020b4200b002c805b9b4c4sm10781792ilu.16.2022.04.06.10.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 10:05:43 -0700 (PDT)
Date:   Wed, 6 Apr 2022 13:05:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] Documentation/Makefile: fix "make info" regression in
 dad9cd7d518
Message-ID: <Yk3IXHr2rgc9Zd3w@nand.local>
References: <20220405141552.qgl6t2urtbeilsmp@lucy.dinwoodie.org>
 <patch-1.1-e700d372e0c-20220405T195425Z-avarab@gmail.com>
 <20220406082625.7mots3ziqchjpyhw@lucy.dinwoodie.org>
 <xmqqbkxeyxfl.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqbkxeyxfl.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 06, 2022 at 09:43:42AM -0700, Junio C Hamano wrote:
> Adam Dinwoodie <adam@dinwoodie.org> writes:
>
> > Confirmed this patch fixes things for me.  Thanks for the quick fix!
> >
> > Tested-by: Adam Dinwoodie <adam@dinwoodie.org>
>
> Thanks, both.

Indeed; thanks for the fix, Ævar. This sub-thread was a fun read for me
to get to learn about a new "make" quirk. You learn something new every
day ;-).

Thanks,
Taylor

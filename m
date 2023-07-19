Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DECC0015E
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 16:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjGSQ5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 12:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGSQ5T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 12:57:19 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D11BB6
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 09:57:18 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-47e36c35285so2319044e0c.0
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 09:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689785837; x=1692377837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha8yEbq1nP1F7i30hweK/5LbvXYX6Yt785A3SHovatU=;
        b=jqz2sWKPSaxSsUR4RzzrXBfYa49d+tOwakdMDfno87Xy4+oOn7R9bexKCupSXMSL6r
         s6/llXy8m+dusbOPKb3mOsCEn2CJRB7czocxEozQGDec8DeAX3kRRXD/WJ4sV8t5jdfY
         HmIin0I7UIJfs5O2Zo0acTRyR/pVxI1we/+N1xNcNlIpoE1Gb1iIyi+hDib63qTrC8LT
         m9/2fcs7MXwAmvpuUowwlh2SEZgRRSyMemYmRgiS3seaVu78m/FytXk3nTkuj430JjgC
         szeOqOeJFZxm65Cvx/RoQR2kOapIffp22LQNuwv6+tNO2sIqw+88DsEfrl8bMI9svkAN
         g0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689785837; x=1692377837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ha8yEbq1nP1F7i30hweK/5LbvXYX6Yt785A3SHovatU=;
        b=dFP3HTepxQ0pZ6iqNqBXZb0WXEQ/RdVmdOxl5d397SYWiK+cf3+NZwORV9Lz0GocSv
         70ZMQ1ZSN5SOC2yx66zQjCqIkjjqBZ6H3Tw3XJLlC0pBzzZ0ETTHhoL7bJWMg6b9GJOk
         +Sz/jSgboi3S1mYY7mArvu4TV5thvbIhB1m4/JlCP6MjPN/03KRueQmvckmyPM3H4/Mr
         SNrpZ7vIxukVD2M6SJUQD36ufAxAw1T/tFjk7j6AVMKX0k23EHlqjtS+UlLUgWdeU6Op
         VPTAWiKZSZyKBJ0XB2BcfLJpb01VALhPxYLYI6M8I2xum8EJOnYgP0LKrBs63Rituve0
         Bctw==
X-Gm-Message-State: ABy/qLYNlq2/CeV6Z9szp2rSleVq1BchaExw+C8oy1KI54DbROy8tbDf
        t9ZLMiDrwZ/bc6fUZzNLJuA8QXmBPfpzT/FH3w4SFw==
X-Google-Smtp-Source: APBJJlFejh4zYPoeVSgAo99I57TuNcTCvrWp39oMouHbSteECYie5uau1EMDvde1pbvbxD69jBbzWg==
X-Received: by 2002:a1f:bd92:0:b0:47e:3bc8:af53 with SMTP id n140-20020a1fbd92000000b0047e3bc8af53mr91196vkf.14.1689785837245;
        Wed, 19 Jul 2023 09:57:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j131-20020a819289000000b00555df877a4csm1093254ywg.102.2023.07.19.09.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 09:57:16 -0700 (PDT)
Date:   Wed, 19 Jul 2023 12:57:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] reset: reject --no-(mixed|soft|hard|merge|keep) option
Message-ID: <ZLgV7EdEox9r1RvK@nand.local>
References: <xmqq1qh4c998.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1qh4c998.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 19, 2023 at 06:37:39AM -0700, Junio C Hamano wrote:
> ---
>  builtin/reset.c  | 29 ++++++++++++++++++-----------
>  t/t7102-reset.sh | 10 ++++++++++
>  2 files changed, 28 insertions(+), 11 deletions(-)

Seems all very sane to me, LGTM.

Thanks,
Taylor

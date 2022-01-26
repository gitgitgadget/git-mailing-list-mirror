Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86966C2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 20:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiAZUYq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 15:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiAZUYp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 15:24:45 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38142C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 12:24:45 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id c188so1037519iof.6
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 12:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8NDup0CXN/F2poZKuYsCtnV/9fhnS1h4uIbhsRBeLOI=;
        b=CMcUI2IftgFzeXp5TBtM3aMsJ9+GlhkYumKFiUSr/eDeGTiHz3Krz23dF3zQRr1qJ0
         U16YJB9Jc61XCO5nOCyAUiAEzkhHzQtJjr8QDV2DXIU3+owZ6Bt4wXyE40nY5tttNJ0P
         fAmlNz+MjHWAYlZFhHnqx2HPY/QBlaXXlP4GfXSteBy0ACiZTGteE5ReSa3f9SrSS6mb
         1nZc4tOs/oEblDt535S1b1VB1mQQrOEuH3zMs7Jlgtn2DGnF7lK+xx7Pm0iKyroEqxOa
         d1KqlgLk5gQdMdGnzubsQTLeLYfQ9m/AVN5DfAsMk/VtFPX83AEENWtJBftmzp9e0qqT
         BaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8NDup0CXN/F2poZKuYsCtnV/9fhnS1h4uIbhsRBeLOI=;
        b=m4VNVpA5G2CFK7reW8U/RLgtormxaouyBDHQRGgkcjDwCvm/5rg6LZqCIhJfjemGEH
         y1xlM9kAhdRHlL6uNskYDCe+jO/V+Vhz3eOCtD88HWf72GOQoNkXeBwSqa+jm9VCMzeT
         lleyxLieLyz/B/bjY1afiUqCD4Ypziko2Ga2K36NLNtvnzdmxjbWryJfwIh23utvbt4J
         hVK9ZAcaUNQbyBfQgAC2GQjIXuhFI7PBY06N5qn+pRhv1ZG33o8vKvFIVYeqpvrzAN0i
         dC0QoZv60LIHnqmRu4OEULXqnfEyoGJorm15HKO4WBIHG7+NsqVqQHWkw2o4tIGoNgpQ
         HpYQ==
X-Gm-Message-State: AOAM5325fwj2iPZMRvIpCMfu0hzNr8Sbh0Mu2ZWYnyUn+uR/amUPCFCh
        ccABFfE18jbC1XW3iZffbnfIuA==
X-Google-Smtp-Source: ABdhPJyCz6b247M4NyMnMG46h9xxfG7axpTRdFPYZbf0+Sy5wDO8gU2JRTJSqinVp+3Lmfz8cStO1w==
X-Received: by 2002:a05:6602:2d49:: with SMTP id d9mr197245iow.48.1643228684626;
        Wed, 26 Jan 2022 12:24:44 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e17sm10822577ilm.67.2022.01.26.12.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 12:24:44 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:24:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 0/9] midx: prevent bitmap corruption when permuting
 pack order
Message-ID: <YfGuC0wowQnYi/Eq@nand.local>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1643150456.git.me@ttaylorr.com>
 <220126.86czkee675.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220126.86czkee675.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 06:50:27PM +0100, Ævar Arnfjörð Bjarmason wrote:
> I gave this some light reading earlier, and left a few nit-y comments
> along the way. This isn't my area of expertise, but without giving it
> much of a deep look this all looked good to me.

Thanks so much!

> I don't see a reason not to carry this forward, with or without
> addressing any of the nits I brought up.

I responded to your comments throughout this thread, but the "executive
summary" is that I think we're OK to continue with this version as-is.

Could I get an ACK from either Stolee or Jonathan Tan that this version
looks OK?

Thanks,
Taylor

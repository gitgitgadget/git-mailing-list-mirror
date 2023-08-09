Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9785FC0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 20:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjHIUfA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbjHIUfA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 16:35:00 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8015A210D
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 13:34:57 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-583a8596e2aso3758767b3.1
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 13:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691613296; x=1692218096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UxGQhBYaBwWbiW+29h8rgDvam6Lh5BTrkMwgzZ+zKKU=;
        b=17wFOd4uJ2OmnM2jnfFwO1HA32ON96GI7VBKk/wNCKKCwJutUYipx+fUfGIan6t9kN
         GUygXQbeo6PYGghoQs0g8BpZ+/2XDH2xM+Own6dYbA5fA5Zsr83voN3PhPhPFVPGKhkq
         rfBQv2WdoqkmbtajZL670sMrrc8+alwfVY8VQPcAua5+h9RCBjBEo7pMCVfIgzHVKoK+
         6BThnRv5CIbPDp3O0J36Yx3cYCHaK2KemXdekXmNGdg5i4vYGSSLr6+wcjv4401gpG+6
         QU6FJ96aTni83evn45fY4AeY6DSa0r/yBDwN1gsDX7AVFamDXq2RLFuBCer0OtyBH7ON
         oI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691613296; x=1692218096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxGQhBYaBwWbiW+29h8rgDvam6Lh5BTrkMwgzZ+zKKU=;
        b=d/lCrynX41wVKY7N9cGN0sg79+i/ABy/SEcMrKm0M5E6gNvZh7XBBoVIVa6mYm4VAE
         ASNR08r4ds7rmmTwhq30JNPx8vCzlfs4CR2tcgoy0py3wnIkUUeHYELp3wX2kdcAGBN3
         aqaqUp2V5k7BuIQ0qkqPrPKIWKk5KOnJaAERcMyStbrIStB8IyhB+3XPJM/q3963ZK7N
         F9CZSL+7rxkv5smnibLDONZnWKp8F5dvs74FNU7NBu9ZslfDNdeJZxnm1q1dg0iu3FUw
         65q4pZQrgI9x0lziLYNTzoRA4Df3zppL+Wgm1BkeB5MBFsCIsNvNbyAtfr7jsqDwOwnQ
         6Ruw==
X-Gm-Message-State: AOJu0Yx5F76HGUEm8nlinySTvVltc9hLVoxsGnCCYTNGZSr8Yri949Um
        jMg7Mr4r5Og9o7WE6w/d/npexMwNwpWhpcGT4LcftQ==
X-Google-Smtp-Source: AGHT+IEPfIVgirjG5t7YOHVSDyK23NQEJiu1TYdo8Lx0DyeORkWqPRcewiMJjWnBX4rBFSTKfFhxQQ==
X-Received: by 2002:a81:77d6:0:b0:583:a590:cd66 with SMTP id s205-20020a8177d6000000b00583a590cd66mr355964ywc.4.1691613296551;
        Wed, 09 Aug 2023 13:34:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s9-20020a81bf49000000b0054bfc94a10dsm4127915ywk.47.2023.08.09.13.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:34:56 -0700 (PDT)
Date:   Wed, 9 Aug 2023 16:34:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net, lenaic@lhuard.fr
Subject: Re: [PATCH 1/6] maintenance: add get_random_minute()
Message-ID: <ZNP4b8/QF73F3ySU@nand.local>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <fefdaa9457948ee5302e7cbfaae250e0b589d752.1691434300.git.gitgitgadget@gmail.com>
 <ZNFgIyuhlNd8I9Y2@nand.local>
 <8854e369-fabb-4044-a06c-eaf5b9fbde4a@github.com>
 <ZNKfxOWJAuJ5DxAN@nand.local>
 <a1e7d730-e220-48ec-8393-2d3538b80163@github.com>
 <xmqq7cq4nj7l.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7cq4nj7l.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2023 at 11:50:38AM -0700, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
>
> >> Instead of using srand() and rand() (which would make sense to wrap with
> >> git_rand() as you propose), we can simplify our lives by using a CSPRNG,
> >> which only gets initialized once, as is already the case with
> >> csprng_bytes().
> >
> > So the idea is to use csprng_bytes() everywhere instead of srand()/rand().
> >
> > I can adjust my local patch to still create git_rand(), but base it on
> > csprng_bytes() and not collide with your patch. Mimicking rand()'s behavior
> > is a simpler interface to consume.
>
> I am still ambivalent about wasting entropy for something that
> srand() would suffice, so git_rand() interface may be an welcome
> addition anyway, that serves an extra layer of indirection to
> insulate the callers from the implementation.

Sounds good to me, I'm not particularly attached to one implementation
over another. Thanks, both.

Thanks,
Taylor

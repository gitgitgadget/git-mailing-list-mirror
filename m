Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EC9C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 22:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351719AbiETWj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 18:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbiETWj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 18:39:27 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF2E185C9F
        for <git@vger.kernel.org>; Fri, 20 May 2022 15:39:26 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id i68so7463251qke.11
        for <git@vger.kernel.org>; Fri, 20 May 2022 15:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3LMY++gI/EtvhxW3JYh4fVOIvH5LjazlnGwwpB+jEWI=;
        b=QgZKRH2ncfymEh4Q54yFBsPkgJ3L9bR998B0VcNeb6rGESkyf8K+hCRauyTQTRLsJK
         zLb6e1pdoOBIVWI/YcpLmMIwyWalmjPvyoXlBX2ZWBmHUdhScPCL1Dsov4+lnIXyA2hU
         6KEsyuagGkSG9Ds8vHxaU+9d0Q3C3DJ8vNeQz9nVbbyhYp92dgwJftuRbz8bRkV1qm0W
         hvuZmDkBzcXxpA4pEgTYNXdvo+/hCm7p5ZHuvnYNG3wkBboyn+dyaySW3f9xnyZdyiF3
         0Pau6g2QfJE9nX6fqNCD420epy5gtuJD3BJERatv3gURZ0t/Tw3otnSBW69HrxtICUZL
         HDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3LMY++gI/EtvhxW3JYh4fVOIvH5LjazlnGwwpB+jEWI=;
        b=6kkmSrhO7Gf+lox43VuTmOei9D6Q8RUh8FQO0RSdHGXTAD8NRjbxYm0+AAnV6/kfdI
         mm+xC/v9TOJKtTT1d3QESI6W6Q6sH3qmxwMeLXIHC4YSQP4W0CpGps+IS9dQweJsimUi
         e+gytu3Bhq4Thgt6fKYJCu1tuYRolHbKddzR13XTDgSEcGh86yJRyK7LKV5NIc2jxnwy
         CbQVGLKNPvr0vcevMg0vaIjbdzlMVGQab+F0qJ6n/nNWFiKHa1hsM7swfaFs/nzcRzEP
         jnMvVfJRVULjtH3//2l2JiW1ggTO5x7q1nXjbUjOt8PfLmbe9wQuuZTfuXep4Pdw+tmg
         V1PA==
X-Gm-Message-State: AOAM531iacHr0MrFoikel6Xpj4WE2kieYvoloZ2KdQjehLFgtRGKFfGn
        oilnSpK0CGCIvHm+wOh5UrahQw==
X-Google-Smtp-Source: ABdhPJwRxRXx4aUVpwnsZ8llHLUKoPqh1zfxfV7+Qb/0Qu2cfdal57g8Bn+QovkAAdUhPBZ8lZWvbg==
X-Received: by 2002:a05:620a:1672:b0:6a3:42d2:57b6 with SMTP id d18-20020a05620a167200b006a342d257b6mr5321037qko.623.1653086365634;
        Fri, 20 May 2022 15:39:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f17-20020a379c11000000b0069ff8ebec64sm391227qke.103.2022.05.20.15.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 15:39:24 -0700 (PDT)
Date:   Fri, 20 May 2022 18:39:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v4 12/17] builtin/repack.c: support generating a cruft
 pack
Message-ID: <YogYm50szub90Ift@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
 <5992a72cbf9e8d076f1e312a789b40d52656ad3c.1652915424.git.me@ttaylorr.com>
 <220519.86v8u14v52.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220519.86v8u14v52.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 19, 2022 at 01:29:26PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Wed, May 18 2022, Taylor Blau wrote:
>
> > +		tip="$(git rev-parse cruft)" &&
>
> Here we don't hide the exit status of "git", as it'll be reflected in what's &&-chained.

Oops! Nice catch.

> > +		path="$objdir/$(test_oid_to_path "$(git rev-parse cruft)")" &&
>
> But here we do, as we'll get the exit status of test_oid_to_path. But as
> we just rev parsed it shouldn't this be $tip in any case?

Indeed, this can just be:

    path="$objdir/$(test_oid_to_path "$tip")" &&

Will include in a reroll shortly.

Thanks,
Taylor

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D9FC47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 23:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CCE613D4
	for <git@archiver.kernel.org>; Thu, 27 May 2021 23:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbhE0XHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 19:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbhE0XHE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 19:07:04 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFC0C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 16:05:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ss26so2586462ejb.5
        for <git@vger.kernel.org>; Thu, 27 May 2021 16:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=I3Yrbno0hFNQo26ucshpz2Oan+W86QvHJkXXK//6p/I=;
        b=Zxqlli5so4nv5Nn4X1BJTW6CzQisPFfSDy9/3lZ9xVyuD2vRJrtXAYJoedYxmDmaT3
         KoHfbnSWlwBWQ+zV8GmmOa08NJf6Pp0UPvtORKTIElM3As7vTXtrHpM9bv3TPiVB3zsg
         uxFO8rBX/h9vmzUNQT3x4eaiLm0e7re5DexMKqS0WZexf/WmLFOQJnBmQ3/aGduo9K3r
         iJYCCTgI5dErtNZM5GRtOcoqKzV00e59cK4OCyjSug7SntB/P2rp8gFC0xSt3QA/lnTm
         4FggXasytGMUtsTziudLwyOhXH4Z2mCoDMJDhB4knd9ttSHB6EEZy2K49rE/z7hNTyXM
         gT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=I3Yrbno0hFNQo26ucshpz2Oan+W86QvHJkXXK//6p/I=;
        b=MMKFRhmtX5RkpZ3SZWFce0axsv36ELLtCg2uqQOSQmJtdIUCWO2uBqrseXfPJ9TwEo
         ULx763ChAMm1toHIMGIV9DZ4Nf+U5rUaNW0jS/jYzXCoN+KWmDJvjPIuGfzYYstb3XO2
         UZPg7UdRLuzAG6Zwq/KY2B4frCJR7kauH3MYeq4YpEhEbs4KM8Xzqwak7MgcaQqMgIX8
         qOdrjvkL75GfUWSjgY5xBKF1Ma+lFbh0rqleYPvuHsZZQ9TBosoLLkeR9GL8Mib4h3Tf
         gVTuV37KGYzzBaW97hYLCS3hqtrBFYUr5m3ezinBtdBrqcHvNf1CUhar0LVj0XC1sgZ9
         O25g==
X-Gm-Message-State: AOAM531Fy8mk3Qtm4Zi+gprEs95UFKIuZMmGiC+hZjsZnC8FS9Gc4n1i
        pKjn/e01+V97ytPANY2alnIyL5Vraj+AUw==
X-Google-Smtp-Source: ABdhPJyGJpWW0ntt0SfvcKL1L2vx4KbEI8jOXRsrVd2lw1Nq3nBcAV3ye+m0W/IwxVzO+LdlfxZN1w==
X-Received: by 2002:a17:906:fb88:: with SMTP id lr8mr6390476ejb.429.1622156726548;
        Thu, 27 May 2021 16:05:26 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c6sm1604050eje.9.2021.05.27.16.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 16:05:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 22/37] read-cache: convert post-index-change hook to
 use config
Date:   Fri, 28 May 2021 01:04:40 +0200
References: <20210527000856.695702-1-emilyshaffer@google.com>
 <20210527000856.695702-23-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210527000856.695702-23-emilyshaffer@google.com>
Message-ID: <87fsy7lqve.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 26 2021, Emily Shaffer wrote:

>  Part of the linkgit:git[1] suite
> diff --git a/read-cache.c b/read-cache.c
> index 1b3c2eb408..6a5c9403f4 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -26,6 +26,8 @@
>  #include "thread-utils.h"
>  #include "progress.h"
>  #include "sparse-index.h"
> +#include "hook.h"
> +>>>>>>> 9524a9d29d (read-cache: convert post-index-change hook to use config)

This adds a conflict marker, which is removed later in the series.

Obviously a trivial mistake, but it's a good idea to use git rebase -i
-x 'make test' or equivalent for such a large series, perhaps there are
other inter-patch issues lurking here...

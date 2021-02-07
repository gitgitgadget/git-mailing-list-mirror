Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83D5C433DB
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 21:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 894C964E2E
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 21:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBGVOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 16:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhBGVOn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 16:14:43 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D116C06174A
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 13:14:03 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z22so15834364edb.9
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 13:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y351KIK42pNsUH9Vo8oMqiMcqy1pEf0/ecgLoJqstYk=;
        b=IEypOQCDy5002soBgS495PgvZg60ReTyufAmqo+uQod5i08Lvsu2crbGqTU17knc4S
         y9Tr3XVMg+yjkH0g+/Z6//wy5atz01OVhqv9aqtB2TV+VyHK7IeRUkfCmHLF3tGsDiSh
         cQFUFH4txw8kD0tn6P5y0SVXYbQrY/11/4vI3JImqNzyMJBE5aRx5KaMbf1pfqhiEdMO
         X0Rz0VLvW0M9lGi5rNuqNYBdZmYyDaCFYbo9vj3b0YYI452DJdEne+WtTtuSMapYLN1w
         Wbgk6fSZ+XKRlG5JndpT3ugxINygn8MtKLc4kTdulKKHk4kUM8HW7BAVo0QCCVOda6Gu
         kk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y351KIK42pNsUH9Vo8oMqiMcqy1pEf0/ecgLoJqstYk=;
        b=jidzAMV7aQ3vnmFgtUUQ18knPF9GIUkmk9VT4LGbXOvQzhFwmGGUTdOLLZagYIdrfJ
         jg7GUUy2aw44RFmqDckfH2l/dHuvj+zFm9Kw+Y5r3nbXREh6A7fNPMXiaLg5YSZ8HR0l
         MV8G1pGVaBx4uTzMCpaWym0B5jphwc05pW22vjdOsegCUts2wMpCtloW0rWc6F2mFcVl
         FZugjby667SDocbm8cK3MCdrLceIc/wIoyZQmOWtEFh+BUl4Y2C2r1OK0AsTNLPvlE+2
         9igV3kiAZkZLYtuq27M9p6WuvDiwtlRcgWMaL2WdWUtluDkxfbqMS6nriFxvowBAsLok
         VZ1A==
X-Gm-Message-State: AOAM531cXUdHcIgF/xDDAM1lL/5YaAltSnggohzdGSE2I+JMM8L1jfYv
        Vcgqhsk8j5NlM517kQUHOsoQHr9dfqE=
X-Google-Smtp-Source: ABdhPJzMDRF1igt8cMWIchwbQUZGzdK9hmfgx8pPpnvMsiSdgFyViimdWurPFweUy27U0wZmTQLhXg==
X-Received: by 2002:a05:6402:2690:: with SMTP id w16mr14337870edd.304.1612732441707;
        Sun, 07 Feb 2021 13:14:01 -0800 (PST)
Received: from szeder.dev (62-165-236-114.pool.digikabel.hu. [62.165.236.114])
        by smtp.gmail.com with ESMTPSA id r9sm7286697eju.74.2021.02.07.13.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 13:14:01 -0800 (PST)
Date:   Sun, 7 Feb 2021 22:13:59 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        l.s.r@web.de, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 02/17] chunk-format: create chunk format write API
Message-ID: <20210207211359.GD1015009@szeder.dev>
References: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
 <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
 <16c37d2370cf4fd5fc309ac6dc8aa6443ffcf3d7.1612535453.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16c37d2370cf4fd5fc309ac6dc8aa6443ffcf3d7.1612535453.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/chunk-format.c b/chunk-format.c
> new file mode 100644
> index 000000000000..6e0f1900213e
> --- /dev/null
> +++ b/chunk-format.c
> @@ -0,0 +1,91 @@
> +#include "cache.h"
> +#include "chunk-format.h"
> +#include "csum-file.h"
> +#define CHUNK_LOOKUP_WIDTH 12

As this macro is defined in 'chunk-format.c' it's not part of the
chunkfile API.  However, at the end of this patch series
'commit-graph.c' still contains:

  #define GRAPH_CHUNKLOOKUP_WIDTH 12

and uses it in a couple of safety checks (that didn't became part of
the common chunkfile module; why?), while 'midx.c' contains:

  #define MIDX_CHUNKLOOKUP_WIDTH (sizeof(uint32_t) + sizeof(uint64_t))

though it's not used anymore.

I think we should have only one such constant as part of the chunkfile
API; and preferably use the definition from 'midx.c' as it is more
informative than yet another magic number.

Furthermore, being called 'CHUNK_LOOKUP_WIDTH', I had to look up the
places where this constant is used to make sure that it indeed means
what I suspect it means.  Perhaps CHUNK_TOC_ENTRY_SIZE would be a more
descriptive name for this constant.


On a somewhat related note: 'commit-graph.c' and 'midx.c' still
contains the constants MAX_NUM_CHUNKS and MIDX_MAX_CHUNKS,
respecticely, but neither of them is used anymore.


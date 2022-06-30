Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C459CCA47B
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 06:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiF3G7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 02:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiF3G7L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 02:59:11 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BD419C11
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 23:59:11 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l2so16714720pjf.1
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 23:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CxBx98AAkv8x5QnXQ6YLIDr/Qg8RosJFsmtENihUQB8=;
        b=JSHeKLMLl8QC21aYZcTEm2nUjOmosHpyAMwtdo2nkQ6BkFJmUs+m/WX4jRj0hH2rPl
         VeXnu6+yc9atiWtDUFJ1Fvm2pa2P1eePDz/mJ3WPVv8DrpzGE8LCSlXW+IgkWGkZWb/B
         kABWVkCfO0CKn7SHiyTpg6pQyvspQguoGRYFU6kiZcURF7/0fXLCGcfyyrPITGlE3xF3
         Qd2R/RbSBbErH5QHRxsMqxdqozOJjLR4BUu5MpwfLvRfoQmOHaHWZolU4rnHJslQb9C6
         bIe5CNLy75WFwzhPqBCdMv3MoZ8eomJfb7hKIIzjpXzSws+SD29J/QUFMOUu7NNxx+5/
         XcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CxBx98AAkv8x5QnXQ6YLIDr/Qg8RosJFsmtENihUQB8=;
        b=zdyneLz1w3j+OwOY5/SU9qzB20iwGPT5siOt8GxtpCKz3VkXG6um7EzV4oa2fuzfQW
         TZq/FFdIWaNFk+vRIumvRVzH4J00OCWXHCcEUAaaj4KBzQc78VWqOCSjr/k2L11QkhBa
         8xPgjW7fIKPCd8VS8D4dACT/AOYw6FQzL75fyoueCwx6BrmHDoQ/SW7jVlyH1DyBhL2U
         /ckfsPmR3kXJZJqZuAhNc556cSWx9Y9vHIYemFVQNmVa7w4xfwv8a1a+4m/3GPj2axkQ
         pqpriUJ412RM9qzJJVb05niqmFK/drKI9/pMWfBMu4rfF1LIdUddJt/hjE6sqh+rOyaB
         uLmA==
X-Gm-Message-State: AJIora/BVRtfXjZ15iPQuEfV/8U5cFYbxQzxHiaXXuwfDpUxM/im3bnI
        J1g7jCCTZrm60d+V4c73/Vo=
X-Google-Smtp-Source: AGRyM1tE3f42ModVWWaMcs+D6nOT7kMkTSyN3Z86nZOr8WWe3/J8KnilKY8Q1wnt1vkPnF+13wECiw==
X-Received: by 2002:a17:903:1c4:b0:16a:73fd:3c6c with SMTP id e4-20020a17090301c400b0016a73fd3c6cmr13016929plh.115.1656572350429;
        Wed, 29 Jun 2022 23:59:10 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.154])
        by smtp.gmail.com with ESMTPSA id 20-20020a170902ee5400b001690a7df347sm12612870plo.96.2022.06.29.23.59.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jun 2022 23:59:09 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 4/6] pack-bitmap: prepare to read lookup table extension
Date:   Thu, 30 Jun 2022 12:28:33 +0530
Message-Id: <20220630065833.6333-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Yry0bKgayLB3GdsW@nand.local>
References: <Yry0bKgayLB3GdsW@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Taylor Blau <me@ttaylorr.com> wrote:

> That shouldn't be the case. When you have a chance, take a look at the
> alloc_nr macro, which shows how much memory we allocate at each
> step:
>
>     #define alloc_nr(x) (((x)+16)*3/2)
>
> Suppose we allocated 16 slots initially, so nr (the number of entries
> stored in the list) is 0 and alloc (the number of entries allocated) is
> 16. Then when we try to add the 17th item, we'll pass 16 to alloc_nr
> which will allocate 48 slots. Then 96, then 168, and so on.
>
> We only have to reallocate and copy the array when nr > alloc, which
> should be fairly infrequently, and happens less and less often the
> larger the array grows.

Ohh, I misunderstood the ALLOC_GROW function. Thanks!

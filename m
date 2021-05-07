Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00D1C433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 12:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7878A6143F
	for <git@archiver.kernel.org>; Fri,  7 May 2021 12:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbhEGM5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 08:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbhEGM50 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 08:57:26 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21EDC061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 05:56:25 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id a11so5090470plh.3
        for <git@vger.kernel.org>; Fri, 07 May 2021 05:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=zSQwOsaS3YadaVy2p1NoWxdSnYq9sKMoDa7xlSWC97g=;
        b=mpit45ydk4WdDfvF4dAeeLQPVW19YHfmxBLEFGscUueHay8ATndgAjgX2zQLk2v7c3
         wnhjreRdTgdfSHdHahFYDxgspX1KaFG0rJDToEheRD2GtEWcy1iSQRvUTwFDX2FfiKdy
         AWP7JuVndkx9YTIedpsh4W0Oec1eRZ7SNuo/wqwinPqWWtr/Uow7bqE6dUckAIbg+A6x
         zA5gdzX+rDPqga+EPgE+NRQ1lHqCNEdwA/Uk+QNrlfLXpbVgF0VlQhvWu6PtY7rkipJW
         /f4u6hsEqJsaliDj4a+EICXqD3V53cUuUTncgHSFf9JcIYdqL+HhNK8L8jCtOWpg4oO2
         l0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=zSQwOsaS3YadaVy2p1NoWxdSnYq9sKMoDa7xlSWC97g=;
        b=i4kDvKAH3hJuk3BIyfGmk4IRSepz5DEEZo6jkPVa1S+vFcjI15xYTCIOQkxiVjyrDx
         ArWAdEKDAW/mZ1MPzifkwBvVU/Tt++0p3dOd5q8CfjGdwPGCi6SAOhsO16SdjQM3ZBLJ
         eGp23k9qnSF3SB/Tu/OJXdSUOUVGD7azDi/pH3WyVxtaVXFbDd3ylMd33kASQcxxzdH6
         uYpvh9aJxNDNunBg5DaVS/F0a69UUIKNFeEiqMhGfoxJnGiQCW5UAqpxCh1O7v5Np8aI
         afItSBe69ZanDDaO7iXvB9m/4KO4lx2nFn1y2TCGa9/87yYR/4xcgG480RL9CO2lV6PH
         CF2Q==
X-Gm-Message-State: AOAM533nQTwaSXaSmqsyNyRuBVMqfF4yc5STI/A2GEjQJ3vpCm7nB0lH
        7oXO5wat9cRKU9GOMfzaoE0W7EhHktP0Zg==
X-Google-Smtp-Source: ABdhPJxZfYgBBAF/YLWVOX3uYaTGW4lmBVZ8l7bZZoHh+pDPE7fuSzs+iSmB+UcwVwilwA6GfmIoXw==
X-Received: by 2002:a17:90b:956:: with SMTP id dw22mr21022879pjb.211.1620392185223;
        Fri, 07 May 2021 05:56:25 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-23.three.co.id. [180.214.232.23])
        by smtp.gmail.com with ESMTPSA id a129sm4972860pfa.36.2021.05.07.05.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 05:56:24 -0700 (PDT)
To:     Git Users <git@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: "bad revision" fetch error when fetching missing objects from partial
 clones
Message-ID: <6422f505-29c4-bee9-e28c-b77dd831c246@gmail.com>
Date:   Fri, 7 May 2021 19:56:22 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a copy of Gitea application repository [1] on my local Git
server on my computer. I was playing with partial clones using that
repository as remote.

I began with blobless clone the repo by:

$ git clone https://<myhost>/bagas/gitea.git gitea --filter=blob:none

Then I tried to fetch missing objects. First, I gathered list of them:

$ git rev-list --objects --all --missing=print | grep -o -P '^\?\K\w+' > .git/missing.list

I had asked how to properly fetch objects from the list above before on
this list, and brian m. carlson (CC'ed) suggested [2] that I should
use xargs:

$ xargs git fetch origin < .git/missing.list

I expected that I received all missing objects. However, the error message
I got was something like below, repeated:

> remote: ...<skipped>
> Receiving objects: 100% (64/64), 154.49 KiB | 2.97 MiB/s, done.
> remote: ...<skipped>
> Receiving objects: 100% (37/37), 168.35 KiB | 4.95 MiB/s, done.
> Resolving deltas: 100% (5/5), done.
> Resolving deltas: 100% (49/49), completed with 47 local objects.
> fatal: bad revision 'd5e9cd36ab21839af3d116eff3221c53f6ca7fd6'
> error: https://<myhost>/bagas/gitea.git did not send all necessary objects

Then I repeated the object list gathering and fetching above, and the error
still occured. Even I tried fetching only one of problematic object above
and still errored.

When I inspected that object with `git cat-file -p` from my other, full
clone version (which I used for submitting changes upstream), the object
is properly displayed (in this case as source code in Go).

Note that I have uploadpack.allowfilter=true config on the server.

Am I missing something?

[1]: https://github.com/go-gitea/gitea
[2]: https://lore.kernel.org/git/YD7bczBsIR5rkqfc@camp.crustytoothpaste.net/

-- 
An old man doll... just what I always wanted! - Clara

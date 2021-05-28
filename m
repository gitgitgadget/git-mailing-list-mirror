Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A806DC47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84BED610A2
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhE1MsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhE1MsX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:48:23 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E342C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:46:48 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 6so2459474pgk.5
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yPMnIZ2u4wkqbn/ozw7JesNtrlktDMidw8ukRJSa014=;
        b=R/Gk243JwqoAPMdScXu0+YFLJnEWiSjhIo4pcLzV+Uk02uJ2jcbGClYmGktq/zoL9a
         dxmwJ5DRLqC9PHKJFdLPg7FJ9zBvXBUmShdhwfTp21rtfW0OBRq3WtFFn5tmMsUd8//E
         OzqxXjl78ld4iY/Gzuq3ChjuKWaYBnavp8uj439AwpAElgTIyc6bkNX/mG6FYQbWoTKS
         y1e9QI24lA3zjGIcA77c5oWWhgkk9+y7E3lVGFTmhDIVVSFtFvEHPCQlcOzieJSNWr+o
         vmsDudJoydPHLiwXgUFkr3Vyz+M1rjwdDfKrSBFMHW4VgpeiQa4AsRx0sYqFdnqN6Gnf
         IzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yPMnIZ2u4wkqbn/ozw7JesNtrlktDMidw8ukRJSa014=;
        b=rk+PCLhyN+gVuFq4UYVZHe5lBHk1Em3JopmPBEL76maE4iqXUdY32tkbfb7OSqxRg2
         XtSL9s/H9khZsSueHjeh3tRzw/lX5pQafewgz4hHm8MOthkUVLQ5mZhWBubgc/jGsSll
         YouVuQOrQ4sPrcO4iDzi/re/P8N/Dw+p2Vs9/08360HvXsszzMcT/8lp703pDajxE8Zq
         zxxzDC1JuTlDswOlQYtCe041lN6ntyAYL5BG6lpNesaWP8vbBrVMai6fECFlHc46s5zl
         9x6fxgiV0YL/zhwu1TPLTVZOZFWBfHOkgvTHJcOuuT6euXG10nRTA+QYffeWXyL8PU8A
         s6gw==
X-Gm-Message-State: AOAM530m3lIyfdn/pRIQ+MdnIRelmfyraVTOBWOm090o5QH48WZ/Hf2E
        BK35YoudjKaW7+Wxs+3iEqx/9bLV2bL2Hg==
X-Google-Smtp-Source: ABdhPJxYABVLV4bC15vZAV5D/8Whtnct+NuYKRvG+IKmT8Qj0+XkRMO+skXac2EtEc2SGhm6G4QV0A==
X-Received: by 2002:a63:7456:: with SMTP id e22mr9045240pgn.193.1622206007651;
        Fri, 28 May 2021 05:46:47 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-74.three.co.id. [180.214.232.74])
        by smtp.gmail.com with ESMTPSA id c3sm4242271pfi.213.2021.05.28.05.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 05:46:47 -0700 (PDT)
Subject: Re: Fetching single tag in shallow clone almost unshallow the clone
To:     Derrick Stolee <stolee@gmail.com>, Git Users <git@vger.kernel.org>
References: <304633fd-e677-7956-6787-f60f195db9b5@gmail.com>
 <d641512e-657f-6dfc-adf4-1b1889439553@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <524c529d-e2f3-3432-55c5-cb05fe8ecf02@gmail.com>
Date:   Fri, 28 May 2021 19:46:44 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <d641512e-657f-6dfc-adf4-1b1889439553@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

> You should add a --depth here, too. Git doesn't remember that you want
> a certain depth, because that doesn't work in perpetuity.
> 

OK. I can specify --depth that I want, but often I forget how deep my 
clone when fetching tag with --depth, so that it has the same depth as 
before fetching tag. What should I do?

> You are hitting the issue I documented in my comparison between partial
> and shallow clones [1]: The commit history for go1.16.1 goes "around"
> your shallow boundary. See the image immediately above the "Comparing
> Clone Options" section.
> 
> [1] https://github.blog/2020-12-21-get-up-to-speed-with-partial-clone-and-shallow-clone/#user-content-shallow-clones

So basically when I request fetching something out of shallow boundary, 
Git "unshallow" by fetching the whole remaining history (but not implies 
--unshallow).

I found out that shallow clones perform on repos that have linear 
history policy (that is no merge commits). For example, on linear 
history repo, deepening shallow clone with `git fetch --deepen <n>` 
deepens the shallow boundary by <n> commits, whereas on repo with merge 
commits, doing the same may drastically zig-zag number of commits on the 
clone (at one instance can be more commits, at the other can be fewer).

-- 
An old man doll... just what I always wanted! - Clara

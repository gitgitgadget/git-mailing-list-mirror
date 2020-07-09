Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86408C433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 18:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6009B207DA
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 18:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSxzVhyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgGISB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgGISB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 14:01:59 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E127DC08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 11:01:58 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id k18so2688770qke.4
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mqbuMI1+BoOQl9sHzTukheBaRRVIAhgMP4o5Mr1aUJg=;
        b=VSxzVhyPl2RPb2xOYUMGN62YHrXcEGdvMo6BbE3q13YNZnrzPY9dV//5t83r73R/Ir
         +AVQ27X+0Ca64yu+nBI8v02Iv6zj+jlVaFKWbsBBitlE+8Q8crkHVNpK1BXaf9gDsAeJ
         lywxX6zGvJwhYW4lL64PolVUxMv+rJTO9IfslL4Ai7D2oLI1MVnA30ZcUtNMIiJ+aYM5
         APTcwLxMJ2OPzi+fz3/AoohOsjj9GU2ndoJaeqowuheFCCfGPNT3aRo7GDov4sSOKr0A
         NXWfVlBS3WEjkTcwwEfQpCW+kbKYxCVccg25ZL9zaarQB6i8cJX2ffUXIhVhoGrEzDuA
         tsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mqbuMI1+BoOQl9sHzTukheBaRRVIAhgMP4o5Mr1aUJg=;
        b=kKZYR8Byx8ORfOfdpkbmhO/Q867hpvNVcbf3qcjzMOHYYuaibL1AEkhFnk5aFDU7HX
         VhMay2Fix6NCBdKlI6V75LnFCeR8L23EdJRc4F1lvZZxAMgNS+YOxOBrOFO+ZAgCUKVV
         E+5L8z8iNmj5MvqhuIxGj7dNtJNSi0bGHTOHhoWDfHpHQvdsUMJ0sHwLtzwR+RZvhayy
         EHF5qinl5TNtt+eViv5PMBcpHaDPOvwmcHnx3iLtUkgtW6Kk3VSJIej7Tvdy4goyPtzC
         dLYErB7EM4qpBlb4pYuB6Ocl+OdTeTmsM80MoYBUSRZoD1JauCKaSyxG45O0PahUrfPP
         +hsg==
X-Gm-Message-State: AOAM533pZ9c1VllV6UN4n3BOdgW1jqXXGeohfe/fcCAQzytQHU1ecwHC
        shMxG/W7fkcLBvDHLJubzHBVM84ph4J1AA==
X-Google-Smtp-Source: ABdhPJwHF6bW43rYS8uNqayYrwteuGz/4gwoOrDSdI+r3NbDCkp9FiD5Pct++R2eB6bovtbW9sVpFw==
X-Received: by 2002:a37:8a06:: with SMTP id m6mr59900609qkd.191.1594317717704;
        Thu, 09 Jul 2020 11:01:57 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id b7sm4397589qkl.18.2020.07.09.11.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 11:01:57 -0700 (PDT)
Subject: Re: [PATCH] commit-graph: fix "Writing out commit graph" progress
 counter
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>, git@vger.kernel.org
References: <ff6b96aad1e2317d3ed36c2c8b419905dea84a83.1586192395.git.gitgitgadget@gmail.com>
 <20200709170003.3020-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1b683731-776b-0058-5744-094091c7db4d@gmail.com>
Date:   Thu, 9 Jul 2020 14:01:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200709170003.3020-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/9/2020 1:00 PM, SZEDER Gábor wrote:
> 76ffbca71a (commit-graph: write Bloom filters to commit graph file,
> 2020-04-06) added two delayed progress lines to writing the Bloom
> filter index and data chunk.  This is wrong, because a single common
> progress is used while writing all chunks, which is not updated while
> writing these two new chunks, resulting in incomplete-looking "done"
> lines:
> 
>   Expanding reachable commits in commit graph: 888679, done.
>   Computing commit changed paths Bloom filters: 100% (888678/888678), done.
>   Writing out commit graph in 6 passes:  66% (3554712/5332068), done.
> 
> Use the common 'struct progress' instance while writing the Bloom
> filter chunks as well.

Thanks for finding this. It's a clearly correct way to go,
and is one of the things that did not get updated properly
between the old prototype when applying it on the new code
that included this ctx->progress pattern.

Junio: head's up that this will conflict with the final patch
in ds/maintenance. I'll remove my edits to these methods in
my v2 to make that merge a bit easier.

Thanks,
-Stolee

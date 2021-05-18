Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F9DC433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 14:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA79E61059
	for <git@archiver.kernel.org>; Tue, 18 May 2021 14:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239839AbhEROqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 10:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239868AbhEROpt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 10:45:49 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BC5C061342
        for <git@vger.kernel.org>; Tue, 18 May 2021 07:44:20 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a22so9445720qkl.10
        for <git@vger.kernel.org>; Tue, 18 May 2021 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CwchrDUWHBudyi7SNlYXm/yWEJ7ZxzhI9E37lH5DP/o=;
        b=b2SCSW1HGxGmw2S8BoWaMcoNy1xg0m+gq52W81tLcXSsLLcKZ3d+57FkwOVh5gb1XP
         oCGMZEKLcKD9odqWogWswnGsqy30Eq/NWZlz2Bu2L97Ruu+fih1gJMwoZQg/BatmhqrL
         UEKJiO863X2vckL0Ae+4molqYTtl12G6gkTHejAsuAciUQx9SurUy05bcKKYHvCcm4X3
         e9ILxMM4hdwiSoub2s1ViZpQ1sJg3oDI3TmjT2S5DacTygoqDwrQARCyoSvnXoP1Ci42
         gfy2X++Nbhv1zBVi3xVMmPSlY38r/IVezalZMiFUkWHrlSDrrVOEFvtO9JmyMMBTyZqV
         DPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CwchrDUWHBudyi7SNlYXm/yWEJ7ZxzhI9E37lH5DP/o=;
        b=eOtSLemo6byj+V3CyGLhW3KSUz3tpSwQTdLtnWGTOL8ZctQNcbGgKX7tO4uVb/ESjm
         U5JyJafCGBuCD0cfTrQluy3Em+CUyFhXXYq121nxptaGIZhk5TyD699wk5napeBSAsj9
         zu6vU5datFfH4ZmjAOT6XpwezZJM/eouA+LoJUnTWelr6+rcXw7bsdzLYvX3huD4OmMe
         ZGWKCHow9bGXqftRaeMMbWUi0OawuaKctidVYJjFyZjljIIcPCn3dFI+cxm2P+tVAjfB
         g6rp7mLf/NYtd2YywAhVYd2WWrR0Pmriop97Tg2/vL09luGejRMqneG1d5SsTnpK9p3J
         eaoQ==
X-Gm-Message-State: AOAM532qqvHGcHpUlPPpK1Y2Y/XB5DDjw+PrNq1w6BGwOUgomE5Z7Fg/
        VnB+3bH+sdg2q7tFNPM1BzM=
X-Google-Smtp-Source: ABdhPJx8OeQEA4fgEzzj1zMbyt3CZIKiDAa7zgEHJKnvIWpHPNSKfQP9F408iKG6pZD2+I1IPKPBBA==
X-Received: by 2002:a37:a604:: with SMTP id p4mr5661992qke.408.1621349059879;
        Tue, 18 May 2021 07:44:19 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:bcf4:c194:74a1:9906? ([2600:1700:e72:80a0:bcf4:c194:74a1:9906])
        by smtp.gmail.com with ESMTPSA id p9sm14358821qtl.78.2021.05.18.07.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 07:44:19 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] csum-file.h: increase hashfile buffer size
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, git@jeffhostetler.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.916.git.1616785928.gitgitgadget@gmail.com>
 <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
 <9dc602f6c4221e2259778842ec3d1eda57508333.1621254292.git.gitgitgadget@gmail.com>
 <xmqqk0nx58lq.fsf@gitster.g> <YKNtxUtDXoWwaVrc@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6baf7f30-f183-b827-9495-96502ddf1756@gmail.com>
Date:   Tue, 18 May 2021 10:44:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKNtxUtDXoWwaVrc@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/18/2021 3:33 AM, Jeff King wrote:
> On Tue, May 18, 2021 at 06:54:57AM +0900, Junio C Hamano wrote:
> 
>> Just after the previous step justified its simplification of its
>> progress logic based on how small the buffer is, this step makes it
>> 16 times as big, which felt a tiny bit dishonest.  We probably
>> should say somewhere that 128k is still small enough that the
>> rewrite in the previous step is still valid ;-)
> 
> I noticed that, too. I'm not sure if still is small enough. For local
> pack writes, etc, it seems fine. But what about "index-pack --stdin"
> reading over the network?
> 
> Updating progress every 8k instead of every 128k seems like it would be
> more responsive, especially if the network is slow or jittery. I dunno.
> Maybe that is too small to care about for the modern world, but I just
> want to make sure we are not being blinded by the fast networks all of
> us presumably enjoy. :)

This is a good point.

If we combine the earlier suggestion of using the heap to store the
buffer, then we can change the buffer size based on the use case: we
can use 8k for data that might be streaming from a network, and 128k
for local-only data (index, commit-graph, multi-pack-index are all
probably safe).

For the case of NFS, I think we should probably assume that the NFS
server is not across a slow connection, which is a case we cannot
make for streaming a pack-file from a remote server.

Thanks,
-Stolee

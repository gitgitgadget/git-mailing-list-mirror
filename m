Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D078C35669
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 01:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5A02072C
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 01:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZDPtY0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgBVBoi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 20:44:38 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39364 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbgBVBoi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 20:44:38 -0500
Received: by mail-yw1-f68.google.com with SMTP id h126so2184242ywc.6
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 17:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D9GKSPIZONbxVXHt2cvtBfxKy/vOKNeSRsPfBGFdnmA=;
        b=MZDPtY0kppGsMLhWEfMN1IBgySXV98uTfzUzWtdHGBJIODL1ggLiw/8MVsyM6UCniY
         C3eOrgxfnxdQsUwZmIyw6Bg/nAhctzUPMUQOASPbjJYmO/nd4CMM3We7Vs/Xlw1vXQpr
         RzOvfitzAkMcvg30i20lG1oyCXHeSu/+LpC+gV90mcWYmd3yKvx6JDU2hftIFXvsIuo+
         VmgBag06nb2O+nDLF66gTsRIvxnSUag8dQ/j6EqVxUdM4qFeRqgPv4gICBaqkSqSzvSw
         v2YIvF2xWGbl2FzldvIcmiDCGexrrtQ9X6wHM/zgZctPvzvFtXrjd4hIqld4woFOwL6J
         BRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D9GKSPIZONbxVXHt2cvtBfxKy/vOKNeSRsPfBGFdnmA=;
        b=INQpmnE0ijkfI2GIrOxGyEGz5iXrFPKVIxHbq6VFDJkg6tuqxgActApeej9pTyzt3R
         I9wIsA58Lj0GKh+eaU7sI4YqQAQgFZA2f3uE+wqK0o0b2eRjASCwlOInOke+K1u1JUbH
         UOVMLOxNJghxZrN8cat4niVX3DSzMEQydCdwda0jsXqgr1MzMOYi4qrePuHYr5WgC/Ii
         IkNaboXisr4Ul9/+xDV/wpVMrc4AU7hDOpQXDsLYBPmZVQBdURCA9CcR5y+ZDNisjBZj
         Rr4Dp4ZOwpi6eHhNyZjokuGJ/3G/3nxQ/K1tFuAwrx9AknkWg4YE4oitYPxTrw2aO9Dp
         1k9g==
X-Gm-Message-State: APjAAAXg+eLjc6BA1JQ/qUioIVaDqWFg18OzNi5xnXxnaARPp3gtpKZR
        xFaVDZP4KShqEzRFTHT6qcE=
X-Google-Smtp-Source: APXvYqwIIudjdS7mdGqRvosfWbwItLyP5hfLOS7v7AuAMftBjHcNV8r2s9Za4m1yIw2MZHd2AoYEjA==
X-Received: by 2002:a25:da0d:: with SMTP id n13mr36221888ybf.115.1582335876927;
        Fri, 21 Feb 2020 17:44:36 -0800 (PST)
Received: from ?IPv6:2600:1700:b00:7980:25f3:c564:ed3b:ab96? ([2600:1700:b00:7980:25f3:c564:ed3b:ab96])
        by smtp.gmail.com with ESMTPSA id u136sm1988160ywf.101.2020.02.21.17.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 17:44:36 -0800 (PST)
Subject: Re: [PATCH v2 09/11] commit-graph: add --changed-paths option to
 write subcommand
To:     Bryan Turner <bturner@atlassian.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Users <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        jeffhost@microsoft.com, me@ttaylorr.com, Jeff King <peff@peff.net>,
        jnareb@gmail.com, Christian Couder <christian.couder@gmail.com>,
        emilyshaffer@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
 <3d7ee0c96955dc15c87d04982d8cdec8b62750b2.1580943390.git.gitgitgadget@gmail.com>
 <CAGyf7-FzaG3Jb92JTx1QyADAoLhHCREyadVbTM2vZW-wxK4zEg@mail.gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <c3a222e7-a782-2c25-e809-8eda4ce418ce@gmail.com>
Date:   Fri, 21 Feb 2020 20:44:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAGyf7-FzaG3Jb92JTx1QyADAoLhHCREyadVbTM2vZW-wxK4zEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2/20/2020 5:10 PM, Bryan Turner wrote:
> On Wed, Feb 5, 2020 at 2:56 PM Garima Singh via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
>> index bcd85c1976..907d703b30 100644
>> --- a/Documentation/git-commit-graph.txt
>> +++ b/Documentation/git-commit-graph.txt
>> @@ -54,6 +54,11 @@ or `--stdin-packs`.)
>>  With the `--append` option, include all commits that are present in the
>>  existing commit-graph file.
>>  +
>> +With the `--changed-paths` option, compute and write information about the
>> +paths changed between a commit and it's first parent. This operation can
> 
> "its first parent"
> 
> (Pardon the grammar nit from the peanut gallery!)
> 

:)
Thank you! Fixed in v3. 

Cheers! 
Garima Singh

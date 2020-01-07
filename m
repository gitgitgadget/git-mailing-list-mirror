Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71333C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403262087F
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLr5tYoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgAGOn5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:43:57 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:42183 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAGOn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 09:43:57 -0500
Received: by mail-qk1-f182.google.com with SMTP id z14so41553588qkg.9
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 06:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RIFF8imwkPDaasERWV0RT64WKhgXe9NXmco3nYNNZWQ=;
        b=PLr5tYoYPGOL+JYmK1wM+u6ocHSwxxByTZyk3nBu6Rmdrex4aXzhBNR7Zt4HWHInEx
         NSEG2n9y/UhT+rmuj+7qvcugXW5C1ig6lmrDlAnnZUYwp2pUFv7rQvOTSny8MCBDGckx
         IVKh/eqLekXCF8Nq+81m0ZkPDMx/3esDy3jvV5AvyvuJs5EnOtFPOjx1eL8fucWp2de1
         qrjAY3FToBHDLwZS7YKsLwPFn9zCi5wiuJGGfXEUnFPJ0i9rhLcgtWgXVe3iMRa6vh8w
         UsisYY8g8t5a+fKTBQaI+5C0/gR3Iz2ElDZA+0X8UYzxWo9wHZ8u/XWmun1ExAePUMj+
         eGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RIFF8imwkPDaasERWV0RT64WKhgXe9NXmco3nYNNZWQ=;
        b=VoywpyLft+Chee7X3mKJkmWsCrwhc7UoaUIk/RViUxf/pTuE8lNqwVAhl9QiHfHEBv
         G5VhLN5NtLh2iR+u3+8jNg/lxmUquOPt3SdKiHttIzOND2CIdqaixDD8YBjo483pUzpg
         USXnERv4xb0XkaAl2ZHV3hqSEEbhCxWiViFT4y/mg7Qz5CDQ0vczL8HCEIOcGqjepERy
         1MDV8FOI25qpOxEFnl/6qGQc0nszp7c3WGcVRbeM7LqcykqTuAFRNmOOBhKAz/tEWkOC
         8E+hqDUzOuYDJTRRlysPL382Wm6uXFD2xQw5qg/RFEf5zHKZm7MUkz5MHURqItfCAx4u
         PtYw==
X-Gm-Message-State: APjAAAVdEV+FG9c/sC3mkuqBxNygu4FPc3lbP3eIX2QcUtLhNfWHjvHZ
        RBIr9Q59z75iKkxyqSVi5FHsTIia
X-Google-Smtp-Source: APXvYqzR/Ez6wygRkUXs38tfLNtAu6i5bCjMt5Om/AS7R1UZ1uwHMKcL5vv9oXAFR0yPjx6YWV1kzg==
X-Received: by 2002:a37:9ec2:: with SMTP id h185mr86426393qke.14.1578408235975;
        Tue, 07 Jan 2020 06:43:55 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:4018:daf7:6551:6995? ([2001:4898:a800:1010:f14d:daf7:6551:6995])
        by smtp.gmail.com with ESMTPSA id j1sm22376195qkl.86.2020.01.07.06.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 06:43:55 -0800 (PST)
Subject: Re: Assertion in git log graphing [regression in v2.25]
From:   Derrick Stolee <stolee@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Bradley Smith <brad@brad-smith.co.uk>,
        Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>, git@vger.kernel.org
References: <CAHt=fUXTHc4JPsapvHKnw5vHhp2cBOYRNfdaSDWBUnKt8fWfeA@mail.gmail.com>
 <20200107114812.GE1073219@coredump.intra.peff.net>
 <5f956281-e861-f274-be43-95d99a625abb@gmail.com>
 <20200107140417.GA12242@coredump.intra.peff.net>
 <39277f9a-f88d-94a3-2a8b-b6e0a3dfdc62@gmail.com>
Message-ID: <ac6d3172-699e-5a61-fa60-420980c49fad@gmail.com>
Date:   Tue, 7 Jan 2020 09:43:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <39277f9a-f88d-94a3-2a8b-b6e0a3dfdc62@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/7/2020 9:22 AM, Derrick Stolee wrote:
> Note how 6_M4 has three parents, and the first parent has a horizontal
> edge. Even giving an extra padding line between horizontal edges, we
> _could_ output the following instead:
> 
> 
> | | | | | | *   6_M4
> | |_|_|_|_|/|\
> |/| | | | |/ /
> | | |_|_|/| /
> | |/| | | |/
> | | | |_|/|
> | | |/| | |
> | | * | | | 6_G

I should have tested this example with v2.24.1, which gives this output
in this section:

| | | | | | *-.   6_M4
| | | | | | |\ \  
| |_|_|_|_|/ / /  
|/| | | | | / /   
| | |_|_|_|/ /    
| |/| | | | /     
| | | |_|_|/      
| | |/| | |       
| | * | | | 6_G

So, this is likely the behavior we would prefer.

For the release, it is likely best to keep the change that does not
collapse properly and fix this collapse bug later. (It is likely an
invasive change.)

Thanks,
-Stolee

Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3292C83003
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 13:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E78521775
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 13:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdNN0AJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgD2NEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgD2NEo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 09:04:44 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C53BC03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 06:04:44 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id w6so2331808ilg.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 06:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qcwj/sx+XYP1jeevrFn6SpbZ+sL9dYkRLZh+ShMNB4M=;
        b=pdNN0AJXz1jALoeEXeRaAW4nOehuvWXMWcDi3Tb/6LCpO5Xn/U9w0i4UhzYS4WAq2U
         UvRNwndzWwA+qsfX/tYkJ6zjzv6jSHG+qo56Yw9FB6MmDRZTh6KkeYTN4YqLOmE+WKah
         hT9U/b50ih4vXviERythE7jjBnibit4lQi8FvheKIBfF1fNi/pr4Bw50Ysu/mtzUiS1c
         J9l2LrPa31yPf1xOnhDOnuc+WpWbgmFB7By57cmMPWuRnjCFiPtRZCsRw5tQmLzVpkg+
         jhhWdAiKNdOccihqF0rbcxS6+wAhk+zSWq7MrVa/nhC972GDrepYdFyHwIlD9SLs8zm1
         pKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qcwj/sx+XYP1jeevrFn6SpbZ+sL9dYkRLZh+ShMNB4M=;
        b=PUsqNHek6zL5/gwHfjlZ6WmMNLh5lLsrcTO/GyY/7hJgvzSWDYC9higPEGlSXHj0PB
         Kq/yjZodd/EG0q1/4pKSey1Naj82103KZcpfIzGvqoWIR+07nNwDPXu4+u2cYCoomQDx
         hPw3hDXbYAAp5MHjo3CdSXDjPQVPr5YqQp7gtQwg2deOvvgVWlyKdfTRd5XxS8Ow7eju
         RjpR+tKK/AP4H4AGU+0K/5NBxU0hnfhz3VCBVzyez63XiQeiyB6EUBSw1yzK3MEC0U1B
         43RBKtjHpDJWboTrjrEhp8TIn2It1sUPDj5SzbqjL2iPGtDg0U6UFy0nI1lny+IlKy3j
         29SQ==
X-Gm-Message-State: AGi0PuZV0Wv3ZxZRHqb8atTEn8NlUUnsayyd2nVyr3GvdneN2AdB6X32
        nAixo2BY62vaJDm+curXJZG6WwYBQxg=
X-Google-Smtp-Source: APiQypKoalZC9n8KaDgXzaUYcquTW6fa8VTD7/of8gXzrMTwgt0LGnLstF2yQoI0iRjriV9Un1wqBQ==
X-Received: by 2002:a92:4b11:: with SMTP id m17mr31732409ilg.42.1588165483348;
        Wed, 29 Apr 2020 06:04:43 -0700 (PDT)
Received: from ?IPv6:2601:8c0:37f:6012:b42c:57cd:fff4:b8c7? ([2601:8c0:37f:6012:b42c:57cd:fff4:b8c7])
        by smtp.gmail.com with ESMTPSA id x75sm936483ill.33.2020.04.29.06.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 06:04:42 -0700 (PDT)
Subject: Re: [PATCH v2] Teach git-rev-list --simplify-forks
To:     Philip Oakley <philipoakley@iee.email>,
        git-ml <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Derrick Stolee <dstolee@microsoft.com>
References: <df0b9e59-e6d7-8839-ca3b-86145dc3bdf3@gmail.com>
 <d3079ba8-33e1-3b68-23d2-ea97b9ca1e97@gmail.com>
 <eda71f1e-b883-82c3-72f2-dc5221804c4b@iee.email>
From:   Antonio Russo <antonio.e.russo@gmail.com>
Message-ID: <ceeb706d-83ad-c994-121d-d66724d82a49@gmail.com>
Date:   Wed, 29 Apr 2020 07:04:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <eda71f1e-b883-82c3-72f2-dc5221804c4b@iee.email>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/29/20 4:08 AM, Philip Oakley wrote:
>> +--simplify-forks::
>> +	Convert the commit graph into a spanning subgraph produced by a
>> +	depth-first-search of the history graph, searching the leftmost
>> +	parent first, and discarding edges to commits already visited.
>> +	Useful with `--graph` to visualize repositories with many merges
>> +	when you are interested in was added to master, and not when the
>> +	branch was last rebased.
> 
> Does this also need to actually mention that it effectively discard
> edges to fork points, as per the option name?. No rebasing required for
> it to be useful.
>      s/when/where/
>     "...and not where the branch was last rebased or forked from." - not
> great but actually mentions the option.
> 
> --
> Philip

Good point.  More generally, my description of the option is not very
useful unless you already basically understand what it's doing.

How about:

> --simplify-forks::
> 	Omits the parent relationship of the first commit of merged branches.
> 	Effectively discards all information about the fork point of merged
> 	branches.  It does so by converting the commit graph into a
> 	spanning subgraph produced by a depth-first-search of the history
> 	graph, searching the leftmost parent first, and discarding edges
> 	to commits already visited.  Useful with `--graph` to visualize
> 	repositories with many merges when you are most interested in
> 	when branches were merged.


Antonio

Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0722DC2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 15:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF21924685
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 15:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM/O1hmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgA1PDh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:03:37 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37677 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgA1PDg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 10:03:36 -0500
Received: by mail-qv1-f68.google.com with SMTP id m5so3251795qvv.4
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 07:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZfGUQhr12FPmOrVvRg6B6lKcVftaKUi21ZXdUrGbNXk=;
        b=WM/O1hmXcjY9VZH3qCWdZmBMVUv+gUEXtm1TnsMvFc6ptebRSp9UrMVxGTOz8LIqmG
         ++Xd0Jf4/TvUU8F7j2yLafiTXlwHwtp6q8b5T1vxYLxslHAi8U7nBTofOtzpBr3rUNzG
         Jr1w0Xx8qQ3+s1yu1YzXGvMfftyhlytwhrg96sZSPKMTpm13HhVTdKmPa8LpY6loNWAq
         yYVQFtHcokPsMtF3KichEBwfWaKVnhPSRj6lLN8zXm5P0FOqKX0gB0UlobnLlI+VaWms
         s9/u8A96mc2+FhAo5wUNkyx6D/M0A+OXi1rWw5HcHHwoOZlKrAT27YDOK/+aR2RIKKDd
         /kCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZfGUQhr12FPmOrVvRg6B6lKcVftaKUi21ZXdUrGbNXk=;
        b=ZILknrpiRWV0mepvqafWSVoxV5JC2HtaHO4Lf0emfAu8Y7oGLdGVSbfaPtJWnClPRz
         9H0YbrtDVmaGNue2ODpAWW2D00cxyAv0T4IWRcjN1Suxsj10PaR1UrOXZOYsTx+ObJTW
         yOKfT55cG5q/HmAslNjTh1/UK7Jw/e2pD0TRnVk5/fX1tIccEq0lCKRRhcqjit2QQeiB
         QSS7tqjQOMy6hvaDMPR87FWESOkHnXlzelboqUOgnE4/dT4vv8iWGU4AmZUwsfnapn0e
         A4lkGhib1NbaWjItEXOaybkKJW/yOB3K20/Rwl0N7zblzA1430h+BAzg9UVAvDfwaPcV
         F7YQ==
X-Gm-Message-State: APjAAAUl4sOX21OkyoMQND6l95Mm53JAiTuvZuSQd31K1qIqGvUv4tIL
        UHtx2X1UWTZMii3A8J6IQJY=
X-Google-Smtp-Source: APXvYqzs/34RSTOW7JigEDsVG8eK7siG3PO8Mx0kX+q1ZP52WlhxREUuCpDeaVhcxcjxI0rfxtIH3Q==
X-Received: by 2002:ad4:4a69:: with SMTP id cn9mr10812014qvb.218.1580223815369;
        Tue, 28 Jan 2020 07:03:35 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:e5a6:5783:dc66:4486? ([2001:4898:a800:1010:96dc:5783:dc66:4486])
        by smtp.gmail.com with ESMTPSA id b9sm12136930qkh.83.2020.01.28.07.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 07:03:34 -0800 (PST)
Subject: Re: [PATCH 8/8] sparse-checkout: write escaped patterns in cone mode
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
 <79b6e9a565fde766954d7cda84a835b9015af6cb.1579029963.git.gitgitgadget@gmail.com>
 <20200114212548.GD3949560@coredump.intra.peff.net>
 <e325daa4-5a26-3652-5f46-06203403e51d@gmail.com>
 <20200114224818.GD3957260@coredump.intra.peff.net>
 <d4fe0b4a-9e3f-6669-9068-d7b4b8934d1b@gmail.com>
 <20200124214206.GA2211026@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6864b79c-b22b-1d1e-1f86-1d07a470fdd3@gmail.com>
Date:   Tue, 28 Jan 2020 10:03:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <20200124214206.GA2211026@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/24/2020 4:42 PM, Jeff King wrote:
> And ultimately the flow would be something like:
> 
>   - read input
>     - if argument is from command-line, use it verbatim
>     - else if reading stdin with "-z", use it verbatim
>     - else if line starts with double-quote, unquote_c_style()
>     - else use line verbatim
>     - the result is a single pristine filename
>   - fill hashset with pristine filenames
>   - generate pattern list to write to sparse file, escaping filenames as
>     necessary according to sparse-pattern rules
> 
> Obviously you don't have a "-z" yet, but I think it's something we'd
> probably want in the long run. And anything coming from the command-line
> shouldn't need quoting to get it to us either (and so we'd need to
> escape before writing to the sparse file).

This recommendation came async with my v2, so I'll follow shortly with
a v3 that uses this flow. I have something that I think works, after
slightly adapting my tests, but now I need to make sure that all the
patches still make sense and build cleanly.

Thanks,
-Stolee


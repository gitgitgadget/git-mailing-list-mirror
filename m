Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570A7C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 13:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252532081E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 13:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlCJASiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgAGNdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:33:00 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:43546 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgAGNdA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 08:33:00 -0500
Received: by mail-pl1-f177.google.com with SMTP id p27so23206657pli.10
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 05:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JTtM3ZDXjBSJDOqUVCSzCBY+v3nxgSHm+TinqkXIVQQ=;
        b=IlCJASiR2HV0hrPuLy8tcNVY1mq6Uh7s7UtRGXZfcPpvLIrSWIIsiW30uV6goLPDfN
         y7eMq4A6H8lbTgSYttLqIuTzFZV5O52DW3tgvRzMYRGtrvBSJq1mbAcDoE8wC1VcYSdj
         5WaNSVFbWcL/b8YW+YP9WaBsdpRCbi2Pefz6aa3e8LQzxikgA7GvEyd0X4rPxNdyMkJZ
         rGySDVPwIVhUxC8Vuz9+JnsFsiLJHr6/FVIGe5UHL/lk4L/sgDRMrCxU5hTUszYX+6+L
         NApVgIdIrOLjVa7bf1+UqIcRkNLtM9cOWA2m2Ym6RyjmBHsOKkYWl2kTXwkdTwFXqFTV
         Mfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JTtM3ZDXjBSJDOqUVCSzCBY+v3nxgSHm+TinqkXIVQQ=;
        b=pKC9s/P3VWPYP+AyYO3G00JwDa4un6wsonVApciIShRmOtc0MsC8a3J3bjELBUZ9L/
         +Wz3hCMc3TAWn4/iVI4s+5vu+bu7TD8ASagYZme69ngkslDl8hgnmLkflbWlcfD8DnwT
         AQx3e7Kxi3f6xiR2deVSg8KUr+7nR1114zUrSuMYjjMn1o+q6oB/bnurMxNaaoms7gMu
         yrLXbsopmgbDKBK2v74SQjgx7ueamir1pmmyL5Iamy4KFX4aR8ViZcbjlHjBXJAvON8v
         6aifpnd5PVk4XloSPBgGrWkxqV1KzVrTtf6+JacfpFSJdOVNZdbMWj9Rny8am1jAHTZG
         SXOw==
X-Gm-Message-State: APjAAAXeb1aQxWYnSx3rANYIEI+ayrX2jpAX62OsqDsiDlDwVl4ZWZCo
        zBcR9RqFSbiCT7VztaI2KyIN0jMR
X-Google-Smtp-Source: APXvYqzknLtptDEELoYqN28ZbgHfPqZEzSQ43UYD6Kl79jcWuJAKBXkn6xF9/cDtBbqYzRSnbjbJwg==
X-Received: by 2002:ad4:59c2:: with SMTP id el2mr80174585qvb.152.1578403561366;
        Tue, 07 Jan 2020 05:26:01 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:4018:daf7:6551:6995? ([2001:4898:a800:1012:f14b:daf7:6551:6995])
        by smtp.gmail.com with ESMTPSA id s33sm25561543qtb.52.2020.01.07.05.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 05:26:00 -0800 (PST)
Subject: Re: Assertion in git log graphing [regression in v2.25]
To:     Jeff King <peff@peff.net>, Bradley Smith <brad@brad-smith.co.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>, git@vger.kernel.org
References: <CAHt=fUXTHc4JPsapvHKnw5vHhp2cBOYRNfdaSDWBUnKt8fWfeA@mail.gmail.com>
 <20200107114812.GE1073219@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5f956281-e861-f274-be43-95d99a625abb@gmail.com>
Date:   Tue, 7 Jan 2020 08:25:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20200107114812.GE1073219@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/7/2020 6:48 AM, Jeff King wrote:
> The assertion itself is quite old, so I wondered if it was even still
> relevant. Removing it does produce a reasonable-looking graph:

As I'm digging into this case, and finding when the assertion is hit,
I see that the issue is in the line further below your coloring issue:

>   | | | | * dd068b4 Merge commit '8f076d8' into HEAD
>   | |_|_|/| 
>   |/| | |/  
>   | | |/|   
>   | |/| |   
>   | * | | 8f076d8 5

What is output is actually this, above. But the logic that includes the
assert is checking where the underscores end, and the shown underscores
actually pass the check. The issue is that it seems like it really wants
to show this:

>   | | | | * dd068b4 Merge commit '8f076d8' into HEAD
>   | |_|_|/| 
>   |/| |_|/  
>   | |/| |   
>   | * | | 8f076d8 5

Note that I dropped a line and compressed a slash into an underscore. It's
on that line that this condition is being hit.

Now, is this really the intended behavior? Maybe. Looking at the previous
tests in 54125-log-skewed-merges.sh, I don't see any where we have two
skewed merges in the same merge.

Thanks,
-Stolee

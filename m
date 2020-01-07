Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D8AC33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58252208C4
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiPoIXZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgAGO5j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:57:39 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41623 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbgAGO5j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 09:57:39 -0500
Received: by mail-qt1-f195.google.com with SMTP id k40so45482438qtk.8
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 06:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WuG/vvJPm5DSHQ2Lk3Vd+dj467LC0+Ab8IOmrfTqm30=;
        b=AiPoIXZMY3N/hLQ6oJ2ruRehvrpXJuVE/4wZp3avGYdjSQRCT83CcYI4fn91YPGV++
         5Q5eReBcA4MmE+Il7NvRauHNdJ8YC+A+TrMz/NWpE86vXH/RcBCt7IT8JiZJGoXm6O/d
         8rXcKuYRilc9O8/YGeISPC7bMly4giqorObmRFIxHj8uxYYgMGOmHOOY6Bqw2xWFHoow
         Il+0IjKdqkIkwRZt43BO0cEm9kBdylxf02fWwz5Tg4I3lw6xT5lUhHBrzOtYAmC3c7Ua
         JbdEhk5PbXA3KcmR4YVXzg/lb+zpFE6jvm04EGuYgWskYn/2bNDrTzmRdnXYzEy7wSSw
         yrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WuG/vvJPm5DSHQ2Lk3Vd+dj467LC0+Ab8IOmrfTqm30=;
        b=YHS7sJ8hSXVl2Y3XL/XeH4G7Z2mvKI1j2GYDU3Tj0dyLn2xqZpDPqqh2p18fNYLV+u
         cRI9vCNbou7y2cKO5iCJCpxyCDSTEftdJhwlIUWop+yrrWl7OaCt9SUZlwwq9mH0+Ofj
         NOZWo38NfhaHF1KBxHQEuxvIxIRXBUl2JAEXV31fSwMvfsvCVgVUFzHCQmO+ALmtWVYC
         Wrt+3OrQuhNmWfoHvGxY8FUIDBmbFeJVAEtiED5RLrVx8XddCLGL09T8nqVP7mF+Wgel
         ErgajWbEFI5Z0PylQhcDbv4bXyJncqnbZDZ2FW1vXDmqgy8Hg71/P3Jj7fN3y0lKTfeI
         CN4w==
X-Gm-Message-State: APjAAAXuJSI/w+nlbGsyyyoGX5L1/vazvdUKAY8D26tyGZnV5yxMdLtf
        Vzqp/zW3hXg7X/Aw+FjLLPI=
X-Google-Smtp-Source: APXvYqy5hStD7l+WeKaRYJieucOfi/ptIh1Pi8Juc5y6PITWvIvcE8P00sQj9Kr+6oEtDOePm0t+CQ==
X-Received: by 2002:ac8:742:: with SMTP id k2mr53996919qth.302.1578409058030;
        Tue, 07 Jan 2020 06:57:38 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:4018:daf7:6551:6995? ([2001:4898:a800:1012:f14b:daf7:6551:6995])
        by smtp.gmail.com with ESMTPSA id f42sm25580909qta.0.2020.01.07.06.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 06:57:37 -0800 (PST)
Subject: Re: Assertion in git log graphing
To:     Bradley Smith <brad@brad-smith.co.uk>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <CAHt=fUXTHc4JPsapvHKnw5vHhp2cBOYRNfdaSDWBUnKt8fWfeA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <faa954fa-ccb9-b034-a39d-d2f0696826ea@gmail.com>
Date:   Tue, 7 Jan 2020 09:57:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <CAHt=fUXTHc4JPsapvHKnw5vHhp2cBOYRNfdaSDWBUnKt8fWfeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/7/2020 6:24 AM, Bradley Smith wrote:
> Hi,
> 
> The following git repository (https://github.com/brads55/git-testcase)
> causes an assertion when running:
> 
>   $ git log --oneline --graph --all
> 
>   git-log: graph.c:1228: graph_output_collapsing_line: Assertion
> `graph->mapping[i - 3] == target' failed.

Bradley,

Thanks for the report. I've submitted [1] what I hope to be a
sufficient fix.

Thanks,
-Stolee

[1] https://lore.kernel.org/git/pull.517.git.1578408947.gitgitgadget@gmail.com/

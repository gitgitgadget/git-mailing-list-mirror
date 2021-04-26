Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B32C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 15:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BD0B60E08
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 15:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbhDZPM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 11:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbhDZPM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 11:12:57 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A70AC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 08:12:16 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id r186so28954327oif.8
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 08:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vn5SL9E2otB8lbg9WUap4CuA3uN/2U8jU3B/BLn00jg=;
        b=A1u8vbSlZk3Xz0yvnPBc61RMwXBNJZSlntiAa22hra1MKwq/V92UI+QJfGetN6c5VR
         OJjCs+xSW219P+igwqNG5amqacAbuDQSskEbY0xVh27XcKdOORcKVrvctXgkGIyKU+c2
         0SM+QdzoxZ74m8N0O+IiFvpn4CQcwIFPVmQtawh1LZidNpTz4O7eD17wsbnkJQwHBHqt
         q9jhIGUzjlZzyNJmHaaX+36viupmF8mD1bWHWt6Cd+HESVVFgMWsXhfGjIhvTLMoGEBT
         BdN1O3aj0opEopBqifGW90kWnby77DFq+1QMnrwnFlMn7YY9OIGYkIRF8GsiwH9VqL1F
         40dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vn5SL9E2otB8lbg9WUap4CuA3uN/2U8jU3B/BLn00jg=;
        b=o7hnHTztxyQBqxMn0z//uE/X+HWDQOprfCJRLKVSQDPT6B4U3c7nGX5ABjkOprCk1K
         PsXmvTsS50l6jjR4o5hrH8kTWFVmAQfuhLYW8/VpZP3aiX35RjIUdIzilb4rogkQhfkl
         RWgEWwIZKiIkZuiwERSV0yHIWFCcTNzwPj/DQgm/GAV3838fTBC+DQSmv+mZZMdXkrTI
         yx/S+iANfUUhKsfP5arr8/1CyYUXH0wd41rC9lsXnPCvPi3sKGu8TgE1ZpZcN4KCnrng
         21U7zujg07kgzaLEz0yCTPS8APd9QA41DDz5iZt7lUeUExogK4GUr0alFmAIw3fZ0X7T
         GfmA==
X-Gm-Message-State: AOAM530LVUyWJ/j9v4ipbA63OUfQ+8AXD7VrS/+ar2011YnkFJD/1gt5
        /Ujk/STUKY2ktK4tfBOrGLE=
X-Google-Smtp-Source: ABdhPJzeS0AicMd7TQGRcodJkFqq76PdgPDz8S73gQb0KR7Db2tNpC+iFO0q9G2dlheuvoou5ppL0w==
X-Received: by 2002:aca:6286:: with SMTP id w128mr12812019oib.119.1619449935615;
        Mon, 26 Apr 2021 08:12:15 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:bc73:cea4:3f85:d407])
        by smtp.gmail.com with ESMTPSA id c9sm28400ooq.31.2021.04.26.08.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 08:12:15 -0700 (PDT)
Subject: Re: [PATCH 06/23] fsmonitor--daemon: implement client command options
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <77170e521f67ce92587d833334f6951a9f375d4d.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <098e4123-676e-2ea0-4c16-dbeaa1198b46@gmail.com>
Date:   Mon, 26 Apr 2021 11:12:13 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <77170e521f67ce92587d833334f6951a9f375d4d.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/21 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Implement command options `--stop`, `--is-running`, `--query`,
> `--query-index`, and `--flush` to control and query the status of a
> `fsmonitor--daemon` server process (and implicitly start a server
> process if necessary).
> 
> Later commits will implement the actual server and monitor
> the file system.

As mentioned before, I think the "query", "query-index", and
"flush" commands are better served in a test helper. Luckily,
the implementation you give here seems rather straightforward
and could fit into a test helper without a lot of duplicated
boilerplate. That's a good sign for the API presented here.

As a bonus, you could delay the implementation of those test
helpers until they are going to be used in a test.

Thanks,
-Stolee

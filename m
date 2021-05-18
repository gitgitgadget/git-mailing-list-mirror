Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9424C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 14:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784B661185
	for <git@archiver.kernel.org>; Tue, 18 May 2021 14:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349744AbhEROFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 10:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243387AbhEROFb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 10:05:31 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55976C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 07:04:13 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so8706695otc.6
        for <git@vger.kernel.org>; Tue, 18 May 2021 07:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UcSV8mMpZ4IS5chJdq6+5bNaCLvN/0hVG4fwXWihQO0=;
        b=UD+YQzVX3dhkflYyA6X69ZclkJPpJDQWpUQ0KwGbNZO5YJ+heFbtH1o0xrF4FvOr2l
         X0inPTzVIbGH1X20e4REfvBorOrUGjFKTs0GPCF9AjRCHfcRbzjC22LL44a5UuCn+9xo
         KbN3GPlQm8jWyKb8qgGciaze+OSXDgcAEOw3o27YZAP7rj/EC5yXUvwIBPcqsyE+jonR
         Rzi6d8Mzo+b/prsml6S2YW8CV6pbmjUmy4VjaTkypMSZSNERUV+egaAU1lcp0ZWJLncl
         JRYvnnP8k/CxKQ9dgF7HbJldarPu4yDVfyY1Yqd59l2OVc427f4cPDpuDHQCfHt/fr4M
         05rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UcSV8mMpZ4IS5chJdq6+5bNaCLvN/0hVG4fwXWihQO0=;
        b=kvCfG+2dGu4nB5046SXBm6rxSP6FVgJ4UvUU4MVlUQDljCYRRQVpTNjiYj3b/fPdN6
         COGrVYztkqfbLr9kE/w9rl+Nztbqo8NYijhnGIfauKcefKl891eR41mNFRNexgeuPQPH
         uhu2ERqW2d2DoA6iGDRi2A0Zw0B0T/6qnUt+wiuwWerVx5Lze7mtgBJNh3Q1OzUBdF9l
         V/nem9vOCwFK6M6jcTJPCz9Mk6osDbE92HE6s184w8omMOVvyHj/R/ZR7PdxVEuGC+wd
         5ng0Lwr3rvOqvm4czx0hspwGv6lj8Tz2Mdzmmd+ZFN9lCeuKHjIqzb/82tkqpk24fXrK
         qc5Q==
X-Gm-Message-State: AOAM532U14foTisNyVSTN3pAawAyk7s0vtDPLENRFNuvNy6ldMroo1FE
        uwcSh/9GT0VP1UvIenr+OsE=
X-Google-Smtp-Source: ABdhPJyjDeXPRxTv3fy5JhRC3sGqZYa/0TvjqJfhnA3f3/tQQoVwpwX53ZyMQxGurN0o1E9sSkwLzQ==
X-Received: by 2002:a05:6830:1db6:: with SMTP id z22mr4481511oti.312.1621346652624;
        Tue, 18 May 2021 07:04:12 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:bcf4:c194:74a1:9906? ([2600:1700:e72:80a0:bcf4:c194:74a1:9906])
        by smtp.gmail.com with ESMTPSA id v28sm3842944ood.27.2021.05.18.07.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 07:04:12 -0700 (PDT)
Subject: Re: "bad revision" fetch error when fetching missing objects from
 partial clones
To:     Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
        Git Users <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <6422f505-29c4-bee9-e28c-b77dd831c246@gmail.com>
 <ba5a0574-c71c-709c-a13c-bf6d5981545c@jeffhostetler.com>
 <YJz4JTsFjTtL7mE2@coredump.intra.peff.net>
 <YJ0FL3zr/SnWN7t6@coredump.intra.peff.net>
 <YJ4mUJ+EEAnudI3G@coredump.intra.peff.net>
 <32e5852f-f94b-e169-de1c-8cc9a534c93c@gmail.com>
 <YKN2vT+zi/N6jUAN@coredump.intra.peff.net>
 <1bedacfb-2b03-85e6-71d6-0f64fab68bbc@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d22edf0d-1d37-ed4a-6b61-0ee56b359aa5@gmail.com>
Date:   Tue, 18 May 2021 10:04:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1bedacfb-2b03-85e6-71d6-0f64fab68bbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/18/2021 6:14 AM, Bagas Sanjaya wrote:
> On 18/05/21 15.11, Jeff King wrote:
>> In practice I think it's an unlikely failure mode for a server you
>> partial-cloned from to turn off filters, so it's probably not that
>> important. I hit it because a test script used test_config to enable
>> them, and then the follow-on test I added to run git-fetch got quite
>> confused. A more likely scenario is that you might see it a
>> misconfigured load-balanced pool of servers.
>>
>> I do wonder how hitting a third-party server should work, though. E.g.,
>> I partial clone from A, and then ask B to fetch some related history
>> built on top. Do I tell B that I'm a partial clone and might be missing
>> some objects? Or do I behave as normal, and expect to fault in objects
>> that it assumes I have (e.g., a delta base)? And if the latter, does
>> that work (if it does, then why doesn't the same logic kick in for this
>> fetch?).
>>
> 
> My server is running Gitea (compiled from main branch [1]). The server
> itself runs Git 2.31.1. I can also reproduce the issue using Jeff's
> test case [2] without Gitea. So this is not Gitea's issue, this is Git's
> issue.
> 
> Even my server setup is just application server + separate database
> server and not load-balanced pool ones.

I think the "third party" thing is mostly about if we have forks
hosted in different places. Imagine that git/git is hosted on
GitHub with partial clone enabled, but git-for-windows/git was
hosted on Azure Repos, which doesn't have partial clone.

What happens when we partial clone git/git from GitHub, but then
add git-for-windows/git as a remote and fetch from it?

This is a separate discussion. I think it really points out the
issues that arise because partial clone makes the remote a more
critical resource. This removes some decentralization from Git,
as requested by the user. These concerns about the remote changing
the availability of filters or about other remotes hosted
elsewhere are unlikely to come up in a centralized workflow (i.e.
a set of users working against a common remote without forks).

Thanks,
-Stolee

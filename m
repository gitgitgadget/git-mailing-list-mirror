Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF1BC433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 10:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E6B60BD3
	for <git@archiver.kernel.org>; Tue, 18 May 2021 10:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348427AbhERKPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 06:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348417AbhERKPq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 06:15:46 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD53C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 03:14:28 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id j12so6670427pgh.7
        for <git@vger.kernel.org>; Tue, 18 May 2021 03:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0yB1SGGEoYswiY+1/TKSWVyZOF1CQ5gqmMR54I+1aEM=;
        b=OiQwiGrq6+ouaMTwR0Ztu2Q30JG/UPc0Qk4NESa8IM8oCbOiZjmpdFgocJuuRl2QnS
         GUh7oe+W1gAPWUWzJqpxwxYapTpcuCn2ukwHGZrVaoaheJI4uSC+J0cJrdoJsEA/59zW
         9vMPDQKFr03D7ZEDhnIj11ekAp1CFCuGayKItNsoTlYUhbD9IM/ciQ1XcNcUZMhHg847
         58lwxBenrTT9Kc+KqrDn024z5FlXeKT87NskKkM815FAeFH7KlCVNrtmoSi8vHOwlh6d
         yH8sCemO7itw+H/e2w4FTvpqRTOVc6ztBCphyMDlBDFltZyjusv5tlIFiHLJcntzsf8J
         nFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0yB1SGGEoYswiY+1/TKSWVyZOF1CQ5gqmMR54I+1aEM=;
        b=ramfZiQQkdidpzWbZZyxASwkfPEl1O33x4wt3wxpGx7MXYnP3n8F/OU8HebKeev4ec
         V/Hncsj7hYWUtnlCbf5Y1ee14PqTNmb3WWNbudimR0w4/6bs5hOBJVJJ4w/yRmLUeRO4
         oAs9R65P2sE5O9QRaI/QPrC7E+jFvip9BOLdFfg3t2eUDxX6ocbQmrHCv2hbSs4a16Sm
         MrwKXFPzbhZK5AP6Wyu1kyE0ci8SPhLhs8KCKz5sVHFN/R3oNevOPL01bvt2gW9LTkrN
         yy17v5K3HkROntjWBoGaUl+b8Rk7XKckM7vQlNIpQYpdhmzYmEZOJ1qQBdgmleGuYOsT
         s9ug==
X-Gm-Message-State: AOAM532q6s25qvvLpWQdxwqqEzgPCVMMAe7v567wiYKNDr3JcPFajw7G
        yNnD+Uw+KqaXx7YEQOdQiXk=
X-Google-Smtp-Source: ABdhPJxGiSPLkDJXewZ6bvFb6wbrL4mVFWIF4I6+0Einupqt+F1XLoYkzWvu1sddquIXkxzPt0eCLQ==
X-Received: by 2002:a63:175e:: with SMTP id 30mr4355972pgx.48.1621332868104;
        Tue, 18 May 2021 03:14:28 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-20.three.co.id. [116.206.28.20])
        by smtp.gmail.com with ESMTPSA id u6sm3558862pfk.177.2021.05.18.03.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 03:14:27 -0700 (PDT)
Subject: Re: "bad revision" fetch error when fetching missing objects from
 partial clones
To:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>
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
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <1bedacfb-2b03-85e6-71d6-0f64fab68bbc@gmail.com>
Date:   Tue, 18 May 2021 17:14:23 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKN2vT+zi/N6jUAN@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/05/21 15.11, Jeff King wrote:
> In practice I think it's an unlikely failure mode for a server you
> partial-cloned from to turn off filters, so it's probably not that
> important. I hit it because a test script used test_config to enable
> them, and then the follow-on test I added to run git-fetch got quite
> confused. A more likely scenario is that you might see it a
> misconfigured load-balanced pool of servers.
> 
> I do wonder how hitting a third-party server should work, though. E.g.,
> I partial clone from A, and then ask B to fetch some related history
> built on top. Do I tell B that I'm a partial clone and might be missing
> some objects? Or do I behave as normal, and expect to fault in objects
> that it assumes I have (e.g., a delta base)? And if the latter, does
> that work (if it does, then why doesn't the same logic kick in for this
> fetch?).
> 

My server is running Gitea (compiled from main branch [1]). The server
itself runs Git 2.31.1. I can also reproduce the issue using Jeff's
test case [2] without Gitea. So this is not Gitea's issue, this is Git's
issue.

Even my server setup is just application server + separate database
server and not load-balanced pool ones.

[1]: https://github.com/go-gitea/gitea/tree/main
[2]: https://lore.kernel.org/git/YJz4JTsFjTtL7mE2@coredump.intra.peff.net/

-- 
An old man doll... just what I always wanted! - Clara

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE821C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 21:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C7164ECC
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 21:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBAVDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 16:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBAVDP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 16:03:15 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC3BC061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 13:02:34 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id k25so20377251oik.13
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 13:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kEH+gTFpPEywdzV85CkZJ73gErznn79o63ZFbLRXlNk=;
        b=HUvJk758w283NDUhf3r4yW1CejJ2ZP3GTiz6PsYQzfd7KlIa8+4ZE6u5ybiMOAhTW5
         an3RGgzjb7sW4PQxWk7diq7GmmphBi+xhzMUR01T1SJxZ3b4t/wqnPIzPmL2CLnBAjPN
         m4fNGVOfPLf0k/UcLWEPKzW0EG43wkt7EAaA0HdJ9Hia8N986o40vhFSbLWWyqsjwQWh
         CEthY5LGv85oFUMbim8W2Sp9rDKPI/+F36gfeONA2fJy9VrgezUHBEIPn+Y4Ms60wuQR
         xkY2Lb7zTbgAesX0ekHdvDswuIunIAqgbcA86dOuFgiekD8MYxcZ4O6MTr2RfWnoc6M1
         QGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kEH+gTFpPEywdzV85CkZJ73gErznn79o63ZFbLRXlNk=;
        b=shpPKyEWNxrdAxDswB+J/f34D/mJ1Jn7hhdQ0DVnF86/cFAig9RP9P5q0S36lS8L1E
         xSJ/djd8j7yA9cSSTShYIQazLIOrhAieZe1qX+HyO3whLpUyydTn5HEqh8jcrE9dhJA/
         nZVdF1mED+LckLHkS1AGp4LX66TmSiu6IKu7JMoW37hW7E6ahzf/SJIF0RVR6xGNmhB2
         I/B9vu3LbD3rInG5vOYaXh6nwdaePL0BxbTQYu/0Q2Czl1bGZ6J/cFNZCbAtwCfB07nz
         wIWHOYQV6rV/0bgt68Ldury6GqmH/g1OwyKtinhQLm/zgKqFWwqrrltqpwDVaGccnQGy
         f6IA==
X-Gm-Message-State: AOAM530wAMxi5UbfvcuJfytzCOKxrv5+pO8tvOcCxxSO0ztXQyU+SS0r
        GC8a/zP2xjOKjod6ml6v3MU=
X-Google-Smtp-Source: ABdhPJwOV6DlfcWaSe0weOE8xwlHUe8ElA4a7YN4gU5QCWK0AxNI33sSvwEQceSxiT6HUUuPULGQ+Q==
X-Received: by 2002:a05:6808:2c2:: with SMTP id a2mr535584oid.164.1612213354143;
        Mon, 01 Feb 2021 13:02:34 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:8497:2090:4038:7fd1? ([2600:1700:e72:80a0:8497:2090:4038:7fd1])
        by smtp.gmail.com with UTF8SMTPSA id c2sm4341192ooo.17.2021.02.01.13.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 13:02:33 -0800 (PST)
Message-ID: <bd00470c-59d6-52a8-9b2c-dc9e3a0beb82@gmail.com>
Date:   Mon, 1 Feb 2021 16:02:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 4/5] commit-reach: use heuristic in remove_redundant()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        me@ttaylorr.com, peff@peff.net,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
 <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
 <83feabeebb5f035059758fba1ca5cf74f3a22c91.1612183647.git.gitgitgadget@gmail.com>
 <xmqqczxjlfj1.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqczxjlfj1.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/1/2021 3:05 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> The important piece is to ensure we short-circuit the walk when we find
>> that there is a single non-redundant commit. This happens frequently
>> when looking for merge-bases or comparing several tags with 'git
>> merge-base --independent'. Use a new count 'count_still_independent' and
>> if that hits 1 we can stop walking.
> 
> That is because when you are left one single thing, it may be able
> to reach many other things, but the fact that it by itself won't be
> reachable by remaining independent things will not change (because,
> that sole remaining independent thing is itself)?

Right. If there is only one non-STALE input commit left, then it will
be the only returned result. We will never find that all commits are
redundant because the commit graph is acyclic. The performance
improvement comes from halting the DFS walk: there might be more
commits to walk but they won't change the result.

>> To update 'count_still_independent' properly, we add use of the RESULT
>> flag on the input commits. Then we can detect when we reach one of these
>> commits and decrease the count. We need to remove the RESULT flag at
>> that moment because we might re-visit that commit when popping the
>> stack.
>>
>> We use the STALE flag to mark parents that have been added to the new
>> walk_start list, but we need to clear that flag before we start walking
>> so those flags don't halt our depth-first-search walk.
>>
>> On my copy of the Linux kernel repository, the performance of 'git
>> merge-base --independent <all-tags>' goes from 1.1 seconds to 0.11
>> seconds.
> 
> These two numbers are with commit-graph fully populated with usable
> generation numbers, I presume, and it is quite impressive.
 
Yes, these numbers are with a full commit-graph.

Thanks,
-Stolee

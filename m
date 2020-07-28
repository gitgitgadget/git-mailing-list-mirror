Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7BFC433E4
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 15:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751782074F
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 15:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbxmWOfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbgG1P6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731149AbgG1P6b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 11:58:31 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D6FC061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 08:58:30 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id 6so15220005qtt.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MAlGzUPNOV7nX9kmWjYgVLUbnZj3grx1nppKV8+VpWg=;
        b=HbxmWOfp8FVfnGwa4tfIE9azM+OKl6+BooI3qb5zcrZ08auAHR5BtMP0usm3NFoxw8
         oKefAUpAk8T+g15t6JUs9D777lyynObcUPUY1awWMIKupVBYeUtehzXhuFZEF7ym52CV
         GqtSME9kcsTb89ofvNCK1BEVJcdEVk2J5YZIeF2V/0YHk5+FujjY0DciSqnNlrowambi
         LdzeR2R+2TBKT7+t9T8v6DzRHR/pJ6n+bx7mRT/DNgnQlE0IErMq4QcruoKvYAzgUejh
         2py1svwtQT2fEPxdydzynA+PM6NJYO4p61sQVG0ELQzNYqobqcZivLqBfNIY6PKjunYc
         PStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MAlGzUPNOV7nX9kmWjYgVLUbnZj3grx1nppKV8+VpWg=;
        b=OK9h2VNDuQRNgTCAX8HcvJuI49H14/1cmEJm8M2l5jkl6KKGLupZ4uwMdGiF/DOIRn
         XokGe6v33ua1Gcr1nsOwV3x1DuMsivD1YUce9gG3eLJzPsP3fU2AcSVfLRknO5RDktww
         gvEhKBBUEqzPS9VJYc4aLHO9hALdARab4xhViftqBqjwucg6jp1KrzCQUt/HRe1jtUoB
         kiqygBm3VegO6C0UjhbZl271Mgsr52vPd2w2lP/jxeCelP2YvhsPGmyYUrEgD3jG3HMe
         aOj+sXuP1iSvMapsA14mlnBJhHl9ZgZkEGX18JeVEeqUR4IgGTpEAzbnz9E7ed1yHOJI
         1iAw==
X-Gm-Message-State: AOAM532dm2A66J7goH/SG2Y12QL7HgzSVEBFG9gnKncasX8Yv9L5ThVA
        7oDO/60b3CHT9CAerDVufe4=
X-Google-Smtp-Source: ABdhPJwBLmu3i1Vykyg1r4uP529PFNVeRKPGAQ00oMJHGOjvJTYbFOZgD4UHynyiE1UYObwsNBKMHw==
X-Received: by 2002:ac8:6f62:: with SMTP id u2mr27541558qtv.155.1595951909906;
        Tue, 28 Jul 2020 08:58:29 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:4854:557c:a990:d78e? ([2600:1700:e72:80a0:4854:557c:a990:d78e])
        by smtp.gmail.com with ESMTPSA id v184sm24444765qki.12.2020.07.28.08.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 08:58:29 -0700 (PDT)
Subject: Re: [PATCH 3/6] commit-graph: consolidate fill_commit_graph_info
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <701f5912369c0fcc07cf604c3129cb5017a125ce.1595927632.git.gitgitgadget@gmail.com>
 <a9d50995-566d-cad2-ff67-8b8604b52eed@gmail.com>
 <d4a613c1-f3e8-3789-2548-8344c4b976e9@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <542e98f1-f793-5290-02ae-3e4706765b80@gmail.com>
Date:   Tue, 28 Jul 2020 11:58:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <d4a613c1-f3e8-3789-2548-8344c4b976e9@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/28/2020 11:19 AM, René Scharfe wrote:
> [Had to remove stolee@gmail.com because with it my mail provider
>  rejected this email with the following error message:
> 
>    Requested action not taken: mailbox unavailable
>    invalid DNS MX or A/AAAA resource record.]
> 
> Am 28.07.20 um 15:14 schrieb Derrick Stolee:
>> On 7/28/2020 5:13 AM, Abhishek Kumar via GitGitGadget wrote:
>>> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>>>
>>> Both fill_commit_graph_info() and fill_commit_in_graph() parse
>>> information present in commit data chunk. Let's simplify the
>>> implementation by calling fill_commit_graph_info() within
>>> fill_commit_in_graph().
>>>
>>> The test 'generate tar with future mtime' creates a commit with commit
>>> time of (2 ^ 36 + 1) seconds since EPOCH. The commit time overflows into
>>> generation number and has undefined behavior. The test used to pass as
>>> fill_commit_in_graph() did not read commit time from commit graph,
>>> reading commit date from odb instead.
>>
>> I was first confused as to why fill_commit_graph_info() did not
>> load the timestamp, but the reason is that it is only used by
>> two methods:
>>
>> 1. fill_commit_in_graph(): this actually leaves the commit in a
>>    "parsed" state, so the date must be correct. Thus, it parses
>>    the date out of the commit-graph.
>>
>> 2. load_commit_graph_info(): this only helps to guarantee we
>>    know the graph_pos and generation number values.
>>
>> Perhaps add this extra context: you will _need_ the commit date
>> from the commit-graph in order to populate the generation number
>> v2 in fill_commit_graph_info().
>>
>>> Let's fix that by setting commit time of (2 ^ 34 - 1) seconds.
>>
>> The timestamp limit placed in the commit-graph is more restrictive
>> than 64-bit timestamps, but as your test points out, the maximum
>> timestamp allowed takes place in the year 2514. That is far enough
>> away for all real data.
> 
> We all may feel like the end of the world is imminent, but do we really
> need to set such an arbitrary limit?  OK, that limit was already set two
> years ago, and I'm really late.  But still: It's sad to see anything
> else than signed 64-bit timestamps to be used in fresh code (after Y2K).
> The extra four bytes would fatten up the structures less than the
> transition from SHA-1 to SHA-256 will, and no bit twiddling would be
> required.  *sigh*

One thing to consider after generation number v2 is out long enough
is if we could drop the topo-levels and write zeroes for the topo-
level portion. This was valid data in the first version of the
commit-graph, so it would still be valid. Then, we could allow
full 64-bit timestamps again.

This is something to think about again in a year, maybe.

Thanks,
-Stolee

